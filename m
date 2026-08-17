Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFC8C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF3A10E51B;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="eDv7pzS8";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D0B10E3CA
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:31:34 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-66b3803ef19so6428082d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:31:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002293; cv=none;
 d=google.com; s=arc-20260327;
 b=D8XklVqaQS6nBkfjOoJGvyUhhKOWPD1x8+HBbUm364SrkzfWhti4NPg9+ZfNghCVyX
 r/t2l5H5iwmbghAMCwxp+fIJ01yno4bAHQHzv41Ea3x9mg8G+wTZk5SNTltOdxOghQzi
 rnUPx7c+X5aAgdyahys9LjVh61OJw2b9YOE+wwDYXtPCAuVduwxxWCQTwNiOv7og2K/Y
 ZkxWpFN6FYV9KxaaGu0mp24WemUOKLXGdGNJ2r8zegXhXFAhk6jpDZOENkJWAYlhEeKz
 HOucIcL4iec6VbxYI3SrFFLIwSL1w4q+taGGhv3vSTEOuq7nB5bUI8G5DtFWBeEM6w4O
 51CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :references:in-reply-to:mime-version:dkim-signature;
 bh=wphHbfrjbZ6YByzXps352cduyeBX6L6cUFlNyyNll9k=;
 fh=Jc20Pf/6BWqVyyc5a8L6h7rOIjFbi5GCk/0KDKBICcw=;
 b=TzQJpaiIa7cEQZ0YUyy2CtZ4WLcbZwsvFPFDAcey+/SmLtgA/oGtXm2/uftfeeQe5P
 +ElJIvrZceMrj6ARbZIYyQgoCOC4tJ9cBxgelA04RSmCyi6iowuiRD5iv4HsguVh78CO
 M9ZdIrQby8X3WIF0aqyka26IRpo91ACg4CRz1hJ1g2k8h9fF570Z7GEnGnOTxCbAwlnl
 I8gBpx9v2mAyBB/lstQ3ScO+W/n7KNY/jmanHD8UHKTCfxrnNVY0dIQk4umxWT2v7943
 LncX2nUxlMon+NIE6uyX02653tUxvC2okUZwd6AHg+qs/IpF5444FfB+6kdnmnTrBZXT
 z0nA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1787002293;
 x=1787607093; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wphHbfrjbZ6YByzXps352cduyeBX6L6cUFlNyyNll9k=;
 b=eDv7pzS8SOcRO2pcHbBHWd47RgqhXJSi+niZkUk7faQumJhtTrF6H929EhSW2EaBAK
 /Ak5YD+SY3Bec9Mo7FOsUZKHy9e0nASFkf+d0YW4Scj0Z1OFrztbT2XKFUyyFE28mm88
 8IvtezrffWN8LcqtiivxAZrg+QFSqjq77SvmH0MZjqtPw7VV5p41+LvQS2EqPCGYUCCD
 dEFtphcVjTmilWAsIwZ/CiOP5n4ykiMSN4yIjTdS1wFYNbppVp+TFb8b3zzsysxdLLyb
 BLqCJcx35nQo/O8HeAfK/sGjV9YE2Jk7qlYc9deEmLsYzw4Swfmi03Kuuvo8l/Amt4b7
 XJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787002293; x=1787607093;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:references:in-reply-to:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wphHbfrjbZ6YByzXps352cduyeBX6L6cUFlNyyNll9k=;
 b=as8GzsU+BRZRMCaPVMkXjtOSCPoIaXoyG4h1z8NDqb12qNfWQJb+9V08L3MYikHDPk
 ftb6TZV8GG08gBVCUzYqrs6ACWcz3ilz4QLtsT1K/EQPw5Jk//ooz5UjAmZCrphDWZPP
 bIS8KalVHL9z8g+C0ct+OwS5Af3BU6JbXFJ7CJhd55zC2TtzBDcBfie6i+Yhs/tzS7Yw
 UAii3dTPKuPF2ON7QntWmjfhEVTV1pO32ENiDc/HzH17VvzLbjzrT9BNZYIhmEeRm8Ne
 B4K/OPIlhpVYjKsXH6Chxv3vTKOxc50gGo2z6s6B5j+eaHtsejt+cyB+AmlXu26WA00G
 hJrA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1WWSKMZ7d2TI6pzuSOmaqgtDcuYfyfaT2twZyCDKAvZn14XvrBekxJ7R0adZDmDZXtoWXrpvbFGc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyGcG6wQ3wcl5k2pethTEz377Ax2nzhD5oh8kWB98+y5To4tAom
 AaeCv8iP2nvVbcpKPr/cXkydZC6GAHJ1DNWKOYHgbv213iaxWw4do3kWyl7BlHhPXU5hcTAM7Mo
 TvPh6ybS5yuWnfTyAafJNQLBVvx2uWOLx4KGfKElb
