Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E544C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C220710E2A4;
	Fri, 11 Sep 2026 18:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="AJbyT9fk";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86E510F6B9
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 18:38:34 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so139851f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1789151913; x=1789756713;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bIN1MnaZoYO+k9IvdVDRKIgD4gsx81w6whboS0Ne+GU=;
 b=AJbyT9fke3mYTu2Z/UU2Gx7pq8xKNF1R5MlM+2/dQfyQs4kCJeKidJe91Tp62R/Weo
 g3EY4A37MbVl7mU6iwSCnJhSrq2390rEO0j+rRnKbUzsdfWJTJBhjik98TBV2u40O2S9
 6quVSI6QZxsUdSUH5bILhwsY0rpYyJzDFwSnQRCygBo4R1y1sIhyf6J/zNNITXk3eKea
 0joxusC7O4qOtUq8vBLtQbYBOMlDd0b1WnA/6pf2pQv2bRyjI+SBcp0tsvnYsFXUf0AB
 W82AZSYVILx5EsO3bzz7mBu12I1kqTyi5bBo6QeNe8tgGdfOnRdx6x6/Z0sJJly/TIXz
 hMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789151913; x=1789756713;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bIN1MnaZoYO+k9IvdVDRKIgD4gsx81w6whboS0Ne+GU=;
 b=ANuzHeZcU8ur6D6BVbIJs4atTEAGNAwCaMPBWXMM6YJFXwwrP/g1MzI2SpR/SG0aap
 2n2uzRQaUkPXP72yezOL0y0ngCb9KDNzeEksK6JaLpO0NOzA+wIgI+IdWRVFF77NJCI1
 r/I9q4TlODSPwAmLupyDjtPqRNLOo96I4CS2RZxDimv7youyvjDB7ij6MDJZfWjF9U8m
 H+3MkzUdc/spXSxstDAS6M3aP20RANZX3w+AtRRxcHdp4MYrKSeQM7vxdk85Ap/BVWhi
 oNQJ9d9WxxU/C3XzNLCO3PG4u1ITXA/ktsVAd5VWerNOkP9hu0iwXjhcP13cgWhQo+V8
 TFRw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6mlcS/6GvUjrR/MP9qwqYwRjCOQBhkl/bP+uK1VBoONr/s/cj3E6ORM8LZip/j0xNLMrdfzrg4gA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mLBhY6GJqKrJp6cPDb5hHIQ1NHk8CjZb2uyCSDpDRvwiydDWHv
 NX/mDKsbP04WCVOBF1XKtAQpGj2Q0oW13oO/WXz3lKc5LQD9xXMatcwbKp1HZgdpeA==
X-Gm-Gg: AYBFou1MSljdjC/ccBAWXllnfEE2hdD3i3B0OKkMoD2QTHPESCBSBDkk7XzVxJxdg+M
 Ke8CtC3JY3toIacztaSza9+CidLP8lhDIDtMiXTkLL+6j5BM0nZoaRUi9Uh3Jyu0iR6itUR/B5p
 HZ5S+OptDxPKpZU7WDSHapvYsB+7pNCW7mRJXNokIJDKkTEURUZxWDi8KlIUwgQOjYHLf0jbWc+
 eInqeqgQ4elQp5up0/zgyjLE8P8AOK1pqacLfv+QUpPl6GgPk0JlkYsR+PCVK/XyE6gLCo0WGCF
 zY/l71pBuqKsymQJZiilZAmG2H0qNL9fcZsTKd1wJsP4bZMqHNpw3vbT2oDCLB3pO/5oyea1JTe
 ytaqhMtdKYVfAtKyI8d+8e6RHV9gwiKr4BAtcmWqvzCSqEPRsvSo5xhdLak14O/V9umhFknZLut
 4nrAg993DzBDah3roruDwIfODVvdEYo5Bv6RwC5nGC/ZabLs6OtH7a9KqlaTtW1t8jxN4HABqWk
 79lUS1XcyuYQoUqIhgaujUqSdm/
X-Received: by 2002:adf:e991:0:b0:486:e8fa:f9b7 with SMTP id
 ffacd0b85a97d-486eb31a264mr11917325f8f.13.1789151912576; 
 Fri, 11 Sep 2026 11:38:32 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34e608sm8204290f8f.23.2026.09.11.11.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 11:38:31 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 kevinyang.wang@amd.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH v3] drm/amdgpu: hold a runtime PM reference for P2P dma-buf
 attachments
Date: Fri, 11 Sep 2026 19:38:25 +0100
Message-ID: <20260911183825.935140-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
References: <358a518d-1490-40ba-bbe3-7f3696c1d696@amd.com>
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
down.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

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
exited.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 39 ++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..fae695c3e531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -100,15 +101,50 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
+	/*
+	 * P2P access needs the exporter awake for the lifetime of the
+	 * attachment.  pm_runtime_get_if_active() never resumes the device,
+	 * so it cannot deadlock against the reservation taken during resume.
+	 * A negative return means runtime PM is disabled and the device
+	 * cannot suspend, in which case the put in detach is a no-op.
+	 */
+	if (attach->peer2peer &&
+	    !pm_runtime_get_if_active(adev_to_drm(adev)->dev))
+		attach->peer2peer = false;
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
@@ -350,6 +386,7 @@ static void amdgpu_dma_buf_vunmap(struct dma_buf *dma_buf, struct iosys_map *map
 
 const struct dma_buf_ops amdgpu_dmabuf_ops = {
 	.attach = amdgpu_dma_buf_attach,
+	.detach = amdgpu_dma_buf_detach,
 	.pin = amdgpu_dma_buf_pin,
 	.unpin = amdgpu_dma_buf_unpin,
 	.map_dma_buf = amdgpu_dma_buf_map,
-- 
2.55.0

