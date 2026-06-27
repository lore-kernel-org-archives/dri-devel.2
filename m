Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC15C43211
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B269C10F74A;
	Sat, 27 Jun 2026 03:32:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="jCfKH6Kj";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3256410F680
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:32:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 03BAA1A0A23;
 Sat, 27 Jun 2026 03:32:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CC5C460233;
 Sat, 27 Jun 2026 03:32:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5BCEC106F1172; 
 Sat, 27 Jun 2026 05:32:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531136; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=6gnb/UaTe/iqU91lXxm2Q2SXLtYDyf1mjuCvN6WD1Ys=;
 b=jCfKH6KjCktl2NtwTciOgqnPRQC4KU8yYFAyz9go8nEk49I5tQ3DMBclW9wFyth8KmNv70
 VAivmLsAWN9RiO0DkR1Zp808f5poc0RJivs4YAzXkF0RJP04HSSOsOfKJDlJ2LnTNhlx77
 YcnL1PBzyn0788ADHLzJCQwpD1FJ9JA7Fqp2+MvS4NancaaaSoqjrXRWfZe83TvFjUgTe2
 2oJ00BUg+Jo9ia7tIPncGbrJldW4ULQsTWaviZDBJBC34/b/2gqnLq17IdhVptEARyUzSX
 pKfnB4MyNLLIvmZ0Jx1W6CPsiC/x64KAtXnC0oy33oD520yH3RXxcBcB/jLVWg==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:53 +0200
Subject: [PATCH v5 36/38] drm/vkms: Introduce configfs for dynamic
 connector creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260627-vkms-all-config-v5-36-854aa0840926@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10758;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=rUkelz8olDDj+nzfUbh7iTwV3qWndTKVfpdkxxxyzRc=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PiVMkMAep2XKav6wxLl6NuiGuJjmX6Nu0F0
 jux4KOAgN6JAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D4hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLrQRAAvn8VHBd+/5P14Vukx20AzDB7T7zzNrY
 KBEZt7wjDeNgnlgKyHMD3/pE7SSyNd80UTSCOBHIRDug++zyMoJ/wwm9AvgtkLHD5w42Q9JDiB7
 txbPkhDiNePYdDu1xxwrh3LqntorLikb3RrllCCWj/dZEG+2DJexTF6Q+ZqW91VYbiy7KSjrO5Z
 kYnov/4bUU4HR9eMntGFmdDikwni5rNdHbwX/3qUeq/o9WmzSL6r6GbTOXuTooUwE7/FCBdpCKu
 eG15ne2z0vHL/20Zcz9Cw3Zob7srJ6Z+qYVBnakLDV/YUw4Rpd2cpTJIUgpuOUOYbZ5eHqS4Flb
 4ksP0pHKvvljWYoZ+4mRUETx8hpWPKlpisrpUhc1vozQ+sWOyacFu/PixiR22iBPP4TH8UkYD6X
 StMiKB0Vs+kGUtVYOaxVVeuwq5CrbaOcuNu7XaEIkd0c5prv7jL+GBAYIbK4pS9u2V+W4TGjlM2
 h8nw7eW1M0UNIJueENT/esizZowpCucuVLpXz09prLxfoUNFOz9bkSc2p6LUsc9JjBcWIngf69j
 NeG3VAVfCJTO/lvCxK1ZAkAyFCDdqKuXG9KXbgzx+R3IpXcIuZcvN3qjl5ar+VMzcjavbO50a9m
 46Ps5ckbWWCmp7I2u5kgeXzVNo3ITac61GvJMcMV7/igzXRRh6nw=
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

DRM allows the connector to be created after the device. To allows
emulating this, add two configfs attributes to connector to allows this.