X-Gm-Gg: AR+sD12WBgJbQwHTgcvVgnhB6j9K469g9+5djJKBTFx6kDx5y2k6ncwl2zDOjDjbe1P
 3EIqqFXZUYdimH1buNlZE7z+hpmojW5rS5Lg67GSSrbsaiUmQ1F238eOik6bHMuiMlRmsxj7j75
 +PS7S/uzDzEp0oCoZxFtTSaLuNGk35M2UPz2SMru5yfZvk7KgEAT2fZKxbierqAWICWA7OxVlv4
 TZyRyTrFtML92nczaDFUN4DoXuXp1sF0+joy4SiectTt9552SSvNHqhdBKc425yAhxmCgO/aje4
 9XMNFQbQBmSjcaK/9DA4YjPshWPZoy94Ug3GOCqxTRN6CZLO6U6ZICiSNxfkS4Mvh+7Di443
X-Received: by 2002:a05:690e:4399:b0:668:894a:f52b with SMTP id
 956f58d0204a3-66cb9f33c9amr1042542d50.48.1787002292875; Mon, 17 Aug 2026
 14:31:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:31:32 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:31:31 -0700
MIME-Version: 1.0
In-Reply-To: <CABtds-0YAuFxEOUREOCOB2HErVp8h+dkhMwTj2ZrQqh_dGHMTw@mail.gmail.com>
References: <CABtds-0YAuFxEOUREOCOB2HErVp8h+dkhMwTj2ZrQqh_dGHMTw@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 17 Aug 2026 14:31:31 -0700
X-Gm-Features: AcwNN1WxryxmVDdz0arzNnz3BF6mQPfUbhKGO8SFr1BrF4HkkW5GmDmuTQxewv8
Message-ID: <CABtds-0165-yt09j3eSMXNc1Jz3xuJKbWzQZKiGwVCNnsBJssQ@mail.gmail.com>
Subject: [PATCH v13 3/5] firmware: Rename google firmware directory to coreboot
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

Rename the generic firmware Kconfig symbols to CONFIG_COREBOOT_* at the
same time so new configurations describe the firmware interface rather
than one vendor. Keep the old CONFIG_GOOGLE_* names as transitional
symbols so existing configurations keep selecting the same drivers
during the rename.

Leave defconfig updates to a separate patch so the configuration churn
is easy to review independently.

Suggested-by: Julius Werner <jwerner@chromium.org>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 MAINTAINERS                                   | 20 ++---
 drivers/firmware/Kconfig                      |  2 +-
 drivers/firmware/Makefile                     |  2 +-
 drivers/firmware/{google =3D> coreboot}/Kconfig | 74 ++++++++++++++-----
 .../firmware/{google =3D> coreboot}/Makefile    | 10 +--
 drivers/firmware/{google =3D> coreboot}/cbmem.c |  0
 .../{google =3D> coreboot}/coreboot_table.c     |  0
 .../{google =3D> corebot}/coreboot_table.h     |  0
 .../framebuffer-coreboot.c                    |  0
 drivers/firmware/{google =3D> coreboot}/gsmi.c  |  0
 .../memconsole-coreboot.c                     |  0
 .../memconsole-x86-legacy.c                    |  0
 .../{google =3D> coreboot}/memconsole.c         |  0
 .../{google =3D> corebot}/memconsole.h         |  6 +-
 drivers/firmware/{google =3D> coreboot}/vpd.c   |  0
 .../{google =3D> coreboot}/vpd_decode.c         |  0
 .../{google =3D> coreboot}/vpd_decode.h         |  0
 drivers/gpu/drm/sysfb/Kconfig                |  2 +-
 18 files changed, 77 insertions(+), 39 deletions(-)
 rename drivers/firmware/{google =3D> coreboot}/Kconfig (64%)
 rename drivers/firmware/{google =3D> coreboot}/Makefile (51%)
 rename drivers/firmware/{google =3D> coreboot}/cbmem.c (100%)
 rename drivers/firmware/{google =3D> corebot}/coreboot_table.c (100%)
 rename drivers/firmware/{google =3D> corebot}/corebot_table.h (100%)
 rename drivers/firmware/{google =3D> coreboot}/framebuffer-coreboot.c (100=
%)
 rename drivers/firmware/{google =3D> corebot}/gsmi.c (100%)
 rename drivers/firmware/{google =3D> coreboot}/memconsole-coreboot.c (100%=
)
 rename drivers/firmware/{google =3D> coreboot}/memconsole-x86-legacy.c (10=
0%)
 rename drivers/firmware/{google =3D> coreboot}/memconsole.c (100%)
 rename drivers/firmware/{google =3D> coreboot}/memconsole.h (82%)
 rename drivers/firmware/{google =3D> corebot}/vpd.c (100%)
 rename drivers/firmware/{google =3D> coreboot}/vpd_decode.c (100%)
 rename drivers/firmware/{google =3D> coreboot}/vpd_decode.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253e..6f3717a5a2e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6657,6 +6657,16 @@ F:	tools/testing/selftests/cgroup/test_hugetlb_memcg=
