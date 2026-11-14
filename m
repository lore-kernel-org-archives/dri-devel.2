Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC092606A323
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MX2maVoF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B284710F047;
	Sat, 14 Nov 2026 16:25:24 +0000 (UTC)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FB0210E898
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 14:19:13 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-36e90071735so314450eec.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794665952; x=1795270752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AdmBh3xC9KRN8uEPKMGQW7/JjymKHmtkhbvdkKIOQCs=;
 b=MX2maVoFW9UXh09Jzjhrxaz4zpWJZuit6tQmHjNDvUnaM5yK6V1yIQ/kQrwq9fOpML
 WJw0VDSFz/aAvMmzfbvmBpTKkI6tBjNG69F6yA88qHtl855fIm585c+QK9T8TJSdmlcF
 mu3Cd4j15LxBvDpXl91YTrIvUzPWmRif1ofhL2yHk0HJlq1sMS6LSVtzroNN4HK5RInE
 EWG1G9d1TkCt2JyB/Vw3GM40M2VTFILMySM6fz3e69v8WDn6C7qbBZ6SFKFVTLg6GPuF
 4y58OdcjiWYuDYlSmws2nf8MLfCGbWGTcKdTKSHhrEBUfGKzdSwC1AUpdaKIOTfeVR6M
 hUhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794665952; x=1795270752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AdmBh3xC9KRN8uEPKMGQW7/JjymKHmtkhbvdkKIOQCs=;
 b=I7AIQm0yOwL+Wz/vLWy/UO2MyKSmKKGwhy5dIFbgvMo6iVzF0B3PkKLRdMaYUg6+y4
 hvMcvlLJ1WmUlD4btMMyTa/omfzD3KICYd+VLzFADeC+pdx/45DySACI1pZ6D7otG3bv
 Bgpir/eF7EwZ0hkibcElrji1KwjGodcUsRfFQHEpocNLXJ4tvhPtqMvaXS3aRqZ0XK8Q
 MQZzUVyQ8mOIJbeTnjd7BIWGGwu6n8paI9V8aY/tZlgC/ZyvrzN3gAJyKB7vsKkJg/2g
 gwqSHHboVGMrO0wa0ypNuzv7TUuz4yn5kCMq4ByrnBWzlnjZ13NksN18VLXpXyzFLL7b
 2/ug==
X-Forwarded-Encrypted: i=1;
 AL+hErEbNa95tkLLnd2fLBgURaBqFbHc6JC31GiV+ewQYJC80KdV6ibFIjt/IVBUrpjHcqqGhFM4dX+VHzg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9cWJFKhzQDdmY2QBm6bJtP9hxoLaEfmLJThypOwDupU3Ald/3Y
 iNbo0CI6Bjj7AulbAR1SQxc9DOW55Okc1z6Vti6ri7GDFEnmAw1UZ4VX
X-Gm-Gg: AYBFou0LvFwc/NsVdBsczK3iDTcNJZMgN1mdcN1M3ZEJCbI8T0rmoF8dHhovguPodu5
 gLKb4yUHAGgDUYiFqJWuar7LB/EjzOilHrAm1Vs2XJ4XX9cZj1jxnBFUSu65O5nNE+tql01RVvD
 LnX9PWHo1bT04SMvvSq+hhbcmamQVKftW9Rb3+v1VQFsFdwfKK1+Wpf4JIWKrKFcY6Tu82sIZvU
 ykigSn8tSjQlYqBV/E02CyMv9va/zC41IWwXh3pWkHx02nmNcJ89Bl7aPIwVWGcpyzkCMWG9vFK
 +6u0Wdb57V8Ijb40871UNCLxp55Eb2o0zUTU0OWSPfIq9dbxJiIfhVNR+OpQXGUdwUhZVS/R5mN
 6DHnAbOYLH/0RonDAQT227XiEZrIQPoypX1oFgRXKn1B5RBrs093qUEu+XVHC77GpP9i3gI93Jf
 AfRWjftVk5KnfSB2J/MncGV2ngRIsL580SbsVCyJWDGMJ8Lm49GPX8ePy6W32TLT/ViAKmurHAi
 UCWRJZ8smm5NXME1UgfUag3f3Wy4v7vFBQBHCZKgh6c2gFNxqaANDUl4icnQwFuYvxHgjyOEbly
 YkrWIWaZZqYHyZjYkhwmFBFPVEaUdwEZjnq9Nvlfy02GGRAY2BNEBsjbsFZCBuru7JHKv4p5fBC
 hLx8=
