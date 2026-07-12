Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061F6C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 01:04:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E082210E40E;
	Sun, 12 Jul 2026 01:04:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Aij36X7b";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71EC910E40E
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 01:04:12 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so37881565e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 18:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783818251; x=1784423051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IH/34IPpqm+flKepaUz3IWK/5zpVie015ZDy8bQoYCs=;
 b=Aij36X7bobGCVqgK2IQ6PTsvD75/K8sjlkjYEo7VEMEjXmB4Kf44QHDfU+On6XLNsL
 M7UUP7jntQq+UbSZP0U6u6hbWj+E0vlhC+5pDAoR3GNDYoFbQEW7oBilKZ+xuQcqeDoz
 kFwE/TJUKgqFI8CbMk21pG/Lh69ZYc7ucSwsp2TIno4MLsdRYFKE8FcOq2PLAMyHaqaR
 61FFkktwLq7s7BXbfdosgv6vccwtAbT7C7OnBc5SNk5ZZopaMoMVhtXHpkqa/3/vaasI
 EAAPer/tHursIZfkkP93GgsQVfmCdUOCF4MxwuAgi+yQ150CUs+mpX14yHBh7ZckwlgW
 Mc2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783818251; x=1784423051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IH/34IPpqm+flKepaUz3IWK/5zpVie015ZDy8bQoYCs=;
 b=nVPLuKw2ghlcBrkpmwXKHH7hWfaCG9FdIVZoChD7ekJfedGX2TGtPZMDUz67cxYPJL
 iLADwVmugY3JTIH3SnWUvnJgmSgFNrFjfvGbpA933aB6TCpWZBMrFG8QsPyRA93/YlPF
 71bldRU/ESW28bAZoG+Z9kY0gCakGTzJp8C3WZaIqqxvh1lT+zd4v56L4b1fai19r6St
 /vklYTZLT5nO+uRWgePx2DSH1o9OIIUt2q05SICparvfS88Um8SMmwKYdg1lyRPWqA3l
 EX2D+cGtQze/kubpCsWQTEAcjwvqTTM6TDteEFCdSzvTzXBOvhHS0wJNJ0pfd4/jdPDF
 1qjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmqmYv1IRWj2obP8BOSDWa8dxt7znldilAJtGJbPuUTqPWG5jP2mRxl30AE06UOz5VGCn09tf6edI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaWqkn25W0oK4vCn9hUOnaK1jTImrg8dFEkrblqTD//KQ++7Ki
 EZHx/ablpl5h/Cp1Y4R320Op+k701bpD2ZUqTVBY31oIFhY2hoFK4AF0
X-Gm-Gg: AfdE7ckhRm0Y/H+z4Qrs0C5wJXOsdBGWJ9u6SZpu/SIknADLTZVkLwNLDTGwDvit5BW
 /BWNL7M7p8RnKpRDnKANBCauEq/t4KDP+sVqeCaJmuKsWSMAXODanVu2s7aJDaO1CmsuOcWswDi
 Do8g9s+FQgF8SUTnjy+g7X/PP5WJ34wJONNaKcrrbw39n3HWCuusSgK9wCnOxxa6mBvmPDB5P/i
 OoQcynlOYSalo238AtwrGkNOH3exK7LKfM1bvOOgCBWl9vQRNOJpC0akRBETGZNh+iNojl+KnJA
 1NHvyP2TloJsfSw8ib9DSmRr/dmd4RslRTEpSMWCbpa7PE1SifBUQE8+k7DA3eDvspICn6mo5am
 h5Q66Dz2SPMbxTJ8zD30CPPnlVzkp/uPrfHL9gQ4XSAdgucKWwyWYSqqrG909AYf7HqsQYGedG+
 z/2LZMOVGJkK6hsaeWRCMGWMu4VMAp66mcqYFK+yamR02cgz6wQ3TeOV4c+pMyDVZENZgJwu+Yi
 /yi
X-Received: by 2002:a05:600d:2398:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-493f88d2f7cmr27656375e9.17.1783818250715; 
 Sat, 11 Jul 2026 18:04:10 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm188580565e9.2.2026.07.11.18.04.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 18:04:10 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, Frank.Li@nxp.com, s.hauer@pengutronix.de
Cc: arnd@arndb.de, kernel@pengutronix.de, festevam@gmail.com, lumag@kernel.org,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drm/imx: fix unmet dependency for DRM_IMX_LDB
Date: Sun, 12 Jul 2026 02:04:07 +0100
Message-ID: <20260712010407.2387049-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
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

Currently, DRM_IMX_LDB selects DRM_BRIDGE_CONNECTOR without ensuring
DRM_DISPLAY_HELPER is enabled.

Other similar options select DRM_DISPLAY_HELPER so let's do the same
here.

This unmet dependency bug was found by kconfirm, a static analysis tool
for Kconfig.

Fixes: f673055a4678 ("drm/imx: Add missing DRM_BRIDGE_CONNECTOR dependency")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/gpu/drm/imx/ipuv3/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/imx/ipuv3/Kconfig b/drivers/gpu/drm/imx/ipuv3/Kconfig
index 3ca237515e46..c54b176649f1 100644
--- a/drivers/gpu/drm/imx/ipuv3/Kconfig
+++ b/drivers/gpu/drm/imx/ipuv3/Kconfig
@@ -37,6 +37,7 @@ config DRM_IMX_LDB
 	depends on OF
 	select MFD_SYSCON
 	select DRM_BRIDGE
+	select DRM_DISPLAY_HELPER
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_PANEL_BRIDGE
 	select DRM_OF_DISPLAY_MODE_BRIDGE
-- 
2.54.0

