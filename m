Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF380606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=yABlbYl5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C0D11235B;
	Thu, 26 Nov 2026 11:33:42 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA51C112360
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:33:19 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id EAA4FC2B9C9;
 Thu, 26 Nov 2026 11:33:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A269760237;
 Thu, 26 Nov 2026 11:33:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7C3DC11E6B306; Thu, 26 Nov 2026 12:33:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692796; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ULuEGzYlKQcAvmS/M/+lwchIxLHwMvtlf/bVXrRMjwg=;
 b=yABlbYl5xXSxkLPZmjDuHwo5fvIPFd1kkA9jMXjfpJnNqD3LmYz0epPwyPSFWXDv4paIG0
 z8JftD5ss70ZvDM85JBNFrGXvc2QlZnhYIYe9acXwO+L8JV2PjeYHBpdOXCwygrSVloxmD
 OkN65Ej//89mpk8h4a9q1+NZlfOTxoRUxgUQEypKnxA1i13oTJz5LcR3E3FAPepvxOgf4z
 TnyyGvMQgLKR/YH+OhS1coK5Oa9J1LZC+LAvvxIkwz7lsHAHrDoBOMmuTCRmTC2yhdo7f8
 Exib839U6t3m+LdM+kA5pdosOsqqUob4Gfwg8iRq+RiQ0yXDrKOxncoN2qWeTA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:24 +0100
Subject: [PATCH v7 41/43] drm/vkms: Introduce configfs for dynamic
 connector creation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-vkms-all-config-v7-41-21194cda2468@bootlin.com>
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

DRM allows the connector to be created after the device. To allow
emulating this, add two configfs attributes to the connector.

Using the dynamic attribute you can set if a connector will be dynamic or
not.
Using the enabled attribute, you can set at runtime if a dynamic connector
is present or not.

Co-developed-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms |  40 +++++++--
 Documentation/gpu/vkms.rst              |   6 +-
 drivers/gpu/drm/vkms/vkms_configfs.c    | 143 ++++++++++++++++++++++++++++++--
 3 files changed, 173 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index 11b4435a3562..f59533e6f80e 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -26,7 +26,10 @@ Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
 Description:
 	This group contains attributes corresponding to the
-	connector <connector> of the VKMS device <device>.
+	connector <connector> of the VKMS device <device>. If the
+	directory is created while the device is enabled, the new
+	connector is automatically marked dynamic and disabled,
+	ready to be hot-added through the enabled attribute.
 
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/status
 Date:		Nov 2025
@@ -35,7 +38,7 @@ Description:
 	Connection status of the connector. Possible values:
 	1 - connected, 2 - disconnected, 3 - unknown. Changing
 	the status triggers a connector hotplug if the device is
-	enabled.
+	enabled and the connector is enabled.
 
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/type
 Date:		Nov 2025
@@ -48,7 +51,6 @@ Description:
 	USB. Writing fails with -EBUSY if the device is enabled and the
 	connector is enabled.
 
-
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/supported_colorspaces
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
@@ -57,8 +59,10 @@ Description:
 	Value is a decimal number, where bit 0 = NO_DATA,
 	bit 1 = SMPTE_170M_YCC, etc. Bits beyond
 	DRM_MODE_COLORIMETRY_COUNT are rejected. Writing fails
-	with -EBUSY if the device is enabled. See enum
-	drm_colorspace for the full list.
+	with -EBUSY if the device is enabled and the connector is
+	enabled; a dynamic connector disabled with enabled=0
+	remains writable. See enum drm_colorspace for the full
+	list.
 
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/edid_enabled
 Date:		Nov 2025
@@ -81,12 +85,36 @@ Description:
 	is only used to generate connector modes when edid_enabled
 	is set.
 
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/dynamic
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Set to 1 to create a dynamic connector (emulates DP MST).
+	Value: 1 - dynamic, 0 - static. Cannot be changed while
+	the device is enabled (-EBUSY).
+
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/enabled
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	For dynamic connectors, set to 1 to create the connector,
+	0 to remove it. Value: 1 - enabled, 0 - disabled. While
+	the device is enabled, only dynamic connectors can be
+	changed (-EBUSY for static connectors), enabling validates
+	the whole device configuration (-EINVAL if invalid), and
+	toggling actually creates or removes the connector. While
+	the device is disabled, the value is only stored and takes
+	effect when the device is enabled.
+
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/possible_encoders
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
 Description:
 	This group contains symbolic links to possible encoders
