Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544760A262D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=jT5uK86M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8C65112C56;
	Fri, 20 Nov 2026 18:03:55 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD840112C5C
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:03:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id A84A34E4168E;
 Fri, 20 Nov 2026 18:03:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 75942601B9;
 Fri, 20 Nov 2026 18:03:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 14C3F11BC08D7; Fri, 20 Nov 2026 19:03:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197821; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DwiRSRh5gEtvlqW0dzzCs/Wk8GHTeI9BSIT2uTN6bJs=;
 b=jT5uK86Me8Ae4QyvVeZKWBG7N93n0ytgWC1TMrfvatyrtERW71aCOlLAfXBum6JMhitE9t
 6fSDEqzTxDbd4VIOAl7oHGGY4RfJa031usTZKkLlLXIMpc/JscB8sjsDlxQTVDXOxIpyHj
 8DkkPk+rvHflgr6euv19Ax1p/LVJLTcMWO4y65l+bYNMioGkAiZVoQ8gl8qAB4ghLpvpx9
 BLRFAfIrY7XXXHjSTzk+RUy3cRgpwpHeE1hKyNsHisA6FxJ7DUfpjQ4K+nXwXj4M1dJS4O
 mDkr01mNq6js5Gffg/c27bKBlbPkajDHRSbc4lv/K1fZwnd/scj2cpkLFxScIQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:54 +0100
Subject: [PATCH v6 12/43] drm/vkms: Reference-count vkms_config and
 vkms_config_connector
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-12-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10009;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=fqjFoGMeqtYdyCoYfsEAUeEHOhGs+X+8/vNwSXbius0=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr+DWgnEZc6vdDJcRWVIOGv/7aW9QOyxI2bm
 AAAiiEmPz6JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLkFhAAgaALNjm0qBvo/M2LjwHbEjtzW1YNXZz
 GxJRa0WBjRXbSvH6TrpY7/7eOg/2xIszGkPwZt+livhMdWlqUlbxM0wxaYI0T7qU7EBDek9X+lb
 wDxmexToVuqMHunfAdDQV7NmsQ8Ztb5vbySxp0O77AVG3qBy/56RPS96NmTVY4xC+Tdum1Vigqx
 Dt/IXe6++jO1u8MFlc4X0Rf39wHS7Sf3oq8MIz7wHEMfsPfT3EZnJShw7+KLHaQ2v4BvI6isszt
 jv7EoZLisZ2pEcw5XLwyEpjScOoDtR5DN5ZbJZkCPALxbVHVr/MYMZQ1Q1xoVd2xLwLvQyKjXLn
 hQFNg6ncIIDGhwBHsXcAsNhqBwu+pHZ0xhqWsRz2hiHf3FCsXlCgfKWodpUb7jkPvoc0ZBxxmJN
 l7vfyFgJaRmko4VgIOJbBGbmgKdnv67LPooSd/ErVGGjhGdgibX1hiE7YAnSePNxvuyw3TgZZPt
 6sQoRgfHTpfmu4HCsQGRskLxEsQOQUAd9Ij7MZ6HKLd7Sgx8AiOs/SYcVe/J6iHKd3Dypp1j4vg
 m1Q43/6KT9HayYfO15qf6kzk9jlwW5A+7jh6xfoutRx/vlw806sqH/O+zJB3tLRcsA/OEFmRjve
 TVbEFp/gSSzKx2pjOWNnZb4WXf3scYG9gQDKPetbgt2au+Ue7UTo=
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

The configuration objects are referenced from places with independent
lifetimes: connectors keep a pointer to their vkms_config_connector, the
DRM device outlives the configfs view, and userspace can delete a
configfs directory while the device is still running. Freeing a
configuration when its configfs representation disappears can therefore
lead to use-after-free.

Add explicit get/put references to vkms_config and vkms_config_connector:
a configuration destroyed while still referenced is detached and kept
alive until its last reference is dropped.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c | 88 +++++++++++++++++++++++++++++++++++---
 drivers/gpu/drm/vkms/vkms_config.h | 41 +++++++++++++++++-
 drivers/gpu/drm/vkms/vkms_drv.c    |  7 ++-
 3 files changed, 128 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 71877651cb00..50cde689f482 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -9,6 +9,8 @@
 
 #include "vkms_config.h"
 
