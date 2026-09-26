Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FF4C9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A457110E8D7;
	Mon, 28 Sep 2026 08:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RupbaH/R";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ECC010E06C
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 16:24:59 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 d2e1a72fcca58-8804b59404aso708727b3a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790439899; x=1791044699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JxTb4rTnxrDZeiosOy7T/2r+lQDYr7z98o9aA1mZOX8=;
 b=RupbaH/RBQFCp/p8v7cB1kI1xUotP2Jr83f3xpaFG6Z8ZY9JYUkUspCUfF9959ZTbO
 9q4+AegVPxVWnWIXA2rQhJC5gYQDiw+0sTIFPVrvaxJp9Y1kO3a4KE5df5UvOrd1QR9x
 xNtS9I8nTUSZ4CdHg0soRefSW+CPVOl3Oj5XRHp8iRocFwdl3uqWTSNkfhci3j2Vg7Go
 AMLVcn2N9dQwB4rDZTkCdUMlL65+rSpiwNqGDxq9zaTZ6/k8TiuEuFy3NCJo5B0ojOy8
 u16DbB/jidM90Emp38dssSkcCsTSLsBkODzqJS6pmUin2+Ujy/o73+qxpeT8xXHr/fEo
 TeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790439899; x=1791044699;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JxTb4rTnxrDZeiosOy7T/2r+lQDYr7z98o9aA1mZOX8=;
 b=ivJKKfO0Kn146WlD/vrx+kl3UjGgWieV0GGiT7BqTjipDeJKSZNsgGckzFIMExFsxb
 kSjGQBtgR7cMpnJcoy4AuKcq8nQv6lzWmIut2GK4EowESuumcY4bjWRWAP601J1Euw6+
 lX57Nz103OGfmUbjcRnWag2/DxkmAYORfb4wk1hPccU1xy33jDpPC39K2FUTtvyXXjlH
 24yFbbzsa8fYGomxWeEygjXF8gvh44AW+4uTGI1Crsluk/ngvQiEwWjdPwBclsXHTu4K
 /7smI4Ze9Xry96BXn+JgC3Bx5XvQSRBPrz0+3r4WV/N3aGQMiWdgmimxi7CVY7D4Gql6
 DIUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpRb5MWHaXGceYlaDab6jFwC5HKqeRdnLtcTLpp6auOCNcGlQK56yRUGWmvJtPev/RT1ormzgePWg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ln3mBCENq9FJX1BiQ6Zd49g1fb+SVD3J322BUVBgBl5AIP3Kag
 xiFESq4ZPTGCvUPWFJ6shG21YoG0OAaxOXFS2RY8MKzbcUirG/2vLhe/
X-Gm-Gg: AYBFou2m8aIKnnw0f8CybGtvUATkJ4kNA4PAvVeKuMG/PV7h/xIVCHCOiiKYtwDp/LZ
 jeZKL6Mjmt1jRHp7eXq0dpQiOnJNdcM6u8hufuxe5uvTup7+l2/5QsS+JgJDUl1C9TZSxdDEHe7
 mjdE4+WirdvkXM17gBd9ue1wRCyBoOyrWLeu4I5CM5cB/OIrYfFxh0OBvvZhBfbCDZ1CEJ4RZ2/
 TbKWuRChoA1wfVsvU9eQ3krItkI9jV8Qzk+ZLf3NSxVIydQIQTj6fgD9lGiOFwo/vwPcY1aRhVQ
 DGjNxmiwFT9xDaDdjVlNfDXf3FL8VHt/82XePoTvcHI7KWHw/Fhl1cZl4O3Se5ptKZVZn7VyTqC
 nF1/tHdJmwJky2c4BaEYYxOVgmfHDmqKo6HgK0M8bdJOiYwPfZcTYL4+32TjdBp+2l62V2KPkbR
 PGuywGt1BoZr8jD7V4HgTLxwr8dacc7zxQ+cd40oT8nCVYYNPW7KADjTWp+w/1cEb4rBXMm+P6L
 kU37ynoJ65ZJT4DQtIGu5TsBzk=
X-Received: by 2002:a05:6a00:4099:b0:87c:3660:fa76 with SMTP id
 d2e1a72fcca58-87e9b69f43fmr6347352b3a.34.1790439898653; 
 Sat, 26 Sep 2026 09:24:58 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:a00e:c90a:972a:c5a2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87fea19800esm2323249b3a.10.2026.09.26.09.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 09:24:58 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Subject: [PATCH] drm/virtio: share one vbuf cache across all devices
Date: Sat, 26 Sep 2026 23:24:52 +0700
Message-ID: <20260926162452.136863-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

The vbuf size is the same for every device, so create the cache once
at module init and destroy it at module exit instead of per device.

Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
Fixes: dc5698e80cf7 ("Add virtio gpu driver.")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 13 ++++++++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h |  5 ++---
 drivers/gpu/drm/virtio/virtgpu_kms.c |  8 --------
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 26 ++++++++++++++------------
 4 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2aaa7cb08085..eec6f73a4c15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -283,6 +283,10 @@ static int __init virtio_gpu_driver_init(void)
 	struct pci_dev *pdev;
 	int ret;
 
