Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8001560A3821
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=M45Vj9qt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF37111264F;
	Thu, 22 Oct 2026 13:42:59 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF97112619
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=vx0nMNG6T5j4HqQLG8MZdguAtMzm7uQavru9EgavMgs=; b=M45Vj9qtwNG0KO3wWdkPWdFTtk
 Z07zbODElbzNzCBi4uOGBoYXXO/cg4+wKyMELwTowRIFHgnmz1nsK2V3sdibUAQGZl2qN/+sVVBnH
 8E9/82Nw3JNNKPYIgjKLLABaa0xtDFvUDGV/h2jvCBquVFsF7M7jBgNcT04tRUQpd4+rxfjC9m3l2
 0+gdEXYSQhZpv/Vh/0Jvl6IYELbDvUZVpLtP/0leNxw9OwH/uoQQ3UEGculfW881Nrnj3b90Dpx0u
 48U0cwxuKd0kyxlGt7Of2t0uKRaOQzVb+BzYo4fH1Nzrs+Pcmj+YsFHld5o9NF1kPdOrpii1CBzAu
 BoISuuhg==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xJt4E-006qVR-Mi; Thu, 22 Oct 2026 15:42:50 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Date: Thu, 22 Oct 2026 10:42:45 -0300
Subject: [PATCH] drm/panthor: Replace panthor_mmu_as_fault_mask() with a macro
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-panthor-as-mask-v1-1-6aba7ad8cb9f@igalia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQpAQBCA4VfRnE3ZkV28ihw2BpMs7UhK3t3m+
 B3+/wHlKKzQZg9EvkRlDwkmz2BYfJgZZUwGKsiagggPH85lj+gVN68rGmpsXTeVKZ2DVB2RJ7n
 /Y9e/7wf3Blk9YQAAAA==
X-Change-ID: 20261022-panthor-as-mask-129688951377
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3612; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=hlKxKLR4LqnKYVErvY5HZCNJ6QP7XtQXbhBuY0V8y5o=;
 b=owEBbQGS/pANAwAKAT/zDop2iPqqAcsmYgBq2hLYrIO12Uph9ppaWONTYUGy57nYj7/Hwc0w4
 kunOZv9NkCJATMEAAEKAB0WIQT45F19ARZ3Bymmd9E/8w6Kdoj6qgUCatoS2AAKCRA/8w6Kdoj6
 qkTxCACajulZFp0AaffpxHzo4a9oLiOA2Sh6+mNg1W+8R8nAgu/bF5LuSFT9+6mRn5JU5b5ruAX
 H/vtYfFAsOumrsb4bDm2EZpwPROk41HGoRLGoraaSVSSWZPtfKyP3j6On2iqoDk5AWL+E2XTPpE
 QKjrJx3xh/kh51ulr4m7dXc6YhUdg1/YqR0AYJRMaS87C/tt0uUiXvvvYz+OLA0tskic4RrnFlm
 hK5fcqvx5GWCOvDkDiF+/EZLon7kj5r4Xc4nL2OVQrfaOv0eraO/Qupbo3QMiW3lYi+CZpRYJpw
 ZMyDc3SslsI8IaMvc0iorBldwkuH9/B2ec18EASG7JbBCu66
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

panthor_mmu_as_fault_mask() ignores its ptdev argument and only returns
the per-AS fault bit, which is fixed in the MMU interrupt registers.
Replace it with the macro MMU_INT_AS_FAULT(), which is defined next to
the other MMU register definitions.

No functional change.

Signed-off-by: Maíra Canal <mcanal@igalia.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c      | 17 +++++------------
 drivers/gpu/drm/panthor/panthor_mmu_regs.h |  1 +
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d4b968ab094e..1109959dadc6 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -596,18 +596,12 @@ static u64 pack_region_range(struct panthor_device *ptdev, u64 *region_start, u6
 	return region_width | *region_start;
 }
 
-static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
-{
-	return BIT(as);
-}
-
 static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
 				 u64 transtab, u64 transcfg, u64 memattr)
 {
 	struct panthor_mmu *mmu = ptdev->mmu;
 
-	panthor_irq_enable_events(&ptdev->mmu->irq,
-				  panthor_mmu_as_fault_mask(ptdev, as_nr));
+	panthor_irq_enable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
 
 	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
 	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
@@ -625,8 +619,7 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
 
 	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
 
-	panthor_irq_disable_events(&ptdev->mmu->irq,
-				   panthor_mmu_as_fault_mask(ptdev, as_nr));
+	panthor_irq_disable_events(&ptdev->mmu->irq, MMU_INT_AS_FAULT(as_nr));
 
 	/* Flush+invalidate RW caches, invalidate RO ones. */
 	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
@@ -745,7 +738,7 @@ int panthor_vm_active(struct panthor_vm *vm)
 		/* Unhandled pagefault on this AS, the MMU was disabled. We need to
 		 * re-enable the MMU after clearing+unmasking the AS interrupts.
 		 */
-		if (ptdev->mmu->as.faulty_mask & panthor_mmu_as_fault_mask(ptdev, as))
+		if (ptdev->mmu->as.faulty_mask & MMU_INT_AS_FAULT(as))
 			goto out_enable_as;
 
 		goto out_make_active;
@@ -800,7 +793,7 @@ int panthor_vm_active(struct panthor_vm *vm)
 	/* Unhandled pagefault on this AS, clear the fault and enable the AS,
 	 * which re-enables interrupts.
 	 */
-	fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
+	fault_mask = MMU_INT_AS_FAULT(as);
 	if (ptdev->mmu->as.faulty_mask & fault_mask) {
 		gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
 		ptdev->mmu->as.faulty_mask &= ~fault_mask;
@@ -1864,7 +1857,7 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 	status = panthor_mmu_fault_mask(ptdev, status);
 	while (status) {
 		u32 as = ffs(status | (status >> 16)) - 1;
-		u32 mask = panthor_mmu_as_fault_mask(ptdev, as);
+		u32 mask = MMU_INT_AS_FAULT(as);
 		u64 addr;
 		u32 fault_status;
 		u32 exception_type;
diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
index 4e32ab931949..1ec7f5ef2b19 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
@@ -7,6 +7,7 @@
 /* MMU regs */
 
 #define MMU_INT_BASE					0x2000
+#define   MMU_INT_AS_FAULT(as)				BIT(as)
 
 /* AS_COMMAND register commands */
 

---
base-commit: cf5d8e390e2ac2cfa24a50645efdbb9f0eebe65f
change-id: 20261022-panthor-as-mask-129688951377

