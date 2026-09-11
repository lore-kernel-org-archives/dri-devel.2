Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7D0C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 23:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39B410F729;
	Fri, 11 Sep 2026 23:30:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="Th1kY6nD";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B053E10F728
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 23:30:02 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f91so53658f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1789169401; x=1789774201;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=maDR2aqOdsCxMDMhneCqVUg2ho2Vb3T2xTiPLWinbKI=;
 b=Th1kY6nD8/zuTndNzfhk7CsKrwkvjaAT2rsrZlGZHGkqCU1OYeKDywFiMLr0ul2zEO
 KzyhBdlWnsSp0xXWKKmxJTKrMHtw+csnOTx8ymgYpsUFDrolI/rIRx2xJBh/8L+d7huT
 v5zOqwkHTi/IiWLbyk1KbmwBMctJHnSmpCLi9sbtZ9nTvvUYYkbMFQzuBQPFKhl3hJKC
 Lq6IvcXp4XLJbwrnPzcrCnnVHpLennrL4zPd8N7Wu5TB/bS3Z40N4DohmGAq8ZEy7O/M
 YUObgBuk6IVvVGtn0SRib11kg0rtdfq/578UUrhenHVXKNJ9pZx7UmyW293eWaoOkKOT
 /MUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789169401; x=1789774201;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=maDR2aqOdsCxMDMhneCqVUg2ho2Vb3T2xTiPLWinbKI=;
 b=ber9DbfPwrhmEEUdMQ5cl36mhmZ1a5tYCicN+gWMvVDmFCffW1dWjXc3pksZSRQf1z
 rRxLAJ74TBNz9V5PBWXsD2t1RBaEFB6bhXi5xsYSI6d5hkOL8gyIJauM9PQgq3/PJFF4
 Ydxzla9YMiILoe1tigWX5IOSf16iwuWqvVKAI/UVaEzRHUa0YMDQZstYidPSM1JQWXnZ
 rnSCPUQXUzOX29KTBKNwZwUeJk47Ahvyp2NaJHCkliyDlumEih1+nEuU0rOQLEzeBQsM
 BcuELdR3+uHz5xhyAaqC9PwYE9VcblH5KUJvvgJwZEY0997DKpYQoVhawIhU4c6x13ue
 34bQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwn9lM8fWOhMPktXRH59HhklrqiyynM0LcHofSdlVYdCFF9Pg0j6vRaJVoA01ZAvSInzYI/gD3oytc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNDfg1WbTVyR+JLL2Ojit9XlQlcBeTksZlodJZ5bbzqI+xOQfq
 utIQii9812Akn1Zj6fY4/mO/pt6GxwkhHMLy8JxLnyohF4p7PCck4ur1oZE8tPAzDA==
X-Gm-Gg: AYBFou0R9t1QNOkpq9Ht6SxcVU1cZfvvKJgNyrqMKSD/aYpJNuSpHp8nvf660kGojjE
 w1evq5vJ5B1EMm6REq9IMqR9h38/LWklRhMrMoicFrFAr3iyNUkpog9zMPJzIktSSZRLgKIEF9v
 Wq69NbYP567S6BGJhKtHjBi97J4xWNd/vUicUAu9qW3Td0jcKSq6poH1hf3xMK6jHCdbI9sGqGz
 cLhNm/02Gp3b8YDWfg4OOSs+sn0Sy7RdVle7PghWvNahPHG6wyU0NhEnS9X3HiYLxXUIt36ITY7
 cPPVT2xBsRKBIdZ+viwfd1F7mfRy78bc4SzGZQe3p6ZIBM2bSDuMWCOQpVdel1ZhH6lsoJqz1on
 ytYigCkBtJhpQZ1gVGbRcgwitsUbybui1L/xq2FEISWBV50LCB1DmfoNtmFO67NvmKbkZhty5Bw
 4E4AFMmcI7TdIOb3Rw4p7vcZpgiL/AQ7238r0ilY2dMQFx2ZlBg4cXPMWGdWzPb+72OjDL7pqyc
 NNNVdXOf5MJqvfp6GZbHQ8G3D4=
