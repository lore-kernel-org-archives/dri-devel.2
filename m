Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69DEF8E4A7
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3699A10E957;
	Fri, 17 Apr 2026 06:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e8QQWTXK";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1305A10E957
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 06:19:19 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ab39b111b9so1169255ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 23:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776406758; x=1777011558; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ce4kj1e/j21mTp4sR9FlUv6X17cBMM3lqzUbVzs/6I=;
 b=e8QQWTXKX1K2ip6/K7xvbF8iS27+MoVYGNbmEEcT9oIqZn6CbMlo6Ljls3rg0xoP76
 5KoWdN5J/PV/RpigISH/jTuXkxmYabJ2MaVm1f5zDYMw/VM/2+xXs4ThOKMx9+qc9/ae
 z1GiikFA197HOswTc8dav7rPLh2AVn2ef3EKQUzXa36dn8Q8UeQsNwEn/LpEKKg33E0D
 DWurikU0Y1QFWKtyOk1yeWf0eM4HD9CqfdhJfZH385b36BfcPVOTEPDbLZuBisNJeCIl
 a5wAb3L1oKiTTkuibKVBHanwnKbEyeQfu0g4+0M+gfvIPhN1VnbsK0wGFR8ugK+AQq7i
 Ckgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776406758; x=1777011558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ce4kj1e/j21mTp4sR9FlUv6X17cBMM3lqzUbVzs/6I=;
 b=hSnoAPiA+yffWKM8IVwEVU7vz/ceOvmtDWVpGl5agbUxNqB/V9DQhMhINUJq+WxHvj
 QR5pHnuGn1YAR8UdlKfPafQ0pRBGVd7akmtM0t9Yj3LuVP3wBDkRS5Bw9WJ3HlSgfrhM
 kedy7bXDUUTIY52lx/sabd2d9wAT9JpADo12fl+rT1+4QB4Lc4DZw2eDhB1kJECIdrF5
 tYR53DfT5TyKvVFcC/fX0LRsfa45woxetnReti0uC1RQQHRpsVbMiaVxJ0jQxP1jMR1p
 Qnn4ksUTS0bWjsL1FpuT152fEXelZkZPR1qulo3ogg8RLaeiIJR9Oxwp633MbtLupYWr
 wUMg==
X-Gm-Message-State: AOJu0YwAmbNl7o9TZhb5NC/otSlMqyhv7ARK/t9KgMIjmMN1sVKZisma
 5ZKIFTq127HGNVQf+jbRx583624CVnucdq5bqfV09cRdHEIJ++DduuDQ8bxOVw0R
X-Gm-Gg: AeBDievxhp5YV5aZJ+vdd8+nr6KAdDdnNUE9H/pQaiqlhydKFxfWFz+OcBO1wIz8CAu
 YZKYWCGMRgX81YznSrGedQWWi4urfZRISye4PLAwPE3WVZMNit0u2TaedzzhA9am0FxYN9WmBNg
 eHDKZG71FtzamTHhnInH5KLK0bfNuEEHJzwOTpzeO7rR4vyqAmFwaRORaA8flPIJHBeEuxziqEP
 qoHcmwgGT1KClgmsgvDaoYNezV94fbPPQ2CP7BHD7uEQcQewRB0KU+2p+fn/Hzy1/xPceJbPgxY
 QWbRdBhAWSQR07ypp0WUT3fyI0NyUaQvjbIBeW2fCNrTBMqrD22E733tyrFHom9EVopzNmZnlvM
 6SqeQRDk+AhTi0VptKcGfLSdM8f0vGiuOqRmo27Z+olkm9E0NLt1PRD6To2nX4L3oiIn+EK5ZPP
 qLbXQj/Mvkzi7DEZZpsQQzDtb6jYVNvVzrvtKKIdapigiNFgRZjulLCok18KvsHZPsAon7zBj+g
 WtD
X-Received: by 2002:a17:902:7585:b0:2b2:5704:5715 with SMTP id
 d9443c01a7336-2b5f9eaea6bmr9483285ad.15.1776406758105; 
 Thu, 16 Apr 2026 23:19:18 -0700 (PDT)
Received: from fedoraemon.neon-universe.ts.net
 ([2406:7400:11d:a9dc:9a14:72eb:1a60:868a])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab40786sm9046225ad.79.2026.04.16.23.19.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 23:19:17 -0700 (PDT)
From: Avinal Kumar <avinal.xlvii@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org, dianders@chromium.org
Cc: lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH v5 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
Date: Fri, 17 Apr 2026 11:48:42 +0530
Message-ID: <20260417061842.66631-3-avinal.xlvii@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417061842.66631-1-avinal.xlvii@gmail.com>
References: <20260417061842.66631-1-avinal.xlvii@gmail.com>
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

Change the panasonic-vvx10f034n00 panel to multi
style functions for improved error handling and
remove redundant error printout.

Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
---
 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 24 ++++++++++---------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index 3c3308fc55df..d21d93a0700e 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -44,14 +44,23 @@ static inline struct wuxga_nt_panel *to_wuxga_nt_panel(struct drm_panel *panel)
 
 static int wuxga_nt_panel_on(struct wuxga_nt_panel *wuxga_nt)
 {
-	return mipi_dsi_turn_on_peripheral(wuxga_nt->dsi);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = wuxga_nt->dsi
+	};
+
+	mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
+	return dsi_ctx.accum_err;
 }
 
 static int wuxga_nt_panel_disable(struct drm_panel *panel)
 {
 	struct wuxga_nt_panel *wuxga_nt = to_wuxga_nt_panel(panel);
+	struct mipi_dsi_multi_context dsi_ctx = {
+		.dsi = wuxga_nt->dsi
+	};
 
-	return mipi_dsi_shutdown_peripheral(wuxga_nt->dsi);
+	mipi_dsi_shutdown_peripheral_multi(&dsi_ctx);
+	return dsi_ctx.accum_err;
 }
 
 static int wuxga_nt_panel_unprepare(struct drm_panel *panel)
@@ -94,15 +103,8 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 	msleep(250);
 
 	ret = wuxga_nt_panel_on(wuxga_nt);
-	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel on: %d\n", ret);
-		goto poweroff;
-	}
-
-	return 0;
-
-poweroff:
-	regulator_disable(wuxga_nt->supply);
+	if (ret < 0)
+		regulator_disable(wuxga_nt->supply);
 
 	return ret;
 }
-- 
2.53.0

