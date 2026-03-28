Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863E510F3DD9
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 10:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A4610E405;
	Sat, 28 Mar 2026 10:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ghY0j63F";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4149110E074
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 02:16:19 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-7d9bba96f7dso1454527a34.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 19:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774664178; x=1775268978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ApsvoKgQ/+ecwFQ1dbi7zrc8rrPgaJdlpz0Z2+3q9AE=;
 b=ghY0j63F/Fy21eyxTKcTrhUK2EXcQLEsa0pVK4SSFKKTOD41ClhsC898UtJOuNfxIt
 VtiD5Miv+2mSXBoJDu5L0Z6pBA7UvqXWnbElJ258y8n746YJgjb28BDGZUOrjS4aZJ2X
 f7x6tdbsjB/XWgtwpcpY95cDE25/FusQ/qoYr1nn/B9jdnXJ62JLUX0dSHr6nu5pRpnT
 4hf5/y2ZKIovFA1ijqLNYv/flR6ovNIkL7vl/qiDyvj2cq5X5f8SWy9RQDuNTH31CAAY
 sSingn0tJdAvzKPr4EHJnA2VcuyeP4zclAsg2zkwASgiGNft1bFbr0RWvWC5rPCRv3R9
 iJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774664178; x=1775268978;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ApsvoKgQ/+ecwFQ1dbi7zrc8rrPgaJdlpz0Z2+3q9AE=;
 b=BC5hUg7gEFDExPRT0Xx/tVBwiAKm4woU9xq4CTPu6EhigsuTs2P33JrCAfbGFK/5Sy
 i+7w0ZuMMj2n0dqCYaGl0JmqSUboli7ojWoAPcskY1etRiuzkmihqtLiHXDqiMhgGjKN
 5Oou84ufKBUhxrYgNkJX9aRKJ8LVDRLrBTIAlhQ6wW3aSIorT7eNpv6yrObbyqMWEeVI
 N33SbMU64eWgbVur+qBIJrBtM5JCj5oK2jZtrsHZeKHY2lZilGEhATgkWySwlV+5XQbZ
 VQrn3OT8Q/GWL5jj1jLJq9/HxpF53ud3FtKT6HPZJqf392K78Z30H/vSTPk8ub19wPCn
 nNPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUclyc2XQbifwzE23l9UvcRJ/m5qOUZS2UQ6VMjT7BgLKeb53kQ9jNehn7jnzv67H5mZZr50yQaUzw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNnfgnj3TrndO3rTl0EgjxTzmklr0Pzph7xEW+vuR4Y9t0IVaX
 WnBEWpojXKYyiOQvc2dwxuDJn3CSuQ70nyJVCyE2b0miRxpKI89UBJIf
X-Gm-Gg: ATEYQzwc0DgOon8eU3dfcotqgNqm0Dd5FzetShegNXTXFpXP5q579DRS2Uh/mycJD5G
 n3PdZieyKRctai5I6hwUQugERoarxDtAi62liiy5VHxHWClSwJVewXmIGxCvSxOgqPL1Bf59k4B
 rBkYTAgRvX0Cm1oYpbXh63EoO1fn3J3M97fUXatzVutA3dYxyTaCIOpJaaQ4UOvwt+KDWd38TOK
 e2uwJMzU/y7RLnY79WH/mH0HXF0KJ/+lrq3XqmFDVobF6ijbP+VMEzzUvtbvWKsjPyJ7WU2oQTT
 KBkIym3P97TLnM2gQLhgqN1cAqve32sek3zE/Kl1+G/yUHedVC7zoJ6Yd4BeBJAxKGb62E86Ti5
 BMVR6WKw0qL9UCsRG32MBt4nVv8JAxPh0znRw47FoGDnXOaCCucOzvmmZMF4ZGyHxilEpZ85Erp
 WN0/IB8/jdZohmMfpDZWD3gkKio9ROhVSSvW8RgiIgOEzcgC4t/TMTe2DpvPDE9wENTpvd
X-Received: by 2002:a05:6830:6a11:b0:7d7:d702:401c with SMTP id
 46e09a7af769-7d9faf5af44mr2814201a34.32.1774664178252; 
 Fri, 27 Mar 2026 19:16:18 -0700 (PDT)
