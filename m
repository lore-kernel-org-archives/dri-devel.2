Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA379CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 917AB10ED16;
	Thu, 28 May 2026 07:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dqlzfk4S";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78B710E7BD
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 15:39:27 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490791a3e92so1421035e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 08:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779896366; x=1780501166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ADHAKXLPSV+B46SoR3AVK3+w80ncz+/VZrd71fy3Anc=;
 b=Dqlzfk4S6cYbuyn5VFnuXClAK8qwPxuu3vw4ZGhgIKluMryXcvyiMnxjWZ7+wnzNyI
 Irghj/YDfxFxEP0TjTabituXqF2iMDYlPUf45f/ZMPSnbzNJ4wdbRZRU0B0BTPmuo6RE
 iX7JyKvT1bRhMMND36LnKI8vWC2YX5iX1ZeZWSYPSOqkY7Qes2EvIIPe0nFENroxa3xN
 K14qhyw1r/oRwzQFh63nIhQlNJY8y9sz/mRCT4WYDWN1vN5atWMNyB94mUICcUUk8VlM
 nDTm+LEPdwn3tcyDvbyof4rTfG77C2nzU1BFDJ/HUX2S+0LOlWBeIkCivx2a0K2WMouj
 YirQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779896366; x=1780501166;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ADHAKXLPSV+B46SoR3AVK3+w80ncz+/VZrd71fy3Anc=;
 b=QBiTyRx/wzfHZ2sLDcQU3uZ6BlaDNe5qJNmf6jDnyTYkPLLKLDNh9Wy8IDMESj/w7R
 bAtHaQgSRPvSs3F7tstK+xrUNGSV6yz9l0dA7CbGEkvtHWJTdhYR/bWoh4Dr3H52O20v
 EZbB8AxkX30Wb3ZlWWt43llw3Nl/3FnXerFrTo0F89FEWqKBfhYEDRP2JY04Cwf+WKQo
 ABUWOSFXtnadZJ2+jUaoYss1WDuJkxuaBTRgfDQ9QS3I4Ranmx0t8cp5y+onjBcnd34m
 6rdbBrIT1VZ3eKOwKSmAUA6Rp35C+TAG92g4kQT+hYX4I0Ymqvhqs+xzo5Xu6yKj9nG0
 rZXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9piEr0CrFyDwsV4ghYYLgH+s2Vmgmm+qSxk4gNY09KFkwB0+IZ67kkeZBBQii5XKc4OLe6ZpxcPEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywy66Kw0He9xincTk+9g1fAV0UAPms0givR9FerejzVjOslvrDI
 oFr+z/v6yoHnBRSST+YbOcrkdmXGI5O+szxHcBgm5jspvgQwevbhEfgQ
X-Gm-Gg: Acq92OE9YPA/FHk5KnsKwXq0ea6gA8NFfX0WCENJ/FdKQq4pQNwqJuqJ/8es1tnfAY9
 ZE14b2zaA4/Q1OQYRj0cXt0AAxNrxPJy/QImNEVgpBR9rgKH5gdUjtLnN6KJBO4CxAf/TKjlu3p
 wzHVPdbQXvltGbD4mKqwW+JlIA7M2IvTnUeB/juz8pkOkYWnJAGFAYpTA0KgOAxA5wnnVo4ckbe
 bwm8ByM6WNd4zWOdBPSC413zcXT83wNhSmWKvJdzws7TQuhXfHpJEiTA0rRaiwcIHy00Jc7DqlL
 vAI5ngPrSpc8ck9L5z848rRq74d8+BDYyLV/eC8rGqQMopoIUfezd4C9sBi/3waeljqpvfd3wpT
 //0zCcfXxj+3h0hWCt25D0wHE3dxpMCDKIBpvGy1Mcfulkz4RJFxUWHlkHexxlV5xCGodqxLldf
 +GeROV4zRXaFnOaep4lfRB2VWq7NUG3X64pmgXWAmJV/hlNh0hLHEWvr8xDUK+5L3Z/UxV3//aV
 ZR+8KDOz8c=
X-Received: by 2002:a05:600c:4ecc:b0:490:502:8422 with SMTP id
 5b1f17b1804b1-490428e2ceamr162598325e9.6.1779896366116; 
 Wed, 27 May 2026 08:39:26 -0700 (PDT)
Received: from simuladores.arostegui.proxmox
 (178.pool85-58-80.dynamic.orange.es. [85.58.80.178])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a6cdsm7241937f8f.2.2026.05.27.08.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 08:39:25 -0700 (PDT)
From: =?UTF-8?q?Alberto=20Ar=C3=B3stegui?= <aarosteguig@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 AlbertoArostegui <aarosteguig@gmail.com>
Subject: [PATCH] fbdev: pxa168fb: use devm_ioremap_resource() for MMIO
Date: Wed, 27 May 2026 15:39:13 +0000
Message-ID: <20260527153913.33342-1-aarosteguig@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:17 +0000
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

From: AlbertoArostegui <aarosteguig@gmail.com>

pxa168fb maps the LCD controller register resource with devm_ioremap(),
which does not request the memory region. Use devm_ioremap_resource()
instead so the MMIO range is claimed before being mapped.

This also handles cleanup automatically.

Signed-off-by: AlbertoArostegui <aarosteguig@gmail.com>
---
 drivers/video/fbdev/pxa168fb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index ec602f7776eb..6784888d93c9 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -653,10 +653,9 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	/*
 	 * Map LCD controller registers.
 	 */
-	fbi->reg_base = devm_ioremap(&pdev->dev, res->start,
-					     resource_size(res));
-	if (fbi->reg_base == NULL) {
-		ret = -ENOMEM;
+	fbi->reg_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(fbi->reg_base)) {
+		ret = PTR_ERR(fbi->reg_base);
 		goto failed_free_info;
 	}
 
-- 
2.43.0

