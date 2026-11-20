Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090CA606A33D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IQB9XVJz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392A3112C77;
	Fri, 20 Nov 2026 18:05:07 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2161112C77
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:04:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 670C34E41693;
 Fri, 20 Nov 2026 18:04:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3BF7F601B9;
 Fri, 20 Nov 2026 18:04:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7285D11BC0627; Fri, 20 Nov 2026 19:04:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197891; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=7Xif5sTlw5uZ32kkcJVZfCDv653KuOlybLMy01kUG3o=;
 b=IQB9XVJzM3KCBKLZJgKYdqHyf4Y772MXcRmnNFOhrIG80xWz5Hj3fNTtrq6aC5GEFyVZXL
 Q/zEKjd6TP0G9TCiE5RY53tpdEO65cDP8KHew55Y+JApkpnLlYmOzyKhITYHpveSalijpv
 aQoGTtIg/9W/S+zlekLLk0E9DzHjg0NBRsSLSTzTeKDxqItCNzrufNcRK06VPgoL/dHo/x
 TogF5LsqktbM/tsyVPlbAU5xEYsMWlq/rVebrmIP3SqICfkv9Qo+loP+E2B1IyujoGM30w
 MjdZMNFXoT+kfssum8XjMS1ZPpXDRD073h2HYKVcK4CcyqQxlR04kKaEt442Kw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:08 +0100
Subject: [PATCH v6 26/43] drm/vkms: Introduce config for plane format
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-26-78ace90f4fc1@bootlin.com>
References: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
In-Reply-To: <20261120-vkms-all-config-v6-0-78ace90f4fc1@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Oarora Etimis <oaroraetimis@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Lucas De Marchi <demarchi@kernel.org>, 
 =?utf-8?q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, sebastian.wick@redhat.com, 
 victoria@system76.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Simona Vetter <simona.vetter@ffwll.ch>, 
 llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=11474;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=QAPMqX4TXRRKvnnwYxRI3ilOmDbfTQV01bLv4Qd5JJs=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsAcYQ9ATGpKgsQLLAJeZbY296AxqR0AE/v/
 KOHoow8tLGJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLABsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKjtQ/+NelsUoGSXSijMlgz655hdEnvNHmb5Kp
 tiPujlWJD5S9+/VWcTKQgngldltYPwHbY+0WVXVi8z9coOhc2JzlHM8Gqew/qgqwTfDXKqcn0dJ
 +jzRMdKynyuu5r9AW2t7634BWv/yH7s+ym2zf55E01Tq4POtw+XG5Y35nQjOTM4pBr3od8Axxah
 9FMSWKAAaMRfYHxhf39Xq9PeI7t0W44XMyTzGlOw/XtGFjRN5kpx3cKjXu2BmZigCxayCoIVjXp
 KTme6eLnw9bggnydDmlQL+OZAaD7O8vCHVxT23Tw1gaY2Ni1zfZuOoUMxcqpdKeMRO1cq4ealk8
 LhEODLhb/02Wdcbi5QwX0ZQB9J2vkSIxE/y3E6TJ4FN+bporMfExcP+ajKWONcofzQKjnnzCaL+
 3PEqL6tCL/CJ0hTNMqOA72UgjgwJ/9uXNwOsa4jmusgUvbIWO2RNikbtSVFaB5Rs1O5D/hnME5n
 2OoeD0eCh+mnJ68QabdWtlhL7q+wUg7XHEHpx7anrteBDpcmM0BaO3ugSTh8h0RC28dnx20oiyr
 z6dLGSzvl9D9tskZL8FlG9fZOf/WpYrVLRDwc9Bhw0KUfLm/yauZCXDLvxPneWpEmcOd99K90iz
 uRA8hg2p1NRv9lL2nqOexCE01dH2D7wuY9rcvO2kyW+BALPigak0=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

VKMS driver supports all the pixel formats for planes, but for testing it
can be useful to only advertise few of them. This new configuration
interface will allow configuring the pixel format per planes.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 140 +++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h |  51 ++++++++++++++
 drivers/gpu/drm/vkms/vkms_plane.c  |  39 +----------
 3 files changed, 193 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index b33760692ba9..5286363f80f7 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -15,6 +15,42 @@
 
 static void vkms_config_connector_release(struct kref *ref);
 
