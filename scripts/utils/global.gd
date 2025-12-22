extends Node

### I've finally gone insane.

### So be it, mathematics. Fuck you and your brain numbing inverse kinematics math,
### I'm going to brute force it and no one will know.

var PlayerHandTransformDict = {
	NON_AIMING = {
		OH_ARM_RIGHT = {
			pos = Vector3(0.483, -0.396, -0.102),
			rot_euler = Vector3(15.3, 1, -180.0),
			rot_rad = proc.Vector3Deg2Rad(Vector3(15.4,5,-180.0))
		},
		OH_ARM_LEFT = {
			pos = Vector3(-0.511, -0.3966, -0.102),
			rot_euler = Vector3(15.3, -1, -180.0),
			rot_rad = proc.Vector3Deg2Rad(Vector3(15.4,-5,-180.0))
		}
	}
}
