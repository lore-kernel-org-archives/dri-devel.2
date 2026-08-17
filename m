Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C820C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6352510E535;
	Wed, 19 Aug 2026 06:36:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="kso9fy+x";
	dkim-atps=neutral
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1280510E2E7
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:25:04 +0000 (UTC)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-836cde02992so35016907b3.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787001903; cv=none;
 d=google.com; s=arc-20260327;
 b=DXQmmWgaZueXMI+kv0xbEjir8tDAfKdsnuvtll+wa9d8ytSyE4lpM+ctN56la+2Xe8
 Ek1UVz1Xp1jDG5yNtpuIHyd0ENynQlys+DLQNbagZYFUEDEcZkgf0eO8Kvvhj2WRHQ5M
 YGhewi0p1OZREAQlXHJQbPQB6R9kYw2CRWospIsRPmQYbtytQLgzuLHRICDft4uVr8vO
 FhfqWligbVnR0J1vkpBmeHW+aiK4U6wjZOA/hENfhyZHj/ocRagCD9FDODogI/oR/8v3
 65v5WsaqbHMz3nOQYkIhXquLca/nxvqsmTsica7b3xIgPaWzERZp3Iufqz8wfcNd1u6A
 RG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=uC+ZPkSmY48LELILJXdTqPOhnPXkVBcTQXLErnsNTc4=;
 fh=GR7pfW4jzb8nWYOGVn4UeJY3eHQuL9/PEIkDY2OY9qQ=;
 b=I8RRX0A2Jlxeju4rRJ+NVhr8MnWMoJmr6sz444VKc1NBlysK1jT5RtMhZKhD5PEq0a
 V0XPoTch8gEovwDctdUailW4XjlmVRb1xAPGOGM7ZlG90SxCTKT+DFQFY7N6CyVwx9VQ
 Xk1OEDfvLnLgIzUooh35Vzct4wN9AZHcTeVvDfWSuaDV8XTkroeTqhfol4bjq3L1MsPu
 zBrd0o4J9UCUSBZ8miv6g9QNOJx6UunMA4sdEtcjtBw9iV8DAOFAJvw6VStkWgjIPyob
 Nv7+5Lc/HtgPr0ZlWx8nUHn9UQoyve62emiKLyGWAgNAgIst/FK1zHQUu66Q6QRwph+7
 4rbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1787001903;
 x=1787606703; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uC+ZPkSmY48LELILJXdTqPOhnPXkVBcTQXLErnsNTc4=;
 b=kso9fy+xnw4nNB1OIZ4kjVwLcYnnba0BpwE5VSasVZvHjGXwpQaXlcWFwjPEKcRd0X
 AXbLopWLM8qqxSZh8+gaiQ0YmBOc/zW6hCMubS8U8LC674HYr4oIJ0Vl+mA/3A+H8cKq
 477/A+zXznsZYwR90i6rFOofIcHLN52Vwy6qznaz/q4R8Lfdvrkm1zYb5on5v/nNfQvC
 LuPXFQNmPg4v/pV89vIxVhVSF9bosr6VoZjD87yR8yvHjnw511hY6aGesJjACzRyPvos
 7m/9Sggez4+LWo/MF40H+8OcJTiG0DivPmAlG+jXkNmFdRnQmUrzdDQrjaJwOJzZUXR6
 d+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787001903; x=1787606703;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=uC+ZPkSmY48LELILJXdTqPOhnPXkVBcTQXLErnsNTc4=;
 b=Dp6DhIopc8RkHlPmYi6PaNsXZ3xzuz7QL3aYi+IFGuMq88TOjEc6GG5Q5/pNjqt30u
 EVSRPM45Uq0RCNru+VrIu3DdCjTmld0wj2Mm2SE62/oS4CsutB9FjKVdiUadVu2er6/j
 MNpvpJ6QxduumJdJT+v6isYNr+HklIlvaQqV/ZLYufUtTGfFPdiALta5zCI7IZ74fXi1
 p7B4BhavUIfgS49aUUaE9lTeCXy0iscAgvi/ccLPkN0hr4RoBAjo/1COU99DEsGsQyy9
 m25T5aBuXoGCvgQ5wL86tZwktR56E13+NMgxsXUAZu+9De92kPnOJTpWfK2likS13WoM
 9zMw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDy/0tCO2YDTwgUESibUBn2UL9r2B7ND6mlrcMyT1jSZxq9922Zu9P5KKoHdEQpdEPNQwBPhYm4Y0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwncblaxDSeBfigC8oWyUl8doDSmKidwXgyE+g/Fszel5VTR3/R
 VUPYBozjMG5H8FE9LrG8r0ae03/u4n+9xP+DSah0HxrqfXOkkhArmJ3mzJFst1GTcnOB/unR3Na
 35gQ+6rNfF+jifDXxZvzmdx7WDlyuKelsZJBv99vx
X-Gm-Gg: AR+sD102dcq8gNvqkccZ9/S3cY8ihpyxEk5B5ViI8EqipKlYQkelFHCv66c635Noe7P
 8og2uMc5BTrki9IKv1Ft0AnAx20Q3mDpPKPYMqOmubEIF9o8aFuaDfqBZo8tKIrhVRxYO4TGZpV
 8WGY3XUlM4yuOgaTQp5Y9AjAa8s/qjepjxGXH/hOkWZdnY65V2BeZgS3x3xOFxviHdKIMwwDH1U
 BgTZd62w6xOlymY5HtFmBQzk2m20bd7bw/sWoLkfB9Ue+VsHWUDVH4EMuGpwkLHnNZMtLuiUJ/W
 +ST2vOwNbcAX2UmTTaNW2d9nPRJgukFhW3lOWCK2Z6rTn3C78KvvW4/c+qAD2evdLtVUOdU/
X-Received: by 2002:a05:690e:1306:b0:664:eb8c:9e3c with SMTP id
 956f58d0204a3-66c72d0980bmr8736238d50.46.1787001902711; Mon, 17 Aug 2026
 14:25:02 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:25:02 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Mon, 17 Aug 2026 14:25:01 -0700
MIME-Version: 1.0
In-Reply-To: <CABtds-0YAuFxEOUREOCOB2HErVp8h+dkhMwTj2ZrQqh_dGHMTw@mail.gmail.com>
References: <CABtds-0YAuFxEOUREOCOB2HErVp8h+dkhMwTj2ZrQqh_dGHMTw@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Mon, 17 Aug 2026 14:25:01 -0700
X-Gm-Features: AcwNN1W2nrfwJkcKJDJypHH8fsf07_HO4F3bBtgGI5y9ucOVgcOJe38ZwikfogY
Message-ID: <CABtds-3HuofWaoDbMHPBc34eivjtaYeBLb4qk+bDXmz59d=1Qg@mail.gmail.com>
Subject: [PATCH v13 1/5] platform/x86: Sort firmware attributes class includes
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

-- 
2.53.0
