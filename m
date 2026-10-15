Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC57CCA462
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 07:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BEA112653;
	Fri, 16 Oct 2026 07:35:42 +0000 (UTC)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477AA1124BE
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:25:52 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4j5Lht3mYnzKp6j;
 Thu, 15 Oct 2026 23:25:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1792099550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2XuJhNfjGucHhAObYOA10HejVry4A1chjwC3rTMjxNQ=;
 b=ZyXzzWUh4SJ7TIsKT/Upe4sKD5jNfPYTAG1lyaL+2Mut3j6z7U2Hm+rVdRG58Grum2HxcW
 rG5KLSdRwnYmXgUehkz7y4T2zOs7nXseo++rGy6pTDoJuC9y+MgCA+4VfWYE4abnkS0LHG
 ABMqef7PCTHGeRPmEcEmdpDZvkM84Yxy0/WDGd/W6rTDEuMEd90LbDBefvsBYcDzo+ShLC
 KVmaZAoHADsI8JbaET5HqH9bqvDdfB9jjs1IEl4MzPFCibJg5pxgBXjhGtdt5kxz+usHiN
 jwtvYhzPf3yujVH7tPR0AR4zN20J4G35MlwDew6AJs7+tQkyhBwFpXyTFGc55Q==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, ville.syrjala@linux.intel.com, jfalempe@redhat.com,
 javierm@redhat.com, Hugo Sales <hugo@hsal.es>
Subject: [PATCH 1/2] drm/client: Probe connectors with the device's mode size
 limits
Date: Thu, 15 Oct 2026 22:25:44 +0100
Message-ID: <20261015212545.1989962-2-hugo@hsal.es>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015212545.1989962-1-hugo@hsal.es>
References: <20261015212545.1989962-1-hugo@hsal.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4j5Lht3mYnzKp6j
X-Mailman-Approved-At: Fri, 16 Oct 2026 07:35:41 +0000
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

Currently, drm_client_modeset_probe() passes the client's width and
height to ->fill_modes(), and the probe helper leaves every larger mode
out of connector->modes. drm_log, fbdev's initial setup and the
GETCONNECTOR ioctl already probe with the device's limits, but on a
hotplug fbdev passes its framebuffer size. After that, the list that
userspace and the driver share lacks every mode larger than the
framebuffer. That includes the panel's preferred mode when video= sets
a smaller one

Probe with the device's limits instead. Make the mode pickers skip
modes that don't fit width x height, using the drm_mode_validate_size()
check the probe helper applied before. The probe helper still runs
mode_valid on every mode, so only the size check moves

fbdev picks the same modes as before, with one exception. A DisplayPort
sink with no mode that fits used to end up with an empty list, so the
probe helper added its 640x480 fallback modes. Its list now keeps the
larger modes, and fbdev leaves that output off

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5983
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Hugo Sales <hugo@hsal.es>
---
 drivers/gpu/drm/drm_client_modeset.c          | 57 +++++++++++++------
 .../gpu/drm/tests/drm_client_modeset_test.c   |  4 +-
 2 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 0080a8e9556a..e79c7257aaa2 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -121,11 +121,13 @@ drm_client_find_modeset(struct drm_client_dev *client, struct drm_crtc *crtc)
 }
 
 static const struct drm_display_mode *
