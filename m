Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695A0606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=x0IFmX3/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B292111231B;
	Thu, 26 Nov 2026 11:29:17 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEF2C10E370
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:29:09 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 814184E41798;
 Thu, 26 Nov 2026 11:29:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5545C60237;
 Thu, 26 Nov 2026 11:29:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E7BE711E6B324; Thu, 26 Nov 2026 12:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692545; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=0pJvFzuu9ojDNs7HFde9fGkz6OigPV2HgpzXDv0JSfs=;
 b=x0IFmX3/Jrlb6OKQa+FRxQEAOztLnfcjybuKQ84nDRspB7EwBcGRwpOZ3tzfm8HfCOsgdQ
 Zk52GnWin6+JCmslFQO2ilQUdRof8IZQ/IMKGfkrGFN3M9W/8WydPqosV8PVqBDWZhxj78
 Q0j/mL53HX1DSIZ1NkrtfCvxhlzdTp+Oiwh1qPdeaRc0pHiXJIzUDIjqHKZwhhbIoysfDL
 SVsy4F5dSr403KmAExmkRyt3FAWNqUnnj9uKTXikNM8iV6ytYuUS0McscGZD28WRjYnviL
 iNal3anJCVXXBSAdBZTC+rEMf3ejnIJI/UlQ4P1FUIZC/71zIU7VfKa2/7rKIg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:28:44 +0100
Subject: [PATCH v7 01/43] drm/vkms: Lock the config dump against concurrent
 configfs changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-1-21194cda2468@bootlin.com>
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

The vkms_config debugfs dump iterates the configuration lists while
configfs can concurrently mutate or free them, which leads to a
use-after-free. Move the configuration lock into struct vkms_config and
run the dump under it.

Fixes: 64229b846a7e ("drm/vkms: Allow to attach connectors and encoders via configfs")
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c    | 74 +++++++++++++++++-------------
 drivers/gpu/drm/vkms/vkms_config.h    | 29 ++++++++++--
 drivers/gpu/drm/vkms/vkms_configfs.c  | 85 +++++++++++++++++++----------------
 drivers/gpu/drm/vkms/vkms_connector.c |  6 ++-
 4 files changed, 119 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index f9e30a4e5a3f..6699ddae7126 100644
--- a/drivers/gpu/drm/vkms/vkms_config.c
+++ b/drivers/gpu/drm/vkms/vkms_config.c
@@ -27,6 +27,7 @@ struct vkms_config *vkms_config_create(const char *dev_name)
 	INIT_LIST_HEAD(&config->crtcs);
 	INIT_LIST_HEAD(&config->encoders);
 	INIT_LIST_HEAD(&config->connectors);
+	mutex_init(&config->lock);
 
 	return config;
 }
@@ -130,6 +131,7 @@ void vkms_config_destroy(struct vkms_config *config)
 	list_for_each_entry_safe(connector_cfg, connector_tmp, &config->connectors, link)
 		vkms_config_destroy_connector(connector_cfg);
 
+	mutex_destroy(&config->lock);
 	kfree_const(config->dev_name);
 	kfree(config);
 }
@@ -348,28 +350,38 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct vkms_config_encoder *encoder_cfg;
 	struct vkms_config_connector *connector_cfg;
 
