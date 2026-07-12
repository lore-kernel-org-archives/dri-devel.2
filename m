Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B525C43458
	for <dri-devel@archiver.kernel.org>; Sun, 12 Jul 2026 00:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AD9D10E3D7;
	Sun, 12 Jul 2026 00:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="koBoDRze";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A3F10E3D3
 for <dri-devel@lists.freedesktop.org>; Sun, 12 Jul 2026 00:08:27 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b7612475so16637335e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 17:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783814906; x=1784419706; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0oa153UtIPgzU5R8cN79Y/SDl3kCNRRvJ18KAFBFKP0=;
 b=koBoDRzehptBsbeaBR5jZY5zQH9THeLW9U4UkDyZ0L9W7gCU8vvb4pOIXi044g2995
 ctJ/c7sHZ+TSazrGtRy4S5zlhXnBOrCf2I/++C6fsmjCicA+MNPlo8JhYekIoyajR/lk
 FTjTGuBXL+Nvcp3EPBCxjt3S2qB7Jo1vbGsm4nwnrzcKPUxlDwGbGXqv7q6a+/ExQom+
 deHoti0XXMuWJWqO02Adt87E9CZsANv0Qd3lQBJjG/2/5fiWGvEm7L/LTY5LH0SD9g2j
 FPEcDOgnntYOo3LajKAWCbIxWduYiuWsVm3Lb4VEKW8z9S3l8shw6izvg5aKJH2D5Q4f
 iLzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783814906; x=1784419706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0oa153UtIPgzU5R8cN79Y/SDl3kCNRRvJ18KAFBFKP0=;
 b=TAwHs1WkZp+QGphBL/xdirdNIKBJ+/GfBVp+aSDWRubviEYuu2VdStPB622BcfK0+e
 0/9ZZ4St1y4LJCbQAPLGSA9cfEaUlkK/A9UPTig1lwi1Ukc/x3MumpEpRuk/5J5sOK2Z
 WUxZOxrZJLZ9rChKFcjNbsIibeFXU06biYF88fCyQbesGyo4XVxq42AGJ0UrJELOPP/q
 It4ut1+jcvjqrXHzNGp+c+oxKZQ+aGttwawlVR6CNriC1l3ank/rv37Zt/AUZCmps2DG
 MbcwpomtlzwE6N3cD1zzIxlI0JK95/ytFbufGWin+o5SyMa/HG18fFPLmY4RavsiNd1k
 3G/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RriurOrNTYuJJFpejwFi00Nj8XkIb4jFaKIS06D6wrm2msmpBtdBs34ys7UJXtKQaGIbXMtOlJ/vy4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylLGf275q0SNRTkaCsjTv1qDdWSlmz5ak11fVVW7XGcpBhK3Sg
 F+ED896fGSuuAENNK8YhDateEMcmPuhzMxbZ+q826CyVntB86bKKJPr3
X-Gm-Gg: AfdE7ckfeqXMoT1CKKygHvM67blQziHeM9TaUkUBwFXSd6v73INNAqSMsPDYTh6aHom
 zSne+DyNSUP7zLe35YGhuILSDpmw7hFhzoYMzF7ZGdkelpsScQol/mXpf+a9GnJjk6ssRpVluO3
 J94tiulruqw0q0HSKB1Qa3f8wXIoGPKT+aBYObZkMrrbac0Kp+ff1BkEmxNCwZoUrQ5B1SIn2Al
 tHZZcsXU7qr4oXzuATMjW9Mj21CvvqK+qQMHyQQb0i7cntJOoMN2Mz7y9ShQyLKJ9FksPCgy0KL
 8nS9nTPu4GA3gCxa+NX2Gj/wJDVF1IkSyBVWQkPTirWTcvrwue3mu512j6PvzbRgcTh/2w3uEpQ
 u8+DYHKURtGU+RhhHBWeFjKV9bCRT3oJ7KuDU4inFjI6ZfkxBToFyjLCeLGW5CU951RSRi3MHlh
 zwXAiBTVapl/zDJj6gzBhcfZQvxNqkE/SwW6KoDTQppMZvxUa52QXtxYJvfU/cgh6Ui2M1h7SkD
 Gl8FL3NLpIxIX8=
X-Received: by 2002:a05:600c:154e:b0:493:aa28:38ad with SMTP id
 5b1f17b1804b1-493f87e9b68mr42761585e9.10.1783814906248; 
 Sat, 11 Jul 2026 17:08:26 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d910sm69931667f8f.6.2026.07.11.17.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2026 17:08:25 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Cc: jesszhan0024@gmail.com, arnd@arndb.de, david@ixit.cz,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] drm/panel: hx83121a: fix unmet dependency for
 DRM_PANEL_ILITEK_ILI9882T
Date: Sun, 12 Jul 2026 01:08:23 +0100
Message-ID: <20260712000823.2315810-1-julianbraha@gmail.com>
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

Fixes: defab7b01e08 ("drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
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

