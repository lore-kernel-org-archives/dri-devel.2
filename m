Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350CEF327B4
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A1010EB8F;
	Tue, 21 Apr 2026 07:10:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e4waehJD";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B54F10E1F2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:45:01 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso9343535e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776692700; x=1777297500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y6I5D+MUBwqgLFI3UEdq1+aGHSj6YwJYf2U1wbo8yrY=;
 b=e4waehJDRun4hSszvN4IA+hQPdplY31JC1pS+1x/eYhW8C2wm/B35l8l9pOXDXPfmm
 yZbKxjFQCiRwZD/cq9+dOaHjDnoDQbJbRiyIjpdlaEfCvfKmcwuFVKAGMqIhju+qBbmh
 Ru/VeiGolNwpNMe78fZUrU0ic5Bw6mRgrQn/bbIUo1YNV6sve0SyQMWm8Z4dMpBz+8nq
 Ff9U3Zd6h3/8PLeKBnku79KAKsdY9Q8p4iWYF+r+VJDH1NCUbkDpNiPHYVrQckE5rZNm
 T+sv3YAoT1fIUN5XrYmY8H5bjZG8rwfAjdTmuZJdXQ31Vj7NkgIcUJe/dGb789gqkQ6U
 NrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776692700; x=1777297500;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y6I5D+MUBwqgLFI3UEdq1+aGHSj6YwJYf2U1wbo8yrY=;
 b=IK6CShDczR84o5WED8KMgcknZ/wWVhF/XS+jmqOiwZHNHh359wK/GXJxWrgffIk3FU
 YOjzf4WeBVEyIAvLNXieBNjsf3nvt8Lg85jsc890eVocqwTF2dLXCvKgP/r84zu3s50G
 nhv8bgCfsokoyI531mUyuomm1yFK9IYssBlHQRuJ4gp87DFcxDhdn6eJGzvJcuS/a2fh
 n3ws0OxrwTbF/3aXtIdUkkLqaCg726PCzKJ8H5KBwWBMTlIJ750eIm4kF6cwsmHchCt6
 rtTLw05q/amjCyX1gd5F9W51yUeAib7jonKWy376uadhlRqyd5l1sBtxqnghXOCZx4yJ
 5Z5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+6A5K7gIWCGmXXUC77RI5EZ7kZqbyYpohH4Caf9yJfAr3pgmBnbqGX8lf5pHObIpXPx8f8/gy6/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr0qQKiby0d1NUyvvsi8OwY11OJctmMIICMJ+wAp/vz9yfvYes
 5+7YCJpfuURIPDd5Ak1Rm8X7QqKNzbrryp0s32sY044VRwmdJZJ5um/u
X-Gm-Gg: AeBDievL1sa2ae6V2LD8B3tVB+8Hc+xA59pwcsUlbnI1OW/W6DHrJGgdlYqVtpSUqaM
 +LAf3L4koNmYAolxBP1fYdj1/FNs29MPwVaTG0d9Wg8wSO3Cz8cPeqrBQgOUOFje7ekQHj2XyJa
 p9K0dqhBnOilIsEtM8CQbR1aZEkUp90XqHKPpBbqMN3QFy6d7i3T8mUpNlq4y8HT8uoAekA/fAp
 z3vow4FRY4wW4b704LOQRsYoIsH1p7IBXdoeNPS/EpwRU6lm5VFI2B0oMauD20vofvdl4AJitDl
 7Rcyd+70b0x0E9GPqcGCtVRkoMrzq0CU4M8Uy6QiVi4mvAIr6GPgtUQiSb13siXj45dKhnAnFh6
 qyVjxJKL/sZZDX/izd0Sq4E+uAAUJBbrFlUroKvz1qoyS5YAFVO9JCZSszHaXUdeSR0flMWLwEJ
 SIKjRm4mGupF8hifpynMRnsjDsrpOEQoMAnmKadM3UhUnG95TJpKU=
X-Received: by 2002:a05:600c:890b:b0:488:a977:8d6 with SMTP id
 5b1f17b1804b1-488fb775a35mr133481065e9.19.1776692699323; 
 Mon, 20 Apr 2026 06:44:59 -0700 (PDT)
Received: from anthony ([2a06:c701:499d:3e00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cc2cacsm29302178f8f.13.2026.04.20.06.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 06:44:57 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: deller@gmx.de
Cc: thomas.zimmermann@suse.de, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 0/3] fbdev: Request memory regions in platform drivers
Date: Mon, 20 Apr 2026 16:44:21 +0300
Message-ID: <20260420134424.77494-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

Several fbdev platform drivers call ioremap() on their hardware MMIO
without first claiming the range via request_mem_region(). This leaves
the kernel resource tree (/proc/iomem) with no record of the mapping,
allowing another driver to silently map the same registers.

This series fixes three platform_device drivers by switching to helpers
that combine resource claiming and ioremap in a single managed call.
cobalt_lcdfb and clps711x-fb are converted to
devm_platform_get_and_ioremap_resource(); goldfishfb is converted to
devm_ioremap_resource(), which also lets us drop the manual iounmap()
calls from the error path and remove function.

For clps711x-fb, resource 1 (the framebuffer range) already used
devm_platform_get_and_ioremap_resource() correctly; this series makes
resource 0 (the MMIO control registers) consistent with it.

This is part of the ongoing effort described in
Documentation/drm/todo.rst ("Request memory regions in all fbdev
drivers").

Amit Barzilai (3):
  fbdev: cobalt_lcdfb: Request memory region
  fbdev: clps711x-fb: Request memory region for MMIO
  fbdev: goldfishfb: Request memory region

 drivers/video/fbdev/clps711x-fb.c  |  9 +++------
 drivers/video/fbdev/cobalt_lcdfb.c | 12 +++---------
 drivers/video/fbdev/goldfishfb.c   |  8 +++-----
 3 files changed, 9 insertions(+), 20 deletions(-)


base-commit: 3f9357c30a44734d45e3093c521d52b2aefb09f5
-- 
2.53.0

