Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FF3CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 08:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A963710E523;
	Fri,  2 Oct 2026 08:32:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Czb6Qrpv";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B8C10E523
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 08:32:24 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af9f88c95so1174262f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 01:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1790929942; x=1791534742; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
 b=Czb6QrpvMSPlhsitLa04drRbTHRUAAWaXtceAEm3GY7XO6ffHna+oGKJkxHwAyrvsE
 nUHuIOi32frbD1mWXtB1mIjFLljNQRwRNSb3J440fUDCzkmxadRDN702iJqPvfdhW2d/
 W7xCTRcbQUoWMoDzZruh1mYJ9swted7IOsKruX/brMGMXyrMTjUdDrKrc2aQekufw83P
 tD6F73FpOR+l2K0fYYARsf7hByMw9FSfbmDsfgv65IWx8SThl/TDsUj5W2Vup8qti5Zk
 Km0VU7mTqL491Hc2rGJa7y6spT3yqziFFGUnoiOdhQZMRFALiIYhhSUHsAehzqtmkvLP
 ErHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790929942; x=1791534742;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5JuY5wMUTyN0P+KeYJB0ZAeckebQaYADB7Uozry53MU=;
 b=i3/Y+7sOxRBdZwIptdCZBFfbAVSnsCE+XOKWzffDUXe6t3DrS5fJYBYyj2gOfbN5Q0
 h9Q5xRwtAGb1KRrd42RSy8GVlpWJZILlr3wV49PtlfZBlUXZSZrHQXlfK5k1dWewL5Au
 GiPe2/aC/TfNrzEa202iFs/0me5JC1XOPWd24YCf6NIm84l0FxVGxjquv6fYvX49Jqel
 8GV9NiAw2zSZAPTPaXCMm49TzH1NwEio/ztP7alqtyn6X0HKre5WM697VORUCmo38Vw9
 zsZQ6ovIQxjd5sw4jA1hrJii0m6yrlyaBRh87o9+CvB5jWSl5TbbbqB9za4ONzDXSNED
 rw+g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxacx6lnyqP1ATz4V5qirdcoljnsWEXmSeg/btNGPUh1liKxiSJnuXWNEONK8K9kUaPbSctPhCN2ow=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kwvmiVHnrzNiCXwPwCli3UjDZFzGjnu6m/r3onz2bM7YupxnVc
 8ySKm3xv/v9ZurfeM3yDHApwkSBBFCgUUpkkLyQ2/A01yP2Fev7tQaTfUyPc3yMiWKE=
X-Gm-Gg: AYBFou0y2xWcj+vmmJHo7ZRItN7F85yr9ZQL6bOIlzLbytIISq9B7p8rl6YuR1c+9DJ
 rOEKScD/ToEr2W5N+cm2BCqb27igmhZjlBdppcicTQsrfw27ASZ+Puc6Tg2zHP8pBZNXAEWFtwz
 ZOrSBy2hcQEax235ly0jk1VUxsX5s/gK2ymvXiHleIuumCsD2tw9w9x/MKNdAuIg+DsGibSaj5s
 lsYmHM8jGqaCdu8b+3/Lpcy2RSK9NKyl8od0b+SbGBD4rP/aUcxOucpXUT/TQdo0IKjSL334418
 cef2SHeHSa6DPc8ynITdq9R1aR/B1CYSCM242+0VaJJPEWnjl87tCtY4KyNj39K0ucV2Bpt15/F
 KQMBAcQQyaMMThdQlzXc1fwqcVmDuSAPgNcBbFXE68IwxR0Q9DHkLUORG6JKp/xg37DL/9yxKAp
 b5joFkoWtSGZayUQMPk1qDcF77Ft3K6ZpNNyWHxY38f+tJJIyRuczPwIvtarHMOWNVooE=
X-Received: by 2002:a05:600c:548c:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a027534bd7mr33259805e9.5.1790929942490; 
 Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
