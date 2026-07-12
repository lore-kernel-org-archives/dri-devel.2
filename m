Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E128CC43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 00:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 322F310E3DA;
	Sun, 12 Jul 2026 00:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nlsk3CK5";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2C510E3DA
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 00:26:37 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493f45e206dso8690645e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 17:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783815995; x=1784420795; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Vyu2chenameFc+MCYEA780kmik+YeADnGHoE4d4Lfog=;
 b=nlsk3CK5rm42CAbzi9fBduYQNmgZ01HGt+jb/SEkiE/TckAQ9aZFOz6feafYvZ/W9g
 yiW9AxbvzL4DMmsh/XsbB1bANUtZi+NR/C6oAe1DNj+ZW5XJL/v1dATDOFbc20boRXoj
 YkvNcuV6IQ4qJRFYp+fR7FT0s1mePxKTwqpM3e9LSXFedG/sLr1awJ3dYI84Jhbnt3CJ
 z2NE+IDH6wWom+KmVb7sf6g7iPuy0B69LlzTYr5IXfn73PyO8PiGtx1kmaVA+8NXqiET
 4AE+Qb9UyF9Co9NWAt7Mvb+zN31Lgtwr3zOoAzZQOgjO++NHlot8aqOp80eHgH2GRabR
 CAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783815995; x=1784420795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vyu2chenameFc+MCYEA780kmik+YeADnGHoE4d4Lfog=;
 b=fLEyKHvrMClYlq/vwrxQQx1unRLhYEynWFl3ExafzkdybsmSFAxIgtZzvU5xuVbSQ0
 IomeN8kVM1WyAu2j13wRTn3FppgvICVXZwCeYKgNGqWDltFKk397jTCELdqB1F+JA12+
 mcd7V+/NKYONcPVumLxH9wqH/UHyGx3x0IOigbh4qaRcwlLBS5xskl334iVI/0ck0Pxk
 xNkcOLgzxPg6Xd6i/Zzq+cgCFJFpVNak6Mkdy+f7b4C0juAu62BX1KaK9Phg8J6M8JMB
 CPdCpSpdHa2EomtHpV0CSTb5aXpxtyI+jr4uxf+cQqIsby4R7s/2RGSerz38Jzv8pBnf
 dGbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnUF/Qwy9ReK91UA3GcElEOrJ2ePLRmWoAQCZCc4svX6uSrMG8pg8AoJjj8NP01VEhceoYpZrAApY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb1mU5y4Q+kG2YJdnsrAs/3UnPGQIbXuPNjyAAqa1pSVlAv+14
 MnxlKSQB+NsLe4bcDyWSRMq2fVhGH9WsSdg8CnHjfVfR2weE1+9/UODu
X-Gm-Gg: AfdE7ckZGz6WGQNQb42JDXLVxpKuCj4hdauARWSAgNg4YiYorrnLYe0ce54A0C67m6h
 YENumJ0ziGjWR9vgOLPW45F/yOCCpKPDkk2APOku688tR39kHKAFaw+e1UBRP2iFa6NWy5ZbZom
 lZ5KsJqPet1MwQzHFFyhFoV4CC0e9Ul6BXBPeSEPlCM/YBM4Sor1EbUE9wGg67oLhNm0BSYpKyw
 Ldd0+mhr9kT0agE7NSjWr5rm58uNOOKpmnXRbBBfx2Vf9QLvh8w5Kc/iT7uq+wqfKmDTaNnQI/N
 +bIJRXB2XU/16uq45jRUgKjPh/OeosfOyNAvFEWvIFLjovMxodvhxKIZ7UlxJ3CSdUb+rQA5/Lb
 WlBcn5HY04WJ+6D4tbAL68m7gM2tgTnfgJ7avUNqLscUDz37FKiRtAw3RpaQv4sHxfQuhJ8evCL
 BLiIaindzQzUotcWlyM1uUcub4m9MXg184rG2BENKwVbauKR1S/+vkQekpgfxTCP1JVjFR2wxoK
 vUc40oVbCBmTUY=
X-Received: by 2002:a05:600c:3b0e:b0:493:f806:fc4d with SMTP id
 5b1f17b1804b1-493f88268e9mr35799445e9.0.1783815995427; 
 Sat, 11 Jul 2026 17:26:35 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb74b3edsm291598785e9.15.2026.07.11.17.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 17:26:34 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: jesszhan0024@gmail.com, mcanal@igalia.com, arnd@arndb.de,
 nicolas.frattaroli@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] drm/panel: ilitek-ili9882t: fix unmet dependency for
 DRM_PANEL_ILITEK_ILI9882T
Date: Sun, 12 Jul 2026 01:26:32 +0100
Message-ID: <20260712002632.2323484-1-julianbraha@gmail.com>
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

Currently, DRM_PANEL_ILITEK_ILI9882T selects DRM_DISPLAY_DSC_HELPER
without ensuring DRM_DISPLAY_HELPER is also enabled, causing an unmet
dependency and build failure.

Other similar options select DRM_DISPLAY_HELPER, let's do the same here.

This unmet dependency bug was found by kconfirm, a static analysis tool
for Kconfig.

Fixes: 68e28facbc8a ("drm/panel: ilitek-ili9882t: Select DRM_DISPLAY_DSC_HELPER")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v1: fixed commit blame and commit title
Link: https://lore.kernel.org/all/20260712001541.3AAC01F000E9@smtp.kernel.org/
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 06bfcef35a72..103f1d09a989 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -375,6 +375,7 @@ config DRM_PANEL_ILITEK_ILI9882T
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DSC_HELPER
 	help
 	  Say Y if you want to enable support for panels based on the
-- 
2.54.0