-drm_connector_get_tiled_mode(struct drm_connector *connector)
+drm_connector_get_tiled_mode(struct drm_connector *connector, int width, int height)
 {
 	const struct drm_display_mode *mode;
 
 	list_for_each_entry(mode, &connector->modes, head) {
+		if (drm_mode_validate_size(mode, width, height) != MODE_OK)
+			continue;
 		if (mode->hdisplay == connector->tile_h_size &&
 		    mode->vdisplay == connector->tile_v_size)
 			return mode;
@@ -134,11 +136,13 @@ drm_connector_get_tiled_mode(struct drm_connector *connector)
 }
 
 static const struct drm_display_mode *
-drm_connector_fallback_non_tiled_mode(struct drm_connector *connector)
+drm_connector_fallback_non_tiled_mode(struct drm_connector *connector, int width, int height)
 {
 	const struct drm_display_mode *mode;
 
 	list_for_each_entry(mode, &connector->modes, head) {
+		if (drm_mode_validate_size(mode, width, height) != MODE_OK)
+			continue;
 		if (mode->hdisplay == connector->tile_h_size &&
 		    mode->vdisplay == connector->tile_v_size)
 			continue;
@@ -163,14 +167,19 @@ drm_connector_preferred_mode(struct drm_connector *connector, int width, int hei
 }
 
 static const struct drm_display_mode *
-drm_connector_first_mode(struct drm_connector *connector)
+drm_connector_first_mode(struct drm_connector *connector, int width, int height)
 {
-	return list_first_entry_or_null(&connector->modes,
-					struct drm_display_mode, head);
+	const struct drm_display_mode *mode;
+
+	list_for_each_entry(mode, &connector->modes, head) {
+		if (drm_mode_validate_size(mode, width, height) == MODE_OK)
+			return mode;
+	}
+	return NULL;
 }
 
 static const struct drm_display_mode *
-drm_connector_pick_cmdline_mode(struct drm_connector *connector)
+drm_connector_pick_cmdline_mode(struct drm_connector *connector, int width, int height)
 {
 	const struct drm_cmdline_mode *cmdline_mode;
 	const struct drm_display_mode *mode;
@@ -183,6 +192,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
 	 */
 
 	list_for_each_entry(mode, &connector->modes, head) {
+		if (drm_mode_validate_size(mode, width, height) != MODE_OK)
+			continue;
 		if (mode->type & DRM_MODE_TYPE_USERDEF)
 			return mode;
 	}
@@ -199,6 +210,8 @@ drm_connector_pick_cmdline_mode(struct drm_connector *connector)
 	prefer_non_interlace = !cmdline_mode->interlace;
 again:
 	list_for_each_entry(mode, &connector->modes, head) {
+		if (drm_mode_validate_size(mode, width, height) != MODE_OK)
+			continue;
 		/* check width/height */
 		if (mode->hdisplay != cmdline_mode->xres ||
 		    mode->vdisplay != cmdline_mode->yres)
@@ -321,7 +334,7 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 			continue;
 
 		mode_replace(dev, &modes[i],
-			     drm_connector_pick_cmdline_mode(connectors[i]));
+			     drm_connector_pick_cmdline_mode(connectors[i], width, height));
 		if (!modes[i]) {
 			can_clone = false;
 			break;
@@ -357,6 +370,8 @@ static bool drm_client_target_cloned(struct drm_device *dev,
 			continue;
 
 		list_for_each_entry(mode, &connectors[i]->modes, head) {
+			if (drm_mode_validate_size(mode, width, height) != MODE_OK)
+				continue;
 			if (drm_mode_match(mode, dmt_mode,
 					   DRM_MODE_MATCH_TIMINGS |
 					   DRM_MODE_MATCH_CLOCK |
@@ -472,7 +487,7 @@ static bool drm_client_target_preferred(struct drm_device *dev,
 
 		mode_type = "cmdline";
 		mode_replace(dev, &modes[i],
-			     drm_connector_pick_cmdline_mode(connector));
+			     drm_connector_pick_cmdline_mode(connector, width, height));
 
 		if (!modes[i]) {
 			mode_type = "preferred";
@@ -483,7 +498,7 @@ static bool drm_client_target_preferred(struct drm_device *dev,
 		if (!modes[i]) {
 			mode_type = "first";
 			mode_replace(dev, &modes[i],
-				     drm_connector_first_mode(connector));
+				     drm_connector_first_mode(connector, width, height));
 		}
 
 		/*
@@ -499,14 +514,16 @@ static bool drm_client_target_preferred(struct drm_device *dev,
 			    connector->num_h_tile * connector->num_v_tile ||
 			    (connector->tile_h_loc == 0 &&
 			     connector->tile_v_loc == 0 &&
-			     !drm_connector_get_tiled_mode(connector))) {
+			     !drm_connector_get_tiled_mode(connector, width, height))) {
 				mode_type = "non tiled";
 				mode_replace(dev, &modes[i],
-					     drm_connector_fallback_non_tiled_mode(connector));
+					     drm_connector_fallback_non_tiled_mode(connector,
+										   width, height));
 			} else {
 				mode_type = "tiled";
 				mode_replace(dev, &modes[i],
-					     drm_connector_get_tiled_mode(connector));
+					     drm_connector_get_tiled_mode(connector,
+									  width, height));
 			}
 		}
 
@@ -721,7 +738,7 @@ static bool drm_client_firmware_config(struct drm_client_dev *client,
 
 		mode_type = "cmdline";
 		mode_replace(dev, &modes[i],
-			     drm_connector_pick_cmdline_mode(connector));
+			     drm_connector_pick_cmdline_mode(connector, width, height));
 
 		if (!modes[i]) {
 			mode_type = "preferred";
@@ -732,7 +749,7 @@ static bool drm_client_firmware_config(struct drm_client_dev *client,
 		if (!modes[i]) {
 			mode_type = "first";
 			mode_replace(dev, &modes[i],
-				     drm_connector_first_mode(connector));
+				     drm_connector_first_mode(connector, width, height));
 		}
 
 		/* last resort: use current mode */
@@ -750,7 +767,8 @@ static bool drm_client_firmware_config(struct drm_client_dev *client,
 		    num_tiled_conns < connector->num_h_tile * connector->num_v_tile) {
 			mode_type = "non tiled";
 			mode_replace(dev, &modes[i],
-				     drm_connector_fallback_non_tiled_mode(connector));
+				     drm_connector_fallback_non_tiled_mode(connector,
+									   width, height));
 		}
 		crtcs[i] = crtc;
 
@@ -865,8 +883,15 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 	mutex_lock(&client->modeset_mutex);
 
 	mutex_lock(&dev->mode_config.mutex);
+	/*
+	 * Probe with the device limits, not width x height. connector->modes is
+	 * shared with userspace and the driver, so it must keep modes larger
+	 * than this client's size. The mode pickers skip those instead
+	 */
 	for (i = 0; i < connector_count; i++)
-		total_modes_count += connectors[i]->funcs->fill_modes(connectors[i], width, height);
+		total_modes_count += connectors[i]->funcs->fill_modes(connectors[i],
+								      dev->mode_config.max_width,
+								      dev->mode_config.max_height);
 	if (!total_modes_count)
 		drm_dbg_kms(dev, "No connectors reported connected with modes\n");
 	drm_client_connectors_enabled(connectors, connector_count, enabled);
diff --git a/drivers/gpu/drm/tests/drm_client_modeset_test.c b/drivers/gpu/drm/tests/drm_client_modeset_test.c
index ec58fe064d86..00f43fca9795 100644
--- a/drivers/gpu/drm/tests/drm_client_modeset_test.c
+++ b/drivers/gpu/drm/tests/drm_client_modeset_test.c
@@ -112,7 +112,7 @@ static void drm_test_pick_cmdline_res_1920_1080_60(struct kunit *test)
 	mutex_unlock(&drm->mode_config.mutex);
 	KUNIT_ASSERT_GT(test, ret, 0);
 
-	mode = drm_connector_pick_cmdline_mode(connector);
+	mode = drm_connector_pick_cmdline_mode(connector, 1920, 1080);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	KUNIT_EXPECT_TRUE(test, drm_mode_equal(expected_mode, mode));
@@ -151,7 +151,7 @@ static void drm_test_pick_cmdline_named(struct kunit *test)
 	mutex_unlock(&drm->mode_config.mutex);
 	KUNIT_ASSERT_GT(test, ret, 0);
 
-	mode = drm_connector_pick_cmdline_mode(connector);
+	mode = drm_connector_pick_cmdline_mode(connector, 1920, 1080);
 	KUNIT_ASSERT_NOT_NULL(test, mode);
 
 	expected_mode = params->func(drm);
-- 
2.55.0

