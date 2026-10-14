Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B81D8CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196CB10FEFB;
	Wed, 14 Oct 2026 17:30:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F26B10FEFD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C62A66022E;
 Wed, 14 Oct 2026 17:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21ED1F000C4;
 Wed, 14 Oct 2026 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999032;
 bh=pmgAVG8no9993DhxcxKYA6kknNN3iHfYrrs08uflq8g=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Yg+0hiqcKe2QmiYQoyqBdCviN0Bb6e0ftp8qmbAbYaOkoxOUEf95PlTr8uMhnb0ue
 2jiBB9dK0kmsMPwDSmmmYKB8ZhT1U4pC2Mhi0qoWydqyBheV+txsbQy2ytWyfWzPOQ
 cbJbeeMdHbzgIRTZdlMcKUBFverUqOxQKm/jLfYr/yIKUTgWnYGgKDEVcBqDa4IMjl
 kspFES2KJA7uOE9JzHKGoKzbM88S2KR6m2WxTTiIy5ejxaXc7j60sLVJYoowBIeVJz
 bjuDEvN7BPB8WP4Jc2CQ8rdkFgfDqT/C8x2pmysZaRW3nZHhcvW76WDxQBjcbatDSq
 J92KgWAQ2SCGQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:18 +0200
Subject: [PATCH 55/75] drm/atomic-state-helper: Rename
 connector_tv_margins_reset to state_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-55-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Ruben Wauters <rubenru09@aol.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6203; i=mripard@kernel.org;
 h=from:subject:message-id; bh=na7ehGrt/jk27d7BAov2bCwf/ccmv0sKzBKRZZ6prdc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnndycpiPx4n7ztfoD432VHvzXyunM6Sh9W3iC62E/j+
 v2Hb3QPdkxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJzHjAWKfX9vUJv86+GlGF
 oMfXG5MnND+an+47ZwtnqSpfpBOLq1+hk4ruU00twcNLPOsPTSitZazTT/i/4JPX0yPKq5ZfP+n
 JsFLinMwbh0jeqVEeK+O+V3rKbir7FuFXeVfwWDnPk6eveO4CAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Recent commits renamed other reset helpers to use the state_init
suffix when they only initialize properties rather than allocate or
update the object state itself.

drm_atomic_helper_connector_tv_margins_reset() falls in the same
category: it initializes the TV margin properties from the kernel
command line without allocating any state. It also reads the
connector state through connector->state, coupling it to the reset
path.

Rename it to drm_atomic_helper_connector_tv_margins_state_init() and
pass the connector state explicitly as a parameter. This decouples
it from the reset hook and prepares for the conversion to
atomic_create_state where connector->state is not yet assigned.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Ruben Wauters <rubenru09@aol.com>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 14 ++++++++------
 drivers/gpu/drm/gud/gud_connector.c       |  3 ++-
 drivers/gpu/drm/vc4/vc4_hdmi.c            |  3 ++-
 include/drm/drm_atomic_state_helper.h     |  3 ++-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index 406157a3660f..6238066fd5d6 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -480,26 +480,27 @@ drm_atomic_helper_connector_create_state(struct drm_connector *connector)
 	return state;
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_create_state);
 
 /**
- * drm_atomic_helper_connector_tv_margins_reset - Resets TV connector properties
+ * drm_atomic_helper_connector_tv_margins_state_init - Initializes TV connector properties
+ * @state: the DRM State object
  * @connector: DRM connector
  *
- * Resets the TV-related properties attached to a connector.
+ * Initializes the TV-related properties attached to a connector.
  */
-void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector)
+void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
+						       struct drm_connector *connector)
 {
 	struct drm_cmdline_mode *cmdline = &connector->cmdline_mode;
-	struct drm_connector_state *state = connector->state;
 
 	state->tv.margins.left = cmdline->tv_margins.left;
 	state->tv.margins.right = cmdline->tv_margins.right;
 	state->tv.margins.top = cmdline->tv_margins.top;
 	state->tv.margins.bottom = cmdline->tv_margins.bottom;
 }
-EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_reset);
+EXPORT_SYMBOL(drm_atomic_helper_connector_tv_margins_state_init);
 
 /**
  * drm_atomic_helper_connector_tv_reset - Resets Analog TV connector properties
  * @connector: DRM connector
  *
@@ -568,11 +569,12 @@ void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector)
 	if (prop)
 		if (!drm_object_property_get_default_value(&connector->base,
 							   prop, &val))
 			state->tv.hue = val;
 
-	drm_atomic_helper_connector_tv_margins_reset(connector);
+	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+							  connector);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
 
 /**
  * drm_atomic_helper_connector_tv_check - Validate an analog TV connector state
diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index 8141c3a1e30a..a57f2565d33e 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -352,11 +352,12 @@ static void gud_connector_reset(struct drm_connector *connector)
 	struct gud_connector *gconn = to_gud_connector(connector);
 
 	drm_atomic_helper_connector_reset(connector);
 	connector->state->tv = gconn->initial_tv_state;
 	/* Set margins from command line */
-	drm_atomic_helper_connector_tv_margins_reset(connector);
+	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+							  connector);
 	if (gconn->initial_brightness >= 0)
 		connector->state->tv.brightness = gconn->initial_brightness;
 }
 
 static const struct drm_connector_funcs gud_connector_funcs = {
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 3a90dbb61f4e..cf84eff847d1 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -507,11 +507,12 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
 
 static void vc4_hdmi_connector_reset(struct drm_connector *connector)
 {
 	drm_atomic_helper_connector_reset(connector);
 	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
-	drm_atomic_helper_connector_tv_margins_reset(connector);
+	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+							  connector);
 }
 
 static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 	.debugfs_init = drm_hdmi_connector_debugfs_init,
 	.force = drm_atomic_helper_connector_hdmi_force,
diff --git a/include/drm/drm_atomic_state_helper.h b/include/drm/drm_atomic_state_helper.h
index 4706eeab52c1..4dac741af22c 100644
--- a/include/drm/drm_atomic_state_helper.h
+++ b/include/drm/drm_atomic_state_helper.h
@@ -72,11 +72,12 @@ void drm_atomic_helper_connector_reset(struct drm_connector *connector);
 struct drm_connector_state *
 drm_atomic_helper_connector_create_state(struct drm_connector *connector);
 void drm_atomic_helper_connector_tv_reset(struct drm_connector *connector);
 int drm_atomic_helper_connector_tv_check(struct drm_connector *connector,
 					 struct drm_atomic_commit *state);
-void drm_atomic_helper_connector_tv_margins_reset(struct drm_connector *connector);
+void drm_atomic_helper_connector_tv_margins_state_init(struct drm_connector_state *state,
+						       struct drm_connector *connector);
 void
 __drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector,
 					   struct drm_connector_state *state);
 struct drm_connector_state *
 drm_atomic_helper_connector_duplicate_state(struct drm_connector *connector);

-- 
2.55.0

