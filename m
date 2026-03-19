Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC251090255
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C14410E8D9;
	Thu, 19 Mar 2026 16:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gf96O6n/";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0A110E517
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:48:39 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48557c8ad47so9464055e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773938918; x=1774543718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XyX5oy0M7FEG2yDPl7UIzv4+eTNG+m8Qc/og46NTtc=;
 b=gf96O6n/0Uj0yU894fXP9B0AC9tWQ4bxbG4L1YIon9WnZs1bwUk7nXJZMn9ZgN76Fc
 9trcXM/NIog3n/xOYl7Jjq5PCulBstZ+riVtmvmuDyPtbL69QZhfUOgdHiCSn2l3PG7/
 U2oiThEK5J3yaTyh2AKyVNPv6J6+9qMM+jK5XWdmj+1fgYxTROBXPSr0YDr4ECpKSOJD
 DKEBptrI8KyOotixe1TCX16CsrViNQMPwAIuBS4TzNFadOCnJkAWGOap73nUfZm9LfoU
 SxAAv/jmqpL/09mlzy6ak8DRsYvqXfc/XmVYiZhXtw68Ei4rjWLDBmnyTzxqNVnhIWeA
 sbqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773938918; x=1774543718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3XyX5oy0M7FEG2yDPl7UIzv4+eTNG+m8Qc/og46NTtc=;
 b=sGOEnAaBIpUMoZbelMkxqPrCvWZ6qElbFvhXSF9bv50tRdqpPv8NXzsm+ub0E0Ialu
 xXMVMFDCWAidss53r1IG/gf9M6M1g/G1u/AOL0+zSPOg3PP3JEhskTQBw5elg11gfo2q
 TpFDfKSNbL7W9MjQWE/f9ER+hOly11zUMhrOQj+BZmjjatcXNjkx7NhfMyU/GCcJVP/s
 3z8C6b0InQ4BSBahenPx4x6DqqzciTx7lFxR8Hx//3fZ640adod76rZcl9xGN2xZXfbP
 dWHbTgqwA4Omy733C90c3vhfws1axbgXatagvnQ7V2O6FhohEVWjuh4MkDuhU4Iu6Qti
 sl7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRlj5yk7og4PJ8k9VBQdHE9JwtvDsaVbVCIxMDdp/K/0gsUKYkO7+myFVrNMpFBWkt6LBw3zpik/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKoCcdesWHYTbW7BJPKBnlx0MZOAwJ8djYCU4p2lYeI408+/OA
 7RKFURTihtsubBv3OhHcsGP7uw3cPGBDYNWOC94QK7OV3F63WLp9BQht
X-Gm-Gg: ATEYQzwKqzFxpyJ+KvokFa5fbnbclNoGN7bC2MXWHTTwCeuZcYgOP4ey7QqZEYB/qLA
 gm4ipO3nSI/Kmsw/FpD7PA/6tNMSlJymLa48/R1LvSXLZEL1pnn3g2u75c35w14nHlKuAwepWe0
 ofvY4U9LM5g3Efvk7XLQl3mHnc0oqUwEVE8ntmb/2DRmBPlbxV2lF81tz6zNwQmjLuD47ACxYwK
 jWFgy55+aPDbc/zCMdlQ8mSWYhgrfYhxh1abLJ2+0T/3JfVeP9eUg/8BTkKiSyZ6STY6wwjxYRK
 xX2Tqfw3MkysftszWF82tB0VIvlvabNi2xoZSp5LUX2Epy/9Jla21gw9oGnlnIbvRIm6+kw5dOJ
 qqo+4WN6AlhdJAtC8ieJsDqQbWaaO2h50BnbDs5DDttOYRXuIlHVmmb+NySwa0DVz9H9fwk7W35
 G3QEtfCA9StTj4IbP//EcGuTofjgl9NiY=
X-Received: by 2002:a05:600c:4fcb:b0:485:3f38:3de3 with SMTP id
 5b1f17b1804b1-486f44384d4mr134219545e9.3.1773938917496; 
 Thu, 19 Mar 2026 09:48:37 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:8326:7b31:bf82:d2d0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486fe68ec05sm5238505e9.0.2026.03.19.09.48.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 09:48:37 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Hugo Villeneuve <hugo@hugovil.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 3/4] drm: renesas: rzg2l_mipi_dsi: Fix deassert of CMN_RSTB
 signal
Date: Thu, 19 Mar 2026 16:48:27 +0000
Message-ID: <20260319164833.409126-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
References: <20260319164833.409126-1-biju.das.jz@bp.renesas.com>
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

The RZ/G2L hardware manual (Rev. 1.50, May 2025), Section 34.4.2.1,
requires deasserting the CMN_RSTB signal after setting the Link
registers. Move the reset_control_deassert() call from
rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_startup(), placing it
after the Link register writes. This reset signal is optional for
RZ/V2H SoCs, so add a NULL check. Drop the unused ret variable from
rzg2l_mipi_dsi_dphy_init().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit header and description
 * Moved the code from rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_startup()
 * Moved the check before calling reset_control_deassert(), so that it will be
   skipped for RZ/V2H SoC
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index d2da247abf05..5020be0f72ac 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -484,7 +484,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	u32 dphytim1;
 	u32 dphytim2;
 	u32 dphytim3;
-	int ret;
 
 	/* All DSI global operation timings are set with recommended setting */
 	for (i = 0; i < ARRAY_SIZE(rzg2l_mipi_dsi_global_timings); ++i) {
@@ -524,12 +523,6 @@ static int rzg2l_mipi_dsi_dphy_init(struct rzg2l_mipi_dsi *dsi,
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM2, dphytim2);
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYTIM3, dphytim3);
 
-	ret = reset_control_deassert(dsi->rstc);
-	if (ret < 0)
-		return ret;
-
-	udelay(1);
-
 	return 0;
 }
 
@@ -809,6 +802,14 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 	FIELD_MODIFY(DSISETR_MRPSZ, &dsisetr, RZG2L_DCS_BUF_SIZE);
 	rzg2l_mipi_dsi_link_write(dsi, DSISETR, dsisetr);
 
+	if (dsi->rstc) {
+		ret = reset_control_deassert(dsi->rstc);
+		if (ret < 0)
+			goto err_phy;
+
+		udelay(1);
+	}
+
 	return 0;
 
 err_phy:
-- 
2.43.0

