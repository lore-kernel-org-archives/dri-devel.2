Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD3BC44500
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 185E710E44B;
	Sat, 27 Jun 2026 03:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="QZNuR4ce";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADABE10E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:32:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 5A105C58468;
 Sat, 27 Jun 2026 03:32:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 49A6260233;
 Sat, 27 Jun 2026 03:32:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9AA55106F116E; 
 Sat, 27 Jun 2026 05:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531126; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=U/t3OuHhm+KhQ/USRuPMK5z2hSnEgIEZbf8Llp8CSuE=;
 b=QZNuR4ceHxC721pk5FQDwU81zIPzLjyaS2wRrfc9eCK/mp+8ltyGemGvRGFcaNEk7yBAjk
 ZbJq9fc+Xaj1Y1Cf2Oi1Qaslhs32yI8Sgq0nwxh+jJv/LR/mUcY16eQcLpK1dOe+ix7Sww
 DOGoQXPcQitASRljNWnnyZa7KgheHNgDR7IPviua57fsXuGZ/mhlVDqVQTfBb9oq2NjHwP
 lU6hx3DniXSTlgwYW1V8h27+/UY96AffUvQaR5CQSyqV2q2Lk7FYfTOI/7uirMzr1KJmlL
 DZmicPQKCEcyF98SKn9lc+VQbuAOJR7jyi1nqKjbKkw2gZRedZ4lGdihq8uL8Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:49 +0200
Subject: [PATCH v5 32/38] drm/vkms: Introduce config for connector EDID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-32-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
In-Reply-To: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, victoria@system76.com, 
 sebastian.wick@redhat.com, victoria@system76.com, airlied@gmail.com, 
 thomas.petazzoni@bootlin.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>, llvm@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8106;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=W4oXPHd9u+n2+sEaPl/KX2dNXZXuOxb/QQcM3uIJH7g=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PhWScKnJ+lj14fgbitf2evRNFAbavdKZx+S
 OU+vwfWLtOJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D4RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOJ5BBAAtkJA5SH2Ovd8crd6VNxuGsBfQMtgmXA
 s9GxqVW9oNUd4N5DoW/kop3TkVAYTVttEazgphme+GOmjP01OydVFwwg356O8R6eIOG9mRvvLnq
 9fmJdA2LTW0xiE0SFraR5BFgCoQC/rXfbsgVFmM78jIjDOPT4LQthVuiGI7vvg1wzKmCxDqrJUQ
 zMsEErqELiItJPQX5eScyjC2EoSJ66hpx5VDgurBRfFS2TDf3BlwDEO0zudNjIzA4EigZSwYaJf
 /JNyQg2+xZW8p5azVvE5pBX1a4HFXfH9xerbguesIwzCWIBVI2VOeXlNncy8PCxhpZCsqR6+SZm
 d/U/9N26QjqsfWcvth/eXNM9KWKVfgHD/xlJjXE2obAYo0533AFugOh0oODXDT/a+4tur1wcy2O
 nb3hF3HQuMRpKdXEUvmFb0J72I1gELKG0l58bJGVHKoMROZlldJgqLsPo0eivBL201yuq+1ifuZ
 JRBT4cP8mQALS5+b4S9n2UfAcLo3gg2J3CjbLl1W+lymeIlu9qLiwUBgytSum7AY8Hl7dN1Cueg
 tIuifITSGDezdbdgoLJvoiYe4+fuEyo+Kk/WI9QU4L9b3ifjY+R2/b370ipOqpJtPMJTfDTkQYL
 Bvt5rSs/1gkpvxbQVZwmHyHXmN+GEFv3X4j2yOAWuwgIgNTqbYXs=
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Allows configuration of EDID for each connector.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  2 +
 drivers/gpu/drm/vkms/vkms_config.c            |  6 +++
 drivers/gpu/drm/vkms/vkms_config.h            | 75 +++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         | 50 ++++++++++++++++--
 4 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index a31fd230c1d4..2b49745ee026 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -218,6 +218,8 @@ static void vkms_config_test_default_config(struct kunit *test)
 		KUNIT_EXPECT_EQ(test,
 				vkms_config_connector_get_supported_colorspaces(connector_cfg),
 				0);
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_edid_enabled(connector_cfg),
+				false);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index ea9bc5d06be6..1a110b8aa114 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -538,6 +538,7 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct drm_device *dev = entry->dev;
 	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 	const char *dev_name;
+	int edid_len;
 	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_encoder *encoder_cfg;
@@ -604,6 +605,11 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		show_bitfield(m, vkms_config_connector_get_supported_colorspaces(connector_cfg),
 			      drm_get_colorspace_name);
 		seq_puts(m, "\n");
