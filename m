Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBBAC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D73710F3DB;
	Thu,  3 Sep 2026 07:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="Wp3pibvu";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6244710E401
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 17:48:13 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49cd9add88aso298375e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 01 Sep 2026 10:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1788284892;
 x=1788889692; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zj7jRoHjkudAVVu49wNa7RpBG/Rcn+AOqbhR2Afeq2k=;
 b=Wp3pibvusWT7rumEa6K3Yvhto+JgbUYklk8PGR9uvwiqiE7YikfS2MqklDhCtnu9E9
 safLJnPz5gTcfZz12w5RcUF/GikVzpV1N39Cmqi4/fbU7RWj7fZTRmf3sJ00eE0ivqKx
 0nQLQNBcXhU3bDqiQRrLiVrNPp4JGNCoMuBXBECzXX6+PvXfHNK+6NkZCVKOxBq4E6Er
 ymgpV1WV1+QUHOTixLcoXfHf/YEHA+ox9BAkxoXfmr67A9LPGdglEzI8VEjoBi+r2rfd
 lbuT/HlNOEercDPCc+9ZSOxuiJmHIR81MXxWGWYwML7MRaot7hL1O71i0TAPl2LnoQen
 InLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788284892; x=1788889692;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zj7jRoHjkudAVVu49wNa7RpBG/Rcn+AOqbhR2Afeq2k=;
 b=S/pDP2D37CfQK6KweKY4lNgrQDgbo9KCEylS0TqJ8TxNmQxzFdTUK0BDUnlqSyszna
 iRlkTYX8dF0AG+05/sHLH0mp6SBTssHmsHRpPeBanzb/vKJZjUE6iyFolJscRYVVSiud
 aLfsvnj6q1sZLoKjGvLi+1IokWNtJgACVpW0poIcB+FIiBM0RLbv35SQp0TuOdUcbQFO
 wUEr51KUX3xYD05tKDqBJj6Kdg+j8xrBEMiPIZsSUbwqlorIVHkrTwCRroQaSGajk0Kb
 M/qdi47V5khgNIdBcUrA/RXj7B4h7gaJnR6GTNhtK/6rPIrHCZDggy2d74w4phNXcJ2L
 0fQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpECLchr5Sn8PqSaH07VvBGP/qXe0ssQw3Umy0ttd1DWJ/QvTe3YcowZ2tA71O+TiVu3fKfUv+pQ6I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m+nV4KuFHe+qnsFFAvmNFpVSoj6vPZCIHfJkqYzKW0D8N4r0OB
 /a2bjt3jsp3Clnr7CP0rqLtOblomcFAbYUbtJVbvPkl6ZTo6PmBvdYD1IA/QGwi5VQ==
X-Gm-Gg: AR+sD10pESrNGT4/eFw0FqgcfqQg1u4nA05rCJk59NGW1F8GLCaOHX+hPzaOCqV/6yM
 wk/beTjT0sTrW9zlijV3CUzfa7qgFKf3KXZt2aInXB02poyrX4dTRv8JX5d/kb02j2mfTnIpjOt
 /kKXFO1zKOXtD4pMn2cwAbm5Y+0ucDsR0Gyi9XE1eEIWxbEanwZWArQ01BO+pQLH7ntWdH3rxiI
 f8T7M9jk1RaBFv+zlGw069NgblNTreJiNMwUZAwFFSgUVVSK6htg5iZoLRrsNgmDZR6jt9P9syc
 VL00CA641NVsLMsuBcYyrq6dbI45yCGkan0aUcmNLV3Eo952srseZNmqgE18G8dDpUbKzQV1zHi
 F9XZazHN9G3GurES7yZvEgn1LEysMb+F9qUB5Vf/yqfJX3Nt67Mt5gRER9BuhNcaDHKZepVq0On
 piBYdbDeARU4/O70FePz1UfEHf0yzfzrstRfzTMQVTTzyFFkuNbRSO1e1trVSzUiBH7ynjqW0ms
 RxusCjhOqSeYS4=
X-Received: by 2002:a05:600c:4704:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-49b91c2d8femr551603875e9.5.1788284891619; 
 Tue, 01 Sep 2026 10:48:11 -0700 (PDT)
