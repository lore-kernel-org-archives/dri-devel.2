Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C74C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C77F10EBCB;
	Wed, 29 Jul 2026 12:55:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QJRT+2Al";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E500410EBCB
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:30 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso6453645e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329729; x=1785934529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYVvwq9bkcr7dWFtqsKXO/Zg4w8BPgRwuOwPLtEELtU=;
 b=QJRT+2AluuJro0heOfIwjLyajdUhFDUuBRLwHSFeLdXQ2YODYfl9xmA1v6Hixfam+W
 1J9ycfU/v1UF3HXWwZXhIYg4gweqAcXb4xUi7wnt/OurzW6AxlnKYugMYXVi+pP5HldJ
 Yp6qG1wTP21tnNavYS8EmwJdH21NlxVbVAQCmQjleHvkvWC9kVVdzqAkujNfvgCNmtJA
 DxD3yzvLCAisfItsM7FquRZ28+MpJxl8lN56apTtK5sdUUpy2E5NMRTCandFXIcAYdgk
 JXpah5iLqFjTrNW+eSFr/gH+yt+1w2qaJAaa6yZsr7gklkOg1uD19Vu0pH69I6LmAmoZ
 +p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329729; x=1785934529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zYVvwq9bkcr7dWFtqsKXO/Zg4w8BPgRwuOwPLtEELtU=;
 b=JrICTfXOaK28zCy5hbO88wcbdVXJxqBzNVyNz2isqmCNcYVwciX05m4FzJzClZqaD7
 nRs9UeOCNGh4AS6LhIHmZvh0HgYR/rr9hglgwBmiVNr8UVnumQuJLLbTBdR3FMXeKvrf
 rSt4UBqN1c003WGeVE8nxP7ECRAwV5jq3AohNxEmG6DXwew+wRUJcl+EwVT6LoetdVKo
 PaWViUILnc2npZXrkTKfAikobXBTrPBAQ0HHxPECpLGnH9+VA7aycxUnRezYPPdWp1CN
 SkuoAx0sZlBchqfP4BeeFXJJwAtZgeMyOFecHNkXkc1GaOAbZiUNGdW52X9kQJiz0swu
 iVdw==
X-Gm-Message-State: AOJu0YyhIyVvWS5l2i4hhEOaASUZYflMRcqKa0U0rkzrlyUviY8KQTIU
 +dJd85Yqi1LGOwEUqDo7uetqSBU3eG1UpdZe6hhU+qzbAfsZhytlT9hs
X-Gm-Gg: AR+sD11ShXPMFvqnXnA9uH6d/Gf5zuPHcaRbnhZMxkj3xlbOFYfn4RKTsdy5gBkdbiw
 +WXgcrKpbaGzhqMUTso+zJCi0JuelBgxj5rvr7g+SmrbYWv1eD5s8eJI8q6skX48Yg8qwQCuiaD
 WyoaSPFh8Cp+aAljzA1ccD0GQ8yVi9xK5Ou08G3QhS/seQws503DATKzq8vgyXKZFPO6UIABk8j
 R/dMQ41jLYlK0g+BuTt25oVG5iapF8FRgbCb0dN0lV5bzHCdD0YEmYDZszBPdr+wwa4HSSe+HDf
 XPtwgvkIn9tbJZR6+ZJ5cC3PjVgc7wEoDxQU+bdI3qBjiWTYHxewSlPbLcK43at8PYINDl/2nYm
 kgkTeDI5zbrs5EXEM4ey3dAa9DdkFxVIdLhs/bNCc1LMX6YNvMBNzOCDKUZQEirnw6OMhRzbNGb
 Nql7ekcdfueu5zmhD9F6dQXEFuSaReirPyBWZtwslQrANWZDy+qDUW3AWiX3W04nd3ykp3ZpEc9
 YcHEXC9S7HN+Q==
X-Received: by 2002:a05:600c:6992:b0:495:5022:71b9 with SMTP id
 5b1f17b1804b1-496c658efc7mr69801845e9.33.1785329729219; 
 Wed, 29 Jul 2026 05:55:29 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:28 -0700 (PDT)
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
Subject: [PATCH v2 04/16] drm: renesas: rzg2l_mipi_dsi: Move global timings
 into hardware info struct
Date: Wed, 29 Jul 2026 13:54:56 +0100
Message-ID: <20260729125516.230757-5-biju.das.jz@bp.renesas.com>
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

Move rzg2l_mipi_dsi_global_timings and its array size out of the hardcoded
ARRAY_SIZE reference in rzg2l_mipi_dsi_dphy_init() and into the struct
rzg2l_mipi_dsi_hw_info. This allows future hardware variants to supply
their own timing tables rather than sharing a single global array, making
the driver more extensible without code duplication.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 1538eeece2b5..180384c10264 100644
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
@@ -1519,6 +1521,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzv2h_mipi_dsi_info = {
 	.cpg_plldsi.limits = rzv2h_plldsi_limits,
 	.cpg_plldsi.table = rzv2h_cpg_div_table,
 	.cpg_plldsi.table_size = ARRAY_SIZE(rzv2h_cpg_div_table),
+	.dsi_global_timings = rzg2l_mipi_dsi_global_timings,
+	.num_dsi_global_timings = ARRAY_SIZE(rzg2l_mipi_dsi_global_timings),
 	.phy_reg_offset = 0x10000,
 	.link_reg_offset = 0,
 	.min_dclk = 5440,
@@ -1530,6 +1534,8 @@ static const struct rzg2l_mipi_dsi_hw_info rzg2l_mipi_dsi_info = {
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

