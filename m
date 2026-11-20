Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B552606A333
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DqkDbP1X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6CD0112C8A;
	Fri, 20 Nov 2026 18:06:04 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 704CD112C79
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:05:51 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 36D474E41692;
 Fri, 20 Nov 2026 18:05:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 09F7A601B9;
 Fri, 20 Nov 2026 18:05:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9989511BC0990; Fri, 20 Nov 2026 19:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197948; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=+EMsf2c2qqJIRiJJyIlB1EE6oKKSu/Z9h3cl2M5rqi0=;
 b=DqkDbP1X5T4DTcno7pJh81OsSo9xGdxq0bjBCjvMr5MoBz9GLcrpeRQNa/+NR5LM+iWYzv
 DBLX/eZZM98EbE0QJsIbqKCnpvHPKl5qeje+wTphVlATchEwnVTyB4ptGJKsQlUGtJlfvC
 JyQalAP69lJ+1e71Mocdo3OKwDOpFa8yQY0FrzQZWdVgtt1RiSgB+Ryd9hRVXt7UBmBqnv
 cq60tzC7S6FOwSsVaPfaH9WMo1cCHJWozbl303SV2wp9EG+JrssAN6qia4kHlvAEKlSsVB
 Td91FKgnX3O3XZ9vPIRA3g087wC9X5shVYrVAkeJs88vPKVQbPli+h6cRCFWaQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:59:17 +0100
Subject: [PATCH v6 35/43] drm/vkms: Introduce config for connector
 supported colorspace
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-35-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8738;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=TrCXpuamax9LWCBRPOQBJ1+srnasha3RWanRdfumjyw=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIsCP6ggarFZPvl7EQupjcS4NRGjfE4uOl/FY
 IvKsCj2mH2JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCLAhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOKm9g//bsadM1LQ+sfi8f+Ju5nU4oH7QItrYZ/
 2evlLnPFpbEhYA/70FeKpNIxG9v2BGo31LIYRfbnXfcaX0BZtHkPEnCD0rFqENMDYzrCbf6JLj2
 v7MLK8K+9lArXENN0kpj+ntBga00NqcnG3o1UB0uCCFPAWsfI/kAPwGKOxzERpf7p5gSOh4j8LH
 EcDyGRdMzCW2xjQUkNQQk8Uzy8DRfw7FwlOU2c7aUSh5nnWaiQe9iKTR9WW/gt2Kg/R0S/kYGvr
 NA4Z8pYEVCkDknhYxfkk7Bl2th3yzeCAa3FfRRpjndy9asCIKqkZ0s/gqQdcQiVLQstmgVdfyoY
 lP8K6wR5/+3dtO+T/YQegO9z5vMgcVUMsfymr7szvv/M0UMibFWnTbhN1xqx9mj0OcE/LXqCc1n
 2GGlD0sWfpuutMgVPa0D4Vui2DnPbmxjjEcK2YjTl/I/omhI8FGvwZ86nvF7z02N5GZ72XqJMvU
 eLAlm0mkWagQpOA6tz+tTnIyFIXcAiC2A/hEoANxrg+C/ciRrnBiND7xui/yfB7OI+0XmR8IfNc
 rfW9rVEQt8ck+nbSzTcSg8kerDK0eNysYXptuBE2OQ3tBbkzK3h9vVcoaPqQs0nxZ1I0UzPsMT0
 CrEWjv6y+5kNDo+Y8a48Plve/0kXi3MqvVVwHyg+4ALwo+6Grh0U=
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
index 291c0330bc56..6c7110e6859b 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -470,6 +470,38 @@ static bool valid_connector_possible_encoders(const struct vkms_config *config)
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
@@ -547,6 +579,9 @@ bool vkms_config_is_valid(const struct vkms_config *config)
 	if (!valid_connector_possible_encoders(config))
 		return false;
 
+	if (!valid_connector_colorspaces(config))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_is_valid);
@@ -653,6 +688,10 @@ static int vkms_config_show(struct seq_file *m, void *data)
 				   vkms_config_connector_get_status(connector_cfg)));
 		seq_printf(m, "\ttype=%s\n",
 			   drm_get_connector_type_name(vkms_config_connector_get_type(connector_cfg)));
+		seq_puts(m, "\tsupported colorspaces=");
+		show_bitfield(m, vkms_config_connector_get_supported_colorspaces(connector_cfg),
+			      drm_get_colorspace_name);
+		seq_puts(m, "\n");
 	}
 
 	return 0;
@@ -987,6 +1026,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->config = config;
 	connector_cfg->status = connector_status_connected;
 	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
+	vkms_config_connector_set_supported_colorspaces(connector_cfg, 0);
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 	kref_init(&connector_cfg->refcnt);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 88429e01089b..c9fab0ba9f63 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -141,6 +141,10 @@ struct vkms_config_encoder {
  * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
  * @config: The vkms_config this connector belongs to
  * @status: Status (connected, disconnected...) of the connector
+ * @supported_colorspaces: Bitmask of all the supported colorspaces. Values
+ *                         are the sames as ones accepted by
+ *                         drm_mode_create_hdmi_colorspace_property() and
+ *                         drm_mode_create_dp_colorspace_property()
  * @possible_encoders: Array of encoders that can be used with this connector
  * @connector: Internal usage. This pointer should never be considered as valid.
  *             It can be used to store a temporary reference to a VKMS connector
@@ -153,6 +157,7 @@ struct vkms_config_connector {
 
 	int type;
 	enum drm_connector_status status;
+	u32 supported_colorspaces;
 	struct xarray possible_encoders;
 
 	/* Internal usage */
@@ -271,6 +276,31 @@ DEFINE_FREE(vkms_config_put, struct vkms_config *, if (_T) vkms_config_put(_T));
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
index 64d79b778551..2e6925ba50b8 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -75,6 +75,53 @@ static void vkms_connector_static_cfg_release(struct drm_device *dev, void *res)
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
@@ -91,6 +138,10 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
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

