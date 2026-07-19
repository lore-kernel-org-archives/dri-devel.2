Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFB2C4451C
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 02:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A0310E3EA;
	Sun, 19 Jul 2026 02:49:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EFpkAo13";
	dkim-atps=neutral
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com
 [74.125.224.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A5F710E3EA
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 02:49:09 +0000 (UTC)
Received: by mail-yx1-f51.google.com with SMTP id
 956f58d0204a3-66843536f94so789367d50.3
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 19:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784429348; x=1785034148; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=eUctq526SauCU2PxPCwSw6FjrhWQ6qRSV04+u+gtfls=;
 b=EFpkAo133X2g9GHV0RxoE+3OvVPbhtbrNuXoKPGawQD/541zPtyCbj6PStv7Q84dgL
 z2P44td+YKRIFn/DD+1lnwHMDpgJ/bjgUEp8Vv2CcPIcmhXHDNi2CnX2roq5AR9D75+5
 c5OS3XH1FWQZnO/a8DnRmB44KjoBTRfyDu0+1XAgb6/NkZfP+yydiuKY9Nnw3PqWHaMB
 ftHHty/wDXI98HHTxqfCjFF+G/kh1uli8Pw2tk3XwMZE589xFGPcuKDHxWkK4x4Fi1+s
 k1+jqnaieVvqJ4GFl4c4eOyOUc0Z6tDHrrb9iIYve+OJxFmatwiDfAW4IzIA8qcY9QPk
 LlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784429348; x=1785034148;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eUctq526SauCU2PxPCwSw6FjrhWQ6qRSV04+u+gtfls=;
 b=EtmZJVkTd89Ub1ggRVQlSyt0ojSYeXIYDRYWvk4Tp0lmKMAJdHejHgXqQevls0H4Tb
 tcr4VluELT9Po7yoSpqTgImDKM2bSkaXm9Ia9++Bp8ZIMiEb4rctEkNut+f9uzS9RUOl
 BrMQpYxAP7rznmyDTx2tvboUn1XurBwb6kqg7k6fz6IW/QncQXaM8PkJPenVAod9ctwL
 sI94YydoWlbLcd0Oy3jt7C1xT428tIzmauEVns8ltYzAct2tujYn60BEoKNiffy8xtfQ
 M4ayFfXr5yGp/cWlbteasEOMPlROxU3jnsoFJB/yLI1OwaIG5pq81z/GXV870t/jHBxD
 Yv7A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4tsQp4RSxm5YUSwez5tASWUycQ73XHEZXicKX6B3fYCEg5xhvDuvzJqaIfwO9v3v7hUK3ImhzqEE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMJJLT+7Vl8zJ3SfVlpo36KCWlaooH/We9J+zdgnEsh9o3j1lF
 65L0msaJpYHHNm4zWhSqPQWMJo4wEtUljBtm5iIzk8EKAEfGy/i0gUHy
X-Gm-Gg: AfdE7cknn02qyhw/uT5t3WUd87/Ca/quccpFfJ5N8KG1k3kygTGKgFEmaHM/67AXuKG
 EUmtBU3jwYlye2lo4rQnTxnIq9UNJuaNkg73gmRbbn+w58RO9/1CyoVb+oK7Kct0FZjCHYSCPvS
 4tQ7N87X/SrudMIqFvdUIdLOVtH8Z+TGOPkbH/kbscM7bAyXiICEMvrVMGZDEMzoOq3PAGPbhoN
 E6Yl8ILSokLbhMxpdcsT3ZQTgjyKKrnaPxeuooOO7eUqAjn2oB4fkk6N5/3tkpJe9v+1Vtc/lSt
 E4gSAfKzvrqI48TCjmibRaRYX5FL7un0dv4suWUTameYmw4UaZr8NkYDXEss6AZN0yMBwa8sIu0
 bGerKnyGOENzWRzbDKaIXhFPepeGGeaqoSy6yhuFNlAkSA0AYWk1Lio+TarfQSFBkpnYfUpukR5
 Ev3B8+LQmGVL16KWCYWfQLrhFtIkohbJ+MxeMeTUsL68Bgq26xaKWnFLwZjdE=
X-Received: by 2002:a05:690c:6607:b0:7a2:842a:db7e with SMTP id
 00721157ae682-81ef2857f78mr33203787b3.35.1784429347849; 
 Sat, 18 Jul 2026 19:49:07 -0700 (PDT)
Received: from nixos-office.attlocal.net
 ([2600:1700:566e:ba00:173e:d781:2a07:621c])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81ef42eb72asm36996117b3.47.2026.07.18.19.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 19:49:06 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, deller@gmx.de
Cc: rdunlap@infradead.org, duje@dujemihanovic.xyz,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, arnd@arndb.de,
 Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] backlight: ktd2801: fix unmet dependency on GPIOLIB
Date: Sun, 19 Jul 2026 03:49:02 +0100
Message-ID: <20260719024902.151710-1-julianbraha@gmail.com>
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

LEDS_EXPRESSWIRE depends on GPIOLIB, so its selector, BACKLIGHT_KTD2801
also needs to ensure GPIOLIB is enabled. Otherwise:

WARNING: unmet direct dependencies detected for LEDS_EXPRESSWIRE
  Depends on [n]: NEW_LEDS [=n] && GPIOLIB [=n]
  Selected by [y]:
  - BACKLIGHT_KTD2801 [=y] && HAS_IOMEM [=y] && BACKLIGHT_CLASS_DEVICE [=y]

This unmet dependency was found by kconfirm, a static analysis tool for
Kconfig.

Fixes: d95963e309bc ("backlight: ktd2801: Depend on GPIOLIB")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 drivers/video/backlight/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7c66b8840d88..dbf4ca23a9b6 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -193,7 +193,7 @@ config BACKLIGHT_KTD253
 
 config BACKLIGHT_KTD2801
 	tristate "Backlight Driver for Kinetic KTD2801"
-	depends on GPIOLIB || COMPILE_TEST
+	depends on GPIOLIB
 	select LEDS_EXPRESSWIRE
 	help
 	  Say Y to enable the backlight driver for the Kinetic KTD2801 1-wire
-- 
2.54.0

