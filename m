Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5B61061B07
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 059F010E632;
	Mon, 30 Mar 2026 14:50:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B5au7j+Q";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4417410E632
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 14:50:56 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-66ba9dfe83bso2445104a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774882255; x=1775487055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=iEQgyKbT1VQKSh6QDXL908TnF5Z4/wgCTC4niu9wvmY=;
 b=B5au7j+QS6+AwFpgbjw/Eanpic1ynQyJcX8vtWUY6PPWbkn3fSJpy9u6hdEb8EFyAz
 59++Cv3qoSElMjP+8TcBMXeIWpzSLcce7XdkJI96KW6PPRUTvU10zhB3r8793gSAtTSr
 C3eqWDPOQFDvJ06f89V1E4HvawTYUdWXl4YagUlSHCV+pjD9xbd9iZijSpjzDAdK4kB6
 +crS2sVlF2u9MTeO7gL7fWeAyjcd8jWfX2zUMQNt32lHgkRfDt8qtePw4kzJl8dVDpNv
 EY/iYTaP+Q9gIudKOzLTNevVOK0luS1qGpBHsuEy0GPyKOYTevV2abbo/+rXSiIscvRI
 79Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774882255; x=1775487055;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iEQgyKbT1VQKSh6QDXL908TnF5Z4/wgCTC4niu9wvmY=;
 b=perjbq2DoxrbggHFW5d2iiZEE8t4ECs/5FkVXmF5Ho7k5pVZnVABhhP86ZhxayRuw2
 MKQIqh3JXsoLS8vt2cOPeHPbVJNkV2AfULTOJ6Yv7LDu1SmrFye6OLfoJkRN7eddihjn
 MtZngaVN9g/7nWOHNTcurEBcpVCgvuWO1GvIYZSGRSTfGMKVsD51A1fECY+Dep5t7kF8
 kLZd0vnNk8YsiDM3y6xUb928uvTdotEe6XbXcPJK0L5v93EBOU3pF7FAtorEeYQuDPsV
 wiiJjJL8K6A3pgtOraGIQOCWvsDC1fnz+/aEG6etgT0na3QfyaYlWQ2vAtTaFT4F6x0L
 Au9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaYNgrAzT+fgN1ij8E/a3Flep+OH+xjBy4DbWUINND7A9zEYEv07hMFcn47vfTs5adtXXdnfg18/4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YztfoClEUGZaGkbAPx/2RbqlISwEiKbjY8is4VbTIFWkPYl+yDi
 NZYA+B3UHIE1ijnOqy669pPWEDgKmD68vfWtuoXg+Tryrkeqnf3eXeYg
X-Gm-Gg: ATEYQzxPSj0UFvRxcBNmnOmsbq3HO4thJJtsLX+aS/DA55ouR7f6H6TWCWhupuV90nP
 rfvV/c3KAhTJL12LM3JkyT0Jo4qb3/1wSgAeH26Q2rUvoUEful/MPf1xgRRh57TywjRFzHzQ+LO
 ab4XWNmcrF5Xpjcsf2oP9LyepRHCWTAzsYqUwxwjnZN/i+GYEkHsCgNTiRBHPw3M5GFYx3+ECmt
 Ib11Sj6CjdANoU/TWLQ3XsGPGQbgHVgiWDWz7YTIQnH8rbYFSTOPUtQafRN94CZfW3jR5RZBbi6
 9l4hG3voFX2ps2xM0zIn0YcEXjZyQoLjgJAdYHJQY0ZiMRWZ01Nwq8asL2c9z4B/lOO116cmeig
 L48VFvyz6GkJGU/9C57goGDYZ68gGERORs/Jd3YUxAmdVyOSnZBZWlhzInI6ZgPvXCAfOMu0FQK
 jrKtA+FtEpivUlAhcoNU9f0XaGDa+5Fmvf3NNxO00wg1c=
