Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D545EC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3CD810F314;
	Fri,  7 Aug 2026 06:47:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="Q8YMbfFc";
	dkim-atps=neutral
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E206E10F2C8
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:28:28 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-66843536f94so3595733d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 13:28:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786048108; cv=none;
 d=google.com; s=arc-20260327;
 b=TPZEQN5nKicS6550RJ4gUp6sE/eOCltDfqwcPj+1Ag7PTvrd0G0hJRUvLO19KvA14z
 fpGdiZbqqbLE5iRk4dlGfV14hpXs+8ZOWpiM8PN9xpKbTy6kiCF/GKBdAmOVztGCHZCr
 dL2iDbJloAxqX9g1ENLF3+8QvojWGjip6oXQ54dz5gENsavyjq4Uq07SW3Lenw71AAF3
 ca28p4rocRTtaxULSE4EhN+vJdBhejwsX6CTISW1DeLFCzNXzYL+ulOGIkJIOKba0Jxw
 y9dDoVh1Y5Ew95Pwvy9RYyil7KTC8SUvuv9Ya+Z3HfTgPatgO8wTp2FhhGMa/FUV6CM7
 n+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Pl3lOHYD5u9a9DZft1poeG2yn48m4MRRkvM23CvELd0=;
 fh=m+6CpZ7ZuvAvj1wumiMhf0SXcqpV8kkizWFQi6JBdKY=;
 b=J7Y7rIb+iNozRy1tziFyHtvOAieLYAav0k3rWAOUMBMGpebwekXXYCoa6IH89OPbUQ
 Ds7nAWlzCIGIdYFxAPKnGjyczqQ3Vzb3ztLbmjL2kA4e/nvJwre11q7zGFnZQUyHT9Q3
 SB1ArHkcO3NKsAJ42nziRA1Yuvsy5XNGgv2JNeV5k+6Jp1u00s829OgYSTUKeJgATbcU
 MEfm6s3kqMoOozdN6ekLvmIuJfYJqaBqKyKEq6II9AO5liVG7Z0IXKOKtOqFrd2WQI+2
 zxkilNMpTK4mDFhBuV3DBVB5X5hTBUi3ebCXdqXGw0pfPHBY4WObo1GPxx52QLx7C/fO
 WdZw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1786048108;
 x=1786652908; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pl3lOHYD5u9a9DZft1poeG2yn48m4MRRkvM23CvELd0=;
 b=Q8YMbfFcwCakhBiUjbqHzDiEpvv9Um2j66GQnAW0QGvHbbmyAJjbxPnFWIXE6hzw/R
 ZygaX2IAZV6owyYFp57sKo0Ir3ULxZlVP9J5naBxOh/LgtECSF8oSjifKggOMnqGg0Nn
 XuvoNNhmEErp81QB7pn7yNffld1rpsKdhoaqImFSzPEiYLlNHu/QSDkARsEJAyH3BWQE
 4uAL/Mg5GyzW/ODNF/M76N3GpM+wf7Q1KvQvqoLaJiZw3h4H0IZMcyJZKAG2Hx5la2+u
 XeG7wMxoCex9SKLnh3JRGBzPdw+mIsCqMdsG7/lryhDHkfvq7f9tBXUlbYeE0lz0Bb5x
 NFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048108; x=1786652908;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Pl3lOHYD5u9a9DZft1poeG2yn48m4MRRkvM23CvELd0=;
 b=nVLYQolsZGcfImn8S/wdv067j9X437ucm5fmEBGo/u75tK9cI5nImNIA14sW0hIUJv
 UmSfSXDNplGBk4Eahyd8mAsUQ5EiV7BICp1vbNHvesV9O7UtvUtROhjOaLLvTuGYHEr5
 bbN4P+FFAX7T8CUCH1JWT+rmr+CDQZMoh5gPUYUdLlH2Cw1+XmgtH1ceiCuIBemjA/WT
 7EXotZKnM50tUk/xn1AoRcZ6803smHOH17BWCIXdoYex1PMaxHalMZciMaGQAEnQfkkl
 hpnL//EbLCJ/jCvXg3JgMp0blbrQTu+sn+csQpsQYrj9wWbPZEsho6DDlxWo4pP/qyNn
 IqkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpy8QimkK7BK5mQprKmy0ok6u/IPaIjkFyp6bU94hf+v+hlAoP34CELl0Pf3ccJLzbr9GCFzmsV+kY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz69UM40pLb29x3xgjSt8yLQTu4OhRyLudAWNsWtSnzx18/B5PA
 rW822bjNZnmEJaeaddxC5L7GWGQTo6tHm9amLSito54ryhNzt1Z5zgx17qTJPDaSONDnQxliJt5
 l4t+wXXgY2GdW3D+8BiRoG5VXE/T19JMUz1MVE2ge
