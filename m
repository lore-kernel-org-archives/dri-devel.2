Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0633CCA5FA5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 01:31:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C3910E22C;
	Wed, 30 Sep 2026 01:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n+Uzdda2";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 907A810E22C
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 01:31:04 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a2adb9bc3cso1712985a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 18:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790731864; x=1791336664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pj9wMOIWQ7bNvdJuP9LsvNqHENYI3grFwHw1yx2eN10=;
 b=n+Uzdda2CwEN2i3TjeLCiNkcTx0HM29mhwMq9Y2ByMJP+APNoJyJHkVs9FA9S5TDyp
 OVD9xK5NGHl4Qn5/uInhs86AXwPKBW1V/GkSEJ/R7akQL2txV2psmrAERO/4vBU/oYGj
 xXI1pcPNAHPeNWkwArWWab2nNqmPtCJ/631Dc+6oBSMZUyy6gVnD88F6tOkf26ju445P
 WHc7hUMHo4klWyDrG8u31GLk8pPiTL1+tbkI06t2tQWw1IptR2HTk4Gq98/16xtyCSEL
 VKbKvU4nmkXh3+fXiTmElvd++K9OBB38/k7PVkzkMrrche0cdazjFXnaHb5zilq75n/M
 1iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790731864; x=1791336664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pj9wMOIWQ7bNvdJuP9LsvNqHENYI3grFwHw1yx2eN10=;
 b=QPsxLDuxQc0OIuDpWU2TJQ1BbCKCRYBcrZpEz8TceuPcNDmtB3nNAs6D2DDX+/TUKF
 rz0LfjZzNR+ZDi+9KToZqyTSZdMKS1l/36LLLgbRNKWtNK2WjsUk0CZwFoou2UVsc9u3
 0z1Cl/ZVFRoFBV94HPDEoxtsmNPV67P3n+NQ6xuCnnGQuCqcJehV6oVOQ8fCBWpsaJyX
 R28b6iHPXa3n5eG9iIFw7ix8alHk3t7LMmLIVZWpQ/iNC9gQv/hm9B21xs/YjUVTW+ex
 Eg4S4FX5NNdOWJVByFwIwtEPb3KukLxhBj3TaKzKi9QzsEKvtsWgEqk3Hx1iLRSoyh/D
 tZ8Q==
X-Gm-Message-State: AFq9FYLRFJ+X/mr5wC7JBIKTEjfvCCx1xEzuqb2gjPHxuQ9skvBgCBro
 1p5qiRcleejq2jXQkx96ZLDOwv7xHrydKo5rf+D8EPiHx/8PbgsF0+0P
X-Gm-Gg: AYBFou1XxbTYS0ZYMBA+RUWKHeszYEwoBaW6UHzH6CGwd7MeEg1eojVPogoRhRpnR4J
 pK8BQuTE7r1H6pveSFKQPkLhraXbPKtWMib4T6L6jYrNb6wz7o5sTCDM8EhRvF3UHgUspEiIoGf
 I2b6R0/stebxS6xRm73GFM3hM4YNCgmyCEbihWeOBrDMeetvWPEgNzatEQ0lCUg+b2vmF+JZQTP
 oa4lJooQzAadr2dm9PNbNUd6eMm24qlTXhKsv3SyRzILC+gNFazLAE3XyZ3PGSc80u+Xu36VmQt
 DSrxo8BtJVhrON68krFFKUiEgTU/LAE9XmTgWVSpR86Jipxli+Xs3LsDH97/F1KjNNDcTIuIlfA
 snLNJlJ2uY+PsK0cVtzSRkV3c2tnjc4PgVuQEIY5xY1Vmz+dMUtaoiTZlhMVLMT3rezjZdFeuXB
 KwBFgpxiQW9Idn5AhipkmCnbSmC2dc1NUwqpjnouTaY5qshVRCWpBQWuFXCfPqZDIWiB0WRHBgO
 rlVELfskZFrBN+947dpRffqMxO4upes+5PtRoo6jIS/FuZdZPi/adUM
X-Received: by 2002:a17:90a:c2cc:b0:3a4:cb6d:aca9 with SMTP id
 98e67ed59e1d1-3a4cb6db018mr144245a91.64.1790731857501; 
 Tue, 29 Sep 2026 18:30:57 -0700 (PDT)
Received: from pc130107.ADVANTECH.CORP ([123.51.235.159])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4caabaf9asm553179a91.8.2026.09.29.18.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 18:30:57 -0700 (PDT)
From: Hsieh Hung-En <hungen3108@gmail.com>
To: dianders@chromium.org, neil.armstrong@linaro.org, jesszhan0024@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, Hsieh Hung-En <hungen3108@gmail.com>
Subject: [PATCH] drm/panel: ronbo-rb070d30: Ignore DCS errors in disable()
Date: Wed, 30 Sep 2026 09:30:29 +0800
Message-ID: <20260930013029.3241267-1-hungen3108@gmail.com>
X-Mailer: git-send-email 2.43.0
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

If rb070d30_panel_disable() returns an error, drm_panel_disable() skips
clearing panel->enabled. unprepare() still powers the panel off, but the
next drm_panel_enable() sees the panel as already enabled and does
nothing, so the panel stays dark.

Always return 0 from disable(). A failed ENTER_SLEEP_MODE is still logged
by mipi_dsi_dcs_enter_sleep_mode_multi().

Suggested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Hsieh Hung-En <hungen3108@gmail.com>
---

Notes:
    This applies on top of:
    https://lore.kernel.org/all/20260929080143.559685-1-hungen3108@gmail.com/
    
    As suggested by Doug in:
    https://lore.kernel.org/all/CAD=FV=UU+NS0T-Ga8i12QKTNCYOu8kar_6=NsH0=4FVUFyKB7A@mail.gmail.com/
    
    Compile-tested on arm64 with W=1; not tested on hardware.

 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
index ebe6352db..2d54182fe 100644
--- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
+++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
@@ -87,7 +87,7 @@ static int rb070d30_panel_disable(struct drm_panel *panel)
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
 
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-	return dsi_ctx.accum_err;
+	return 0;
 }
 
 /* Default timings */
-- 
2.43.0

