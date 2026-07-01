Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E30C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F199B10F1D1;
	Thu,  2 Jul 2026 07:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LZacTikc";
	dkim-atps=neutral
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com
 [209.85.167.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D04A10E3F4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:43:02 +0000 (UTC)
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-5aec201b582so1220172e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 16:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782949381; x=1783554181; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
 b=LZacTikcuYnMfGOZYLqJ7/WfMjXCHjoLZ9Uojvxp+oflapRKuEdzxAQMrpUSl9RFVg
 oJlKzEAI4SRp+VSyrk+yB+tVhbQHYwBN8pgqbf4kQsbzw/noO1jZl75vuaiLI0SYfq7T
 7hwlxqA8WUIACtwRcRg5OHgEi1OtsTVKhf02Of9aAO5WZZWAlYEWQ4cvtOYUyq8fBztt
 uRtBrMtLE8C7Z7QM/ZRUM+CHmqXHEmb75uOC5VJITnC/jHqKLZPLxICBquqQCjnhkIYp
 ZwILUupRNtIx4wGk22kxcV58DB1Mz1BIg8C3JRnaZADzGcMNbIDCQ2wUCfEhR3kH5wmH
 ydKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782949381; x=1783554181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
 b=YckntLzC5yhHKrh3N/Yh5t0l1FpQTD/PaUy5P2MdApu3lTrKvffFZTHrwnoxDYitvd
 iOudUS+Az0BesxrGxQ87sb9xATPFDqeWH++5UxyAJjD4CMAbYA4/4CfJIgEph48VuRTi
 h+ovmNmYyzh1MuG3XN0YuSPTqdQwhJUknvdQKtaxUN7vHNR9AejNmNzWtrkzD1htPJU2
 aMLESeC94RqB6LsR7Vv0WxUrY+DgAOq/xeq0nvAocMju/0l0L4i8mz/UcR+gIgi/pb9f
 qy3PAluo9molas2FRefLy0omxVnR0jeHFAID9iMpA93Zm8WBrOraU9LA9fTABRR0aCVg
 2JDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMXu6rAS+5eyRPIoKR/GmzUDJ6T3OTEbUa1m7cfaHJqLFZmIZzF29t3EosDN8/bB8CX/tyrmHdA+c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxDKWNA3N32PXQkPPwKDPWJVc9UnFmD8hSt/hQ1dGUhrvKRi1V
 2Fiqgk6Igg9fg5DQ9E4C40OMm/oq6Ta/tmDf4Uv+fQvyQvQPBCkQN/QG
X-Gm-Gg: AfdE7ckWOHEFSRZ2LEmeUF4OvoHW9lujzZPkockZORmh3z7YJfoGvq7pITtBwxl6CA9
 mP32GYwhZcgdb5oskUg9joGgzSwy1/3p26JFgnmpU2C3ZN4/r7WsieamLNIKOtS3Ye5daPIt0t6
 p3QZq42RAXLhpoXD1icE7GLFcy/FmB14EtRILdGSw7q5IFMOAD0K8rmRDAE/GjGDVeS2r4lTum7
 G8XPYotJfCtB4APf7gURaadD99YrdVcbggr8kK/F58Ymf6OGaoiHmwmrUfyi2yeFKbNW1q2auWe
 ZEF+A+09ibv7oMtxqedozwlHLlmeqR3dRbxXCul5KwAp1gb/4WFsTuckk4HKVN9/hqu+0Tjy9pS
 ob2dwwTDy+/J8UXFgQKb2c1PdS790Rx75CL+vqpnCliLNB9eUXSbQdHsRhpHZ8rKLlKEYWyELPN
 5ArjSMak1BR639kMNM+jo2BLJYQg5NGO8=
X-Received: by 2002:a05:6512:66c1:10b0:5aa:8822:b1ee with SMTP id
 2adb3069b0e04-5aec68b7f97mr677361e87.48.1782949380696; 
 Wed, 01 Jul 2026 16:43:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 16:42:58 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Melbin K Mathew <mlbnkm1@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 3/3] fbdev: serialize mode sysfs access with lock_fb_info()
Date: Thu,  2 Jul 2026 01:42:48 +0200
Message-Id: <20260701234248.236023-4-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701231706.234715-1-mlbnkm1@gmail.com>
References: <20260701231706.234715-1-mlbnkm1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

show_mode(), show_modes(), and store_mode() access fb_info->modelist
and fb_info->mode without holding lock_fb_info(). store_modes() takes
lock_fb_info() while replacing the modelist and freeing the old one.

A concurrent reader or writer can load a pointer to an old modelist
entry before store_modes() frees it, then dereference freed memory or
store a stale freed pointer in fb_info->mode.

Take lock_fb_info() in show_mode(), show_modes(), and store_mode() to
serialize with store_modes(). In show_mode(), copy the mode to the
stack and format after dropping the lock. In store_mode(), split
activate() into a _locked variant to avoid double-locking, and hold
the locks for the modelist walk, mode conversion, activation, and
fb_info->mode assignment together.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 46 ++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index af21dc5052..d3d60c555b 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -12,19 +12,24 @@
 #include "fb_internal.h"
 #include "fbcon.h"
 
+static int activate_locked(struct fb_info *fb_info,
+			    struct fb_var_screeninfo *var)
+{
+	var->activate |= FB_ACTIVATE_FORCE;
+	return fb_set_var_from_user(fb_info, var);
+}
+
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
 	int err;
 
-	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
 	lock_fb_info(fb_info);
-	err = fb_set_var_from_user(fb_info, var);
+	err = activate_locked(fb_info, var);
 	unlock_fb_info(fb_info);
 	console_unlock();
-	if (err)
-		return err;
-	return 0;
+
+	return err;
 }
 
 static int mode_string(char *buf, size_t size, unsigned int offset,
@@ -65,6 +70,9 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	memset(&var, 0, sizeof(var));
 
+	console_lock();
+	lock_fb_info(fb_info);
+
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i = mode_string(mstr, sizeof(mstr), 0, mode);
@@ -72,12 +80,22 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 			var = fb_info->var;
 			fb_videomode_to_var(&var, mode);
-			if ((err = activate(fb_info, &var)))
+			err = activate_locked(fb_info, &var);
+			if (err) {
+				unlock_fb_info(fb_info);
+				console_unlock();
 				return err;
+			}
 			fb_info->mode = mode;
+			unlock_fb_info(fb_info);
+			console_unlock();
 			return count;
 		}
 	}
+
+	unlock_fb_info(fb_info);
+	console_unlock();
+
 	return -EINVAL;
 }
 
@@ -85,11 +103,20 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 			 char *buf)
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
+	struct fb_videomode mode;
+	bool have_mode = false;
 
-	if (!fb_info->mode)
+	lock_fb_info(fb_info);
+	if (fb_info->mode) {
+		mode = *fb_info->mode;
+		have_mode = true;
+	}
+	unlock_fb_info(fb_info);
+
+	if (!have_mode)
 		return 0;
 
-	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, &mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -137,12 +164,15 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	const struct fb_videomode *mode;
 
 	i = 0;
+	lock_fb_info(fb_info);
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, PAGE_SIZE, i, mode);
 		if (i >= PAGE_SIZE - 1)
 			break;
 	}
+	unlock_fb_info(fb_info);
+
 	return i;
 }
 
-- 
2.39.5

