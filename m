Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC3FCC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:51:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CDC891B4;
	Wed, 14 Oct 2026 13:50:58 +0000 (UTC)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA4A410FEC9
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:50:51 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-8935f42e8f0so260513b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 06:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791985851; x=1792590651; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9N60FEJPn+sUP2TONC0z9cgEmKUwGGHP2BKqTLaIgb8=;
 b=DgoDtG1B5YjQoSOiHne+AvcAVsYShI3YOs4bzjEg+mofEtOcwSA2jk3VrsYI1yMgp/
 BRCcHWoMk36BdgxssP9Hjme/sTPBe3NGj/osfsiP/IPhSv8XWiatAsV0n+1MnGQlsn16
 AqKmuDlhAHCKEDMn0uD1Qhu66awVaMjA758Htsm2yV43F4QWw7IocZtyDuaimpbNYAt0
 Ypdb3LMTIlPrwC2Myq2+K55BbpHiBZXXfn1mVKVvZ0zI5AHon/dCXPJGeNRa91f5hBNZ
 Hq2k9A6WGwqxLXY3WL3CTyaqvPF79Zhpptf1tG+YKvRDEnQ7W2+IiFDIB29bHblo5qK9
 ochw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791985851; x=1792590651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9N60FEJPn+sUP2TONC0z9cgEmKUwGGHP2BKqTLaIgb8=;
 b=JwqXPykCCULkvbpJi0fjtubopOqcrEjm6afWbLOoE8Fx6wK6qA5Jl3MUBq7WeaiodL
 EqEqyQAyYHFQfwEGxB2qUG2Kj6zLBCiJow89Mz6yYWxzDE1iT0noZI5molQoxTWwsWHJ
 6ySRbX37wJxV8itpLu2IoM1ARgd0BQj0Y6g96FefZYDMJV1qsfvWn7CqJGU33uz2EYA8
 mPC8hFmMgIUnUO3zw0aRDixzgCJzdg5YyaFDo8a2trUkEpno7lADAtvEQSs0+9nfPcUU
 t9amNctS8kE/RbmiAHEJFl03TtxBfU0zSW7mCjakwLi89W/i0z9SLmY8lHHvgtO/vAMT
 snDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzDbUdSBSHfR8ZhD3+t2WgB/qaO+Eg2LGaa+QY7LICxDQ2W5Wnf3KuORPxnBo9bIyKbi/BkJEdteLY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTDV1bl4/l70kbCcRdFcMD6Tj1FpyjwCGaEP834x11mvoAy7nF
 Thf/MEwHuupvXFdJPIQrmgoS8Ep+EWvjJ9BPHnlmZX6o8Z94FPkNtFku
X-Gm-Gg: AYBFou3JpWy+njYtvSO4gMJe+deR5ykj/m2FEqQIwgHKxTeYBhiJ9XvyjCV2WvS0YTI
 GNp6ZvEloRc965BB3cOftz3wK2N/N2ovD0HlRZ6pa+smTSMpvXMPOsWfurgk8WNn42UWlfLaarC
 qY7m2bDjve/t5Jfb+7vavPXAdGd2ErJHx8Qd7Ar56qaGjBcRsl9xphitk03F3bHFUf5muGTbIcr
 xXVnk1SAsvNbOfIqMxFw8JUF3WzE370OrmEK/fyQwJ1tg4Hkf8wTig2yQFmXdeWvVIdIG/myxh4
 WwSY/XzF5H+L1wQGsm8m5FBfsAGAISZ2sJfmXq/Q7ioVvmUiqU4zNO2mP546Eze1d/BnWWAc27Z
 TJHVTWc/7SF0zBoNC9ZxK7S4Xy4ysv8FCqRjD4C1Wd3ktU1DbRSTmFxzEqlWSwcr7fg/p/2N2nL
 9wS/FJKL8eTdpLof0tCsYR2g+CkcuRUdr5e2jwtBLheVObDNcsSURsThdGqqxxN7c1y+PUdbyQ3
 CvDZuJq/B6Yz6B6T5ePm8Ryn0oiKO5IQmsdBev/4oMRLAtemoK7AlN/EOxjKFWQsTxrk/kq4UNz
 g0YK9h9FLUkYxO4cUoKfQ0O6BkcbvA08yHlAxiMSIKWmSg==
