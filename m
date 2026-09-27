Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95EDC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 245D410E84B;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NR2bBxVW";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A77210E23D
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 04:20:42 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so683716a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790482842; x=1791087642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eDCmetS7q26pDTAMQ+r7lMzCxwM1hYCU7lPFcoUtvfY=;
 b=NR2bBxVWZc4cEs0U/CLz1liFUYmPPQdyhrayTrIMRNW30+pwRO8leaUbz1EEZWsgd4
 aQc9fzFkhD5HAmxSvMYCSn/rTxp+kjc5/QEtYM8+69+kMrz79FCjdwuO8+aE2nl6Lms/
 ERbn44tllB4pzHmrPxuveOwRR3+VK8zRq7XPkA116XPX68ngmLx3tlPncFS9vr4hWaom
 4QH+s46XwIzbiQZnkLVide8dGkr6azhKYGOP+6+1jvQTxHm4XjZZLBI5f4as8QZuFjRm
 YlEqYRK/YX3U+b9E31ZOycWvwuXhNAdJB/dVgr1qGTsh5MfTNZFfOayjHjXJnDIqc9C8
 Zv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790482842; x=1791087642;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eDCmetS7q26pDTAMQ+r7lMzCxwM1hYCU7lPFcoUtvfY=;
 b=Js3g/jnYYRTAeFDUAzGzosr0GD9Or0Uy7+ovNOnGTWsReVSwQBT2P4f1qBgzqO8EeY
 3wnRZ1EpNzQwhvU+mdrgN5mXoBZ2kDjPASfbP/KumMju+fifk6n+9wsqDndYsK46LE9S
 4Hfv+vmTfoLoDqjFDRs05ztz4Ad8+Co1XOR7bm/bEjXZQpOhDoE5e5OGj75KAC1MLmMt
 cTeDnD/+/fgPlfDueBm9g8M7zNJT7Fv7KwWCGsCngqmq+ds39kicNRGyIH2TjcYO6ZcR
 qejpjf9Y6hOfCk5A1GUsOacw4eiH5IBsNCgpOQ7ZcD82v5DaWnzs4/bDoYeSRuWjquFp
 kHZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8y/tI0XA064t5UC7miHjUppO4SF9ZugDBKFU1YzXF3ThBUnr57JodBwlUgAKWSwwgALEHWlta5LY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJf6Lz02QkWuBCsRozOMefd+dua/lNka25Ye3/aawHb9cIFV9GD
 4wy56qZXg2jzGkN4LHetOPxuUbI+Zi+4zVhZawPMkDcsZQ37qdYGnjP8
X-Gm-Gg: AYBFou1QQ7s8rEeEiwq5GwJlrCwUkJ+YOhvcE39U7t84akMRrDHp3QuzDg64c5kWzDn
 ed2IF5IE7dcwnyCuKpUhDOf5QwGmmYeDDw25SNYajTLM9i1uSQKKwXMHrdfCtLRry3po7iA18SI
 b0a4RV7B9LQu+SaqZTp1hm5KytH1SZ6IdAJo/7oT2DAuKCDHLlDl3DwzfDJs61z9JUwefcR4zHt
 mEOAylLLhMgOhhF5/svq/r10u77y74SQWTlsa2Y/ennxFjpmeGVRsaGY0xvSVaufECgr7qJpu9M
 NX9jwRnVuhxEtW6Y9ndwRrTbZnumLSNQw/JimwdHYoAJndh4j38Uax7AftDeJ1Gryf0qj7Urp9P
 WoI3VmwjaFfi8BuBUg/KEa8LYququQOToFe5MGuLVy64nSNHH3mX0RSlfCMMJfkj/lCd5MVS2PC
 9bjxuGEDGrlsnQmw+CfSwMp+Ky3R91rLSk7lo1n/nPkaUQQ360tT1ZaLMlKOcR0IeQHZiSE4LuF
 eyz/RWLNmiU7PA/
X-Received: by 2002:a17:90a:dfcc:b0:3a0:cca0:4a8c with SMTP id
 98e67ed59e1d1-3a0cca04bf4mr2596078a91.7.1790482841989; 
 Sat, 26 Sep 2026 21:20:41 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b4f6345fsm5558223a91.1.2026.09.26.21.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 21:20:41 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Hillf Danton <hdanton@sina.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Subject: [PATCH v2] drm/virtio: drop the dedicated vbuf kmem_cache
Date: Sun, 27 Sep 2026 11:20:35 +0700
Message-ID: <20260927042035.19956-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