X-Received: by 2002:a05:701b:4508:10b0:1b3:a881:a67b with SMTP id
 a92af1059eb24-1b5030b6337mr8411764c88.1.1794665952002; 
 Sat, 14 Nov 2026 06:19:12 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b2519sm14745032c88.13.2026.11.14.06.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 06:19:11 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Julius Bairaktaris <julius@bairaktaris.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v3 2/3] drm/msm: Destroy the VM_BIND entity when its queue is
 closed
Date: Sat, 14 Nov 2026 23:18:50 +0900
Message-ID: <20261114141851.134290-3-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114141851.134290-1-arpe1618@gmail.com>
References: <20261114141851.134290-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The entity of a VM_BIND submitqueue is attached to the per-VM scheduler,
and msm_gem_vm_close() calls drm_sched_fini() on that scheduler when the
file is closed, which frees its run queues. The submitqueue itself is
only destroyed on its final put, though, and every VM_BIND job holds a
reference to it. msm_submitqueue_close() only flushes the entity, and a
queue that was closed earlier with MSM_SUBMITQUEUE_CLOSE is not flushed
at all.

The flush gives up after a timeout when the process exits, or on a
fatal signal, and it only kills the queued jobs when the process exits
because of SIGKILL. In these cases, and after MSM_SUBMITQUEUE_CLOSE,
the entity can still have a callback armed on the in-fence of a
VM_BIND job when drm_sched_fini() runs. When that fence signals,
drm_sched_entity_wakeup() dereferences entity->rq->sched, and so reads
a run queue that drm_sched_fini() has freed. If the jobs were killed,
the final put of the queue then calls drm_sched_entity_destroy(), which
reads the same freed run queue in drm_sched_entity_flush(). If they
were not, they never run, and keep the queue, its context and the VM
alive.

Destroy the VM_BIND entity when userspace closes the queue, on file
close or with MSM_SUBMITQUEUE_CLOSE, instead of on the final put, and
refuse new VM_BIND jobs on a closed queue. In the MSM_SUBMITQUEUE_CLOSE
path, do it after dropping ctxlock, as destroying the entity waits for
the jobs queued on it.

As a result, MSM_SUBMITQUEUE_CLOSE on a VM_BIND queue now waits
(killably) for the jobs already queued on it, and a fatal signal during
that wait cancels the remaining ones, where they used to still run. On
file close, the jobs still queued when the wait gives up are now always
cancelled, as they already were when the process was killed while
exiting, instead of being left on the entity. With the previous patch,
such jobs apply their unmaps and release their pins and references.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
The scoped_guard() in msm_submitqueue_remove() relies on commit
ea69d489d3a6 ("drm/msm: Rework queuelock"), so trees older than v7.3
need a manual backport.

If MSM_SUBMITQUEUE_CLOSE should rather not block, the destroy of closed
VM_BIND queues could instead be deferred to file close, e.g. with a
per-context list of them. That would also keep the ioctl out of a
killable wait for the queued jobs, which the freezer cannot interrupt.

 drivers/gpu/drm/msm/msm_gem_vma.c     |  5 +++
 drivers/gpu/drm/msm/msm_gpu.h         |  6 ++++
 drivers/gpu/drm/msm/msm_submitqueue.c | 50 +++++++++++++++++++--------
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 0b9f2e8916b7..ce9d97582df5 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1557,6 +1557,11 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	if (ret)
 		goto out_post_unlock;
 
