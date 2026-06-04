Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66AECD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 06:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20671126D4;
	Thu,  4 Jun 2026 06:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pEGEKlrQ";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6238A1126D4
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 06:42:42 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2bf2247e38eso3793495ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780555362; x=1781160162; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ERlLtZnynL1JYR1BCmWJV8DFDr7q66lNokSGTMbdgUo=;
 b=pEGEKlrQA1CjTeLdDb+tKZYQMVjP4SeMffrl1evnzhV6w8YbrWULELv+crRTO3M05u
 1iDX4VjSG0kS4a0N+TSQIZmzdIgZncc3SHN0PzJ1eC5fy2xNAnsgz6z0zdW4Cr6yf4jO
 sXM1bQSQGD6lpAZHPakbSbb2otbiWxp1D2mNe5dh10o7wXOI0Cy9J821TY8AGurpmk8P
 qSSPQ7aC2+mCDNBG7o1hl/9U0uMGDHhUccFn6ieKfnOPLt1ewKvkUXvJ0660jmXtC6bT
 hYPTz/UcnFJRbWqv4Qrrf/cqdzS8v0dCdybmM/SNUNZZN0X13j0XWq8bYODdjNYVEP93
 gYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780555362; x=1781160162;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERlLtZnynL1JYR1BCmWJV8DFDr7q66lNokSGTMbdgUo=;
 b=XgcquWcJz/4fjuNYgGtRVoT+nR1TiQ2VdoK/69UVYEv5LAUa44Zk6xtCoER+M8IzrO
 Hj4G7wq2cBElvfjecCr90fsEuO7sPT4EyNSr+TnKH+sKD5dMhmYmtvbc3chauvhu9gG8
 rrmuxoYrvH7GguSAAzfIJTZSOmfrCTSydQrhctoxtOgCqfSk5jYnPeYR5DdX9aYoJmXq
 5Tm/SdC7FmZ7yE+dEB7G0AA/28KbyXelA9AMKH+JghqV8XP0DizeeHwuk3t+0v2fFiK0
 LTjMd4jG3AlzCt+NHrCKHbtvNv5hbGLozR7gFxdIrBkFjcZ3t2sN5nDLDdLxcSHkCMG4
 mDJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M65CGZoB9Eh1G+WZ9g8f/ahAm/3Jr7cb39CR2ES+ZS/3hoLGw9iexZqtDpC0JPgj4ZEkhEFQlziQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxx//Ogqddi/0kNIPFB7P3Dum8aZpCEsC4F4Ayu4QKdiHLNxZ3J
 nl0esDNqNzMGAS0crUOcrzJ7wYSnzlwuQDEi2GP2Md3jvszX38Y6lGEe
X-Gm-Gg: Acq92OET838wvZE9nm8lOfaAN/g1nOuwTWIAJriGJSIU6WxViL7yaxdzp6W6UqDiVvg
 vO4Soz9djUdtnh15yQvUfRpTo2ge3Rpvia3x0O9644457fpjf9kpLKsez6w9ITaCmw92y9qB3r9
 YvCgFNa+sulL4a2oEyAFXblBsrNAV08QKpn8jRjKVKqY9g7oWo4j4tUvyeFvpUol7MPoxDXYkoE
 C18+b7TgUNwWOlSMBgDQ/o52tISjV4MUYKo5Enl9fnVAN0xvqTm0rwMJeRpvQwxrhZ7Sn5JlRiQ
 uROlUa/5zZm0gQRa48HUW89gQ+EwTYYU0FudFHsPeyKA1CdnqrQ/Qj+2CxvhaEON3Sl1BY84OiF
 +2OcoWEsWl9X3OrFzO9eXxLrrnaDvZlgFEm0G1Uud4d0syVTNk9nTOHxTAZuPzd8/Ax6ROceMB9
 FXAH5CTE5zydveG13I
X-Received: by 2002:a17:903:41cf:b0:2c0:ca93:1303 with SMTP id
 d9443c01a7336-2c1639ee9e7mr70998755ad.6.1780555361754; 
 Wed, 03 Jun 2026 23:42:41 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f6dc92sm43801515ad.13.2026.06.03.23.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 23:42:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Prike Liang <Prike.Liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] drm/amdgpu/userq: clean up VA state on create failure
Date: Thu,  4 Jun 2026 14:39:43 +0800
Message-ID: <20260604063943.1412955-1-lgs201920130244@gmail.com>
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

amdgpu_userq_input_va_validate() is not a side-effect-free validator.
When it succeeds, it allocates a VA cursor, links it on
queue->userq_va_list and marks the corresponding bo_va as userq mapped.

The user queue create path validates queue_va, rptr_va and wptr_va with a
short-circuit OR expression. If an earlier validation succeeds and a
later validation fails, the error path frees the queue directly. The VA
cursor added by the successful validation is leaked and
bo_va->userq_va_mapped remains set even though no user queue was created.

The same stale VA tracking state can also survive later create failures
after all VA validations have succeeded, because those paths also free
the queue without unwinding queue->userq_va_list.

Route the create error paths through common unwind labels and call
amdgpu_userq_buffer_vas_list_cleanup() before freeing the queue. This
releases any VA cursors added during validation and clears the stale
userq VA mapping state.

Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address and size")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 32 +++++++++++------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0a1b93259887..dba0f786ae4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -826,17 +826,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
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
@@ -844,15 +842,14 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	r = amdgpu_userq_fence_driver_alloc(adev, queue);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to alloc fence driver\n");
-		goto unlock;
+		goto free_queue;
 	}
 
 	r = uq_funcs->mqd_create(queue, &args->in);
 	if (r) {
 		drm_file_err(uq_mgr->file, "Failed to create Queue\n");
 		amdgpu_userq_fence_driver_free(queue);
-		kfree(queue);
-		goto unlock;
+		goto free_queue;
 	}
 
 	/* drop this refcount during queue destroy */
@@ -862,21 +859,17 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	down_read(&adev->reset_domain->sem);
 	r = xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queue, GFP_KERNEL));
 	if (r) {
-		kfree(queue);
 		up_read(&adev->reset_domain->sem);
-		goto unlock;
+		goto free_queue;
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
+		goto free_queue;
 	}
 	up_read(&adev->reset_domain->sem);
 
@@ -892,10 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			xa_erase(&uq_mgr->userq_xa, qid);
-			amdgpu_userq_fence_driver_free(queue);
-			uq_funcs->mqd_destroy(queue);
-			kfree(queue);
-			goto unlock;
+			goto free_queue;
 		}
 	}
 
@@ -915,7 +905,15 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
+	goto unlock;
 
+free_mqd:
+	uq_funcs->mqd_destroy(queue);
+free_fence_driver:
+	amdgpu_userq_fence_driver_free(queue);
+free_queue:
+	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
+	kfree(queue);
 unlock:
 	mutex_unlock(&uq_mgr->userq_mutex);
 
-- 
2.43.0

