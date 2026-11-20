Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62094606A33C
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFRcjYQs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A176B112A29;
	Fri, 20 Nov 2026 13:10:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5357112A1E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:10:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 47BE462A0C;
 Fri, 20 Nov 2026 13:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0201F000E1;
 Fri, 20 Nov 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180248;
 bh=iiJnD7v9aFWHKpJ3Q4lR06Nb75KXGKPE8/0cqPiDtQI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dFRcjYQsQxGEeCqdLvwJtGkLL4XugcJLJGa7JBm5m7IFUvgJfaI5VMcO4fGeoJjXm
 1PTcHntbpknbu9u/H9QqNkHuv4cGDHcuhvfJhlUtdEBUGVjI4BGq4GN3wjz7qO77Dk
 tvLp+XGavWeMq2bkgt1U+M7S+DvFmuIbMjHnPcxU7iyz68b08sWI8wwqNzney4OP5b
 r3i2bWFcQu2RHbBUwphPNtKqMbJNjERPyDVXVtLwTDIAhSBqVM3ikLOmVIYN6jZd0+
 krgNRchkN2oIHb/ddIvATIJe+A0vAE7BrvRzgkyHrSGwsUVgrqKAtkb2vQ+pTO5Ljr
 oavBq8u2MXPQg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 14:10:16 +0100
Subject: [PATCH v12 9/9] drm/vkms: Add driver-specific plane property for
 testing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-reset-state-flag-v12-9-42d63d7417fc@kernel.org>
References: <20261120-drm-reset-state-flag-v12-0-42d63d7417fc@kernel.org>
In-Reply-To: <20261120-drm-reset-state-flag-v12-0-42d63d7417fc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Oarora Etimis <oaroraetimis@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6615; i=mripard@kernel.org;
 h=from:subject:message-id; bh=u8FbPSMOVBrgNqgbv2ZDGqH/Wbk2GeZ3sYhq04Tu080=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMbtty+hx5tjybYa9b9yrvr3Nh++3HCxYKLntVzPz7o
 VElb8+7jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjARnS2Mdfbb2aW8/malcd0Q
 NnzrV6RgMKUt7UjBpu2pdnGxoUeXXzb4PlUwTnrGtjkGS/8y/Ms6zFgf4KD4aJuQ2lr+gwnx2ss
 fvd3k+yZ6xSy5ZR47WA4c+NMsWeuaO/Voyqye4vz8hU7OuQUA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM_MODE_ATOMIC_RESET flag allows userspace to reset all object
states to their defaults before applying new property values. Testing
that this mechanism works correctly requires a property that the test
can set to a non-default value and then verify is properly reset.

Using a standard property for this is problematic: compositors like
Mutter enumerate and track all known properties, making it difficult
to isolate the reset behavior from the compositor's own property
management.

Add a "vkms-test-do-not-use-in-prod" range property to vkms planes.
The property is stored in vkms_plane_state, duplicated across state
copies, and initialized from its registered default in
atomic_create_state via drm_object_property_get_default_value().

