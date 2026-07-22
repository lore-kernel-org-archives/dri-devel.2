Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A688DC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22ED10ECE8;
	Wed, 22 Jul 2026 09:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="AAltFSdh";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21CB210ECE8
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 09:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784711553; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BtiExc6BExPv2oPxfEnpsI7xA2VLmpH80GLgRj75o6USMKBDYPIFKJiQjsbpjzEWKFNXcSLuWHD62dZRe1tAdsFFPBx0aq5KsOJUsoY/cM9eS7l5wQBDrpTdfnzs2tW1OJ+Rs4YyMi5S9MDqTROj17kU4Bmjl2ahR/ZApbyr1Q4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784711553;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iyMdeIjesJ+k58luJXaL+sqCBtei9UFC6fuSl+9RZtM=; 
 b=VwDCJi38iJOZKcg30bZV5q4dx4NejMKciMMaqpDSxqjvuBJN7xXYRQpllc3G36cnBsVBnPBSKeEpx0eNZoMJeptGR79b2C/6iX/O44hhfxYCm1qsb8cQjh7d8zUlouDMELUcRgwNejyimw5PDpPjV7SeTidjWA8A7DhDsUQfgZ8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784711553; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=iyMdeIjesJ+k58luJXaL+sqCBtei9UFC6fuSl+9RZtM=;
 b=AAltFSdhoPdoaO2KYSQtzGfzwpyuxjcg2fE0W1pqpKcTQ4AKUQsZDzrrMeNFyVwy
 1qBI//aS9VPKohPXA6+F67QuCkVjeVIvih8kVIN1MfbPfj7mu0afcP+MP78MOfqwOro
 hUWsOgYswpGULKAQeL5GveMxfvr1a07MWG+8RdGU=
Received: by mx.zohomail.com with SMTPS id 1784711552275117.3981724913416;
 Wed, 22 Jul 2026 02:12:32 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 22 Jul 2026 11:11:50 +0200
Subject: [PATCH v8 4/5] drm/debugfs: Move HDMI debugfs registration to
 state helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-scdc-link-health-v8-4-cd1dacbb85d9@collabora.com>
References: <20260722-scdc-link-health-v8-0-cd1dacbb85d9@collabora.com>
In-Reply-To: <20260722-scdc-link-health-v8-0-cd1dacbb85d9@collabora.com>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Hans Verkuil <hverkuil+cisco@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
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

The HDMI debugfs files are only useful for connectors that already make
use of the HDMI state helpers. In addition, relying on HDMI-specific
functions in drm_debugfs.c can lead to circular linking problems later
down the line.

Move hdmi_debugfs_add() and friends to a new helper in
drm_hdmi_state_helper.c, and make all current users (vc4, sun4i, bridge)
either use it as a debugfs_init func, or call it directly in its
debugfs_init func.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c  |   3 +
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 154 +++++++++++++++++++++++
 drivers/gpu/drm/drm_debugfs.c                   | 157 ------------------------
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c          |   1 +
 drivers/gpu/drm/vc4/vc4_hdmi.c                  |   1 +
 include/drm/display/drm_hdmi_state_helper.h     |   3 +
 6 files changed, 162 insertions(+), 157 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8b54069fa53a..00feb73e63d7 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -263,6 +263,9 @@ static void drm_bridge_connector_debugfs_init(struct drm_connector *connector,
 		if (bridge->funcs->debugfs_init)
 			bridge->funcs->debugfs_init(bridge, root);
 	}
+
+	if (bridge_connector->bridge_hdmi)
+		drm_hdmi_connector_debugfs_init(connector, root);
 }
 
 static struct drm_connector_state *
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index ce17eeefc2da..8d5ee10ceb87 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: MIT
 
+#include <linux/debugfs.h>
 #include <linux/export.h>
 
 #include <drm/drm_atomic.h>
@@ -965,6 +966,159 @@ drm_hdmi_connector_mode_valid(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_hdmi_connector_mode_valid);
 