+	if (queue->vm_bind_closed) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
 	if (args->flags & MSM_VM_BIND_FENCE_FD_IN) {
 		struct dma_fence *in_fence;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index bc5b31eb1eca..561f2d998e99 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -596,6 +596,12 @@ struct msm_gpu_submitqueue {
 	struct kref ref;
 	struct drm_sched_entity *entity;
 
+	/**
+	 * @vm_bind_closed: the queue was closed by userspace, and its VM_BIND
+	 * entity is being or has been destroyed.  Protected by @lock.
+	 */
+	bool vm_bind_closed;
+
 	/** @_vm_bind_entity: used for @entity pointer for VM_BIND queues */
 	struct drm_sched_entity _vm_bind_entity[0];
 };
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 8d550d281704..2dbe42551bd8 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -79,9 +79,6 @@ void msm_submitqueue_destroy(struct kref *kref)
 
 	idr_destroy(&queue->fence_idr);
 
-	if (queue->entity == &queue->_vm_bind_entity[0])
-		drm_sched_entity_destroy(queue->entity);
-
 	msm_context_put(queue->ctx);
 
 	kfree(queue);
@@ -107,6 +104,25 @@ struct msm_gpu_submitqueue *msm_submitqueue_get(struct msm_context *ctx,
 	return NULL;
 }
 
+/*
+ * The VM_BIND scheduler is torn down by msm_gem_vm_close() when the file is
+ * closed, but a VM_BIND queue can outlive that, as long as a job still holds
+ * a reference to it.  So destroy the VM_BIND entity here, when userspace
+ * closes the queue, rather than on the final put.  Both ways a queue is taken
+ * off ctx->submitqueues come through here.
+ */
+static void msm_submitqueue_close_vm_bind(struct msm_gpu_submitqueue *queue)
+{
+	if (queue->entity != &queue->_vm_bind_entity[0])
+		return;
+
+	mutex_lock(&queue->lock);
+	queue->vm_bind_closed = true;
+	mutex_unlock(&queue->lock);
+
+	drm_sched_entity_destroy(queue->entity);
+}
+
 void msm_submitqueue_close(struct msm_context *ctx)
 {
 	struct msm_gpu_submitqueue *queue, *tmp;
@@ -119,8 +135,7 @@ void msm_submitqueue_close(struct msm_context *ctx)
 	 * be any more user ioctls coming our way
 	 */
 	list_for_each_entry_safe(queue, tmp, &ctx->submitqueues, node) {
-		if (queue->entity == &queue->_vm_bind_entity[0])
-			drm_sched_entity_flush(queue->entity, MAX_WAIT_SCHED_ENTITY_Q_EMPTY);
+		msm_submitqueue_close_vm_bind(queue);
 		list_del(&queue->node);
 		msm_submitqueue_put(queue);
 	}
@@ -326,7 +341,7 @@ int msm_submitqueue_query(struct drm_device *drm, struct msm_context *ctx,
 
 int msm_submitqueue_remove(struct msm_context *ctx, u32 id)
 {
-	struct msm_gpu_submitqueue *entry;
+	struct msm_gpu_submitqueue *entry, *queue = NULL;
 
 	if (!ctx)
 		return 0;
@@ -338,16 +353,23 @@ int msm_submitqueue_remove(struct msm_context *ctx, u32 id)
 	if (!id)
 		return -ENOENT;
 
-	guard(rwsem_write)(&ctx->ctxlock);
-
-	list_for_each_entry(entry, &ctx->submitqueues, node) {
-		if (entry->id == id) {
-			list_del(&entry->node);
-			msm_submitqueue_put(entry);
-			return 0;
+	scoped_guard(rwsem_write, &ctx->ctxlock) {
+		list_for_each_entry(entry, &ctx->submitqueues, node) {
+			if (entry->id == id) {
+				list_del(&entry->node);
+				queue = entry;
+				break;
+			}
 		}
 	}
 
-	return -ENOENT;
+	if (!queue)
+		return -ENOENT;
+
+	/* Not under ctxlock: destroying the entity can wait for its jobs */
+	msm_submitqueue_close_vm_bind(queue);
+	msm_submitqueue_put(queue);
+
+	return 0;
 }
 
-- 
2.43.0