+		vkms_config_connector_get_edid(connector_cfg, &edid_len);
+		seq_printf(m, "\tEDID=%s (len=%d)\n",
+			   str_enabled_disabled(vkms_config_connector_get_edid_enabled(connector_cfg)),
+			   edid_len
+		);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 80bbc13aad79..7e361b6e45b0 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -137,6 +137,9 @@ struct vkms_config_encoder {
  *                         are the sames as ones accepted by
  *                         drm_mode_create_hdmi_colorspace_property() and
  *                         drm_mode_create_dp_colorspace_property()
+ * @edid_enabled: If true, create the EDID property
+ * @edid: Stores the current EDID. The value will be ignored if @edid_enabled is false
+ * @edid_len: Current EDID length. The value will be ignored if @edid_enabled is false
  * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
@@ -150,6 +153,9 @@ struct vkms_config_connector {
 	int type;
 	enum drm_connector_status status;
 	u32 supported_colorspaces;
+	bool edid_enabled;
+	u8 *edid;
+	unsigned int edid_len;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -274,6 +280,75 @@ vkms_config_connector_get_supported_colorspaces(const struct vkms_config_connect
 	return connector_cfg->supported_colorspaces;
 }
 
+/**
+ * vkms_config_connector_get_edid_enabled() - Check if EDID is enabled for a connector
+ * @connector_cfg: Connector configuration to check
+ *
+ * Returns:
+ * True if EDID is enabled for this connector, false otherwise.
+ */
+static inline bool
+vkms_config_connector_get_edid_enabled(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->edid_enabled;
+}
+
+/**
+ * vkms_config_connector_set_edid_enabled() - Enable or disable EDID for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @enabled: Whether to enable EDID for this connector
+ */
+static inline void
+vkms_config_connector_set_edid_enabled(struct vkms_config_connector *connector_cfg,
+				       bool enabled)
+{
+	connector_cfg->edid_enabled = enabled;
+}
+
+/**
+ * vkms_config_connector_get_edid() - Get the EDID data for a connector
+ * @connector_cfg: Connector configuration to get the EDID from
+ * @len: Pointer to store the length of the EDID data
+ *
+ * Returns:
+ * Pointer to the EDID data buffer, or NULL if no EDID is set.
+ * The length of the EDID data is stored in @len.
+ */
+static inline const u8 *
+vkms_config_connector_get_edid(const struct vkms_config_connector *connector_cfg, int *len)
+{
+	*len = connector_cfg->edid_len;
+	return connector_cfg->edid;
+}
+
+/**
+ * vkms_config_connector_set_edid() - Set the EDID data for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @edid: Pointer to the EDID data buffer
+ * @len: Length of the EDID data
+ *
+ * If @len is 0, the EDID data will be cleared and @edid ignored. If
+ * memory allocation fails, the existing EDID data will be preserved.
+ */
+static inline void
+vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
+			       const u8 *edid, unsigned int len)
+{
+	if (len) {
+		void *edid_tmp = krealloc(connector_cfg->edid, len, GFP_KERNEL);
+
+		if (edid_tmp) {
+			connector_cfg->edid = edid_tmp;
+			memcpy(connector_cfg->edid, edid, len);
+			connector_cfg->edid_len = len;
+		}
+	} else {
+		kfree(connector_cfg->edid);
+		connector_cfg->edid = NULL;
+		connector_cfg->edid_len = len;
+	}
+}
+
 /**
  * vkms_config_get_device_name() - Return the name of the device
  * @config: Configuration to get the device name from
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index a1f08167def1..fe42ab2ba7b1 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -42,13 +42,55 @@ static const struct drm_connector_funcs vkms_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static int vkms_connector_read_block(void *context, u8 *buf, unsigned int block, size_t len)
+{
+	struct vkms_config_connector *config = context;
+	unsigned int edid_len;
+	const u8 *edid = vkms_config_connector_get_edid(config, &edid_len);
+
+	if (block * len + len > edid_len)
+		return 1;
+	memcpy(buf, &edid[block * len], len);
+	return 0;
+}
+
 static int vkms_conn_get_modes(struct drm_connector *connector)
 {
-	int count;
+	struct vkms_connector *vkms_connector = drm_connector_to_vkms_connector(connector);
+	const struct drm_edid *drm_edid = NULL;
+	int count = 0;
+	struct vkms_config_connector *context = NULL;
+	struct drm_device *dev = connector->dev;
+	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
+	struct vkms_config_connector *connector_cfg;
 
-	/* Use the default modes list from DRM */
-	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
-	drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
+	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+		if (connector_cfg->connector == vkms_connector) {
+			context = connector_cfg;
+			break;
+		}
+	}
+	if (context) {
+		if (vkms_config_connector_get_edid_enabled(context)) {
+			drm_edid = drm_edid_read_custom(connector,
+							vkms_connector_read_block, context);
+
+			/*
+			 * Unconditionally update the connector. If the EDID was read
+			 * successfully, fill in the connector information derived from the
+			 * EDID. Otherwise, if the EDID is NULL, clear the connector
+			 * information.
+			 */
+			drm_edid_connector_update(connector, drm_edid);
+
+			count = drm_edid_connector_add_modes(connector);
+
+			drm_edid_free(drm_edid);
+		} else {
+			count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
+			drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
+		}
+	}
 
 	return count;
 }

-- 
2.54.0