+static const u32 vkms_supported_plane_formats[] = {
+	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ABGR8888,
+	DRM_FORMAT_BGRA8888,
+	DRM_FORMAT_RGBA8888,
+	DRM_FORMAT_XRGB8888,
+	DRM_FORMAT_XBGR8888,
+	DRM_FORMAT_RGB888,
+	DRM_FORMAT_BGR888,
+	DRM_FORMAT_XRGB16161616,
+	DRM_FORMAT_XBGR16161616,
+	DRM_FORMAT_ARGB16161616,
+	DRM_FORMAT_ABGR16161616,
+	DRM_FORMAT_RGB565,
+	DRM_FORMAT_BGR565,
+	DRM_FORMAT_NV12,
+	DRM_FORMAT_NV16,
+	DRM_FORMAT_NV24,
+	DRM_FORMAT_NV21,
+	DRM_FORMAT_NV61,
+	DRM_FORMAT_NV42,
+	DRM_FORMAT_YUV420,
+	DRM_FORMAT_YUV422,
+	DRM_FORMAT_YUV444,
+	DRM_FORMAT_YVU420,
+	DRM_FORMAT_YVU422,
+	DRM_FORMAT_YVU444,
+	DRM_FORMAT_P010,
+	DRM_FORMAT_P012,
+	DRM_FORMAT_P016,
+	DRM_FORMAT_R1,
+	DRM_FORMAT_R2,
+	DRM_FORMAT_R4,
+	DRM_FORMAT_R8,
+};
+
 struct vkms_config *vkms_config_create(const char *dev_name)
 {
 	struct vkms_config *config;
@@ -411,6 +447,17 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	struct vkms_config_plane *plane_cfg;
 
 	vkms_config_for_each_plane(config, plane_cfg) {
+		if (vkms_config_plane_get_supported_formats_count(plane_cfg) == 0) {
+			drm_info(dev, "Plane must have at least one supported format.\n");
+			return false;
+		}
+
+		if (vkms_config_plane_get_supported_formats_count(plane_cfg) >
+		    ARRAY_SIZE(vkms_supported_plane_formats)) {
+			drm_info(dev, "Plane has too much formats.\n");
+			return false;
+		}
+
 		if (!vkms_config_valid_plane_rotation(config, plane_cfg))
 			return false;
 
@@ -474,6 +521,15 @@ static __nocfi void show_bitfield(struct seq_file *m, uint32_t value, const char
 	}
 }
 
+static void show_formats(struct seq_file *m, u32 *formats, size_t formats_count)
+{
+	for (int i = 0; i < formats_count; i++) {
+		seq_printf(m, "%p4cc", &formats[i]);
+		if (i != formats_count - 1)
+			seq_puts(m, ", ");
+	}
+}
+
 static int vkms_config_show(struct seq_file *m, void *data)
 {
 	struct drm_debugfs_entry *entry = m->private;
@@ -519,6 +575,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "\n");
 		seq_printf(m, "\tdefault color range=%s\n",
 			   drm_get_color_range_name(vkms_config_plane_get_default_color_range(plane_cfg)));
+		seq_puts(m, "\tsupported formats=");
+		show_formats(m, vkms_config_plane_get_supported_formats(plane_cfg),
+			     vkms_config_plane_get_supported_formats_count(plane_cfg));
+		seq_puts(m, "\n");
 	}
 
 	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -569,6 +629,10 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	if (ret)
 		goto cleanup_plane_cfg;
 
