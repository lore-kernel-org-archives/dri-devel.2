Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CFDC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4462310F072;
	Wed,  9 Sep 2026 09:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="exB6boDY";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57BC10F062
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:46:17 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso53646495e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1788947176; x=1789551976;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ej2jXznQ8MiiebMcPklRSS9215NaFP0hQU6L/r3E0Cc=;
 b=exB6boDY8YcdkR4fg6q0E2ZW2ZuqyLcKMRjgZZ3XlyKoHxdqZnEMox+KNNFkKaVMet
 GmfjtH+stJIqHjX3u7L5zRZIpVBP2r7RcKgkDG29NvK0tJCd0GkEFbg3IibYR+7X++1V
 dZTWYA6BrQTGDVMkXeffHS2zC0FjSsYxG59TpjLrxdmF7mzBKtlwT8Cm21Dm/IIV+6/t
 sU+2G2zzyv1//nKE091+qa0+gegZb3kqL4/M40O/PCWsvxYFcRmnYqvCmJFV1Ai5BlCN
 Cm5nRNr2/7zUDj/gJrUwwH/XH0KMUj4QPUe5XXPQnhYAdP/VSfQSxKfwn8xafkJB9zuD
 bXNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788947176; x=1789551976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ej2jXznQ8MiiebMcPklRSS9215NaFP0hQU6L/r3E0Cc=;
 b=IxjusVxqa2DHCiFfU25MZDjEQXUOCU/t1AzJz1eAxnSHBbXR6eX1pDtD5YIjJnO0Kh
 LCVlSybtesnGZT567tEg43lnb8Ypp5ujjSs+hY+VeU0TqnDaujgv8HL7iu41YoG0A7Yj
 nrbgESOyHOqHtnnWGi34zwRZGksDA+KimrOw/6cUA2OdHSrdb6gU68g8qYTup/bwgYAu
 r+6iavNnEgo4e31ZL6vvr37chVxhJ/3acj/7M7/EIEXLY+D0E21TbctkWXa+8GzpewX5
 aTUGPL+zwpXjbAnhcefLX+C0fWWjeUaq4fsUBCphzcHeWmLpjk3V7EyWfv2tKqDNf9Bh
 Js0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBybr+anZriHoB21hhnTZRJBRmxMXPlOY39R7YR8R0jtAa0kNGwV/GKZR40gmDkjGdl6C/t/frNjaho=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nbqoEdtktNgftwLPhbwHRJRSB1XlZI5boGv3cbAYKh5eC5QlB/
 JcDwk6Ci+8dhoUEevuijLgA97BjMeZEKgA0Wkd6mnLPXnNLrcY2ZF8iVh8ZLS4bKpA==
X-Gm-Gg: AYBFou2hVOdTXJ0DKvg9gDNF8Lo3oM1LBjtWgTrJ2ZTnVebQ6Hw1JLcTI4PYfM15bxR
 FVv0yRopkTMJ1RxDj6YPKF7Q8nQXF4c80u2uElNqBaqzGkF0DsklY9IWGtRH8PbXMv3cQHmhn67
 SzYgjmyhgG5UsiciCIqByYubdp2HZK0DGBMKV31YKu/vms8RUMQs4T1zORJwhMQdMLZgQmHkps+
 5LqEQ+JCQLoX4Dq/X1NKeFaWtBvzSJTgpkt1Qc+AJzGB91iYmXy5Qd2AtXj3dK4vbZG4pgN3SUV
 fWdVaM05KBSw4+EdZ0yWlwuoCFkmldJzUGozpR2ydKPnEVjuUi0Nh7dxW3UakfnO1hrwN8eA45w
 jGafXPngvF1ac+GgEbPWw046ZzMsoOvSLdeJyZBsX7bslGR4p682znd20DoasZOMwL62AYhG/Eq
 jwYETFgHUGK1QN+2KqOnzmIuBzLjd7QepkfUxt6dRPuLCb0ZHwGgvp3j+POzguhx5haQD8CjamB
 NV3yaVfTKHLMkqLScrVnZOJXJo=
X-Received: by 2002:a05:600c:8b48:b0:49c:fff9:f684 with SMTP id
 5b1f17b1804b1-49cfff9f6efmr260109905e9.21.1788947175442; 
 Wed, 09 Sep 2026 02:46:15 -0700 (PDT)
