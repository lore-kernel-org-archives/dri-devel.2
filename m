Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5090C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:36:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E926110E4FE;
	Wed, 19 Aug 2026 06:36:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="tT5rLvao";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F74610E477
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:54:56 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47fde295992so261761f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1787003694;
 x=1787608494; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eyYlZFVCc06FCgom6L11YucB1au+iuvrVnF7FufZeZ4=;
 b=tT5rLvaor/ZksuyBrHCafwjmKajnkMZUEFpj5gRGw3vRwpBMtSKNfq4wC5ANW3wAaE
 i9lBPXmr1de9vp1k3HxSM7lLpR64XtSZnDaUR/BZe3ZR0lvsCf6biKpcvWwT0glmiww4
 XYjUhe7EwlfVIPDuKAi+GOdJJWHE9LQGeJEk/C4DWXj2NHYc7LGg+qQlWjhiPT8odeUP
 0/7dVmxLg+r21tJLnlOltuiCU9UXJ9gUPD9gBZ/24Gf5swOVs6E6OXzPIGKh9y+3AiJe
 Hx8/HQhOYHPR2VyM+qNvl1P6bZQ8QWjveIhgV/AJZcZSaTMpwG/VoQUAt2F47B2dPsqj
 inPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787003694; x=1787608494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eyYlZFVCc06FCgom6L11YucB1au+iuvrVnF7FufZeZ4=;
 b=sWUR84trlny3lvaPnowpPBAS2d7pjRd/gc6aNGzHsSIbFiI2brGcebOlwR6YcBbDsE
 m3hBAZN/pOLQe+wdJ5fG4HWuBqu4h+WX1Ti+kzC3jK2yMYD2Ec7ckzKVGmQaErns4ZDi
 eRSQDj+gCT/UoEbcfl86h73iKVMUaixiiYYNjCgXLkMpZffQqujhtWeTEVGl7Muu9LN/
 SLbAggqDWZQQ0piqFjIZ98DRk8UKAZriftv+kImL77nL7YWXQHtFiSS+IiTZu7oYRHdY
 A/CU2QRecrI4dxNVW97kiMp+jSz1+M2F9RPaLoXfucVLD1X7pN6175iycral1PmQYEfo
 xudw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLcJWgCkTI9ttjAElKKFXDFa0sZPRlKwtcFD9nCk2x5EZsl2pZapI3OnrKRk3WjCN6r2qc7HBg3p0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9AHnMvQEV5JGeYMQA7pSIRtE7pqO5ApuDtrl1cxcyaQSwyygl
 8MRl3SlXHuuTdCykDnlBbg6yznxijogM0iVehEfjSTGI+GC9SZUnfEkKTIuievQlmg==
X-Gm-Gg: AR+sD1131fzlA0y9S0Y7GKYZk4goKHsQp7f7xR6S/R0gRqB4WzKt8p1whQGswO5Hyn3
 6YFdl8Rc7YuYLzKAKsdPx1GU1XzYxJ9xHw37VLHueQHGjMzgWh4JrzbTEfrso408x0b1286Z2dT
 O85BdxgJqpprI0PKnG2v866SSuZk4OHx/P24dwIJgNFdNVjtHTJtFLLZRPpP1r7pzaoACFLO4Zm
 8pFx+44rqe2BaMXK3C/ctjzKzd4UlwzG1EqmwIoXWJFi9k6LHlW7S1cXKSMVE0YmAW9uE4N6YJO
 7CQiriIIxKCNAvhO40R6byhWOcuHzbeyRAYHIuaXKY8X7N+LqzSMulmt3NjEBsBMX72kWSda6Tj
 qGYBK0efqDLre4GBLHOmNZ5hVoQHj/u9CrEBRXUpF8DbKC3qI9hw76GOoW2gQMhPRTnxa06tBZa
 0VGMhyNoSh2gMOn8Vry54PluBFRj1HAsRzyIkIaMHGYb8ESYx/d70MQv1EKx0tXEy768hpAz9P+
 v93EpAfil9Lzg==
X-Received: by 2002:a05:6000:4028:b0:47f:fcff:6b05 with SMTP id
 ffacd0b85a97d-482aab887d9mr1314805f8f.13.1787003694601; 
 Mon, 17 Aug 2026 14:54:54 -0700 (PDT)
Received: from horizon ([217.155.46.38]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b3f0sm6060954f8f.14.2026.08.17.14.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 14:54:53 -0700 (PDT)
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
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
 Sean Rhodes <sean@starlabs.systems>, "Michael S. Tsirkin" <mst@redhat.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Huacai Chen <chenhuacai@kernel.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Brian Norris <briannorris@chromium.org>,
 Julius Werner <jwerner@chromium.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>,
 Kees Cook <kees@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>,
 linux-kernel@vger.kernel.org, oliver@liuxiaozhen.dev
Subject: [PATCH v13 RESEND 1/5] platform/x86: Sort firmware attributes class
 includes
Date: Mon, 17 Aug 2026 22:54:47 +0100
Message-ID: <b967ec0f8adb69417a3d81ee5546e4a238e29e11.1787003659.git.sean@starlabs.systems>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1787003659.git.sean@starlabs.systems>
References: <cover.1787003659.git.sean@starlabs.systems>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
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
 
diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
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
diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
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
diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x86/lenovo/think-lmi.c
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
diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x86/lenovo/wmi-other.c
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
 
diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform/x86/samsung-galaxybook.c
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
 