X-Received: by 2002:a5d:5f91:0:b0:486:e6a2:2da2 with SMTP id
 ffacd0b85a97d-486f6bf0cdfmr584543f8f.21.1789169400567; 
 Fri, 11 Sep 2026 16:30:00 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm9136355f8f.20.2026.09.11.16.29.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 16:29:59 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 kevinyang.wang@amd.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH v4] drm/amdgpu: hold a runtime PM reference for P2P dma-buf
 attachments
Date: Sat, 12 Sep 2026 00:29:08 +0100
Message-ID: <20260911232908.1056738-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911183825.935140-1-mike@fireburn.co.uk>
References: <20260911183825.935140-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
attachment.  GTT is only a fallback placement when VRAM is preferred, so
ttm_bo_validate() migrates the buffer from GTT into VRAM.  While the
exporting device is runtime suspended its SDMA rings are down and the
move fails:

  amdgpu: Move buffer fallback to memcpy unavailable

An importer on a second GPU reaches this holding no runtime PM
reference on the exporter, e.g. a compositor on the APU submitting a
frame that references a buffer exported by an idle dGPU:

  amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
    -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
      -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move

Pinning a dma-buf into VRAM has the same requirement, which
commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
when we attach a buffer" v2") called out as the one case that would
need the reference back.

Take it in attach and drop it in detach.  pm_runtime_get_if_active()
never resumes the device, so it cannot deadlock against the reservation
taken during resume, which is why the old pm_runtime_get_sync() had to
go.  If the device is not active, clear peer2peer instead: the buffer
then stays in GTT, which remains accessible while the GPU is powered
down.  If runtime PM is disabled, take a plain reference so the put in
detach stays balanced.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

v4: take a plain reference when runtime PM is disabled.
    pm_runtime_get_if_active() returns -EINVAL then, and v3 left
    peer2peer set without a reference, so detach dropped one it never
    took.  Reported by Sashiko AI review.
v3: take the reference in attach and drop it in detach, clearing
    peer2peer when the device is not active, as suggested by Christian.
    v2 only covered amdgpu_dma_buf_map() and left VRAM pinning exposed.
v2: use pm_runtime_get_if_active() instead of testing
    adev->mman.buffer_funcs_enabled, which was racy against a
    concurrent suspend.  Reported by Sashiko AI review.

Reproduced on a HawkPoint APU [1002:1900] driving the display with a
Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
offload.  Without the patch kwin_wayland hits the call chain above
within a minute of the dGPU autosuspending and the desktop stops
repainting until it resumes.

Tested with v3: Chromium rendering on the dGPU and composited by kwin
6.7.5 for five minutes, then closed.  The dGPU stayed active while the
window was on screen and suspended six seconds after Chromium exited,
with no fallback errors or runtime PM usage count underflows.  After
an hour of yuzu render offload the dGPU also suspended once yuzu
exited.  v4 only changes the runtime PM disabled path, which this
machine does not hit.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 43 ++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..9adf3eed8822 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -100,15 +101,54 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
+	/*
+	 * Only allow P2P while the exporter is active, and keep it active
+	 * until detach.  With runtime PM disabled take a plain reference so
+	 * the put in detach stays balanced.
+	 */
+	if (attach->peer2peer) {
+		struct device *dev = adev_to_drm(adev)->dev;
+		int ret = pm_runtime_get_if_active(dev);
+
+		if (!ret)
+			attach->peer2peer = false;
+		else if (ret < 0)
+			pm_runtime_get_noresume(dev);
+	}
+
 	r = dma_resv_lock(bo->tbo.base.resv, NULL);
 	if (r)
-		return r;
+		goto err_pm_put;
 
 	amdgpu_vm_bo_update_shared(bo);
 
 	dma_resv_unlock(bo->tbo.base.resv);
 
 	return 0;
+
+err_pm_put:
+	if (attach->peer2peer)
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	return r;
+}
+
+/**
+ * amdgpu_dma_buf_detach - &dma_buf_ops.detach implementation
+ *
+ * @dmabuf: DMA-buf where we remove the attachment from
+ * @attach: the attachment to remove
+ *
+ * Drop the runtime PM reference taken in amdgpu_dma_buf_attach().
+ */
+static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
+				  struct dma_buf_attachment *attach)
+{
+	struct drm_gem_object *obj = dmabuf->priv;
+	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
+	if (attach->peer2peer)
+		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 }
 
 /**
@@ -350,6 +390,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
+	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
-- 
2.55.0

