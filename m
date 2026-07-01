Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A22C44501
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 592FD10F1EB;
	Thu,  2 Jul 2026 07:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qXMH+Mdm";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A687F10E28C
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 22:18:02 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5aebd52488cso1154090e87.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782944281; x=1783549081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iq6lRh8f1Za1oSMuyvvaFYD5RB3Lmh/p/MiUmv9wGms=;
 b=qXMH+MdmcyJOwtzlMsaiLVIdgzaBQ9nw7WvaPKAeMwQHqApz4SXoZg5EGJP9J9hmM4
 zQq6PbWyXLcG0x+IvIsbZLXkQtefNR1N5P675B9Wnpcuev38Sux27fbV9knqj9kNJgg0
 6gvhsxl8tn6ZDJUZuJN++653ky955BcK7w5eQmHJAxjTOjk7FDnL0HpvX9/HLuIlUNNL
 K5QHA4/VSH4ifgQTHBKXxomQLVmgmXmIw8xy3W9pDq1RrOfEmyGd1OrDph/bFpdstaSx
 ptPu/cwKr+0wpC1mYX+VQjOUi9usHGabZXpoWpvyIXkmJqPyzcW8kG5A4zUXXUY34Nhl
 MMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782944281; x=1783549081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iq6lRh8f1Za1oSMuyvvaFYD5RB3Lmh/p/MiUmv9wGms=;
 b=qtry/rDczZ3a1vwB6jYgA+hgSMQxCeHRan+wciM9qjw/FrXO2mmSst8Z4PBnZSEMyp
 n6NSV0RD7L+2zwmaA0KlHrBx5pUErUHopZ8JSwz23v+b9GseaqddVjstIKAcDp8QXDpu
 JxQNuPiBzd5znx2NzfKUr7Uom602v54TpIcDCztw9NM3HxJ4WXB3zmzLA8A67dv4dfrV
 BVsWTXxG8xfi2xsXuXif7HYwFeU+BKIyzBFK6/JK4m8KiMqdyCjJ13nv63UxlWZ0IWMX
 bU+ZLp/ky3HclsPLagaImfNIFspiZaXg/CiahaVy1O9TulULWpoaoSpJd++Z9kmthzVN
 1DaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrC8L/7sfzDF6FePq+5nco7NH87YXbskk9Wqscha/uARhB0ohHqbZftLQbvzCRMyuE++2qZy3r4Q54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGVbFwFpfpHy2AqAVaH8Bgo/luzbqQRUJc8+b8h2BMfXmKKnYX
 V98wmYLhCKEThnm15PgAAdMi1Q2m+2EYPuh/FAjLg6eqZljJv6W3/Dnl
X-Gm-Gg: AfdE7ck/jPD0CnrthMXVH5ynCO30Y5qMtR0M5M8UzdpRpRZIKBT/2m69wtTmOrg1hVV
 qz078wzgkXHVYl/nhPeYQmJafB89eBwO3AfXpybG4oIeGdT1I4U2GagkX9Fzv/ufa+w2xjYHbOf
 Vb/jFmOluB4+Yi+vl9N0RYRC6pkDNCfY5XDS4guVEpimT68AS2O2VNQFeBUTQBsyBkptrO/qQ7/
 h0w3e4RZ6lrlbJa0HgMGGkGLXt8rSfs0H6rvse7kgfu0IAC4ke5Z1VB8u6sUcasVXDX19ekTgEj
 M/f4pcJN56mq/ODeSyle3zk+LtE4h2nYRAzxBtLAckaUgGK+oWOR3W5GOnv31/6wHbHSg8eOOux
 RogVu/sjcV5cG4rEIJ/MgcOSajW/DmPBRkPhXynuu12TYLmYC/DwnvkRtk2u/gi5EQIpuiAuh25
 YPxa2+1qLz8/vvGY3qHieaUA0XVMOb9Do=
X-Received: by 2002:a05:6512:22c5:b0:5ae:a9ec:3545 with SMTP id
 2adb3069b0e04-5aec7338d31mr590751e87.54.1782944280234; 
 Wed, 01 Jul 2026 15:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aec89dc478sm267767e87.68.2026.07.01.15.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 15:17:58 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, security@kernel.org,
 Melbin K Mathew <mlbnkm1@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] fbdev: protect mode sysfs reads with lock_fb_info()
Date: Thu,  2 Jul 2026 00:17:57 +0200
Message-Id: <20260701221757.231490-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
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

show_mode() dereferences fb_info->mode and show_modes() walks
fb_info->modelist without holding lock_fb_info(). store_modes() takes
lock_fb_info() while replacing the modelist and freeing the old one.

A concurrent reader can load a pointer to an old modelist entry before
store_modes() frees it, then dereference freed memory in mode_string().

Take lock_fb_info() in both show_mode() and show_modes() to serialize
with store_modes(). In show_mode(), copy the mode to the stack and
format the stack copy after dropping the lock.

Impact: local kernel UAF read when a privileged writer races with
sysfs readers of /sys/class/graphics/fb*/mode and modes.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
A userspace reproducer triggering the race is available to maintainers on request.

 drivers/video/fbdev/core/fbsysfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index ea196603c7..6bdb25f7be 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -82,11 +82,20 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
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
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, 0, &mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -134,10 +143,13 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	const struct fb_videomode *mode;
 
 	i = 0;
+	lock_fb_info(fb_info);
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, i, mode);
 	}
+	unlock_fb_info(fb_info);
+
 	return i;
 }
 
-- 
2.39.5

