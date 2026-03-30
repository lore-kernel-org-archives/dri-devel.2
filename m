Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE221061B1C
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 19:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E8010E692;
	Mon, 30 Mar 2026 19:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A0476hLy";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E8110E759
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 19:11:28 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-b9358dd7f79so883210266b.1
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774897886; x=1775502686; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6a4ZAZ+tx15YWcQtSZ0Ur1vxlfH/UsJLxqB03uCLMU=;
 b=A0476hLyGOCx1rw3Lasi2UNr51qrw4uoH7+j4NqcGhtuKApkJali5XZdt2TXXal/kc
 MCVQEn3kz94kGaFT6bZnGr+t+v0xoT/ve0a3n5XcF8SsGYh3chchEcV7pJrg0uhtonJD
 1LAzCaA1gPINhGV2ya6LADwlFDZy91e/ICROogiYit9rT/+7FaJdOBbG2eoAZpbbExF5
 29EXCiwTcRze9w4VunRFmJ1ZPfp63pLbSNR5vglSZ0ErsF5XY7g5OnhAz1ZehPccf1bg
 lOGrCjdPOg1iBQkT143e3eqfqnzZqryYfWQizKgMUcTZclSEOMHqsLb3rfl2JmxHoVVB
 5Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774897886; x=1775502686;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6a4ZAZ+tx15YWcQtSZ0Ur1vxlfH/UsJLxqB03uCLMU=;
 b=e5gntPBf4AFk5TlNOjwbZWX7ZoEt/ErjDl4mw6sFM4h2GTb+VbhTAANJh6nPITF/RO
 JQlC3PcRpAHlOUrSBNrAos+8s5wi0I4z4YkPqKK+569J/Vw+VuIWyM+UMVqcmejmDDis
 OmJiHOSM4U/dJ7sjcyBz+BmVOhNxNxJjFUsd9Viq8ZcEqooI98yFr6SyUjwBpjFxOItk
 DM6ntATnrjEaV4zxUWX92ledVJxz4I+pfxW7Ff+ujEMUh5HL/PvQD1fYH/cpizzPAEGY
 dn6jt7o/Eu2T3qIU0lqIRLuYKnbg7fUqDj2Up44IVfIXOSC8VJvOK8f1I9WrOx/14qFY
 d9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV90+bROlnQZAsidIz6LzFwH4XsDT5GVAsaSU4RTaZHWNst7CeMzH6TcHO/HVC/UdnZZUoEaKRxjoI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhPMU7V9kUXBVHbVRP0WLiYeLVNJFk5b5aiFFuJaCUW97xTix3
 cWuc9PaRW5uzibldzymv2bTiqZXlRxhJMKKPdclWZ0GoWbHApwEYlvdEd7rnvJN7uGN+ZB8O
X-Gm-Gg: ATEYQzyW81XU0q0FxPZLFlnlRAIX2/Cn/2mgTIMyl8YIRkq3qz3Nq58hgglmckdum9h
 iny8/eZnlsySifqhO8Z7XzEsObOVHpCQmkFRhcSSBgHCMkP2ZblbFaSJ2PUmumZixk5dVsMNn/4
 T/wf5CsycHjWdSOf1XVAdCWTqQEka0hSde+kxgarsP7PV6UxsH9uofYDyGmJ0t3NUKSe6NEegsi
 64CIh33rpAli2ZklOh7v0+utLAkxEfnjJaCt46PuLrG8Pf2NdAF6bH4WnWVM/llItucKnBta4rO
 cPaPy+ahajJIHTCHb9WZP59tCZyYpuWwkPuXPo5HbzSFGbFl6YtD44gpyi7HNz6/emYu1/E1f7Z
 M8I/Kv7/3gWImE3OGDWdT9Pux9sZNtVJnRZfrw+ijJZzEpuJTTW1+cuBwJjDH/kdCym3uT5jfVJ
 1+Fn3VPYhs2DqEFwwxJt0rzCW7rP3dWa2T
X-Received: by 2002:a17:907:9711:b0:b9b:63af:d9cf with SMTP id
 a640c23a62f3a-b9b63afda64mr750376566b.48.1774897886184; 
 Mon, 30 Mar 2026 12:11:26 -0700 (PDT)
Received: from localhost ([178.214.243.78]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b7ae52295sm330600666b.24.2026.03.30.12.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 12:11:25 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 stable@vger.kernel.org, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v5] drm/amdgpu: replace PASID IDR with XArray
Date: Tue, 31 Mar 2026 00:11:20 +0500
Message-ID: <20260330191120.105065-1-mikhail.v.gavrilov@gmail.com>
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
GFP_KERNEL pre-allocation and IRQ-safe locking internally, so it is
used directly in amdgpu_pasid_alloc().  For amdgpu_pasid_free(), which
can be called from hardirq context, use explicit xa_lock_irqsave()
with __xa_erase() since xa_erase() only uses plain xa_lock() which
is not IRQ-safe.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
    since xa_erase() only uses plain xa_lock() which is not safe from
    hardirq context. Keep xa_alloc_cyclic() for amdgpu_pasid_alloc()
    as it handles locking internally. (Lijo Lazar)
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 47 ++++++++++++-------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index d88523568b62..3fbf631e67c7 100644
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
@@ -84,11 +85,13 @@ int amdgpu_pasid_alloc(unsigned int bits)
  */
 void amdgpu_pasid_free(u32 pasid)
 {
+	unsigned long flags;
+
 	trace_amdgpu_pasid_freed(pasid);
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_lock_irqsave(&amdgpu_pasid_xa, flags);
+	__xa_erase(&amdgpu_pasid_xa, pasid);
+	xa_unlock_irqrestore(&amdgpu_pasid_xa, flags);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -625,13 +628,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
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

