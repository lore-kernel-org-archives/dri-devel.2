Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46379606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLqdRcrp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C05410EF0D;
	Sat, 14 Nov 2026 16:24:53 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9DE310E1B5
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 06:25:52 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-37605faade6so207420eec.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794637552; x=1795242352; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LDQz09G2XyTTuhJSitLdBUGEVlAlYFjTvvQk/ah90w4=;
 b=jLqdRcrpxbuFvu59MsszipvxcSy4ennxzRclNZvEVmtwkzWq/haGtKL9cRll2Y8j/X
 oCL68ACmQqQqyHEvVL9tzv4PN05M3o1cnXe+/QNcfWxFTQnOnZ1W7N8e91lylDfoqqI4
 p1xEyIZiGUZILro1vKTHbonFPWbvH/0QZS6Sz2cKT42dBCltmXzRWrE0Ao9zv9CzEM3A
 UaQ8ck3fpftwanzrjgzfy5kmoY9awo5XupTik4earMyalc5i3DBgkZazc+s71PbUcKw7
 IOQNxAdePIhujWLwFwISkl9gJq8q+I7oXYRbMEs4AdZoPATNahXbVvdEVZ0V+Q8T6XQJ
 HHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794637552; x=1795242352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LDQz09G2XyTTuhJSitLdBUGEVlAlYFjTvvQk/ah90w4=;
 b=nWMB5r/1A4UWiaRjH9jdDtJ3R1wN9utZPTK6bjWNzx4VFoiB5/i31qf5shrXJeWFra
 NdpL3EvglsFSmB5zPJkdenWO2H9FQYX7bseY58xpBoW3yPL52qtPZJZatfGszRNpkg1z
 5HYj4mye2zj8hxNnSH8yGcVrXQyXYOMUaTZTcmXCLxYzl8PDrShSnGXHq0GDgRKhMrOe
 Rehxa5fv/+OeOWxYTlqK7B/kNhnNTFqEujSDGuv8nYyZJatFi/PCbnbZ1GskAlYDZYFc
 8BN6Yz3beWp6cmqvC6PWup57AsahDs8bei4vI+aPy1SOzjKUGMPwDrVBihyM1nbEPpAe
 g5Jg==
X-Forwarded-Encrypted: i=1;
 AL+hErGXhM2aPJ1FlBQoG7+DSbpedakWVfDmCs/1h5/8zz+37ZOSj3hjL4R4jn8URZH5OQgFRQ/VrAySzqY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8T7CvI1HxqJ/AIKbAREzxbqf/vvSAhWNNN7otzVnyEMXqbgYRE
 JVcvnB6+iR2Xq7kpSdSms4j2WwuGDEGxwMe5ZRvPcY3a2tHHp+EyrMac
X-Gm-Gg: AYBFou0PHKiuDsWx9Tc0W78mu9Uoc+mOxrKR/6uklhkJJsxJcM0THkc+oyorK7GFQoW
 SK0Exr5ky+glwNBfJ2sag+ean/yFJrlo8srh/MKVk75cSrJz6Ow7+r0/S86BFdTSzpLHHOnbHAq
 Dh+bwwNWS+lRrHeZJUSM4jtoKf29P9b9d1VIzTWrYZqULSvgYnIxsfwk3ZAQJQezowjJxqWCLzo
 IsKkFXrZocaPIJERLO+synNy6dXKHwSZDiy4xuAFpaC4cGcIo+3bEijcwrah3sgRDiXEUH/IUJc
 8D9jZ7VFtkTTnmvWWlX7rcSrk8AMPT16cFjrXi2Si5ofVB8lkvRMoUBczeQ2sn2m2GxaELWmdkY
 42JX0yVPBMJpnoHpsKy62X5E4zLRK0EW5jNwNtse/LhbWgk0WyRYFuuaHo4gNSJtr3CC+tJ2PN5
 21kgz8oVQhQ26BUf4Cfg7jlOoJw6GyG4hx/Uey3w5WPP4frNi0mEZfrcnIj2X2JHX9oleP6Vsst
 a9607vuv/KWrb05h0/QEHTPwSPJp2Op+N+R/QoB8gofQwDRfPWs366VWDrJrRuLkUVBwFCT8BIB
 e+6JAm26yzQ58arvfnXBBH04IqmwuU840gidi6RYzo5GmcvDFcOXQy/PwNGu4cq0fA+2b6PjOd9
 1i/Q=
X-Received: by 2002:a05:7300:7481:b0:36d:cd5d:d809 with SMTP id
 5a478bee46e88-37964ff2d6emr9111552eec.1.1794637551552; 
 Fri, 13 Nov 2026 22:25:51 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3795591f4f8sm13537585eec.13.2026.11.13.22.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 22:25:51 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH 1/2] drm/msm: Destroy the VM_BIND entity when its queue is
 closed
Date: Sat, 14 Nov 2026 15:25:40 +0900
Message-ID: <20261114062541.2001-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
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
exiting, instead of being left on the entity.

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
per-context list of them.

Not changed here: for a job that never ran, msm_vma_job_free() neither
unpins the BOs that msm_ioctl_vm_bind() pinned nor drops the GEM
references that vm_op_enqueue() took. That already happens to VM_BIND
jobs killed when the process exits, and with this patch also to the
ones cancelled by a fatal signal during MSM_SUBMITQUEUE_CLOSE.

Deferring drm_sched_fini() of the VM scheduler to msm_gem_vm_free() was
considered instead. It does not help: the stranded jobs keep the queue,
its context and the VM alive, so the entities would still have to be
destroyed at close.

 drivers/gpu/drm/msm/msm_gem_vma.c     |  5 +++
 drivers/gpu/drm/msm/msm_gpu.h         |  6 ++++
 drivers/gpu/drm/msm/msm_submitqueue.c | 50 +++++++++++++++++++--------
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030a..0cf518420656 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1499,6 +1499,11 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
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
 

base-commit: 1e59855738454b14021b64115f0090eafc7526ae
-- 
2.43.0

