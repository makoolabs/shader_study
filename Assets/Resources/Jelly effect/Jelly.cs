using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Jelly : MonoBehaviour {
	public MeshFilter mesh;
	public Transform[] trans;
	public LineRenderer line;
	public void Start(){
		var count = mesh.mesh.vertexCount;
		var verts = mesh.mesh.vertices;
	}
	int index = 0;
	public void Update(){
		var t = Time.realtimeSinceStartup;
		for(var i = 0;i<trans.Length;i++){
			var tran = trans[i];
			var pos = tran.localPosition;
			var s = sign(pos.x)*Mathf.Cos(t*3)/50;
			var c = sign(pos.y)*Mathf.Sin(t*3)/50;
			pos.x += s;
			pos.y += c;
			tran.localPosition = pos;
		}
		line.positionCount++;
		line.SetPosition(index++,trans[trans.Length-1].localPosition);
	}

	private int sign(float x){
		return x>0?1:(x==0?0:-1);
	}
}
