Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35C60C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F8610F1AE;
	Thu,  2 Jul 2026 07:51:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I0HAfOnG";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04A8E10E3F4
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 23:42:57 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5aeb6d00883so974876e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782949375; x=1783554175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
 b=I0HAfOnGcHTrorpDXludyr+GKv+V+QhIAeZbcyet9i+CvRJGxLB0ZHHC2jzedbT1em
 0ScilbSThwd0Qv+WXUtZzklj4V0NnidnSEz4ObHspQcUiYYU+kHnMUXKjdNkFYhY+xBI
 HrhN8YXBiu7h9FvK0JA0Ezau2bc2Q+3cYNwWZcHmNaz73tFEdpvl6Ujnj97RWhSVeSbf
 c5l+H9m8SdgJeuoxKodACfhS2roQBEw7n4doubv8kF0gsJ+7/TxlnhlmLDuT8RZH0OVa
 e3zEtGDTDz9KL7AW4xsowokfxD3p0OnnqnIcreF/1Aocv2Sz/nrl06Cqm/qvOO5LD5YN
 lVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782949375; x=1783554175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
 b=ZDgj4xGOUnnP6sAMtc8n0FUqst4GvF4d62kskmV/90cyPjcWUABW438qZlCQxFiYoG
 SF5nGPwMFqPM75Ez7wGWclyGBJqG0hyqw55EHs6612w3l+oNOE1AVgOMBp3jVR4f20K5
 zFwajCVUPWnMX6seTzvyH1O1Rs2+bH4KURUhw0seWSgUxCGo+DB+JqkLrfM/dQfAOxoe
 2VLU88RssGTV4VQl05cTZwkXL742XWywxk4Ovoj7pVabU6tKJBZ0ig6svv4QJUm9RfDJ
 TUuED+YbXbIHbJ+NnFT/gSbB3YUm0BPlg2KQeX8oY6Jy/Rcvd8peop2jZ2xptQPDJ1c2
 n0Kw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZG0jYLT89F1uaA0RbtgtLWtFOoqr3Dhp7+PghBlNiJppogm1iKda3Ku07R+yN4xqDyILGbwvze1Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2G92eDsmqq+G/U2Qs3+smzrWEiOMDB7aZ8SLDhuZNxMA4QB8P
 QZW5WjGSmNTvN3A5Co4gi1KXc8VhMDlz/Je/PNrb5oPsXS8+bIs1zI+5
X-Gm-Gg: AfdE7ckTPrJqxIGdYjWLCW0bA8e7RbWozGe2DMP1FlK2Ze1+RiW7QLcGTgN+bGx8z3L
 0P4I5a86Bif/VvH4bJ8Q5M6NiRyfSJggAZ13QcohRfXDsgApD9PXvda+NYGZFxuzIEDAEF9yQkq
 8xGG3QoUqoDkwm3nkPRkQzSKBPTVpUK7muuYpxEaKYhFdE37tm/jQl938vbU2Jo/Sx9zMRXh2zm
 Lx6b4VH+cL3tSDcQkyG8UGnMKjWPZjiKPKZZjwVofHHnCODw71qgHH+DY5++Gumrg8Yfiwzt9KT
 Tw3zKt+JEszf7t+xlPE3K1i+z0brE06mWcQPSqMXEFMQSOvflzHiyLKMJBlnIMpiBOmwngqcwCm
 4abG3/QzwJypctHC0Ht7VY5lwnuCzvdpYMgpNVTxl6upViL66+onT5p/e94T5LKpC4pF9oLBQEp
 1inWDc8CaIeFVMhJIk7RkLzKqLOj4fVR0z3/PttE7rCg==
X-Received: by 2002:a05:6512:4481:b0:5ae:c201:c3d7 with SMTP id
 2adb3069b0e04-5aec801063cmr603820e87.8.1782949374962; 
 Wed, 01 Jul 2026 16:42:54 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39b37fda160sm2836261fa.29.2026.07.01.16.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 16:42:53 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Melbin K Mathew <mlbnkm1@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3 1/3] fbdev: bound mode sysfs output to the sysfs buffer
Date: Thu,  2 Jul 2026 01:42:46 +0200
Message-Id: <20260701234248.236023-2-mlbnkm1@gmail.com>
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

