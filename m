Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65BDC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FE010FEFD;
	Wed, 14 Oct 2026 17:30:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5AF810FEFD
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:30:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D898560229;
 Wed, 14 Oct 2026 17:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153F01F000C4;
 Wed, 14 Oct 2026 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791999050;
 bh=DbSuhGcU5F2AudOqjawBMeENfozP8H5WOsGmSV1ZOEI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ls/wC7FHf0dFNpmbTLsuMoQOA1oDVdEF1yaadRDiLZCGwB2L6WC9b3AmxBy3Ozogp
 ou+GPvgdPiIWERdrGFjq65sOgwO16oC8dkxZKIGOJqx7Pzz7jWxwRTzrsriAVu3pGY
 b2BMmVNVtYFshe0Y3o3XdGG7ANEohwawvI9ALW3hRoxUqYKIR3drQuVztO4Kgg1J4/
 vxlZOZVYGXgoCzh1qErRfe4fkTWizHvWmcIK4JQWQ5+avt5CpYFN9+36Js2K3DL7qN
 MiY377V2ZhoNaXdYQtE/UiduFLkKvLMmCxaIIFJkI3BgzeHN/WqAPR/IFwWGvKSBz2
 oMathAKpOf7Ag==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:23 +0200
Subject: [PATCH 60/75] drm/sun4i: hdmi: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-60-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138; i=mripard@kernel.org;
 h=from:subject:message-id; bh=i8MYkIjGLYh93ZYp+TwUqmFpGoWQ2CROBOjcXchRZbM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd6eYpKx6p3VXbf/n0h/uNYYlh8XTrHyS766etlkpf
 ZXR1qWbO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEKhMY66wT/qgydzzZeqY6
 VDbx5mz9LYVlB8IaHk7ZW+R91X5KNFv5rttiu69qvBXvdmzqlg3PZWxYVqyctOPyude1N9SEXVg
 8/D/nvDjJHSM095/zMouT2UHbXvh4N8vsOuO32t3yccykU2wA
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

The sun4i HDMI connector reset implementation creates a pristine
state and initializes the HDMI state. It does not perform any
hardware reset.

Since this is equivalent to what atomic_create_state expects, convert
the reset function to an atomic_create_state hook that returns the
initialized state.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Chen-Yu Tsai <wens@kernel.org>
Cc: Samuel Holland <samuel@sholland.org>
Cc: linux-sunxi@lists.linux.dev
---
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index d98b6f12a7bc..1226228c2ab3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -283,21 +283,30 @@ sun4i_hdmi_connector_detect(struct drm_connector *connector, bool force)
 	}
 
 	return connector_status_connected;
 }
 
-static void sun4i_hdmi_connector_reset(struct drm_connector *connector)
+static struct drm_connector_state *
+sun4i_hdmi_connector_create_state(struct drm_connector *connector)
 {
-	drm_atomic_helper_connector_reset(connector);
-	__drm_atomic_helper_connector_hdmi_state_init(connector, connector->state);
+	struct drm_connector_state *connector_state;
+
+	connector_state = drm_atomic_helper_connector_create_state(connector);
+	if (IS_ERR(connector_state))
+		return connector_state;
+
+	__drm_atomic_helper_connector_hdmi_state_init(connector,
+						      connector_state);
+
+	return connector_state;
 }
 
 static const struct drm_connector_funcs sun4i_hdmi_connector_funcs = {
 	.debugfs_init		= drm_hdmi_connector_debugfs_init,
 	.detect			= sun4i_hdmi_connector_detect,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
-	.reset			= sun4i_hdmi_connector_reset,
+	.atomic_create_state	= sun4i_hdmi_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
 #ifdef CONFIG_DRM_SUN4I_HDMI_CEC

-- 
2.55.0

