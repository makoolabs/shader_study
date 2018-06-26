Shader "Unlit/UV rotation"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		Blend SrcAlpha OneMinusSrcAlpha 
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
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			};
			sampler2D _MainTex;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				//Pivot
				float2 pivot = float2(0.5,0.5);
				//Rotation Matrix
				float cosAngle = cos(_Time.w);
				float sinAngle = sin(_Time.w);
				float2x2 rot = float2x2(cosAngle,-sinAngle,sinAngle,cosAngle);
				//Rotation consedering pivot
				float2 uv = v.texcoord.xy - pivot;
				o.uv = mul(rot,uv);
				o.uv += pivot;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return tex2D(_MainTex, i.uv);
			}
			ENDCG
		}
	}
}