+static void vkms_config_connector_release(struct kref *ref);
+
 struct vkms_config *vkms_config_create(const char *dev_name)
 {
 	struct vkms_config *config;
@@ -27,6 +29,7 @@ struct vkms_config *vkms_config_create(const char *dev_name)
 	INIT_LIST_HEAD(&config->crtcs);
 	INIT_LIST_HEAD(&config->encoders);
 	INIT_LIST_HEAD(&config->connectors);
+	kref_init(&config->refcnt);
 	mutex_init(&config->lock);
 
 	return config;
@@ -112,8 +115,9 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_default_create);
 
-void vkms_config_destroy(struct vkms_config *config)
+static void vkms_config_release(struct kref *ref)
 {
+	struct vkms_config *config = container_of(ref, struct vkms_config, refcnt);
 	struct vkms_config_plane *plane_cfg, *plane_tmp;
 	struct vkms_config_crtc *crtc_cfg, *crtc_tmp;
 	struct vkms_config_encoder *encoder_cfg, *encoder_tmp;
@@ -128,13 +132,37 @@ void vkms_config_destroy(struct vkms_config *config)
 	list_for_each_entry_safe(encoder_cfg, encoder_tmp, &config->encoders, link)
 		vkms_config_destroy_encoder(config, encoder_cfg);
 
-	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connectors, link)
-		vkms_config_destroy_connector(connector_cfg);
+	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connectors, link) {
+		/*
+		 * The configuration is already being released and cannot be
+		 * pinned anymore: drop the initial reference directly. The
+		 * connector is still linked, so its release only unlinks it
+		 * without touching the configuration.
+		 */
+		vkms_config_connector_put(connector_cfg);
+	}
 
 	mutex_destroy(&config->lock);
 	kfree_const(config->dev_name);
 	kfree(config);
 }
+
+void vkms_config_get(struct vkms_config *config)
+{
+	kref_get(&config->refcnt);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_get);
+
+void vkms_config_put(struct vkms_config *config)
+{
+	kref_put(&config->refcnt, vkms_config_release);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_put);
+
+void vkms_config_destroy(struct vkms_config *config)
+{
+	vkms_config_put(config);
+}
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy);
 
 static bool valid_plane_number(const struct vkms_config *config)
@@ -610,6 +638,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->config = config;
 	connector_cfg->status = connector_status_connected;
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
+	kref_init(&connector_cfg->refcnt);
 
 	list_add_tail(&connector_cfg->link, &config->connectors);
 
@@ -617,12 +646,61 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
 
-void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
+static void vkms_config_connector_release(struct kref *ref)
 {
+	struct vkms_config_connector *connector_cfg =
+		container_of(ref, struct vkms_config_connector, refcnt);
 	xa_destroy(&connector_cfg->possible_encoders);
-	list_del(&connector_cfg->link);
+	if (list_empty(&connector_cfg->link)) {
+		/*
+		 * The connector was detached from the configuration by
+		 * vkms_config_destroy_connector() before its final put,
+		 * and that call pinned the configuration to keep it alive
+		 * while the connector still points to it; drop that
+		 * reference now that the last connector reference is gone.
+		 */
+		vkms_config_put(connector_cfg->config);
+	} else {
+		/*
+		 * The configuration is already being released and cannot be
+		 * pinned anymore: unlink the connector without touching the
+		 * configuration.
+		 */
+		list_del(&connector_cfg->link);
+	}
 	kfree(connector_cfg);
 }
