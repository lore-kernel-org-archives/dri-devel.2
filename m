Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C93B8FA1FD7
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:50:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0262510EED2;
	Wed, 22 Apr 2026 16:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="JmBpMWtQ";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6072B10EED2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:50:04 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 1E881C5EF08;
 Wed, 22 Apr 2026 16:50:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3BE795FA8F;
 Wed, 22 Apr 2026 16:50:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D9F42104609C6; 
 Wed, 22 Apr 2026 18:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776876601; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ywbK2HV2rBEQPkwJrBhO61M7IBwez+H9/FL3w+0c7J0=;
 b=JmBpMWtQn+qbUs+h6OFIhRAzucxNfhVJQIHkxgbIS1VA28k3W6+xyrBTsDwbbMvsnthRfJ
 6Xd4zxZzjB87GCqG3Rw15zCRCaaRAORQJtj0jTxXmFWTT8gFUIXvFHvUEV8Wjns1Yo3Fce
 +ovdm3GJLqw1cWiFVYki4p2Ry1y85zIo7W1va5lYwIZVhtUKpezXDYSwK5Oinkefy2lWVr
 IF/McKgW7NZ7SmN5Sq4EwilcgM9ObHajPYckJT1z+LzzdGu1S/6GD4Pb/EreTOwN2Orrgi
 xnQtDtjP0+7x0NWkVHcL41WRZ4LEeDGx0OYAw4Av9RcnkhRGMjmHpD6f6bvpxQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 22 Apr 2026 18:48:23 +0200
Subject: [PATCH v4 26/37] drm/vkms: Introduce config for connector type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-vkms-all-config-v4-26-dbb52e9aadc3@bootlin.com>
References: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
In-Reply-To: <20260422-vkms-all-config-v4-0-dbb52e9aadc3@bootlin.com>
To: Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Melissa Wen <melissa.srw@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, jose.exposito89@gmail.com, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: victoria@system76.com, sebastian.wick@redhat.com, victoria@system76.com, 
 airlied@gmail.com, thomas.petazzoni@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>, 
 llvm@lists.linux.dev, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16-dev
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

In order to emulate connector-specific behavior, add connector type
configuration.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  5 +++++
 drivers/gpu/drm/vkms/vkms_config.c            |  3 +++
 drivers/gpu/drm/vkms/vkms_config.h            | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         |  5 +++--
 drivers/gpu/drm/vkms/vkms_connector.h         |  4 +++-
 drivers/gpu/drm/vkms/vkms_output.c            |  2 +-
 6 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
index 4a5899b8ccfd..1900cc79db2b 100644
--- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
+++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
@@ -137,6 +137,7 @@ static void vkms_config_test_default_config(struct kunit *test)
 	struct vkms_config *config;
 	struct vkms_config_plane *plane_cfg;
 	struct vkms_config_crtc *crtc_cfg;
+	struct vkms_config_connector *connector_cfg;
 	int n_primaries = 0;
 	int n_cursors = 0;
 	int n_overlays = 0;
@@ -211,6 +212,10 @@ static void vkms_config_test_default_config(struct kunit *test)
 
 	/* Connectors */
 	KUNIT_EXPECT_EQ(test, vkms_config_get_num_connectors(config), 1);
+	vkms_config_for_each_connector(config, connector_cfg) {
+		KUNIT_EXPECT_EQ(test, vkms_config_connector_get_type(connector_cfg),
+				DRM_MODE_CONNECTOR_VIRTUAL);
+	}
 
 	KUNIT_EXPECT_TRUE(test, vkms_config_is_valid(config));
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index c2b0c99b620f..209e5d5c3b45 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -602,6 +602,8 @@ static int vkms_config_show(struct seq_file *m, void *data)
 		seq_puts(m, "connector:\n");
 		seq_printf(m, "\tstatus=%s\n",
 			   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
+		seq_printf(m, "\ttype=%s\n",
+			   drm_get_connector_type_name(vkms_config_connector_get_type(connector_cfg)));
 	}
 
 	return 0;
@@ -934,6 +936,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 
 	connector_cfg->config = config;
 	connector_cfg->status = connector_status_connected;
+	vkms_config_connector_set_type(connector_cfg, DRM_MODE_CONNECTOR_VIRTUAL);
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index df2ec432a1af..1f0fbd2d62eb 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -129,6 +129,7 @@ struct vkms_config_encoder {
  * struct vkms_config_connector
  *
  * @link: Link to the others connector in vkms_config
+ * @type: Store the type of connector using DRM_MODE_CONNECTOR_* values
  * @config: The vkms_config this connector belongs to
  * @status: Status (connected, disconnected...) of the connector
  * @possible_encoders: Array of encoders that can be used with this connector
@@ -141,6 +142,7 @@ struct vkms_config_connector {
 	struct list_head link;
 	struct vkms_config *config;
 
+	int type;
 	enum drm_connector_status status;
 	struct xarray possible_encoders;
 
@@ -343,6 +345,28 @@ vkms_config_plane_set_default_pipeline(struct vkms_config_plane *plane_cfg,
 }
 
 /**
+ * vkms_config_connector_get_type() - Return the connector type
+ * @connector_cfg: Connector to get the type from
+ */
+static inline int
+vkms_config_connector_get_type(const struct vkms_config_connector *connector_cfg)
+{
+	return connector_cfg->type;
+}
+
+/**
+ * vkms_config_connector_set_type() - Set the connector type
+ * @connector_cfg: Connector to set the type to
+ * @type: New connector type
+ */
+static inline void
+vkms_config_connector_set_type(struct vkms_config_connector *connector_cfg,
+			       int type)
+{
+	connector_cfg->type = type;
+}
+
+/*
  * vkms_config_plane_get_default_rotation() - Get the default rotation for a plane
  * @plane_cfg: Plane to get the default rotation from
  *
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index b0a6b212d3f4..5a87dc2d4c63 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -68,7 +68,8 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.best_encoder = vkms_conn_best_encoder,
 };
 
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
+					   struct vkms_config_connector *connector_cfg)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_connector *connector;
@@ -79,7 +80,7 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
 		return ERR_PTR(-ENOMEM);
 
 	ret = drmm_connector_init(dev, &connector->base, &vkms_connector_funcs,
-				  DRM_MODE_CONNECTOR_VIRTUAL, NULL);
+				  vkms_config_connector_get_type(connector_cfg), NULL);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index ed312f4eff3a..33253d29b1cc 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -4,6 +4,7 @@
 #define _VKMS_CONNECTOR_H_
 
 #include "vkms_drv.h"
+#include "vkms_config.h"
 
 #define drm_connector_to_vkms_connector(target) \
 	container_of(target, struct vkms_connector, base)
@@ -24,7 +25,8 @@ struct vkms_connector {
  * Returns:
  * The connector or an error on failure.
  */
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
+					   struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_trigger_connector_hotplug() - Update the device's connectors status
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 86ce07a617f5..1288c8551bc8 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -97,7 +97,7 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		struct vkms_config_encoder *possible_encoder;
 		unsigned long idx = 0;
 
-		connector_cfg->connector = vkms_connector_init(vkmsdev);
+		connector_cfg->connector = vkms_connector_init(vkmsdev, connector_cfg);
 		if (IS_ERR(connector_cfg->connector)) {
 			DRM_ERROR("Failed to init connector\n");
 			return PTR_ERR(connector_cfg->connector);

-- 
2.54.0