Received: from zovi.suse.cz ([2001:af0:8000:1409:193:86:92:181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a03feed16bsm42507905e9.4.2026.10.02.01.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 01:32:22 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rudolf Marek <r.marek@assembler.cz>,
 Andi Shyti <andi.shyti@kernel.org>, Chris Snook <chris.snook@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andreas Noever <andreas.noever@gmail.com>,
 Mika Westerberg <westeri@kernel.org>,
 Yehezkel Bernat <YehezkelShB@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Duncan Sands <duncan.sands@free.fr>,
 Chas Williams <3chas3@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-watchdog@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-hwmon@vger.kernel.org, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] hwmon: Replace __MODULE_STRING() with __stringify()
Date: Fri,  2 Oct 2026 10:31:01 +0200
Message-ID: <20261002-module-string-v2-1-fc7438acaf4d@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

__MODULE_STRING() has been an alias for __stringify() since "[PATCH]
MODULE_PARM support for older modules" [1] in 2002-12. That change also
moved it to the graveyard section at the end of linux/module.h

Replace the remaining uses of __MODULE_STRING() with __stringify() in
preparation for its removal.

Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 drivers/hwmon/fschmd.c         | 3 ++-
 drivers/hwmon/nct7904.c        | 5 +++--
 drivers/hwmon/sch56xx-common.c | 3 ++-
 drivers/hwmon/w83793.c         | 5 +++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 019fc32bf318..df9418a86c83 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -35,6 +35,7 @@
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
 #include <linux/kref.h>
+#include <linux/stringify.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
@@ -43,7 +44,7 @@ static const unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 enum chips { fscpos, fscher, fscscy, fschrc, fschmd, fschds, fscsyl };
 
diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index 976b8a008e44..04e1a8e6db37 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -23,6 +23,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/watchdog.h>
+#include <linux/stringify.h>
 
 #define VENDOR_ID_REG		0x7A	/* Any bank */
 #define NUVOTON_ID		0x50
@@ -113,12 +114,12 @@
 static int timeout;
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout, "Watchdog timeout in minutes. 1 <= timeout <= 255, default="
-			__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+			__stringify(WATCHDOG_TIMEOUT) ".");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-			__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+			__stringify(WATCHDOG_NOWAYOUT) ")");
 
 static const unsigned short normal_i2c[] = {
 	0x2d, 0x2e, I2C_CLIENT_END
diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index a385aae3bb0f..febb8ba7dc2c 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -18,13 +18,14 @@
 #include <linux/watchdog.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/stringify.h>
 #include "sch56xx-common.h"
 
 /* Insmod parameters */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
-	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+	__stringify(WATCHDOG_NOWAYOUT) ")");
 
 #define SIO_SCH56XX_LD_EM	0x0C	/* Embedded uController Logical Dev */
 #define SIO_UNLOCK_KEY		0x55	/* Key to enable Super-I/O */
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index c6ef04c69856..e1f2708b5db6 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -34,6 +34,7 @@
 #include <linux/notifier.h>
 #include <linux/reboot.h>
 #include <linux/jiffies.h>
+#include <linux/stringify.h>
 
 /* Default values */
 #define WATCHDOG_TIMEOUT 2	/* 2 minute default timeout */
@@ -57,13 +58,13 @@ static int timeout = WATCHDOG_TIMEOUT;	/* default timeout in minutes */
 module_param(timeout, int, 0);
 MODULE_PARM_DESC(timeout,
 	"Watchdog timeout in minutes. 2<= timeout <=255 (default="
-				__MODULE_STRING(WATCHDOG_TIMEOUT) ")");
+				__stringify(WATCHDOG_TIMEOUT) ")");
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 	"Watchdog cannot be stopped once started (default="
-				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+				__stringify(WATCHDOG_NOWAYOUT) ")");
 
 /*
  * Address 0x00, 0x0d, 0x0e, 0x0f in all three banks are reserved

-- 
2.55.0
