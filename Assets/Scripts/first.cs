using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class first : MonoBehaviour {
	public MeshFilter mesh;
	public void Start(){
		var count = mesh.mesh.vertexCount;
		var verts = mesh.mesh.vertices;
		foreach(var vert in verts){
			Debug.LogWarning(vert.x+"::"+vert.y+"::"+vert.z);
		}
		Debug.LogWarning("vert::"+count);
	}
}