-	dev_name = vkms_config_get_device_name((struct vkms_config *)vkmsdev->config);
-	seq_printf(m, "dev_name=%s\n", dev_name);
-
-	vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
-		seq_puts(m, "plane:\n");
-		seq_printf(m, "\ttype=%d\n",
-			   vkms_config_plane_get_type(plane_cfg));
-	}
+	/*
+	 * The configuration lists are mutated by the configfs under the
+	 * configuration lock. Walk them under RCU instead: mutations use
+	 * list_{add,del}_rcu and free the objects after a grace period,
+	 * so this reader holds no lock and cannot block the configfs
+	 * paths (the disable path removes this file while holding the
+	 * lock, and the debugfs removal waits for this reader to drain).
+	 */
+	scoped_guard(rcu) {
+		dev_name = vkms_config_get_device_name((struct vkms_config *)vkmsdev->config);
+		seq_printf(m, "dev_name=%s\n", dev_name);
+
+		vkms_config_for_each_plane(vkmsdev->config, plane_cfg) {
+			seq_puts(m, "plane:\n");
+			seq_printf(m, "\ttype=%d\n",
+				   vkms_config_plane_get_type(plane_cfg));
+		}
 
-	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
-		seq_puts(m, "crtc:\n");
-		seq_printf(m, "\twriteback=%d\n",
-			   vkms_config_crtc_get_writeback(crtc_cfg));
-	}
+		vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
+			seq_puts(m, "crtc:\n");
+			seq_printf(m, "\twriteback=%d\n",
+				   vkms_config_crtc_get_writeback(crtc_cfg));
+		}
 
-	vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
-		seq_puts(m, "encoder\n");
+		vkms_config_for_each_encoder(vkmsdev->config, encoder_cfg)
+			seq_puts(m, "encoder\n");
 
-	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
-		seq_puts(m, "connector:\n");
-		seq_printf(m, "\tstatus=%s\n",
-			   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
+		vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
+			seq_puts(m, "connector:\n");
+			seq_printf(m, "\tstatus=%s\n",
+				   drm_get_connector_status_name(vkms_config_connector_get_status(connector_cfg)));
+		}
 	}
 
 	return 0;
@@ -398,7 +410,7 @@ struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *config)
 	vkms_config_plane_set_type(plane_cfg, DRM_PLANE_TYPE_OVERLAY);
 	xa_init_flags(&plane_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
-	list_add_tail(&plane_cfg->link, &config->planes);
+	list_add_tail_rcu(&plane_cfg->link, &config->planes);
 
 	return plane_cfg;
 }
@@ -407,8 +419,8 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_plane);
 void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
 {
 	xa_destroy(&plane_cfg->possible_crtcs);
-	list_del(&plane_cfg->link);
-	kfree(plane_cfg);
+	list_del_rcu(&plane_cfg->link);
+	kfree_rcu(plane_cfg, rcu);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);
 
@@ -456,7 +468,7 @@ struct vkms_config_crtc *vkms_config_create_crtc(struct vkms_config *config)
 	crtc_cfg->config = config;
 	vkms_config_crtc_set_writeback(crtc_cfg, false);
 
-	list_add_tail(&crtc_cfg->link, &config->crtcs);
+	list_add_tail_rcu(&crtc_cfg->link, &config->crtcs);
 
 	return crtc_cfg;
 }
@@ -474,8 +486,8 @@ void vkms_config_destroy_crtc(struct vkms_config *config,
 	vkms_config_for_each_encoder(config, encoder_cfg)
 		vkms_config_encoder_detach_crtc(encoder_cfg, crtc_cfg);
 
-	list_del(&crtc_cfg->link);
-	kfree(crtc_cfg);
+	list_del_rcu(&crtc_cfg->link);
+	kfree_rcu(crtc_cfg, rcu);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_crtc);
 
@@ -535,7 +547,7 @@ struct vkms_config_encoder *vkms_config_create_encoder(struct vkms_config *confi
 	encoder_cfg->config = config;
 	xa_init_flags(&encoder_cfg->possible_crtcs, XA_FLAGS_ALLOC);
 
-	list_add_tail(&encoder_cfg->link, &config->encoders);
+	list_add_tail_rcu(&encoder_cfg->link, &config->encoders);
 
 	return encoder_cfg;
 }
@@ -550,8 +562,8 @@ void vkms_config_destroy_encoder(struct vkms_config *config,
 		vkms_config_connector_detach_encoder(connector_cfg, encoder_cfg);
 
 	xa_destroy(&encoder_cfg->possible_crtcs);
-	list_del(&encoder_cfg->link);
-	kfree(encoder_cfg);
+	list_del_rcu(&encoder_cfg->link);
+	kfree_rcu(encoder_cfg, rcu);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_encoder);
 
