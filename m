Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145F606A32D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=kY0Yg5EJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582B1112344;
	Thu, 26 Nov 2026 11:32:00 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212D411230B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:31:52 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 130FEC2B9C9;
 Thu, 26 Nov 2026 11:31:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C100E60237;
 Thu, 26 Nov 2026 11:31:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 87DD111E6B324; Thu, 26 Nov 2026 12:31:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692707; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=bE49lmI1WH7RlvtPvS+Y29YOSqLTn5J4n7HHlqAPMAI=;
 b=kY0Yg5EJCGS5AaQfdgZDGR2D5ETD0OwPM3hdHgokZwtzKELc5rvfxlLdQIOgbFrnnQRfXT
 svNVhTX2WViO3xGo60GrjaJ7X/kOj87M8YdXbQkiq2NPQu/5g/uXQkFwqLLLTZ9ikko6mF
 5BmSzUEEbCxwLqrPQhYS8D33okzuJRXSFB8BHeOv5hA/55RB8jjoHHrO7RJnqip13eamrk
 pYRfzofP/MTlJLR3NIN2IH5L3c//oYvuZryjsHOuHFNyj0f7scCTOJ9qsvbS/CXD5AzWip
 tqp6lekUp//okBZL0+B0+2bndHSEMAHNwDM3IORpcMRe+Bv/ZTc7JLB1fzJLow==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:08 +0100
Subject: [PATCH v7 25/43] drm/vkms: Introduce config for plane format
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-25-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
In-Reply-To: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
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
 linux-doc@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.17-dev
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
index 6e4e2143c652..230346e56877 100644
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
@@ -407,6 +443,17 @@ bool vkms_config_is_valid(const struct vkms_config *config)
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
 
@@ -470,6 +517,15 @@ static __nocfi void show_bitfield(struct seq_file *m, uint32_t value, const char
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
@@ -516,6 +572,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 			seq_puts(m, "\n");
 			seq_printf(m, "\tdefault color range=%s\n",
 				   drm_get_color_range_name(vkms_config_plane_get_default_color_range(plane_cfg)));
+			seq_puts(m, "\tsupported formats=");
+			show_formats(m, vkms_config_plane_get_supported_formats(plane_cfg),
+				     vkms_config_plane_get_supported_formats_count(plane_cfg));
+			seq_puts(m, "\n");
 		}
 
 		vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
@@ -566,6 +626,10 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	if (ret)
 		goto cleanup_plane_cfg;
 
+	ret = vkms_config_plane_add_all_formats(plane_cfg);
+	if (ret)
+		goto cleanup_plane_cfg;
+
 	vkms_config_plane_set_supported_rotations(plane_cfg,
 						  DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
 	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_ROTATE_0);
@@ -584,6 +648,7 @@ struct vkms_config_plane __must_check *vkms_config_create_plane(struct vkms_conf
 	return plane_cfg;
 
 cleanup_plane_cfg:
+	kfree(plane_cfg->supported_formats);
 	kfree(plane_cfg);
 fail:
 	return ERR_PTR(ret);
@@ -595,6 +660,7 @@ static void vkms_config_plane_rcu_free(struct rcu_head *head)
 	struct vkms_config_plane *plane_cfg =
 		container_of(head, struct vkms_config_plane, rcu);
 
+	kfree(plane_cfg->supported_formats);
 	kfree(plane_cfg->name);
 	kfree(plane_cfg);
 }
@@ -721,6 +787,80 @@ static struct vkms_config_plane *vkms_config_crtc_get_plane(const struct vkms_co
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
index 20369e8d7c6e..1b353556166c 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -64,6 +64,8 @@ struct vkms_config {
  * @supported_color_encodings: Color encodings that this plane will support
  * @default_color_range: Default color range that should be used by this plane
  * @supported_color_ranges: Color ranges that this plane will support
+ * @supported_formats: List of supported formats
+ * @supported_formats_count: Length of @supported_formats
  */
 struct vkms_config_plane {
 	struct list_head link;
@@ -78,6 +80,8 @@ struct vkms_config_plane {
 	unsigned int supported_color_encodings;
 	enum drm_color_range default_color_range;
 	unsigned int supported_color_ranges;
+	u32 *supported_formats;
+	unsigned int supported_formats_count;
 	struct xarray possible_crtcs;
 	bool default_pipeline;
 
@@ -528,6 +532,53 @@ bool vkms_config_valid_plane_color_range(const struct vkms_config *config,
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
index 71be819fe159..70ed0e68a1c9 100644
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
@@ -268,7 +232,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device *vkmsdev,
 	 */
 	plane = drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
 					   &vkms_plane_funcs,
-					   vkms_formats, ARRAY_SIZE(vkms_formats),
+					   vkms_config_plane_get_supported_formats(plane_cfg),
+					   vkms_config_plane_get_supported_formats_count(plane_cfg),
 					   NULL, vkms_config_plane_get_type(plane_cfg),
 					   vkms_config_plane_get_name(plane_cfg) ? "%s" : NULL,
 					   vkms_config_plane_get_name(plane_cfg));

-- 
2.56.0