Received: from Mac (c-76-107-126-43.hsd1.tn.comcast.net. [76.107.126.43])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7da0a87de2esm683700a34.27.2026.03.27.19.16.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Mar 2026 19:16:17 -0700 (PDT)
From: David Baum <davidbaum461@gmail.com>
To: alexdeucher@gmail.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 David Baum <davidbaum461@gmail.com>
Subject: [PATCH] drm/amdgpu: fix resource leaks in userqueue creation error
 paths
Date: Fri, 27 Mar 2026 21:16:14 -0500
Message-ID: <20260328021614.20100-1-davidbaum461@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Mar 2026 10:16:18 +0000
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

amdgpu_userq_create() has multiple error paths that jump directly to the
'unlock' label, which only releases the mutex. This leaks resources that
were allocated earlier in the function:

- When amdgpu_userq_fence_driver_alloc() fails, the queue struct,
  doorbell BO, and VA list entries are leaked.
- When xa_store_irq() fails, the MQD and fence driver are leaked
  in addition to the queue struct.
- When kasprintf() fails for the queue debug name, the entire queue
  with all its resources (xa entry, MQD, fence driver, queue struct)
  is leaked.

Fix this by adding cleanup labels in reverse allocation order
(erase_xa, destroy_mqd, free_fence_driver, free_queue) before the
existing unlock label, and routing each error path to the correct
label that matches the resources allocated up to that point.

Signed-off-by: David Baum <davidbaum461@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 37 +++++++++++------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7c4503508..93c44798c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -819,17 +819,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_va, AMDGPU_GPU_PAGE_SIZE) ||
 	    amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_va, AMDGPU_GPU_PAGE_SIZE)) {
 		r = -EINVAL;
-		kfree(queue);
-		goto unlock;
+		goto free_queue;
 	}
 
 	/* Convert relative doorbell offset into absolute doorbell index */
 	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
 	if (index == (uint64_t)-EINVAL) {
 		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
-		kfree(queue);
 		r = -EINVAL;
-		goto unlock;
+		goto free_queue;
 	}
 
 	queue->doorbell_index = index;
@@ -837,15 +835,13 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
-		goto unlock;
+		goto free_queue;
 	}
 
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
-		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
-		goto unlock;
+		goto free_fence_driver;
 	}
 
 	/* drop this refcount during queue destroy */
@@ -855,21 +851,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	down_read(&adev->reset_domain->sem);
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
 	if (r) {
-		kfree(queue);
 		up_read(&adev->reset_domain->sem);
-		goto unlock;
+		goto destroy_mqd;
 	}
 
 	r = xa_alloc(&uq_mgr->userq_xa, &qid, queue,
 		     XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-		amdgpu_userq_fence_driver_free(queue);
-		uq_funcs->mqd_destroy(queue);
-		kfree(queue);
 		r = -ENOMEM;
 		up_read(&adev->reset_domain->sem);
-		goto unlock;
+		goto destroy_mqd;
 	}
 	up_read(&adev->reset_domain->sem);
 
@@ -884,18 +876,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		r = amdgpu_userq_map_helper(queue);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
-			xa_erase(&uq_mgr->userq_xa, qid);
-			amdgpu_userq_fence_driver_free(queue);
-			uq_funcs->mqd_destroy(queue);
-			kfree(queue);
-			goto unlock;
+			goto erase_xa;
 		}
 	}
 
 	queue_name = kasprintf(GFP_KERNEL, "queue-%d", qid);
 	if (!queue_name) {
 		r = -ENOMEM;
-		goto unlock;
+		goto erase_xa;
 	}
 
 #if defined(CONFIG_DEBUG_FS)
@@ -908,7 +896,16 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+	goto unlock;
 
+erase_xa:
+	xa_erase_irq(&uq_mgr->userq_xa, qid);
+destroy_mqd:
+	uq_funcs->mqd_destroy(queue);
+free_fence_driver:
+	amdgpu_userq_fence_driver_free(queue);
+free_queue:
+	kfree(queue);
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.50.1 (Apple Git-155)