X-Gm-Gg: AR+sD13w8CEv1eVqb1rXGkzyddXQKkECghODQsSxf7fCvKSXc0L16Q1ihLRllrMbB/G
 x1cMDSoJNt9gCa1fZ7QklwAgG8ZiQJ2R7hKgIfclXxzyZuQFfaqVP/ZULSWPpqcWcTh9MzgQ11J
 ltbHhxjZnml9tn0BzCAgZ+zAr2yVL0QKdDO9nBiNhpOPW14tvnel2KhB5Ru70JJJvycvwUVZ7eo
 2JXhZ2wyBJv8Ae8kV0vVzgqHJ1CJH12NqevQ7ENJWFBVnjVTwxOGxceQmDADGaEcg3kTwnRxtiZ
 pjeQdqK7O7tCMZ7YpvJVJ+otFbtTRZMOPKfW8zBy3dcfwjzbZ7qUvC1sgJk2QyEBgfbsLTz6Uw=
 =
X-Received: by 2002:a53:510c:0:b0:668:1c09:aef1 with SMTP id
 956f58d0204a3-6699a8f6b6bmr7594739d50.6.1786048107607; Thu, 06 Aug 2026
 13:28:27 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 13:28:26 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 13:28:26 -0700
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 6 Aug 2026 13:28:26 -0700
X-Gm-Features: AUfX_mwOaRxg95OuW9Ds8iNQvGKcieqxJPLMdtz6kfQAyNoKr3gXMq_u-wATIaU
Message-ID: <CABtds-3MAA8y5ksGcps6s-iLx8dOF7EoJEJH9079Y_E+-bJB4A@mail.gmail.com>
Subject: [PATCH v12 3/4] firmware: Rename google firmware directory to coreboot
To: chrome-platform@lists.linux.dev
Cc: corentin.chary@gmail.com, luke@ljones.dev, denis.benato@linux.dev, 
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, prasanth.ksr@dell.com, 
 jorge.lopez2@hp.com, mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com, 
 josh@joshuagrisham.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 florian.fainelli@broadcom.com, chenhuacai@kernel.org, mst@redhat.com, 
 wenst@chromium.org, tzungbi@kernel.org, briannorris@chromium.org, 
 jwerner@chromium.org, tzimmermann@suse.de, javierm@redhat.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, krzysztof.kozlowski@oss.qualcomm.com, andersson@kernel.org, 
 geert@linux-m68k.org, dmitry.baryshkov@oss.qualcomm.com, arnd@arndb.de, 
 ebiggers@kernel.org, luca.weiss@fairphone.com, michal.simek@amd.com, 
 sven@kernel.org, u.kleine-koenig@baylibre.com, bhelgaas@google.com, 
 dakr@kernel.org, o-takashi@sakamocchi.jp, titouan.ameline@gmail.com, 
 kees@kernel.org, dri-devel@lists.freedesktop.org, oliver@liuxiaozhen.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

Most drivers in drivers/firmware/google are coreboot table drivers rather
than Google-specific firmware drivers. Rename the directory to coreboot
and update the Kconfig prompt, build path and maintainer entry.

