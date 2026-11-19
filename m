Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0318606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Y0bdvIqm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2501121AF;
	Thu, 19 Nov 2026 08:51:03 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD4F1121AE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795078251;
 bh=t3C0iBCCFtuZQ3rf9c18/aTXJ/Sm+17DkMsX+TVkPhk=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Y0bdvIqm1Xe26h39NN8buRnMaxlOiyqo+iLCJ0DpnydLsTCsx36X9aE71z5TrOMkr
 2ddoP5mpEV8O9xHuYf3P84Ivb531+C62Zm455GB/Q/T9NMik/Q+Ekl2xwquaCK4Ntg
 0rij/jva60ChE5BI+uRLtWRKqQqL+pPpGFvSBUH9W5PdebcVmQS4sGHTc+bf41sfK/
 SRZGUXiPaGuu4835tncyBA7SG5ixSvSfn9/Micp9Nx4QzjxTbE2ZyT6I++8PD7iHYP
 vUaj9kg2A1ML9KL6QhgJ6h5YhkCak6FlV76O6dvrLJPDbaTk2TRfXmNzNH6mLRqQTP
 7yNM8GkOQ6tbA==
Received: from fedora1.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9584E17E0480;
 Thu, 19 Nov 2026 09:50:50 +0100 (CET)
Date: Thu, 19 Nov 2026 09:50:45 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Christian Gmeiner <christian.gmeiner@gmail.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Lukas
 Zapolskas <lukas.zapolskas@arm.com>, Paul Toadere <paul.toadere@arm.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Christian Gmeiner <cgmeiner@igalia.com>
Subject: Re: [PATCH v2 1/3] drm/panthor: Report the last VM fault through
 VM_GET_STATE
Message-ID: <20261119095045.100699ca@fedora1.home>
In-Reply-To: <20261104-panthor-fault-info-v2-v2-1-673b31f3840c@igalia.com>
References: <20261104-panthor-fault-info-v2-v2-0-673b31f3840c@igalia.com>
 <20261104-panthor-fault-info-v2-v2-1-673b31f3840c@igalia.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 08:52:39 +0100
Christian Gmeiner <christian.gmeiner@gmail.com> wrote:

