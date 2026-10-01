Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946CCCA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA2E610E361;
	Thu,  1 Oct 2026 09:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ghRBZpii";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A83C10E337
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:40:47 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ff9621c5dso38146875e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790847646; x=1791452446; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uE8Y/GOA42pEAQBZUN716lEqGW7syf1sO2zhDpHNTp0=;
 b=ghRBZpiiQhZzi2bM2CSq1L1P5ryOP9lCz/tVAsSv5UM5dtM43cWmxaK5xHxPHDXuQC
 9vidO4mw/QA5MgBOvzOizZhd/tp9iTOyMe1NY6Z7rleoNvwGc6HfapthYt7qlp2LGRsg
 QKFwCdf6wdQofzK5J3Z0Zza2YbvCC6vJQIpuqmz8hdGLA9qBXDRHOJMN6q3y9YJH80E4
 LZNb/CyigKDx4Mja0TpVZGRgrZPOqluVx3z8Y4o9J9L3vYWSIG/rFhyqhbmcLJk6gDOP
 enJTc1l0K8u/mDvpWytBzDi+LyZmBNCZ8gF2es1FOEpLjWZkUSHLwpDozn2DjleNsQsd
 VNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790847646; x=1791452446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uE8Y/GOA42pEAQBZUN716lEqGW7syf1sO2zhDpHNTp0=;
 b=2DWuH98/g+mh+19iWVZrCCogp4Yj9S1Bb6/2L6lrw80Ot/wdXT4lHpYI+WNT85Iihk
 8qwE66mAkNs06CAlXe8OPgcKAN/4bqVgCzmcQU//4o/pQW2JzwFf1qvEeaAHJ8FmFOy4
 gzJyOQAgdf3kB/Fb7Ja4BkC32kqtVy+sDQ7PDtu7+ECniiY39dTc4x6Y71aKQt46VkG6
 CW/rsD3Xm4k6JM7Evdm0EUNrNCkpXt/VidaBZ8P6byyEpmnDKb6nNl/BdYg43YUyZKMU
 ISGzdZAlfgi33w39ZQdWBjO+VVniIUS2vEs3CdrSrzPRjM+E5OmahhePU7idBiMz3whN
 QSpQ==
X-Gm-Message-State: AFuF++lKis83koWaKQdfDEe0NSx9vZZHb8N2wPk/cTn1hKJP4PY9fe2/
 1dYBssJytkqS/0Hd0XviT+Hbg7rPJY+EKIpwjF2wP45CUJkTBtsiBYy1
X-Gm-Gg: AYBFou2CTL7NRxKi21xp1MrgUzwJgltw/7lUnOnV9UN23mueRNefuqb6qe26Ca3WRoV
 gCzzhQq/WBZ/KvF4htyccLU7jKA6PRoa6PdDNdjijmsbQS0Ji3FszNi5a6CoFs3a7iaFV0KgcqH
 5o0g7TdP/q4L8XFbTZ+BB0opWhtQXX2p/z2TGQJrN1f+Cmswg+VFxmfQ/kuoqyK0wcJwF8mDXhq
 +udcA/ZBMPHgcKmwEwbFA84VzXoX37lQMZ7ZDn8sos+jrPKArkDxT7teQNvZhC6xCjQ/KI/d19F
 YYHR+9zhATQuYuF4NALzjVfU2gPJ4NdgV7eXnjlzg5/FJe07cKV51OwF0ofeAm0ph4QkoCx+RoM
 LhNVfuTvBxomze3G0tVCbf3lyXJ0kcVTVd/z3klaBGQanw1MBdh/qLcnH1GPfj7R7uaHVPKSqWU
 mNgwlz8//OeJXQZhCtsrxCv/W1+3gY2c+acpV2663IFVBz6Yu7Oqo8+VaD0OrWAUECLf7Dg9iPH
 4fN
X-Received: by 2002:a05:600c:1c19:b0:49c:cfbe:5a76 with SMTP id
 5b1f17b1804b1-4a01adb2cb6mr88790415e9.2.1790847645616; 
 Thu, 01 Oct 2026 02:40:45 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:5563:a938:8fc:9dc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0226201aasm38937725e9.6.2026.10.01.02.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:40:45 -0700 (PDT)
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
Subject: [PATCH v5 1/9] drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val
 to hw_info
Date: Thu,  1 Oct 2026 10:40:16 +0100
Message-ID: <20261001094041.135697-2-biju.das.jz@bp.renesas.com>
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

Move the DSIDPHYCTRL0 initialization value into the hw_info structure as
dphyctrl0_init_val, allowing SoC-specific D-PHY control register
initialization to be defined per compatible. This prepares the driver for
supporting SoCs that require a different initial DSIDPHYCTRL0 value.

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

