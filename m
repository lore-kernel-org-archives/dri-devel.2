Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DC3FD5F7F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 06:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E466E10E52D;
	Wed,  8 Apr 2026 06:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LIKcAtTc";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D8E10E52D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 06:51:05 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-35d965648a2so4601407a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 23:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775631065; x=1776235865;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U521sUYf25ASEfCtOQX+Ill+lllnFxxt3OJbaB5Iblc=;
 b=LIKcAtTcfXHn09e4EUrloLdHaYwniHRyFwDftVqOlBNIBVxRP7Hrw0PrW6RzEhQzUf
 8lg/XylO9Isjh8klZUJPcDjwngysIuF2C0Q1nIKME4mb4BdJYaPR/17i8MD+PLnZUx0i
 1YrdJUhaOpWYzgFBHrBIHlVIMKDd/BCfq6OHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775631065; x=1776235865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U521sUYf25ASEfCtOQX+Ill+lllnFxxt3OJbaB5Iblc=;
 b=Aukj+yeQgR4mR2BRL/oj0y9Lhhgwged7V4w3hPh3HnHIk9cRB1m9VnKh+YQ6YPBmm6
 xZ4exUpKCQrmbtG7OtjjVUBFVfjcfuU/HlUCgOWFtkugU1XxcESH3NCzwH9PQ1rxfkX8
 RkewnAiIoM5NbHuuwPRdkwGcCcNrnBSzND0x8WeeyBSmDa/CJpieMKdcAppqGeoZfoLJ
 QbdQHwnsu5JBRt+sNQXaTkEFtbV8sSOstrw3qHinHvrXciSLkfWNrWijn6dFIbnxjbya
 hRyEE6oMWFkKYgf+LgxLbbjamP/gNtrEchthJh3fV41/4xjFLi+wwAWSryO06uTBdkP1
 7ZGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrXOENDomYeRVcGH5evUHhePGZH0KEmGGcBh1FeJEVL/FCIFZ0/b/UjmgDL7PREmumekPfjxhkPDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtVnYOpbG15iLNY7wC1F8DQkn30/+M3j3euE4wEzSETeuZkFxA
 rIhpd2ceUR3FVU3HvGpcf9imuJlWE2CEG2WoF30pQuRMjxToL0TqLCwCZE32cw/arg==
X-Gm-Gg: AeBDiesy+gMLd/aGRO97pxOMJMQEtpSYOhF3nNaOPSOdny3l2b5SDWwtx6FzH8CD9Yd
 elkw5UT3ncs3IDe/xKx1buDySqvWszWo8dH8KeycUCtaP/Z5TmIJiYdvk/8yCLqEo3T8Xs9Lyf/
 kWuCRnF3AW3GxHW8ImCtroxTrL60JIylGpM7a5cFWHJYMpCsZB2dWHoeoL1ubj8l5c6dTaNp923
 sULxWka+cg6H/7oaqlGA0NXk+ZaaXDgRUl0WBuiTeoYB1obPr5fKTUXPltAUimXQELYYUCt0i35
 i/GtFS0D24DR4gTyL+2oHKkGVGMRBq3Dsd4PiRZe3XVGaCyIckFxEfsPZmuBURPCHrcsbrXpMwF
 udYWSVXKu32lifK2SunKpcDN8KjX2zwms4QBmszYAsb/eXzP85eSaa3q2UFpwWny0oVr4FbdU3w
 iNhxkfixoQ658KpeRN7RIsTrd2kNh+uCWO/+0/EScWA3DTHwjLZcPhyQwcg0lguDZInfDLYi8i5
 sdHpfU6apJ9bnThHww=
X-Received: by 2002:a17:90b:4f43:b0:359:f3b1:6811 with SMTP id
 98e67ed59e1d1-35de67db862mr18680927a91.1.1775631064757; 
 Tue, 07 Apr 2026 23:51:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:f0e3:c8b2:74ff:70d1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35dbe959886sm24889460a91.14.2026.04.07.23.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 23:51:04 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos/fimd: fix register offset type in fimd_trigger()
Date: Wed,  8 Apr 2026 14:50:54 +0800
Message-ID: <20260408065055.1353444-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
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

Sparse reports:

    exynos_drm_fimd.c:992:39: warning: incorrect type in initializer (different address spaces)
    exynos_drm_fimd.c:992:39:    expected void *timing_base
    exynos_drm_fimd.c:992:39:    got void [noderef] __iomem *
    exynos_drm_fimd.c:1005:33: warning: incorrect type in argument 1 (different address spaces)
    exynos_drm_fimd.c:1005:33:    expected void const volatile [noderef] __iomem *addr
    exynos_drm_fimd.c:1005:33:    got void *
    exynos_drm_fimd.c:1007:33: warning: incorrect type in argument 2 (different address spaces)
    exynos_drm_fimd.c:1007:33:    expected void volatile [noderef] __iomem *addr
    exynos_drm_fimd.c:1007:33:    got void *

Add "__iomem" to *timing_base to fix its type.

Fixes: 3854fab24e89 ("drm/exynos: fimd: support LCD I80 interface")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
random warning I found while checking for the size_t warning.
---
 drivers/gpu/drm/exynos/exynos_drm_fimd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index b6abdc4f2b0a..695d3515d421 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -989,7 +989,7 @@ static void fimd_trigger(struct device *dev)
 {
 	struct fimd_context *ctx = dev_get_drvdata(dev);
 	const struct fimd_driver_data *driver_data = ctx->driver_data;
-	void *timing_base = ctx->regs + driver_data->timing_base;
+	void __iomem *timing_base = ctx->regs + driver_data->timing_base;
 	u32 reg;
 
 	 /*
-- 
2.53.0.1213.gd9a14994de-goog

