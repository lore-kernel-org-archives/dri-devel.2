Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A7BC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9200210E195;
	Wed,  1 Jul 2026 17:15:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EfbvvJ8D";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 149BD10E195
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:15:54 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2c9b1edf2bdso6390625ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782926153; x=1783530953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:subject:cc:to:from:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kXHKpeSyKt3/ctGA9pi3psIMZ/frqZMmTniR+Nhu24E=;
 b=EfbvvJ8DIGYc4+WCNszibX5TU3wdMyKsZu5M4PJ3YeOIpgNCo0we5FnFfheQMSHjAl
 wF3owX/FmCBvZzLOypUy6Q9r79zp6keGPL5K4eJKHiO+Lx5YPGKMLbN9yYoRBufADUln
 y2CTYTulE8/b4aFiTlHTD2cHnoVUnNwzj5hFOeLtUmbONzYmwE1bDkzs71fVrz8bWl1o
 COyYbTO/t20bxnJl7GN0f1mHt0wrBHfXCiStnDDxRvBTOW5PI9EmDfPZY4mPbVcSr2/v
 15eoQEsLiDrI75+LWaWfvZUIx1+1lDM4pvVgg5JVsjT8DpJOOFIOLjxcAP/5jujoLazv
 WHsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782926153; x=1783530953;
 h=content-transfer-encoding:mime-version:subject:cc:to:from:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXHKpeSyKt3/ctGA9pi3psIMZ/frqZMmTniR+Nhu24E=;
 b=nTec9ZO99Vkm+Svx5qbvHRUVyfAvjUSQxsjxzZorN7luuLhs/TNwuwvRxUtw2+G0j8
 eIPijQa6VTxo8P/5aRzwVbLr9tqBn03R4Y7R9Z5aj1nO4K1H7yIBBhklVp/Cp5j/9swd
 TpkEqtdXbiUMsyUz/+m7asYnSKuKCS12kZ4e+xjK4c/Nm0PRn8XDpIAvgpQtv7bloqnq
 ll/OSMPwVmqNxcY3W/KmWxM5LbTGOP+ckPjGDpha/hXVE1h67pLydnWEOZ2twM0AzjCZ
 qgA99Z1uzah88anlv70HKsDuUvZhIND2v6pe4WukJB4zzxjQnFXAXvR79b29yZNTOtJt
 gf/g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4ldn51a4SVG0guy4QCMaH1KL8ZdGDaP/TiYysmjxJ3FRCZYUhA5dwjuP2cHnUtOv1I/CNOP0ELU8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwC4QPk3VRA8EiR1r3hZCB2W6wPJ7WU/pSjBiLoRkCj/kCGTLkG
 o1hEtulHH7x+e3gIU0TtiS0DZXS+b4TY/9uvyojiGIKDKHWAJeekHGmi6MU09LCZrs0FvA==
X-Gm-Gg: AfdE7clr/kkXrixxNHgsBKo2f6Pc1ph7Zg9PBcHvde9NOrAEwXBh/pDRxlv3w2gQrmF
 P7l6fQ0bkq8F67C7iYL+dKddMknRSR7uOnQ2ZcyXRnngwQY95CSXfwqx8t/nHO8ecC/nxT3B8nA
 WhFP0nuCiTHr7BUpC1JROlXuImmTb2kVyz37Oi+z1kfMszCcsngReshMxKkZzs7T4qZ+LxqTRrA
 vLZhx/UKjCM2JPVAVC/XGU0a0ZxM7ZovNyiKTsv9nPD64hRJ7Pr5mmbCuoUT0CNIvN97BVB8R83
 algRm81l8YMZBSd0yZQ5WRxPxcnw7WBiwjggReD7EWoksGqyT5vj8uk7woX1PN14Uxt/ZZH7aqt
 9SpFTUzNTN5vip6etCRiUqJisZzyHZVSO0+Ofusn5PcMUIK2Atq2nZhSmzwg6Ox04MbZgIb7G7B
 7Gg5xUsSBzgvEPDa33KCBcrFvXVy9tEI0pxbwMZnlkE3q0x1AJAGZiIBnh7S35owf4Cu7UXVdFc
 9J/6HJJojASAZWk+Z6K
X-Received: by 2002:a17:903:3c50:b0:2ca:e5c:7fcf with SMTP id
 d9443c01a7336-2ca7e654686mr28663675ad.3.1782926153257; 
 Wed, 01 Jul 2026 10:15:53 -0700 (PDT)
Received: from Shuvs-MacBook-Air.local
 ([2407:1400:aa40:6780:6462:8b0c:2576:642b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ca9aa38fc5sm1121895ad.4.2026.07.01.10.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:15:52 -0700 (PDT)
Message-ID: <6a454b48.6a8fa39a.27019b.984b@mx.google.com>
Date: Wed, 01 Jul 2026 10:15:52 -0700 (PDT)
From: Shuvam Pandey <shuvampandey1@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] accel/rocket: initialize job domain before cleanup paths
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

rocket_ioctl_submit_job() releases rjob through rocket_job_put() on
allocation error paths. rocket_job_cleanup() unconditionally calls
rocket_iommu_domain_put(job->domain), but job->domain is assigned only
after task copying and BO lookups. A failure before that assignment can
therefore clean up a job with a NULL domain pointer.

Take the per-file domain reference before the first error path can release
rjob. Also clear rjob->tasks after freeing it in rocket_copy_tasks(), so
the common cleanup path cannot free the task array again after a task-copy
error.

Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
Cc: stable@vger.kernel.org
Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
---
 drivers/accel/rocket/rocket_job.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 2f1861f960cc..2b7222afc197 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -102,6 +102,7 @@ rocket_copy_tasks(struct drm_device *dev,
 
 fail:
 	kvfree(rjob->tasks);
+	rjob->tasks = NULL;
 	return ret;
 }
 
@@ -548,6 +549,7 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 	kref_init(&rjob->refcount);
 
 	rjob->rdev = rdev;
+	rjob->domain = rocket_iommu_domain_get(file_priv);
 
 	ret = drm_sched_job_init(&rjob->base,
 				 &file_priv->sched_entity,
@@ -573,8 +575,6 @@ static int rocket_ioctl_submit_job(struct drm_device *dev, struct drm_file *file
 
 	rjob->out_bo_count = job->out_bo_handle_count;
 
-	rjob->domain = rocket_iommu_domain_get(file_priv);
-
 	ret = rocket_job_push(rjob);
 	if (ret)
 		goto out_cleanup_job;
