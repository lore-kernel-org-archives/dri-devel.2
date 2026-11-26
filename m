Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED095606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=EvlrFSrB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A225C112355;
	Thu, 26 Nov 2026 11:32:51 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C266611230B
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:32:20 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 884704E41798;
 Thu, 26 Nov 2026 11:32:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 527D160237;
 Thu, 26 Nov 2026 11:32:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8F7D511E6B306; Thu, 26 Nov 2026 12:32:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ZHVX62wBRWW7xGq0GauMky9QTZyuhLqBMxJaaoGzdPk=;
 b=EvlrFSrBd0LsgaDyFMfEuvlgFmEpQy3dP3mEJd76n92o7YnxrQKzJ28rLaPtNBrNrrgeJ6
 2ilym5aia42TC9o5tHqg2aFxzoADEr8WJtrZan93Wjakhc+Fp5ZyntWCnQhmFqSlSoSE0x
 KlrCn7sRhMb+fDRlXEHeAMDn/aGdZLOhzorHHfdUwHDaBMp2e4OHu72zrZGvjSUCCyIZ7n
 fgWZIIYvD7ltD8I5RnwxKvTAnfR9k1ASNOWW6Iq2272FU8OIh4ul6U2VuVtY2ijw310mkF
 SLfoX5XC9kLJejQaWCYFSphdhAP/zQ+J7fxKId/LikZ0XiUJJKoq93tUUZlQ/g==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:13 +0100
Subject: [PATCH v7 30/43] drm/vkms: Introduce back pointer to connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-30-21194cda2468@bootlin.com>
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

Each connector now stores a pointer to its vkms_config_connector and
takes a reference on it when created, released through a drmm action on
device cleanup; detect() uses the back-pointer instead of walking the
configuration list.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_connector.c | 33 ++++++++++++++++++++++++---------
 drivers/gpu/drm/vkms/vkms_connector.h |  9 ++++++++-
 drivers/gpu/drm/vkms/vkms_output.c    |  2 +-
 3 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 080a0240d5e9..bb023b5af4e4 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -11,11 +11,9 @@
 static enum drm_connector_status vkms_connector_detect(struct drm_connector *connector,
 						       bool force)
 {
-	struct drm_device *dev = connector->dev;
-	struct vkms_device *vkmsdev = drm_device_to_vkms_device(dev);
 	struct vkms_connector *vkms_connector;
+	struct vkms_config_connector *cfg;
 	enum drm_connector_status status;
-	struct vkms_config_connector *connector_cfg;
 
 	vkms_connector = drm_connector_to_vkms_connector(connector);
 
@@ -26,11 +24,12 @@ static enum drm_connector_status vkms_connector_detect(struct drm_connector *con
 	 */
 	status = connector->status;
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
-		if (connector_cfg->connector == vkms_connector) {
-			scoped_guard(mutex, &vkmsdev->config->lock)
-				status = vkms_config_connector_get_status(connector_cfg);
-		}
+	cfg = vkms_connector->cfg;
+	if (cfg) {
+		cfg = vkms_config_connector_get(cfg);
+		scoped_guard(mutex, &cfg->config->lock)
+			status = vkms_config_connector_get_status(cfg);
+		vkms_config_connector_put(cfg);
 	}
 
 	return status;
@@ -70,7 +69,16 @@ static const struct drm_connector_helper_funcs vkms_conn_helper_funcs = {
 	.best_encoder = vkms_conn_best_encoder,
 };
 
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
+static void vkms_connector_static_cfg_release(struct drm_device *dev, void *res)
+{
+	struct vkms_connector *connector = res;
+
+	vkms_config_connector_put(connector->cfg);
+}
+
+
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
+					   struct vkms_config_connector *connector_cfg)
 {
 	struct drm_device *dev = &vkmsdev->drm;
 	struct vkms_connector *connector;
@@ -87,6 +95,13 @@ struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev)
 
 	drm_connector_helper_add(&connector->base, &vkms_conn_helper_funcs);
 
+	connector->cfg = connector_cfg;
+	vkms_config_connector_get(connector_cfg);
+	ret = drmm_add_action_or_reset(dev, vkms_connector_static_cfg_release,
+				       connector);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return connector;
 }
 
diff --git a/drivers/gpu/drm/vkms/vkms_connector.h b/drivers/gpu/drm/vkms/vkms_connector.h
index 52ae97af2bc1..89d7f3a15d6e 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.h
+++ b/drivers/gpu/drm/vkms/vkms_connector.h
@@ -4,6 +4,7 @@
 #define _VKMS_CONNECTOR_H_
 
 #include "vkms_drv.h"
+#include "vkms_config.h"
 
 #define drm_connector_to_vkms_connector(target) \
 	container_of(target, struct vkms_connector, base)
@@ -12,19 +13,25 @@
  * struct vkms_connector - VKMS custom type wrapping around the DRM connector
  *
  * @base: Base DRM connector
+ * @cfg: Configuration of the connector. A reference on it is taken at
+ *	 creation and released by a drmm action on device cleanup
  */
 struct vkms_connector {
 	struct drm_connector base;
+
+	struct vkms_config_connector *cfg;
 };
 
 /**
  * vkms_connector_init() - Initialize a connector
  * @vkmsdev: VKMS device containing the connector
+ * @connector_cfg: Connector's configuration
  *
  * Returns:
  * The connector or an error on failure.
  */
-struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev);
+struct vkms_connector *vkms_connector_init(struct vkms_device *vkmsdev,
+					   struct vkms_config_connector *connector_cfg);
 
 /**
  * vkms_trigger_connector_hotplug() - Update the device's connectors status
diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/vkms_output.c
index 982c6cd5fcc7..7783a2f6d343 100644
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
2.56.0

