Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F7DCCD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 11:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73C2113F95;
	Thu,  4 Jun 2026 11:48:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kAYv+s6T";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2261113F95
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 11:48:21 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2bf125989f2so3931225ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 04:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780573701; x=1781178501; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+NpC1bqSInGOO1aahZDlWqyayeuLAZFyoOtvmQIUnHs=;
 b=kAYv+s6Tbs2/SYGl0i9knmXMLV7MffbFBTZXCbkicRjqsu21GsJWZimc+xnX1qXWbe
 UWzCoInFo6VJkDS8n/rDAUm7A6slssdkrV5c1mLnH2cnYpsxfKIOvPktRxiEfFK+mnh+
 iekQ54jQzJUAujEwD1j9JNvHGeZ4J1Vawe1l4joQ5S4R5tpcg6CV1rKYub30WeTNj2rO
 2a+mKHCkLPtQO8NcFyQaVRKXdSGSHRqk3Q+wkMTyXFisl0bYK7zJZ2FirY71FAixT2uP
 Uhvgho1cDZ34DfGNGpFDCGyD+wagDDqpDj/gBdp7Cy9zzWSnmzYBNEVVWilc6kfj0BSD
 9PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573701; x=1781178501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NpC1bqSInGOO1aahZDlWqyayeuLAZFyoOtvmQIUnHs=;
 b=ZylUpR7nkVHis2O5EayOJasljImyAxSRNhDtL9MbcHjberw+OwIg5pt84L1olhFSm5
 g5qg5ber+hTtzY4aWN6Q+EZJZARObOdg0NYMddwaU9wLdKAn7w9ZPxWpGoXa0NLb7lA5
 SaNwmJfg33HBGMy2BotYCyTTCWbAuFV0BxYT31flb878QH8ZN8RTDOCOy82S8SdFfrXD
 aEwdXLG5klI9NhBv916y5LfstyfplhAk7x3vCd6bwEEQNYG91SN46WVIpBl9kf4M/dR3
 WwAUiI0q3HMmCjbfiZM5JF9Nq3IUUCKRhzi9OXbNWoL7Mmrj+vn4T1grQUzx9BOiiuey
 lmHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uwTFs2PH+Ntm07VIrCpMnwtXG4LFtCz+8VmsxOAnwAeAOqTxkh+ihUZqub9w6++lWGwfJFNnQMW4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymSsnbI54snNhA0cFAD9A6CtlOvorfztsG+z9chLd4LdYGuY+0
 astllZltRfdyNoI8HbHSD3jnFSnxm25E1vX1r2QP8Yx7ZgoNSii0+Rsh
X-Gm-Gg: Acq92OFFJAphg8Bm5Fc2gCFjEfR3mxaDPBfYl0KYfoBBA/l1GoGM97ChqLjGbOkxcRF
 nPXVZzEdODXHbwG7RZtIarYIbdt1yo7sDxzp1w67O1SWQV/wvcG+w/hHoH08bjcVg44TlrE7bwP
 lq40bm7mM+ea8lkEFdcsjJVcWzo2zaC7Jwecefls4p06pVMOk0C2ib1Un247rsAhCcr3TmJumPi
 uFzVOQujmIBphH+dsrcEPfMejwDk5beB2GBvmdaKVXTNbRUl7cWH1LbfgtCXo5EtIgcncUDvXfr
 bBBfnrdiaTMBlHaPJJ2EXBz9RLD0g7MH0GgASHg751+0ITPpeC1RgQrwAfzv/5lgJMie9Xay48t
 IVzIr/3uyu45OguoCiTY2fzq/0yvjAgNtI88X9dQ8Fsl+Ah36OAxRlRY+ex2csCyGFLtzRHQyaO
 vJVorMoF01vHt9pqBX
X-Received: by 2002:a17:902:f78a:b0:2bf:160f:7038 with SMTP id
 d9443c01a7336-2c163a12d2emr88021725ad.12.1780573701192; 
 Thu, 04 Jun 2026 04:48:21 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c166396fa9sm55550165ad.66.2026.06.04.04.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 04:48:20 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/bridge: samsung-dsim: fix TE GPIO ownership
Date: Thu,  4 Jun 2026 19:46:04 +0800
Message-ID: <20260604114604.1422184-1-lgs201920130244@gmail.com>
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

samsung_dsim_register_te_irq() acquires the TE GPIO with
devm_gpiod_get_optional(), but the descriptor is released manually in the
request_threaded_irq() error path and in samsung_dsim_unregister_te_irq().
The devres entry remains registered and will release the same descriptor
again when the device is detached.

Use the non-managed gpiod_get_optional() helper instead, so the GPIO
descriptor lifetime matches the existing manual cleanup paths. Also clear
dsi->te_gpio after each gpiod_put() to avoid leaving a stale descriptor
pointer around if the host is attached again.

Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Samsung DSIM bridge")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/bridge/samsung-dsim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index c3eb437ef1b0..2299b7dc0c04 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1862,7 +1862,7 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
 	int te_gpio_irq;
 	int ret;
 
-	dsi->te_gpio = devm_gpiod_get_optional(dev, "te", GPIOD_IN);
+	dsi->te_gpio = gpiod_get_optional(dev, "te", GPIOD_IN);
 	if (!dsi->te_gpio)
 		return 0;
 	else if (IS_ERR(dsi->te_gpio))
@@ -1875,6 +1875,7 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
 	if (ret) {
 		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
 		gpiod_put(dsi->te_gpio);
+		dsi->te_gpio = NULL;
 		return ret;
 	}
 
@@ -1886,6 +1887,7 @@ static void samsung_dsim_unregister_te_irq(struct samsung_dsim *dsi)
 	if (dsi->te_gpio) {
 		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
 		gpiod_put(dsi->te_gpio);
+		dsi->te_gpio = NULL;
 	}
 }
 
-- 
2.43.0