Keep the existing CONFIG_GOOGLE_* symbols to avoid user configuration
churn in this mechanical move.

Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 MAINTAINERS                                                 | 4 ++--
 drivers/firmware/Kconfig                                    | 2 +-
 drivers/firmware/Makefile                                   | 2 +-
 drivers/firmware/{google => coreboot}/Kconfig               | 6 +++---
 drivers/firmware/{google => coreboot}/Makefile              | 0
 drivers/firmware/{google => coreboot}/cbmem.c               | 0
 drivers/firmware/{google => coreboot}/coreboot_table.c      | 0
 drivers/firmware/{google => coreboot}/coreboot_table.h      | 0
 .../firmware/{google => coreboot}/framebuffer-coreboot.c    | 0
 drivers/firmware/{google => coreboot}/gsmi.c                | 0
 drivers/firmware/{google => coreboot}/memconsole-coreboot.c | 0
 .../firmware/{google => coreboot}/memconsole-x86-legacy.c   | 0
 drivers/firmware/{google => coreboot}/memconsole.c          | 0
 drivers/firmware/{google => coreboot}/memconsole.h          | 6 +++---
 drivers/firmware/{google => coreboot}/vpd.c                 | 0
 drivers/firmware/{google => coreboot}/vpd_decode.c          | 0
 drivers/firmware/{google => coreboot}/vpd_decode.h          | 0
 17 files changed, 10 insertions(+), 10 deletions(-)
 rename drivers/firmware/{google => coreboot}/Kconfig (94%)
 rename drivers/firmware/{google => coreboot}/Makefile (100%)
 rename drivers/firmware/{google => coreboot}/cbmem.c (100%)
 rename drivers/firmware/{google => coreboot}/coreboot_table.c (100%)
 rename drivers/firmware/{google => coreboot}/coreboot_table.h (100%)
 rename drivers/firmware/{google => coreboot}/framebuffer-coreboot.c (100%)
 rename drivers/firmware/{google => coreboot}/gsmi.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole-coreboot.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole-x86-legacy.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole.c (100%)
 rename drivers/firmware/{google => coreboot}/memconsole.h (82%)
 rename drivers/firmware/{google => coreboot}/vpd.c (100%)
 rename drivers/firmware/{google => coreboot}/vpd_decode.c (100%)
 rename drivers/firmware/{google => coreboot}/vpd_decode.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6a8c271e79d..62ddee473f55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11069,14 +11069,14 @@ S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
 F:	drivers/net/ethernet/google

-GOOGLE FIRMWARE DRIVERS
+COREBOOT FIRMWARE DRIVERS
 M:	Tzung-Bi Shih <tzungbi@kernel.org>
 R:	Brian Norris <briannorris@chromium.org>
 R:	Julius Werner <jwerner@chromium.org>
 L:	chrome-platform@lists.linux.dev
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
-F:	drivers/firmware/google/
+F:	drivers/firmware/coreboot/
 F:	include/linux/coreboot.h

 GOOGLE TENSOR SoC SUPPORT
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 78a239f8bbef..4df0a0ad18b8 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -293,7 +293,7 @@ endif # TURRIS_MOX_RWTM
 source "drivers/firmware/arm_ffa/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/cirrus/Kconfig"
-source "drivers/firmware/google/Kconfig"
+source "drivers/firmware/coreboot/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/imx/Kconfig"
 source "drivers/firmware/meson/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 385b6e8b7fc6..7a8fc3eeb3f0 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -30,7 +30,7 @@ obj-y				+= broadcom/
 obj-y				+= cirrus/
 obj-y				+= meson/
 obj-y				+= microchip/
-obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
+obj-$(CONFIG_GOOGLE_FIRMWARE)	+= coreboot/
 obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/coreboot/Kconfig
similarity index 94%
rename from drivers/firmware/google/Kconfig
rename to drivers/firmware/coreboot/Kconfig
index b78c644fa253..b248bafe8b6b 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/coreboot/Kconfig
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig GOOGLE_FIRMWARE
-	bool "Google Firmware Drivers"
+	bool "coreboot firmware drivers"
 	default n
 	help
-	  These firmware drivers are used by Google servers,
-	  Chromebooks and other devices using coreboot firmware.
+	  These firmware drivers are used by devices running coreboot
+	  firmware, including Chromebooks and some Google servers.
 	  If in doubt, say "N".

 if GOOGLE_FIRMWARE
