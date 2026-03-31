Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF84109B475
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 14:21:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE8510E975;
	Tue, 31 Mar 2026 14:21:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GXlp1Kd0";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6C110E975
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 14:21:34 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-59dcdf60427so6345926e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774966892; x=1775571692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1oYcPcx8F3d6g2/KOSoArMOX0Oh8a20uUVdo2G1rSio=;
 b=GXlp1Kd0Sm9f1m/VgIRHyqcva4hnKPuIhrzVZXoqwiRtaAVvMOCNmHetEc9MFnFoeS
 4tTuKor9IfsDp3h28yaFkoSZcre80cXrNVIHbDrsr67Kt9DoDqwWv8Qclc/6ap0bo1jT
 U5aV84t7FdDONbjaJuml0FxDpyvpUBALnEbNRwlDVCGtgC3lS89vCkhErApOzGRdqCj0
 NZaxEdKcfIaqYB1UkxUls2bkaNsYsWxupjhAUFJE9VobGj2GNGWWxG/cqCi5eXT3RyBC
 wCUKGEUAOGVXfQtyo0WtOA4przFt2gnVQLXglIUBmSUwBtZtHAfmyOz5Vyla0ERha9bk
 PfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774966892; x=1775571692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1oYcPcx8F3d6g2/KOSoArMOX0Oh8a20uUVdo2G1rSio=;
 b=a/QEzvhYkfxbgci2Tt5b7UvGilDcTcyxVACU6g1irrxBMucqhGqER7v2k/8iLqIuoG
 N5SMet5PWSZDhvFTIQurZW3ESbH0c6MKAdftcAq9Y0xHQAlrP8LnFBEvuyMsmW04TEre
 YTyKaTPXCdb10yllD/NQ0E/JpYpQGJCSSIIx+wgLYUc2jPfkBm/i6huz0avq5JU+iGYs
 MzrfgtBjZvpgoiZhpDxvwuygCqA2PTieSxm7hs1nVSwe2RGniMik4jvGnhoFJ+uvDSA3
 BDv/BYAz6rZ3CwvrzyzdckmwrSxko9SgAI88OP3X3moz2NEdJF2+qihawxcV3tymjZxX
 2sWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhgv8OA83+tmLKmXqDNeKxqCPeeKZnjOnNoaRXVVwg3UYE+brpo9IyqRjGb5kczDRLo4VgoCo5yFU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhzgKAcHxZY9ZILhQqazn3LL4netEABccQv5ToGZeSSNFfLty+
 juuKFtDmSbLg+OCyEjtoa71kZawTWTZubrrOxE3NaGByneuqu95S4DdJ
X-Gm-Gg: ATEYQzwmOZP6rI4OZXmFfGlnRQSBjpSRP2+lhOAiOLYeElZq408SPTim7+zF9/7UxiG
 +dtbG97kZFycrxbHyAlJHxIdM3pywMp0ARVfhe8CEHJjB5YjOO1nLgGOIut2Flemsn5InW2wY41
 nxW6p1gX9Q+/79JAm3DkQwmmNEuUdqBn4vJIosAb2TmpHAX68dsT6bQmK93iZc8IzPbCkLB1nPv
 mFuJU+K0NFIDCpLnVhaEhvL7e3Q0yuijwAaaQARqxj0hgjs7WuK8ah3W6iteOSroiQmMnGpzovG
 gd/bmPPL6xlrwZWD42MuOtZX2b7icigG05Bj/ZHcIckImz6nRlDBZqZagrglPhS3ikhu4BCVVKH
 hQeGR+mvGiByQ5OagVmA2KibDHyffYI0TFs330KsvUB9a9MhzVcAXMppYULQOzyhuYM16F91Um8
 N8IDtnkvLjmtnw1qNrCnRAKk3aQJZUeAFNXQ==
X-Received: by 2002:a05:6512:3ca8:b0:5a2:bc8d:272 with SMTP id
 2adb3069b0e04-5a2bc8d0336mr1017775e87.0.1774966891920; 
 Tue, 31 Mar 2026 07:21:31 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a2b1444a1dsm2422837e87.54.2026.03.31.07.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 07:21:31 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v7] drm/amdgpu: replace PASID IDR with XArray
