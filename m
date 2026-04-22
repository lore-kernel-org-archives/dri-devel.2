Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09CAFA1FD9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 16:50:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E409510EEED;
	Wed, 22 Apr 2026 16:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="x03ZXV4m";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA1B10EEE9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 16:50:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 8109C1A33B1;
 Wed, 22 Apr 2026 16:50:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 582675FA8F;
 Wed, 22 Apr 2026 16:50:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 48540104609C6; 
 Wed, 22 Apr 2026 18:50:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776876632; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=fGfgeIpuCIgD+eRDVdPjA5csZ40ByrU6uqlaF4J4fNg=;
 b=x03ZXV4mwoz+KHJVlu05CJQoH7g1cmb0dh0K2QLpQwW7rMhNQKJwWRNy+CqJp2OnpTTvEP
 e7L1pbFcWVsrx4AcJoWeOQUe4sPJpTCAzo0I/7Wn8QRUiK96LCyKMf7Q9qkdMdC2sypuWY
 VbK7aEoIQi1HwUYJF6cEkJ8Vz+Klcpc6ryi2qvYkjfJ4SWIV541K6Icbm/KVaAlxALySLU
 gVaUK1Be4AQ2IPbNSbBKTXq/imZw4PkTSLP7GUvWR6IcEMNJdthlVASyh5D0iH4sT7N/3L
 jh/qVO+Tsk0aHWgxWEjadPTvmkJCTFXhTpLPUGJfA6Sgu8KYQ/NL0+hXrwNw2A==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Wed, 22 Apr 2026 18:48:34 +0200
Subject: [PATCH v4 37/37] drm/vkms: Add ConfigFS interface for connector
 parent and port_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-vkms-all-config-v4-37-dbb52e9aadc3@bootlin.com>
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
 llvm@lists.linux.dev
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

Add the parent and port_id configuration for a connector.

- port_id can contains any u8 value
- parent can contain at most one symlink to an other connector.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 104 +++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index bc84a93cf1cd..dfe53dcbddff 100644
--- a/drivers/gpu/drm/vkms/vkms_configfs.c
+++ b/drivers/gpu/drm/vkms/vkms_configfs.c
@@ -114,6 +114,7 @@ struct vkms_configfs_encoder {
 struct vkms_configfs_connector {
 	struct config_group group;
 	struct config_group possible_encoders_group;
+	struct config_group parent_group;
 	struct vkms_configfs_device *dev;
 	struct vkms_config_connector *config;
 };
@@ -151,6 +152,10 @@ struct vkms_configfs_connector {
 	container_of(to_config_group((item)), struct vkms_configfs_connector, \
 		     possible_encoders_group)
 
+#define connector_parent_item_to_vkms_configfs_connector(item) \
+	container_of(to_config_group((item)), struct vkms_configfs_connector, \
+		     parent_group)
+
 static ssize_t crtc_writeback_show(struct config_item *item, char *page)
 {
 	struct vkms_configfs_crtc *crtc;
@@ -1457,6 +1462,42 @@ static ssize_t connector_dynamic_store(struct config_item *item,
 	return count;
 }
 
+static ssize_t connector_port_id_show(struct config_item *item, char *page)
+{
+	struct vkms_configfs_connector *connector;
+	u8 port_id;
+
+	connector = connector_item_to_vkms_configfs_connector(item);
+
+	scoped_guard(mutex, &connector->dev->lock)
+		port_id = vkms_config_connector_get_port_id(connector->config);
+
+	return sprintf(page, "%u\n", port_id);
+}
+
+static ssize_t connector_port_id_store(struct config_item *item,
+				   const char *page, size_t count)
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
+	scoped_guard(mutex, &connector->dev->lock) {
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
@@ -1464,6 +1505,7 @@ CONFIGFS_ATTR(connector_, edid_enabled);
 CONFIGFS_ATTR(connector_, edid);
 CONFIGFS_ATTR(connector_, dynamic);
 CONFIGFS_ATTR(connector_, enabled);
+CONFIGFS_ATTR(connector_, port_id);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
@@ -1473,6 +1515,7 @@ static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_edid,
 	&connector_attr_dynamic,
 	&connector_attr_enabled,
+	&connector_attr_port_id,
 	NULL,
 };
 
@@ -1568,6 +1611,63 @@ static const struct config_item_type connector_possible_encoders_group_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+static int connector_parent_connector_allow_link(struct config_item *src,
+						 struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+	struct vkms_configfs_connector *parent;
+	struct vkms_config_connector *parent_cfg;
+	int ret;
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
+	scoped_guard(mutex, &connector->dev->lock) {
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
+	return ret;
+}
+
+static void connector_parent_connector_drop_link(struct config_item *src,
+						  struct config_item *target)
+{
+	struct vkms_configfs_connector *connector;
+	struct vkms_config_connector *connector_cfg;
+
+	connector = connector_parent_item_to_vkms_configfs_connector(src);
+	connector_cfg = connector->config;
+
+	scoped_guard(mutex, &connector->dev->lock)
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
@@ -1600,6 +1700,10 @@ static struct config_group *make_connector_group(struct config_group *group,
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
2.54.0

