Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FFEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2021C10F41D;
	Thu,  9 Jul 2026 07:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hnMJ2xzI";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B29310F38C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 06:23:18 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cc8e87f29bso12368465ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 23:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783578198; x=1784182998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=F+zTyO38kFOW42Ye072aTRdmVTUuZduS9Yzytq9n62s=;
 b=hnMJ2xzIBvd3dcVncRG/EbQN7tA9VVTXJlgMsVV+8NazVuCbyA5Et5Z9eU9qg+AupS
 OJ9Z3BS2MwgZYeYlyVjo7PvIaJZN1E/1tPVwNgCx7w2eey55H1Usbiunwe1MOim35X4Y
 dKjiWjbETh0O5a4tKVLJAKZvzLnOdOgHCBgC/aWVrTGaRw9o8ykMxJTjXRNUUFP0/4Ut
 MiOAUNb9OYQqRjelwjyk56tifecHbw5u2nEa9rG52NWeIGHpAGEzQSTpA99zXdfFyF84
 39lbjCUxnw7qfoEKtn57C9G1vWGvRls4f4GsG1c1M6wkblSsqwAoTX1HcKHLwUGcwadG
 T76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783578198; x=1784182998;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F+zTyO38kFOW42Ye072aTRdmVTUuZduS9Yzytq9n62s=;
 b=kmPhWeh+1s7/nVvQlSjgkeZvJkOQmaU/ZiG/3P0K0byD02ki6j7g40C0B1NUCssnWE
 78ikA+/tytiZ+WzXOPZQgdc138CGuZrCsHPDqQXQi1Iz+6pdcPkEhONw/LvGjfUteC9U
 a54DIVfu955Zyc0zw80lygd3dHF+A6Lf5kntZI8LH4YmsMrB9TnRDLVpV7LSHpPyPSVL
 jVddkxeTS9XXeXZ5JpGcZV5phACgYeO1CHojFKlBgwH6pUygzb1JTQMFkJvOd5cKaV4H
 ahjS+BtPQiuAL1SrRiuqoPSSGnQBlPWeK5ijnC0XWh0vww3hZHoe5oSSzlUzMtPPkVTu
 NvHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqVwYTRo3pz7oXvWEes9w7pXHPLmeO+pAxoNSjp8AXaEemaJQ8ZNpERCXXVOINrt8xBPajj0z7FVig=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVI1gIq5IEtQzAQGxTiO4g3cqt7oHXQAyve5UXvYvIF+IfF+Wy
 Jyo5RlEWHMXnOZkv1/h8CF3+mf8edH2hKNcdqDZO0xZhxeKTnw0WmYXG
X-Gm-Gg: AfdE7clITk+R42xarHeffhzAnnLsAoLWbbdKe7FGt13JkJhVHlAmC42AA0jrHHGNWZG
 7I8iw4hKwSZVXxcnHZ6SMS1L7Vi6wK/dMjx5j3EMwEJsFQTfvVGY9tRsFnxLBFKEkp/oxMFt9yl
 Z+u9LyZ8bVLXgH7qefPjrwskrsjeo9GvPW5WJP9kB9HRlNejIfHU7XGwoKgNbm7puLyZ3BSNXrE
 XdAKRh7nqUYC5vDkvVM97OSA8aoElsv/AnhjID8rMs0bMRv6Z+FZtj+hhP/WH5fDoIUwZ/XQje1
 ECTZoBboQetYDOqJqM+o+JjnLtzcijQjjw9z2k5/dEB7IR6StSvKQm6aaRKIIpQtxzDKF6veubB
 IeErhfMhOedoBY+FsxUu6iYqmU7jv4Zla1jAbJHVteeg7sWu44j1qdnnlvvNsnjAMyw2DFl8Sdc
 cNvSI5PWiZ5LnwWompCz37i42XccQpfAeg
X-Received: by 2002:a17:903:230c:b0:2c9:fa31:84f9 with SMTP id
 d9443c01a7336-2ccea2d807cmr62949145ad.5.1783578197580; 
 Wed, 08 Jul 2026 23:23:17 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:ea9b:46f2:6d0c:46c7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d1e26esm38741495ad.44.2026.07.08.23.23.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 23:23:16 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: robdclark@gmail.com, quic_abhinavk@quicinc.com,
 dmitry.baryshkov@linaro.org, sean@poorly.run,
 marijn.suijten@somainline.org, airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH] drm/msm: Only fini scheduler after successful init
Date: Thu,  9 Jul 2026 14:23:09 +0800
Message-ID: <20260709062309.4168362-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:19 +0000
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

msm_ringbuffer_new() destroys a partially initialized ring through
msm_ringbuffer_destroy() when an allocation or scheduler setup step
fails.

If drm_sched_init() fails before it finishes initializing the scheduler,
the failure path still calls drm_sched_fini(). That teardown path assumes
the scheduler work items, lists, and workqueue state were initialized.

Track successful scheduler initialization and call drm_sched_fini() only
after drm_sched_init() returned 0.

This issue was found by a static analysis checker and confirmed by
manual source review.

Fixes: 1d8a5ca436ee ("drm/msm: Conversion to drm scheduler")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/msm/msm_ringbuffer.c | 7 ++++---
 drivers/gpu/drm/msm/msm_ringbuffer.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
index 0d14c31bd4e47..af2b0edc4d586 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.c
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
@@ -108,9 +108,9 @@ struct msm_ringbuffer *msm_ringbuffer_new(struct msm_gpu *gpu, int id,
 	ring->memptrs_iova = memptrs_iova;
 
 	ret = drm_sched_init(&ring->sched, &args);
-	if (ret) {
+	if (ret)
 		goto fail;
-	}
+	ring->sched_initialized = true;
 
 	INIT_LIST_HEAD(&ring->submits);
 	spin_lock_init(&ring->submit_lock);
@@ -132,7 +132,8 @@ void msm_ringbuffer_destroy(struct msm_ringbuffer *ring)
 	if (IS_ERR_OR_NULL(ring))
 		return;
 
-	drm_sched_fini(&ring->sched);
+	if (ring->sched_initialized)
+		drm_sched_fini(&ring->sched);
 
 	msm_fence_context_free(ring->fctx);
 
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 28ca8c9f7463d..3631ec283c6e5 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -56,6 +56,7 @@ struct msm_ringbuffer {
 	 * The job scheduler for this ring.
 	 */
 	struct drm_gpu_scheduler sched;
+	bool sched_initialized;
 
 	/*
 	 * List of in-flight submits on this ring.  Protected by submit_lock.
-- 
2.51.0