+	ret = vkms_config_plane_add_all_formats(plane_cfg);
+	if (ret)
+		goto cleanup_plane_cfg;
+
 	vkms_config_plane_set_supported_rotations(plane_cfg,
 						  DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
@@ -587,6 +651,7 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	return plane_cfg;
 
 cleanup_plane_cfg:
+	kfree(plane_cfg->supported_formats);
 	kfree(plane_cfg);
 fail:
 	return ERR_PTR(ret);
@@ -596,6 +661,7 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
 void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
 	xa_destroy(&plane_cfg->possible_crtcs);
+	kfree(plane_cfg->supported_formats);
 	list_del(&plane_cfg->link);
 	kfree(plane_cfg->name);
 	kfree(plane_cfg);
@@ -700,6 +766,80 @@ static struct vkms_config_plane *vkms_config_crtc_get_plane(const struct vkms_co
 	return NULL;
 }
 
+int __must_check vkms_config_plane_add_all_formats(struct vkms_config_plane *plane_cfg)
+{
+	u32 *ret = krealloc_array(plane_cfg->supported_formats,
+				  ARRAY_SIZE(vkms_supported_plane_formats),
+				  sizeof(uint32_t), GFP_KERNEL);
+	if (!ret)
+		return -ENOMEM;
+	plane_cfg->supported_formats = ret;
+
+	memcpy(plane_cfg->supported_formats, vkms_supported_plane_formats,
+	       sizeof(vkms_supported_plane_formats));
+	plane_cfg->supported_formats_count = ARRAY_SIZE(vkms_supported_plane_formats);
+	return 0;
+}
+
+static bool is_supported_format(u32 drm_format)
+{
+	for (int i = 0; i < ARRAY_SIZE(vkms_supported_plane_formats); i++) {
+		if (vkms_supported_plane_formats[i] == drm_format)
+			return true;
+	}
+
+	return false;
+}
+
+static bool vkms_config_plane_has_format(struct vkms_config_plane *plane_cfg, u32 drm_format)
+{
+	for (unsigned int i = 0; i < plane_cfg->supported_formats_count; i++) {
+		if (plane_cfg->supported_formats[i] == drm_format)
+			return true;
+	}
+	return false;
+}
+
+int __must_check vkms_config_plane_add_format(struct vkms_config_plane *plane_cfg, u32 drm_format)
+{
+	if (!is_supported_format(drm_format))
+		return -EINVAL;
+
+	if (vkms_config_plane_has_format(plane_cfg, drm_format))
+		return 0;
+
+	u32 *new_ptr = krealloc_array(plane_cfg->supported_formats,
+				      plane_cfg->supported_formats_count + 1,
+				      sizeof(*plane_cfg->supported_formats), GFP_KERNEL);
+	if (!new_ptr)
+		return -ENOMEM;
+
+	plane_cfg->supported_formats = new_ptr;
+	plane_cfg->supported_formats[plane_cfg->supported_formats_count] = drm_format;
+	plane_cfg->supported_formats_count++;
+
+	return 0;
+}
+
+void vkms_config_plane_remove_all_formats(struct vkms_config_plane *plane_cfg)
+{
+	plane_cfg->supported_formats_count = 0;
+	kfree(plane_cfg->supported_formats);
+	plane_cfg->supported_formats = NULL;
+}
+
+void vkms_config_plane_remove_format(struct vkms_config_plane *plane_cfg, u32 drm_format)
+{
+	for (unsigned int i = 0; i < plane_cfg->supported_formats_count; i++) {
+		if (plane_cfg->supported_formats[i] == drm_format) {
+			plane_cfg->supported_formats[i] =
+				plane_cfg->supported_formats[plane_cfg->supported_formats_count -
+					1];
+			plane_cfg->supported_formats_count--;
+		}
+	}
+}
+
 struct vkms_config_plane *vkms_config_crtc_primary_plane(const struct vkms_config *config,
 							 struct vkms_config_crtc *crtc_cfg)
 {
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 827f1b3023aa..7488a17aee8d 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -58,6 +58,8 @@ struct vkms_config {
  * @supported_color_encodings: Color encodings that this plane will support
  * @default_color_range: Default color range that should be used by this plane
  * @supported_color_ranges: Color ranges that this plane will support
+ * @supported_formats: List of supported formats
+ * @supported_formats_count: Length of @supported_formats
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -71,6 +73,8 @@ struct vkms_config_plane {
 	unsigned int supported_color_encodings;
 	enum drm_color_range default_color_range;
 	unsigned int supported_color_ranges;
+	u32 *supported_formats;
+	unsigned int supported_formats_count;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
 
@@ -502,6 +506,53 @@ bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
 					 const struct vkms_config_plane *plane_cfg);
 #endif
 
+static inline u32 *
+vkms_config_plane_get_supported_formats(const struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_formats;
+}
+
+static inline unsigned int
+vkms_config_plane_get_supported_formats_count(struct vkms_config_plane *plane_cfg)
+{
+	return plane_cfg->supported_formats_count;
+}
+
+/** vkms_config_plane_add_format - Add a format to the list of supported format of a plane
+ *
+ * The passed drm_format can already be present in the list. This may fail if the allocation of a
+ * bigger array fails.
+ *
+ * @plane_cfg: Plane to add the format to
+ * @drm_format: Format to add to this plane
+ *
+ * Returns: 0 on success, -ENOMEM if array allocation fails, -EINVAL if the format is not supported
+ * by VKMS
+ */
+int __must_check vkms_config_plane_add_format(struct vkms_config_plane *plane_cfg, u32 drm_format);
+
+/**
+ * vkms_config_plane_add_all_formats - Helper to quickly add all the supported formats
+ * @plane_cfg: Plane to add the formats to
+ *
+ * Returns: 0 on success, -ENOMEM if array allocation fails
+ * by VKMS
+ */
+int __must_check vkms_config_plane_add_all_formats(struct vkms_config_plane *plane_cfg);
+
+/**
+ * vkms_config_plane_remove_format - Remove a specific format from a plane
+ * @plane_cfg: Plane to remove the format from
+ * @drm_format: Format to remove
+ */
+void vkms_config_plane_remove_format(struct vkms_config_plane *plane_cfg, u32 drm_format);
+
+/**
+ * vkms_config_plane_remove_all_formats - Remove all formats from a plane
+ * @plane_cfg: Plane to remove the formats from
+ */
+void vkms_config_plane_remove_all_formats(struct vkms_config_plane *plane_cfg);
+
 /**
  * vkms_config_plane_set_name() - Set the plane name
  * @plane_cfg: Plane to set the name to
diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
index d7bbcaea6351..e028c39b0c81 100644
--- a/drivers/gpu/drm/vkms/vkms_plane.c
+++ b/drivers/gpu/drm/vkms/vkms_plane.c
@@ -16,42 +16,6 @@
 #include "vkms_drv.h"
 #include "vkms_formats.h"
 
-static const u32 vkms_formats[] = {
-	DRM_FORMAT_ARGB8888,
-	DRM_FORMAT_ABGR8888,
-	DRM_FORMAT_BGRA8888,
-	DRM_FORMAT_RGBA8888,
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_XBGR8888,
-	DRM_FORMAT_RGB888,
-	DRM_FORMAT_BGR888,
-	DRM_FORMAT_XRGB16161616,
-	DRM_FORMAT_XBGR16161616,
-	DRM_FORMAT_ARGB16161616,
-	DRM_FORMAT_ABGR16161616,
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_BGR565,
-	DRM_FORMAT_NV12,
-	DRM_FORMAT_NV16,
-	DRM_FORMAT_NV24,
-	DRM_FORMAT_NV21,
-	DRM_FORMAT_NV61,
-	DRM_FORMAT_NV42,
-	DRM_FORMAT_YUV420,
-	DRM_FORMAT_YUV422,
-	DRM_FORMAT_YUV444,
-	DRM_FORMAT_YVU420,
-	DRM_FORMAT_YVU422,
-	DRM_FORMAT_YVU444,
-	DRM_FORMAT_P010,
-	DRM_FORMAT_P012,
-	DRM_FORMAT_P016,
-	DRM_FORMAT_R1,
-	DRM_FORMAT_R2,
-	DRM_FORMAT_R4,
-	DRM_FORMAT_R8,
-};
-
 static struct drm_plane_state *
 vkms_plane_duplicate_state(struct drm_plane *plane)
 {
@@ -264,7 +228,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
-					   vkms_formats, ARRAY_SIZE(vkms_formats),
+					   vkms_config_plane_get_supported_formats(plane_cfg),
+					   vkms_config_plane_get_supported_formats_count(plane_cfg),
 					   NULL, vkms_config_plane_get_type(plane_cfg),
 					   "%s", vkms_config_plane_get_name(plane_cfg));
 	if (IS_ERR(plane))

-- 
2.56.0

