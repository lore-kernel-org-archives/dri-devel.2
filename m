Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091D5606A33E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=du+7RZIT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 639E5112362;
	Thu, 26 Nov 2026 11:33:42 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40CE5112358
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:33:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 1316B1A1808;
 Thu, 26 Nov 2026 11:33:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id DB23160237;
 Thu, 26 Nov 2026 11:33:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EFBCA11E6B324; Thu, 26 Nov 2026 12:33:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692791; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=vdq4+yIT10zCjA12KGC+zQ5W30iZRMt1TieO3JSus38=;
 b=du+7RZITEBbS/n41n2WsWw4B6DVOFzm0fBTQ6rJV2njyc5ZjQ1nC/qbYE35VUA4QUXViWs
 D5V91ccPOf6AlppraIoif0baPNQRqG1xHNEG+TtUBMosgGgdCa3Obu1xZRR1+sxV9bmjj7
 IctxHNwOt0qYU1vmYgUTzNXFE5BC5tlHbNDK+YIpzgsqe65ScbXw8CLKoHVGNuIDmdoQAb
 +Mo5WWTZAB1mar9qMcgWjd4mGkO4kwnwyTKme3bZRZ70rbNR/8Lr1pXLjYroLYY279IabP
 iikf6WFNx57pexfKJLHG6Rv2nKnDtSg1UlzVe9kq4txcpFzeqmUghSg57CzZqg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:23 +0100
Subject: [PATCH v7 40/43] drm/vkms: Allow to hot-add connectors
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-vkms-all-config-v7-40-21194cda2468@bootlin.com>
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

In order to allow creating dynamic connectors, add the required
infrastructure in vkms_connector.

A dynamic connector creates its own initial atomic state before being
registered. The hot-add and hot-remove paths are serialized with
mode_config.mutex, which drm_mode_getconnector() holds for the whole
duration of a probe, so probes never observe intermediate states.
Hot-remove only detaches the cfg->connector back-pointer, keeping the
configuration reference until the connector is destroyed, and
vkms_connector_dynamic_destroy() releases it. Attaching an encoder at
runtime (vkms_connector_hot_attach_encoder()) only updates the
connector's possible_encoders mask.

Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c  |   5 ++
 drivers/gpu/drm/vkms/vkms_connector.c | 138 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_connector.h |  40 ++++++++++
 drivers/gpu/drm/vkms/vkms_output.c    |  15 +++-
 4 files changed, 197 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 32ac4d7c4194..1822978879ff 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1358,6 +1358,11 @@ static void connector_possible_encoders_drop_link(struct config_item *src,
 	encoder = encoder_item_to_vkms_configfs_encoder(target);
 
 	scoped_guard(mutex, &connector->dev->config->lock) {
+		if (connector->dev->enabled && connector->config->dynamic &&
+		    connector->config->enabled && connector->config->connector)
+			vkms_connector_hot_detach_encoder(connector->config->connector,
+							  encoder->config->encoder);
+
 		vkms_config_connector_detach_encoder(connector->config,
 						     encoder->config);
 	}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 71a0ae15be65..93bceba0a1ae 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -149,6 +149,7 @@ static int __must_check vkms_connector_init(struct vkms_connector *connector,
 			if (ret) {
 				drm_property_destroy(connector->base.dev,
 						     connector->base.colorspace_property);
+				connector->base.colorspace_property = NULL;
 				return ret;
 			}
 			drm_connector_attach_hdr_output_metadata_property(&connector->base);
@@ -197,9 +198,146 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
 	return connector;
 }
 
+static void vkms_connector_dynamic_destroy(struct drm_connector *connector)
+{
+	struct vkms_connector *vkms_connector = drm_connector_to_vkms_connector(connector);
+
+	if (connector->colorspace_property) {
+		drm_property_destroy(connector->dev,
+				     connector->colorspace_property);
+		connector->colorspace_property = NULL;
+	}
+
+	drm_connector_cleanup(connector);
+
+	if (vkms_connector->cfg)
+		vkms_config_connector_put(vkms_connector->cfg);
+	kfree(vkms_connector);
+}
+
+static const struct drm_connector_funcs vkms_dynamic_connector_funcs = {
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.destroy = vkms_connector_dynamic_destroy,
+	.detect = vkms_connector_detect,
+};
+
 void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 
 	drm_kms_helper_hotplug_event(dev);
 }
