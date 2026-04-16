Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F72FA0C23
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C337410E835;
	Thu, 16 Apr 2026 07:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HW3qqMYy";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18F610E835
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:39:37 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-35d9c7bf9a1so6769201a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776325177; x=1776929977; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jCegayYB0PENmbMOz7Ts5R4TPK8wv3h+gE07w9piCso=;
 b=HW3qqMYyVGUssQ/OIC5Eb8zLDXrvgcXaoAbzSmA0y17oD+WJrudGfiYXj3fyqeSRqf
 PUJfXrNZ3pHzJwC3R01hKCHNU7MrFZoyaSst/1+GxHrR8B+PrILcHcCoihxBbFXq6U71
 3ulPla2esSP/ub7FBLkZlmkM/v1AlAT9I0WAQNMlvGW647NzyiambL+2D1LVYHZTc0XW
 V3uCJ6koFC07yLxBbTSjEzCsScUmKOzORTvpi513on4a5Hj3m8S3+bw2yUA2jRKjRCae
 28BWFDFX/5LIeREJeJcACdAVkKk/jpIUczvX4RjBIRIMWyHela4Vq5lChfM8tURD4nZN
 oVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776325177; x=1776929977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jCegayYB0PENmbMOz7Ts5R4TPK8wv3h+gE07w9piCso=;
 b=EXEw/AR7qu1MFBCExLqKPwki/QQ+pgoFXOblmVgIQzaBCk7mDS4s6Or3U6RgAsZ+Th
 oOSukelSYkYD/8huTci4DNFBpIOLXCcFlzAvdE+DflnuZacq8ddjxGAtoLy4gTWIEdZt
 BckjhJzR/IgeFOswik8EFS7k9W+WGk1De8ILbxjpcHlnj/+xcRpdSSNbq47abRDCTKSW
 4Wp/F04KLcAcZZXDDyE3RYuMZ5aOgAWWPZI+tod44NCW1l1cVnd+TCKrcojJ+ResD2D+
 YeY9aIxv8xFFrlnvKi2X26G6979arV6hTmmqmpNUq3jaJgqKtPlohwxvts/yQDkYM0bI
 OEkg==
X-Gm-Message-State: AOJu0YwZpjjWtM8QGEOuB5D9uQlVC8RFs3J5tpGY7qb2aaQu3ZO5qDJk
 F4EmOMSxzghbS654PgfG7WMTJRs7+EvQMbEXwMshFvFB8reqB5ArYxxVZqJfkKfS
X-Gm-Gg: AeBDievYpNPOOwVoJVu7AMrr8ajgV5lazynnVGanbL2+gzSVDvGRyrVkmfx75aru82Q
 DUFKHJ5JsjVJ3/ViS+Xw8AlcOlxMjSQ3BFocCnBQawfqrOIoXL8pSkHBqtLbyq5Sivn8XwyhTiZ
 QoKqhP9bIo3Z0dbBhCC7eU7vLgqdDRzrHBFh5wOwpRWpTaWanb7SOCXw9rEJwDA0u2Q4JoC1Ixy
 YVSgKDoi7OD23fz8xGUK6DDLrAXBzSgs/vzBdi4spZTiH6/70kKhvbNCSHvAiu6N6MXk/r6N93d
 kMeVmd26+6lPDaQ6cqTSFX8k2HFYPAzyhH6bfucdvhQKhNdF4g9o5osOrcG10E89NJPqSNWX+1N
 ZKBzv2eUsBKNOTReFGw/CFQYKQTY/Cw3w2/FzVhn1Ci3mpqEgxkZoITjWSCFRZY9fFbG/4a7XY9
 Prt+8gcYQ4YPOzZG18TpvKP7XFuNwHpbA1f94FA5fNkz7nkdL0GxZ4tK3YnlNGQVq1gA==
X-Received: by 2002:a17:90b:288f:b0:35b:9b77:d7c with SMTP id
 98e67ed59e1d1-35e4285338cmr26207579a91.14.1776325176898; 
 Thu, 16 Apr 2026 00:39:36 -0700 (PDT)
Received: from fedoraemon.neon-universe.ts.net
 ([2406:7400:11d:a9dc:9a14:72eb:1a60:868a])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36132d9d228sm1735245a91.10.2026.04.16.00.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 00:39:36 -0700 (PDT)
From: Avinal Kumar <avinal.xlvii@gmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 neil.armstrong@linaro.org, dianders@chromium.org
Cc: lumag@kernel.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH v4 2/2] drm/panel: panasonic-vvx10f034n00: transition to
 mipi_dsi wrapped functions
Date: Thu, 16 Apr 2026 13:07:22 +0530
Message-ID: <20260416073722.719036-3-avinal.xlvii@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416073722.719036-1-avinal.xlvii@gmail.com>
References: <20260416073722.719036-1-avinal.xlvii@gmail.com>
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

Changes the panasonic-vvx10f034n00 panel to multi
style functions for improved error handling and
removes redundant error printout.

Signed-off-by: Avinal Kumar <avinal.xlvii@gmail.com>
---
 .../gpu/drm/panel/panel-panasonic-vvx10f034n00.c   | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index 3c3308fc55df..f9e547c8b1b8 100644
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
@@ -95,7 +104,6 @@ static int wuxga_nt_panel_prepare(struct drm_panel *panel)
 
 	ret = wuxga_nt_panel_on(wuxga_nt);
 	if (ret < 0) {
-		dev_err(panel->dev, "failed to set panel on: %d\n", ret);
 		goto poweroff;
 	}
 
-- 
2.53.0

