Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6601FC61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7EC10ED1F;
	Wed, 26 Aug 2026 14:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IWWLcxFa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A4B10E4C4
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756188;
 bh=6+349PSAkA/F/V5CV+mrYLPnAnUzCRKSyla22S/Tw5s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IWWLcxFaoYhlO4BB8ZFPJXXYiJ9VZFiy9s6bA2KzUgoyiLlGP3ixnaKPsxmCy6Yo0
 btmE+5QZ8yiNIJTXyMEKG0gpDq2CYIrE+V5jVqEhRG+OTdpZi7dJBQhaT/E+iJJjtM
 +Ikn2zuQH0CGIrkZnA+20mfsWkFGop/IUHaHX6kXc1NCQRUmvb7LYKqDmWiEdscdO/
 qwsc+KzaQBtpRMLPahSjJmEACdeGrjZS2NtIgEvBP59NsMBQBN4UE4Tc2szilw3HD1
 Wibj1XUh4fkDkVVZwP+IOI6V0uhx07ZiKY914tIsU2jn0Jo+YgspWuWzvaho9KdUBm
 TReLh0puC3YjA==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0A5EF17E11F6;
 Wed, 26 Aug 2026 16:56:28 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 26 Aug 2026 16:56:14 +0200
Subject: [PATCH v4 15/18] drm/panthor: Track user owned VMs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-panthor-unplug-fixes-v4-15-982cc8f4234b@collabora.com>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
In-Reply-To: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=3408;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=6+349PSAkA/F/V5CV+mrYLPnAnUzCRKSyla22S/Tw5s=;
 b=5TnF/4it+DDY5EnNGlaxtd5+8F6kHg1/WNxn11WpeaMh37v23bqfN+7zxXRkh26eWURr+knwp
 HKPjKVsyFQgCryjDM5bv9TuHqsszmYUoBOfyFszZQcUmGu3/bp9ZgDv
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

We will soon need this to fix the unplug logic and make sure panthor_vm
objects are not left behind after an unplug.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 47c57b39bd12..6368bf57b8f5 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -117,12 +117,15 @@ struct panthor_mmu {
 
 	/** @vm: VMs management fields */
 	struct {
-		/** @vm.lock: Lock protecting access to list. */
+		/** @vm.lock: Lock protecting access to list and user_owned. */
 		struct mutex lock;
 
 		/** @vm.list: List containing all VMs. */
 		struct list_head list;
 
+		/** @vm.list: List containing VMs with a valid handle. */
+		struct list_head user_owned;
+
 		/** @vm.reset_in_progress: True if a reset is in progress. */
 		bool reset_in_progress;
 
@@ -447,6 +450,9 @@ struct panthor_vm {
 	/** @node: Used to insert the VM in the panthor_mmu::vm::list. */
 	struct list_head node;
 
+	/* @user_node: Used to insert the VM in the panthor_mmu::vm::user_owned list. */
+	struct list_head user_node;
+
 	/** @for_mcu: True if this is the MCU VM. */
 	bool for_mcu;
 
@@ -1681,10 +1687,19 @@ int panthor_vm_pool_create_vm(struct panthor_device *ptdev,
 	drm_gem_object_get(&pool->dummy->base);
 	vm->dummy = pool->dummy;
 
+	/* Insert in the list before xa_alloc() so we can't race with
+	 * panthor_vm_pool_destroy_vm() have the VM inserted in the
+	 * user_owned list after it's been destroyed.
+	 */
+	scoped_guard(mutex, &ptdev->mmu->vm.lock)
+		list_add_tail(&vm->user_node, &ptdev->mmu->vm.user_owned);
+
 	ret = xa_alloc(&pool->xa, &id, vm,
 		       XA_LIMIT(1, PANTHOR_MAX_VMS_PER_FILE), GFP_KERNEL);
 
 	if (ret) {
+		scoped_guard(mutex, &ptdev->mmu->vm.lock)
+			list_del_init(&vm->user_node);
 		panthor_vm_put(vm);
 		return ret;
 	}
@@ -1739,13 +1754,19 @@ static void panthor_vm_destroy(struct panthor_vm *vm)
  */
 int panthor_vm_pool_destroy_vm(struct panthor_vm_pool *pool, u32 handle)
 {
+	struct panthor_device *ptdev;
 	struct panthor_vm *vm;
 
 	vm = xa_erase(&pool->xa, handle);
+	if (!vm)
+		return -EINVAL;
+
+	ptdev = container_of(vm->as->base.drm, struct panthor_device, base);
+	scoped_guard(mutex, &ptdev->mmu->vm.lock)
+		list_del_init(&vm->user_node);
 
 	panthor_vm_destroy(vm);
-
-	return vm ? 0 : -EINVAL;
+	return 0;
 }
 
 /**
@@ -1785,7 +1806,7 @@ void panthor_vm_pool_destroy(struct panthor_file *pfile)
 		return;
 
 	xa_for_each(&pfile->vms->xa, i, vm)
-		panthor_vm_destroy(vm);
+		panthor_vm_pool_destroy_vm(pfile->vms, i);
 
 	if (pfile->vms->dummy)
 		drm_gem_object_put(&pfile->vms->dummy->base);
@@ -3182,6 +3203,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		goto err_put_as;
 	}
 
+	INIT_LIST_HEAD(&vm->user_node);
 	vm->user_va_range = kernel_va_start;
 	vm->as = as;
 	mutex_init(&vm->heaps.lock);
@@ -3707,6 +3729,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 		return ret;
 
 	INIT_LIST_HEAD(&mmu->vm.list);
+	INIT_LIST_HEAD(&mmu->vm.user_owned);
 	ret = drmm_mutex_init(&ptdev->base, &mmu->vm.lock);
 	if (ret)
 		return ret;

-- 
2.55.0

