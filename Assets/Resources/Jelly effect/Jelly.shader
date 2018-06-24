Shader "Unlit/Jelly Effect"{
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
				IN.pos.x += sign(IN.pos.x)*sin(_Time.w)/50;
				IN.pos.y += sign(IN.pos.y)*cos(_Time.w)/50;
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
//sin(0) = 0  sin(90)=1  sin(180) =0 sin(270)=-1 sin(360)=0
//cos(0) = 1 cos(90) = 0 cos(180) = 1 cos(270) = 0 cos(360) =1
// pos.x + 
