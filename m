Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF606C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB2D10F1B9;
	Thu,  2 Jul 2026 07:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrOAspuE";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280F910E3E2
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:17:14 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5aeba09900bso1034484e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782947832; x=1783552632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
 b=TrOAspuEE8d/RuIdpsAInZaIw4yPyozh5YxbTEFrcrAGtgyzbw90S6ESm6PxEfujvm
 oS2yGvrCVhslY552c16dOGbc7pfmq4fUkDxddbiozr2ysFN0pMMleZNdhL7D0kjGxRuU
 qkFFan29Jov0V6LlrR7kWE03/iop5vH8keQuHJDPDVoHTX0t9fCuTkhtWuzHJPrusvi3
 cRjny8a4DeZRDeU0dkqbHob3sWoozSKWGOOERFo/xvgDQ6zzZW2jH8zzErdB+FEvauQd
 LN2flPcFgQlh6t62KzZ0SA4JfYQWTxsHrRowyDrE9Tv8o6yjueZTf4VaU32G8ZsiZlud
 tSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782947832; x=1783552632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
 b=iB0WJ+KkNPTqCS1bY/3zf0EgNT2PliuU916QiPsyyyJXulhxt8Sdej/Q/gCF9vI9Sj
 ZzGaas+JgY0JF0x72O3m+cWIsn3WMSBoE1bVyoCroGv8FnqIa/XxmPrexSxVUhRyDueR
 NNwKwEAGou4v1yju8g/InqlX1G++cQla1sbUmPKrnxyob8f+FPFRAaurcaDrCiQCoe+d
 OXBM4oSiB2Mqza0C+Boa0ZtDJ6j7f6WeZL+W+LdQtwZ0eUOCAPhM8JLBGUjvyw4+m5Ny
 ijO/mrcfv4DecNmioITlxEqyFPXN14YUUr1c/pxOpTzqU+jZRuKLtXUyYVEpAZ8n/h0y
 FgFA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKB5ZFv7qaHlWLOxtilmpSK4lIDz2/5T84cAJ4mAXwmE/a8dbtMcVs06hZB3vyxQ4XNebBE1s0Nv0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx56y1uk7ALqxx5DPyVJyNuNZON02SINLovcI7Af/Ojok/tEnHI
 TfJDq7bOpecbwQK3LrytkDcxCczybDzOOGf8EGEDYdx0VstVaIgwVH7T
X-Gm-Gg: AfdE7cnKQdTL/xnOfJ8fdAtqfJwJmsCnKt67A8hEyIv+m0VagPWAcQmbtwVQqQO91GQ
 EDB7UGHoNFpWy5elRir/SWeZhghysl6ZDUhRY6o/ec/ZgbXunG0BMA6vo04rylHJ9cKbQE5b9uc
 GIwtPNhrkSi4R2hgS2xMXgoxJXD48nVoypgGp5AnnVkBypfY5SX8DwHex2q8AsHA8kZT/2NkV5B
 PhlAtJxNAFecnR3nN8vJ8YG4nxl95YQNITm73gAS5wG1eBiEOKd1ZxmokxsqOwXGgaqLttXmtod
 bM8L7A/UiO7Da6VyuQ6trXzDvZuKaVFZQDyN6R9npa9fga/WWDkzdoEXtTtOtDn6TZAvbSs8Sc0
 5EgrzbKxZqxBHPgdvbQ/yV5TYDRokm/K4mC2EVZQt3AFofMqTO0LBsxWOL+3liZ9i56Yn3jWK+r
 DYWd7KLRs8posRBq15UQ++BEoM3hcTDJVoR9uIZu1xug==
X-Received: by 2002:a05:6512:8387:b0:5ae:9c19:165c with SMTP id
 2adb3069b0e04-5aec7fe9d35mr502903e87.7.1782947832122; 
 Wed, 01 Jul 2026 16:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aec8991974sm308950e87.4.2026.07.01.16.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 16:17:10 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Melbin K Mathew <mlbnkm1@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v2 1/2] fbdev: bound mode sysfs output to the sysfs buffer
Date: Thu,  2 Jul 2026 01:17:05 +0200
Message-Id: <20260701231706.234715-2-mlbnkm1@gmail.com>
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

mode_string() uses snprintf() which can return a value larger than the
remaining buffer space. show_modes() accumulates the return value into i
without checking whether i has reached PAGE_SIZE, causing the offset to
advance past the sysfs buffer if the modelist is long enough.

Add a size parameter to mode_string() and use scnprintf() to return
only the bytes actually written. Add an early return when offset
already exceeds the buffer. In show_modes(), stop accumulating once
the buffer is full.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index ea196603c7..af21dc5052 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -27,12 +27,15 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 	return 0;
 }
 
-static int mode_string(char *buf, unsigned int offset,
+static int mode_string(char *buf, size_t size, unsigned int offset,
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
 	char v = 'p';
 
+	if (offset >= size)
+		return 0;
+
 	if (mode->flag & FB_MODE_IS_DETAILED)
 		m = 'D';
 	if (mode->flag & FB_MODE_IS_VESA)
@@ -45,7 +48,7 @@ static int mode_string(char *buf, unsigned int offset,
 	if (mode->vmode & FB_VMODE_DOUBLE)
 		v = 'd';
 
-	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
+	return scnprintf(&buf[offset], size - offset, "%c:%dx%d%c-%d\n",
 	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
@@ -64,7 +67,7 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i = mode_string(mstr, 0, mode);
+		i = mode_string(mstr, sizeof(mstr), 0, mode);
 		if (strncmp(mstr, buf, max(count, i)) == 0) {
 
 			var = fb_info->var;
@@ -86,7 +89,7 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 	if (!fb_info->mode)
 		return 0;
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -136,7 +139,9 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	i = 0;
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i += mode_string(buf, i, mode);
+		i += mode_string(buf, PAGE_SIZE, i, mode);
+		if (i >= PAGE_SIZE - 1)
+			break;
 	}
 	return i;
 }
-- 
2.39.5

