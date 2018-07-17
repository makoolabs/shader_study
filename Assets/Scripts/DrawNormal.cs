using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
public class DrawNormal : MonoBehaviour {
	public SkinnedMeshRenderer render;
	[SerializeField]
	private bool _displayWireframe = false;
	[SerializeField]
	private NormalsDrawData _faceNormals = new NormalsDrawData(new Color32(34,221,221,155),true);
	[SerializeField]
	private NormalsDrawData _vertexNormals = new NormalsDrawData(new Color32(200,255,195,127),true);

	void OnDrawGizmosSelected(){
		EditorUtility.SetSelectedRenderState(render,_displayWireframe?EditorSelectedRenderState.Wireframe:EditorSelectedRenderState.Hidden);
		OnDrawNormals(true);
	}
	public void OnDrawGizmos() {
		if(!Selection.Contains(this)){
			OnDrawNormals(true);
		}
	}

	private void OnDrawNormals(bool isSelected){
		var mesh = render.sharedMesh;
		if(_faceNormals.CanDraw(isSelected)){
			var triangles = mesh.triangles;
			var vertices = mesh.vertices;
			for(var i = 0;i<triangles.Length;i+=3){
				var v0 = transform.TransformPoint(vertices[triangles[i]]);
				var v1 = transform.TransformPoint(vertices[triangles[i+1]]);
				var v2 = transform.TransformPoint(vertices[triangles[i+2]]);
				var center = (v0+v1+v2)/3;
				var dir = Vector3.Cross(v1-v0,v2-v0);
				dir /= dir.magnitude;
				_faceNormals.Draw(center,dir);
			}
		}
		if(_vertexNormals.CanDraw(isSelected)){
			var vertices = mesh.vertices;
			var normals = mesh.normals;
			for(var i = 0;i<vertices.Length;i++){
				_vertexNormals.Draw(transform.TransformPoint(vertices[i]),transform.TransformVector(normals[i]));
			}
		}
	}

	[System.Serializable]
	private class NormalsDrawData{
		[SerializeField]
		protected DrawType _draw = DrawType.Selected;
		protected enum DrawType{Never,Selected,Always}
		[SerializeField]
		protected float _length = 0.3f;
		[SerializeField]
		protected Color _normalColor;
		private Color _baseColor = new Color32(255,133,0,255);
		private const float _baseSize = 0.0125f;
		public NormalsDrawData(Color normalColor,bool draw){
			this._normalColor = normalColor;
			this._draw = draw ? DrawType.Selected:DrawType.Never;
		}
		public bool CanDraw(bool isSelected){
			return (this._draw == DrawType.Always)||(this._draw == DrawType.Selected && isSelected);
		}

		public void Draw(Vector3 from,Vector3 direction){
			if(Camera.current.transform.InverseTransformDirection(direction).z<0f){
				Gizmos.color = _baseColor;
				Gizmos.DrawWireSphere(from,_baseSize);
				Gizmos.color = _normalColor;
				Gizmos.DrawRay(from,direction*_length);
			}
		}
	}
}
