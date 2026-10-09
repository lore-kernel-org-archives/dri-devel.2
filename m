Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5167BCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:18:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEE0112036;
	Fri,  9 Oct 2026 10:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BZXPHilW";
	dkim-atps=neutral
Received: from mail-oo2-f10.google.com (mail-oo2-f10.google.com
 [74.125.231.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859D4112039
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:18:53 +0000 (UTC)
Received: by mail-oo2-f10.google.com with SMTP id
 46e09a7af769-820ff812cd8so1638142a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791541132; x=1792145932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qQYsTFrWke5vcZofnQE3TNuLqYunAq0Wa80G2xcz6E8=;
 b=BZXPHilW1AerL2kD7w+mrFWUe/DPWJHLAh8tscNsuSvNKsp5zmZGffoTuoK7JqW8jB
 /2UNXobb7y1EgxjTtM3Y93aoG76NH0ex1C7ot9dizqUUztLN583ZaZwVowxzscQIbdlR
 9Jtos9m9C8XUqOtaZE99MI9AEJp6nvzgbNa9yc9/SpsAekgu+0NiE+0DkVexVXD/7o0F
 vYtIez7qAxC9+VexyxfLN5YEYA5M+70BNfIiEVSpqa123FM4dkhjhWy/rFRnTKei2hVn
 di/QoDHfSSVxiy2v+qsLwgXZYWMEpAkCDN7KZ524cN3DL4lVxsg+xjPoLDbFZbSPY5oa
 LPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791541132; x=1792145932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qQYsTFrWke5vcZofnQE3TNuLqYunAq0Wa80G2xcz6E8=;
 b=mOsBtgDdDds+XSnh3KcjsJ5e05wuv7BnmOdTWVZKN3/ckaGWeuCquCOUCJQDv2MOfd
 hrZ6SjkIRntBBEzS4GaPrDx2oVo+MEjnz2Exh0iNIQspIvP5QsC3yk/nX2NVkSWhTiyf
 /Of6ZvxGOqiaEzDj7/Ouz5kR1FnZO0dwtXs1z9cAfaXU8YWydfSiwE3YMaGNl7oGmuWp
 pElXjJGA55NPzMkc1DbvhZWiekECmnXFVWTKiBAysbGTMC0aKJb/0+hlgSKHAeWWTI3v
 AxaVgt3/Muv843CO1JTb7s+35L/BLfe62UReZL3m+JbXQ/gDNP4UvPWvBDBA0fvbklaK
 appQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCyUXOTVzfBIanEZKmw/IbDZtHcDsuU1+Le7rihIx2ufdQKiTIbX9sA8DvzOyxWVf+YglBWHoiuJM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIDzepCx8ShIigYf9Hbr/F85pXkOw4qqqqNCs/g3eQVLRNDfvpa
 GlYhAdNOWsuaoCQdKQPwlaMLJiwuJ4Dfg46KPW2ROHustofxxNiLXSyR
X-Gm-Gg: AYBFou24g8DuKD+3tu+OXrwU3wO7OIFjumvH4X6J7aFVOFlJR3u3Wp8t8UI99mRFs/I
 vORzdamaMjPnF1q4alZBBpjYT5/tBgi1BhiRwgg++EbrR5aRH2GoLNlA6vvoA0d/DT+WFBnjU6Y
 fv4csiH3Bxmd8DzKAG+tcVoeudx1j820xADdEEuG99OWuROA6GSTTtoBAABYW2MCXzxII6ljnFN
 wE+1InVSq7baG7qPhdWDjvGPJZjZpDgOgmE66YDDsros3+YVQQ16AAJN8lfriAzM/XCnPfPe8wM
 eUXO3WUGJ7Xh60RD5XWNrdJ+z5eQYP03SsLpbhsGPsci64cLYgSPAzpZh9l2gO67v+7hGJA1lfb
 uo2H7XTawzzUPHsCl/97Roa8pO2VbtR96PQ6G1/3UQR1rPRAWv4OOgbZRF0lAN8R9TUtuvq02j5
 oWXjFPzP6IGbvQAvXAGdQXS8C87w/72tA4QZ9gVPBiCbTtUR+X3ZPQGAPjedBGB+eGCBF1kdJZ+
 FSLjNrCwMr1Y+ghiLpt0c2zTAPYrmYNfp3jpA==
X-Received: by 2002:a05:6871:5214:b0:49e:6fbc:cd5b with SMTP id
 586e51a60fabf-4a2a898e729mr1145751fac.55.1791541132396; 
 Fri, 09 Oct 2026 03:18:52 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.41])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a858aa3esm1401367fac.12.2026.10.09.03.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 03:18:50 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] amdkfd: fix doorbell allocation race creating duplicate
 allocations
Date: Fri,  9 Oct 2026 18:18:42 +0800
Message-ID: <20261009101842.3294707-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

The check-and-allocate sequence on pdd->qpd.proc_doorbells is
lockless at every call site of kfd_alloc_process_doorbells():
kfd_get_process_doorbells() (mmap of /dev/kfd), kfd_ioctl_create_queue()
and the CRIU restore path each test the pointer under different
locking (or none), so two racing threads can both observe NULL and
each allocate a doorbell BO and bitmap, orphaning one allocation and
handing the two mappings different backing pages.

Move the serialization into kfd_alloc_process_doorbells() itself:
take kfd->doorbell_mutex and re-check under it, so all three call
sites are covered regardless of their own locking.  The existing
doorbell_mutex users (kfd_get_kernel_doorbell() /
kfd_release_kernel_doorbell()) only guard the device-global
kfd->doorbell_bitmap in short non-sleeping sections and never call
into this path, so there is no nesting.

This vulnerability was discovered by Tencent CodeBuddy Security.

Fixes: 428542d91772 ("drm/amd/display: Setup for mmhubbub3_warmup_mcif with big buffer")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index fdcf7f2d1b5b4..07f881573837e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -257,12 +257,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 	int r;
 	struct qcm_process_device *qpd = &pdd->qpd;

+	mutex_lock(&kfd->doorbell_mutex);
+
+	/* Another thread may have won the check-and-allocate race */
+	if (qpd->proc_doorbells) {
+		mutex_unlock(&kfd->doorbell_mutex);
+		return 0;
+	}
+
 	/* Allocate bitmap for dynamic doorbell allocation */
 	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
 					     GFP_KERNEL);
 	if (!qpd->doorbell_bitmap) {
 		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto unlock;
 	}

 	r = init_doorbell_bitmap(&pdd->qpd, kfd);
@@ -284,11 +293,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 		DRM_ERROR("Failed to allocate process doorbells\n");
 		goto err;
 	}
+
+	mutex_unlock(&kfd->doorbell_mutex);
 	return 0;

 err:
 	bitmap_free(qpd->doorbell_bitmap);
 	qpd->doorbell_bitmap = NULL;
+unlock:
+	mutex_unlock(&kfd->doorbell_mutex);
 	return r;
 }

--
2.43.7
