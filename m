Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72425CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A7B10F3E3;
	Wed, 30 Sep 2026 13:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qnXrw3Ub";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 787A810F3D5
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:03 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48b02a2359aso239376f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775182; x=1791379982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xG0P97LACQjd3EgbiKcVcaE0+HdMc9QDAIUrR6Re04=;
 b=qnXrw3UbMHSvh2iWWJM+zZaM1kcjJCRuaK4zCiAGZkPrcXuNRRdWxYZFqAhW3kQjyY
 aKlApof/Ny/6XQoyWMhadS2pkzxMHMNb+6zgdXNxznNf+IqpXBY8SDy0ks8AMY5SRCxA
 mHrCpzqhJSGMN0TlNk1BQNTGQ+Oij1PwBMjq5sMOYVpu+Hn+26F+iIX7mASszls37+Xb
 vigVumBKzzTNQ6KDZwpnq2t8nNwaHgk13i4MOPhMPtIOGJuNGn3T6vVK8Xdv7Yxegytr
 rpFtLhrtUnDBWLaIJ6vPE6hE8dOoEHiP2KR+Q8BWhFbl1tCM2SmwCx1/WVUlpiJy8HeN
 WNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775182; x=1791379982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6xG0P97LACQjd3EgbiKcVcaE0+HdMc9QDAIUrR6Re04=;
 b=aACanFxj/+vngVUFnAJciC3G5Y5eVvcllIUz8j2j/GpbO6jw/qYkVme8uSL8RA2pRk
 1L3Jso6GeqQ203BEf8H8FsyfSnjEISgVlRCX8k5ZWmFuC93Etuxn0gUGvMkxHm+dgaUN
 9oFtuHPLnBNuwyAC2RCwvSh9X4rwpfjgAMi7BUhqQ4jvpd++Q4CJGNE0RRbPTlhPLmll
 MFWwpOlcvccvACIj30UMIwNh4pVeQuu33mSz5GcKjob26UHtsMq7B1pJLgAD8oYZD+yh
 IN29eaFqKv2pIOL1C4AABeXYNxfvrq2sY6kCl6626cPL9hhMySTBSdJM8dEO074rtzDs
 cJ/A==
X-Gm-Message-State: AFq9FYJYuU2ZfxpovGAytvpzPs+DUDLuRJ0n2caOCwSOSat0zeokgkVs
 lKRexSmeK/15FJEjwgvx6KjN12tHP7vBZ7A1lQ3c3hEUewHFJcCy7S/L
X-Gm-Gg: AYBFou1HsUbxVTADMXuN1mJKRVAsOIenjZlZUfJUM4n/b7VWPNBZzcuW9WyvsA/2n/x
 Z34+QmAIjEV1hUZH72KfX8bh7ie6WP8q0onxmoFPZiOBeYn2NjoqcNkktGAgq81T7V0nq7SLbCW
 iHXvIVqBdE0RXfZQKRdW6N1AtACGZA4s60d8Eyq1BXwylyE0btFfIH+lFGriAXMuzdWxSO0rOB4
 JB/j/zfwaNoWQ6ZRyQgKtooq6tBnDZkp+cfjUqJADzsCV/6P44FW2KUdA4F0AFsh0lpTy9ZdO9w
 sk6tWDBiSRAZLuDAiOkiIoHBsnQLBvDkShbLKfFp/A/W/MDz0ta0b3L/8r1V0W2U/5SSiBWN/wP
 x06YXGhhd41aqXbKLcBPPytkoJeU/GsfSv/kO9MnLCiq5QZV05UZbSEa7gs5QECZE+ZqyWdchTU
 Gdj5pAFPtUCCt75xLNzghJp3P1jl2vEhxcY+7ywt0OTS4aAoXas3032vZSy8uli9J6+vC85/IMk
 WNp3byCU4U5C+XAlRVfpRE=
X-Received: by 2002:a05:6000:288b:b0:488:7ace:9c5c with SMTP id
 ffacd0b85a97d-48b0250c66cmr3650138f8f.23.1790775181803; 
 Wed, 30 Sep 2026 06:33:01 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:bade:1500:bcd:b3ec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f2b02sm3685582f8f.24.2026.09.30.06.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:01 -0700 (PDT)
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
Subject: [PATCH v4 1/9] drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val
 to hw_info
Date: Wed, 30 Sep 2026 14:32:43 +0100
Message-ID: <20260930133257.23210-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
References: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
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

