Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF96C531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 505DA10E579;
	Thu, 23 Jul 2026 12:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zvagr3DI";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C30710E579
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 12:28:23 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso379283f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 05:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784809702; x=1785414502; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kHSxDwM0Y6FUMCJyC98ds2ox0gHcqUAID04qqyOi0zE=;
 b=Zvagr3DIfUlOlBAMa6M2QPrncuV8Yr6aw60MFzpAhCKXZTn1a0AhR7qkeKCWM8TkLs
 E0udXytexaNLODnVdjpROWGeMw3il0E/36X3vOoPlQbE8Xy/tl482OTrHLsbS8hxO5Sd
 FDCTn5NLLvAVGYf4pYOiT7OZfwrzcHkmEOpSaZyoOSZVYq/a5k7A24o7zRpoaBuFMqeZ
 R4xR7RRbeYKU6V4D9Pvl3ok4SRB8Rm5LRX5LBmYMjymH89paE0a7IRs1x24dTUPpezAH
 CSqdnUTjWPcqJ4UF3aT4nTwkNvN5b8/FKbRBC6hDp44ZB12ZN4zr3QadlciS6ybMILF5
 2U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784809702; x=1785414502;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kHSxDwM0Y6FUMCJyC98ds2ox0gHcqUAID04qqyOi0zE=;
 b=hzFbRGhl8tvAudLOJgoYXRPe1wDtKE+Ktn/4EhY8/zUrSXJGjefmWejzyAjhqNTM29
 6mYE6iwIn7kg1FmeWpN6O8EtNPMFtxi3SOgHgwawUtsALX3G9J3nZDssrFk5MIDeNmRq
 m4x7yG0E5LMzb8XRKQxvpKh060JdqHK88GEsJicVMkAo7WXVKPCtJ6QC72K0hhp1M2s8
 Y1b6QkF5PcC4pVR173oZhGYuhUju5+GYQxaYD7qg4NyX+yKsTk+voHJJGPuk20LzK7/T
 5I6wB+oTGXNkAiBFDiEXPmWsQtd9+17M0dWGtPv2eEUe7Zx+Wyd7pjW9eP/ATlSVI+7N
 2ySw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rry3TcG3Hsg1214Sf1VBXcKpTJYbre9wo3YydwD87Qujz6ZdRU0gX3CH54BD1rmP5V1/gTrVIVu4kY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyvCqDfEDip5kv37JjOVm7OHr0iw/i/RnufcjQ6qq2M3GsWPBvt
 n5FNmIq5ToH5l7ZkSb96jzateUzEByC1WtyYNYQtTT0j4Q6D4/a2h5Ie
X-Gm-Gg: AR+sD10u8U8p3LMUagzO50khEK/qhl8fyxo6/jOQE9qc+sy9cRh6SEk0Q+87yLYv0Ae
 Fqd9u8Uee8AI2REH9XnS8Pbl66pWrUCBSPh1OotsOTrgnGGe5yyX5OWg9m/GSfV+uxXwr7V7MHy
 oGjp+qtltbucc3h6N2MHCB/g2DqkHl7gSWtpt5o8voA3Aw28pBye4fyf5Fks20Gv3RupzRgl0mc
 hMPRP0hMBIX4VO2OOa1QwnBrq43i588VWJrYim7v3J92ryk6xfW+ttF1wyfAHGZBV/ZHCTIbbB9
 ctu59+Tq4psyXdb8rog9bbkGXm5DvPNd57uOumfMAm5jVSskiFlOWh0g0C8zFDjLaFA1m88X+3O
 LykVZX+MG9/+F9cghyZVy//HQgSNGqdh8JGw3H7OImuN6MmwsoImF9D9a8sEyLtVrITa8rjd2ut
 5f0gyPQEG+dxhcrLGGHShk0q++y+kzv5pTJBFkHrc/IJlEPvpSpbs9py/GgXjfI4QvvhI6zIMwv
 6wB
X-Received: by 2002:a05:600c:a218:b0:495:6788:c229 with SMTP id
 5b1f17b1804b1-49573cb99bamr18898445e9.4.1784809701703; 
 Thu, 23 Jul 2026 05:28:21 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a509901sm255799575e9.8.2026.07.23.05.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:28:21 -0700 (PDT)
From: Julian Braha <julianbraha@gmail.com>
To: deller@gmx.de
Cc: tzimmermann@suse.de, wei.liu@kernel.org, ptsm@linux.microsoft.com,
 arnd@arndb.de, u.kleine-koenig@baylibre.com, hsukrut3@gmail.com,
 rob.github@jumpstation.co.uk, enelsonmoore@gmail.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v2] fbdev: replace dead select with dependency
Date: Thu, 23 Jul 2026 13:28:18 +0100
Message-ID: <20260723122818.437802-1-julianbraha@gmail.com>
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

'select' does not work on config options in a 'choice', so currently it is
possible to enable FB_MB862XX_LIME without FB_LITTLE_ENDIAN.

We cannot replace the 'select FB_LITTLE_ENDIAN' without also changing
FB_FOREIGN_ENDIAN from 'select' to 'depends on', otherwise we will get
a recursive dependency.

Since the default choice is FB_BOTH_ENDIAN, let's use:
'depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN'
to avoid breaking defconfig.

This dead select was found by kconfirm, a static analysis tool for Kconfig.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
Changes since v1: support the default FB_BOTH_ENDIAN
Link:
https://lore.kernel.org/all/20260722220023.196029-1-julianbraha@gmail.com/
---
 drivers/video/fbdev/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 085d3a202148..e8cd8cb76874 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1717,8 +1717,7 @@ config FB_MB862XX_PCI_GDC
 config FB_MB862XX_LIME
 	bool "Lime GDC"
 	depends on OF && PPC
-	select FB_FOREIGN_ENDIAN
-	select FB_LITTLE_ENDIAN
+	depends on FB_LITTLE_ENDIAN || FB_BOTH_ENDIAN
 	help
 	  Framebuffer support for Fujitsu Lime GDC on host CPU bus.
 
-- 
2.54.0

