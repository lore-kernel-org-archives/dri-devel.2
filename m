Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019501061B2E
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 11:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4CB910EB10;
	Tue, 31 Mar 2026 11:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V/ItdmvV";
	dkim-atps=neutral
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com
 [209.85.208.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1C410EB10
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 11:18:16 +0000 (UTC)
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-38cb8e42d1dso3491231fa.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 04:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774955894; x=1775560694; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rr4XYxZlbgfRszfW0peUqy8RdEvlcyzb6hrOTDVWLRU=;
 b=V/ItdmvV/WT2eQzBtgasskifjonRs0OwDDT+fwU32WZmPJDQP7hLP2Db6YT9Dx4L+F
 ll7sn+4au+EZeE8IPmqP2w4lfx/zwAsiIS8IxsAXJAtak9mkvZ2k3z8uffAlcw5KB+pk
 gI1GUQaY4bBXfQy2+H5OsXiHnXzAD+1T9v32iUs8K7akz4A56Ud8KOnV0H8UH/4QSgqo
 W6ET3Jgc7+Unn3tcEKczoscC64qEqP5tnKD7jYhBlEc7pZ9SkBEHat095eGWvx15YQ9M
 gI9MmkTKlZKcqc+H8jug9xakXIPxaw1EuVVsWeBXUnHVOPI+7dWCs18kXsqQ9MQFiMBP
 zXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774955894; x=1775560694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rr4XYxZlbgfRszfW0peUqy8RdEvlcyzb6hrOTDVWLRU=;
 b=Tv5R7H/sbrr7EQfvn9brz+KbY/HVfPhKJ5ttoVqCbzwgD38lYcwpkNlUe27bb16Ngi
 F0Q4tCIo/8PddcR1ecCYrEgJ8dckvAk88ijL0SrqZY8cqAsofriDVKkQvfnLgJYbhq0M
 WmkwTr9fFk8l2PvaybxtC7kcTJNVoR2Mz9LmU0Qb4Kv7ff3+tfwmIeJSSV+8xx2rTFpy
 j/Xp2Hs7E/d6uXphUaUQgnsYIUVSsC6HVHXAjgv/mYcCmixcQvYFTpc6jQovTzo2YsVJ
 cf/DjS888YHfsP0oarBlI8d0CFWFEZ7SJag1HehEL1F1Sl6Fdwh24TqvfAaq+aAmjYPx
 XxFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUncWsbFgsirMvIpYU7OchxNcgU5iMzubenWhIJIZrKPiRJhqUzzLU7oCSaOSta9KQbCp9GczHSlE4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNbdr1Ipi4ojKIYjcfE4dxyT4dPus/oKvi6Ezj8KmiYma1/Gp/
 3d8WlPxasdMpO2+xlZbNTXARz5UzaIq0FgzPXNTmM+hPwNeZHrLiL+Ad
X-Gm-Gg: ATEYQzzQ0B7YChJYW/TYldmeKe/ME7ss2vCNtemfk8PEwBu9WQ7kxH6IWDNzwUozzlL
 E7fKFARgclH8QprQmLzAwe7uFoZHDkDZUGeP9NGnG1EOXz0TrsSO4LdoX+Jqxdcbv7l+WHVEeHu
 8adejqv7N0lpeRYBqGhwE1sA5hL4GMyf7Dt/L0Zb7K/ahETGghup6LARTV7/dbepZdOcqm4KGVU
 J+3qHQEFgMplZ/esc4wMZLBPr3r3CDWSG5O1JlE3Tn1S6Ar9G0Jj5422H2VGxhNX9PM2Y4IDDGP
 pZ+mdqMmGfWzQAA45i/8dBKEKQ5drKyFscW393HfGWzxO7YIZ6Te9FAjUn7DDHZz2yG9N+vrncJ
 gvZ0M0lBYGY2/fvk6ylkK/+khxtdU86toh/68d1y4uj1s0mznYSVehBuBl8p4ej4CYqPuDYfTnE
 5Sx2wP7J+MiKfx+bnR0/IOgMDAGXn6KnTSRA==
X-Received: by 2002:a2e:bc15:0:b0:38a:3ad8:6f32 with SMTP id
 38308e7fff4ca-38c740b8c29mr55919451fa.30.1774955894075; 
 Tue, 31 Mar 2026 04:18:14 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c8389524esm20069411fa.21.2026.03.31.04.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 04:18:13 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v6] drm/amdgpu: replace PASID IDR with XArray
Date: Tue, 31 Mar 2026 16:17:24 +0500
Message-ID: <20260331111808.16578-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Replace the IDR + spinlock with XArray using XA_FLAGS_LOCK_IRQ (all
xa operations use IRQ-safe locking internally) and XA_FLAGS_ALLOC1
(zero is not a valid PASID).  Both xa_alloc_cyclic() and xa_erase()
then handle locking consistently, fixing both bugs.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
    so all xa operations use IRQ-safe locking internally.  Drop
    Cc: stable since the regression was never released to any stable
    kernel. (Christian König)
v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
    since xa_erase() only uses plain xa_lock() which is not safe from
    hardirq context.
    https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmail.com/
v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
    xa_lock_irqsave, as suggested by Lijo Lazar.
    https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
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
index d88523568b62..9f264d439f3d 100644
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
+static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1);
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

