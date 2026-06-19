Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EC5CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C8710F5AF;
	Fri, 19 Jun 2026 12:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IQzVlels";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DAC610F5A7
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:27:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D2A9601EE;
 Fri, 19 Jun 2026 12:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562601F000E9;
 Fri, 19 Jun 2026 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872053;
 bh=Lf535QyZCex7JQ2a7o9ANcaV5PHkieAcb90gA4YNnns=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IQzVlelsdmDgHRopqcPvD4iPPOJZor+5H/o9B7+wzAydz+B1gs9gvVAWimFotJ9Vk
 pfTJ1lSlfUc0R3uOXs8+60PpnjHBCnKFkAk/nnUDkSYM2bPqGx5UUbVHWypyIwW0ZJ
 e3Y/tBq+mUK7PafFuiIr+MS+C9IvbpNrknQ8lAf6T+HpaIzLTF2P1G5k7cTAhap2X2
 Tuwu8tM7JEb4Af85okWptu7U5+4HoeThrxoOaLO3ohK6D2eqSh30Tjk1W2i0wpQluz
 HaVEpRF5luOtoV/PV3W/OWLg0L+ok2zXXmlGx1FsXEnBzmFSivdVTOANdPrnOMvaa+
 pWoeV964tSxpA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:07 +0200
Subject: [PATCH v3 62/78] drm/renesas: rcar-du: mipi_dsi: Switch to
 atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-62-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=mripard@kernel.org;
 h=from:subject:message-id; bh=bacVvb6kDoR91wSeLjd3x7j+m9ph7MurfY3FVR33UKk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmpqwXX+lp5kxSPnQ7U+vqlAcPVec9LZqw8Mfj5I3so
 gk6mj2POqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEmOsYG3rusK9Vd13HIfTw
 zNlv+5UcQ8+vNXS5aejd4/LoecznjS8tY4sFDLfM0S6cPMt6/pnFDYx1Om1Ba9S+vlgct8hd+Fx
 QxyuZRRJL3tU0dun1NDGobJl16uQEqxNqYjvl7y5K4jSNCCoEAA==
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index aaafee1c060b..6e46d6d99f3c 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -922,11 +922,11 @@ rcar_mipi_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs rcar_mipi_dsi_bridge_ops = {
 	.attach = rcar_mipi_dsi_attach,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_enable = rcar_mipi_dsi_atomic_enable,
 	.atomic_disable = rcar_mipi_dsi_atomic_disable,
 	.mode_valid = rcar_mipi_dsi_bridge_mode_valid,
 };
 

-- 
2.54.0

