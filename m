Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E8606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=X69ZALn8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED37112354;
	Thu, 26 Nov 2026 11:32:51 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9491112351
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:32:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 82B524E41780;
 Thu, 26 Nov 2026 11:32:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 507EF60237;
 Thu, 26 Nov 2026 11:32:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C24DF11E6B306; Thu, 26 Nov 2026 12:32:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692754; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hMm6MPgtfX5HPLFmHUEsbteIllEBE7dr2I2UIPxH4Zg=;
 b=X69ZALn8rG+xElps9l1WTh3gXi2fFDdNdWIgkwBLzmd3YreqZhghuGRGynxwtXce/wxDz+
 RtqNKCefulXf5V92yEafdlFgusAo3po1IksNdI8XM3hJcfjjzVSAwAN6Jw4zjIak5+Trk5
 K+h63nPcPNHumpGF5wePzHquh/ge1gO5IDAmg5p1kFBKBegcC2F0HEXrXQaBPrO8XYyqRx
 FKs/UFRvwMef8p1V464bNoHLD2H0L6g3THvvh7/oRCEI3aZSernXdCHWneTayt/Anm0IfI
 K3r8TR+beUNHFyJ6Iwj7WNSRMIOIkk793qesO7MwRrE9BjfPNlZMtLdZHkLUNg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:17 +0100
Subject: [PATCH v7 34/43] drm/vkms: Introduce config for connector
 supported colorspace
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-34-21194cda2468@bootlin.com>
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

To emulate some HDR features of displays, it is required to expose some
properties on HDMI, eDP and DP connectors.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  3 ++
 drivers/gpu/drm/vkms/vkms_config.c            | 40 +++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 30 ++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         | 51 +++++++++++++++++++++++++++
 4 files changed, 124 insertions(+)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 257ba0342034..1c54d6f9828d 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -215,6 +215,9 @@ static void vkms_config_test_default_config(struct kunit *test)
 	vkms_config_for_each_connector(config, connector_cfg) {
 		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_type(connector_cfg),
 				DRM_MODE_CONNECTOR_VIRTUAL);
+		KUNIT_EXPECT_EQ(test,
+				vkms_config_connector_get_supported_colorspaces(connector_cfg),
+				0);
 	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index b415d4bf6edb..fa4ca256b4b9 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -466,6 +466,38 @@ static bool valid_connector_possible_encoders(const struct vkms_config *config)
 	return true;
 }
 
