Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0904C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3733410E32C;
	Wed, 26 Aug 2026 17:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FzMc5aDW";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87D110E32C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:49:00 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c160420289bso165798566b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787766539; x=1788371339; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XGCUJbrGi7S4/RW/jQIrHeNXdMRfy5zYhPa2LNyhWxc=;
 b=FzMc5aDWSfcLuPLYD7iDAe/FXsJ5xNsnroJHebPf1x+5IO5AAD2GFyrR6X1nlkeMmA
 n6WulHBOFgTh2B3n+v39eil6PtlTjZkIQT/sTYBgzR7qHE5pl8ESJWaymO8XwyPoP76E
 J1B4CWLI2v/mlJpxtnl4oKgNgyp7mOz/3bnf2WqWgwZhevPZJ4vbPldPwFJAQLT4MB/j
 wVocZw5KCxQqaJqK2VD43uokYRiBBD0KDE5vVzOpE7ddUMxrKznAwHAhuDIUOm9VgMwu
 hL2duLuNcAKr1fuJuzZ2OBYZkx0qWIqmSz9h8b58ZmygFBNsMz1vKzElNtoawnKPJnGD
 gH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766539; x=1788371339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XGCUJbrGi7S4/RW/jQIrHeNXdMRfy5zYhPa2LNyhWxc=;
 b=WVDMsSbt5CQhEPtgzxNNDx5d+Yi3/fBO3YqlrHjwLzBJyNVb8bDRA7mFdxVlqy123K
 Q0jd0DrmtydI6fFEomONv/PiJiBAHJehT/7lxtpUiWdOf/mEJ+OByCb5pgtobiXtVWvh
 ge9kNDN90xF7NpaGhqXnMoBXlzGA/K5NrhrKxmomMU7qGgZwou1saDKN1Kj9EWLgCzHw
 KmKgp81wlsmew2rkgYLQ4fOohEgq4V6om3hqf2/dGl4+UMl0Qrt2xV66CgiCk6GH9848
 byXOwdVI9FzWD8G6gr8q3lG87csHB8+poruK/YaqOQ2hMeAACRPLOaz03KfD3cGDubwX
 6cPQ==
X-Gm-Message-State: AFuF++kpPbrFEcA6gnYoLgUAEezQkzD30pv6niYaIQPJPGCbFMMZ1rxy
 1t7vm6YOvn3EI+/oM2ODZr8hD0/0wyi6Y9/aUmeb072MjjM9h2q4Jb+W
X-Gm-Gg: AR+sD11EXsjcgKDFEsG8t1lNG66UthfX5VmBxYKhAIDEprUT1Kn70ieV8RnYxtYYJGr
 bnQenrJeVC2vXUjbkeof4GWvIHO/9yzW0739rb1jYosFJBdpmCITYM3GshuODTwoFpoHKMSCVBN
 +MsKT0CBWH/CP4uJyu2qmI5DYmYjAKkoKeRVlJjetI/DUdnU17C6UbUS9aFbgQd7bCpcVJzv17b
 3qjntc99qCsmmoTa1+VZhpomUqdGnVtMGIuUqKtiFymQNxwWhCdCp/sSXlDXxsfx19y/JM/n9Og
 K8yzgzbfeeP1+t2EROfzvkCNhYCwkh2TyPqy587Epris88tfaQs3gnlbyIeXvxfl2YTs40WUGmW
 56cncXVmIfy1koh5dUfFvtm7fmUx1VWILoQoeTJxM0nhBBRpNb+0q2PgkbZ7DhSVLveCL+x+wOk
 IfUZ/5Wl1wQQ27+ZOJ3uZOn0PQvvVWCNgW5XS3566LIBTJMWnQQrLmSyBBn8W/Akj3h1bU3OaRZ
 RpALryu/Z3htQ==
X-Received: by 2002:a17:907:8b91:b0:c25:3001:4699 with SMTP id
 a640c23a62f3a-c2530014f82mr425766266b.12.1787766538844; 
 Wed, 26 Aug 2026 10:48:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac7fsm777752766b.30.2026.08.26.10.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:48:58 -0700 (PDT)
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
 Biju Das <biju.das.au@gmail.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v3 01/13] drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val
 to hw_info
Date: Wed, 26 Aug 2026 18:48:35 +0100
Message-ID: <20260826174854.199139-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
References: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
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
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v2->v3:
 * Collected tag.
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

