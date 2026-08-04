Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E0AC56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:24:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3AD10ED39;
	Wed,  5 Aug 2026 07:24:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="RvTurGTu";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D2D10E9AD
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:13:25 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so27763825e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 03:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1785838404;
 x=1786443204; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QC4AFuTm4HDDPDQl/NigTkSn6PdRCMtpbKbWNy2fmpU=;
 b=RvTurGTuIbQukz/kWoJrl7rqfvXdsXdoM1XdVBzDlLGqs8SAl7KBE850rhDLULNeMg
 rZRhyCblAMNUkee4++hEl7HoZxCEachGy/Te+QtjBSBg+iGA0hqo495YG7V8uLgN5Xnl
 CJJVTU0FnEhSJdGeax7OvW3a7nBEFMyxXKhZcNCfVb6kxVklcbji7hsB9bez47Kpk7b8
 GYoceh8BN5vNvl4xUC7qXDeKU+msehOBj+OBoedtGwGKc4lfz/TmPeS5dJ8k4J2ECiud
 kHUZSi6FgDb91zTCNe9tMLByHuS9wcICtUzRvOzpEfJ2qqYqIPTINbix827T5WgBHP6r
 93GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785838404; x=1786443204;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QC4AFuTm4HDDPDQl/NigTkSn6PdRCMtpbKbWNy2fmpU=;
 b=tAjxX/jQ7kLDHJwhVyqLGNU4Y1qE6KhsZhCXVM+6Ne51jjvPRxwZ9sJP9s0znjl8EN
 He1JeM93Vg9vrDSCFP0xoqRzJNJV/uf36BdEOHFvSL3qQd7XqAWn05JMkWRT/VTARftz
 XvFaSihoM8HAMRmYjBW7VJZdNi6/bp4ggYtE6yfMSol+6Ky15qcRSgexud/Qj3FKH2O0
 yE20wCJC1f3wfErV2xqyZYjBzq9cX/X4/854eaQjmLEfNBSXq0Oqn3qlGggz64bXQ/gH
 vxXRKjyAf3HtXaNDMOnARop4RAv/OaMk5SmMab52eCnEVvxJCyyVVV2cbQJgK3EycZVD
 j/iA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp07ePa2FSDOgJgVPzXGGsBdPIrALQnbDdTZbUhUadsjczgWbE3vlVG/2eXWkFOY9iPC0wSPSi2HFc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmQJU1R2/cCi0WyE572lYHbo0Fxi5bvv2kxuHn6It/BtH+/OmZ
 5m47PBUEiywxP6gIiRfablpodKAUATTxNU3aQX5590e/GckVlK9orO8Ue5bnNcfriA==
X-Gm-Gg: AR+sD10ZqH6irJnLO1LxTz4pTeOd7NA9Bu2aK+Jvay8Qc7QbYoHwNCIoEr0yWzzWqt4
 Q6+x4Mo2Zq+FqNJFZGls5iINzbtUrrsDnrhFMREAHUCY3AnDeiVXPka2f86GnO06YbJXLAAzRcJ
 c9rlkurOyVK946RwakTO71JRJ5OW0pPGGdVAGdNmojhnzNt38xYYEBirPpWihZDQmdVa815Ejcw
 ptWLhlZOE/P1jKCa6EFO3bSuPmMFmpgt2dqBBx/Qp7APaIMvizDiyQ3EEVUtqhAbXwp9kY+UEbw
 cAS/GsdLkYsgNEsrQ9HwhY9zRppVZB0ElP2hWyOZRLkpd86hjBNnMewjyplX4wGHuTzwrK9BUCD
 zl3cFJ7Cez/hYQ/6DtNtECFF9pY6vqMxumMIfsMDHoPxNs8+A2wAInbE839rdOH5C1YjvbTzLvy
 gwPJGSoLCS2FvtMPranj3h2W20KfcdNVxM2D3b8OdTG/P33XHNjDePqZDdm9kVDT4MsNr4I4iY1
 +1xDrAJYCcBST+gteMXkLZwBveH672T
