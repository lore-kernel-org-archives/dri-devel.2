Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E5EC61DC6
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C271310E461;
	Wed, 26 Aug 2026 17:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H3K+ES/I";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C97710E32C
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:49:01 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c252e703fa3so104372966b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787766540; x=1788371340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2YMeD7dLZisixXOJMrSKSkr6GLMkfgvOUyr+kt9XhqQ=;
 b=H3K+ES/I8eSL2sIjCNizKaR/ya71wod4oZwl5TETJ09RsXa77LhI92Y138LKylJ2LX
 7BhTZzwZRS6/uGBjGwb0w8WRABnM1U4PDnlAPVo/HGzqFj63u5D2iA63seJCOqEsKMjD
 BebLd3UErffeUemGQSXRRuvE21zPFMA3wplLKSDxinYYisNAbBPCd27drp1ydN6QBH/7
 IimI2Cr6jqGmAV1EAK7DS4ZRBBjLQM+8wrC1IZsdo/GkAhBunTnn29nAI0MyaLOaCCy/
 AGPLRzPzgmrlfhTxdtIHWSIzXNCEPDmtHcj4QJ1zqUBBjnEfwkfjaeGp29oc/gGZH2mq
 /8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766540; x=1788371340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2YMeD7dLZisixXOJMrSKSkr6GLMkfgvOUyr+kt9XhqQ=;
 b=sHJKqaqy9ZiIV1u/oDy2/U9/WhFWPXl8O9rGMCpR9jrSO5S56G3SiAGomeviu++/YO
 B0FaMPNoiN+GzXupP0h3pQ7FnM7iQ7GXxXo8ajycs6FVBvB7N4hGvfAQiLYWD2R79HkV
 ZoDuohulR2e7mxuohPIbkT08Lt0S2CKHXFOGaXLozr2Y1mh8kIt0D0nyKy5AflEgCwCR
 9VqXvSgl7CUtbAHDKJpcpL8Ar+pCeL0RDhLreaurrOImqx8NOFiw2x8KNRnqJlXBp4D6
 IXx5tty1hYMxjLIGd1Zc6X3Z9lKoWWR9kMrLWp/ROny4ABg2qutcSIfpZUEtCnZgcO9O
 NP3g==
X-Gm-Message-State: AFuF++lC7oTC3tzmp5MIB74WumErYRfrHpoBXepCf5rKvTC7veLx1+m5
 BaJbOKrEUoddILuRVe4GZfv0sHlKl/dq3WHVAOVNoUj3l8jmyxpI0PTr
X-Gm-Gg: AR+sD13ajALEDnYSzr8AbjbNYHXyi/cey+zboVf4C0APCmjBZ5c2Tnze8C872LESNZY
 7rwqTIcNK3I3BrgoWV7PS0WXO5QyNgG04NAPMLzt1xwOCd2UyTfpfiwtYxkInQU5O2UW8zFDEUz
 LcuZhh+4xQ3zlBAOp8E6JA6B+sEp/ABB1X0d97sFx7h3l7EoY+SUhtZKkExDWvpKh4z7G3fmacT
 b2llbguvEThepMyGvKMq9be6533+i/OD53ESaZex+2lTTpXum9fa6JPrPKY4HS9F1LYgjFr1ZSS
 aA/fTDv5PKmbTf5CEnHvMuRe+PX+eV5nvQpNMqlQ+idwPAOf6rK5ijJPIH3XoxOQpwvpKz5m6jh
 T31bzqTbeyWWQ0ryNkVVBn8grF/LIga61yhQ9/3S49PUZVWMUZln1kxUOp/Jg9XG7KNanBKD9Mn
 QkQ09S+HK19PrUmO4J6DeR0exC96MoPwkzfjqTa5HXRyIbNUJr92vjjzjD/BCyBvyrg4OJGxI6L
 2XpDBI2Y2H65w==
X-Received: by 2002:a17:907:c22:b0:c21:4393:c41a with SMTP id
 a640c23a62f3a-c250c312bbbmr1016918466b.11.1787766539831; 
 Wed, 26 Aug 2026 10:48:59 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac7fsm777752766b.30.2026.08.26.10.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:48:59 -0700 (PDT)
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
Subject: [PATCH v3 02/13] drm: renesas: rzg2l_mipi_dsi: Add activation_dly to
 hw_info
Date: Wed, 26 Aug 2026 18:48:36 +0100
Message-ID: <20260826174854.199139-3-biju.das.jz@bp.renesas.com>
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

Move the post-reset activation delay into the hw_info structure as
activation_dly, allowing SoC-specific values to be defined per
compatible. This prepares the driver for supporting SoCs that require a
different delay after reset deassertion.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
v2->v3:
 * Collected tag.
v1->v2:
 * No change.
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

