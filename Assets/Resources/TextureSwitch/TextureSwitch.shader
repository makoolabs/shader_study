Shader "Unlit/TextureSwitch"
{
	Properties
	{
		_PlayerPos("Player position",vector) = (0.0,0.0,0.0,0.0)
		_Dist("Distance",float)= 5.0
		_MainTex ("Texture", 2D) = "white" {}//第一张贴图
		_SecondayTex("Secondary texture",2D) = "white"{}//第二张贴图
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 pos:SV_POSITION;
				float2 uv : TEXCOORD0;
				float4 worldPos:TEXCOORD1;
			};
			float4 _PlayerPos;
			sampler2D _MainTex;
			sampler2D _SecondayTex;
			float _Dist;
			
			v2f vert (appdata_base v)
			{
				v2f o;
				o.worldPos = mul(unity_ObjectToWorld,v.vertex);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				if(distance(_PlayerPos.xyz,i.worldPos.xyz)>_Dist){
					return tex2D(_MainTex,i.uv);
				}else{
					return tex2D(_SecondayTex,i.uv);
				}
			}
			ENDCG
		}
	}
}