Reviewed-by: Daniel Stone <daniels@collabora.com>
Reviewed-by: Oarora Etimis <oaroraetimis@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_drv.h   |  3 ++
 drivers/gpu/drm/vkms/vkms_plane.c | 63 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index ce8df1a8fbad..5807c44a0cf2 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -144,20 +144,23 @@ struct conversion_matrix {
  * @base: base plane state
  * @frame_info: data required for composing computation
  * @pixel_read_line: function to read a pixel line in this plane. The creator of a
  *		     struct vkms_plane_state must ensure that this pointer is valid
  * @conversion_matrix: matrix used for yuv formats to convert to rgb
+ * @vkms_test_do_not_use_value: driver-specific property for testing only
  */
 struct vkms_plane_state {
 	struct drm_shadow_plane_state base;
 	struct vkms_frame_info frame_info;
 	pixel_read_line_t pixel_read_line;
 	struct conversion_matrix conversion_matrix;
+	unsigned int vkms_test_do_not_use_value;
 };
 
 struct vkms_plane {
 	struct drm_plane base;
+	struct drm_property *vkms_test_do_not_use_property;
 };
 
 struct vkms_color_lut {
 	struct drm_color_lut *base;
 	size_t lut_length;
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index fd3d34dcf0fe..42513cb462ac 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -9,14 +9,18 @@
 #include <drm/drm_colorop.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
+#include <drm/drm_property.h>
 
 #include "vkms_drv.h"
 #include "vkms_formats.h"
 
+#define to_vkms_plane(target) \
+	container_of_const(target, struct vkms_plane, base)
+
 static const u32 vkms_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_ABGR8888,
 	DRM_FORMAT_BGRA8888,
 	DRM_FORMAT_RGBA8888,
@@ -52,16 +56,19 @@ static const u32 vkms_formats[] = {
 };
 
 static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
+	struct vkms_plane_state *old_state = to_vkms_plane_state(plane->state);
 	struct vkms_plane_state *vkms_state;
 
 	vkms_state = kzalloc_obj(*vkms_state);
 	if (!vkms_state)
 		return NULL;
 
+	vkms_state->vkms_test_do_not_use_value = old_state->vkms_test_do_not_use_value;
+
 	__drm_gem_duplicate_shadow_plane_state(plane, &vkms_state->base);
 
 	return &vkms_state->base.base;
 }
 
@@ -83,28 +90,69 @@ static void vkms_plane_destroy_state(struct drm_plane *plane,
 	kfree(vkms_state);
 }
 
 static struct drm_plane_state *vkms_plane_create_state(struct drm_plane *plane)
 {
+	struct vkms_plane *vkms_plane = to_vkms_plane(plane);
 	struct vkms_plane_state *vkms_state;
+	u64 val;
 
 	vkms_state = kzalloc_obj(*vkms_state);
 	if (!vkms_state) {
 		DRM_ERROR("Cannot allocate vkms_plane_state\n");
 		return ERR_PTR(-ENOMEM);
 	}
 
 	__drm_gem_shadow_plane_state_init(plane, &vkms_state->base);
 
+	if (!drm_object_property_get_default_value(&plane->base,
+						   vkms_plane->vkms_test_do_not_use_property,
+						   &val))
+		vkms_state->vkms_test_do_not_use_value = val;
+
 	return &(&vkms_state->base)->base;
 }
 
+static int vkms_plane_atomic_set_property(struct drm_plane *plane,
+					  struct drm_plane_state *state,
+					  struct drm_property *property,
+					  uint64_t val)
+{
+	struct vkms_plane *vkms_plane = to_vkms_plane(plane);
+	struct vkms_plane_state *vkms_state = to_vkms_plane_state(state);
+
+	if (property == vkms_plane->vkms_test_do_not_use_property) {
+		vkms_state->vkms_test_do_not_use_value = val;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int vkms_plane_atomic_get_property(struct drm_plane *plane,
+					  const struct drm_plane_state *state,
+					  struct drm_property *property,
+					  uint64_t *val)
+{
+	const struct vkms_plane_state *vkms_state = to_vkms_plane_state(state);
+	const struct vkms_plane *vkms_plane = to_vkms_plane(plane);
+
+	if (property == vkms_plane->vkms_test_do_not_use_property) {
+		*val = vkms_state->vkms_test_do_not_use_value;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
 static const struct drm_plane_funcs vkms_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
-	.atomic_create_state = vkms_plane_create_state,
-	.atomic_duplicate_state = vkms_plane_duplicate_state,
+	.atomic_set_property	= vkms_plane_atomic_set_property,
+	.atomic_get_property	= vkms_plane_atomic_get_property,
+	.atomic_create_state	= vkms_plane_create_state,
+	.atomic_duplicate_state	= vkms_plane_duplicate_state,
 	.atomic_destroy_state	= vkms_plane_destroy_state,
 };
 
 static void vkms_plane_atomic_update(struct drm_plane *plane,
 				     struct drm_atomic_commit *state)
@@ -281,10 +329,21 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					  BIT(DRM_COLOR_YCBCR_LIMITED_RANGE) |
 					  BIT(DRM_COLOR_YCBCR_FULL_RANGE),
 					  DRM_COLOR_YCBCR_BT601,
 					  DRM_COLOR_YCBCR_FULL_RANGE);
 
+	plane->vkms_test_do_not_use_property =
+		drm_property_create_range(dev, 0,
+					  "vkms-test-do-not-use-in-prod",
+					  0, U32_MAX);
+	if (!plane->vkms_test_do_not_use_property)
+		return ERR_PTR(-ENOMEM);
+
+	drm_object_attach_property(&plane->base.base,
+				   plane->vkms_test_do_not_use_property,
+				   0);
+
 	if (vkms_config_plane_get_default_pipeline(plane_cfg))
 		vkms_initialize_colorops(&plane->base);
 
 	return plane;
 }

-- 
2.56.1

