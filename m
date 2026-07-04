Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E7EC43602
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44CB10E064;
	Sat,  4 Jul 2026 09:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fAOydj5q";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B7510E059
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:38 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493c55d5c7aso12554455e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157676; x=1783762476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+qcP8EPHpeRw8GGZwK9AJJe0lfKflcJRQSrck6Nv9iE=;
 b=fAOydj5qTmIhhM8zkq52yK2rsIOnARyhzwwli07CJNabUGC7oV5JjMUxfF1uQnf3JS
 Zf8ruA+INHvbL7M+MguOA0Q0Cczyj7+rBiFnKqM5H7dB5BqVdypp2ocwqXRvq0uLucAY
 MlyuRy97L0UGszuv9J7KdBMqf5I5vaJyqZQWJzrb6ATlpqyb511a/G5j4P4Dh+UmioT/
 N37Sy0tAC7cEktQ8wDG393aWOqN2XsYiy3MNbKPzs2e4Z5bXsL8z1i6tMSVoPy2i+mF9
 6LU48qK5MI0z3raP0CeD9PCx+F65MZq6U9z6eTQgK4iPcZE2vKMQHzEI3U4h+7UdhBsL
 o1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157676; x=1783762476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+qcP8EPHpeRw8GGZwK9AJJe0lfKflcJRQSrck6Nv9iE=;
 b=NUj1zLLhSXwmPW2/jdWrq+8COQyTEyVoBrvsLvDeT61myUxAhJcmRgp2LZeAl5cRYM
 +ITs7ob1raWL00bPBD3/Ty/ly00uAEuqrXKFIWw2QzrIf5DgvgDJAIDlyP/lEhozm4cp
 pRYSAR9wOpqsHPQL5qDuTsNkzh4zgdPmS9Bdk+t2MWWKamPW5i2clObCtP5UUHZPEUIS
 V5PtJEpwJ/e39gtL9ocOnbu5o7Lnxs/XzF90THMPoYo/jiLz0Wr3xwe+9WqjOOF6U2f3
 8bXnO9c7c2Ok9TbarPbITMVCnrmDODTxfqLXbF/ZZkMQ+b3QLQC9qIQayImcDKwwfVku
 bUAw==
X-Gm-Message-State: AOJu0Yyec4kdPcXm500ebv69+OuQMyMQVIyxdBq1mboyPj/+UOnrLoQG
 BIHf5l844IpbNn82UObFK7gNbFCE28DQiDL817gCxFOYUv7cPkLdu394
X-Gm-Gg: AfdE7clOpfN/x1wyMnPAG63aL5DoJ9kRjDAS6FSazMZ8waiF3VFKqGfoowPed/pRLDy
 l4TRdJ0OXbjCASH/dxg7zy6bZc7wL/rP6ZkJvQsV5qf7hXeO7jCZzGRmigykgu2+ujc7ZYqEEZu
 32wUKnMEazvH42NMlj9D5G6NIBmGJxNVYyWRjTW2+zzrN5Eik7ncEmgJh8roj+m22tcuChgvpzr
 kEKsTxUDx3zV7W2wo884Bc+XmlYPiKBSEsFBjj2N1RgQO1pTAzh/RA69PXE7crpUgAaZ8yqOCuv
 EaWNMPNYqW6ISxl2JCeBiR5rSjt0mi/8qBITtQuYbWGlURBVi52l3CquXS58UQ6iG3JHP9+Ckil
 GbHKXRMiKrmJWlau9cR6VUEbHWn7yAM9d0qCQeDXHYaieKAPcxxwviUh7uQWrsX1uRezmS2rJJ1
 e6KsB7+8qNif/1cMohVApY
X-Received: by 2002:a05:600c:3551:b0:493:adc3:cced with SMTP id
 5b1f17b1804b1-493d1204c63mr26953345e9.34.1783157676384; 
 Sat, 04 Jul 2026 02:34:36 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.35
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
Subject: [PATCH 02/16] drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val to
 hw_info
Date: Sat,  4 Jul 2026 10:34:12 +0100
Message-ID: <20260704093433.273672-3-biju.das.jz@bp.renesas.com>
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

Move the DSIDPHYCTRL0 initialization value into the hw_info structure as
dphyctrl0_init_val, allowing SoC-specific D-PHY control register
initialization to be defined per compatible. This prepares the driver for
supporting SoCs that require a different initial DSIDPHYCTRL0 value.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 0590ade96b91..2128fd16ebc9 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -56,6 +56,7 @@ struct rzg2l_mipi_dsi_hw_info {
 	} cpg_plldsi;
 	u32 phy_reg_offset;
 	u32 link_reg_offset;
+	u32 dphyctrl0_init_val;
 	unsigned long min_dclk;
 	unsigned long max_dclk;
 	u8 features;
@@ -493,9 +494,7 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	}
 
 	/* Initializing DPHY before accessing LINK */
-	dphyctrl0 = DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN |
-		    DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR;
-
+	dphyctrl0 = dsi->info->dphyctrl0_init_val;
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
 	usleep_range(20, 30);
 
@@ -1531,6 +1530,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
 	.dphy_conf_clks = rzg2l_dphy_conf_clks,
 	.link_reg_offset = 0x10000,
+	.dphyctrl0_init_val = DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN |
+			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
 	.min_dclk = 5803,
 	.max_dclk = 148500,
 };
-- 
2.43.0

