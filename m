Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A960C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5068510E392;
	Sat,  8 Aug 2026 13:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DOPSzSVL";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CF910E04E
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 13:02:33 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so3933495ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 06:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786194153; x=1786798953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ujnNvGTSQxsZnZMjDYqn4ikZo1KrqP6vWqNprtUTP2Y=;
 b=DOPSzSVLe72OJ9+E4kgUu4L1K1U9mkO4jeUwQjsIeg1dcQcyFrH4viZ+Vl8Tyoqg9g
 PLGmUpBaVI6IogCgGq0mFbNZHbggxVWaDl+wz9KjQXwwUj42l5AGqVFOKdFRP52D3+bJ
 AxQ2TgdGjxVi8R5As6x6ND6zE73xfeMfJInqyTfHsJ010Qk7lUWIXQofCq/VEkipfjsK
 SypPuyuxp16EGMXZ+nIRYf1OM/TLqckrCo5SmIuBmBIVSLCBKy8RJCrRjAku7k4xzNMq
 O+/QTdqkUx1C+6Yr47E5X+0XDAU+ODyhZaYKnV9pAt+7Hr4Zp2xlpjsVzSzMtQBcDycD
 sF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786194153; x=1786798953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ujnNvGTSQxsZnZMjDYqn4ikZo1KrqP6vWqNprtUTP2Y=;
 b=ACZDuDbPvZl+3uYuzr315k75gqswLR8XKuWciazAh1fiH+VSZ9X5Sg5Ci4EdOT1zLJ
 lQEZTBaG2SqZJ6fjFRKKarZzWwavj1v15y+l0vaFbmUekxG2gvN1Fc6l0DOBcFHwomcl
 zKXJoRFoAtbpmMfDqYukH6gZJbwz/9aO4znANLX9Gb/8Ju/cEyCykxS6OM/f0FHU4xpl
 fUBjPDpoEB/QwlOi1Db0YeBBXmCr0oOAoKT9lai1Pk+XafW7IT5xDdDdVnMQqTgVj2gu
 5vvjQgMpBXXALVSHmW2VCX36sGAXAFdxgOt44TXKcl2RkeZ2wQgFCz2bM6VU22QiULsV
 r6Vw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrtFrzW+MaDEdak6CsvYsRPRG7sa0D3mRilJbFZ0h/lU6GlyYOJFvgoNFrJ8Ww5WtoOGmgo6CVtvJE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCJGUO0sTS4lO49BXBeiWkXuC8ZNgMoW6G1lwjcqS2QXJ+kBlf
 rubnVz+D/Vp+MW7T7IeVsoO00SlZ4bG+91Dt4xHj8hxUniwmHjpCRcRr
X-Gm-Gg: AR+sD11Ms/ZmN2J7Cw+ZCVtOfdaMRfqb5Uy+KGtThFl2LIxEcARAiNvYXAz/t1DCI5u
 BzwLao0ij5POuhnmRUf4jFobv9cCbHmfoJOT3ah9a04KgMWBW809ynjPGLiHLXVH5iP1R0U5d4Z
 jbaikY0akRkKT1zP+FnNE7hHthhPM0MhjfJRr1KsIF+qyxyMwy+KigkEgNpahoZF5dAerIVOhfP
 qf2mO9AbBqPxsc8aw/2qCfAUGabIyvrXDDs00PcV8+22jaebhyNNa9gYuo/l1s27cUxSIIyX+RK
 blxUNCIGBGu734Ui/lHY16sxdQ4LKy29v8ckqwWwTGg1S55ZReoFlaKFEqT5oMdAp8WbYJPQF+6
 L3hZYcb7CizWWcRemA+pNb8AkA7CRCFjUI2LO2Okff9BtDxDqogHjxdxRcsHolHAqr3/HnnoUb5
 7hc7279ckE2N8rs2mkzfpq0iXNLMj+i9adYYPYnR4wbN6/
X-Received: by 2002:a17:902:cccf:b0:2d0:cc92:f7b8 with SMTP id
 d9443c01a7336-2d0cc9302a7mr351828965ad.2.1786194153328; 
 Sat, 08 Aug 2026 06:02:33 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccae6f8sm18582125ad.1.2026.08.08.06.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:02:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Vasily Khoruzhick <anarsoul@gmail.com>,
 dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/lima: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 20:59:53 +0800
Message-ID: <20260808125953.2842241-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
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

lima_pdev_probe() calls pm_runtime_use_autosuspend(), but its failure
path does not call the matching pm_runtime_dont_use_autosuspend()
before disabling runtime PM. The remove path has the same issue.

In particular, lima_pdev_remove() explicitly sets the autosuspend
delay to -1 while autosuspend is still enabled. A negative autosuspend
delay can increase usage_count to prevent runtime suspend. Without
calling pm_runtime_dont_use_autosuspend(), this reference is not
dropped before runtime PM is disabled, leaving usage_count unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
failure and remove paths.

This issue was found by manual code inspection.

Fixes: 50de2e9ebbc0 ("drm/lima: enable runtime pm")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/lima/lima_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 9a0eb1092ad3..9bd44c191e6c 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -434,6 +434,7 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	return 0;
 
 err_out3:
+	pm_runtime_dont_use_autosuspend(ldev->dev);
 	pm_runtime_disable(ldev->dev);
 	lima_devfreq_fini(ldev);
 err_out2:
@@ -456,6 +457,7 @@ static void lima_pdev_remove(struct platform_device *pdev)
 
 	/* stop autosuspend to make sure device is in active state */
 	pm_runtime_set_autosuspend_delay(ldev->dev, -1);
+	pm_runtime_dont_use_autosuspend(ldev->dev);
 	pm_runtime_disable(ldev->dev);
 
 	lima_devfreq_fini(ldev);
-- 
2.43.0

