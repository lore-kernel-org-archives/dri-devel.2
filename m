Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01EDFB3D17
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 10:45:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E8210E58B;
	Mon, 30 Mar 2026 10:45:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MZcmC6SR";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C394510E5D3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 10:44:56 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-486fb112c09so42246315e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774867495; x=1775472295; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WwQ4dRMFArea8SYkY8eqqNt1lO8reAvWgec/k1eN+cI=;
 b=MZcmC6SRxlkTERzlksfgOw4i4C806rqulYklOVE0IDoU1lV9cmpCArLYZT9LC8QWkO
 tE+kWYKjCv2+upfH31vN1dJS/sA9jLonyAzWY7fLV8Et/rrhxtq5uvnZQ9M/MsfNcOa0
 4Hc3EdVOclcjdO0XlKxHLnQica0vqtB7ECDI/usLD5EVntD6QP+yYQdWAmbLTykoKxWK
 uUqZFJIX/MCU1CpC1LcRPU86FX+6G9AnW5k3NPlPeR0Q6JfDy0d/pUcc8Q4ExvIkLelz
 X3j9NgpgNm1HETNThRh8fu4ajGZ0xqUWolcsug6h48xhY5W2QnuwTk/SScdNywq55/h/
 seVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774867495; x=1775472295;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WwQ4dRMFArea8SYkY8eqqNt1lO8reAvWgec/k1eN+cI=;
 b=fuSSKmWCbfbSXzmhmuKDMkw8aQgKR17lplvg3ZRthqbuk0fv5lYHAn3es1/HA3qJyS
 c1nLRLqiqRHQrYMbKOYf6E4ZD0B+9hq8+7SWLfT4NbOf+QA5XlmMXzddS66DihLA1Svi
 vS3eTsoebFrrOgJl452OOTP52gMPOxpUF2qNrwMsX+3PfhYtoS5v84pyeSO6IcbhchD4
 8NNaKSLAMBn3C4dvSFlJbnkTNXnrHjrs/542Z0V9GfWGyOwgvlyD4g1DZLDxU5qz/HwL
 58q93LSY/a9pnGxZyddtizfUx8TtGFHF2Xf/DMMjxoHEDL3qweK1NFOOPChwArJrlVgr
 EZOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBmvsvyzLj4YmQv7mOolX75sHY5IinBJ0LJ8mHqe5WwWUhbyXugMX1pe5Gz3C+UvJIJFvW5dMhR6M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfcTOFyieSpRsNA4nF3iiQfh+K0/1CFV58/fLqNFsHdS3oJNnT
 HvdzPX+jg3eEb1M7KrKjV3A6KJBTOXtvf3KlhtGzMZ2oZNZbR+MkWB8/
X-Gm-Gg: ATEYQzw3XkSkZJp7Roem8aWDPpcF6IyZfYX/wYWzTTFyBfwPx228Q5BKZrvneYBKuEr
 8ijriXP2rXOtx7V1gJt0v1Nvfr7YDZGRNkpo3w8Z6rzQvkRi9siYuqhHyCxxbswY+4aZZx+fH3f
 kcwJ2GTE352DoaSn4GiwwWdXTqsPTudCIhV4nX2YU8MpcpXzq7gSSdtovnbcEIZECuz2sy3D+qQ
 4h4PXO7OHYRkIwoHyCNrI1pazXItRUUqzfwnhveGDjNbjyTM9lofRT8O8LSWw90I1AEhdDaqOg8
 sPC9BUH9sl+J+m9N36PUOuwbyFENvrtFb9cU6jmyIyd5uF3ZJ6H+9gyc5QK9GtTAfBSVuFtofGW
 6DdMnTCPR+6d20zJUTwJdf+iqjBsbxU/49/aUoljIF43DaAiUfZkX7UJ5mL7Fq1+ssA3sxCgO2z
 0cZfIj9wM01/WVvaX3ivLKXMNzQo99Rw==
X-Received: by 2002:a05:600c:8489:b0:486:fbdb:b718 with SMTP id
 5b1f17b1804b1-4872807483cmr201130955e9.25.1774867495178; 
 Mon, 30 Mar 2026 03:44:55 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:e60:2c8a:54bb:d692])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48727bfc5ecsm185842685e9.1.2026.03.30.03.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 03:44:54 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Chris Brandt <chris.brandt@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 3/3] drm: renesas: rzg2l_mipi_dsi: Fix deassert/assert of
 CMN_RSTB signal
Date: Mon, 30 Mar 2026 11:44:46 +0100
Message-ID: <20260330104450.128512-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
References: <20260330104450.128512-1-biju.das.jz@bp.renesas.com>
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
requires deasserting the CMN_RSTB signal after setting the Link registers.
Move the reset_control_deassert() call from rzg2l_mipi_dsi_dphy_init() to
rzg2l_mipi_dsi_startup(), placing it after the Link register writes. This
reset signal is optional for RZ/V2H SoCs, so add a NULL check. Drop the
unused ret variable from rzg2l_mipi_dsi_dphy_init().

The CMN_RSTB signal is not required for reading PHY registers in the
probe. Move reset_control_assert() from rzg2l_mipi_dsi_dphy_exit() to
rzg2l_mipi_dsi_stop(), placing it before the dphy_exit() call. Since this
reset signal is optional for RZ/V2H, the call is a no-op on that SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Merged patch#2 and patch#3 to avoid breakage.
 * Updated commit description
v1->v2:
 * Updated commit header and description
 * Moved the code from rzg2l_mipi_dsi_dphy_init() to rzg2l_mipi_dsi_startup()
 * Moved the check before calling reset_control_deassert(), so that it will be
   skipped for RZ/V2H SoC
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 9d9f77d8f949..715872130780 100644
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
-	fsleep(1000);
-
 	return 0;
 }
 
@@ -541,8 +534,6 @@ static void rzg2l_mipi_dsi_dphy_exit(struct rzg2l_mipi_dsi *dsi)
 
 	dphyctrl0 &= ~(DSIDPHYCTRL0_EN_LDO1200 | DSIDPHYCTRL0_EN_BGR);
 	rzg2l_mipi_dsi_phy_write(dsi, DSIDPHYCTRL0, dphyctrl0);
-
-	reset_control_assert(dsi->rstc);
 }
 
 static int rzg2l_dphy_conf_clks(struct rzg2l_mipi_dsi *dsi, unsigned long mode_freq,
@@ -811,6 +802,14 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 	FIELD_MODIFY(DSISETR_MRPSZ, &dsisetr, RZG2L_DCS_BUF_SIZE);
 	rzg2l_mipi_dsi_link_write(dsi, DSISETR, dsisetr);
 
+	if (dsi->rstc) {
+		ret = reset_control_deassert(dsi->rstc);
+		if (ret < 0)
+			goto err_phy;
+
+		fsleep(1000);
+	}
+
 	return 0;
 
 err_phy:
@@ -822,6 +821,7 @@ static int rzg2l_mipi_dsi_startup(struct rzg2l_mipi_dsi *dsi,
 
 static void rzg2l_mipi_dsi_stop(struct rzg2l_mipi_dsi *dsi)
 {
+	reset_control_assert(dsi->rstc);
 	dsi->info->dphy_exit(dsi);
 	pm_runtime_put(dsi->dev);
 }
-- 
2.43.0