virtio_gpu_alloc_vbufs() creates a kmem_cache with the fixed name
"virtio-gpu-vbufs" for every device and destroys it from
virtio_gpu_release(), which only runs once the last drm_device
reference is dropped. If a reference outlives the PCI removal (for
instance an open /dev/fbN), a rescan probes the device again while the
old cache still exists:

  kmem_cache of name 'virtio-gpu-vbufs' already exists
  WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
  Call Trace:
   virtio_gpu_alloc_vbufs
   virtio_gpu_init
   virtio_gpu_probe
   ...
   pci_rescan_bus
   rescan_store

kmem_cache_create() then fails and the new device does not probe.

A vbuf is 216 bytes and lands in kmalloc-256 anyway, so the dedicated
cache buys nothing. Use kzalloc()/kfree() and drop the per-device cache.

Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2: (Hillf Danton) drop the dedicated cache and use kzalloc()/kfree()
    instead of sharing one cache across devices.
    v1: https://lore.kernel.org/r/20260926162452.136863-1-ngocthang2710.1999@gmail.com

 drivers/gpu/drm/virtio/virtgpu_drv.h |  3 ---
 drivers/gpu/drm/virtio/virtgpu_kms.c |  8 --------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++--------------------
 3 files changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9df4c7117341..2639d9ec0470 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -261,7 +261,6 @@ struct virtio_gpu_device {
 	struct virtio_gpu_queue ctrlq;
 	struct virtio_gpu_queue cursorq;
 	bool vqs_released;
-	struct kmem_cache *vbufs;
 
 	atomic_t pending_commands;
 
@@ -361,8 +360,6 @@ void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
 void virtio_gpu_array_put_free_work(struct work_struct *work);
 
 /* virtgpu_vq.c */
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev);
 void virtio_gpu_cmd_create_resource(struct virtio_gpu_device *vgdev,
 				    struct virtio_gpu_object *bo,
diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1d4d3bf46a20..047b591b5da2 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -264,11 +264,6 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 		DRM_ERROR("failed to find virt queues\n");
 		goto err_vqs;
 	}
-	ret = virtio_gpu_alloc_vbufs(vgdev);
-	if (ret) {
-		DRM_ERROR("failed to alloc vbufs\n");
-		goto err_vbufs;
-	}
 
 	/* get display info */
 	virtio_cread_le(vgdev->vdev, struct virtio_gpu_config,
@@ -324,8 +319,6 @@ int virtio_gpu_init(struct virtio_device *vdev, struct drm_device *dev)
 	virtio_reset_device(vgdev->vdev);
 	virtio_gpu_modeset_fini(vgdev);
 err_scanouts:
-	virtio_gpu_free_vbufs(vgdev);
-err_vbufs:
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
 err_vqs:
 	dev->dev_private = NULL;
@@ -365,7 +358,6 @@ void virtio_gpu_release(struct drm_device *dev)
 		return;
 
 	virtio_gpu_modeset_fini(vgdev);
-	virtio_gpu_free_vbufs(vgdev);
 	virtio_gpu_cleanup_cap_cache(vgdev);
 
 	if (vgdev->has_host_visible)
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d92..5eb78d69f561 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -70,30 +70,13 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
 	schedule_work(&vgdev->cursorq.dequeue_work);
 }
 
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
-{
-	vgdev->vbufs = kmem_cache_create("virtio-gpu-vbufs",
-					 VBUFFER_SIZE,
-					 __alignof__(struct virtio_gpu_vbuffer),
-					 0, NULL);
-	if (!vgdev->vbufs)
-		return -ENOMEM;
-	return 0;
-}
-
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
-{
-	kmem_cache_destroy(vgdev->vbufs);
-	vgdev->vbufs = NULL;
-}
-
 /* For drm_panic */
 static struct virtio_gpu_vbuffer*
 virtio_gpu_panic_get_vbuf(struct virtio_gpu_device *vgdev, int size)
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC);
+	vbuf = kzalloc(VBUFFER_SIZE, GFP_ATOMIC);
 
 	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
 	vbuf->size = size;
@@ -110,7 +93,7 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL | __GFP_NOFAIL);
+	vbuf = kzalloc(VBUFFER_SIZE, GFP_KERNEL | __GFP_NOFAIL);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE ||
 	       size < sizeof(struct virtio_gpu_ctrl_hdr));
@@ -205,7 +188,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
 	kvfree(vbuf->data_buf);
-	kmem_cache_free(vgdev->vbufs, vbuf);
+	kfree(vbuf);
 }
 
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
-- 
2.43.0

