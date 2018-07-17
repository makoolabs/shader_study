Shader "Unlit/Outline and ScreenSpace texture"
{
	Properties
	{
		[Header(Outline)]
		_OutlineVal("Outline value",Range(0.,2.)) = 1.
		_OutlineCol("Outline color",Color) = (1.,1.,1.,1.)
		[Header(Texture)]
		_MainTex ("Texture", 2D) = "white" {}
		_Zoom("Zoom",Range(0.5,20)) = 1
		_SpeedX("Speed along X",Range(-1,1)) = 0
		_SpeedY("Speed along Y",Range(-1,1)) = 0
	}
	SubShader
	{
		Tags {"Queue" = "Geometry" "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Cull Front
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"
			struct v2f
			{
				float4 pos : SV_POSITION;
			};
			float _OutlineVal;
			
			v2f vert (appdata_base v)
			{
				v2f o;
				//v.vertex.xyz += v.normal * _OutlineVal;
				//Convert to vertex to clip space
				o.pos = UnityObjectToClipPos(v.vertex);
				//Convert normal to view space(camera space)
				float3 normal = mul((float3x3)UNITY_MATRIX_IT_MV,v.normal);
				//Compute normal value in clip space
				normal.x *= UNITY_MATRIX_P[0][0];
				normal.y *= UNITY_MATRIX_P[1][1];
				//Scale the model depending the previous computed normal and outline value
				//o.pos.xy += _OutlineVal * normal.xy;
				o.pos.x += _OutlineVal * normal.x;
				o.pos.y += _OutlineVal * normal.y;
				return o;
			}
			fixed4 _OutlineCol;
			fixed4 frag (v2f i) : SV_Target
			{
				return _OutlineCol;
			}
			ENDCG
		}
		Pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			float4 vert(appdata_base v):SV_POSITION{
				return UnityObjectToClipPos(v.vertex);
			}
			sampler2D _MainTex;
			float _Zoom;
			float _SpeedX;
			float _SpeedY;
			fixed4 frag(float4 i:VPOS):SV_TARGET{
				return tex2D(_MainTex,((i.xy/_ScreenParams.xy)+float2(_Time.y*_SpeedX,_Time.y*_SpeedY))/_Zoom);
			}
			ENDCG
		}
	}
}
