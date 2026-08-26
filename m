Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF7F8C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CAC10E333;
	Wed, 26 Aug 2026 17:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HTnxT+IY";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A203410E32C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:49:02 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c250c6a6a6eso199586966b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787766541; x=1788371341; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZdCoo9ded4E53Moqvr4ZcBU+4FPafYbozkQJvalYbuE=;
 b=HTnxT+IYNkEwb06lKUGSYVGNtR8uvVrk32B570nlPcViLpjJCN0JDPUBBI1hFVs/NC
 zeLvn2ueMSuSTOMxUFjbQY37VSa0hPUxtbVOejoJqAcF/Ol9dNU2qHb5clU1VuOCl63A
 6Bm8Ehv+oMdIlDqd+gPwDh8rMU0lqon+HlOH+mxUz4LHeI3/0XaKew5sBGuh3wrencyG
 ibMtyT+NSP/BNbOpf3ufXWOk++CuVBU9FZx2sZVmftHUVSX3CWdxyVBs9HzN2paT2gME
 WluhyEi/kOf4ucze0q5BUsU68FF8E1ZECUXSWvKaB5G93WZBu5zxBwezWKPyqzbLSDkl
 2Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766541; x=1788371341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZdCoo9ded4E53Moqvr4ZcBU+4FPafYbozkQJvalYbuE=;
 b=FD5nXhMstEP6Hgn4dgdX5rrIUsPAVuF6YtJr30tMyXkDXqixSPnG/30bN8UAADSzX3
 qQlcn45x2va9pwLp+5jPbq/7EzAzH6P0+Hiv5r6MKWEB6yIMAiwMZfaxlr7GNTrd4oPJ
 qhaHW43tHjNKBD/N5lNtNuaIv5/EE8jca7+SWIUyj+Rv7boInSr3rOTVPeZc2pTlo/LX
 pL/QF9or8ElC3CdmrARZGOekZYaulpR7yGdn8odVuQqZX+tlO5naKwOG19l/vSgDO7Sy
 xf5ZbGCBkHHRLW30Qo9bgWCftFtlZO120MLhTjtwIClStKftvrJ3WtHwgY60JHkQjUBN
 8idw==
X-Gm-Message-State: AFuF++kEoxx6tJNwWcaMWNUrvgMw87UyXW6/sGiZfTvo6xfKb8bLveJw
 BIZdpgjX8a2+Y+9ZuHD7zkO3s30fiq8MTmqSUK0FxthAdx0yaj6omdB+
X-Gm-Gg: AR+sD12WhSa8m3SFH3tPNBPJfG23J2MwR4/pLQv32gDW71OhJ/NpnrAtWfH+zUpyCHs
 CSwr2tg6HsgCnYjIara/drmElNLLJYElxZK4Mm8ZINQ1U7uqgDZ9cy4ZtfYMbEI+RNijaB7gWwh
 Hep8IDM0mQWceaieAcPsuLFKzT4hH8hmTU0I24PA1ewtKjiEURJ0mAVdk5gif9sxdBfWc4fji3Y
 B91pmNj3ZGB0kNTACihH5OWUzozrYlTGAn8bnbaeX5NkXeIpIFiNeF+BvZg/gEsxc+OZK7DmOF3
 fylS1r+ufPxKkWME02+wbPJ/y4kn55NSTsHlLaxGKlhzqtxn2TetWBcvXaKpeIAXpOkWx0d/o3p
 NgyBIoZC/r79p7xm6AwRRCY1C2RoG+c7z/zGzUGRkLK5sG5PA1jaNxeKkEGMzpyg4h1rS96PYC7
 bMyY/C/FTcxkQjTwGWfA96bStu+/Wx56135qSYAspqO7vxrh5HTBwdm59wSHTATSKcZZ2BdywoF
 FTYngugioGUWQ==
X-Received: by 2002:a17:907:9616:b0:c24:457b:86fc with SMTP id
 a640c23a62f3a-c250c329bf3mr831430866b.21.1787766540789; 
 Wed, 26 Aug 2026 10:49:00 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac7fsm777752766b.30.2026.08.26.10.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:49:00 -0700 (PDT)
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
Subject: [PATCH v3 03/13] drm: renesas: rzg2l_mipi_dsi: Move global timings
 into hardware info struct
Date: Wed, 26 Aug 2026 18:48:37 +0100
Message-ID: <20260826174854.199139-4-biju.das.jz@bp.renesas.com>
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

Move rzg2l_mipi_dsi_global_timings and its array size out of the hardcoded
ARRAY_SIZE reference in rzg2l_mipi_dsi_dphy_init() and into the struct
rzg2l_mipi_dsi_hw_info. This allows future hardware variants to supply
their own timing tables rather than sharing a single global array, making
the driver more extensible without code duplication.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Dropped .dsi_global_timings from rzv2h_mipi_dsi_info as it uses
   different path.
v1->v2:
 * No change.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 1538eeece2b5..d67e1230b70c 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -54,6 +54,8 @@ struct rzg2l_mipi_dsi_hw_info {
 		const u8 *table;
 		const u8 table_size;
 	} cpg_plldsi;
+	const struct rzg2l_mipi_dsi_timings *dsi_global_timings;
+	unsigned int num_dsi_global_timings;
 	u32 phy_reg_offset;
 	u32 link_reg_offset;
 	u32 dphyctrl0_init_val;
@@ -488,8 +490,8 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	u32 dphytim3;
 
 	/* All DSI global operation timings are set with recommended setting */
-	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
-		dphy_timings = &rzg2l_mipi_dsi_global_timings[i];
+	for (i = 0; i < dsi->info->num_dsi_global_timings; ++i) {
+		dphy_timings = &dsi->info->dsi_global_timings[i];
 		if (hsfreq <= dphy_timings->hsfreq_max)
 			break;
 	}
@@ -1530,6 +1532,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
 	.dphy_init = rzg2l_mipi_dsi_dphy_init,
 	.dphy_exit = rzg2l_mipi_dsi_dphy_exit,
 	.dphy_conf_clks = rzg2l_dphy_conf_clks,
+	.dsi_global_timings = rzg2l_mipi_dsi_global_timings,
+	.num_dsi_global_timings = ARRAY_SIZE(rzg2l_mipi_dsi_global_timings),
 	.link_reg_offset = 0x10000,
 	.dphyctrl0_init_val = DSIDPHYCTRL0_CAL_EN_HSRX_OFS | DSIDPHYCTRL0_CMN_MASTER_EN |
 			      DSIDPHYCTRL0_RE_VDD_DETVCCQLV18 | DSIDPHYCTRL0_EN_BGR,
-- 
2.43.0