+static bool valid_connector_colorspaces(const struct vkms_config *config)
+{
+	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
+	struct vkms_config_connector *connector_cfg;
+
+	vkms_config_for_each_connector(config, connector_cfg) {
+		u32 colorspaces = vkms_config_connector_get_supported_colorspaces(connector_cfg);
+
+		if (!colorspaces)
+			continue;
+
+		switch (connector_cfg->type) {
+		case DRM_MODE_CONNECTOR_HDMIA:
+		case DRM_MODE_CONNECTOR_HDMIB:
+		case DRM_MODE_CONNECTOR_DisplayPort:
+		case DRM_MODE_CONNECTOR_eDP:
+			break;
+		default:
+			drm_info(dev,
+				 "Colorspaces are only supported on HDMI, DisplayPort and eDP connectors\n");
+			return false;
+		}
+
+		if (colorspaces & ~(BIT(DRM_MODE_COLORIMETRY_COUNT) - 1)) {
+			drm_info(dev, "Colorspace value contains invalid bits\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 bool vkms_config_is_valid(const struct vkms_config *config)
 {
 	struct drm_device *dev = config->dev ? &config->dev->drm : NULL;
@@ -543,6 +575,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	if (!valid_connector_possible_encoders(config))
 		return false;
 
+	if (!valid_connector_colorspaces(config))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
@@ -649,6 +684,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 				   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
 			seq_printf(m, "\ttype=%s\n",
 				   drm_get_connector_type_name(vkms_config_connector_get_type(connector_cfg)));
+			seq_puts(m, "\tsupported colorspaces=");
+			show_bitfield(m, vkms_config_connector_get_supported_colorspaces(connector_cfg),
+				      drm_get_colorspace_name);
+			seq_puts(m, "\n");
 		}
 	}
 
@@ -1008,6 +1047,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->config = config;
 	connector_cfg->status = connector_status_connected;
 	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
+	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 	/* refcnt starts at 1: this reference is owned by config->connectors */
 	kref_init(&connector_cfg->refcnt);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index efebb190ce40..341e0638b508 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -153,6 +153,10 @@ struct vkms_config_encoder {
  * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
  * @config: The vkms_config this connector belongs to
  * @status: Status (connected, disconnected...) of the connector
+ * @supported_colorspaces: Bitmask of all the supported colorspaces. Values
+ *                         are the sames as ones accepted by
+ *                         drm_mode_create_hdmi_colorspace_property() and
+ *                         drm_mode_create_dp_colorspace_property()
  * @possible_encoders: Array of encoders that can be used with this connector
  * @unlinked: Set when the connector was unlinked from config->connectors
  *            by vkms_config_destroy_connector()
@@ -170,6 +174,7 @@ struct vkms_config_connector {
 
 	int type;
 	enum drm_connector_status status;
+	u32 supported_colorspaces;
 	struct xarray possible_encoders;
 	bool unlinked;
 
@@ -297,6 +302,31 @@ DEFINE_FREE(vkms_config_put, struct vkms_config *, if (_T) vkms_config_put(_T));
  */
 void vkms_config_destroy(struct vkms_config *config);
 
+/**
+ * vkms_config_connector_set_supported_colorspaces() - Set the supported colorspaces for a connector
+ * @connector_cfg: Connector configuration to modify
+ * @supported_colorspaces: Bitmask of supported colorspaces (DRM_MODE_COLORIMETRY_*)
+ */
+static inline void
+vkms_config_connector_set_supported_colorspaces(struct vkms_config_connector *connector_cfg,
+						u32 supported_colorspaces)
+{
+	connector_cfg->supported_colorspaces = supported_colorspaces;
+}
+
+/**
+ * vkms_config_connector_get_supported_colorspaces() - Get the supported colorspaces for a connector
+ * @connector_cfg: Connector configuration to query
+ *
+ * Returns:
+ * Bitmask of supported colorspaces (DRM_MODE_COLORIMETRY_*)
+ */
+static inline u32
+vkms_config_connector_get_supported_colorspaces(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->supported_colorspaces;
+}
+
 /**
  * vkms_config_get_device_name() - Return the name of the device
  * @config: Configuration to get the device name from
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 7264ca84f910..552d767c3976 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -76,6 +76,53 @@ static void vkms_connector_static_cfg_release(struct drm_device *dev, void *res)
 	vkms_config_connector_put(connector->cfg);
 }
 
+/**
+ * vkms_connector_init - Common initialization for all vkms connectors
+ *
+ * @connector - Already allocated connector
+ * @connector_cfg - Configuration to apply
+ *
+ * Returns: 0 on success, errno on error;
+ */
+static int __must_check vkms_connector_init(struct vkms_connector *connector,
+					    struct vkms_config_connector *connector_cfg)
+{
+	int ret = 0;
+
+	if (vkms_config_connector_get_supported_colorspaces(connector_cfg)) {
+		if (connector_cfg->type == DRM_MODE_CONNECTOR_HDMIA ||
+		    connector_cfg->type == DRM_MODE_CONNECTOR_HDMIB) {
+			ret = drm_mode_create_hdmi_colorspace_property(
+				&connector->base,
+				vkms_config_connector_get_supported_colorspaces(connector_cfg));
+			if (ret)
+				return ret;
+		} else if (connector_cfg->type == DRM_MODE_CONNECTOR_DisplayPort ||
+			   connector_cfg->type == DRM_MODE_CONNECTOR_eDP) {
+			ret = drm_mode_create_dp_colorspace_property(
+				&connector->base,
+				vkms_config_connector_get_supported_colorspaces(connector_cfg));
+			if (ret)
+				return ret;
+		}
+
+		if (connector_cfg->type == DRM_MODE_CONNECTOR_HDMIA ||
+		    connector_cfg->type == DRM_MODE_CONNECTOR_HDMIB ||
+		    connector_cfg->type == DRM_MODE_CONNECTOR_DisplayPort ||
+		    connector_cfg->type == DRM_MODE_CONNECTOR_eDP) {
+			ret = drm_connector_attach_colorspace_property(&connector->base);
+			if (ret) {
+				drm_property_destroy(connector->base.dev,
+						     connector->base.colorspace_property);
+				return ret;
+			}
+			drm_connector_attach_hdr_output_metadata_property(&connector->base);
+		}
+	}
+
+	return 0;
+}
+
 struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
 						  struct vkms_config_connector *connector_cfg)
 {
@@ -92,6 +139,10 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	ret = vkms_connector_init(connector, connector_cfg);
+	if (ret)
+		return ERR_PTR(ret);
+
 	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
 
 	connector->cfg = connector_cfg;

-- 
2.56.0