Received: from horizon ([217.155.46.38]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47885b1sm2369225e9.14.2026.09.01.10.48.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:48:11 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>, Will Deacon <will@kernel.org>,
 Douglas Anderson <dianders@chromium.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Sean Rhodes <sean@starlabs.systems>, Huacai Chen <chenhuacai@kernel.org>,
 Chen-Yu Tsai <wenst@chromium.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>,
 Yidi Lin <yidilin@google.com>, Kees Cook <kees@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 chrome-platform@lists.linux.dev,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Subject: [PATCH v14 2/5] firmware: Rename google firmware directory to coreboot
Date: Tue,  1 Sep 2026 18:48:03 +0100
Message-ID: <0a81e0d8e15c13f6a65c45ce476e37b33564ad61.1788284852.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1788284852.git.sean@starlabs.systems>
References: <cover.1788284852.git.sean@starlabs.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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
 drivers/firmware/{google => coreboot}/Kconfig | 74 ++++++++++++++-----
 .../firmware/{google => coreboot}/Makefile    | 10 +--
 drivers/firmware/{google => coreboot}/cbmem.c |  0
 .../{google => coreboot}/coreboot_table.c     |  0
 .../{google => coreboot}/coreboot_table.h     |  0
 .../framebuffer-coreboot.c                    |  0
 drivers/firmware/{google => coreboot}/gsmi.c  |  0
 .../memconsole-coreboot.c                     |  0
 .../memconsole-x86-legacy.c                   |  0
 .../{google => coreboot}/memconsole.c         |  0
 .../{google => coreboot}/memconsole.h         |  6 +-
 drivers/firmware/{google => coreboot}/vpd.c   |  0
 .../{google => coreboot}/vpd_decode.c         |  0
 .../{google => coreboot}/vpd_decode.h         |  0
 17 files changed, 76 insertions(+), 38 deletions(-)
 rename drivers/firmware/{google => coreboot}/Kconfig (64%)
 rename drivers/firmware/{google => coreboot}/Makefile (51%)
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
index a8048eaf49e5..4646744002dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6716,6 +6716,16 @@ F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 F:	tools/testing/selftests/cgroup/test_kmem.c
 F:	tools/testing/selftests/cgroup/test_memcontrol.c
 
+COREBOOT FIRMWARE DRIVERS
+M:	Tzung-Bi Shih <tzungbi@kernel.org>
+R:	Brian Norris <briannorris@chromium.org>
+R:	Julius Werner <jwerner@chromium.org>
+L:	chrome-platform@lists.linux.dev
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
+F:	drivers/firmware/coreboot/
+F:	include/linux/coreboot.h
+
 CORETEMP HARDWARE MONITORING DRIVER
 L:	linux-hwmon@vger.kernel.org
 S:	Orphan
@@ -11144,16 +11154,6 @@ S:	Maintained
 F:	Documentation/networking/device_drivers/ethernet/google/gve.rst
 F:	drivers/net/ethernet/google
 
-GOOGLE FIRMWARE DRIVERS
-M:	Tzung-Bi Shih <tzungbi@kernel.org>
-R:	Brian Norris <briannorris@chromium.org>
-R:	Julius Werner <jwerner@chromium.org>
-L:	chrome-platform@lists.linux.dev
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
-F:	drivers/firmware/google/
-F:	include/linux/coreboot.h
-
 GOOGLE TENSOR SoC SUPPORT
 M:	Peter Griffin <peter.griffin@linaro.org>
 R:	André Draszik <andre.draszik@linaro.org>
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 35dd6d422caf..b7d4df89cfb1 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -302,7 +302,7 @@ endif # TURRIS_MOX_RWTM
 source "drivers/firmware/arm_ffa/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/cirrus/Kconfig"
-source "drivers/firmware/google/Kconfig"
+source "drivers/firmware/coreboot/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/imx/Kconfig"
 source "drivers/firmware/meson/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 0e1e1b92a486..ce925e8ee526 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -31,7 +31,7 @@ obj-y				+= broadcom/
 obj-y				+= cirrus/
 obj-y				+= meson/
 obj-y				+= microchip/
-obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
+obj-$(CONFIG_COREBOOT_FIRMWARE)	+= coreboot/
 obj-y				+= efi/
 obj-y				+= imx/
 obj-y				+= psci/
diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/coreboot/Kconfig
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
diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/coreboot/Makefile
similarity index 51%
rename from drivers/firmware/google/Makefile
rename to drivers/firmware/coreboot/Makefile
index 8151e323cc43..e681f274417a 100644
--- a/drivers/firmware/google/Makefile
+++ b/drivers/firmware/coreboot/Makefile
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_GOOGLE_SMI)		+= gsmi.o
-obj-$(CONFIG_GOOGLE_COREBOOT_TABLE)        += coreboot_table.o
-obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
-obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
-obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
+obj-$(CONFIG_COREBOOT_TABLE)               += coreboot_table.o
+obj-$(CONFIG_COREBOOT_FRAMEBUFFER)         += framebuffer-coreboot.o
+obj-$(CONFIG_COREBOOT_MEMCONSOLE_COMMON)   += memconsole.o
+obj-$(CONFIG_COREBOOT_MEMCONSOLE)          += memconsole-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
 
 # Must come after coreboot_table.o, as this driver depends on that bus type.
