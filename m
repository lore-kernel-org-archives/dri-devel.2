Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C263C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE73B10F324;
	Thu, 16 Jul 2026 14:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SUdoPcm5";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D8CC10F324
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 14:03:59 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49544a80b9dso3159805e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784210638; x=1784815438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/NbnvUxJy4yq4eCE2cGJR00Ylvnn766FWTUcQlnPB58=;
 b=SUdoPcm53FuCIVtGnMDdbrQM1Cv17zJdzK8Iy2hhcA+UVeUlRybuMIfqMIqAfll4tM
 f228TnF6mOICOQD4M5KEw7txUxcUAhhpgUXq/cbuTq4amKscgdUG3SnsmYxauq2qjDww
 z7Rfy3l/4a5mh27IxWaruDa8/HV8N5lGUIbNXFYNs8s4jFOMpFAK8s9M98YWKIsD4mBR
 9U1TUWIJ9uVTSsY5hmya6gNohQQ39Rn1Dy7RVOVARTgeJx9LjF0F3z+9XBDGQPhdM4xq
 wTUVdKh97at5z6HtlTcIya/UEoaR6jxshA1xCvaHJLJMWm/ktK1Oy41JAR2Jje/FtAjF
 JWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784210638; x=1784815438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/NbnvUxJy4yq4eCE2cGJR00Ylvnn766FWTUcQlnPB58=;
 b=kEUdsMVUDZlRHDAWDosoNOtjNuMPJrsZwJDXTQ0SEsAxMY0QhPXCIfcfEXz0PrJfBo
 GtjG3WawILWsAyQClWawNxZ1xjzNz6OCQPaZlqTz2jHO3A0ySKCiQ77ZXsNIyGAYLxkF
 qbviGFebBHPhO+D6k+J4L1MHg9O/Hq7AFrLgx6+PGwG5FAP/JwEiB70XCFaJfGu5Rmvj
 rj7qb8AG2jT2vEBQpQPlycIiUbd87FHxDY3e56YqjP8zm/PkW63WJRvLM14jzfY0Jw6s
 t8zMDgP2mUgcf6ZTay7s5huHqF8KUK8daYhjrd75gugKsbZ1pIFbjRhRVh2H5br3cUZ2
 NF9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoR89nBkAxeqKboHyNORqrqHGmOtu+kfeFE9EQMWmilatm+DZ1ZTW+VIhNoD/FVx1vJrPmQWGbAAkc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1TPUBLKkETo/fpZJHvkzZaFnR49W93sj2TjpVCP3i+yK90bHZ
 7/k/u23LcTly6OtKJnm3GMS9hqP46rnCOolM0fZ6idn6Jfi5yfrkzc5N
X-Gm-Gg: AfdE7clOyYbdpwq8O9mIpdc5xXcp30dnOUxyopV+hzsm7QDk0ZHIpKMgdAu1yVpH3Wl
 y6znUzXpC1s9aTv+pgGTll5N3q6bdXiKOij2df3WG1bLB8jaicHJJCNxUv+QODyJCtPbgL2VzxG
 chWTEEvzzTQMH1dCNXUbZDJN32wSthd9TfcW88nn+1Z6Ol2LcZwfQ5pnji38YL3urwd1LUYIZGO
 WN92CRayzABdA41VG3QpaC5fZK9zjdZFzmUvTnHcM1sJ/eShAEh9Ws9qlX8zgJ8OmYe/vCr/69W
 OlFT5Nn34vavD2IKa6KmaOOd4gmL/6XcT24EmuVwojsY2J7WuiXwqs5a2vQA/mRlpaXWryCzkgR
 y0/fBMc23NJiXLdKBPlekqlPz4UXtuckvzW5866Is6pry8ls6r2nDey8HZjgWfrffHtZaWGfR6b
 Ze4WEg7hlp3qvLze68iWpa+8yyU6ARKfzm0U0i
X-Received: by 2002:a05:600d:6451:20b0:493:c0c1:3930 with SMTP id
 5b1f17b1804b1-495389ce059mr95230935e9.1.1784210637453; 
 Thu, 16 Jul 2026 07:03:57 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:8529:198:eaf9:708])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e7f7f7sm60785125e9.2.2026.07.16.07.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 07:03:56 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Grant Likely <grant.likely@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] drm/panthor: return PTR_ERR() from devm_drm_dev_alloc()
Date: Thu, 16 Jul 2026 16:03:36 +0200
Message-ID: <20260716140337.10679-1-osama.abdelkader@gmail.com>
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

devm_drm_dev_alloc() returns an ERR_PTR() on failure, but panthor_probe()
always converts that failure to -ENOMEM. Preserve the actual error code
returned by the DRM core instead.

Fixes: 4bdca1150792 ("drm/panthor: Add the driver frontend block")
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 487eedb72ac5..847db031e165 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1824,7 +1824,7 @@ static int panthor_probe(struct platform_device *pdev)
 	ptdev = devm_drm_dev_alloc(&pdev->dev, &panthor_drm_driver,
 				   struct panthor_device, base);
 	if (IS_ERR(ptdev))
-		return -ENOMEM;
+		return PTR_ERR(ptdev);
 
 	platform_set_drvdata(pdev, ptdev);
 
-- 
2.43.0

