Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D427CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 14:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F9A10E9C7;
	Sun,  4 Oct 2026 14:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OIly5H5p";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45B6610EA79
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 14:50:20 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C98314394F;
 Sun,  4 Oct 2026 14:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A42A1C2BCB9;
 Sun,  4 Oct 2026 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791125419;
 bh=ksNh/cGrEv1PgupfeXYl3pyjEDpGERY+1FVkyy1VR28=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=OIly5H5pCnSTczTQArt7HZa6P6KS2y6CYkzLuUgX9Q+/IYH7WMRN70J042jE+FeE2
 N6i7ujPPOXpsvOZP56HOCk9PQGSVpsXK6wWCLrVJV0BFDznwmigBtxIN6EXuDJvK/l
 lw/aTs1gFtloYtxTLTMCoFZYquc9o3ZCKYfztoTkpBg/myYvcbGKrLVzXvM4dDbp0D
 +dgx+BQy8hEP+IXe9k7zb10w3FM1D8tBZnXvdTl0sdyWjBcDwQgG9dn9eEdZve67oJ
 tkyeowW+cw2YGpt65wm2xGqrsWt1+D4DeWCLzykf+CYY4SWX/IzH9p2VMeyaA7bvV9
 +bpCO1JcdjWxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDE4CA5FCE;
 Sun,  4 Oct 2026 14:50:19 +0000 (UTC)
From: Shigeaki Asai via B4 Relay <devnull+y-asai.0816.docomonet.jp@kernel.org>
Date: Sun, 04 Oct 2026 23:50:17 +0900
Subject: [PATCH] drm/meson: encoder_dsi: load ENCL gamma table while ENCL
 is disabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-meson-gamma-v1-1-6347558e2bb3@docomonet.jp>
X-B4-Tracking: v=1; b=H4sIAKhnwmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDAwMT3dzU4vw83fTE3NxEXWNjAzMjU/NkgxQjCyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgDtxUAKbwAAAA==
X-Change-ID: 20261004-meson-gamma-3306257c0d28
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Nicolas Belin <nbelin@baylibre.com>, 
 Jagan Teki <jagan@amarulasolutions.com>
Cc: dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, John Williams <porschemad911@gmail.com>, 
 Shigeaki Asai <y-asai.0816@docomonet.jp>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791125418; l=2799;
 i=y-asai.0816@docomonet.jp; s=20261004; h=from:subject:message-id;
 bh=epdsIAmy9JIKhg6OxImAsy/RAjs7ztCfGy7gPcYMgNE=;
 b=h1/oYAEa0HS+pqwwtr8ShKjfVW0AjgRlYY9z53yxUQUK0hbzAlVR8WNCPGetlPDMDGiY6cTF2
 en6s7mGAgp2D8IBtRWbfgNkpTT4Jym6j+2p7MFWctL/CZY5Yu0idK3I
X-Developer-Key: i=y-asai.0816@docomonet.jp; a=ed25519;
 pk=jkd95ViSn8i/X3oPMHYG1A8mae8IOwOKGE64kzLqC5c=
X-Endpoint-Received: by B4 Relay for y-asai.0816@docomonet.jp/20261004 with
 auth_id=1110
X-Original-From: Shigeaki Asai <y-asai.0816@docomonet.jp>
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
Reply-To: y-asai.0816@docomonet.jp
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Shigeaki Asai <y-asai.0816@docomonet.jp>

meson_encoder_dsi_atomic_enable() programmed the ENCL gamma LUT right
after meson_venc_mipi_dsi_mode_set(), i.e. while the ENCL timing
generator was already running (ENCL_VIDEO_EN=1). Writing the LUT
during active video stalls the hardware: L_GAMMA_CNTL_PORT
WR_RDY/ADR_RDY deassert and the ENCL line counter (ENCL_INFO_READ)
freezes, so every remaining write times out (~8s total at boot) and
the panel ends up with a corrupted gamma table (wrong colors).

Instrumented boots on the ODROID-GO Ultra (S922X) show:

  failing:  start: VIDEO_EN=1 INFO 0000001a->002d0000 GAMMA_CNTL=00000030
            stall: INFO 002d0000->002d0000 GAMMA_CNTL=00000000
            (VID_CLK_CNTL2 / VIID_CLK_CNTL / VIID_CLK_DIV unchanged,
             i.e. the ENCL clock is still running)
  fixed:    start: VIDEO_EN=0 INFO 00000000->00000000 GAMMA_CNTL=00000030
            no stall, no timeout

Whether it failed depended only on timing, which is why enabling
lock debugging (LOCKDEP etc.) appeared to "fix" it most of the time.
It happens regardless of the bootloader (mainline or Hardkernel vendor
U-Boot).

The function already writes ENCL_VIDEO_EN=0 right afterwards before
re-enabling the encoder, so simply move meson_encl_load_gamma() after
that write. This matches the order used by the vendor U-Boot's own LCD
driver, which never times out.

Tested on the ODROID-GO Ultra with mainline U-Boot: 5 cold boots +
3 warm reboots, no timeouts, correct colors, LOCKDEP disabled.

Fixes: 42dcf15f901c ("drm/meson: add DSI encoder")
Cc: stable@vger.kernel.org
Tested-by: John Williams <porschemad911@gmail.com>
Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
---
This was found on the ODROID-GO Ultra while bringing it up on
Lakka / ROCKNIX. Happy to test any alternative approach.
---
 drivers/gpu/drm/meson/meson_encoder_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_dsi.c b/drivers/gpu/drm/meson/meson_encoder_dsi.c
index faa309cb97a6..912cd676bbe2 100644
--- a/drivers/gpu/drm/meson/meson_encoder_dsi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_dsi.c
@@ -65,9 +65,9 @@ static void meson_encoder_dsi_atomic_enable(struct drm_bridge *bridge,
 	/* ENCL clock setup is handled by CCF */
 
 	meson_venc_mipi_dsi_mode_set(priv, &crtc_state->adjusted_mode);
-	meson_encl_load_gamma(priv);
 
 	writel_relaxed(0, priv->io_base + _REG(ENCL_VIDEO_EN));
+	meson_encl_load_gamma(priv);
 
 	writel_bits_relaxed(ENCL_VIDEO_MODE_ADV_VFIFO_EN, ENCL_VIDEO_MODE_ADV_VFIFO_EN,
 			    priv->io_base + _REG(ENCL_VIDEO_MODE_ADV));

---
base-commit: 70456f05d4b6396b22048c4b8cd3cb98ecf9f9e3
change-id: 20261004-meson-gamma-3306257c0d28

Best regards,
--  
Shigeaki Asai <y-asai.0816@docomonet.jp>