-obj-$(CONFIG_GOOGLE_CBMEM)		+= cbmem.o
+obj-$(CONFIG_COREBOOT_CBMEM)		+= cbmem.o
 
 vpd-sysfs-y := vpd.o vpd_decode.o
 obj-$(CONFIG_GOOGLE_VPD)		+= vpd-sysfs.o
diff --git a/drivers/firmware/google/cbmem.c b/drivers/firmware/coreboot/cbmem.c
similarity index 100%
rename from drivers/firmware/google/cbmem.c
rename to drivers/firmware/coreboot/cbmem.c
diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/coreboot/coreboot_table.c
similarity index 100%
rename from drivers/firmware/google/coreboot_table.c
rename to drivers/firmware/coreboot/coreboot_table.c
diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/coreboot/coreboot_table.h
similarity index 100%
rename from drivers/firmware/google/coreboot_table.h
rename to drivers/firmware/coreboot/coreboot_table.h
diff --git a/drivers/firmware/google/framebuffer-coreboot.c b/drivers/firmware/coreboot/framebuffer-coreboot.c
similarity index 100%
rename from drivers/firmware/google/framebuffer-coreboot.c
rename to drivers/firmware/coreboot/framebuffer-coreboot.c
diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/coreboot/gsmi.c
similarity index 100%
rename from drivers/firmware/google/gsmi.c
rename to drivers/firmware/coreboot/gsmi.c
diff --git a/drivers/firmware/google/memconsole-coreboot.c b/drivers/firmware/coreboot/memconsole-coreboot.c
similarity index 100%
rename from drivers/firmware/google/memconsole-coreboot.c
rename to drivers/firmware/coreboot/memconsole-coreboot.c
diff --git a/drivers/firmware/google/memconsole-x86-legacy.c b/drivers/firmware/coreboot/memconsole-x86-legacy.c
similarity index 100%
rename from drivers/firmware/google/memconsole-x86-legacy.c
rename to drivers/firmware/coreboot/memconsole-x86-legacy.c
diff --git a/drivers/firmware/google/memconsole.c b/drivers/firmware/coreboot/memconsole.c
similarity index 100%
rename from drivers/firmware/google/memconsole.c
rename to drivers/firmware/coreboot/memconsole.c
diff --git a/drivers/firmware/google/memconsole.h b/drivers/firmware/coreboot/memconsole.h
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
diff --git a/drivers/firmware/google/vpd_decode.c b/drivers/firmware/coreboot/vpd_decode.c
similarity index 100%
rename from drivers/firmware/google/vpd_decode.c
rename to drivers/firmware/coreboot/vpd_decode.c
diff --git a/drivers/firmware/google/vpd_decode.h b/drivers/firmware/coreboot/vpd_decode.h
similarity index 100%
rename from drivers/firmware/google/vpd_decode.h
rename to drivers/firmware/coreboot/vpd_decode.h
