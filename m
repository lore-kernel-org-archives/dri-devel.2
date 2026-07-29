Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAEAC54FCD
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD7110EBF6;
	Wed, 29 Jul 2026 12:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cp+LdFzo";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6B110EBCB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:27 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so616159f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329726; x=1785934526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/QYl1GSAMhd7afswg8X62zSOp+YGZ6LTenJec+EYIzY=;
 b=Cp+LdFzoTcG8GiCWwtt2UzGqJ8j4+h1tQ+QGNUzi2hysyqUXzqsG3nyDpBNfFBL9kE
 zYy72ozKdRq4F2hy7o0QhgRfWVhm1fMJTOpSXguqK8fB2jlIWVcZyE/Dn526Bf/yVjl6
 tcidebQprlQRUXpjk/RhxOYbud8ZV/tl0fxLCMXuqTJRO/EK1O5qV9LB3WjKLxPllFeP
 mRvisjxcbLz9bJzeFE6s+w6pme5CmTl0zhp91hMIrgSy22KTeIk6A76W4+EB7n40wL3o
 0E1s5etuEbclpKKs8Dszj92em/rqniHoolj4PF1THTS9SVuaeZUfYydVJZX64uYrX9Ja
 wtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329726; x=1785934526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/QYl1GSAMhd7afswg8X62zSOp+YGZ6LTenJec+EYIzY=;
 b=ROPSrUCK7JvAFWZTsPTFtv3qX7vWgBnUKJkbTZ5I4cLTSa5HJe5VSYJy7I6Ya8bviG
 Xh+BUW+QBBYkspdZY64XbOn5MDVRIMZ7Q7xbDyoly1cL+40jBTGeQSoYdRwIOaCjfMRd
 HaDzYsuuE117TPAaz8DyxlKpdLuDx8wZVQnvzpagAOSgawyMT+8MqrOcObb0VasFtp24
 cXv1enoJw2Pc7a+TOUT3vJ2vCJSQ0qXx00F/km6YDYktnupD/K87oWJ6v7KOVFUkBDc1
 H+hl0sRt+WUD7lja3bRffK3AaAa2s60E44FNtrOK3DPVs+9yxvQ30+9wxwky1TinTHMZ
 lBrQ==
X-Gm-Message-State: AOJu0YyQZ/hzAw5rkT52UqKg05KQZDYYZ6hUmdsRkrD+RGqOIHl2gS4h
 V9LD8arHI0ItVBaPH3ck8M60wlZilJY9XegMpWSk8sqHZ5FHkK+hnVIb
X-Gm-Gg: AR+sD13b3ADu91q+BJRWqYdFAuFaGWYZfv+FG+DfvpkuY8eS5TUX2gbKumd0p2eTFSZ
 nSnZ5yI9M/ibHwEV7UaiccKIEY0/I1LyZZiV9bziz3sVer1H4mazIrMpjPeADxeQ3FJx8IYOjkf
 jcEXh/qOfvKJZAAwC1IS/zXp5vVPB2GLnUI340h+dqNwNXHAs1B++exWZlooL8pv2EYlSXa15+q
 4Gz+Pv8vy7LWcm7bRoJfYqtKn4EshsWT5JtfqXnlHGCytWpeUY0cckMnPFjo+Y/QgVhTIFHqzgi
 nh3gWZkVTLh9WKclTp+PJs62F7Xq6o+Y9w8c4Xca2UIyoAPQ3ohuHz1cc5AhV3FRJ0xMsGnWPCw
 4RTJi4mcwgk/K+kPyL1O6bkmjmb7TuuVs447wq3tWaLZ9ht3MJWdUpZUXf/IpQCXzEZ6e1Ix6yN
 0o4owcStBGRSYSNiWPYSioa1lq+EgkyS8uSHn4005FLHb+81hTyEg7f+Z0yE2I8CdZ+DiUNZP2H
 H6sgNVv2oCHvle6EIAYsSel
X-Received: by 2002:a5d:64e9:0:b0:47f:93be:dabd with SMTP id
 ffacd0b85a97d-47fb1f1013bmr7516301f8f.28.1785329726087; 
 Wed, 29 Jul 2026 05:55:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:25 -0700 (PDT)
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
Subject: [PATCH v2 02/16] drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val
 to hw_info
Date: Wed, 29 Jul 2026 13:54:54 +0100
Message-ID: <20260729125516.230757-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * No change.
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

