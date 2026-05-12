Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8E5CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:06:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 281E510EACD;
	Tue, 12 May 2026 13:06:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CcqVM7iq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 659B410EACB;
 Tue, 12 May 2026 13:06:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4815344460;
 Tue, 12 May 2026 13:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BF4C2BCFB;
 Tue, 12 May 2026 13:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778591214;
 bh=gbVTJtwCwXKjNy5wlYr8Ght0y2FOk1OU1njW/cguZKg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CcqVM7iqa9Hw3YVZz1seoaUyVOz8cJUZZMdHRwQpaqZ+bS6GxjdChmYr/qXtx+Jsp
 muRpigbQpOQ04Y8MoDukhx3Vr1kIrwxgfw0XCyXDF7zcJ4vkWhl3BCDCNvYqiQHg2T
 2AEvahW5lwQb54Qdevs/v94655O3VMxUhufy2IDEtRVSJgJ7Xp2Pn5Fl8aPIcAyuKk
 RMpu84jUcsp8W6KPwisfSCJ76wp3HQOhvsdTVcxjw8PGhiUwmxj7bJLfnaasTpE9KE
 6n7NCEGy/Mk401R2Uyhi3fzMkusBOOmb/AJWg3fKS+iWqnh627pvXCcItB0Eo28V34
 vuKPbuvla2cgw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 12 May 2026 15:06:12 +0200
Subject: [PATCH v4 14/20] drm/hdmi: Rename
 __drm_atomic_helper_connector_hdmi_reset()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-drm-mode-config-init-v4-14-591dfdcc1bf9@kernel.org>
References: <20260512-drm-mode-config-init-v4-0-591dfdcc1bf9@kernel.org>
In-Reply-To: <20260512-drm-mode-config-init-v4-0-591dfdcc1bf9@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Simon Ser <contact@emersion.fr>, Harry Wentland <harry.wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>, 
 Alex Hung <alex.hung@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7570; i=mripard@kernel.org;
 h=from:subject:message-id; bh=gbVTJtwCwXKjNy5wlYr8Ght0y2FOk1OU1njW/cguZKg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnMqgf+Kn0siCzwXLTz1PLZhkypmj4PCtv1Uvgr2hU/5
 Sr6iBV0TGVhEOZkkBVTZHkiE3Z6efviKgf7lT9g5rAygQxh4OIUgIn802VseMm+gpNZfyODOmes
 pS+rsKbpG7ELd/5s/67KyvAgy4NRo3p3psXGmT/Zdq74ZBYZ7PKCseHiJi7WRpkMlRrnxm8N2To
 fFucWP5zP2sLXoOArr3LthVvkDDszfr9Hz+R3nta8VcO6EwA=
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

__drm_atomic_helper_connector_hdmi_reset() is typically used to
initialize a newly allocated drm_connector_state when the connector is
using the HDMI helpers, and is being called by the
drm_connector_funcs.reset implementation.

Since we want to consolidate DRM objects state allocation around the
atomic_create_state callback that will only allocate and initialize a
new drm_connector_state instance, we will need to call
__drm_atomic_helper_connector_hdmi_reset() from both the reset and
atomic_create hooks.

To avoid any confusion, we can thus rename
__drm_atomic_helper_connector_hdmi_reset() to
__drm_atomic_helper_connector_hdmi_state_init().

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/display/drm_bridge_connector.c     |  4 ++--
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 15 ++++++++-------
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  2 +-
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |  2 +-
 include/drm/display/drm_hdmi_state_helper.h        |  4 ++--
 6 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 649969fca141..50408af746d8 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -270,12 +270,12 @@ static void drm_bridge_connector_reset(struct drm_connector *connector)
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
 
 	drm_atomic_helper_connector_reset(connector);
 	if (bridge_connector->bridge_hdmi)
-		__drm_atomic_helper_connector_hdmi_reset(connector,
-							 connector->state);
+		__drm_atomic_helper_connector_hdmi_state_init(connector,
+							      connector->state);
 }
 
 static const struct drm_connector_funcs drm_bridge_connector_funcs = {
 	.reset = drm_bridge_connector_reset,
 	.detect = drm_bridge_connector_detect,
diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 4867edbf2622..83e2790fab00 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -304,29 +304,30 @@
  *		--kunitconfig=drivers/gpu/drm/tests \
  *		drm_atomic_helper_connector_hdmi_*
  */
 
 /**
- * __drm_atomic_helper_connector_hdmi_reset() - Initializes all HDMI @drm_connector_state resources
+ * __drm_atomic_helper_connector_hdmi_state_init() - Initialize all HDMI @drm_connector_state resources
  * @connector: DRM connector
- * @new_conn_state: connector state to reset
+ * @new_conn_state: connector state to initialize
  *
  * Initializes all HDMI resources from a @drm_connector_state without
  * actually allocating it. This is useful for HDMI drivers, in
- * combination with __drm_atomic_helper_connector_reset() or
- * drm_atomic_helper_connector_reset().
+ * combination with __drm_atomic_helper_connector_state_init(),
+ * drm_atomic_helper_connector_reset(), or
+ * drm_atomic_helper_connector_create_state() .
  */
-void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
-					      struct drm_connector_state *new_conn_state)
+void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
+						   struct drm_connector_state *new_conn_state)
 {
 	unsigned int max_bpc = connector->max_bpc;
 
 	new_conn_state->max_bpc = max_bpc;
 	new_conn_state->max_requested_bpc = max_bpc;
 	new_conn_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
 }
-EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
+EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_state_init);
 
 static enum hdmi_colorspace
 output_color_format_to_hdmi_colorspace(const struct drm_connector *connector,
 				       enum drm_output_color_format fmt)
 {
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 07e2afcb4f95..3cad8f9bc529 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -283,11 +283,11 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 }
 
 static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
 {
 	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_reset(connector, connector->state);
+	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
 }
 
 static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
 	.detect			= sun4i_hdmi_connector_detect,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index c9819c3fc635..e89e1af7a811 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -166,11 +166,11 @@ static const struct drm_connector_helper_funcs dummy_connector_helper_funcs = {
 };
 
 static void dummy_hdmi_connector_reset(struct drm_connector *connector)
 {
 	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_reset(connector, connector->state);
+	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
 }
 
 static const struct drm_connector_funcs dummy_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index a161d3b00a25..74dce4be0c00 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -506,11 +506,11 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
 }
 
 static void vc4_hdmi_connector_reset(struct drm_connector *connector)
 {
 	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_reset(connector, connector->state);
+	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
 	drm_atomic_helper_connector_tv_margins_reset(connector);
 }
 
 static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 	.force = drm_atomic_helper_connector_hdmi_force,
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 0adc30c55ec9..13375bd0f4ae 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -9,12 +9,12 @@ struct drm_connector_state;
 struct drm_display_mode;
 struct hdmi_audio_infoframe;
 
 enum drm_connector_status;
 
-void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
-					      struct drm_connector_state *new_conn_state);
+void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
+						   struct drm_connector_state *new_conn_state);
 
 int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
 					   struct drm_atomic_commit *state);
 
 int drm_atomic_helper_connector_hdmi_update_audio_infoframe(struct drm_connector *connector,

-- 
2.54.0