Using the dynamic attribute you can set if a connector will be dynamic or
not.
Using the enabled attribute, you can set at runtime if a dynamic connector
is present or not.

Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms |  14 ++++
 Documentation/gpu/vkms.rst              |   6 +-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 144 ++++++++++++++++++++++++++++++--
 3 files changed, 155 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 04e2f89e3129..8a5899c52e78 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -62,6 +62,20 @@ Description:
 	Content of the EDID for this connector. Ignored if
 	edid_enabled is not set.
 
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/dynamic
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Set to 1 to create a dynamic connector (emulates DP MST).
+	Value: 1 - dynamic, 0 - static.
+
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/enabled
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	For dynamic connectors, set to 1 to create the connector,
+	0 to remove it. Value: 1 - enabled, 0 - disabled.
+
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/possible_encoders
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 2a3e175bf67b..31569421d8f5 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -137,7 +137,7 @@ Last but not least, create one or more connectors::
 
   sudo mkdir /config/vkms/my-vkms/connectors/connector0
 
-Connectors have 5 configurable attribute:
+Connectors have 7 configurable attribute:
 
 - status: Connection status: 1 connected, 2 disconnected, 3 unknown (same values
   as those exposed by the "status" property of a connector)
@@ -149,7 +149,9 @@ Connectors have 5 configurable attribute:
 - edid_enabled: Enable or not EDID for this connector. Some connectors may not have an
   EDID but just a list of modes, this attribute allows to disable EDID property.
 - edid: Content of the EDID. Ignored if edid_enabled is not set
-
+- dynamic: Set to 1 while configuring the device to create a dynamic connector. A dynamic
+  connector can be used to emulate DP MST connectors.
+- enabled: For dynamic connector, set it to 1 to create the connector, 0 to remove it.
 
 To finish the configuration, link the different pipeline items::
 
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index f79a796c2017..f92b172e75cf 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1091,6 +1091,12 @@ static ssize_t connector_status_show(struct config_item *item, char *page)
 	return sprintf(page, "%u", status);
 }
 
+static bool connector_is_enabled(struct vkms_config_connector *connector_cfg)
+{
+	return !connector_cfg->dynamic ||
+	       (connector_cfg->dynamic && connector_cfg->enabled);
+}
+
 static ssize_t connector_status_store(struct config_item *item,
 				      const char *page, size_t count)
 {
@@ -1110,7 +1116,7 @@ static ssize_t connector_status_store(struct config_item *item,
 	scoped_guard(mutex, &connector->dev->lock) {
 		vkms_config_connector_set_status(connector->config, status);
 
-		if (connector->dev->enabled)
+		if (connector->dev->enabled && connector_is_enabled(connector->config))
 			vkms_trigger_connector_hotplug(connector->dev->config->dev);
 	}
 
@@ -1171,7 +1177,7 @@ static ssize_t connector_type_store(struct config_item *item,
 	}
 
 	scoped_guard(mutex, &connector->dev->lock) {
-		if (connector->dev->enabled)
+		if (connector->dev->enabled && connector_is_enabled(connector->config))
 			return -EBUSY;
 
 		vkms_config_connector_set_type(connector->config, val);
@@ -1290,6 +1296,107 @@ static ssize_t connector_edid_store(struct config_item *item,
 		    connector_status_disconnected)
 			vkms_trigger_connector_hotplug(connector->dev->config->dev);
 	}
+	return count;
+}
+
+static ssize_t connector_enabled_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		enabled = vkms_config_connector_is_enabled(connector->config);
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t connector_enabled_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	bool enabled, was_enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
+
+	if (kstrtobool(page, &enabled))
+		return -EINVAL;
+	scoped_guard(mutex, &connector->dev->lock) {
+		if (!connector->dev->enabled) {
+			vkms_config_connector_set_enabled(connector_cfg, enabled);
+		} else {
+			// Only dynamic connector can be enabled/disabled at runtime
+			if (!connector_cfg->dynamic)
+				return -EBUSY;
+
+			was_enabled = vkms_config_connector_is_enabled(connector_cfg);
+			vkms_config_connector_set_enabled(connector_cfg, enabled);
+
+			// Resulting configuration is invalid (missing encoder for example)
+			// Early return to avoid drm core issue
+			if (!vkms_config_is_valid(connector->dev->config)) {
+				count = -EINVAL;
+				goto rollback;
+			}
+
+			if (!was_enabled && enabled) {
+				// Adding the connector
+				connector_cfg->connector = vkms_connector_hot_add(connector->dev->config->dev,
+										  connector_cfg);
+				if (IS_ERR(connector_cfg->connector)) {
+					count = PTR_ERR(connector_cfg->connector);
+					goto rollback;
+				}
+			} else if (was_enabled && !enabled) {
+				vkms_connector_hot_remove(connector->dev->config->dev,
+							  connector_cfg->connector);
+			}
+		}
+	}
+	return count;
+
+rollback:
+	vkms_config_connector_set_enabled(connector_cfg, was_enabled);
+	return count;
+}
+
+static ssize_t connector_dynamic_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	bool enabled;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		enabled = vkms_config_connector_is_dynamic(connector->config);
+	}
+
+	return sprintf(page, "%d\n", enabled);
+}
+
+static ssize_t connector_dynamic_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	bool dynamic;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
+
+	if (kstrtobool(page, &dynamic))
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->lock) {
+		// Can't change the dynamic status when the device is activated
+		if (connector->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_connector_set_dynamic(connector_cfg, dynamic);
+	}
 
 	return count;
 }
