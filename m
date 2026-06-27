Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C60C43602
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F0E10F74B;
	Sat, 27 Jun 2026 03:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ohsZLMyt";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F52F10E429
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:32:24 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id E0489C58468;
 Sat, 27 Jun 2026 03:32:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id D06DF60233;
 Sat, 27 Jun 2026 03:32:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 2E833106F1165; 
 Sat, 27 Jun 2026 05:32:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782531141; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=DGT4effFpPmWOM+aXYqsouC87Bp3kHtwAGycmPjcxEs=;
 b=ohsZLMytWMZBzsQe7gY3ZbjctlxoKgmRqmejFt1q9lEeX/IHv/cRb2/tIPWIbcGee+K3eq
 pfIOBf+JygjhF9tDGZIj3BxJSCaUEbxaonntKMYK+E0kNI0FdyuIusGA7vAMpDYcKfpfLV
 qnWfPHpxUE6/Z8iQp53fBxrNRA7oHS5+FsgoNiFy0Pqp5cEKK0s6s9RuNNrk4cKufFCyDb
 8b+zyOJIZYmzHtn8MyQTi9Iv9Rkqv6zYNa6YWyP3fxyWSUDKNw+fPpSw2LnjdzOCdmeCXf
 c/VpvpOtWxA5fMgCKoGR7O7GKMcLbCM4Hdu5uxMDzbWvKO6KaSqEWqsykbEIiw==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Sat, 27 Jun 2026 05:30:55 +0200
Subject: [PATCH v5 38/38] drm/vkms: Add ConfigFS interface for connector
 parent and port_id
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260627-vkms-all-config-v5-38-854aa0840926@bootlin.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5595;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=EiGhaRVcBrHhG3ZC1o5OwZvxjBRoDMYEi/Wnd/D43UQ=;
 b=owEBiQJ2/ZANAwAIASCtLsZbECziAcsmYgBqP0PiMoWff0aLZE1ohvIaGwcxn99Z0iBt1F03R
 rzY5b5+pceJAk8EAAEIADkWIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCaj9D4hsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQIK0uxlsQLOLEoQ//Q5VaBWPpu8uf3hXu+ADvo62FtR/kJFG
 cLstNH97LeJ/qWyPfke7Sl9BAEDZU8Qn+/2l8KiKZIBzh/8TMOCM01wSAHBWfFi6tyr74gvvXi2
 Lu6TyNiwUoKyBd71EatZ03G2YhmB1PbJwipHLMTYm6XaWTjXJluzEonnOJbVQ+LEyX4a8c242tm
 tZ/Mv5cgU7dxIxO4U5LEOf8BAYiCNQ60efX6YZ5qM8cC0mlWBJKC2AcQ+z1IwvMNF/gmAkbYllu
 jF7P1pARpuUrzqvxXSXZ3SgFsJ3nfwLX1mYrIlF2MEDUAYblbH2QHY8VHHO9WkYfg8mTheuQhio
 JaeuA/Uq3/Xuwba0Vr3fY1uxaRoUOsHBrdtKJQvU5LXMNz7JT1i0eeYsHlnz6qFz4b9MJxR6w5e
 NqJOtr/Vl8LN+O+52jXP4t+CSsFfzv1XCjkqqV+Up5BipUAbZVXVym6Tl6X+F2Ab+YlIP0FYMCa
 WPgBbYWYqjJ4SZuuNTwBspbKE1zfKWgZAa6gx4+B91aC3/oWtYLOCvMgCFRXuLltjw0+rrGKm2L
 Be1sdNHi3Mf1JxY3PxwEHdngOMQzWXxPqbR7Bd8zqSbVB1U+Rf2Fc4llhhYvsC/2qbhnvxpbQ9L
 duEmfzCs6Fj67BOlQUJoSwI94qS0bSEK/pgSRwTi1zEYljson0lA=
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

Add the parent and port_id configuration for a connector.

- port_id can contains any u8 value
- parent can contain at most one symlink to an other connector.

Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
 drivers/gpu/drm/vkms/vkms_configfs.c | 104 +++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/vkms_configfs.c
index dd2a9e450150..4f4ec9944804 100644
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
@@ -1401,6 +1406,42 @@ static ssize_t connector_dynamic_store(struct config_item *item,
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
@@ -1408,6 +1449,7 @@ CONFIGFS_ATTR(connector_, edid_enabled);
 CONFIGFS_ATTR(connector_, edid);
 CONFIGFS_ATTR(connector_, dynamic);
 CONFIGFS_ATTR(connector_, enabled);
+CONFIGFS_ATTR(connector_, port_id);
 
 static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_status,
@@ -1417,6 +1459,7 @@ static struct configfs_attribute *connector_item_attrs[] = {
 	&connector_attr_edid,
 	&connector_attr_dynamic,
 	&connector_attr_enabled,
+	&connector_attr_port_id,
 	NULL,
 };
 
@@ -1512,6 +1555,63 @@ static const struct config_item_type connector_possible_encoders_group_type = {
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
@@ -1544,6 +1644,10 @@ static struct config_group *make_connector_group(struct config_group *group,
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