X-Received: by 2002:a17:907:2d8d:b0:b9b:207c:f7df with SMTP id
 a640c23a62f3a-b9b507a92c1mr792638966b.29.1774882254394; 
 Mon, 30 Mar 2026 07:50:54 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-66b7340cae2sm2848609a12.11.2026.03.30.07.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:50:53 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v4] drm/amdgpu: replace PASID IDR with XArray
Date: Mon, 30 Mar 2026 19:50:49 +0500
Message-ID: <20260330145049.21936-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
converted the global PASID allocator from IDA to IDR with a spinlock
for cyclic allocation, but introduced two locking bugs:

1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
   which can sleep.

2) amdgpu_pasid_free() can be called from hardirq context via the
   fence signal path (amdgpu_pasid_free_cb), but the lock is taken
   with plain spin_lock() in process context, creating a potential
   deadlock:

     CPU0
     ----
     spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
     <Interrupt>
       spin_lock(&amdgpu_pasid_idr_lock) // deadlock

   The hardirq call chain is:

     sdma_v6_0_process_trap_irq
      -> amdgpu_fence_process
       -> dma_fence_signal
        -> drm_sched_job_done
         -> dma_fence_signal
          -> amdgpu_pasid_free_cb
           -> amdgpu_pasid_free

   This was observed on an RX 7900 XTX when exiting a Vulkan game
   running under Proton/Wine, which triggers the fence callback path
   during VM teardown.

Replace the IDR + spinlock with XArray.  xa_alloc_cyclic() handles
GFP_KERNEL pre-allocation and IRQ-safe locking internally, and
xa_erase() is already IRQ-safe, so no explicit locking is needed.
This fixes both bugs in a single, cleaner conversion.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
    xa_lock_irqsave, as suggested by Lijo Lazar.
v3: Replace IDR with XArray instead of fixing the spinlock, as
    suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
    lock inconsistency (spin_lock -> spin_lock_irqsave).
    https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
    using idr_preload/GFP_NOWAIT.
    https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 43 +++++++++++--------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..2b63b54eaaa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -22,7 +22,7 @@
  */
 #include "amdgpu_ids.h"
 
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
 
 
@@ -35,13 +35,13 @@
  * PASIDs are global address space identifiers that can be shared
  * between the GPU, an IOMMU and the driver. VMs on different devices
  * may use the same PASID if they share the same address
- * space. Therefore PASIDs are allocated using IDR cyclic allocator
- * (similar to kernel PID allocation) which naturally delays reuse.
- * VMs are looked up from the PASID per amdgpu_device.
+ * space. Therefore PASIDs are allocated using an XArray cyclic
+ * allocator (similar to kernel PID allocation) which naturally delays
+ * reuse. VMs are looked up from the PASID per amdgpu_device.
  */
 
-static DEFINE_IDR(amdgpu_pasid_idr);
-static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
+static DEFINE_XARRAY_ALLOC(amdgpu_pasid_xa);
+static u32 amdgpu_pasid_xa_next;
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
  * amdgpu_pasid_alloc - Allocate a PASID
  * @bits: Maximum width of the PASID in bits, must be at least 1
  *
- * Uses kernel's IDR cyclic allocator (same as PID allocation).
- * Allocates sequentially with automatic wrap-around.
+ * Uses XArray cyclic allocator for sequential allocation with wrap-around.
  *
  * Returns a positive integer on success. Returns %-EINVAL if bits==0.
  * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
@@ -62,20 +61,22 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_KERNEL);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+			    XA_LIMIT(1, (1U << bits) - 1),
+			    &amdgpu_pasid_xa_next, GFP_KERNEL);
 
-	if (pasid >= 0)
+	if (r >= 0) {
 		trace_amdgpu_pasid_allocated(pasid);
+		return pasid;
+	}
 
-	return pasid;
+	return r;
 }
 
 /**
@@ -86,9 +87,7 @@ void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_erase(&amdgpu_pasid_xa, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -625,13 +624,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
- *
- * Cleanup the IDR allocator.
+ * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
  */
 void amdgpu_pasid_mgr_cleanup(void)
 {
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_destroy(&amdgpu_pasid_idr);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_destroy(&amdgpu_pasid_xa);
 }
-- 
2.53.0

