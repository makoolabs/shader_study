using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TextureSwitch : MonoBehaviour {
	private Material Mat;
	private GameObject Player;
	public float Radius = 10;
	void Start(){
		Mat = GetComponent<Renderer>().material;
		Player = GameObject.Find("Player");
	}
	private int direction = 1;
	private float speed = 0.5f;
	void Update(){
		var pos = Player.transform.position;
		pos.x += direction*Time.deltaTime*speed;
		if(pos.x>=1.5f){
			direction = -1;
		}
		if(pos.x<=-1.5f){
			direction = 1;
		}
		Player.transform.position = pos;
		Mat.SetVector("_PlayerPos",Player.transform.position);
		Mat.SetFloat("_Dist",Radius);
	}
}
