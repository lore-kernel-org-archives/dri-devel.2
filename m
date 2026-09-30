Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBA8CA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 579B310F3F8;
	Wed, 30 Sep 2026 13:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hu2fQTNv";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D88E210F3E4
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:08 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af4663da5so1461762f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775187; x=1791379987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u5kSzTFtU8H0oThccK4Asw1nQQnIMXeScYzPiW6YHxE=;
 b=Hu2fQTNvJ5D9SRfkbCbZPfXupasq6LjIxfzvqhAA/IwSTaYXVj0qGWOtQOIPzkI99k
 F4sBLIPwSGGfk4U7XKobNz3nav3j0DudQk2dxvIKsn5npKKNLPvn66YvtpYvNWnhC3Vx
 tmoEUotcYbhRiUuSYgOQ5gdslMulQNyBL0mtJS2J8UP0GxZqmUpcWnEm0rfxw3Px/f01
 r65FxwQ6T/GPOUdaQ69Q0+R3SpCZFMTe5FMWqSP7iim9ySJq+wQvqpJUrYlBHzdtJVqM
 s7Fz2wJ0r0TR0uXMCNLkCSjb0g4uSJrSRQ7hcKiDQtNilzDTAZlBybjJ2oTx9oRf5hoX
 mjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775187; x=1791379987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u5kSzTFtU8H0oThccK4Asw1nQQnIMXeScYzPiW6YHxE=;
 b=VTCHAc+b9meu5rxWHUK8+t09aPX2YEauzJXxwKsWRVRkGwmrDnmpIn8WWNXI+YIGzV
 kuanwb9UUzJOVIfy4tcZuwEIHfV1zAIRHf1pTFgxBbXM0Dpd1gjKmucVhM/R5feXaMLs
 EwdR8XjaQ6FJjU5pHUHLqupLy9hsqZzpLSWq2kxHSfk1s6HPkiE+PL/8qM6Z0kfEKgs8
 eIbi7NVw7ICVasMDrvDa5Hu5t0thFDNbPwZTPsfn5riYdEH0Md5/Vl/NPuPxZFeIpwtg
 JGl65/PXPtEMxYDRJKYlLtx7OyC+KOcD3vzOScMNlSsxoIHN152VUOJPd0vuzXhEKJYe
 uuKQ==
X-Gm-Message-State: AFq9FYL7hFqTGYhto1CYS5wX99+Dg3GSOp2Nq9scqA2mWeJpEnN/HsA+
 ZpRy7/fdT2fXgQ+N631qWQcy5FxNSxYoepyy732e71oGnilx+GmlLp15
X-Gm-Gg: AYBFou2oG11PtsafA06njsOODHM8JH/MTdGRAayyRQ5+ijaR5Zw2obHp3P803mG35ky
 zId02igHnP9uA7/hxIw+gXzu9+7r0g+eSB8wyi9mLXA/Dg/wcd+MUxgZ8ZhQlyhEyoEg2j44UkH
 q7KlrZF1cC3vVaD+hrmfEc5f34F3C/mQwj1/w64t6JehZNKxt3F8xfgn1dpwDF2vJl+is2amPu/
 x8gEXZ8m3kVinvFCeYAi9U/UldjqCM9uSOJWnZ6TCpgWwt8VnX3o5t+3UkKwGGrJorvMiZXt5PX
 HjTT/7cj1z+q+JaqvMlUQWqJ44kvVCLXf9dc0XVo14Tj5uYXZlLnmgqr01ehjkj6f13BkHHaQf3
 rZZTywKhn6xmGQo/Zciy+CL6D2uIPh2iERzYpbTFInML/MGOrrfOTT/99wlXd5BpIrvx6gpyKtV
 Bv1q0QNLGwtvE+Lxtlts+eKo3RD2ez2PWP3I0HcerZCpYv47We39AP1A8PqoTH2K8PbH/Ju33xu
 tpGgUKpsKocri2n8e1NO0I=
X-Received: by 2002:a05:6000:4814:b0:48a:eeef:b4a7 with SMTP id
 ffacd0b85a97d-48b02541665mr2708487f8f.48.1790775186962; 
 Wed, 30 Sep 2026 06:33:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:bade:1500:bcd:b3ec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f2b02sm3685582f8f.24.2026.09.30.06.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:05 -0700 (PDT)
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
Subject: [PATCH v4 3/9] drm: renesas: rzg2l_mipi_dsi: Move global timings into
 hardware info struct
Date: Wed, 30 Sep 2026 14:32:45 +0100
Message-ID: <20260930133257.23210-4-biju.das.jz@bp.renesas.com>
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

Move rzg2l_mipi_dsi_global_timings and its array size out of the hardcoded
ARRAY_SIZE reference in rzg2l_mipi_dsi_dphy_init() and into the struct
rzg2l_mipi_dsi_hw_info. This allows future hardware variants to supply
their own timing tables rather than sharing a single global array, making
the driver more extensible without code duplication.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
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