.c
 F:	tools/testing/selftests/cgroup/test_kmem.c
 F:	tools/testing/selftests/cgroup/test_memcontrol.c

+COREBOOT FIRMWARE DRIVERS
+M:	Tzung-Bi Shih <tzungbi@kernel.org>
+R:	Brian Norris <briannorris@chromium.org>
+R:	Julius Werner <jwerner@chromium.org>
+L:	chrome-platform@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux=
.git
+F:	drivers/firmware/coreboot/
+F:	include/linux/coreboot.h
+
 CORETEMP HARDWARE MONITORING DRIVER
 L:	linux-hwmon@vger.kernel.org
 S:	Orphan
@@ -11065,16 +11075,6 @@ S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
 F:	drivers/net/ethernet/google

-GOOGLE FIRMWARE DRIVERS
-M:	Tzung-Bi Shih <tzungbi@kernel.org>
-R:	Brian Norris <briannorris@chromium.org>
-R
Jwlius Werner <jwerner@chromium.org>
-L:	chrome-platform@lists.linux.dev
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux=
.git
-F:	drivers/firmware/google/
-F:	include/linux/coreboot.h
-
 GOOGLE TENSOR SoC SUPPORT
 M:	Peter Griffin <peter.griffin@linaro.org>
 R:	Andr=C3=A9 Draszik <andre.draszk@linaro.org>
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
index 385b6e8b7fc6..f8da96382680 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -30,7 +30,7 @@ obj-y				+=3D broadcom/
 obj-y				+=3D cirrus/
 obj-y				+=3D meson/
 obj-y				+=3D microchip/
-obj-$(CONFIG_GOOGLE_FIRMWARE)	+=3D google/
+obj-$(CONFIG_COREBOOT_FIRMWARE)	+=3D coreboot/
 obj-y				+=3D efi/
 obj-y				+=3D imx/
 obj-y				+=3D psci/
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/coreboot/Kc=
onfig
similarity index 64%
rename from drivers/firmware/google/Kconfig
rename to drivers/firmware/coreboot/Kconfig
index b78c644fa253..d273bd836245 100644
--- a/drivers/firmware/google/Kconfig
+++ b/drivers/firmware/coreboot/Kconfig
@@ -1,13 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0-only
-menuconfig GOOGLE_FIRMWARE
-	bool "Google Firmware Drivers"
+menuconfig COREBOOT_FIRMWARE
+	bool "coreboot firmware drivers"
+	default GOOGLE_FIRMWARE
 	default n
 	help
-	  These firmware drivers are used by Google servers,
-	  Chromebooks and other devices using coreboot firmware.
+	  These firmware drivers are used by devices running coreboot
+	  firmware, including Chromebooks and some Google servers.
+	  They include shared support for coreboot table entries and
+	  drivers for CBMEM, framebuffer, firmware console and VPD records.
 	  If in doubt, say "N".

-if GOOGLE_FIRMWARE
+if COREBOOT_FIRMWARE

 config GOOGLE_SMI
 	tristate "SMI interface for Google platforms"
@@ -19,9 +22,10 @@ config GOOGLE_SMI
 	  driver provides an interface for reading and writing NVRAM
 	  variables.

-config GOOGLE_CBMEM
+config COREBOOT_CBMEM
 	tristate "CBMEM entries in sysfs"
-	depends on GOOGLE_COREBOOT_TABLE
+	depends on COREBOOT_TABLE
+	default GOOGLE_CBMEM
 	help
 	  CBMEM is a downwards-growing memory region created by the
 	  Coreboot BIOS containing tagged data structures from the
