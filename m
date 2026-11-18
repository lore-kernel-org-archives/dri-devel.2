Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D8606A336
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B1OYTHDe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9637710E72C;
	Wed, 18 Nov 2026 02:07:56 +0000 (UTC)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51E5F10E6DF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:07:48 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1397a4855beso13649c88.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794967667; x=1795572467; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=auMQLMVZW1hAksySChJapjBYGje9k4SG0oMAPhT3Wp0=;
 b=B1OYTHDeGe2HE5UcKluuwqWhoT6RmjZzsru8VUTJrTqPMY/DAI0zizCT0i7zqJDct8
 sL1GQuppuwoa9AiTsCNpKjRFWzEB7C5gaLWs3MlCtIP4HNbCg9YNvhR0OfJIf80jHqFk
 57DrDOoFHTSkOZv8NNK36A1RkZD3SrULzwkdH6iaxCzUklAJLLuQTEbzFgWrS4zDiqHW
 4uA2BdAGrYirCh+em2YhZGdQFfGwMBH1uA2T+WfiJMqnM6Dv8cL52jfUVNTAq4rOcwNj
 hAaG6xV8uOfRDd19exo2jZFz6iBvZuk4Ay4uLHSa4wHMh+OC79wLPTUjuuSAd5gg60To
 TgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794967667; x=1795572467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=auMQLMVZW1hAksySChJapjBYGje9k4SG0oMAPhT3Wp0=;
 b=fBXuRlTI1l72P/oiFQj5bzbvc+TTs/lN2h5xl/VoUlzbEm3GIuwPeJddlWD+ovYLkY
 uW4jvkXgBkhkbi30ZvBueo4WIE/2s/tBJneoOsq63PA6Df5vjyXCGuW/4mBGCM/EofjE
 peB0kHfvI3c1K3F7j5HedsAfuAIIVUd1hSJe70gKh3JNGoYzERA/jlHJQAWdh3mrBVAt
 TZxIB/mWw3FUCKjLjPNjyTwZ9l8TPOB2SEPR1x4bqjfsiX6xW10+Vb+PIL3kTusIQGMz
 zRVOiWkUvwIiiq7qX+Iruiq6MWMdFdUyhA/iwBaFhvRWNbXfuL4rqW0v4ReTNQnY6sI2
 cCAw==
X-Forwarded-Encrypted: i=1;
 AL+hErG+S4Jzb2d9CSNTTV/+6WrmUPXUSoCHWitqEKr15BLElAs83LRTDELNU7/8UD4G1xJ9QNkCwtF1xuY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9HrhqHpx0IvoPAFkDveLnRpnP2nT+dL70C+AjWhbVXt7c9vhPk
 GvVyGhQHw2goD3cOCsaFDQUjF1C+Se9+wm68LZJVLufav61L3o4HUBDD
X-Gm-Gg: AYBFou2iOU4JLQl99jd24abnqoTp/fM1AhD389lYA3NPu5n71BSPssMq8GmycIr75GJ
 eQBPy+r6M0HkwJXKjoL8JgoCv8+booCURIyFvFA44SdJ6a3oX6N8OHZGXU8ByqKoKWiR5YCsh93
 1FPrphH+LtvbTCKDdP/PzeVQCgxFynKl1FKzzioVBVAgCE0rUqpBy7OaKRrXFdaq37nw58FWcK4
 hJjKpU6KRmFUPSv3zWYIomvCdvB1AJEU3pLRqMoFgoCT8ocvgrfs23xsbSLiU/sr6leIH1oONpz
 ACndR4Ay5IU/pdRfjH6wEXbHt52NaVV/vQSeCh/y5eiJHLHBzoUpOr/Kgx2hw/bwM5/BOBLfph0
 2OsLuOhAlftdNGOJndrD20rnPVBdUU9LvJdk3snZDxkdy5+41D2nrj90iqskF9WH8WKNMjMj8pO
 1nwSGCo/6JLtFVdXYDDaOO/LU8vh1bBPSfvG9oN1LnBk/nZWOj96h24kDSp6z+c3I1ghhwr8Fw2
 igUhwyJyKr+N7J34VDicpM8y+Tx5xUIk8+RJwJ+AMVTeBrAq+aZAaMEk8C6/txlMlSZw6uBZZ5C
 8aPR5IOY6ASZ2Msb4hU+kQKcaFL3CRpnQvUt6qNZPVl9MlynBlH7bMrIvXB8IR44ShDDKoxH3Ao
 YMFs7zDM=
X-Received: by 2002:a05:701a:cc8f:20b0:1b5:4596:8371 with SMTP id
 a92af1059eb24-1b54596847cmr618875c88.0.1794967667440; 
 Tue, 17 Nov 2026 18:07:47 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 18:07:47 -0800 (PST)
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
Subject: [PATCH v4 4/5] drm/msm: Destroy the VM_BIND entity when its queue is
 closed
Date: Wed, 18 Nov 2026 11:07:15 +0900
Message-ID: <20261118020716.1698-5-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020716.1698-1-arpe1618@gmail.com>
References: <20261118020716.1698-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
file is closed, which frees its run queues. The submitqueue, and with it
the entity, is only destroyed on its final put, though, and every
VM_BIND job holds a reference to it.

msm_gem_vm_close() waits for the fences of VM_BIND jobs first, but when
a job is killed, e.g. on SIGKILL while the process exits, the scheduler
signals the fence of the job before it frees the job. The free can then
drop the last reference to the queue after drm_sched_fini() has run, and
the final put calls drm_sched_entity_destroy(), which reads the freed
run queue in drm_sched_entity_flush().

Destroy the VM_BIND entity when userspace closes the queue, on file
close or with DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE, instead of on the final
put, and refuse new VM_BIND jobs on a closed queue. In the
DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE path, do it after dropping ctxlock, as
destroying the entity waits for the jobs queued on it.

As a result, DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE on a VM_BIND queue now
waits (killably) for the jobs already queued on it, and a fatal signal
during that wait cancels the remaining ones, where they used to still
run. On file close, the jobs still queued when the wait gives up are now
always cancelled, as they already were when the exiting process had
been killed by SIGKILL, instead of being left on the entity. Cancelled
jobs apply their unmaps, release their pins and references, and mark
the VM unusable.

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 92395af63a99 ("drm/msm: Add VM_BIND submitqueue")
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
The scoped_guard() in msm_submitqueue_remove() relies on commit
ea69d489d3a6 ("drm/msm: Rework queuelock"), so trees older than v7.3
need a manual backport.

If DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE should rather not block, the destroy
of closed VM_BIND queues could instead be deferred to file close, e.g.
with a per-context list of them. That would also keep the ioctl out of
a killable wait for the queued jobs, which the freezer cannot interrupt.

 drivers/gpu/drm/msm/msm_gem_vma.c     |  5 +++
 drivers/gpu/drm/msm/msm_gpu.h         |  6 ++++
 drivers/gpu/drm/msm/msm_submitqueue.c | 50 +++++++++++++++++++--------
 3 files changed, 47 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index fd104e2cee35..c526409f451d 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1668,6 +1668,11 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
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