+static ssize_t
+audio_infoframe_read(struct file *filp, char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct drm_connector_hdmi_infoframe *infoframe;
+	struct drm_connector *connector;
+	union hdmi_infoframe *frame;
+	u8 buf[HDMI_INFOFRAME_SIZE(AUDIO)];
+	ssize_t len = 0;
+
+	connector = filp->private_data;
+	mutex_lock(&connector->hdmi.infoframes.lock);
+
+	infoframe = &connector->hdmi.infoframes.audio;
+	if (!infoframe->set)
+		goto out;
+
+	frame = &infoframe->data;
+	len = hdmi_infoframe_pack(frame, buf, sizeof(buf));
+	if (len < 0)
+		goto out;
+
+	len = simple_read_from_buffer(ubuf, count, ppos, buf, len);
+
+out:
+	mutex_unlock(&connector->hdmi.infoframes.lock);
+	return len;
+}
+
+static const struct file_operations audio_infoframe_fops = {
+	.owner   = THIS_MODULE,
+	.open    = simple_open,
+	.read    = audio_infoframe_read,
+};
+
+static int create_hdmi_audio_infoframe_file(struct drm_connector *connector,
+					    struct dentry *parent)
+{
+	struct dentry *file;
+
+	if (!connector->hdmi.funcs ||
+	    !connector->hdmi.funcs->audio.write_infoframe)
+		return 0;
+
+	file = debugfs_create_file("audio", 0400, parent, connector, &audio_infoframe_fops);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	return 0;
+}
+
+#define DEFINE_INFOFRAME_FILE(_f) \
+static ssize_t _f##_read_infoframe(struct file *filp, \
+				   char __user *ubuf, \
+				   size_t count,      \
+				   loff_t *ppos)      \
+{ \
+	struct drm_connector_hdmi_infoframe *infoframe; \
+	struct drm_connector_state *conn_state; \
+	struct drm_connector *connector; \
+	union hdmi_infoframe *frame; \
+	struct drm_device *dev; \
+	u8 buf[HDMI_INFOFRAME_SIZE(MAX)]; \
+	ssize_t len = 0; \
+	\
+	connector = filp->private_data; \
+	dev = connector->dev; \
+	\
+	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL); \
+	\
+	conn_state = connector->state; \
+	infoframe = &conn_state->hdmi.infoframes._f; \
+	if (!infoframe->set) \
+		goto out; \
+	\
+	frame = &infoframe->data; \
+	len = hdmi_infoframe_pack(frame, buf, sizeof(buf)); \
+	if (len < 0) \
+		goto out; \
+	\
+	len = simple_read_from_buffer(ubuf, count, ppos, buf, len); \
+	\
+out: \
+	drm_modeset_unlock(&dev->mode_config.connection_mutex); \
+	return len; \
+} \
+\
+static const struct file_operations _f##_infoframe_fops = { \
+	.owner = THIS_MODULE, \
+	.open = simple_open, \
+	.read = _f##_read_infoframe, \
+}; \
+\
+static int create_hdmi_## _f ## _infoframe_file(struct drm_connector *connector, \
+						struct dentry *parent) \
+{ \
+	struct dentry *file; \
+	\
+	if (!connector->hdmi.funcs || \
+	    !connector->hdmi.funcs->_f.write_infoframe) \
+		return 0; \
+	file = debugfs_create_file(#_f, 0400, parent, connector, &_f ## _infoframe_fops); \
+	if (IS_ERR(file)) \
+		return PTR_ERR(file); \
+	\
+	return 0; \
+}
+
+DEFINE_INFOFRAME_FILE(avi);
+DEFINE_INFOFRAME_FILE(hdmi);
+DEFINE_INFOFRAME_FILE(hdr_drm);
+DEFINE_INFOFRAME_FILE(spd);
+
+static int create_hdmi_infoframe_files(struct drm_connector *connector,
+				       struct dentry *parent)
+{
+	int ret;
+
+	ret = create_hdmi_audio_infoframe_file(connector, parent);
+	if (ret)
+		return ret;
+
+	ret = create_hdmi_avi_infoframe_file(connector, parent);
+	if (ret)
+		return ret;
+
+	ret = create_hdmi_hdmi_infoframe_file(connector, parent);
+	if (ret)
+		return ret;
+
+	ret = create_hdmi_hdr_drm_infoframe_file(connector, parent);
+	if (ret)
+		return ret;
+
+	ret = create_hdmi_spd_infoframe_file(connector, parent);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+void drm_hdmi_connector_debugfs_init(struct drm_connector *connector,
+				     struct dentry *root)
+{
+	struct dentry *dir;
+
+	dir = debugfs_create_dir("infoframes", root);
+	if (IS_ERR(dir))
+		return;
+
+	create_hdmi_infoframe_files(connector, dir);
+}
+EXPORT_SYMBOL(drm_hdmi_connector_debugfs_init);
+
 static int clear_infoframe(struct drm_connector *connector,
 			   const struct drm_connector_infoframe_funcs *funcs,
 			   const char *type)
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index ae1c6126c2c5..a72f9723d3a9 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -633,161 +633,6 @@ static const struct file_operations drm_connector_fops = {
 	.write = connector_write
 };
 
-static ssize_t
-audio_infoframe_read(struct file *filp, char __user *ubuf, size_t count, loff_t *ppos)
-{
-	struct drm_connector_hdmi_infoframe *infoframe;
-	struct drm_connector *connector;
-	union hdmi_infoframe *frame;
-	u8 buf[HDMI_INFOFRAME_SIZE(AUDIO)];
-	ssize_t len = 0;
-
-	connector = filp->private_data;
-	mutex_lock(&connector->hdmi.infoframes.lock);
-
-	infoframe = &connector->hdmi.infoframes.audio;
-	if (!infoframe->set)
-		goto out;
-
-	frame = &infoframe->data;
-	len = hdmi_infoframe_pack(frame, buf, sizeof(buf));
-	if (len < 0)
-		goto out;
-
-	len = simple_read_from_buffer(ubuf, count, ppos, buf, len);
-
-out:
-	mutex_unlock(&connector->hdmi.infoframes.lock);
-	return len;
-}
-
-static const struct file_operations audio_infoframe_fops = {
-	.owner   = THIS_MODULE,
-	.open    = simple_open,
-	.read    = audio_infoframe_read,
-};
-
-static int create_hdmi_audio_infoframe_file(struct drm_connector *connector,
-					    struct dentry *parent)
-{
-	struct dentry *file;
-
-	if (!connector->hdmi.funcs ||
-	    !connector->hdmi.funcs->audio.write_infoframe)
-		return 0;
-
-	file = debugfs_create_file("audio", 0400, parent, connector, &audio_infoframe_fops);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	return 0;
-}
-
-#define DEFINE_INFOFRAME_FILE(_f) \
-static ssize_t _f##_read_infoframe(struct file *filp, \
-				   char __user *ubuf, \
-				   size_t count,      \
-				   loff_t *ppos)      \
-{ \
-	struct drm_connector_hdmi_infoframe *infoframe; \
-	struct drm_connector_state *conn_state; \
-	struct drm_connector *connector; \
-	union hdmi_infoframe *frame; \
-	struct drm_device *dev; \
-	u8 buf[HDMI_INFOFRAME_SIZE(MAX)]; \
-	ssize_t len = 0; \
-	\
-	connector = filp->private_data; \
-	dev = connector->dev; \
-	\
-	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL); \
-	\
-	conn_state = connector->state; \
-	infoframe = &conn_state->hdmi.infoframes._f; \
-	if (!infoframe->set) \
-		goto out; \
-	\
-	frame = &infoframe->data; \
-	len = hdmi_infoframe_pack(frame, buf, sizeof(buf)); \
-	if (len < 0) \
-		goto out; \
-	\
-	len = simple_read_from_buffer(ubuf, count, ppos, buf, len); \
-	\
-out: \
-	drm_modeset_unlock(&dev->mode_config.connection_mutex); \
-	return len; \
-} \
-\
-static const struct file_operations _f##_infoframe_fops = { \
-	.owner = THIS_MODULE, \
-	.open = simple_open, \
-	.read = _f##_read_infoframe, \
-}; \
-\
-static int create_hdmi_## _f ## _infoframe_file(struct drm_connector *connector, \
-						struct dentry *parent) \
-{ \
-	struct dentry *file; \
-	\
-	if (!connector->hdmi.funcs || \
-	    !connector->hdmi.funcs->_f.write_infoframe) \
-		return 0; \
-	file = debugfs_create_file(#_f, 0400, parent, connector, &_f ## _infoframe_fops); \
-	if (IS_ERR(file)) \
-		return PTR_ERR(file); \
-	\
-	return 0; \
-}
-
-DEFINE_INFOFRAME_FILE(avi);
-DEFINE_INFOFRAME_FILE(hdmi);
-DEFINE_INFOFRAME_FILE(hdr_drm);
-DEFINE_INFOFRAME_FILE(spd);
-
-static int create_hdmi_infoframe_files(struct drm_connector *connector,
-				       struct dentry *parent)
-{
-	int ret;
-
-	ret = create_hdmi_audio_infoframe_file(connector, parent);
-	if (ret)
-		return ret;
-
-	ret = create_hdmi_avi_infoframe_file(connector, parent);
-	if (ret)
-		return ret;
-
-	ret = create_hdmi_hdmi_infoframe_file(connector, parent);
-	if (ret)
-		return ret;
-
-	ret = create_hdmi_hdr_drm_infoframe_file(connector, parent);
-	if (ret)
-		return ret;
-
-	ret = create_hdmi_spd_infoframe_file(connector, parent);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static void hdmi_debugfs_add(struct drm_connector *connector)
-{
-	struct dentry *dir;
-
-	if (!(connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
-	      connector->connector_type == DRM_MODE_CONNECTOR_HDMIB))
-		return;
-
-	dir = debugfs_create_dir("infoframes", connector->debugfs_entry);
-	if (IS_ERR(dir))
-		return;
-
-	create_hdmi_infoframe_files(connector, dir);
-}
-
 void drm_debugfs_connector_add(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
@@ -815,8 +660,6 @@ void drm_debugfs_connector_add(struct drm_connector *connector)
 	debugfs_create_file("output_bpc", 0444, root, connector,
 			    &output_bpc_fops);
 
-	hdmi_debugfs_add(connector);
-
 	if (connector->funcs->debugfs_init)
 		connector->funcs->debugfs_init(connector, root);
 }
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index e99f52ebb26f..e6c4f121ad0c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -292,6 +292,7 @@ static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
 }
 
 static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
+	.debugfs_init		= drm_hdmi_connector_debugfs_init,
 	.detect			= sun4i_hdmi_connector_detect,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.reset			= sun4i_hdmi_connector_reset,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 17c8635c5afa..ea1f2013b20e 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -513,6 +513,7 @@ static void vc4_hdmi_connector_reset(struct drm_connector *connector)
 }
 
 static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
+	.debugfs_init = drm_hdmi_connector_debugfs_init,
 	.force = drm_atomic_helper_connector_hdmi_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.reset = vc4_hdmi_connector_reset,
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 13375bd0f4ae..596c57d9d250 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -3,6 +3,7 @@
 #ifndef DRM_HDMI_STATE_HELPER_H_
 #define DRM_HDMI_STATE_HELPER_H_
 
+struct dentry;
 struct drm_atomic_commit;
 struct drm_connector;
 struct drm_connector_state;
@@ -29,5 +30,7 @@ void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 enum drm_mode_status
 drm_hdmi_connector_mode_valid(struct drm_connector *connector,
 			      const struct drm_display_mode *mode);
+void drm_hdmi_connector_debugfs_init(struct drm_connector *connector,
+				     struct dentry *root);
 
 #endif // DRM_HDMI_STATE_HELPER_H_

-- 
2.55.0