+
+struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
+					      struct vkms_config_connector *connector_cfg)
+{
+	struct vkms_config_encoder *encoder_cfg;
+	struct vkms_connector *connector = NULL;
+	struct drm_connector_state *conn_state;
+	int ret;
+	unsigned long idx = 0;
+
+	connector = kzalloc_obj(*connector, GFP_KERNEL);
+	if (!connector)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drm_connector_dynamic_init(&vkmsdev->drm,
+					 &connector->base,
+					 &vkms_dynamic_connector_funcs,
+					 connector_cfg->type,
+					 NULL);
+	if (ret) {
+		kfree(connector);
+		return ERR_PTR(ret);
+	}
+
+	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
+
+	vkms_config_connector_for_each_possible_encoder(connector_cfg, idx, encoder_cfg) {
+		ret = drm_connector_attach_encoder(&connector->base,
+						   encoder_cfg->encoder);
+		if (ret) {
+			drm_connector_put(&connector->base);
+			return ERR_PTR(ret);
+		}
+	}
+
+	conn_state = drm_atomic_helper_connector_create_state(&connector->base);
+	if (IS_ERR(conn_state)) {
+		drm_connector_put(&connector->base);
+		return ERR_CAST(conn_state);
+	}
+	connector->base.state = conn_state;
+
+	ret = vkms_connector_init(connector, connector_cfg);
+	if (ret) {
+		drm_connector_put(&connector->base);
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * Attach the configuration before registration and serialize the
+	 * registration with in-flight probes: drm_mode_getconnector() holds
+	 * dev->mode_config.mutex for the whole duration of the probe and the
+	 * detect()/get_modes() callbacks read connector->cfg. Registering
+	 * under the same mutex prevents a probe from observing the new
+	 * connector before it is fully set up.
+	 */
+	vkms_config_connector_get(connector_cfg);
+	connector->cfg = connector_cfg;
+
+	mutex_lock(&connector->base.dev->mode_config.mutex);
+	ret = drm_connector_dynamic_register(&connector->base);
+	mutex_unlock(&connector->base.dev->mode_config.mutex);
+
+	if (ret) {
+		drm_connector_put(&connector->base);
+		return ERR_PTR(ret);
+	}
+
+	return connector;
+}
+
+void vkms_connector_hot_remove(struct vkms_connector *connector)
+{
+	/*
+	 * Userspace probes are serialized by mode_config.mutex:
+	 * drm_mode_getconnector() holds it for the whole duration of the
+	 * probe and the detect()/get_modes() callbacks read the connector
+	 * state, including connector->cfg. Take the same mutex here so the
+	 * unregistration and the config detachment are not visible in the
+	 * middle of an in-flight probe.
+	 */
+	mutex_lock(&connector->base.dev->mode_config.mutex);
+
+	drm_connector_unregister(&connector->base);
+
+	/*
+	 * Only detach the config from the connector: in-flight userspace
+	 * probes may still be reading connector->cfg (see vkms_connector_detect()
+	 * and vkms_conn_get_modes()), so the reference taken in
+	 * vkms_connector_hot_add() must be kept until the connector is
+	 * finally destroyed. vkms_connector_dynamic_destroy() releases it.
+	 */
+	if (connector->cfg)
+		connector->cfg->connector = NULL;
+
+	mutex_unlock(&connector->base.dev->mode_config.mutex);
+
+	drm_connector_put(&connector->base);
+}
+
+int vkms_connector_hot_attach_encoder(struct vkms_connector *connector,
+				      struct drm_encoder *encoder)
+{
+	return drm_connector_attach_encoder(&connector->base, encoder);
+}
+
+int vkms_connector_hot_detach_encoder(struct vkms_connector *connector,
+				      struct drm_encoder *encoder)
+{
+	return drm_connector_detach_encoder(&connector->base, encoder);
+}
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 61a8dd55d7f7..83b5b32b42de 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -39,4 +39,44 @@ struct vkms_connector *vkms_connector_init_static(struct vkms_device *vkmsdev,
  */
 void vkms_trigger_connector_hotplug(struct vkms_device *vkmsdev);
 
+/**
+ * vkms_connector_hot_add() - Create a connector after the device is created
+ * @vkmsdev: Device to hot-add the connector to
+ * @connector_cfg: Connector's configuration
+ *
+ * Returns:
+ * A pointer to the newly created connector or a PTR_ERR on failure.
+ */
+struct vkms_connector *vkms_connector_hot_add(struct vkms_device *vkmsdev,
+					      struct vkms_config_connector *connector_cfg);
+
+/**
+ * vkms_connector_hot_remove() - Remove a connector after a device is created
+ * @connector: The connector to hot-remove
+ */
+void vkms_connector_hot_remove(struct vkms_connector *connector);
+
+/**
+ * vkms_connector_hot_attach_encoder() - Attach a connector to a encoder after
+ * the device is created.
+ * @connector: Connector to attach to @encoder
+ * @encoder: Target encoder
+ *
+ * Returns:
+ * 0 on success or an error on failure.
+ */
+int vkms_connector_hot_attach_encoder(struct vkms_connector *connector,
+				      struct drm_encoder *encoder);
+
+/**
+ * vkms_connector_hot_detach_encoder() - Detach an encoder from a connector
+ * after the device is created.
+ * @connector: Connector to detach from @encoder
+ * @encoder: Target encoder
+ *
+ * Returns: 0 on success, negative errno on failure.
+ */
+int vkms_connector_hot_detach_encoder(struct vkms_connector *connector,
+				      struct drm_encoder *encoder);
+
 #endif /* _VKMS_CONNECTOR_H_ */
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index fb30cffc10ef..b100ed0c91e6 100644
--- a/drivers/gpu/drm/vkms/vkms_output.c
+++ b/drivers/gpu/drm/vkms/vkms_output.c
@@ -115,5 +115,18 @@ int vkms_output_init(struct vkms_device *vkmsdev)
 		}
 	}
 
-	return drm_mode_config_create_initial_state(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
+
+	vkms_config_for_each_connector_dynamic(vkmsdev->config, connector_cfg) {
+		if (connector_cfg->enabled) {
+			connector_cfg->connector = vkms_connector_hot_add(vkmsdev, connector_cfg);
+
+			if (IS_ERR(connector_cfg->connector))
+				return PTR_ERR(connector_cfg->connector);
+		}
+	}
+
+	return 0;
 }

-- 
2.56.0

