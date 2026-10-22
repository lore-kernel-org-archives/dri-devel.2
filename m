Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E9606A335
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vh9QJ85I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90B67112688;
	Thu, 22 Oct 2026 13:54:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F2611266F
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:54:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0DCE40F40;
 Thu, 22 Oct 2026 13:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE8A1F000C7;
 Thu, 22 Oct 2026 13:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792677250;
 bh=6ZzQsZGcg18quMqMh69zzhWreZ6eF7KFu7H5SdblfDY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Vh9QJ85IQf+V43gTRnlITAdDRXRVKjbBOK7I4ikMXAGVQzEwqiqkchYL1nYlC57Gl
 f3U53Tub2gQK9gUUkwLMhyPRfCF1q8Er9E8lR66Nu6gsbEZnrefDkedLcLjZPpZ0oB
 qBKpvr54fX8d/DdGPEMtBaleOwvESG0Ggka3a+X8W9eyfQuv4oqSBsyknsVCn05121
 1oJbDTxMpUxUGAiQjT8lGnDYZPrPXv9BbcgP0IuiJ/QUEdCO+CVmyVtsRo8fI6St6U
 2VH2JlTpTcsAB3nCeRuR24CZKuxnxCSpSGWpMkxkQmZS/uyJGPTRdID+xp+9HUsmcx
 7H/nHv9N5Hu8Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 15:53:16 +0200
Subject: [PATCH v6 15/15] drm/vkms: Add driver-specific plane property for
 testing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-reset-state-flag-v6-15-f36d640b7e76@kernel.org>
References: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
In-Reply-To: <20261022-drm-reset-state-flag-v6-0-f36d640b7e76@kernel.org>
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
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5644; i=mripard@kernel.org;
 h=from:subject:message-id; bh=PvyuuyhdjASC30AtEcfGja2PmrzUAnlbW0yqbZ3QSmQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3RD0Zs/YtkFX6nZM+4aTmjQnBFzr51uh+zoho91I2n
 DypyXdTx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIzgXGhssHPadoCOkI+2kc
 qtQK3BNz9JPUlpNl/Fl7VdlNd3+v87AVbX+Z/PLD/e7aWy0P1WvqGBv+vmZ00bXhkdSM+12TczI
 +5W1b9zTfIPkvi+SuVvB+SLgTw9nI8MC0fJ0zU5lVgfe6RwA=
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/vkms/vkms_drv.h   |  3 ++
 drivers/gpu/drm/vkms/vkms_plane.c | 61 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index dea6cad3f1b9..384616095b45 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -147,4 +147,5 @@ struct conversion_matrix {
  *		     struct vkms_plane_state must ensure that this pointer is valid
  * @conversion_matrix: matrix used for yuv formats to convert to rgb
+ * @vkms_test_do_not_use_value: driver-specific property for testing only
  */
 struct vkms_plane_state {
@@ -153,8 +154,10 @@ struct vkms_plane_state {
 	pixel_read_line_t pixel_read_line;
 	struct conversion_matrix conversion_matrix;
+	unsigned int vkms_test_do_not_use_value;
 };
 
 struct vkms_plane {
 	struct drm_plane base;
+	struct drm_property *vkms_test_do_not_use_property;
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index fd3d34dcf0fe..0ebc131c2788 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -12,8 +12,12 @@
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
@@ -55,4 +59,5 @@ static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
+	struct vkms_plane_state *old_state = to_vkms_plane_state(plane->state);
 	struct vkms_plane_state *vkms_state;
 
@@ -61,4 +66,6 @@ vkms_plane_duplicate_state(struct drm_plane *plane)
 		return NULL;
 
+	vkms_state->vkms_test_do_not_use_value = old_state->vkms_test_do_not_use_value;
+
 	__drm_gem_duplicate_shadow_plane_state(plane, &vkms_state->base);
 
@@ -86,5 +93,7 @@ static void vkms_plane_destroy_state(struct drm_plane *plane,
 static struct drm_plane_state *vkms_plane_create_state(struct drm_plane *plane)
 {
+	struct vkms_plane *vkms_plane = to_vkms_plane(plane);
 	struct vkms_plane_state *vkms_state;
+	u64 val;
 
 	vkms_state = kzalloc_obj(*vkms_state);
@@ -96,12 +105,51 @@ static struct drm_plane_state *vkms_plane_create_state(struct drm_plane *plane)
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
@@ -284,4 +332,13 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 					  DRM_COLOR_YCBCR_FULL_RANGE);
 
+	plane->vkms_test_do_not_use_property =
+		drm_property_create_range(dev, 0,
+					  "vkms-test-do-not-use-in-prod",
+					  0, U32_MAX);
+	if (plane->vkms_test_do_not_use_property)
+		drm_object_attach_property(&plane->base.base,
+					   plane->vkms_test_do_not_use_property,
+					   0);
+
 	if (vkms_config_plane_get_default_pipeline(plane_cfg))
 		vkms_initialize_colorops(&plane->base);

-- 
2.55.0