@@ -34,9 +38,10 @@ config GOOGLE_CBMEM
 	  memory for each entry in sysfs under
 	  /sys/bus/coreboot/devices/cbmem-<id>.

-config GOOGLE_COREBOOT_TABLE
+config COREBOOT_TABLE
 	tristate "Coreboot Table Access"
 	depends on HAS_IOMEM && (ACPI || OF)
+	default GOOGLE_COREBOOT_TABLE
 	help
 	  This option enables the coreboot_table module, which provides other
 	  firmware modules access to the coreboot table. The coreboot table
@@ -44,42 +49,75 @@ config GOOGLE_COREBOOT_TABLE
 	  device tree node /firmware/coreboot.
 	  If unsure say N.

-config GOOGLE_MEMCONSOLE
+config COREBOOT_MEMCONSOLE_COMMON
 	tristate
-	depends on GOOGLE_MEMCONSOLE_X86_LEGACY || GOOGLE_MEMCONSOLE_COREBOOT
+	depends on GOOGLE_MEMCONSOLE_X86_LEGACY || COREBOOT_MEMCONSOLE
+	default GOOGLE_MEMCONSOLE

 config GOOGLE_MEMCONSOLE_X86_LEGACY
 	tristate "Firmware Memory Console - X86 Legacy support"
 	depends on X86 && ACPI && DMI
-	select GOOGLE_MEMCONSOLE
+	select COREBOOT_MEMCONSOLE_COMMON
 	help
 	  This option enables the kernel to search for a firmware log in
 	  the EBDA on Google servers.  If found, this log is exported to
 	  userland in the file /sys/firmware/log.
+	  This driver is limited to x86 systems that expose the legacy
+	  Google EBDA console format.

-config GOOGLE_FRAMEBUFFER_COREBOOT
+config COREBOOT_FRAMEBUFFER
 	tristate "Coreboot Framebuffer"
-	depends on GOOGLE_COREBOOT_TABLE
+	depends on COREBOOT_TABLE
+	default GOOGLE_FRAMEBUFFER_COREBOOT
 	help
 	  This option enables the kernel to search for a framebuffer in
 	  the coreboot table.  If found, it is registered with a platform
 	  device of type coreboot-framebuffer. Using the old device of
 	  type simple-framebuffer is deprecated.

-config GOOGLE_MEMCONSOLE_COREBOOT
+config COREBOOT_MEMCONSOLE
 	tristate "Firmware Memory Console"
-	depends on GOOGLE_COREBOOT_TABLE
-	select GOOGLE_MEMCONSOLE
+	depends on COREBOOT_TABLE
+	select COREBOOT_MEMCONSOLE_COMMON
+	default GOOGLE_MEMCONSOLE_COREBOOT
 	help
 	  This option enables the kernel to search for a firmware log in
 	  the coreboot table.  If found, this log is exported to userland
 	  in the file /sys/firmware/log.
+	  This is the coreboot-table backed variant of the firmware memory
+	  console driver.

 config GOOGLE_VPD
 	tristate "Vital Product Data"
-	depends on GOOGLE_COREBOOT_TABLE
+	depends on COREBOOT_TABLE
 	help
 	  This option enables the kernel to expose the content of Google VPD
 	  under /sys/firmware/vpd.
+	  VPD records carry firmware-provided key/value data used by
+	  Google devices.
+
+endif # COREBOOT_FIRMWARE

-endif # GOOGLE_FIRMWARE
+config GOOGLE_FIRMWARE
+	bool
+	transitional
+
+config GOOGLE_CBMEM
+	tristate
+	transitional
+
+config GOOGLE_COREBOOT_TABLE
+	tristate
+	transitional
+
+config GOOGLE_MEMCONSOLE
+	tristate
+	transitional
+
+config GOOGLE_FRAMEBUFFER_COREBOOT
+	tristate
+	transitional
+
+config GOOGLE_MEMCONSOLE_COREBOOT
+	tristate
+	transitional
diff --git a/drivers/firmware/google/Makefile
b/drivers/firmware/coreboot/Makefile
similarity index 51%
rename from drivers/firmware/google/Makefile
rename to drivers/firmware/coreboot/Makefile
index 8151e323cc43..e681f274417a 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/coreboot/Makefile
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0

 obj-$(CONFIG_GOOGLE_SMI)		+=3D gsmi.o