diff --git a/drivers/firmware/google/Makefile
b/drivers/firmware/coreboot/Makefile
similarity index 100%
rename from drivers/firmware/google/Makefile
rename to drivers/firmware/coreboot/Makefile
diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/coreboot/cbmem.c
similarity index 100%
rename from drivers/firmware/google/cbmem.c
rename to drivers/firmware/coreboot/cbmem.c
diff --git a/drivers/firmware/google/coreboot_table.c
b/drivers/firmware/coreboot/coreboot_table.c
similarity index 100%
rename from drivers/firmware/google/coreboot_table.c
rename to drivers/firmware/coreboot/coreboot_table.c
diff --git a/drivers/firmware/google/coreboot_table.h
b/drivers/firmware/coreboot/coreboot_table.h
similarity index 100%
rename from drivers/firmware/google/coreboot_table.h
rename to drivers/firmware/coreboot/coreboot_table.h
diff --git a/drivers/firmware/google/framebuffer-coreboot.c
b/drivers/firmware/coreboot/framebuffer-coreboot.c
similarity index 100%
rename from drivers/firmware/google/framebuffer-coreboot.c
rename to drivers/firmware/coreboot/framebuffer-coreboot.c
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/coreboot/gsmi.c
similarity index 100%
rename from drivers/firmware/google/gsmi.c
rename to drivers/firmware/coreboot/gsmi.c
diff --git a/drivers/firmware/google/memconsole-coreboot.c
b/drivers/firmware/coreboot/memconsole-coreboot.c
similarity index 100%
rename from drivers/firmware/google/memconsole-coreboot.c
rename to drivers/firmware/coreboot/memconsole-coreboot.c
diff --git a/drivers/firmware/google/memconsole-x86-legacy.c
b/drivers/firmware/coreboot/memconsole-x86-legacy.c
similarity index 100%
rename from drivers/firmware/google/memconsole-x86-legacy.c
rename to drivers/firmware/coreboot/memconsole-x86-legacy.c
diff --git a/drivers/firmware/google/memconsole.c
b/drivers/firmware/coreboot/memconsole.c
similarity index 100%
rename from drivers/firmware/google/memconsole.c
rename to drivers/firmware/coreboot/memconsole.c
diff --git a/drivers/firmware/google/memconsole.h
b/drivers/firmware/coreboot/memconsole.h
similarity index 82%
rename from drivers/firmware/google/memconsole.h
rename to drivers/firmware/coreboot/memconsole.h
index aaff2b72b606..58899c2abaaa 100644
--- a/drivers/firmware/google/memconsole.h
+++ b/drivers/firmware/coreboot/memconsole.h
@@ -7,8 +7,8 @@
  * Copyright 2017 Google Inc.
  */

-#ifndef __FIRMWARE_GOOGLE_MEMCONSOLE_H
-#define __FIRMWARE_GOOGLE_MEMCONSOLE_H
+#ifndef __FIRMWARE_COREBOOT_MEMCONSOLE_H
+#define __FIRMWARE_COREBOOT_MEMCONSOLE_H

 #include <linux/types.h>

@@ -33,4 +33,4 @@ int memconsole_sysfs_init(void);
  */
 void memconsole_exit(void);

-#endif /* __FIRMWARE_GOOGLE_MEMCONSOLE_H */
+#endif /* __FIRMWARE_COREBOOT_MEMCONSOLE_H */
diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/coreboot/vpd.c
similarity index 100%
rename from drivers/firmware/google/vpd.c
rename to drivers/firmware/coreboot/vpd.c
diff --git a/drivers/firmware/google/vpd_decode.c
b/drivers/firmware/coreboot/vpd_decode.c
similarity index 100%
rename from drivers/firmware/google/vpd_decode.c
rename to drivers/firmware/coreboot/vpd_decode.c
diff --git a/drivers/firmware/google/vpd_decode.h
b/drivers/firmware/coreboot/vpd_decode.h
similarity index 100%
rename from drivers/firmware/google/vpd_decode.h
rename to drivers/firmware/coreboot/vpd_decode.h