@@ -1299,6 +1406,8 @@ CONFIGFS_ATTR(connector_, type);
 CONFIGFS_ATTR(connector_, supported_colorspaces);
 CONFIGFS_ATTR(connector_, edid_enabled);
 CONFIGFS_ATTR(connector_, edid);
+CONFIGFS_ATTR(connector_, dynamic);
+CONFIGFS_ATTR(connector_, enabled);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
@@ -1306,19 +1415,28 @@ static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_supported_colorspaces,
 	&connector_attr_edid_enabled,
 	&connector_attr_edid,
+	&connector_attr_dynamic,
+	&connector_attr_enabled,
 	NULL,
 };
 
 static void connector_release(struct config_item *item)
 {
 	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
 	struct mutex *lock;
 
 	connector = connector_item_to_vkms_configfs_connector(item);
+	connector_cfg = connector->config;
 	lock = &connector->dev->lock;
 
 	scoped_guard(mutex, lock) {
+		if (connector->dev->enabled && connector_cfg->dynamic && connector_cfg->enabled)
+			vkms_connector_hot_remove(connector->dev->config->dev,
+						  connector_cfg->connector);
+
 		vkms_config_destroy_connector(connector->config);
+
 		kfree(connector);
 	}
 }
@@ -1337,6 +1455,7 @@ static int connector_possible_encoders_allow_link(struct config_item *src,
 						  struct config_item *target)
 {
 	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
 	struct vkms_configfs_encoder *encoder;
 	int ret;
 
@@ -1344,14 +1463,25 @@ static int connector_possible_encoders_allow_link(struct config_item *src,
 		return -EINVAL;
 
 	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	connector_cfg = connector->config;
 	encoder = encoder_item_to_vkms_configfs_encoder(target);
 
 	scoped_guard(mutex, &connector->dev->lock) {
-		if (connector->dev->enabled)
-			return -EBUSY;
+		if (connector->dev->enabled && connector_cfg->enabled) {
+			if (!connector_cfg->dynamic)
+				return -EBUSY;
+
+			ret = vkms_connector_hot_attach_encoder(connector->dev->config->dev,
+								connector->config->connector,
+								encoder->config->encoder);
+			if (ret)
+				return ret;
+		}
 
 		ret = vkms_config_connector_attach_encoder(connector->config,
 							   encoder->config);
+		if (ret)
+			return ret;
 	}
 
 	return ret;
@@ -1392,9 +1522,6 @@ static struct config_group *make_connector_group(struct config_group *group,
 	dev = child_group_to_vkms_configfs_device(group);
 
 	scoped_guard(mutex, &dev->lock) {
-		if (dev->enabled)
-			return ERR_PTR(-EBUSY);
-
 		connector = kzalloc(sizeof(*connector), GFP_KERNEL);
 		if (!connector)
 			return ERR_PTR(-ENOMEM);
@@ -1408,6 +1535,9 @@ static struct config_group *make_connector_group(struct config_group *group,
 			return ERR_PTR(ret);
 		}
 
+		vkms_config_connector_set_dynamic(connector->config, connector->dev->enabled);
+		vkms_config_connector_set_enabled(connector->config, !connector->dev->enabled);
+
 		config_group_init_type_name(&connector->group, name,
 					    &connector_item_type);
 

-- 
2.54.0

