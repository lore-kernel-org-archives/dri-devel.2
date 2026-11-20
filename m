Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EA960A2618
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Q1Qg5SZe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D0D112AD4;
	Fri, 20 Nov 2026 18:02:25 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7A24112AE7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:02:18 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 17051C62222;
 Fri, 20 Nov 2026 18:02:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4BA0C601B9;
 Fri, 20 Nov 2026 18:02:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DEE5111BC0627; Fri, 20 Nov 2026 19:02:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795197730; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=P6AYD+bbvo1nJpzr3ZfTD/0ZeapDCF9Qn70g9hmYQyY=;
 b=Q1Qg5SZe2x0onzjQPP6mc2vasdbqBVcehCIYg9KQUIYe7vUefbu1IBxQ5Nu1nE9hulqoDn
 QlAnYJjimpeIr5QVM3bH2T5xBgNirirQogcIW3SjGx8gkXZrWTPscMkdyuvAk3HW07m2qz
 h7MhNBsBTfxDqyqiIuBtTE6H9luXHXJOmmNGpKv606Uu5j1B6hLCKpzr9+Hp9CbKVKGPqc
 2Vy6HLDNEnx3MZceM0Z4kqnDjaB19oG0/1vGDrnyuZVWaY2HA0/vod6fOi/ObHNinZZZic
 q79mUXk7FALBwDMbC7KL6yDCrlVsGt+zSC/LtXpVdSqqgdsMm/Sxw37C3Y4EQQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 20 Nov 2026 18:58:44 +0100
Subject: [PATCH v6 02/43] drm/vkms: Lock the config dump against concurrent
 configfs changes
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vkms-all-config-v6-2-78ace90f4fc1@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12208;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=3mEU4wfI03iW/8m7Gv5Culy275EHb1q24tvJ3uMvQUs=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBrAIr9NHwTdh1GNyO+y3NF9gHI9metlR8/8aewR
 JyrvVuSnhmJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCawCK/RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOIcyA//U5CADUnOk/vuJtl6JI6PNGwi2u1le0C
 Vxn00a+y4kvmTvn7txE0CABUu/50Ape/MwYeaolHe0FVHPyRL/3nHT2fTbR0PqZ5cOvpz8SnBU1
 KE++zutiBxIok+U66tLp2puYQT3ebUbFgCh+mpaumbIp+tkn3e6RYXYHwwMS4u0VWCFV1q9aPIG
 hpwjj1jw8bDMNUJ9K6KrI5B1EgX4nQkF35JHoZPkwXiXKqUc+CiuqrJbdVyfwfSrDZhC8IdMwwF
 a7JhAWqZVd7+j9Ugd7iFBKyDuMOb4iun48MjvG0x7pTVIzKFyQqdOqTizomLyrgjptEuguZM7X2
 +b2MPqO4zArWZs+x+wBtgRZ35/IAt6VN+Xn7ayhasW1OCBN9RccNytpsmvaYMljICOf8WwcTJTw
 hrvWJiPKBkEuhzUDVh3dyP7pxLEVmBmYG6VCemTRVu3RkiXljkqwdQ5pk6MR5MS8abw7Y2D/lwE
 NZ179YmWO9H8g3jtpARtgybK0rPlrBaozov8MJfy/wgvVe7geVy087DoPeAd2FaC9hzERkErQhL
 l9jMQ0j9sfaGZx0bgs/Hei0Wz0V4Ff0iieDsNTdtcQ4+I0lN8PyF1avQe6fVjdZf+cmB/fzng/9
 c2lj3GNMZmO2KJOYXYqF4avskic1fXHhjIrjflQBzcb2vvZ5K370=
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

The vkms_config debugfs dump iterates the configuration lists while
configfs can concurrently mutate or free them, which leads to a
use-after-free. Move the configuration lock into struct vkms_config and
run the dump under it.

Fixes: 13fc9b9745cc ("drm/vkms: Add and remove VKMS instances via configfs")
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_config.c   | 10 +++++++
 drivers/gpu/drm/vkms/vkms_config.h   |  4 +++
 drivers/gpu/drm/vkms/vkms_configfs.c | 54 +++++++++++++++++-------------------
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vkms_config.c
index 48c60930302f..71877651cb00 100644
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
@@ -347,6 +349,14 @@ static int vkms_config_show(struct seq_file *m, void *data)
 	struct vkms_config_crtc *crtc_cfg;
 	struct vkms_config_encoder *encoder_cfg;
 	struct vkms_config_connector *connector_cfg;
+	struct vkms_config *config = (struct vkms_config *)vkmsdev->config;
+
+	/*
+	 * The configuration lists and fields are concurrently mutated by
+	 * configfs (creation, removal, attribute stores); iterate under the
+	 * configuration lock to keep the iteration coherent.
+	 */
+	guard(mutex)(&config->lock);
 
 	dev_name = vkms_config_get_device_name((struct vkms_config *)vkmsdev->config);
 	seq_printf(m, "dev_name=%s\n", dev_name);
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 56805b0c9b14..10604f7f37e1 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -4,6 +4,7 @@
 #define _VKMS_CONFIG_H_
 
 #include <linux/list.h>
+#include <linux/mutex.h>
 #include <linux/types.h>
 #include <linux/xarray.h>
 
@@ -19,6 +20,8 @@
  * @crtcs: List of CRTCs configured for the device
  * @encoders: List of encoders configured for the device
  * @connectors: List of connectors configured for the device
+ * @lock: Protects the whole configuration (lists and item fields) against
+ *        concurrent access from the configfs, debugfs and DRM paths
  * @dev: Used to store the current VKMS device. Only set when the device is instantiated.
  */
 struct vkms_config {
@@ -27,6 +30,7 @@ struct vkms_config {
 	struct list_head crtcs;
 	struct list_head encoders;
 	struct list_head connectors;
+	struct mutex lock;
 	struct vkms_device *dev;
 };
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index 601e3f128c9f..707cf3578e2d 100644
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
 
 	return sprintf(page, "%u", type);
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
 
 	return sprintf(page, "%u", status);
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
@@ -711,7 +709,7 @@ static ssize_t device_enabled_store(struct config_item *item, const char *page,
 	if (kstrtobool(page, &enabled))
 		return -EINVAL;
 
-	scoped_guard(mutex, &dev->lock) {
+	scoped_guard(mutex, &dev->config->lock) {
 		if (!dev->enabled && enabled) {
 			if (!vkms_config_is_valid(dev->config))
 				return -EINVAL;
@@ -745,7 +743,6 @@ static void device_release(struct config_item *item)
 	if (dev->enabled)
 		vkms_destroy(dev->config);
 
-	mutex_destroy(&dev->lock);
 	vkms_config_destroy(dev->config);
 	kfree(dev);
 }
@@ -781,7 +778,6 @@ static struct config_group *make_device_group(struct config_group *group,
 	}
 
 	config_group_init_type_name(&dev->group, name, &device_item_type);
-	mutex_init(&dev->lock);
 
 	config_group_init_type_name(&dev->planes_group, "planes",
 				    &plane_group_type);

-- 
2.56.0

