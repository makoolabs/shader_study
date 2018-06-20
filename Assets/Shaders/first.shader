Shader "Unlit/first"{
	SubShader{
		Pass{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			struct appdata{
				float4 pos:POSITION;
			};
			struct v2f{
				float4 pos:SV_POSITION;
			};
			v2f vert(appdata IN){
				v2f o;
				o.pos = UnityObjectToClipPos(IN.pos);
				return o;
			}
			fixed4 frag(v2f IN):SV_TARGET{
				return fixed4(1,1,0,1);
			}
			ENDCG
		}
	}
}