X-Received: by 2002:a05:6a00:928b:b0:882:26ea:cd56 with SMTP id
 d2e1a72fcca58-897c73f3112mr13158156b3a.35.1791985851084; 
 Wed, 14 Oct 2026 06:50:51 -0700 (PDT)
Received: from NB150512.ADVANTECH.CORP
 (2001-b011-6c00-3d72-751d-cebe-164a-ae70.dynamic-ip6.hinet.net.
 [2001:b011:6c00:3d72:751d:cebe:164a:ae70])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89d804e514bsm1168418b3a.41.2026.10.14.06.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 06:50:50 -0700 (PDT)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: jagan@amarulasolutions.com, osama.abdelkader@gmail.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH 2/3] drm/panel: raydium-rm68200: Use mipi_dsi_*_multi()
 functions
Date: Wed, 14 Oct 2026 21:50:27 +0800
Message-ID: <20261014135028.1438841-3-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014135028.1438841-1-hungen3108@gmail.com>
References: <20261014135028.1438841-1-hungen3108@gmail.com>
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

Replace the deprecated MIPI DSI DCS helpers with their _multi variants,
as suggested in Documentation/gpu/todo.rst.

In prepare(), use mipi_dsi_msleep() to skip delays after a failed
command, preserving the existing error handling. The helpers also
log command failures.

In unprepare(), clear accum_err between commands so that ENTER_SLEEP_MODE
is still attempted if SET_DISPLAY_OFF fails. The helpers now log failures
at error level instead of warning level.

Leave the initialization sequence unchanged, as converting its write
helpers would change error handling. This is addressed in the next patch.

Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---
 drivers/gpu/drm/panel/panel-raydium-rm68200.c | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-raydium-rm68200.c b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
index c535dc931903..971d075bb060 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm68200.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm68200.c
@@ -232,15 +232,13 @@ static int rm68200_unprepare(struct drm_panel *panel)
 {
 	struct rm68200 *ctx = panel_to_rm68200(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
-	int ret;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	ret = mipi_dsi_dcs_set_display_off(dsi);
-	if (ret)
-		dev_warn(panel->dev, "failed to set display off: %d\n", ret);
+	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
 
-	ret = mipi_dsi_dcs_enter_sleep_mode(dsi);
-	if (ret)
-		dev_warn(panel->dev, "failed to enter sleep mode: %d\n", ret);
+	/* Attempt to enter sleep mode even if display off failed. */
+	dsi_ctx.accum_err = 0;
+	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
 
 	msleep(120);
 
@@ -258,6 +256,7 @@ static int rm68200_prepare(struct drm_panel *panel)
 {
 	struct rm68200 *ctx = panel_to_rm68200(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 	int ret;
 
 	ret = regulator_enable(ctx->supply);
@@ -275,19 +274,15 @@ static int rm68200_prepare(struct drm_panel *panel)
 
 	rm68200_init_sequence(ctx);
 
-	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
-	if (ret)
-		return ret;
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
 
-	msleep(125);
+	mipi_dsi_msleep(&dsi_ctx, 125);
 
-	ret = mipi_dsi_dcs_set_display_on(dsi);
-	if (ret)
-		return ret;
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
 
-	msleep(20);
+	mipi_dsi_msleep(&dsi_ctx, 20);
 
-	return 0;
+	return dsi_ctx.accum_err;
 }
 
 static int rm68200_get_modes(struct drm_panel *panel,
-- 
2.43.0