@@ -600,7 +612,7 @@ struct vkms_config_connector *vkms_config_create_connector(struct vkms_config *c
 	connector_cfg->status = connector_status_connected;
 	xa_init_flags(&connector_cfg->possible_encoders, XA_FLAGS_ALLOC);
 
-	list_add_tail(&connector_cfg->link, &config->connectors);
+	list_add_tail_rcu(&connector_cfg->link, &config->connectors);
 
 	return connector_cfg;
 }
@@ -609,8 +621,8 @@ EXPORT_SYMBOL_IF_KUNIT(vkms_config_create_connector);
 void vkms_config_destroy_connector(struct vkms_config_connector *connector_cfg)
 {
 	xa_destroy(&connector_cfg->possible_encoders);
-	list_del(&connector_cfg->link);
-	kfree(connector_cfg);
+	list_del_rcu(&connector_cfg->link);
+	kfree_rcu(connector_cfg, rcu);
 }
 EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_connector);
 
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 56805b0c9b14..125273f67e7d 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -4,6 +4,8 @@
 #define _VKMS_CONFIG_H_
 
 #include <linux/list.h>
+#include <linux/rculist.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 
@@ -19,6 +21,8 @@
  * @crtcs: List of CRTCs configured for the device
  * @encoders: List of encoders configured for the device
  * @connectors: List of connectors configured for the device