> From: Christian Gmeiner <cgmeiner@igalia.com>
> 
> Keep the raw AS_FAULTSTATUS and AS_FAULTADDRESS of the last fault in
> the VM and return them through VM_GET_STATE. Userspace decodes the
> values. No memory is allocated in the fault path.
> 
> The MMU irq handler records the fault under the AS slots lock. The
> ioctl reads it under the same lock. The VM stores the fault as a
> struct drm_panthor_vm_fault, which is the uAPI struct, so the ioctl
> can copy it with one assignment.
> 
> The unhandled_fault flag is cleared when the VM is re-activated. The
> stored fault is not. So userspace can still query it after the group
> that hit the fault was killed.
> 
> Old userspace that passes the shorter struct still works, the DRM core
> zero-fills the missing tail.
> 
> Link: https://lore.kernel.org/r/20251215115457.2137485-4-lukas.zapolskas@arm.com
> Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_drv.c |  2 ++
>  drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++++++--
>  drivers/gpu/drm/panthor/panthor_mmu.h |  2 ++
>  include/uapi/drm/panthor_drm.h        | 22 ++++++++++++++++++++++
>  4 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
> index dc8d0191aef4..7572cd7d6423 100644
> --- a/drivers/gpu/drm/panthor/panthor_drv.c
> +++ b/drivers/gpu/drm/panthor/panthor_drv.c
> @@ -1471,6 +1471,8 @@ static int panthor_ioctl_vm_get_state(struct drm_device *ddev, void *data,
>  	else
>  		args->state = DRM_PANTHOR_VM_STATE_USABLE;
>  
> +	panthor_vm_get_fault(vm, &args->fault);
> +
>  	panthor_vm_put(vm);
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d1c29eec46f2..6fc5f3d381c1 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -389,6 +389,15 @@ struct panthor_vm {
>  	 */
>  	bool unhandled_fault;
>  
> +	/**
> +	 * @fault: Last fault on this VM.
> +	 *
> +	 * A new fault overwrites the previous one. Unlike @unhandled_fault,
> +	 * this is not cleared when the VM is re-activated. Protected by
> +	 * panthor_mmu::as::slots_lock.
> +	 */
> +	struct drm_panthor_vm_fault fault;
> +
>  	/** @locked_region: Information about the currently locked region currently. */
>  	struct {
>  		/** @locked_region.start: Start of the locked region. */
> @@ -662,6 +671,19 @@ bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm)
>  	return vm->unhandled_fault;
>  }
>  
> +/**
> + * panthor_vm_get_fault() - Get the last fault of a VM
> + * @vm: VM to query.
> + * @fault: Returns the last fault, with a zero status if no fault happened.
> + */
> +void panthor_vm_get_fault(struct panthor_vm *vm, struct drm_panthor_vm_fault *fault)
> +{
> +	struct panthor_device *ptdev = vm->ptdev;
> +
> +	guard(mutex)(&ptdev->mmu->as.slots_lock);
> +	*fault = vm->fault;
> +}
> +
>  /**
>   * panthor_vm_is_unusable() - Check if the VM is still usable
>   * @vm: VM to check.
> @@ -1855,6 +1877,7 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  	while (status) {
>  		u32 as = ffs(status | (status >> 16)) - 1;
>  		u32 mask = MMU_INT_AS_FAULT(as);
> +		struct panthor_vm *vm;
>  		u64 addr;
>  		u32 fault_status;
>  		u32 exception_type;
> @@ -1895,8 +1918,14 @@ static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  		 */
>  		gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
>  
> -		if (ptdev->mmu->as.slots[as].vm)
> -			ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
> +		vm = mmu->as.slots[as].vm;
> +		if (vm) {
> +			vm->unhandled_fault = true;
> +			vm->fault = (struct drm_panthor_vm_fault){
> +				.status = fault_status,
> +				.address = addr,
> +			};
> +		}
>  
>  		/* Disable the MMU to kill jobs on this AS. */
>  		panthor_mmu_as_disable(ptdev, as);
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.h b/drivers/gpu/drm/panthor/panthor_mmu.h
> index abc36e7204be..74f9f5d98c94 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.h
> @@ -11,6 +11,7 @@
>  struct drm_exec;
>  struct drm_sched_job;
>  struct drm_memory_stats;
> +struct drm_panthor_vm_fault;
>  struct panthor_gem_object;
>  struct panthor_heap_pool;
>  struct panthor_vm;
> @@ -74,6 +75,7 @@ struct panthor_vm *panthor_vm_pool_get_vm(struct panthor_vm_pool *pool, u32 hand
>  
>  bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm);
>  bool panthor_vm_is_unusable(struct panthor_vm *vm);
> +void panthor_vm_get_fault(struct panthor_vm *vm, struct drm_panthor_vm_fault *fault);
>  
>  /*
>   * PANTHOR_VM_KERNEL_AUTO_VA: Use this magic address when you want the GEM
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index a2ff0f4ec691..85e197d7a528 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -743,6 +743,20 @@ enum drm_panthor_vm_state {
>  	DRM_PANTHOR_VM_STATE_UNUSABLE,
>  };
>  
> +/**
> + * struct drm_panthor_vm_fault - Fault information of a VM.
> + */
> +struct drm_panthor_vm_fault {
> +	/** @status: Raw AS_FAULTSTATUS value, zero if no fault happened. */
> +	__u32 status;
> +
> +	/** @pad: Will be zero on return. */
> +	__u32 pad;
> +
> +	/** @address: Raw AS_FAULTADDRESS value, valid if @status is non-zero. */
> +	__u64 address;
> +};
> +
>  /**
>   * struct drm_panthor_vm_get_state - Get VM state.
>   */
> @@ -756,6 +770,14 @@ struct drm_panthor_vm_get_state {
>  	 * Must be one of the enum drm_panthor_vm_state values.
>  	 */
>  	__u32 state;
> +
> +	/**
> +	 * @fault: Last fault on this VM.
> +	 *
> +	 * A new fault overwrites the previous one. It is not cleared when the
> +	 * VM is re-activated or after a GPU reset.
> +	 */
> +	struct drm_panthor_vm_fault fault;
>  };
>  
>  /**
> 

