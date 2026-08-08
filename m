Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7085C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:14:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E34B10E021;
	Sat,  8 Aug 2026 12:14:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lUhJk817";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB26D10E14B
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:14:47 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d02b4c3601so4718815ad.3
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 05:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786191287; x=1786796087; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fR3OipClJn+6ckgYC/3aH7kLb8zueZhnpSjG/5qdPqk=;
 b=lUhJk817M1r6Y1OLAlYUQlZcc73r8m5btFDx5hug1m7fv7CYZaOQe2CRi9oqcOnbt+
 Gnh0uiDURhTgsTnPMHZveo255bHxVpPt/Epq9PNF9h2uTsfrIVDP7PsJ2FPusuKLWo86
 CxYl/u2iPl04VTatuGHLjI51vn/xUXEQQeES1d6JcY+KFzwFTkYwWgx7uIo6bV7T6wci
 KVBLhML25aeGEEaQjPW5MOpCsu1cJltI0H1ocxReYqV7B3DMGYq0MhzNuQwL6diPM+cq
 2kY0GkUrjAnN54M2O1ZxgqCHC0EqAO4tM3fpOKOx3UqfECrby/HjPGEdq3K+c7hiHHHZ
 JcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786191287; x=1786796087;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fR3OipClJn+6ckgYC/3aH7kLb8zueZhnpSjG/5qdPqk=;
 b=InPCYtHkPbzcn4UFcFpBLOTmTArqNZ1fF+pBonPDqqJxK9Su1V5y/Zpw7w3zt9FioT
 4u2tHbIemRBq4+gxgIO1GO2SAXGwQK6u76zDsPgsd80DY0hmOjyu4G15kUNsnMQ293fV
 MKC+VsHL7PymDEyuoqk0X3kTtMEgIAAxHpajCtqXRtIf6rRaCziPOWSGFv8X1+OXQKnE
 HNCmULRakc9pTSAZWLmcVCJKDNF+Wr2QsW7A/z+AfOLeb4RUqbdgSKl5KWYK15nulZML
 CY+542dDY7cQpTXrBSbE/xsCobglmeuX3R3SWdDcyySRtBohaQDuo1YgyWR7YZBn9+EB
 fujw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrw0UPlbkYqoqKID2J4ZQHb9JhUPKJ7SVyOLf+aybE2jGklvCNXhWAsSLbSoH0xNycRuOm94U496ZU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxM9tsfpTwpGVhZuqmmnceF2ADmsFTUzlGG5xjXE/w0Cmrq7yPO
 nVBWc19bLoTBC3e6rSUudYhNh+Ojg8qsh6UW8weSCSnrf9Hx4RZAfFOf
X-Gm-Gg: AR+sD10aGErUma0c7IUba3sxAJ+ZMZG0EWpPgrDVB+gCOcFJBF9HbfujB+hSd+qfI7C
 VGXa6UDhd/LBsPRcd9KtHahxAFV+ObINi2DOoTRYutGSnlv8/slXxSoeDoQKLRv81CT2beV3E9P
 357N1JOYEDP4MfkA+fr6/8+D2WtUkS7AqRvVVClJAb21N/1t1Rh+q+euIsuH2L24LMRn1UBigK5
 +Ay70WAw2inrrXtI7lj4nCN6rbVlaDc18mh1wrizpZJ/MT2Ecrgj/qO6//2GMcuou9hA2n/OAru
 nhwkX4/PTvIHhbcY+43aCT9Ir7nW6UFUS6tldyEpkR6NmJZKBJiESii3uUg9ZEbMUv7rwQxyg+d
 YsnlsAbR7StNUxph02GnB27dY+cxWQ3l0jH76bRZENl3ykgyOVUvxz3gJ1lAiUPG+ip6fnSw8Q0
 GxFra9BsBHbq8N75UboBMn7vi3z1busZTykzcADiuKMd1P5XhqqJH8CRHS9g==
X-Received: by 2002:a17:902:e945:b0:2ca:d151:383a with SMTP id
 d9443c01a7336-2d0ca98f97dmr360786285ad.20.1786191287049; 
 Sat, 08 Aug 2026 05:14:47 -0700 (PDT)
Received: from lgs.. ([101.76.249.46]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d14ccdb26bsm18584345ad.22.2026.08.08.05.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 05:14:46 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/etnaviv: fix runtime PM cleanup during teardown
Date: Sat,  8 Aug 2026 20:14:34 +0800
Message-ID: <20260808121434.2815841-1-lgs201920130244@gmail.com>
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

etnaviv_gpu_platform_probe() calls pm_runtime_use_autosuspend() and
enables runtime PM before registering the component. If component_add()
fails, the probe path returns without undoing the autosuspend setting
or disabling runtime PM. The remove path also disables runtime PM
without calling the matching pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Undo the autosuspend setting on both probe failure and device removal,
and disable runtime PM on the component registration failure path.

This issue was found by manual code inspection.

Fixes: a8c21a5451d8 ("drm/etnaviv: add initial etnaviv DRM driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index c314b3cb5e70..7acf2ed651f3 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1964,6 +1964,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	err = component_add(dev, &gpu_ops);
 	if (err < 0) {
 		dev_err(dev, "failed to register component: %d\n", err);
+		pm_runtime_dont_use_autosuspend(dev);
+		pm_runtime_disable(dev);
 		return err;
 	}
 
@@ -1975,6 +1977,7 @@ static void etnaviv_gpu_platform_remove(struct platform_device *pdev)
 	struct etnaviv_gpu *gpu = dev_get_drvdata(&pdev->dev);
 
 	component_del(&pdev->dev, &gpu_ops);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	mutex_destroy(&gpu->lock);
-- 
2.43.0