+	ret = virtio_gpu_vbufs_init();
+	if (ret)
+		return ret;
+
 	pdev = pci_get_device(PCI_VENDOR_ID_REDHAT_QUMRANET,
 			      PCI_DEVICE_ID_VIRTIO_GPU,
 			      NULL);
@@ -291,7 +295,7 @@ static int __init virtio_gpu_driver_init(void)
 			VGA_RSRC_LEGACY_IO | VGA_RSRC_LEGACY_MEM);
 		if (ret) {
 			pci_dev_put(pdev);
-			return ret;
+			goto err_vbufs;
 		}
 	}
 
@@ -305,12 +309,19 @@ static int __init virtio_gpu_driver_init(void)
 		pci_dev_put(pdev);
 	}
 
+	if (ret)
+		goto err_vbufs;
+	return 0;
+
+err_vbufs:
+	virtio_gpu_vbufs_exit();
 	return ret;
 }
 
 static void __exit virtio_gpu_driver_exit(void)
 {
 	unregister_virtio_driver(&virtio_gpu_driver);
+	virtio_gpu_vbufs_exit();
 }
 
 module_init(virtio_gpu_driver_init);
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9df4c7117341..f6009fc8472f 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -261,7 +261,6 @@ struct virtio_gpu_device {
 	struct virtio_gpu_queue ctrlq;
 	struct virtio_gpu_queue cursorq;
 	bool vqs_released;
-	struct kmem_cache *vbufs;
 
 	atomic_t pending_commands;
 
@@ -361,8 +360,8 @@ void virtio_gpu_array_put_free_delayed(struct virtio_gpu_device *vgdev,
 void virtio_gpu_array_put_free_work(struct work_struct *work);
 
 /* virtgpu_vq.c */
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev);
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev);
+int virtio_gpu_vbufs_init(void);
+void virtio_gpu_vbufs_exit(void);
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
index c02c03c10d92..769b6e70feda 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -70,21 +70,23 @@ void virtio_gpu_cursor_ack(struct virtqueue *vq)
 	schedule_work(&vgdev->cursorq.dequeue_work);
 }
 
-int virtio_gpu_alloc_vbufs(struct virtio_gpu_device *vgdev)
+/* Shared by all devices: a per-device cache would collide by name. */
+static struct kmem_cache *virtio_gpu_vbufs;
+
+int virtio_gpu_vbufs_init(void)
 {
-	vgdev->vbufs = kmem_cache_create("virtio-gpu-vbufs",
-					 VBUFFER_SIZE,
-					 __alignof__(struct virtio_gpu_vbuffer),
-					 0, NULL);
-	if (!vgdev->vbufs)
+	virtio_gpu_vbufs = kmem_cache_create("virtio-gpu-vbufs",
+					     VBUFFER_SIZE,
+					     __alignof__(struct virtio_gpu_vbuffer),
+					     0, NULL);
+	if (!virtio_gpu_vbufs)
 		return -ENOMEM;
 	return 0;
 }
 
-void virtio_gpu_free_vbufs(struct virtio_gpu_device *vgdev)
+void virtio_gpu_vbufs_exit(void)
 {
-	kmem_cache_destroy(vgdev->vbufs);
-	vgdev->vbufs = NULL;
+	kmem_cache_destroy(virtio_gpu_vbufs);
 }
 
 /* For drm_panic */
@@ -93,7 +95,7 @@ virtio_gpu_panic_get_vbuf(struct virtio_gpu_device *vgdev, int size)
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC);
+	vbuf = kmem_cache_zalloc(virtio_gpu_vbufs, GFP_ATOMIC);
 
 	vbuf->buf = (void *)vbuf + sizeof(*vbuf);
 	vbuf->size = size;
@@ -110,7 +112,7 @@ virtio_gpu_get_vbuf(struct virtio_gpu_device *vgdev,
 {
 	struct virtio_gpu_vbuffer *vbuf;
 
-	vbuf = kmem_cache_zalloc(vgdev->vbufs, GFP_KERNEL | __GFP_NOFAIL);
+	vbuf = kmem_cache_zalloc(virtio_gpu_vbufs, GFP_KERNEL | __GFP_NOFAIL);
 
 	BUG_ON(size > MAX_INLINE_CMD_SIZE ||
 	       size < sizeof(struct virtio_gpu_ctrl_hdr));
@@ -205,7 +207,7 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	if (vbuf->resp_size > MAX_INLINE_RESP_SIZE)
 		kfree(vbuf->resp_buf);
 	kvfree(vbuf->data_buf);
-	kmem_cache_free(vgdev->vbufs, vbuf);
+	kmem_cache_free(virtio_gpu_vbufs, vbuf);
 }
 
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
-- 
2.43.0

