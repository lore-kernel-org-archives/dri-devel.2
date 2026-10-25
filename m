Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0551606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W6QTABE2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C893B10EC86;
	Mon, 26 Oct 2026 08:37:24 +0000 (UTC)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782DD10E168
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 14:26:56 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3ae1d0caaedso25818a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 07:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792938416; x=1793543216; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JCokAAgAWjsPtUD0NKsGFk/Sx5sgBs2gnUzEQm6U42Q=;
 b=W6QTABE2YZ0BagI8+Y9mgcfVYyn9EMJ+MA773xhraCnTlB3FQG1WTSTExqPvVGQeNd
 ArFgB4KS1eijujevDTvS65h7SHqQTq0FbbP5xzUnZ37iqAn19hbGvGoKPTvv1q/T7M+f
 aPQ9xngAhM8rBiAqAShxMTXOoJYbgO6ekfz40Z8+z5p34riPhchdzKOXcn3Xkh4jgxPF
 IWxWJxXIAnguGdqMewKln89BNycwZJIqEFjcKK0w5r0Pgis3BDxT/gf0upIX1oicQC+N
 jfuVsP/l+ex0/tLnXWPE/h1tO4BBcYNdjI5I/gBHQ1/i/8oY2P82S62eMyxEV690JkEU
 dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792938416; x=1793543216;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JCokAAgAWjsPtUD0NKsGFk/Sx5sgBs2gnUzEQm6U42Q=;
 b=FSKwcq8+rMXHFWQyPrZbD/18kwvURBjNMEyvQ1WihwxSHFiWqKL6skoTK8reJsBpPv
 zeYHynyATRMK7ZoSP1ENt6OzS7vTMlLIseYCarCfe3c2Heym3ZROYQVW/lHzKqUq0kFk
 +fkDsoYNslMu4DPngFXCD927/hYYaep6Hs2uJrQm0Jk6CqhZiLNTxrcR8SKgAzo8IIxG
 +BLR5ELOp4JAIaFTlgMirxsWNw27vcJsIeA4yXvmeYpbk4dAcRH2ItCfetuXGeLGjfUJ
 7S2SX72HZ/ejdPC3rXDE4Gq7FPdr7maklAQaWQjLJfIB6ole+ggHnIwJZyf2Wy7/x1qB
 GzNQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByK0EaFItGBQEovTXETEq0XjrvZVzdoBjifLBB3yES7P67wiWJR0OArXYel7klTJay23WXjRABB3j4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIM/QYiRI5FpiXa3kPMflYNQdWJikLyKAvXYmzOGJZAjbWuuJ6b
 v9rmCjtxKskn0fCiuqo2KIpj2I9wsLFOq9cqxyRn5eUqMChbgIPL/ZY4
X-Gm-Gg: AYBFou1m7Ce56DRjosA+6c8mATTTbak2O7XSQgbWClkPCkRlrMIdz300eOyAcZQv6wj
 7pnbcDDLq7NuEZSbKkNj9/MK6j2//+uckmeDAhds7+lMLrp9xblXdNrA6nHZRiFgCHa3089Ago9
 D72OKX0qBanbcYOWcnaBvykzDn+Q2cNrx3rsXJy6gKwmhY1TSk8iVy74TYa9lnVPoIDPgu88hVA
 CrUEK5xPEfK347ggKCnpay/8mLfQ2FNUoqE22rDO+1jYHE0FfK6u/pCMNJOazSrvwevpubypCEF
 1gzgm8qRNU2UwH86ddkVpBTVJIFiPTADR3NlcLRpEBsSPhRqzUUHJ5QQFNlk4CyuKqiggyGDQ/G
 4siUPPN5SYtXDHZgMzsbQYT6laG1qT5Cbt1Y0xhhTNkM8Eh+/EQwoFnZsZ5i4yk31E3B0m0j3pc
 g16KKXC4GHeATV9LfsHDUjRgWnS8vKq7ZYd7/10jEjOY5EiiS7NKNxmEiiDi3G82l9kvZk/Wpnq
 NsVTUWr+FLMjJb4re6EdAOjXt43L/3PzeTMvnh+iUH6KBcVQHYQ7lVBwMVZHZJ+oPxk6sxCCV1H
 bgtySH8LUQJwEN/4ElkXfpaGYqKj/Vbu6YdXMpXcf+rsAfLwGO+G6nUvSu+o5IT9BKP8V10=
X-Received: by 2002:a17:90a:d2c7:b0:3ac:9706:7735 with SMTP id
 98e67ed59e1d1-3ade9b2d476mr3991234a91.5.1792938415936; 
 Sun, 25 Oct 2026 07:26:55 -0700 (PDT)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:4c3:3a00:d533:9d50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb0977asm5068848a91.13.2026.10.25.07.26.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 07:26:55 -0700 (PDT)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: dw-mipi-dsi: use the lane rate for lbcc when
 lanes run faster
