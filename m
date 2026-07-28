Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1BC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 01:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4A010E30F;
	Tue, 28 Jul 2026 01:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Pk5T4FRJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E6410E30F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 01:02:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6583F600FC;
 Tue, 28 Jul 2026 01:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14617C19425;
 Tue, 28 Jul 2026 01:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785200531;
 bh=Ua55qntkf6FUa/odovy4VEDVDrXVjb+9HiEv/tsrxaM=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=Pk5T4FRJrfYnDjVXzp9TFAjKyO8KY5Nb8eJD386vlcOUKS7RVuO3t/TaIPxUeshPP
 kuAJEKeC4vflTr2wz3trNsJnnXSGAMVdUXKmOj5oCVgHnaQ6dnsjAU5hj301AFxb1D
 BtOUsZNhAWbkl7q4D52YzI4NZY6DEn3hnFg3B33td+WmRWrq5TUQwk+xshfjSqeXef
 tG2lDwCWAnUoH1PKnvEGPORPCVk1SjFioy+iZ0ntR4r/KtG7tELJZcqCH+Elwo9P14
 Bra98JWm5sFkXWb0bg1S4DWEOjGkoHcGnquAx5vIiKmXhdvR1jg/BiylOQuegbaCVS
 CyUhEsYhY8VZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 003F1C53219;
 Tue, 28 Jul 2026 01:02:10 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 27 Jul 2026 20:02:06 -0500
Subject: [PATCH] drm/panel: chipone-icna35xx: Fix picture parameter set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-icna35xx-pps-v1-1-691d79d13ee4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqAIBBA4avErBP8wZSuEi1Mp5qNiUII4t2Tl
 t/ivQYFM2GBdWqQ8aVCTxwQ8wT+dvFCRmEYJJcLN9Iw8tEpXStLqbAjBKUVCmu9h5GkjCfVf7f
 tvX+4sLAyXgAAAA==
X-Change-ID: 20260727-icna35xx-pps-bdd353e188cc
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785200530; l=2932;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=QTBXMwTaFmupIS6l/7ZwehPI+YvXmXkeYvJXQHLZdi0=;
 b=dtPx0sO/kojcGDbRNd9IK9D2b/Io1rnHH0Lm40mGpNetKyfuGJJtrQizGqFRde4i0wObMMxny
 Q7uJ2/ngGFzDZRKP6dc2YwRVsKRIFlTr+M96x0YXo+nojiyEq42ArQl
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

These ddic's do not handle the standard mipi dsi command for pps.
Instead, there are per chip vendor commands to write the packed struct
directly to manufacturer registers.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
This patch results in no change at runtime because the ddic defaults to
the config being set by the existing mode. The issue was found while
doing testing running the panel in a 10-bit mode. But since it is a real
problem, better to fix it early.
---
 drivers/gpu/drm/panel/panel-chipone-icna35xx.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
index 2cc16494a4cef..b2422ffc1d1c5 100644
--- a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
+++ b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
@@ -69,6 +69,7 @@ static int icna3512_init_sequence(struct panel_info *pinfo)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
 	struct drm_dsc_picture_parameter_set pps;
+	u8 *pps_ptr = (u8 *)&pps;
 
 	pinfo->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
@@ -91,7 +92,14 @@ static int icna3512_init_sequence(struct panel_info *pinfo)
 	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x48, 0x20);
 
 	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
-	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC6, 0x11, 0x88);
+
+	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC7, pps_ptr, 32);
+	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC8, pps_ptr + 32, 32);
+	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC9, pps_ptr + 64, 24);
+
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
 
 	mipi_dsi_msleep(&dsi_ctx, 20);
 
@@ -104,6 +112,7 @@ static int icna3520_init_sequence(struct panel_info *pinfo)
 {
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = pinfo->dsi };
 	struct drm_dsc_picture_parameter_set pps;
+	u8 *pps_ptr = (u8 *)&pps;
 
 	pinfo->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
@@ -133,7 +142,14 @@ static int icna3520_init_sequence(struct panel_info *pinfo)
 	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xB2, 0x24);
 
 	drm_dsc_pps_payload_pack(&pps, &pinfo->desc->dsc);
-	mipi_dsi_picture_parameter_set_multi(&dsi_ctx, &pps);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x9F, 0x01);
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xC0, 0x1A, 0x71);
+
+	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC1, pps_ptr, 32);
+	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC2, pps_ptr + 32, 32);
+	mipi_dsi_dcs_write(dsi_ctx.dsi, 0xC3, pps_ptr + 64, 24);
+
+	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0xFD, 0xA5, 0xA5);
 
 	mipi_dsi_msleep(&dsi_ctx, 20);
 

---
base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
change-id: 20260727-icna35xx-pps-bdd353e188cc

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


