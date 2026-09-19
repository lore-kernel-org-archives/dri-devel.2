Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F15C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FEB610E440;
	Mon, 21 Sep 2026 07:00:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XW9zq14J";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8FC310E53F
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:34:41 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccd4f99dso2027816a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789857281; x=1790462081; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bwQ10vDhFAWwDcYIO9V2fABJxs02GOextq4IhPQqc6k=;
 b=XW9zq14J7IWdZJcGs/8CsuhnEtRjg+NyLm/J5bwe++o0Bn+0EaW6SLvWkuk1Lm+Bsr
 xuCP9gRNnSjTNufxv7gRnY3ft7CrHxcjjr+eU4SB1WjerEP8nwf2BBr530o7hlPuA75R
 KHCNb6zTsKgwiNUxOmA0bTValFulCB974zgAd50yeGNATsFtnQOB3X8MtvCYAbbNxVE0
 Y5QeSJYUpZ/y4DNXOk+U9Ci0P3QQL2SkRWurLV/JTCNfPyLKOXx60/o8emFp+sMS4A0v
 huxPrC2V6y8Jq5iVQ6CjJMAQOiyfMJyyyDjExrpD4A+64k0/WvLe8hchu4lOM8W6TkVP
 e6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789857281; x=1790462081;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bwQ10vDhFAWwDcYIO9V2fABJxs02GOextq4IhPQqc6k=;
 b=cQXZFI2GNueu7CXGZ7TyivZG5WxwxXyJdI3PJIYPSo0UgWQ3PnvYp70yBjkbo8HS+f
 DUOS+tQdj/1Gz+adLfEWRDmwYjUfYkitU8z3Hd+yyT1eBnxuPzIVWZoErqCqvkspy62D
 Jr838J3OUX7GFpsadP9c5bNidhYK505xuIqs741pMDvP2F+5YQTtEr3c/jOCdAqaVVlc
 0/fAgKpdSPHJXipqyyBT/Iq5vuT+zPpAISJ+o+03bZDT9Q661Bto5Gv7o8b/Rlq4/NoU
 SwaQXBlrE6XUJ122wosCEadldAwumdAzbb5SicgRa8mImy/Zt7SS0TFYrQ0sKoFAQsJY
 f4oA==
X-Gm-Message-State: AFuF++mqdCBEC0Pl3mV3pzGFC498+0r4OJMJtj/rSlkvdAxDbsfQEvM5
 JjnFs0F+7HK2Tt9d/VhLLVUobIax0BqBJI+19zNfWP27lPeIh2w9sbVi
X-Gm-Gg: AYBFou0ncT/TW3M+Wf2O6cq/pcdf5VzzO0oq3AvhRZfTA/YdBh2IQ2qBA2ytncx3VMR
 6Kig8ahIA8BvEaa8FQwYc4FO3Q+LvOtBDzLQ+R89e+Y2q7B37foZndDD8NLhmUiqHKe69r/Wfzw
 dl+K7qvxOMKUIhfqwQ/Gf0t9dkIdvcQWBEKou+4Ocis51NNp4Hsm0DIQeRX+2NcOvCLJdOMef9Q
 APbbWK+sf48SaWw4lnupV11VknhDPtV2Sg0i4VeR2KQN+g05CTo9pEj/KHD6gew7xGWbqmejKGh
 5PquYXfp8YaujDenej8BtnWlAF5BltoIytRmI9c+9NpAPD4Q9BSH2q8+I9Hq+n9wZFLeOsUJj85
 pgJhyH3nur/MG1VG6cXVzfE7Vu8gzu3R0ZqT9MCABwfqhMaezTl9wolC4cgzTE2RqCbluGDU8di
 LBSsNQLoPSOj2/84p7AoigvXCwFOC/knQB7i3ChQ2uJ9veVwZTkIciJ1e6VxU/TG8/bCad+PYL8
 lVHrEeg4l3iWxEz6naIJanGT+hHF0AiJr3z9RKSxr3M+6BrcRjaYFdQWHLOT/yKCWWUhpfi15GT
 xpNx6SkWWg==
