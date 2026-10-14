Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85368C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C423F10FF04;
	Wed, 14 Oct 2026 17:31:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D0310FF04
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:31:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9E6ED41311;
 Wed, 14 Oct 2026 17:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BBD1F000C6;
 Wed, 14 Oct 2026 17:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999061;
 bh=mFUiPSF7iIk0Glba8sWaV4070u1IOu03mH+/AmeQv4o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gxe0xN45Oxbb6dcXF6uJyEDzLqsFfxsTEI4ALg9XlR7NaoIvFJ88dQ80AhYR/Z8l5
 M3XIedtHit6uEvURz6j4phNHv4hZSDj+982MuR5nQOdFXApI7rDRYyIRLevp7bBDeA
 R00PesBEy4ppwn7ObNftAjNqcHD4AAQ1tAqg7rb2pS+5xcXCGHLRrsIIV4j4Z2mwQn
 0SZ4eOk1ZfEI5iprQPzPYJqAWKp0ErxGf46f1UsuTjYTQ1qRSOhyITR9QKt05OWWQe
 J6ICo74QGlHVCjmB+Tsq4/8O9mu67R+Gw6lZ/Re2oyyxnuVfFZ6SaSpiWkjvz36GJO
 iLbRAfJAitKLA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:26 +0200
Subject: [PATCH 63/75] drm/vc4: hdmi: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-63-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3125; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zh76/4Khx+OSUn8qtGWJZuGUjH09Ig/2NX8FtZdXkCA=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6ft+ctm4Lioh+lJ2pmVDEeXvLzPOkkgR09nuuW74
 /uPpYrydExlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJGFoy1mn31DA+eRt+Uyp7
 J1dRwOKgLS4xeo/fds078PFzepTto3NPfbnnfHPq5z3a3vOVbdXGfsaG07daCv86sbBtsz61zST
 QJT/Gc9Lj6xw3XstmvG58ryI9s9HB00ZzWfnNP3InxEpbWW0A
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

The vc4 HDMI connector reset implementation creates a pristine state,
initializes the HDMI state, and sets the TV margins. It does not
perform any hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: "Maíra Canal" <mcanal@igalia.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index cf84eff847d1..bf4b19910e56 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -503,23 +503,33 @@ static int vc4_hdmi_connector_atomic_check(struct drm_connector *connector,
 	}
 
 	return drm_atomic_helper_connector_hdmi_check(connector, state);
 }
 
-static void vc4_hdmi_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+vc4_hdmi_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
-	drm_atomic_helper_connector_tv_margins_state_init(connector->state,
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	__drm_atomic_helper_connector_hdmi_state_init(connector,
+						      connector_state);
+
+	drm_atomic_helper_connector_tv_margins_state_init(connector_state,
 							  connector);
+
+	return connector_state;
 }
 
 static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 	.debugfs_init = drm_hdmi_connector_debugfs_init,
 	.force = drm_atomic_helper_connector_hdmi_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.reset = vc4_hdmi_connector_reset,
+	.atomic_create_state = vc4_hdmi_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs = {
@@ -566,12 +576,19 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 
 	/*
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
 	 */
-	if (connector->funcs->reset)
-		connector->funcs->reset(connector);
+	if (!connector->state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = vc4_hdmi_connector_create_state(connector);
+		if (IS_ERR(conn_state))
+			return PTR_ERR(conn_state);
+
+		connector->state = conn_state;
+	}
 
 	/* Create and attach TV margin props to this connector. */
 	ret = drm_mode_create_tv_margin_properties(dev);
 	if (ret)
 		return ret;

-- 
2.55.0

