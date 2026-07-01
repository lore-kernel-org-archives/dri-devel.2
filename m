Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20681C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6713910F1DB;
	Thu,  2 Jul 2026 07:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DEFWrcJq";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6664010E3E2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:17:17 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5aec139da7eso3160e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 16:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782947835; x=1783552635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
 b=DEFWrcJqSIcjit0AajYI/La95/6RY83qqs/pAIc/rNIZPhLjQDJ5HKLYsQoR7gDY+k
 BRIwZ+Y4ZGZHzDALDqbmzA/2jxKkP4AWgiJm1SJJYth2AwC2p72+OVzSMrbzWnwYaRp/
 iBCXesGWB4kRVyLrzeD098WHxMGvBRHc5Pzq9+QXuHOLC0f2c3spKJD9gmVBCyfjvFxc
 HPWx4WP/J7GnNam6ozwJZ8CDLFBUgS9i/qej0CF50O5LqEUdS52pLLOtwt3Nu4gFkvCT
 G3JyXHort3GSyU7R1LhYsylaKTbKlG9gvNnSMmskbauee44eS6XZWu9RfEF9JefRW/HP
 0TKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782947835; x=1783552635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/M9QqAmY7Pg8H8gQnrUHA/IfrEsurxPK03ttJdgNJSc=;
 b=JokJt2f7Xkrto7vMaxZZ7OlvfcG+zt0+NcE+FNLsu4nhXRPY3HjjQOAtEUFnsvBCyn
 jWnN7so66TFi5qR6p5WVzGX2j/v/cPvMm9C1gXrS1glNd78nMb+1iSgSgszCzO9BzsG+
 nQQ1U2m5bV7E0EaQkLHMbj0dLilqj+BIcgZZCY7A3VfgFmM1NCfGSMaW4rkd0qoP6c9z
 xv3RDD3olvyweMAflSbhQ/UE4pL9VW5iY8LNmkSMv1QuOgg66wJnOJDXFcBxu1oOUkz/
 kyIiPRpTK/TWhxs9IKXRT60O3yyI8btT+ImktXlcobLY7YTdf4kI7PCqU1TwhG2Qb1Vn
 8fPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzJbgTg5mgsbhuKa5i5MJLZn2Ltq9PAg4bizacZygZ2yOsx5/k1tSRTp8d7Guna39nF6CcTocQGRs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcxqKt1CSgDMN+q5IMg22omwBfBxxeRifsilWolDH0q0Db0NYd
 u/IZZMm90bK9axjkWWuHghIpWkx10NZHahSS+Q/bi2EumN+tQtlg1Gnn
X-Gm-Gg: AfdE7cmWoNFMXQXqYZOzws9PXCsMYQpZdarxhfOX+n4O3NoHpYdKwuhWHxwNW+74ATF
 xpneJdlqA9WrJtSLOgIgCeiBZg9sUzilNjA6emN8v54VbATx0IAP1IMbQbNPG74tieU73+fKYpC
 +QpN2BfCcAa1K7R2GylbrBt1CXYIj8um13A0JvQfBpSkQld4BdkKqX9wRaRxvzOjg+RAXcEi+Pg
 jAixBRz7wANVs4ELT7zn7eZE3lCvxwSRix4AZ+uXz7UPfj5t1ZlxtvS3NBOF/HQ7oIQa5OJDggi
 cznKPtHRwBKtBtuiiW3Apu69ee6MsbMd83ZWDE5w0Kx2ECtdfzSfU1ERNJD8066NawQTkff2W7l
 4YZxOO+qFrijqWpeAEBE8TIC2u+sOmBYTKLQh/4AJ/rY98yVILfmt1EX4zGIgCjYlA91/MwAc2h
 l6edGvXqYaUTnHpJh/h4fFaX9e3+J1Dwk=
X-Received: by 2002:a05:6512:2286:b0:5ae:b6cf:c745 with SMTP id
 2adb3069b0e04-5aec630a373mr908377e87.17.1782947835394; 
 Wed, 01 Jul 2026 16:17:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aec8991974sm308950e87.4.2026.07.01.16.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 16:17:13 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Melbin K Mathew <mlbnkm1@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 2/2] fbdev: serialize mode sysfs access with lock_fb_info()
Date: Thu,  2 Jul 2026 01:17:06 +0200
Message-Id: <20260701231706.234715-3-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701221757.231490-1-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
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