X-Received: by 2002:a17:90b:39ad:b0:39e:6c69:9b95 with SMTP id
 98e67ed59e1d1-39e6c69b29dmr4693412a91.58.1789857281154; 
 Sat, 19 Sep 2026 15:34:41 -0700 (PDT)
Received: from phui-2.c.googlers.com.com
 (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a02526e27dsm1943501a91.0.2026.09.19.15.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 15:34:40 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: airlied@redhat.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com, tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/virtio: fix vbuf->objs double-free, fence NULL deref,
 and sgt error path
Date: Sat, 19 Sep 2026 22:34:39 +0000
Message-ID: <20260919223440.3884176-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 21 Sep 2026 07:00:14 +0000
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

Fix three error-handling bugs in drivers/gpu/drm/virtio/:

1. In virtio_gpu_dequeue_ctrl_func() and vbuf cleanup (virtgpu_vq.c),
   clear entry->objs after freeing so objects are not double-released,
   and fix the vmalloc_to_sgt() error path.
2. In virtio_gpu_cleanup_submit() (virtgpu_submit.c), cancel and free
   out_fence->e when submit fails before drm_event_reserve_init()
   completes.

Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 32cb1e4aa425..84aeea58c700 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -343,8 +343,14 @@ static void virtio_gpu_cleanup_submit(struct virtio_gpu_submit *submit)
 	if (submit->out_fence_fd >= 0)
 		put_unused_fd(submit->out_fence_fd);
 
-	if (submit->out_fence)
+	if (submit->out_fence) {
+		if (submit->out_fence->e && !submit->out_fence->f.seqno) {
+			drm_event_cancel_free(submit->vgdev->ddev,
+					      &submit->out_fence->e->base);
+			submit->out_fence->e = NULL;
+		}
 		dma_fence_put(&submit->out_fence->f);
+	}
 
 	if (submit->sync_file)
 		fput(submit->sync_file->file);
@@ -415,6 +421,9 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 	if (err)
 		return err;
 
+	if (!exbuf->size)
+		return -EINVAL;
+
 	submit->buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(submit->buf))
 		return PTR_ERR(submit->buf);
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d92..115156a680bc 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -202,6 +202,10 @@ static void *virtio_gpu_alloc_cmd_cb(struct virtio_gpu_device *vgdev,
 static void free_vbuf(struct virtio_gpu_device *vgdev,
 		      struct virtio_gpu_vbuffer *vbuf)
 {
+	if (vbuf->objs) {
+		virtio_gpu_array_put_free_delayed(vgdev, vbuf->objs);
+		vbuf->objs = NULL;
+	}
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
 	kvfree(vbuf->data_buf);
@@ -282,8 +286,6 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
 	wake_up(&vgdev->ctrlq.ack_queue);
 
 	list_for_each_entry_safe(entry, tmp, &reclaim_list, list) {
-		if (entry->objs)
-			virtio_gpu_array_put_free_delayed(vgdev, entry->objs);
 		list_del(&entry->list);
 		free_vbuf(vgdev, entry);
 	}
@@ -517,6 +519,7 @@ static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
 			if (!sgt) {
 				if (fence && vbuf->objs)
 					virtio_gpu_array_unlock_resv(vbuf->objs);
+				free_vbuf(vgdev, vbuf);
 				return -ENOMEM;
 			}
 
@@ -1409,8 +1412,7 @@ virtio_gpu_cmd_resource_assign_uuid(struct virtio_gpu_device *vgdev,
 	cmd_p->resource_id = cpu_to_le32(bo->hw_res_handle);
 
 	vbuf->objs = objs;
-	virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
-	return 0;
+	return virtio_gpu_queue_ctrl_buffer(vgdev, vbuf);
 }
 
 static void virtio_gpu_cmd_resource_map_cb(struct virtio_gpu_device *vgdev,