Date: Sun, 25 Oct 2026 15:26:39 +0100
Message-ID: <20261025142639.3454322-1-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit ac87d23694f4 ("drm/bridge: synopsys: dw-mipi-dsi: Use pixel clock
rate to calculate lbcc") counts HSA, HBP and HLINE from the pixel clock,
which is only right when the lanes run at the pixel bandwidth (pixel
clock * bpp / lanes). Commit 93e82bb4de01 ("drm/bridge: synopsys:
dw-mipi-dsi: Fix hcomponent lbcc for burst mode") went back to the lane
rate for burst mode, where the lanes are faster on purpose.

The Rockchip glue runs the lanes faster in every mode: it adds 25% to
the pixel bandwidth, or uses the rate the panel asks for. In non-burst
video mode the line programmed in lane byte clocks is then shorter than
the DPI line. On the GPD XD (RK3288, ILI9881C panel, 4 lanes at
752 Mbps, 59.5 MHz pixel clock, htotal 747) HLINE was 561 lane byte
clocks (6.0 us) for a 12.55 us line: the DPI payload FIFO overflows
(dpi_pld_wr_err in DSI_INT_ST1) and the panel shows garbage as soon as
a client page-flips.

Use the lane rate when it is clearly above the pixel bandwidth (more
than 1/8), and keep the pixel clock formula when both match, as on
i.MX93, Meson and STM in non-burst mode, where lane_mbps is the pixel
bandwidth rounded up to the next MHz. On the GPD XD this gives HLINE
1181, HSA 21 and HBP 7, and the picture is stable.

Fixes: ac87d23694f4 ("drm/bridge: synopsys: dw-mipi-dsi: Use pixel clock rate to calculate lbcc")
Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
Notes for reviewers (not for the changelog):
- The 1/8 threshold separates glues that report the pixel bandwidth
  rounded up to the next MHz (i.MX93, Meson; STM in non-burst mode) from
  Rockchip, which adds 25% in every mode. If a per-glue flag is
  preferred instead of a threshold, I can rework it that way.
- Testing: built with W=1 for arm (multi_v7) and arm64 (defconfig),
  DRM_DW_MIPI_DSI=y and =m, no warnings. Tested live on the GPD XD
  (RK3288, ILI9881C, non-burst with sync pulses), 6.18.54 with this
  exact change applied: HLINE 1181, HSA 21, HBP 7 read back from the
  DSI host, no dpi_pld_wr_err in DSI_INT_ST1 while the UI page-flips,
  and a clean picture in the UI and in games (before the change: garbage
  as soon as a client page-flips).
  Not tested on i.MX93, Meson or STM hardware; for them the computation
  is unchanged unless the lane rate is more than 1/8 above the pixel
  bandwidth.
- Tool disclosure: this patch was prepared with Claude Opus 5.5
  (Anthropic) as a coding assistant, in an interactive session where I
  asked it to bring up the GPD XD display and then to prepare the fix
  for upstream. It located the cause from the DSI host registers, went
  through the history of the lbcc computation (ac87d23694f4,
  93e82bb4de01) and the lane rates of the other dw-mipi-dsi glues, and
  drafted the code change and the changelog. I reviewed and understand
  both, and tested the patch on the GPD XD as described above.

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 23 +++++++++++++------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 22d1b8cbe1..b026b602ab 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -781,19 +781,28 @@ static u32 dw_mipi_dsi_get_hcomponent_lbcc(struct dw_mipi_dsi *dsi,
 					   u32 hcomponent)
 {
 	u32 frac, lbcc, minimum_lbcc;
+	u64 pixel_kbps;
 	int bpp;
 
-	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
+	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
+	if (bpp < 0) {
+		dev_err(dsi->dev, "failed to get bpp\n");
+		return 0;
+	}
+
+	/*
+	 * Use the lane rate when it is above the pixel bandwidth (burst, or
+	 * glues adding margin in all modes); the 1/8 slack ignores lane_mbps
+	 * being rounded up to the next MHz. Otherwise the pixel clock is more
+	 * precise.
+	 */
+	pixel_kbps = div_u64((u64)mode->clock * bpp, dsi->lanes);
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST ||
+	    (u64)dsi->lane_mbps * MSEC_PER_SEC > pixel_kbps + pixel_kbps / 8) {
 		/* lbcc based on lane_mbps */
 		lbcc = hcomponent * dsi->lane_mbps * MSEC_PER_SEC / 8;
 	} else {
 		/* lbcc based on pixel clock rate */
-		bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
-		if (bpp < 0) {
-			dev_err(dsi->dev, "failed to get bpp\n");
-			return 0;
-		}
-
 		lbcc = div_u64((u64)hcomponent * mode->clock * bpp, dsi->lanes * 8);
 	}
 

base-commit: cf61bef3801c3c9d0d8c39026b7b2fb242898a3a
-- 
2.43.0

