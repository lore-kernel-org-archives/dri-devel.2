Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064BCC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 21:21:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4781A10F7A7;
	Thu,  3 Sep 2026 21:21:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BsQ34vqB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6B7B10F7A7
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 21:21:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9D2A560A68;
 Thu,  3 Sep 2026 21:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460641F000E9;
 Thu,  3 Sep 2026 21:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788470493;
 bh=n3EsoaIzcA525F0lJH8ShpS0ULNbgO24l+g3orWPlRQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BsQ34vqBqZ9jTzSQ527A2qQontApW5zby7KJJnR1rD4Gmn6bSpGSGxSw7lh55tvrj
 EdtTZTVT2yldtmVrxHgAkI8qsE4kTrHhwK7s831FOZ5tezsFqbwheec7heRxypPm/C
 UmskJ7yUHvLwAPYVUev2g3SpS/Sire/Ol6GxS7ngmdqzgNiEP9OV1RphEnTc8gK2XV
 VKXvwQaJ5Iiddb0b23c+inJVZ3EfHksTSq0NeWoP+QVkwYK7b6RC12eAWx8yuAcAEo
 3JKPQk4Js9M3xeFfNX/zkkZ11ueMGCXh5zEX3xmmXj/xl/B5lcunWAGKSpFwVxJLk8
 JbA3xIkqE+0hQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 03 Sep 2026 23:21:20 +0200
Subject: [PATCH 2/2] drm/panel: samsung-s6e88a0-ams452ef01: Use test key
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-drm-panels-sofef0-v1-2-9e841645beba@kernel.org>
References: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
In-Reply-To: <20260903-drm-panels-sofef0-v1-0-9e841645beba@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 David Heidelberg <david@ixit.cz>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0
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

The F0 command pair in this driver is already documented as enabling
and disabling level 2 commands. Replace the raw writes with the shared
level 2 test key helpers.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
index ca5cad41ff1d..e816783081c2 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
@@ -13,6 +13,8 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 
+#include "panel-samsung-dsi.h"
+
 struct s6e88a0_ams452ef01 {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
@@ -43,7 +45,7 @@ static int s6e88a0_ams452ef01_on(struct s6e88a0_ams452ef01 *ctx)
 
 	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
 
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0x5a, 0x5a); // enable LEVEL2 commands
+	samsung_dsi_test_key_on_lvl2(&dsi_ctx);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xcc, 0x4c); // set Pixel Clock Divider polarity
 
 	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
@@ -66,7 +68,7 @@ static int s6e88a0_ams452ef01_on(struct s6e88a0_ams452ef01 *ctx)
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xb6, 0x2c, 0x0b); // set default elvss voltage
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_WRITE_POWER_SAVE, 0x00);
 	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf7, 0x03); // gamma/aor update
-	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xf0, 0xa5, 0xa5); // disable LEVEL2 commands
+	samsung_dsi_test_key_off_lvl2(&dsi_ctx);
 
 	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 

-- 
2.55.0