X-Received: by 2002:a05:600c:2153:b0:497:fe58:d714 with SMTP id
 5b1f17b1804b1-4980c674df7mr198300025e9.9.1785838403656; 
 Tue, 04 Aug 2026 03:13:23 -0700 (PDT)
Received: from horizon.localdomain ([216.128.28.240])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb0c5sm67300275e9.4.2026.08.04.03.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 03:13:23 -0700 (PDT)
From: Sean Rhodes <sean@starlabs.systems>
To: chrome-platform@lists.linux.dev
Cc: Corentin Chary <corentin.chary@gmail.com>,
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>,
 Hans de Goede <hansg@kernel.org>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Joshua Grisham <josh@joshuagrisham.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com, Sean Rhodes <sean@starlabs.systems>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>, Michal Simek <michal.simek@amd.com>,
 Sven Peter <sven@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org,
 Oliver Lin <oliver@liuxiaozhen.dev>
Subject: [PATCH v11 2/4] firmware: Move firmware attributes class helper
Date: Tue,  4 Aug 2026 11:13:07 +0100
Message-ID: <6d82b7ed6fd917ff4923436fdc6fafcaf8745cc3.1785838269.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785838269.git.sean@starlabs.systems>
References: <cover.1785838269.git.sean@starlabs.systems>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:24:24 +0000
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

Move the firmware attributes class helper from drivers/platform/x86 to
drivers/firmware and expose its class declaration through a public Linux
header.

The helper is not x86-specific. Keeping it in firmware lets coreboot
firmware drivers use the standard firmware-attributes ABI without living
under platform/x86.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Tested-by: Oliver Lin <oliver@liuxiaozhen.dev>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 MAINTAINERS                                               | 8 ++++++++
 drivers/firmware/Kconfig                                  | 3 +++
 drivers/firmware/Makefile                                 | 1 +
 .../x86 => firmware}/firmware_attributes_class.c          | 2 +-
 drivers/platform/x86/Kconfig                              | 3 ---
 drivers/platform/x86/Makefile                             | 2 --
 drivers/platform/x86/asus-armoury.c                       | 2 +-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c        | 2 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c              | 2 +-
 drivers/platform/x86/lenovo/think-lmi.c                   | 2 +-
 drivers/platform/x86/lenovo/wmi-other.c                   | 2 +-
 drivers/platform/x86/samsung-galaxybook.c                 | 2 +-
 .../linux/firmware_attributes.h                           | 6 +++---
 13 files changed, 22 insertions(+), 15 deletions(-)
 rename drivers/{platform/x86 => firmware}/firmware_attributes_class.c (94%)
 rename drivers/platform/x86/firmware_attributes_class.h => include/linux/firmware_attributes.h (60%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f9472c1a090..e6a8c271e79d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10115,6 +10115,14 @@ F:	include/linux/firewire.h
 F:	include/uapi/linux/firewire*.h
 F:	tools/firewire/
 
+FIRMWARE ATTRIBUTES CLASS
+M:	Hans de Goede <hansg@kernel.org>
+M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/firmware/firmware_attributes_class.c
+F:	include/linux/firmware_attributes.h
+
 FIRMWARE FRAMEWORK FOR ARMV8-A
 M:	Sudeep Holla <sudeep.holla@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 12dc70254842..78a239f8bbef 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -8,6 +8,9 @@ menu "Firmware Drivers"
 
 source "drivers/firmware/arm_scmi/Kconfig"
 
+config FW_ATTR_CLASS
+	tristate
+
 config ARM_SCPI_PROTOCOL
 	tristate "ARM System Control and Power Interface (SCPI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 4ddec2820c96..385b6e8b7fc6 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_MTK_ADSP_IPC)	+= mtk-adsp-ipc.o
 obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
+obj-$(CONFIG_FW_ATTR_CLASS)	+= firmware_attributes_class.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
 obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TH1520_AON_PROTOCOL) += thead,th1520-aon.o
diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/firmware/firmware_attributes_class.c
similarity index 94%
rename from drivers/platform/x86/firmware_attributes_class.c
rename to drivers/firmware/firmware_attributes_class.c
index 736e96c186d9..503ecc288086 100644
--- a/drivers/platform/x86/firmware_attributes_class.c
+++ b/drivers/firmware/firmware_attributes_class.c
@@ -3,7 +3,7 @@
 /* Firmware attributes class helper module */
 
 #include <linux/module.h>
-#include "firmware_attributes_class.h"
+#include <linux/firmware_attributes.h>
 
 const struct class firmware_attributes_class = {
 	.name = "firmware-attributes",
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index b54b5212b204..beed14c38b54 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -926,9 +926,6 @@ config DASHARO_ACPI
 
 source "drivers/platform/x86/x86-android-tablets/Kconfig"
 
-config FW_ATTR_CLASS
-	tristate
-
 config INTEL_IMR
 	bool "Intel Isolated Memory Region support"
 	depends on X86_INTEL_QUARK && IOSF_MBI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 872ac3842391..cab20a4145e3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -63,8 +63,6 @@ obj-$(CONFIG_X86_PLATFORM_DRIVERS_HP)	+= hp/
 # Hewlett Packard Enterprise
 obj-$(CONFIG_UV_SYSFS)       += uv_sysfs.o
 
-obj-$(CONFIG_FW_ATTR_CLASS)	+= firmware_attributes_class.o
-
 # IBM Thinkpad (before 2005)
 obj-$(CONFIG_IBM_RTL)		+= ibm_rtl.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
index f3d8c5a85762..e6af93608ec5 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -20,7 +20,7 @@
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include "firmware_attributes_class.h"
+#include <linux/firmware_attributes.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/kmod.h>
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index 4ff9003c6589..963b3473991d 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -9,7 +9,7 @@
 
 #include <linux/align.h>
 #include <linux/dmi.h>
-#include "../../firmware_attributes_class.h"
+#include <linux/firmware_attributes.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 1965a329be48..f13f21580acd 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -8,7 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/errno.h>
-#include "../../firmware_attributes_class.h"
+#include <linux/firmware_attributes.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
index 9e4b3e973de9..4437785aa1f2 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -15,7 +15,7 @@
 #include <linux/array_size.h>
 #include <linux/dmi.h>
 #include <linux/errno.h>
-#include "../firmware_attributes_class.h"
+#include <linux/firmware_attributes.h>
 #include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
index fdebaa0a9992..b175971bb308 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -33,7 +33,7 @@
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/export.h>
-#include "../firmware_attributes_class.h"
+#include <linux/firmware_attributes.h>
 #include <linux/gfp_types.h>
 #include <linux/hwmon.h>
 #include <linux/idr.h>
diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
index 74103c00b0c8..3911f60c23ea 100644
--- a/drivers/platform/x86/samsung-galaxybook.c
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -14,7 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/err.h>
-#include "firmware_attributes_class.h"
+#include <linux/firmware_attributes.h>
 #include <linux/i8042.h>
 #include <linux/init.h>
 #include <linux/input.h>
diff --git a/drivers/platform/x86/firmware_attributes_class.h b/include/linux/firmware_attributes.h
similarity index 60%
rename from drivers/platform/x86/firmware_attributes_class.h
rename to include/linux/firmware_attributes.h
index d27abe54fcf9..d4026ba1fcc2 100644
--- a/drivers/platform/x86/firmware_attributes_class.h
+++ b/include/linux/firmware_attributes.h
@@ -2,11 +2,11 @@
 
 /* Firmware attributes class helper module */
 
-#ifndef FW_ATTR_CLASS_H
-#define FW_ATTR_CLASS_H
+#ifndef _LINUX_FIRMWARE_ATTRIBUTES_H
+#define _LINUX_FIRMWARE_ATTRIBUTES_H
 
 #include <linux/device/class.h>
 
 extern const struct class firmware_attributes_class;
 
-#endif /* FW_ATTR_CLASS_H */
+#endif /* _LINUX_FIRMWARE_ATTRIBUTES_H */
