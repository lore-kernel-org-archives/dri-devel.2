Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7AAC43602
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE0210E068;
	Sat,  4 Jul 2026 09:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EZb4q/mm";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924AE10E059
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:38 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so7271155e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157677; x=1783762477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vdr0BjFhIBzM2JOvPePh0SjNKUa4w0ykoB19Blh2f9o=;
 b=EZb4q/mmZR7N9WxvwkTrHj3gIryt/SsBmO28NtAF9nTB/9813F8A0cGCcPAgNa4GXB
 yEZhqqEYkRfLNfl2JC5bOLymrYrgMe6FWtAQssv7tANye9vlOuMigdlyWLX9iLeWrt1k
 IpXMsbIPxXUVVMv0zs4s2ECzhbC0O8J4To4eASd97dwOpblT9u65WigFuq6cFmtL7euy
 cDjgWVilwI97tWDJmU6CD2QxWISWxj5tSp/vHFKqtjBvHDtBfwdSNHCByoWy/0pQxypo
 GeiiaWSddFdtPMXgdyzOpyuCLCaT9QVE+kYSYZ+/3Mi7///20Ps7Md8EXiLgZwn3RBvZ
 j+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157677; x=1783762477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vdr0BjFhIBzM2JOvPePh0SjNKUa4w0ykoB19Blh2f9o=;
 b=FcmrBScO4IWiPXdmcSdYxTrxIbc7c459al5neRS7j7MvJbXn9MVk2OGLM9mWS4wK++
 cRDnvC5rb/1T6BI9YGBho7X/dC8owhXgUYP3s0vHymuG9XCYT04+mcMwToVc7rjNJcpA
 q+PsygYVPpLr3Ot7JPqth8ewdTWm7rnXUUJEmya16vx0+nHY1QASdCYdVEkrgcx0eezN
 KBnn/GIHnNfl4NM1D0y2KeFUwbrEQp1DDOuRPATcsDT5kLot2G6OKHFftLqmXE43j9zL
 JE8hq4MyzuGQXhwS2MU3m+cbY3lfVHGvwIrne3b0j/G472RhiSo7/mq/xAvnXzb0rTci
 +s4w==
X-Gm-Message-State: AOJu0YyPocuxrgvIolTr8zKaNbrF3QXc1y9D/20u4OVz4ZBtFtLxs4ys
 Rla7NiYWt06nGu4/l4JDbG7Wqxd6L7lQXPWieV++RE7YJ6aXsx1rcmbh
X-Gm-Gg: AfdE7ckJilY3Ka/hZIYrSujA4VMshn6UcKo0sJVB0HxLAIVOVXRK7qhs0rlbAruqCxo
 bsD/Ldh4fYxSWBldj5R/Z4EyTulIHf+GCK5uQEQHiDdDTe6rEG9xXx8Sat/srk6KqGuoNu9G+hv
 tEWBnElu8cWkOCZInYSPsqFYH0A9ZqN/9SUIqUTmoU27CXeidGrx6xRfxOxiNsmemWIdyTKCM7M
 oNnLGi12BAxAitxC9fVRNBmrJ+LAid4URzyr5hJqCO8yejtKnf2UvN9HymBtNSPrg8lltSw3HVX
 mPQ74h3ILEqVNvLKWhHGPhNEfti4TdH6x2wLl4t3AUSn/+Mw5z4Mi1PWLPqvINkmWtFrSpq26gh
 UDqnj+h87kEWs4EvtVGl7dxGm2AZYPF0KYCP0dK26ZGzWlUIfBCx58MuNbJHZfgiAyvcebXOso3
 ph2rv9XwL1pOVxRCIWBw/i
X-Received: by 2002:a05:600c:34cb:b0:493:b150:c607 with SMTP id
 5b1f17b1804b1-493d11d936amr26353015e9.12.1783157676877; 
 Sat, 04 Jul 2026 02:34:36 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:36 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 03/16] drm: renesas: rzg2l_mipi_dsi: Add activation_dly to
 hw_info
Date: Sat,  4 Jul 2026 10:34:13 +0100
Message-ID: <20260704093433.273672-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Move the post-reset activation delay into the hw_info structure as
activation_dly, allowing SoC-specific values to be defined per
compatible. This prepares the driver for supporting SoCs that require a
different delay after reset deassertion.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 2128fd16ebc9..1538eeece2b5 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -59,6 +59,7 @@ struct rzg2l_mipi_dsi_hw_info {
 	u32 dphyctrl0_init_val;
 	unsigned long min_dclk;
 	unsigned long max_dclk;
+	u16 activation_dly;
 	u8 features;
 };
 
@@ -806,7 +807,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 		if (ret < 0)
 			goto err_phy;
 
-		fsleep(1000);
+		fsleep(dsi->info->activation_dly);
 	}
 
 	return 0;
@@ -1534,6 +1535,7 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
 	.min_dclk = 5803,
 	.max_dclk = 148500,
+	.activation_dly = 1000,
 };
 
 static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
-- 
2.43.0

