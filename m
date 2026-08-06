Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67601C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDB5E10F387;
	Fri,  7 Aug 2026 06:47:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="wPcj1PdK";
	dkim-atps=neutral
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A41010F2C6
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:28:04 +0000 (UTC)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-66843304cbaso4065496d50.2
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 13:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786048084; cv=none;
 d=google.com; s=arc-20260327;
 b=Z16hFOJBou5XNtkaz0lZdIxd0oqkCWSyVIe8pU99/JaOshnBKyKhYEDKTweD1YefV0
 8AbZg8WZFx8pUrPwT+WtJjdJReu6QFrCJ/7ZHwmvSCKyI4/xbPjLrP1RklVfRs+5UCx0
 PcOeoZZwZicxIeiFXrsFLzF/eB0h891Z+4nx46jWb9+xRMow8Yb5GjJEWpcHD+QGopEr
 sGHkrMR6J8+9bM8D6X3Xx/mC5lr0lYF6HkTce6EhhGhmi4AjvnxS7ZBNmthB9P9X2zXc
 ynEzGZoJNYC1k1NSuMTaTKyNructE5WP+Cw2uty8kvQ4pHqPJOODK92jdm3bklwOZH6r
 0QVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=7U9/0YDtB0EZm+GYjdQn8v+EZny+DXzdIE7UlRBbf24=;
 fh=CupiwIzUuyTYlpRWqxpnXsUZyOC4W/H4B8Ma+dRT+NM=;
 b=E7u0XlCyn4YiPjttP/Blqyh7FkG931t4By3TzdVh3waKlUdTJIp6hR+pW4AOkFXA/w
 2TCZojD2edk9R3ivFJFerccIOLJa1wpo1HC8mr7IRE2XbF7PFFbiuaS1CjI8ymD8gMP5
 5Jzj1qawcpfrHQeKlNwRmP+tH8z3+7JHbHAKjnxL4WeGumbZZBridB9GmmjnCsyMOcHr
 NZxv1txIUrpRypTbgqhIaMcFEu5l3l57ik4gd9dNpJLVicX/MpAQmNrl0iTk/1E1LRm3
 URqhrjjfrDhQYyUlIeEwHExF9PjpXJZqfH8mJtdEZMtlR0G13fwsS115pWNasE6lD5wK
 2Hew==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1786048084;
 x=1786652884; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7U9/0YDtB0EZm+GYjdQn8v+EZny+DXzdIE7UlRBbf24=;
 b=wPcj1PdK9hZMqTg6LU4AYGm6a+zTe9gVrEgJDtBtc7MDUwr3iI6CITJwC5ie5tOWOa
 nmiDJcB5J2Jc4lVcf3VEJLEozWf5oyZiGzYtCtpzb3cYscJiSkzWJojObNesjk8aiEgz
 iK0jqh9KctcEpCW+ciRjW2yVOj/UldhNvn2sjBG7OqhvZWsMNlyfuz7cK0Ji1iUQz4dc
 7aEPHs/l5LzdnnPgYvO7qOOLRFiaw1ackmYXjaJ/Fhd7AlVLToQFEELQdWAC7iKLaNRJ
 UServ7EfeU3Fxw9fpItLOPhPPSvbY0XUfJYDq89v91z09g1NRd704KZSaJ2MMqhT2IOh
 sFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048084; x=1786652884;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7U9/0YDtB0EZm+GYjdQn8v+EZny+DXzdIE7UlRBbf24=;
 b=ViGeE+dp6NwNNAtG8ZH9ujni279+4MIQf6x/GPc32LFx2+XkHgN1iBdGtEwo7f7ubG
 Z+jH5uaWP5zwwdRi+pAMggCpZxIkdVv+i9kdzjwJYZhP+lMoXubsYdhgjav6hC0J/7bw
 z2dC3grYpO3qhmPGtqOLSV7BFLUg8NbHZW1Y8zxWATY2f4Zst6I1YA5CmK7jdPCHq6Cn
 70h/won5UYaotTLRF7g20MrfvwIi8hq63qOtskvTpY+NwJg5xuaM2aBLD1dBEvy28EZU
 aC2AKqZbgk3XA81yIt34PyMoXPFq+bJcsIUns/lNmPhg9Y3bn6ppF3A+saYTeUJ1drob
 rBlw==
X-Forwarded-Encrypted: i=1;
 AHgh+RptHc6my6Hduynp/3VfYSPxPBPrlMI2AGJnGKRMoLYgTD8XZ2lCepiMDPuKPtLhHiROE/+28WADwPs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSnsZele+hJkXpk+3zlIW9QPwzy6xBTIDU5x0I4BYQNj9T31N0
 cxbHlxhNu4zzdQH7C178nbtu3k8kx6OeQEU0w6gDCE81NrdMYpRLRJFoqioc0gzEuulnVBLmdRl
 EfZ97zY/VC+pF/TqC7baWS+dk1nyn+hsR8H7UkPbA
X-Gm-Gg: AR+sD105CKcUKaG/I/gpLSmAL5kAQYSg4Yl8r80gFaw09ZprFqyLRCduu5Y04FzUzEG
 Tl078NeCBxgKO2kXcZhzHQmrEmzfqHmHiT9a2+T4lkcrn6+cckf9sjqSp5/9Ka6dhAqeyXTKb+K
 sq1c/cIdQtxNvGHEEbCI0lx8gzB44BPU25RB+f1CVhrw8aOK2pQgqQw6+iYXjqkh6/1aJYbTjlb
 8q9gwuOUGwcWHKrB6diaw8+5CtZ0GtZ1RXLRI/h9nxADRetuvqNnXT5LWEcQpfv/Ns83YdcQ7tW
 6ZwOuyf33ce47FUdMbaqNPz7llhswJRL0px2aIcXuz97i7Ms2Gj7GtCgYIuYAw3qq6Ak76UcLAN
 sgZGiQpyXZYyxcTiOCz0y
