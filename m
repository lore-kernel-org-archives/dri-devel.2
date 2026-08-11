Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86928C5CFDB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:18:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6EE10EB3C;
	Tue, 11 Aug 2026 10:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="OyN0CK2L";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5E710EB18
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443474;
 bh=ZYp1BwFYi/2bMtugS7zfwiZcE/lz4o2JKqmO8xY3DZg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OyN0CK2L/BWmz56KZILZlyitqyDMV/7BudwMHU+mdbWnEGLWv7QgNKSptrjz6HYuH
 uIZpSpQi8YG5Gt4MgdkYPaGX80xuz+VNUPVDFMvV/1gX2gF1XXRDPiXHMr2GmyJx9Z
 nAjtDG5vBxw8AVP+hBt1X/k0tDjkghLZUQRu57lqW83G8VLo2eMguH8stu115Aq4lE
 OQykSiwqCJactx8eYLfi6UKaiJJ7r3S3r+MbfMAXc6rmlZXBN5afYpY3cvkJOwo2np
 3KdRmQISEqro8fJeIBrnHamirNHJ9J2KAzUAJlu6kUU4CpRXKviiCaZFbACQN4BtCR
 j1ZqZ8wpG1d9Q==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 116A817E121B;
 Tue, 11 Aug 2026 12:17:54 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 12:17:47 +0200
Subject: [PATCH v2 13/17] drm/panthor: Track user owned VMs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-unplug-fixes-v2-13-6b583e37f9ae@collabora.com>
References: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
In-Reply-To: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443467; l=3118;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=ZYp1BwFYi/2bMtugS7zfwiZcE/lz4o2JKqmO8xY3DZg=;
 b=E6X2u1SlVbfXZJFr5NcQYVPfwjUJLGgjEPktcj/6ShDfxYzGNiPzJIGQSEkQPZebr4Ue0KB0c
 T/jfpramj//DGOWle0q1ERIqrh2HMWh6amKS3Hd7U+RP4DrTaxuyffA
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
 drivers/gpu/drm/panthor/panthor_mmu.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 93e9d55da783..5672d437d52d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -107,12 +107,15 @@ struct panthor_mmu {
 
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
 
@@ -427,6 +430,9 @@ struct panthor_vm {
 	/** @node: Used to insert the VM in the panthor_mmu::vm::list. */
 	struct list_head node;
 
+	/* @user_node: Used to insert the VM in the panthor_mmu::vm::user_owned list. */
+	struct list_head user_node;
+
 	/** @for_mcu: True if this is the MCU VM. */
 	bool for_mcu;
 
@@ -1669,10 +1675,19 @@ int panthor_vm_pool_create_vm(struct panthor_device *ptdev,
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
@@ -1727,13 +1742,19 @@ static void panthor_vm_destroy(struct panthor_vm *vm)
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
@@ -3118,6 +3139,7 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		goto err_put_as;
 	}
 
+	INIT_LIST_HEAD(&vm->user_node);
 	vm->user_va_range = kernel_va_start;
 	vm->as = as;
 	mutex_init(&vm->heaps.lock);
@@ -3626,6 +3648,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 		return ret;
 
 	INIT_LIST_HEAD(&mmu->vm.list);
+	INIT_LIST_HEAD(&mmu->vm.user_owned);
 	ret = drmm_mutex_init(&ptdev->base, &mmu->vm.lock);
 	if (ret)
 		return ret;

-- 
2.55.0

