Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B35606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fXvRSfe0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BF8112365;
	Thu, 26 Nov 2026 11:33:47 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6A21112360
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:33:33 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A6053C2B9C7;
 Thu, 26 Nov 2026 11:33:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 601B660237;
 Thu, 26 Nov 2026 11:33:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2CDFF11E6B306; Thu, 26 Nov 2026 12:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1795692806; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HoA7X4ma5bwJj/kRPNS7vTcKgiIrboSXt7Y5O79fKEE=;
 b=fXvRSfe0MfaDTim26L+H+xvmIAfAJdy1AF4wSb1n/A1Ko0cq2qJvKz3Hy/WEsU5RyAL5tj
 DOvCBD02/KO3AEHXnUM4MeUDGdOa4AasCWrEChDV44rJBollx0f/mVYIdaeReAmX2uw+pu
 X0bCvAyeICVFkD/rWBwD0BWuyWEGy3JEPkTdyBZl4JfQ6mjuUtwzn5QfNMBUKTdy5BGmPX
 PmsagCEJubaw/SNsFntJOhkX2rIF7sCAqScpv0rI+R6hFjaAl4J0+KOmiOmrmrHKlJqUV4
 VdTkXa0xhrOldzo6hw7BHueJdh5ey943nFnte7N6M9PPbNRJ66Ryjx1F0DYtRQ==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Thu, 26 Nov 2026 12:29:26 +0100
Subject: [PATCH v7 43/43] drm/vkms: Add ConfigFS interface for connector
 parent and port_id
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vkms-all-config-v7-43-21194cda2468@bootlin.com>
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

Add the parent and port_id configuration for a connector.

- port_id can contain any u8 value
- parent can contain at most one symlink to an other connector.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 Documentation/ABI/testing/configfs-vkms |  28 +++++++++
 drivers/gpu/drm/vkms/vkms_config.h      |   8 +--
 drivers/gpu/drm/vkms/vkms_configfs.c    | 103 ++++++++++++++++++++++++++++++++
 3 files changed, 135 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/testing/configfs-vkms
index f59533e6f80e..27d307935771 100644
--- a/Documentation/ABI/testing/configfs-vkms
+++ b/Documentation/ABI/testing/configfs-vkms
@@ -106,6 +106,15 @@ Description:
 	the device is disabled, the value is only stored and takes
 	effect when the device is enabled.
 
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/port_id
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	Port number of the connector, used together with parent to
+	build the MST PATH property. Value is a decimal number
+	between 0 and 255. Writing fails with -EBUSY if the device
+	is enabled and the connector is enabled.
+
 What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/possible_encoders
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
@@ -116,6 +125,25 @@ Description:
 	connector attaches it immediately, and linking into a
 	static connector fails with -EBUSY.
 
+What:		/sys/kernel/config/vkms/<device>/connectors/<connector>/parent
+Date:		Nov 2025
+Contact:	dri-devel@lists.freedesktop.org
+Description:
+	This group contains a symbolic link to the parent
+	connector, to emulate a DP MST topology. The target must
+	be a connector of the same VKMS device. Creating the link
+	fails with -EMLINK if the connector already has a parent,
+	and with -EBUSY if the device is enabled and the connector
+	is enabled. Removing the link detaches the parent. A
+	connector with a parent exposes a PATH property of the
+	form "mst:<root connector DRM ID>-<port_id>...", listing
+	the port IDs along the path from the first connector below
+	the root down to this one (up to 16 levels of nesting).
+	Creating a link that forms a parent cycle (A becoming the
+	parent of B while B is already the parent of A) is accepted,
+	but such a cycle is rejected when the device is enabled,
+	during configuration validation (-EINVAL).
+
 What:		/sys/kernel/config/vkms/<device>/crtcs
 Date:		Nov 2025
 Contact:	dri-devel@lists.freedesktop.org
diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vkms_config.h
index 83869e677f15..457239cfc2a4 100644
--- a/drivers/gpu/drm/vkms/vkms_config.h
+++ b/drivers/gpu/drm/vkms/vkms_config.h
@@ -432,6 +432,10 @@ vkms_config_connector_get_edid(const struct vkms_config_connector *connector_cfg
 	*len = 0;
 	return NULL;
 }
