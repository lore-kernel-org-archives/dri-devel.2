Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED63CA9ED2
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 07:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EBA10E4B3;
	Mon, 12 Oct 2026 07:32:02 +0000 (UTC)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB9310E5CE
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:04:37 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3ab752f6244so463966a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791644677; x=1792249477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aUdWymVuN1GgzXiVTLtzb4zC9ehLS9HDiJgUQVk5Mn4=;
 b=JxErr61oMeVGCREBBM9lyaWG3OBKWl3Jt9rcgeZkwOnWTHDHJQwRGwcDJ0itoHOuHC
 EddqPc+/Mimu2sDHh0vE7qHavt8gToTs0CfrwqwVpyDP3hCzjTShtEg1+z0GoaTYd5S9
 /JCNIZDGEOXzVZDJIJ7/1jF5CtKuYii9AtPFa+JZgL7dwy+XYrv7y1GmpAG9jTDVPlfV
 rk/65gaCWuqMTHBK3NDN5+9Chtgn1CIBQ0ENqrYSyZH0tcJQtJc+NaqQroBtYDngO5JZ
 ZaTs4+IUhG+xzIHtk/F6scNZvPYQRp7rQlyMQlzRZItEntfKuQkfSg6jdZF3H5v2MJrQ
 xblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791644677; x=1792249477;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUdWymVuN1GgzXiVTLtzb4zC9ehLS9HDiJgUQVk5Mn4=;
 b=mfkOqFER/wvabGMd5JqlKWRtWTY25KPkxb2dWzc8aC/pVYIfTUeoW31aieQArE42Wo
 /crl5oU910LniANqDeAvrpW2MfYe1bIo8auY/AEst05mKy4NmQJYEZRESOf+VR7hgiTJ
 z28r0WPCTIbryhAMyEKoyIyrdBd+W1jDVOt1XN9H5sPFqQcYx9XO/7DwFoWLvh5n6vB4
 1JIWqFHCK0F5WZpiid03loFAFgxYt+TBDo2HHmJgTHllD6szmLOG8EOWHOygvuCLwzjH
 0XJgLLPcX7seP2y+Ih+Z5l7IA8F3710qB9Tc+6ZxzfBG49iuHIRdyHgnB9Y5n8Zk4Zjq
 5miw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZIdl+YNYN/LLI9h2xLx/+/dwGbW5nljRK5ZNFHB7nN3VkSKVU/DfqVo1da/8uf1TLaAvTLCCJ3cU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK9DwzeLx4NkRfJdRcPMsx4ODLUPlOEtAZslGUucBufDMuaujOU
 NMSMObgg6Ke3NWbGYBoTxQhIX+xBT3EG+4p23j7Q6tTFcAom3cpesSokO4P7wKvL
X-Gm-Gg: AYBFou0md+wTZGcZH4S8zhByNy9rRrVIdGUMzUCICtBJpFrHS+t/eQ1wyglVNw1GZDV
 ATaUefRyHaG8S6TvuKk8Mu7NRoPIZQm+AD2wpwURzFJ8swR10sP6E7VzYaQvx4Zt55lG8Ll2966
 +qnKM91+kyCzLcnaNX3JLuBWgBtkjLYgWcBk5VjjVoqjflIEhb1V0bMbkSaVGUKwsmKAxgOnnq+
 f1+YY04f8RnGsH+zcE5hFx+IhaGRfHYV8ydrzhKeWRJfP1qMoI5Y45pSrOxwSQaUiwd5GaQ2JYI
 4i3sJvCZvh5Af1ZeEqTM8SqQB5jBT65YG4xDWTGm4AbAbFOV0ULouuLGG+ZE/YZSTpc+bTKTGTX
 81fSX/TZcknA3fw4K/c/zscAYeSp4Jp7dRHzDwuJAdYR5u75b+3uLaXtKZzHdq/Ks75ujRizngR
 8nE2nmKJC/9DKoEmrG0nClsQpW4cz9eCwg29QRl1q12qxV7R9iRr3ozw3TloMifxL2Xqpoog==
X-Received: by 2002:a17:90b:3b84:b0:3ab:1b19:78f4 with SMTP id
 98e67ed59e1d1-3ab3a3a11a1mr4404697a91.6.1791644676645; 
 Sat, 10 Oct 2026 08:04:36 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7a80:50::3cf:2d])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab397920b4sm4828242a91.4.2026.10.10.08.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 08:04:35 -0700 (PDT)
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
Subject: [PATCH v3] drm/virtio: share one vbuf cache across all devices
Date: Sat, 10 Oct 2026 22:04:29 +0700
Message-ID: <20261010150429.17036-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 12 Oct 2026 07:32:01 +0000
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
"virtio-gpu-vbufs" for every virtio-gpu device and destroys it from
virtio_gpu_release(), which only runs once the last drm_device
reference is dropped.

Two live virtio-gpu devices are enough to hit this: the second
kmem_cache_create() call finds the name already taken and
kmem_cache_sanity_check() WARNs. This reproduces at plain boot with
two "-device virtio-gpu-pci" on the QEMU command line, no sysfs
remove/rescan or held-open fd needed.

  kmem_cache of name 'virtio-gpu-vbufs' already exists
  WARNING: mm/slab_common.c:111 at __kmem_cache_create_args
  Call Trace:
   virtio_gpu_alloc_vbufs
   virtio_gpu_init
   virtio_gpu_probe
   ...

syzbot found the same WARNing through a different path: open an
fbdev node, then remove and rescan its PCI device over sysfs. The
drm_device reference the open fd holds delays virtio_gpu_release(),
so the old cache is still around when the rescan probes the device
again and calls virtio_gpu_alloc_vbufs() a second time.

Either way kmem_cache_create() still returns a valid (merged) cache,
so the device keeps working; the WARN is not a probe failure. But it
is a real defect: as the comment next to the check says, a duplicate
name "confuses slabtop, et al", and it is exactly what syzbot and
any panic_on_warn setup treat as a crash.

The vbuf size is the same for every device, so create the cache once
at module init and destroy it at module exit instead of per device.

Reported-by: syzbot+1b129b44597a126d2d79@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b129b44597a126d2d79
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
No Fixes: tag. I could not pin down which commit introduced the
dedicated per-device cache (dc5698e80cf7, the original driver commit,
still used a plain kzalloc() pool); happy to add the right one if
someone can point to it.

v3: back to one cache shared at module scope (Dmitry), not kzalloc()/
    kfree() (v2) -- kmem_cache keeps the allocation off the general
    kmalloc slabs for this latency-sensitive path. Commit message
    corrected: the duplicate-name WARN does not fail the probe (the
    cache still gets created, merged with the existing one), and the
    trigger is any two live virtio-gpu devices, not just the syzbot
    remove/rescan path. Tested with two "-device virtio-gpu-pci" at
    once, and with one device torn down and rescanned while its fbdev
    node stays open.
    v2: https://lore.kernel.org/r/20260927042035.19956-1-ngocthang2710.1999@gmail.com
    v1: https://lore.kernel.org/r/20260926162452.136863-1-ngocthang2710.1999@gmail.com

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