-	for this connector.
+	for this connector. While the device is enabled and the
+	connector is enabled, linking an encoder into a dynamic
+	connector attaches it immediately, and linking into a
+	static connector fails with -EBUSY.
 
 What:		/sys/kernel/config/vkms/<device>/crtcs
 Date:		Nov 2025
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
index 1822978879ff..0681722e98e8 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -1065,6 +1065,12 @@ static ssize_t connector_status_show(struct config_item *item, char *page)
 	return sprintf(page, "%u\n", status);
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
@@ -1084,7 +1090,7 @@ static ssize_t connector_status_store(struct config_item *item,
 	scoped_guard(mutex, &connector->dev->config->lock) {
 		vkms_config_connector_set_status(connector->config, status);
 
-		if (connector->dev->enabled)
+		if (connector->dev->enabled && connector_is_enabled(connector->config))
 			vkms_trigger_connector_hotplug(connector->dev->config->dev);
 	}
 
@@ -1145,7 +1151,7 @@ static ssize_t connector_type_store(struct config_item *item,
 	}
 
 	scoped_guard(mutex, &connector->dev->config->lock) {
-		if (connector->dev->enabled)
+		if (connector->dev->enabled && connector_is_enabled(connector->config))
 			return -EBUSY;
 
 		vkms_config_connector_set_type(connector->config, val);
@@ -1183,7 +1189,7 @@ static ssize_t connector_supported_colorspaces_store(struct config_item *item,
 		return -EINVAL;
 
 	scoped_guard(mutex, &connector->dev->config->lock) {
-		if (connector->dev->enabled)
+		if (connector->dev->enabled && connector_is_enabled(connector->config))
 			return -EBUSY;
 
 		vkms_config_connector_set_supported_colorspaces(connector->config, val);
@@ -1281,6 +1287,106 @@ static ssize_t connector_edid_store(struct config_item *item,
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
+	scoped_guard(mutex, &connector->dev->config->lock)
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
+	scoped_guard(mutex, &connector->dev->config->lock) {
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
+				vkms_config_connector_set_enabled(connector_cfg,
+								  was_enabled);
+				return -EINVAL;
+			}
+
+			if (!was_enabled && enabled) {
+				struct vkms_connector *conn;
+
+				// Adding the connector
+				conn = vkms_connector_hot_add(connector->dev->config->dev,
+							      connector_cfg);
+				if (IS_ERR(conn)) {
+					vkms_config_connector_set_enabled(connector_cfg, was_enabled);
+					return PTR_ERR(conn);
+				}
+				connector_cfg->connector = conn;
+			} else if (was_enabled && !enabled) {
+				vkms_connector_hot_remove(connector_cfg->connector);
+			}
+		}
+	}
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
+	scoped_guard(mutex, &connector->dev->config->lock) {
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
+	scoped_guard(mutex, &connector->dev->config->lock) {
+		// Can't change the dynamic status when the device is activated
+		if (connector->dev->enabled)
+			return -EBUSY;
+
+		vkms_config_connector_set_dynamic(connector_cfg, dynamic);
+	}
 
 	return count;
 }
@@ -1290,6 +1396,8 @@ CONFIGFS_ATTR(connector_, type);
 CONFIGFS_ATTR(connector_, supported_colorspaces);
 CONFIGFS_ATTR(connector_, edid_enabled);
 CONFIGFS_ATTR(connector_, edid);
+CONFIGFS_ATTR(connector_, dynamic);
+CONFIGFS_ATTR(connector_, enabled);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
@@ -1297,19 +1405,27 @@ static struct configfs_attribute *connector_item_attrs[] = {
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
 	lock = &connector->dev->config->lock;
 
 	scoped_guard(mutex, lock) {
+		if (connector->dev->enabled && connector_cfg->dynamic && connector_cfg->enabled)
+			vkms_connector_hot_remove(connector_cfg->connector);
+
 		vkms_config_destroy_connector(connector->config);
+
 		kfree(connector);
 	}
 }
@@ -1328,6 +1444,7 @@ static int connector_possible_encoders_allow_link(struct config_item *src,
 						  struct config_item *target)
 {
 	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
 	struct vkms_configfs_encoder *encoder;
 	int ret;
 
@@ -1335,14 +1452,24 @@ static int connector_possible_encoders_allow_link(struct config_item *src,
 		return -EINVAL;
 
 	connector = connector_possible_encoders_item_to_vkms_configfs_connector(src);
+	connector_cfg = connector->config;
 	encoder = encoder_item_to_vkms_configfs_encoder(target);
 
 	scoped_guard(mutex, &connector->dev->config->lock) {
-		if (connector->dev->enabled)
-			return -EBUSY;
+		if (connector->dev->enabled && connector_cfg->enabled) {
+			if (!connector_cfg->dynamic)
+				return -EBUSY;
+
+			ret = vkms_connector_hot_attach_encoder(connector->config->connector,
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
@@ -1388,9 +1515,6 @@ static struct config_group *make_connector_group(struct config_group *group,
 	dev = child_group_to_vkms_configfs_device(group);
 
 	scoped_guard(mutex, &dev->config->lock) {
-		if (dev->enabled)
-			return ERR_PTR(-EBUSY);
-
 		connector = kzalloc_obj(*connector);
 		if (!connector)
 			return ERR_PTR(-ENOMEM);
@@ -1404,6 +1528,9 @@ static struct config_group *make_connector_group(struct config_group *group,
 			return ERR_PTR(ret);
 		}
 
+		vkms_config_connector_set_dynamic(connector->config, connector->dev->enabled);
+		vkms_config_connector_set_enabled(connector->config, !connector->dev->enabled);
+
 		config_group_init_type_name(&connector->group, name,
 					    &connector_item_type);
 

-- 
2.56.0

