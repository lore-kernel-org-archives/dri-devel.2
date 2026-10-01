Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079E3CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F1210E352;
	Thu,  1 Oct 2026 09:40:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dMXAK791";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4203D10E352
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:40:48 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so28633065e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790847647; x=1791452447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h2InO87pmSFWFpzCtL0kBSIEBqZO5yulpRnkLLV7Amw=;
 b=dMXAK791W8SzDaeeo2kp+2Wut9zwYifbviGIawspJ6Ani/OBMw5cDqZTvufpxx+Y4k
 GZbI9tMHR1FoPyUzB1jeIXb7E5V40VImhySX6R434sxGbW7JLl4YC1ExBgYzuzROq3H7
 V6Mhi+Hian4WIO9KrbhynrBJDetcZISCKszsUz086CgKZcRKLqAPhyp/wyJ0yebpWK4p
 kzJ5i3014ibESZnsJrOoKB35cYQgvWZal360FTACtE8Ge7ZLJnin7g5I0P6JS0JqJ7oS
 09vmkQPLdfgjq2WmjZ4LsNU9JOGXUvVQe794RSUVR/E7NECObX6tSXBQLT93ikHIB39M
 BYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790847647; x=1791452447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h2InO87pmSFWFpzCtL0kBSIEBqZO5yulpRnkLLV7Amw=;
 b=j4H0FHzHlVlxClmHucSe23jW1MDDbO/hR+yQTdIqgdjNbAvK0AL7bbOWrhAxN9+vL9
 UHhsLORbremuk1wzBztlppRtqG0GBgAMfT86Ehtmaowlopgn4TJEHBpzMMBdIc92QwE/
 JdqICF7DJGUWtBkctkia4E0UWasShzeFg0dq7ExZUuVqmWyQnDLaS6reautsujqTojAS
 ltLebN+oguTyq52Dywib41MWAgdjk7RT0B8ELpgQllC+Z9CHbRLCPv0rKz+3Uk5WJ5Pe
 P7kHqkwRxTGPMB2LmLw4rLk4sbCkZB8/FM3171dGvHgivs05gS3/4L39GfDYLmvUundI
 OvZQ==
X-Gm-Message-State: AFuF++lfhCQuiP41lODy5eyRa57TWavOT6njZzUvsS2vkYDr42oeazZ0
 G1nHAb2FqguZmgV4QqNQfI/kPZI3f61Wj5YFFFke3ogw4IZOoZUy9KG6
X-Gm-Gg: AYBFou3x40id50HFhBkJgIVjNtffHoRDdgyv7OehzKu19e7c/VBXsTw+M/2Eg3X+ZDy
 RCSE8gUAnmOTnlwV2h1uqMo90wjrEvjXEf4/fz5qx+yiZ7FsqVtlZK2m9kSI6ViDjHIq4M58k1O
 IDcYbqNhzcSxWYK2SE1HrH7KxEcvVBTdHfOpAtOtCRki5Kcoq4qsgEL45ro5ABbu0Ff57pfaTZZ
 oOs+jMQN3muSpSZl6v8LMnmlkgGxVkILK1InHqfGAg3s8Qz4D3ME3HlnWzBDiwP2fOIMeHND2yC
 S5LdChgtMZ7ai73zYp8t2g+O4RRdyxF209awlXbkxKJYyJUAvfv4TU70LDIFvF109KTZrlx9JMK
 rgnD4wlaWaWabjPbhxngKupc9ZJCXCoNXJXDcIFDins6FBoNNmtssSGrv9xVCB+7nA3rf8BLbSX
 fcxq7V7y4pYyaIRbRtP+KZnRVQj2dAc6GeHyJnl7TuO416Ri9WbpqJIwMk3SGDvtvW7drxhmOHR
 qXq
X-Received: by 2002:a05:600c:c490:b0:49f:ce73:5e96 with SMTP id
 5b1f17b1804b1-4a01b12d914mr68051805e9.34.1790847646421; 
 Thu, 01 Oct 2026 02:40:46 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:5563:a938:8fc:9dc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0226201aasm38937725e9.6.2026.10.01.02.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:40:46 -0700 (PDT)
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
Subject: [PATCH v5 2/9] drm: renesas: rzg2l_mipi_dsi: Add activation_dly to
 hw_info
Date: Thu,  1 Oct 2026 10:40:17 +0100
Message-ID: <20261001094041.135697-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001094041.135697-1-biju.das.jz@bp.renesas.com>
References: <20261001094041.135697-1-biju.das.jz@bp.renesas.com>
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

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * No change.
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