+
+int vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
+				   const u8 *edid, unsigned int len);
+
 /**
  * vkms_config_connector_attach_parent - Attach a connector to a parent connector
  * @connector_cfg: Connector to attach
@@ -492,10 +496,6 @@ vkms_config_connector_set_port_id(struct vkms_config_connector *connector_cfg,
 }
 
 
-int vkms_config_connector_set_edid(struct vkms_config_connector *connector_cfg,
-				   const u8 *edid, unsigned int len);
-
-
 /**
  * vkms_config_get_device_name() - Return the name of the device
  * @config: Configuration to get the device name from
diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index e6222db02a2e..55de6a06ab2d 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -112,6 +112,7 @@ struct vkms_configfs_encoder {
 struct vkms_configfs_connector {
 	struct config_group group;
 	struct config_group possible_encoders_group;
+	struct config_group parent_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_connector *config;
 };
@@ -149,6 +150,10 @@ struct vkms_configfs_connector {
 	container_of(to_config_group((item)), struct vkms_configfs_connector, \
 		     possible_encoders_group)
 
+#define connector_parent_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     parent_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -1391,6 +1396,42 @@ static ssize_t connector_dynamic_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_port_id_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	u8 port_id;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->config->lock)
+		port_id = vkms_config_connector_get_port_id(connector->config);
+
+	return sprintf(page, "%u\n", port_id);
+}
+
+static ssize_t connector_port_id_store(struct config_item *item,
+				       const char *page, size_t count)
+{
+	struct vkms_configfs_connector *connector;
+	u8 port_id;
+	int ret;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	ret = kstrtou8(page, 10, &port_id);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &connector->dev->config->lock) {
+		if (connector->dev->enabled && connector_is_enabled(connector->config))
+			return -EBUSY;
+
+		vkms_config_connector_set_port_id(connector->config, port_id);
+	}
+
+	return count;
+}
+
 CONFIGFS_ATTR(connector_, status);
 CONFIGFS_ATTR(connector_, type);
 CONFIGFS_ATTR(connector_, supported_colorspaces);
@@ -1398,6 +1439,7 @@ CONFIGFS_ATTR(connector_, edid_enabled);
 CONFIGFS_ATTR(connector_, edid);
 CONFIGFS_ATTR(connector_, dynamic);
 CONFIGFS_ATTR(connector_, enabled);
+CONFIGFS_ATTR(connector_, port_id);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
@@ -1407,6 +1449,7 @@ static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_edid,
 	&connector_attr_dynamic,
 	&connector_attr_enabled,
+	&connector_attr_port_id,
 	NULL,
 };
 
@@ -1505,6 +1548,62 @@ static const struct config_item_type connector_possible_encoders_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int connector_parent_connector_allow_link(struct config_item *src,
+						 struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	struct vkms_configfs_connector *parent;
+	struct vkms_config_connector *parent_cfg;
+
+	if (target->ci_type != &connector_item_type)
+		return -EINVAL;
+
+	connector = connector_parent_item_to_vkms_configfs_connector(src);
+	connector_cfg = connector->config;
+	parent = connector_item_to_vkms_configfs_connector(target);
+	parent_cfg = parent->config;
+
+	if (connector->dev != parent->dev)
+		return -EINVAL;
+
+	scoped_guard(mutex, &connector->dev->config->lock) {
+		if (vkms_config_connector_get_parent(connector_cfg))
+			return -EMLINK;
+
+		if (connector->dev->enabled && connector_cfg->enabled)
+			return -EBUSY;
+
+		vkms_config_connector_attach_parent(connector_cfg,
+						    parent_cfg);
+	}
+
+	return 0;
+}
+
+static void connector_parent_connector_drop_link(struct config_item *src,
+						 struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+
+	connector = connector_parent_item_to_vkms_configfs_connector(src);
+	connector_cfg = connector->config;
+
+	scoped_guard(mutex, &connector->dev->config->lock)
+		vkms_config_connector_attach_parent(connector_cfg, NULL);
+}
+
+static struct configfs_item_operations connector_parent_item_operations = {
+	.allow_link	= connector_parent_connector_allow_link,
+	.drop_link	= connector_parent_connector_drop_link,
+};
+
+static const struct config_item_type connector_parent_group_type = {
+	.ct_item_ops	= &connector_parent_item_operations,
+	.ct_owner	= THIS_MODULE,
+};
+
 static struct config_group *make_connector_group(struct config_group *group,
 						 const char *name)
 {
@@ -1537,6 +1636,10 @@ static struct config_group *make_connector_group(struct config_group *group,
 		config_group_init_type_name(&connector->possible_encoders_group,
 					    "possible_encoders",
 					    &connector_possible_encoders_group_type);
+		config_group_init_type_name(&connector->parent_group,
+					    "parent",
+					    &connector_parent_group_type);
+		configfs_add_default_group(&connector->parent_group, &connector->group);
 		configfs_add_default_group(&connector->possible_encoders_group,
 					   &connector->group);
 	}

-- 
2.56.0

