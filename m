Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D47606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vrcD2ZJ5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70BC510FA18;
	Wed,  4 Nov 2026 07:52:59 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A8C10FA21
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 07:52:53 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so2112955e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793778772; x=1794383572; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H9pWRYIuDAbASTBKlOVzXYu6I+EvAShszd61Y2x+bnQ=;
 b=vrcD2ZJ5Wt5bMowdm9UGkoqINcthwtI9CRSSgaMQybdCLD5gX/RDXOt1of67r7i9ii
 O+t3z6WOnlzwGfAoCU0cey7ECoOdIVfWMbznlulbAEOHgWhcOULm49ZDrp+D3chVqgqM
 niUmh0OtFFkVa33OCG8UQqyAOwCUCGnqGUxoai/jyf4EhbE5Um9dKa42fjQgMT+YccMi
 GzYUxso3yVLVxD07lW6CaXYRyKzY93UeLTOvOS+VG48qJugnlln3xNbTxHSGEmVASH/Q
 vxd+DO1VAIBU82ervIcfGSQwzZ+NcvMj1e1q7Zpt/cR1PEoXvZn7nA1XP0ex4bg7XbAU
 XAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793778772; x=1794383572;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H9pWRYIuDAbASTBKlOVzXYu6I+EvAShszd61Y2x+bnQ=;
 b=JyFuUJ59pL+X8e6iRwPdnmyXY/r03gRkLkCwkwFkoaGvQI322/zTMV0UsLGuaYVgEE
 OuZ9KCXziz0edT1zSfzd6sAgsnxyTWoE36f+2GZiYmBCbnXb+CF5RD715W8ry/aP56jQ
 lrZAD0u04viSuvVvaoIZbqdmHDV9EiLW7D9dns+Tvrhi9JnE5yozjI6lRC+Y1Oeg0qiy
 Mx3gZ0EmGl17kSvEpPZbIcQE7Ww5gRRSUXARSHjdm22WI4tnJBJ6MQ1zT7ukDufrlf5N
 ORfjCrZersWpHmZIiAvu1qYRpl0/rWo5gObP8DrPkTlJlN37LSK35eZOVEpQgXdczc8Q
 xK7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUioEDZHdcAFAFsbKCDd0YPEhYGuin+JoeFKUa1XJzcD/zo+6W4ffNYPsZTTMk8VBWDtPnLFWIcKA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9zDGZKYgzScJzlAQvGCEzOw7Xj9/1kb0+U+5lqZm9FMhOEBRr5
 p4wMsoXGCcZSEWGKFoGi2QSd2V+fGk3ky8Lo7ciUyvCiz9H6rZlJHT8N
X-Gm-Gg: AYBFou0KnqEm8uxVKP33MDytKFGEBbfknJOXk1ynS7slhab0agLEMRECS5+57/mNsgE
 rNJRsgUHblfHS5sNsmKiQjSf0+hgNiuagOfYyR/+qSfR6+plTVRVDIhCOI6doCvr963gDwz/DoE
 CoORufFg3zZWOsSbbXTfVdzho9Qu64mdZFK///9mAeju0fK4P8lB+IO25zdUTu6bZFsxgry4Moy
 1VwajQfjwB6cbhkFllEhDGJvBQOevWohnv4UmqV2OCph8oFT1QF/QjgkE6FDdqg5kLqUAU21GA6
 QKeHhnBE0DzAa1+Zwngsamf3eMhWrx6P8XOFE7zMxvoFL/YQ9jKpljnOGZClUNKdpMRx/Y+Iqla
 Lrfl+/LOSiFF/uu5jVww4UvXVWfjlRf6aR9guZ09WfbSi6iB8Q0RwTwkGXVmkJdJ3aGEMi3mc9Q
 fMCv0KDiVHc1GLRe0K1FGjP38EXs1q9c5Moc4Add/rNmIyoNrnWKyajZaVEzAomc6QSeGnA+qyW
 0IJM5/Xz0C6MpfkskTCkNlEWEDcCGidLie4fYIa6gqlexumDB+X27irR25AkC66YwEHMsMxAtts
 QM/f1PI/eP+Z80y0+eucdIvCSQCEGUhD27gxlN6BXEyPfjJI5B91Z6GWczv/gWYmy3yLf+0vxQL
 puFEO2LVSWrckzU9ZaeAO+w0rtL5X7tIk7u9gmYn8OdmIoqhw2SIS
X-Received: by 2002:a05:600c:3554:b0:4a1:e7ce:107b with SMTP id
 5b1f17b1804b1-4ac150b20eamr371311155e9.2.1793778771764; 
 Tue, 03 Nov 2026 23:52:51 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda207d8sm2200785f8f.52.2026.11.03.23.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:52:51 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Wed, 04 Nov 2026 08:52:39 +0100
Subject: [PATCH v2 1/3] drm/panthor: Report the last VM fault through
 VM_GET_STATE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-panthor-fault-info-v2-v2-1-673b31f3840c@igalia.com>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
In-Reply-To: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: Lukas Zapolskas <lukas.zapolskas@arm.com>, 
 Paul Toadere <paul.toadere@arm.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

Keep the raw AS_FAULTSTATUS and AS_FAULTADDRESS of the last fault in
the VM and return them through VM_GET_STATE. Userspace decodes the
values. No memory is allocated in the fault path.