Received: from quark ([2a01:4b00:d309:1c00:7807:3ba6:3446:4db2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf772692dsm537897555e9.10.2026.09.09.02.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 02:46:14 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 kevinyang.wang@amd.com, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [PATCH v2] drm/amdgpu: don't migrate a dma-buf into VRAM while
 runtime suspended
Date: Wed,  9 Sep 2026 10:46:09 +0100
Message-ID: <20260909094609.1541-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909020854.58462-1-mike@fireburn.co.uk>
References: <20260909020854.58462-1-mike@fireburn.co.uk>
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

amdgpu_dma_buf_map() adds VRAM to the allowed domains for a peer2peer
attachment, so ttm_bo_validate() can migrate the buffer from GTT into
VRAM.  While the exporting device is runtime suspended its SDMA rings
are down and the move fails:

  amdgpu: Move buffer fallback to memcpy unavailable

An importer on a second GPU reaches this holding no runtime PM
reference on the exporter, e.g. a compositor on the APU submitting a
frame that references a buffer exported by an idle dGPU:

  amdgpu_cs_ioctl -> amdgpu_cs_parser_bos -> amdgpu_cs_bo_validate
    -> ttm_bo_validate -> amdgpu_bo_move -> dma_buf_map_attachment
      -> amdgpu_dma_buf_map -> ttm_bo_validate -> amdgpu_bo_move

Only migrate into VRAM while holding the exporter awake.
pm_runtime_get_if_active() takes a reference only when the device is
already active and never resumes it, so it cannot deadlock against the
reservation held across these callbacks.  That deadlock is why
commit 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference
when we attach a buffer" v2") removed the pm_runtime_get_sync() from
the attach callback.

If the device is suspended or suspending the buffer stays in GTT, which
remains accessible while the GPU is powered down.  A negative return
means runtime PM is disabled, so the device cannot suspend and VRAM
stays usable.

Fixes: 030631e97b20 ("drm/amdgpu: revert "take runtime pm reference when we attach a buffer" v2")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:Opus-5 [Claude Code]
---

v2: hold the exporter with pm_runtime_get_if_active() across the
    validate instead of testing adev->mman.buffer_funcs_enabled.  The
    v1 check was racy - the device could suspend between the test and
    ttm_bo_validate(), so amdgpu_bo_move() could still see the rings
    torn down.  Reported by Sashiko AI review.

Is this the failure that commit c52feb436539 ("drm/amdgpu: Disable
runtime PM for externally attached dGPUs") was working around?  That
commit explains how to detect external attachment but not what breaks,
so I can't tell which.

If it is the same thing, could the pci_is_thunderbolt_attached() ||
dev_is_removable() check there be narrowed or dropped on top of this,
so eGPU users keep runtime PM?

I can't test that here: this box hits the bug by missing that check.
The dGPU is on an oculink port off a native AMD root port, so
pci_is_thunderbolt_attached() is false, dev_is_removable() is empty,
and runtime PM stays enabled.

Reproduced on a HawkPoint APU [1002:1900] driving the display with a
Navi 48 [Radeon AI PRO R9700] [1002:7551] on oculink for render
offload.  Without the patch kwin_wayland hits the call chain above
within a minute of the dGPU autosuspending and the desktop stops
repainting until it resumes.

 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index b33c300e26e2..c89846f266d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,7 @@
 #include <linux/dma-buf.h>
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
 
@@ -189,14 +190,25 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		/* move buffer into GTT or VRAM */
 		struct ttm_operation_ctx ctx = { false, false };
 		unsigned int domains = AMDGPU_GEM_DOMAIN_GTT;
+		int pm_ref = 0;
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
 		    attach->peer2peer) {
-			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-			domains |= AMDGPU_GEM_DOMAIN_VRAM;
+			/*
+			 * Only migrate into VRAM while the exporter is held
+			 * awake.  A negative return means runtime PM is
+			 * disabled, so it cannot suspend either.
+			 */
+			pm_ref = pm_runtime_get_if_active(adev_to_drm(adev)->dev);
+			if (pm_ref) {
+				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+				domains |= AMDGPU_GEM_DOMAIN_VRAM;
+			}
 		}
 		amdgpu_bo_placement_from_domain(bo, domains);
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (pm_ref > 0)
+			pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 		if (r)
 			return ERR_PTR(r);
 	}
-- 
2.55.0