Date: Tue, 31 Mar 2026 19:21:26 +0500
Message-ID: <20260331142127.52796-1-mikhail.v.gavrilov@gmail.com>
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

Replace the PASID IDR + spinlock with XArray as noted in the TODO
left by commit dccd79bb1c7f ("drm/amdgpu: fix the idr allocation
flags").

The IDR conversion still has an IRQ safety issue:
amdgpu_pasid_free() can be called from hardirq context via the fence
signal path, but amdgpu_pasid_idr_lock is taken with plain spin_lock()
in process context, creating a potential deadlock:

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

Use XArray with XA_FLAGS_LOCK_IRQ (all xa operations use IRQ-safe
locking internally) and XA_FLAGS_ALLOC1 (zero is not a valid PASID).
Both xa_alloc_cyclic() and xa_erase() then handle locking
consistently, fixing the IRQ safety issue and removing the need for
an explicit spinlock.

Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: e6d765de3d6b ("drm/amdgpu: prevent immediate PASID reuse case")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---

v7: Rebased on amd-staging-drm-next which already includes
    dccd79bb1c7f ("drm/amdgpu: fix the idr allocation flags").
    Updated commit message to reflect that sleeping-under-spinlock
    is already fixed and the xarray conversion now addresses the
    remaining IRQ safety issue.  Inverted error check to
    if (r < 0) return r; per Christian König.
v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
    so all xa operations use IRQ-safe locking internally.  Drop
    Cc: stable since the regression was never released to any stable
    kernel. (Christian König)
    https://lore.kernel.org/all/20260331111733.118553-1-mikhail.v.gavrilov@gmail.com/
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

 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 34 ++++++++++---------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index e495a8fa13fd..a6ac3b4ce0df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -22,7 +22,7 @@
  */
 #include "amdgpu_ids.h"
 
-#include <linux/idr.h>
+#include <linux/xarray.h>
 #include <linux/dma-fence-array.h>
 
 
@@ -40,8 +40,8 @@
  * VMs are looked up from the PASID per amdgpu_device.
  */
 
-static DEFINE_IDR(amdgpu_pasid_idr);
-static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
+static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1);
+static u32 amdgpu_pasid_xa_next;
 
 /* Helper to free pasid from a fence callback */
 struct amdgpu_pasid_cb {
@@ -62,22 +62,19 @@ struct amdgpu_pasid_cb {
  */
 int amdgpu_pasid_alloc(unsigned int bits)
 {
-	int pasid;
+	u32 pasid;
+	int r;
 
 	if (bits == 0)
 		return -EINVAL;
 
-	spin_lock(&amdgpu_pasid_idr_lock);
-	/* TODO: Need to replace the idr with an xarry, and then
-	 * handle the internal locking with ATOMIC safe paths.
-	 */
-	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
-				 1U << bits, GFP_ATOMIC);
-	spin_unlock(&amdgpu_pasid_idr_lock);
-
-	if (pasid >= 0)
-		trace_amdgpu_pasid_allocated(pasid);
+	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
+			    XA_LIMIT(1, (1U << bits) - 1),
+			    &amdgpu_pasid_xa_next, GFP_KERNEL);
+	if (r < 0)
+		return r;
 
+	trace_amdgpu_pasid_allocated(pasid);
 	return pasid;
 }
 
@@ -88,10 +85,7 @@ int amdgpu_pasid_alloc(unsigned int bits)
 void amdgpu_pasid_free(u32 pasid)
 {
 	trace_amdgpu_pasid_freed(pasid);
-
-	spin_lock(&amdgpu_pasid_idr_lock);
-	idr_remove(&amdgpu_pasid_idr, pasid);
-	spin_unlock(&amdgpu_pasid_idr_lock);
+	xa_erase(&amdgpu_pasid_xa, pasid);
 }
 
 static void amdgpu_pasid_free_cb(struct dma_fence *fence,
@@ -634,7 +628,5 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
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

