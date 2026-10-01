Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2175BCA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA5810F5B5;
	Thu,  1 Oct 2026 09:40:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W9GDeO0h";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3461810E361
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:40:49 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b0f4efe31so160447f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790847647; x=1791452447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I4W5NZM4ccedNa6iDSrM95gMMfTflIrpPojWIgsdmsU=;
 b=W9GDeO0hva7oCv411gRMKMT7rmOx/xp/JK31U2mdrgnX63Hq+Y4lE91Hl/N98yuRZN
 ILxxighOP5S6eLncMqZs6VT7/pk7F3mDFjJa6DIbPpxCa1Uv4fnF+8eyopItM/d4u0ur
 IahNZhcoyE4EQNhUXMUizLDcCSz2u89tdp0SLNwCk9e50CTOyFXNHNYwgfUwzuNzrgUI
 Oxm9hqv5mTcWzx3IuwaJXBhRV/uD9Enp7T+K3i9mlxuqT4BBaAerQoZjLnxS7bm7tO0H
 ar+BGwwjW69k4PI4HRRk2n07jWJdIc/slG1fhCyKlku1vMlnMNV8ZMAp3wnrHPQlfhw9
 XMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790847647; x=1791452447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I4W5NZM4ccedNa6iDSrM95gMMfTflIrpPojWIgsdmsU=;
 b=milzQtVQy5PGILUEvyY+NWbhoKB89sXLVTD4BbvAV2Tj/qOwwS5opNq6KXMGPsW1uv
 zJTb9Om6ci2VuOL5tzn9GNVrrl04AZ6Gks8yxM/9EJxgrSRanixvkY6+jAge2CmJU+kT
 t9qe1qB76UMX6VJqgCItG+RihPP1x5HNJOPR+3qsKyDerjx/rnS9cASX++9QnilrGrXb
 3lKuDndygT/Lp1RzSbCOUetGaEXBKd3AMJv1OVaxIvtd8XkAjfZPF9s7/8hqoUHnAlvr
 28eJP7GdN+21UeLooWwdfdB7MVlublHqAcRzifK0LBfxZowAqAk3zR9vSEWEYG82ogBs
 X0Cg==
X-Gm-Message-State: AFuF++lFBE9n3jv11A5XIf2G6MglQaGE+BE9/M4Nx+Fz5bYjGj1SrPXO
 qTl5v4/I/gzx2ABXTulRBCu2+T/1tEvyMVGhkJc97qnPCMMMAdxobtS/
X-Gm-Gg: AYBFou3ovpaZy0+aCjD71fayOmuQSqCpVHARpLUw8/dkDU9y0RR1z98VtIAQaUd9LlM
 q9EdgMfsKjzVGGoqf/PgqC8cG4LM0AODN8cb7jygZEq0PKb+HddAu13T5zGDDxdpzszE4qKNnSg
 8kjpOfAAwkvwE7AqpJQY1GWGQNW4OnpeZuLL74dzY3wAmSEmbDUCO+JW+OFl3odNJNDVIjxEf8u
 GdGGnlIj1jjwobZ5p0fGKlGzlZXWHypbC4Pq853jDhXzb0BFBnJvFjDX6LiAh4ACkyvK5OYJNU8
 kU2C2zFotAHC76vwHUQ3U50yOyXE+5rDQbrKkMorAGtDeNdpy5QVHo2tqyc35M9bB3ART0wZ5kE
 uE8Tw6mKRANAW70CLwSLFxZxnLwNmwkR+prKajxV74O37QGUaz1Lsh9o1M0T3+9SXDPihekPXBr
 yFBkgtwSY30Dtq7b9gxxrnv2pDk8HGmYqt7vYVB5zuwi0buRSm9gmdkh7xzGWiiMOLco0EK+m1g
 FQX9ms+NuAw8I8=
X-Received: by 2002:a05:600c:c490:b0:49c:fc6e:a3d7 with SMTP id
 5b1f17b1804b1-4a01afeab70mr67040295e9.22.1790847647365; 
 Thu, 01 Oct 2026 02:40:47 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:5563:a938:8fc:9dc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0226201aasm38937725e9.6.2026.10.01.02.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:40:47 -0700 (PDT)
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
Subject: [PATCH v5 3/9] drm: renesas: rzg2l_mipi_dsi: Move global timings into
 hardware info struct
Date: Thu,  1 Oct 2026 10:40:18 +0100
Message-ID: <20261001094041.135697-4-biju.das.jz@bp.renesas.com>
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

Move rzg2l_mipi_dsi_global_timings and its array size out of the hardcoded
ARRAY_SIZE reference in rzg2l_mipi_dsi_dphy_init() and into the struct
rzg2l_mipi_dsi_hw_info. This allows future hardware variants to supply
their own timing tables rather than sharing a single global array, making
the driver more extensible without code duplication.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * No change.
v3->v4:
 * Collected tag.
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