X-Received: by 2002:a05:690e:1757:b0:668:973d:5ba0 with SMTP id
 956f58d0204a3-6699aaec1famr7717035d50.26.1786048083788; Thu, 06 Aug 2026
 13:28:03 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 13:28:02 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 13:28:02 -0700
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 6 Aug 2026 13:28:02 -0700
X-Gm-Features: AUfX_mxR1eLhUqYeWuAis8rIKkWeNZ942rZgSIBzeg-q9vYC4RMlefqMyPaKtVg
Message-ID: <CABtds-3qYvwy5Z435vR-21djf2dvoVYSuYgLSXH=hc0e97j2vQ@mail.gmail.com>
Subject: [PATCH v12 1/4] platform/x86: Sort firmware attributes class includes
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

Move firmware_attributes_class.h into the main include block and sort the
affected includes. This lets the header move replace each include in place.

Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 drivers/platform/x86/asus-armoury.c                | 2 +-
 drivers/platform/x86/dell/dell-wmi-sysman/sysman.c | 9 +++++----
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c       | 9 +++++----
 drivers/platform/x86/lenovo/think-lmi.c            | 5 +++--
 drivers/platform/x86/lenovo/wmi-other.c            | 2 +-
 drivers/platform/x86/samsung-galaxybook.c          | 3 ++-
 6 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/asus-armoury.c
b/drivers/platform/x86/asus-armoury.c
index 495dc1e31d40..f3d8c5a85762 100644
--- a/drivers/platform/x86/asus-armoury.c
+++ b/drivers/platform/x86/asus-armoury.c
@@ -20,6 +20,7 @@
 #include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include "firmware_attributes_class.h"
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/kmod.h>
@@ -34,7 +35,6 @@
 #include <linux/sysfs.h>

 #include "asus-armoury.h"
-#include "firmware_attributes_class.h"

 #define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"

diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
index ab46a023cc34..4ff9003c6589 100644
--- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
+++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
@@ -8,18 +8,19 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/align.h>
-#include <linux/fs.h>
 #include <linux/dmi.h>
-#include <linux/module.h>
+#include "../../firmware_attributes_class.h"
+#include <linux/fs.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nls.h>
 #include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/wmi.h>
+
 #include "dell-wmi-sysman.h"
-#include "../../firmware_attributes_class.h"

 #define MAX_TYPES  4
-#include <linux/nls.h>

 struct wmi_sysman_priv wmi_priv = {
 	.mutex = __MUTEX_INITIALIZER(wmi_priv.mutex),
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
index 27fd6cd21529..1965a329be48 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
@@ -7,16 +7,17 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/errno.h>
+#include "../../firmware_attributes_class.h"
 #include <linux/fs.h>
-#include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/nls.h>
 #include <linux/printk.h>
 #include <linux/string.h>
 #include <linux/wmi.h>
+
 #include "bioscfg.h"
-#include "../../firmware_attributes_class.h"
-#include <linux/nls.h>
-#include <linux/errno.h>

 MODULE_AUTHOR("Jorge Lopez <jorge.lopez2@hp.com>");
 MODULE_DESCRIPTION("HP BIOS Configuration Driver");
diff --git a/drivers/platform/x86/lenovo/think-lmi.c
b/drivers/platform/x86/lenovo/think-lmi.c
index e215e86e3db7..9e4b3e973de9 100644
--- a/drivers/platform/x86/lenovo/think-lmi.c
+++ b/drivers/platform/x86/lenovo/think-lmi.c
@@ -13,14 +13,15 @@

 #include <linux/acpi.h>
 #include <linux/array_size.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
+#include "../firmware_attributes_class.h"
 #include <linux/fs.h>
 #include <linux/mutex.h>
 #include <linux/string_helpers.h>
 #include <linux/types.h>
-#include <linux/dmi.h>
 #include <linux/wmi.h>
-#include "../firmware_attributes_class.h"
+
 #include "think-lmi.h"

 static bool debug_support;
diff --git a/drivers/platform/x86/lenovo/wmi-other.c
b/drivers/platform/x86/lenovo/wmi-other.c
index fbb32bf404f2..fdebaa0a9992 100644
--- a/drivers/platform/x86/lenovo/wmi-other.c
+++ b/drivers/platform/x86/lenovo/wmi-other.c
@@ -33,6 +33,7 @@
 #include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/export.h>
+#include "../firmware_attributes_class.h"
 #include <linux/gfp_types.h>
 #include <linux/hwmon.h>
 #include <linux/idr.h>
@@ -50,7 +51,6 @@
 #include "wmi-capdata.h"
 #include "wmi-events.h"
 #include "wmi-helpers.h"
-#include "../firmware_attributes_class.h"

 #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"

diff --git a/drivers/platform/x86/samsung-galaxybook.c
b/drivers/platform/x86/samsung-galaxybook.c
index 6382af0b106c..74103c00b0c8 100644
--- a/drivers/platform/x86/samsung-galaxybook.c
+++ b/drivers/platform/x86/samsung-galaxybook.c
@@ -14,6 +14,7 @@
 #include <linux/acpi.h>
 #include <linux/bits.h>
 #include <linux/err.h>
+#include "firmware_attributes_class.h"
 #include <linux/i8042.h>
 #include <linux/init.h>
 #include <linux/input.h>
@@ -27,8 +28,8 @@
 #include <linux/sysfs.h>
 #include <linux/uuid.h>
 #include <linux/workqueue.h>
+
 #include <acpi/battery.h>
-#include "firmware_attributes_class.h"

 #define DRIVER_NAME "samsung-galaxybook"