+
+struct vkms_config_connector *vkms_config_connector_get(struct vkms_config_connector *connector_cfg)
+{
+	kref_get(&connector_cfg->refcnt);
+	return connector_cfg;
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_get);
+
+void vkms_config_connector_put(struct vkms_config_connector *connector_cfg)
+{
+	kref_put(&connector_cfg->refcnt, vkms_config_connector_release);
+}
+EXPORT_SYMBOL_IF_KUNIT(vkms_config_connector_put);
+
+void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
+{
+	/*
+	 * Pin the configuration and detach the connector before dropping
+	 * the initial reference: the release callback runs inside the put
+	 * when it is the last one, and would otherwise mutate the
+	 * configuration lists without holding config->lock, or free the
+	 * configuration while this call and its configfs caller still use
+	 * both. The pin is dropped again by the release when the connector
+	 * dies here; if it survives, it keeps the configuration alive until
+	 * the connector's final put.
+	 */
+	vkms_config_get(connector_cfg->config);
+	list_del_init(&connector_cfg->link);
+
+	vkms_config_connector_put(connector_cfg);
+}
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
 
 int __must_check vkms_config_connector_attach_encoder(struct vkms_config_connector *connector_cfg,
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 10604f7f37e1..de6a89819daf 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -3,8 +3,12 @@
 #ifndef _VKMS_CONFIG_H_
 #define _VKMS_CONFIG_H_
 
-#include <linux/list.h>
+#include <linux/cleanup.h>
+#include <linux/kref.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
+#include <linux/string.h>
+#include <linux/list.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 
@@ -32,6 +36,7 @@ struct vkms_config {
 	struct list_head connectors;
 	struct mutex lock;
 	struct vkms_device *dev;
+	struct kref refcnt;
 };
 
 /**
@@ -122,6 +127,8 @@ struct vkms_config_connector {
 
 	/* Internal usage */
 	struct vkms_connector *connector;
+
+	struct kref refcnt;
 };
 
 /**
@@ -211,6 +218,23 @@ struct vkms_config *vkms_config_default_create(bool enable_cursor,
 					       bool enable_overlay,
 					       bool enable_plane_pipeline);
 
+/**
+ * vkms_config_get() - Acquire a reference to a VKMS configuration
+ * @config: vkms_config to acquire a reference to
+ */
+void vkms_config_get(struct vkms_config *config);
+
+/**
+ * vkms_config_put() - Release a reference to a VKMS configuration
+ * @config: vkms_config to release the reference from
+ *
+ * When the last reference is released, the configuration and all its
+ * sub-components are freed.
+ */
+void vkms_config_put(struct vkms_config *config);
+
+DEFINE_FREE(vkms_config_put, struct vkms_config *, if (_T) vkms_config_put(_T));
+
 /**
  * vkms_config_destroy() - Free a VKMS configuration
  * @config: vkms_config to free
@@ -446,6 +470,21 @@ void vkms_config_encoder_detach_crtc(struct vkms_config_encoder *encoder_cfg,
  */
 struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *config);
 
+/**
+ * vkms_config_connector_get() - Acquire a reference to a connector configuration
+ * @connector_cfg: Connector configuration to acquire a reference to
+ */
+struct vkms_config_connector *
+vkms_config_connector_get(struct vkms_config_connector *connector_cfg);
+
+/**
+ * vkms_config_connector_put() - Release a reference to a connector configuration
+ * @connector_cfg: Connector configuration to release the reference from
+ *
+ * When the last reference is released, the connector configuration is freed.
+ */
+void vkms_config_connector_put(struct vkms_config_connector *connector_cfg);
+
 /**
  * vkms_config_destroy_connector() - Remove and free a connector configuration
  * @connector_cfg: Connector configuration to destroy
diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_drv.c
index 5a640b531d88..64c75b038869 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.c
+++ b/drivers/gpu/drm/vkms/vkms_drv.c
@@ -163,6 +163,9 @@ int vkms_create(struct vkms_config *config)
 	struct faux_device *fdev;
 	struct vkms_device *vkms_device;
 	const char *dev_name;
+	struct vkms_config *cfg __free(vkms_config_put) = config;
+
+	vkms_config_get(cfg);
 
 	dev_name = vkms_config_get_device_name(config);
 	fdev = faux_device_create(dev_name, NULL, NULL);
@@ -210,11 +213,11 @@ int vkms_create(struct vkms_config *config)
 		goto out_devres;
 
 	drm_client_setup(&vkms_device->drm, NULL);
-
 	return 0;
 
 out_devres:
 	devres_release_group(&fdev->dev, NULL);
+	config->dev = NULL;
 out_unregister:
 	faux_device_destroy(fdev);
 	return ret;
@@ -275,7 +278,7 @@ static void __exit vkms_exit(void)
 		return;
 
 	vkms_destroy(default_config);
-	vkms_config_destroy(default_config);
+	vkms_config_put(default_config);
 }
 
 module_init(vkms_init);

-- 
2.56.0