The MMU irq handler records the fault under the AS slots lock. The
ioctl reads it under the same lock. The VM stores the fault as a
struct drm_panthor_vm_fault, which is the uAPI struct, so the ioctl
can copy it with one assignment.

The unhandled_fault flag is cleared when the VM is re-activated. The
stored fault is not. So userspace can still query it after the group
that hit the fault was killed.

Old userspace that passes the shorter struct still works, the DRM core
zero-fills the missing tail.

Link: https://lore.kernel.org/r/20251215115457.2137485-4-lukas.zapolskas@arm.com
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c |  2 ++
 drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_mmu.h |  2 ++
 include/uapi/drm/panthor_drm.h        | 22 ++++++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..7572cd7d6423 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1471,6 +1471,8 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
 	else
 		args->state = DRM_PANTHOR_VM_STATE_USABLE;
 
+	panthor_vm_get_fault(vm, &args->fault);
+
 	panthor_vm_put(vm);
 	return 0;
 }
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d1c29eec46f2..6fc5f3d381c1 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -389,6 +389,15 @@ struct panthor_vm {
 	 */
 	bool unhandled_fault;
 
+	/**
+	 * @fault: Last fault on this VM.
+	 *
+	 * A new fault overwrites the previous one. Unlike @unhandled_fault,
+	 * this is not cleared when the VM is re-activated. Protected by
+	 * panthor_mmu::as::slots_lock.
+	 */
+	struct drm_panthor_vm_fault fault;
+
 	/** @locked_region: Information about the currently locked region currently. */
 	struct {
 		/** @locked_region.start: Start of the locked region. */
@@ -662,6 +671,19 @@ bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm)
 	return vm->unhandled_fault;
 }
 
+/**
+ * panthor_vm_get_fault() - Get the last fault of a VM
+ * @vm: VM to query.
+ * @fault: Returns the last fault, with a zero status if no fault happened.
+ */
+void panthor_vm_get_fault(struct panthor_vm *vm, struct drm_panthor_vm_fault *fault)
+{
+	struct panthor_device *ptdev = vm->ptdev;
+
+	guard(mutex)(&ptdev->mmu->as.slots_lock);
+	*fault = vm->fault;
+}
+
 /**
  * panthor_vm_is_unusable() - Check if the VM is still usable
  * @vm: VM to check.
@@ -1855,6 +1877,7 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 	while (status) {
 		u32 as = ffs(status | (status >> 16)) - 1;
 		u32 mask = MMU_INT_AS_FAULT(as);
+		struct panthor_vm *vm;
 		u64 addr;
 		u32 fault_status;
 		u32 exception_type;
@@ -1895,8 +1918,14 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
 		 */
 		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
 
-		if (ptdev->mmu->as.slots[as].vm)
-			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
+		vm = mmu->as.slots[as].vm;
+		if (vm) {
+			vm->unhandled_fault = true;
+			vm->fault = (struct drm_panthor_vm_fault){
+				.status = fault_status,
+				.address = addr,
+			};
+		}
 
 		/* Disable the MMU to kill jobs on this AS. */
 		panthor_mmu_as_disable(ptdev, as);
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
index abc36e7204be..74f9f5d98c94 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.h
+++ b/drivers/gpu/drm/panthor/panthor_mmu.h
@@ -11,6 +11,7 @@
 struct drm_exec;
 struct drm_sched_job;
 struct drm_memory_stats;
+struct drm_panthor_vm_fault;
 struct panthor_gem_object;
 struct panthor_heap_pool;
 struct panthor_vm;
@@ -74,6 +75,7 @@ struct panthor_vm *panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 hand
 
 bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm);
 bool panthor_vm_is_unusable(struct panthor_vm *vm);
+void panthor_vm_get_fault(struct panthor_vm *vm, struct drm_panthor_vm_fault *fault);
 
 /*
  * PANTHOR_VM_KERNEL_AUTO_VA: Use this magic address when you want the GEM
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index a2ff0f4ec691..85e197d7a528 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -743,6 +743,20 @@ enum drm_panthor_vm_state {
 	DRM_PANTHOR_VM_STATE_UNUSABLE,
 };
 
+/**
+ * struct drm_panthor_vm_fault - Fault information of a VM.
+ */
+struct drm_panthor_vm_fault {
+	/** @status: Raw AS_FAULTSTATUS value, zero if no fault happened. */
+	__u32 status;
+
+	/** @pad: Will be zero on return. */
+	__u32 pad;
+
+	/** @address: Raw AS_FAULTADDRESS value, valid if @status is non-zero. */
+	__u64 address;
+};
+
 /**
  * struct drm_panthor_vm_get_state - Get VM state.
  */
@@ -756,6 +770,14 @@ struct drm_panthor_vm_get_state {
 	 * Must be one of the enum drm_panthor_vm_state values.
 	 */
 	__u32 state;
+
+	/**
+	 * @fault: Last fault on this VM.
+	 *
+	 * A new fault overwrites the previous one. It is not cleared when the
+	 * VM is re-activated or after a GPU reset.
+	 */
+	struct drm_panthor_vm_fault fault;
 };
 
 /**

-- 
2.56.0

