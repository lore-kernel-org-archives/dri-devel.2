Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AE5CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D532410E02D;
	Tue, 29 Sep 2026 08:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hW619DUl";
	dkim-atps=neutral
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357CD10E02D
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 08:02:02 +0000 (UTC)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-88272e1d069so1613018b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 01:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790668922; x=1791273722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SSQZyZEz06a3fdZn5+IeTwoBHZwphcMSLAQAOls5WNY=;
 b=hW619DUlKsRb4++uKuoSB77GImqRdURKxr8Rd35N+sHfqDsnyFE/tfyLr0nRBu5P2I
 RnL99n08hMaG4RlguyhE/rPjsu6BtTrTZo87WXt57L5cPYHfrhcgOYNFj8v2L4b2j0fZ
 sU6tcYpPYfeTyrTgaJJgrrSRn85GkThrlbaFxjX2xHaUtMXupHD5LrsI6rDxFEeYmOgT
 thPwok2WxvE87jOzfIzqOhhB6L64QWUxlKZF+MfQeTqxaugP+LIg6n5SphF/Rg2kKkdH
 5P3xC0+919G20Klzat4QnEWayoeSv1fJsdICj3mZZZKL7R3DXI1YRTG5+FuEIg+Ra7Hl
 WLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790668922; x=1791273722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSQZyZEz06a3fdZn5+IeTwoBHZwphcMSLAQAOls5WNY=;
 b=R88l6mndfCvP7rCRsLM8FbNsx9ehW7h/czJb+be+Ryg/R3nf6XwbsD5Gd4+xmhEPJ7
 mSTPejujWtmKBnGbV7hAmXcIr4OedMsTQXhL545PfBLUx5JBsR9Cdojvx9hU+wdJTKki
 /fvvcoNbt4WaJo2E+M21KDh7mywvA4+FgCqEcgMptVWTi3IcvtxwsdReNVCvUbEAzCvk
 Utk1nZSk5G4YxV+5yCWVmidEl7UBCFvvGedmECw9bYFgB4uh0IdZ9xnTypHu14zpYl7F
 Yecy+gSpgm3qr9epUP/6Zr+FmY0SWmLZmjqQkN05loSfy5s8sLL94DwjWHFSfEZKt7Yn
 M7uA==
X-Gm-Message-State: AFuF++ksmp2Cbxd0pVueCIMlmbTunnLJFa/JvHhyLy7m0hJWGPyPOsb3
 qrE1xws7m9+v8CoMAusUheonh34f7mUUH/Gi6Bjthg+SyEQley6NNNN4
X-Gm-Gg: AYBFou1pl4aOMqQ+kL3Rt2qAUK4jC9bgKjTxoYoQIP3HY27bhBdyWCKoFzpCpVwgcT8
 IGbJZ+XxlfVlm0kQWnIweo9FcZb8B59ySORu3OAyVW3D8qxmx9E9fc1BUXkS0gowwJlfpRshZk4
 0M8TbMd2fmhArC0gtfm/ZwRdq/f5xoMhFTPzn+caJdQmEuvYnlo0uj/U2w3uMP8PJ1YEzvNRDA1
 aw/wZV2qYJvMQuYbGOVte/eHx3eag469RtLlsr6WaMmo5vZY0yNOgCmUq4DHI9zlzqNg/Jy3i7M
 z6dfBe0465FWctAK/tVHwtV2mKYKspDPQIWh2FAlEJlBoYLU2LrISHBsktAjtn5eAO4BEHrFX8y
 +dFcVRknJxMwH6pXfTE+2/Vr7/IuNGEXSPgCR+1BNCTp4PHFF+U4k3z1PDJ7BdFKwF2OUeJUVRs
 X+Xv8ThIJ5E7e0opsCFb3QFW2w/a/Q0IwhIB0eBdKqSeO4VKHuZQE4FUc6vdpOrmqg8TtsJa4Rs
 KLr5jLxPePxVSR3HD2+i5C7zEirimx9xthcakn/IL3gHn7mRECs+jrF
X-Received: by 2002:a05:6a21:820c:b0:3da:ebec:69c1 with SMTP id
 adf61e73a8af0-3de26c83b87mr11531089637.24.1790668921486; 
 Tue, 29 Sep 2026 01:02:01 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP ([123.51.235.159])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1067425sm372775b3a.13.2026.09.29.01.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 01:02:01 -0700 (PDT)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH] drm/panel: ronbo-rb070d30: Use mipi_dsi_*_multi() functions
Date: Tue, 29 Sep 2026 16:01:43 +0800
Message-ID: <20260929080143.559685-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Replace the deprecated mipi_dsi_dcs_exit_sleep_mode() and
mipi_dsi_dcs_enter_sleep_mode() calls in the enable and disable callbacks
with their _multi variants, as suggested in Documentation/gpu/todo.rst.

The callbacks retain the same return values. The new helpers additionally
log an error if the command fails.

Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    Compile-tested on arm64 with W=1; not tested on hardware.

 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
index c3fbc459c..ebe6352db 100644
--- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
+++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
@@ -75,15 +75,19 @@ static int rb070d30_panel_unprepare(struct drm_panel *panel)
 static int rb070d30_panel_enable(struct drm_panel *panel)
 {
 	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	return mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	return dsi_ctx.accum_err;
 }
 
 static int rb070d30_panel_disable(struct drm_panel *panel)
 {
 	struct rb070d30_panel *ctx = panel_to_rb070d30_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
-	return mipi_dsi_dcs_enter_sleep_mode(ctx->dsi);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
+	return dsi_ctx.accum_err;
 }
 
 /* Default timings */
-- 
2.43.0