+ * @lock: Protects the whole configuration (lists and item fields) against
+ *        concurrent access from the configfs, debugfs and DRM paths
  * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
  */
 struct vkms_config {
@@ -27,6 +31,7 @@ struct vkms_config {
 	struct list_head crtcs;
 	struct list_head encoders;
 	struct list_head connectors;
+	struct mutex lock;
 	struct vkms_device *dev;
 };
 
@@ -34,6 +39,7 @@ struct vkms_config {
  * struct vkms_config_plane
  *
  * @link: Link to the others planes in vkms_config
+ * @rcu: RCU head for deferred freeing of this object
  * @config: The vkms_config this plane belongs to
  * @type: Type of the plane. The creator of configuration needs to ensures that
  *        at least one primary plane is present.
@@ -45,6 +51,7 @@ struct vkms_config {
  */
 struct vkms_config_plane {
 	struct list_head link;
+	struct rcu_head rcu;
 	struct vkms_config *config;
 
 	enum drm_plane_type type;
@@ -59,6 +66,7 @@ struct vkms_config_plane {
  * struct vkms_config_crtc
  *
  * @link: Link to the others CRTCs in vkms_config
+ * @rcu: RCU head for deferred freeing of this object
  * @config: The vkms_config this CRTC belongs to
  * @writeback: If true, a writeback buffer can be attached to the CRTC
  * @crtc: Internal usage. This pointer should never be considered as valid.
@@ -68,6 +76,7 @@ struct vkms_config_plane {
  */
 struct vkms_config_crtc {
 	struct list_head link;
+	struct rcu_head rcu;
 	struct vkms_config *config;
 
 	bool writeback;
@@ -80,6 +89,7 @@ struct vkms_config_crtc {
  * struct vkms_config_encoder
  *
  * @link: Link to the others encoders in vkms_config
+ * @rcu: RCU head for deferred freeing of this object
  * @config: The vkms_config this CRTC belongs to
  * @possible_crtcs: Array of CRTCs that can be used with this encoder
  * @encoder: Internal usage. This pointer should never be considered as valid.
@@ -89,6 +99,7 @@ struct vkms_config_crtc {
  */
 struct vkms_config_encoder {
 	struct list_head link;
+	struct rcu_head rcu;
 	struct vkms_config *config;
 
 	struct xarray possible_crtcs;
@@ -101,6 +112,7 @@ struct vkms_config_encoder {
  * struct vkms_config_connector
  *
  * @link: Link to the others connector in vkms_config
+ * @rcu: RCU head for deferred freeing of this object
  * @config: The vkms_config this connector belongs to
  * @status: Status (connected, disconnected...) of the connector
  * @possible_encoders: Array of encoders that can be used with this connector
@@ -111,6 +123,7 @@ struct vkms_config_encoder {
  */
 struct vkms_config_connector {
 	struct list_head link;
+	struct rcu_head rcu;
 	struct vkms_config *config;
 
 	enum drm_connector_status status;
@@ -126,7 +139,9 @@ struct vkms_config_connector {
  * @plane_cfg: &struct vkms_config_plane pointer used as cursor
  */
 #define vkms_config_for_each_plane(config, plane_cfg) \
-	list_for_each_entry((plane_cfg), &(config)->planes, link)
+	list_for_each_entry_rcu((plane_cfg), &(config)->planes, link, \
+				      lockdep_is_held(&(config)->lock) || \
+				      !(config)->dev)
 
 /**
  * vkms_config_for_each_crtc - Iterate over the vkms_config CRTCs
@@ -134,7 +149,9 @@ struct vkms_config_connector {
  * @crtc_cfg: &struct vkms_config_crtc pointer used as cursor
  */
 #define vkms_config_for_each_crtc(config, crtc_cfg) \
-	list_for_each_entry((crtc_cfg), &(config)->crtcs, link)
+	list_for_each_entry_rcu((crtc_cfg), &(config)->crtcs, link, \
+				      lockdep_is_held(&(config)->lock) || \
+				      !(config)->dev)
 
 /**
  * vkms_config_for_each_encoder - Iterate over the vkms_config encoders
@@ -142,7 +159,9 @@ struct vkms_config_connector {
  * @encoder_cfg: &struct vkms_config_encoder pointer used as cursor
  */
 #define vkms_config_for_each_encoder(config, encoder_cfg) \
-	list_for_each_entry((encoder_cfg), &(config)->encoders, link)
+	list_for_each_entry_rcu((encoder_cfg), &(config)->encoders, link, \
+				      lockdep_is_held(&(config)->lock) || \
+				      !(config)->dev)
 
 /**
  * vkms_config_for_each_connector - Iterate over the vkms_config connectors
@@ -150,7 +169,9 @@ struct vkms_config_connector {
  * @connector_cfg: &struct vkms_config_connector pointer used as cursor
  */
 #define vkms_config_for_each_connector(config, connector_cfg) \
-	list_for_each_entry((connector_cfg), &(config)->connectors, link)
+	list_for_each_entry_rcu((connector_cfg), &(config)->connectors, link, \
+				      lockdep_is_held(&(config)->lock) || \
+				      !(config)->dev)
 
 /**
  * vkms_config_plane_for_each_possible_crtc - Iterate over the vkms_config_plane
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index af097967ca6f..6bb24f5835db 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -21,10 +21,9 @@ static bool is_configfs_registered;
  * @crtcs_group: Default subgroup of @group at "/config/vkms/crtcs"
  * @encoders_group: Default subgroup of @group at "/config/vkms/encoders"
  * @connectors_group: Default subgroup of @group at "/config/vkms/connectors"
- * @lock: Lock used to project concurrent access to the configuration attributes
- * @config: Protected by @lock. Configuration of the VKMS device
- * @enabled: Protected by @lock. The device is created or destroyed when this
- * option changes
+ * @config: Configuration of the VKMS device. Its @lock field protects it
+ * against concurrent access
+ * @enabled: The device is created or destroyed when this option changes
  */
 struct vkms_configfs_device {
 	struct config_group group;
@@ -33,7 +32,6 @@ struct vkms_configfs_device {
 	struct config_group encoders_group;
 	struct config_group connectors_group;
 
-	struct mutex lock;
 	struct vkms_config *config;
 	bool enabled;
 };
@@ -141,7 +139,7 @@ static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 
 	crtc = crtc_item_to_vkms_configfs_crtc(item);
 
-	scoped_guard(mutex, &crtc->dev->lock)
+	scoped_guard(mutex, &crtc->dev->config->lock)
 		writeback = vkms_config_crtc_get_writeback(crtc->config);
 
 	return sprintf(page, "%d\n", writeback);
@@ -158,7 +156,7 @@ static ssize_t crtc_writeback_store(struct config_item *item, const char *page,
 	if (kstrtobool(page, &writeback))
 		return -EINVAL;
 
-	scoped_guard(mutex, &crtc->dev->lock) {
+	scoped_guard(mutex, &crtc->dev->config->lock) {
 		if (crtc->dev->enabled)
 			return -EBUSY;
 
@@ -181,7 +179,7 @@ static void crtc_release(struct config_item *item)
 	struct mutex *lock;
 
 	crtc = crtc_item_to_vkms_configfs_crtc(item);
-	lock = &crtc->dev->lock;
+	lock = &crtc->dev->config->lock;
 
 	scoped_guard(mutex, lock) {
 		vkms_config_destroy_crtc(crtc->dev->config, crtc->config);
@@ -208,7 +206,7 @@ static struct config_group *make_crtc_group(struct config_group *group,
 
 	dev = child_group_to_vkms_configfs_device(group);
 
-	scoped_guard(mutex, &dev->lock) {
+	scoped_guard(mutex, &dev->config->lock) {
 		if (dev->enabled)
 			return ERR_PTR(-EBUSY);
 
@@ -253,7 +251,7 @@ static int plane_possible_crtcs_allow_link(struct config_item *src,
 	plane = plane_possible_crtcs_item_to_vkms_configfs_plane(src);
 	crtc = crtc_item_to_vkms_configfs_crtc(target);
 
-	scoped_guard(mutex, &plane->dev->lock) {
+	scoped_guard(mutex, &plane->dev->config->lock) {
 		if (plane->dev->enabled)
 			return -EBUSY;
 
@@ -272,7 +270,7 @@ static void plane_possible_crtcs_drop_link(struct config_item *src,
 	plane = plane_possible_crtcs_item_to_vkms_configfs_plane(src);
 	crtc = crtc_item_to_vkms_configfs_crtc(target);
 
-	scoped_guard(mutex, &plane->dev->lock)
+	scoped_guard(mutex, &plane->dev->config->lock)
 		vkms_config_plane_detach_crtc(plane->config, crtc->config);
 }
 
@@ -293,7 +291,7 @@ static ssize_t plane_type_show(struct config_item *item, char *page)
 
 	plane = plane_item_to_vkms_configfs_plane(item);
 
-	scoped_guard(mutex, &plane->dev->lock)
+	scoped_guard(mutex, &plane->dev->config->lock)
 		type = vkms_config_plane_get_type(plane->config);
 
 	return sprintf(page, "%u\n", type);
@@ -314,7 +312,7 @@ static ssize_t plane_type_store(struct config_item *item, const char *page,
 	    type != DRM_PLANE_TYPE_CURSOR)
 		return -EINVAL;
 
-	scoped_guard(mutex, &plane->dev->lock) {
+	scoped_guard(mutex, &plane->dev->config->lock) {
 		if (plane->dev->enabled)
 			return -EBUSY;
 
@@ -337,7 +335,7 @@ static void plane_release(struct config_item *item)
 	struct mutex *lock;
 
 	plane = plane_item_to_vkms_configfs_plane(item);
-	lock = &plane->dev->lock;
+	lock = &plane->dev->config->lock;
 
 	scoped_guard(mutex, lock) {
 		vkms_config_destroy_plane(plane->config);
@@ -364,7 +362,7 @@ static struct config_group *make_plane_group(struct config_group *group,
 
 	dev = child_group_to_vkms_configfs_device(group);
 
-	scoped_guard(mutex, &dev->lock) {
+	scoped_guard(mutex, &dev->config->lock) {
 		if (dev->enabled)
 			return ERR_PTR(-EBUSY);
 
@@ -415,7 +413,7 @@ static int encoder_possible_crtcs_allow_link(struct config_item *src,
 	encoder = encoder_possible_crtcs_item_to_vkms_configfs_encoder(src);
 	crtc = crtc_item_to_vkms_configfs_crtc(target);
 
-	scoped_guard(mutex, &encoder->dev->lock) {
+	scoped_guard(mutex, &encoder->dev->config->lock) {
 		if (encoder->dev->enabled)
 			return -EBUSY;
 
@@ -434,7 +432,7 @@ static void encoder_possible_crtcs_drop_link(struct config_item *src,
 	encoder = encoder_possible_crtcs_item_to_vkms_configfs_encoder(src);
 	crtc = crtc_item_to_vkms_configfs_crtc(target);
 
-	scoped_guard(mutex, &encoder->dev->lock)
+	scoped_guard(mutex, &encoder->dev->config->lock)
 		vkms_config_encoder_detach_crtc(encoder->config, crtc->config);
 }
 
@@ -454,7 +452,7 @@ static void encoder_release(struct config_item *item)
 	struct mutex *lock;
 
 	encoder = encoder_item_to_vkms_configfs_encoder(item);
-	lock = &encoder->dev->lock;
+	lock = &encoder->dev->config->lock;
 
 	scoped_guard(mutex, lock) {
 		vkms_config_destroy_encoder(encoder->dev->config, encoder->config);
@@ -480,7 +478,7 @@ static struct config_group *make_encoder_group(struct config_group *group,
 
 	dev = child_group_to_vkms_configfs_device(group);
 
-	scoped_guard(mutex, &dev->lock) {
+	scoped_guard(mutex, &dev->config->lock) {
 		if (dev->enabled)
 			return ERR_PTR(-EBUSY);
 
@@ -526,7 +524,7 @@ static ssize_t connector_status_show(struct config_item *item, char *page)
 
 	connector = connector_item_to_vkms_configfs_connector(item);
 
-	scoped_guard(mutex, &connector->dev->lock)
+	scoped_guard(mutex, &connector->dev->config->lock)
 		status = vkms_config_connector_get_status(connector->config);
 
 	return sprintf(page, "%u\n", status);
@@ -548,7 +546,7 @@ static ssize_t connector_status_store(struct config_item *item,
 	    status != connector_status_unknown)
 		return -EINVAL;
 
-	scoped_guard(mutex, &connector->dev->lock) {
+	scoped_guard(mutex, &connector->dev->config->lock) {
 		vkms_config_connector_set_status(connector->config, status);
 
 		if (connector->dev->enabled)
@@ -571,7 +569,7 @@ static void connector_release(struct config_item *item)
 	struct mutex *lock;
 
 	connector = connector_item_to_vkms_configfs_connector(item);
-	lock = &connector->dev->lock;
+	lock = &connector->dev->config->lock;
 
 	scoped_guard(mutex, lock) {
 		vkms_config_destroy_connector(connector->config);
@@ -602,7 +600,7 @@ static int connector_possible_encoders_allow_link(struct config_item *src,
 	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
 	encoder = encoder_item_to_vkms_configfs_encoder(target);
 
-	scoped_guard(mutex, &connector->dev->lock) {
+	scoped_guard(mutex, &connector->dev->config->lock) {
 		if (connector->dev->enabled)
 			return -EBUSY;
 
@@ -622,7 +620,7 @@ static void connector_possible_encoders_drop_link(struct config_item *src,
 	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
 	encoder = encoder_item_to_vkms_configfs_encoder(target);
 
-	scoped_guard(mutex, &connector->dev->lock) {
+	scoped_guard(mutex, &connector->dev->config->lock) {
 		vkms_config_connector_detach_encoder(connector->config,
 						     encoder->config);
 	}
@@ -647,7 +645,7 @@ static struct config_group *make_connector_group(struct config_group *group,
 
 	dev = child_group_to_vkms_configfs_device(group);
 
-	scoped_guard(mutex, &dev->lock) {
+	scoped_guard(mutex, &dev->config->lock) {
 		if (dev->enabled)
 			return ERR_PTR(-EBUSY);
 
@@ -693,7 +691,7 @@ static ssize_t device_enabled_show(struct config_item *item, char *page)
 
 	dev = device_item_to_vkms_configfs_device(item);
 
-	scoped_guard(mutex, &dev->lock)
+	scoped_guard(mutex, &dev->config->lock)
 		enabled = dev->enabled;
 
 	return sprintf(page, "%d\n", enabled);
@@ -711,21 +709,34 @@ static ssize_t device_enabled_store(struct config_item *item, const char *page,
 	if (kstrtobool(page, &enabled))
 		return -EINVAL;
 
-	scoped_guard(mutex, &dev->lock) {
-		if (!dev->enabled && enabled) {
-			if (!vkms_config_is_valid(dev->config))
-				return -EINVAL;
+	scoped_guard(mutex, &dev->config->lock) {
+		if (dev->enabled == enabled)
+			return (ssize_t)count;
 
-			ret = vkms_create(dev->config);
-			if (ret)
-				return ret;
-		} else if (dev->enabled && !enabled) {
-			vkms_destroy(dev->config);
-		}
+		if (!dev->enabled && !vkms_config_is_valid(dev->config))
+			return -EINVAL;
 
 		dev->enabled = enabled;
 	}
 
+	/*
+	 * Do not hold config->lock while creating/destroying the device:
+	 * vkms_destroy() unregisters the DRM device, which removes the
+	 * vkms_config debugfs file and waits for its readers to drain, and
+	 * vkms_connector_detect() takes config->lock to read the connector
+	 * status.
+	 */
+	if (enabled) {
+		ret = vkms_create(dev->config);
+		if (ret) {
+			scoped_guard(mutex, &dev->config->lock)
+				dev->enabled = false;
+			return ret;
+		}
+	} else {
+		vkms_destroy(dev->config);
+	}
+
 	return (ssize_t)count;
 }
 
@@ -745,7 +756,6 @@ static void device_release(struct config_item *item)
 	if (dev->enabled)
 		vkms_destroy(dev->config);
 
-	mutex_destroy(&dev->lock);
 	vkms_config_destroy(dev->config);
 	kfree(dev);
 }
@@ -781,7 +791,6 @@ static struct config_group *make_device_group(struct config_group *group,
 	}
 
 	config_group_init_type_name(&dev->group, name, &device_item_type);
-	mutex_init(&dev->lock);
 
 	config_group_init_type_name(&dev->planes_group, "planes",
 				    &plane_group_type);
diff --git a/drivers/gpu/drm/vkms/vkms_connector.c b/drivers/gpu/drm/vkms/vkms_connector.c
index 57138027966f..080a0240d5e9 100644
--- a/drivers/gpu/drm/vkms/vkms_connector.c
+++ b/drivers/gpu/drm/vkms/vkms_connector.c
@@ -27,8 +27,10 @@ static enum drm_connector_status vkms_connector_detect(struct drm_connector *con
 	status = connector->status;
 
 	vkms_config_for_each_connector(vkmsdev->config, connector_cfg) {
-		if (connector_cfg->connector == vkms_connector)
-			status = vkms_config_connector_get_status(connector_cfg);
+		if (connector_cfg->connector == vkms_connector) {
+			scoped_guard(mutex, &vkmsdev->config->lock)
+				status = vkms_config_connector_get_status(connector_cfg);
+		}
 	}
 
 	return status;

-- 
2.56.0