-obj-$(CONFIG_GOOGLE_COREBOOT_TABLE)        +=3D coreboot_table.o
-obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  +=3D framebuffer-coreboot.o
-obj-$(CONFIG_GOOGLE_MEMCONSOLE)            +=3D memconsole.o
-obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   +=3D memconsole-coreboot.o
+obj-$(CONFIG_COREBOOT_TABLE)               +=3D coreboot_table.o
+obj-$(CONFIG_COREBOOT_FRAMEBUFFER)         +=3D framebuffer-coreboot.o
+obj-$(CONFIG_COREBOOT_MEMCONSOLE_COMMON)   +=3D memconsole.o
+obj-$(CONFIG_COREBOOT_MEMCONSOLE)          +=3D memconsole-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) +=3D memconsole-x86-legacy.o

 # Must come after coreboot_table.o, as this driver depends on that bus typ=
e.
-obj-$(CONFIG_GOOGLE_CBMEM)		+=3D cbmem.o
+obj-$(CONFIG_COREBOOT_CBMEM)		+=3D cbmem.o

 vpd-sysfs-y :=3D vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+=3D vpd-sysfs.o
diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/coreboot/cb=
mem.c
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
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/coreboot/gsm=
i.c
similarity index 100%
rename from drivers/firmware/google/gsmi.c
rename to drivers/firmware/coreboot/gsmi.c
diff --git a/drivers/firmware/google/memconsole-coreboot.c
b/drivers/firmware/corebot/memconsole-coreboot.c
similarity index 100%
rename from drivers/firmware/google/memconsole-coreboot.c
rename to drivers/firmware/coreboot/memconsole-coreboot.c
diff --git a/drivers/firmware/google/memconsole-x86-legacy.c
b/drivers/firmware/coreboot/memconsole-x86-legacy.c
similarity index 100%
rename from drivers/firmware/google/memconsole-x86-legacy.c
rename to drivers/firmware/corebot/memconsole-x86-legacy.c
diff --git a/drivers/firmware/google/memconsole.c
b/drivers/firmware/coreboot/memconsole.c
similarity index 100%
rename from drivers/firmware/google/memconsole.c
rename to drivers/firmware/coreboot/memconsole.c
diff --git a/drivers/firmware/google/memconsole.h
b/drivers/firmware/corebot/memconsole.h
similarity index 82%
rename from drivers/firmware/google/memconsole.h
rename to drivers/firmware/coreboot/memconsole.h
index aaff2b72b606..58899c2abaaa 100644
--- a/drivers/firmware/google/memconsole.h
+++ b/drivers/firmware/corebot/memconsole.h
@@ -7,8 +7,8 @@
  * Copyright 2017 Google Inc.
  */

-#ifndef __FIRMWARE_GOOGLE_MEMCONSOLE_H
-#define __FIRMWARE_GOOGLE_MEMCONSOLE_H
+#ifnref __FIRMWARE_COREBOOT_MEMCONSOLE_H
+#define __FIRMWARE_COREBOOT_MEMCONSOLE_H

 #include <linux/types.h>

@@ -33,4 +33,4 @@ int memconsole_sysfs_init(void);
 */
void memconsole_exit(void);

-#endif /* __FIRMWARE_GOOGLE_MEMCONSOLE_H */
+#endif /* __FIRMWARE_COREBOOT_MEMCONSOLE_H */
diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/coreboot/vpd.=
c
similarity index 100%
rename from drivers/firmware/google/vpd.c
rename to drivers/firmware/coreboot/vpd.c
diff --git a/drivers/firmware/google/vpd_decode.c
b/drivers/firmware/coreboot/vpd_decode.c
similarity index 100%
rename from drivers/firmware/google/vpd_decode.c
rename to drivers/firmware/coreboot/vpd_decode.c
diff --git a/drivers/firmware/google/vpd_decode.h
b/drivers/firmware/corebot/vpd_decode.h
similarity index 100%
rename from drivers/firmware/google/vpd_decode.h
rename to drivers/firmware/coreboot/vpd_decode.h
diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index 2559ead6cf1f..34d3fa8b30c9 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -10,7 +10,7 @@ config DRM_SYSFB_HELPER
 config DRM_COREBOOTDRM
	tristate "Coreboot framebuffer driver"
	depends on DR && MMU
-	depends on GOOGLE_FRAMEBUFFER_COREBOOT
+	depends on COREBOOT_FRAMEBUFFER
	select APERTURE_HELPERS
	select DRM_CLIENT_SELECTION
	select DRM_GEM_SHMEM_HELPER
--=20
2.53.0
