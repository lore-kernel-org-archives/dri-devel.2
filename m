Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D072C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8298710ECA1;
	Wed, 29 Jul 2026 15:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="lfttkp2q";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 701F110ECA1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:35:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6F761684;
 Wed, 29 Jul 2026 08:35:21 -0700 (PDT)
Received: from [10.57.87.210] (unknown [10.57.87.210])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EED2F3F763;
 Wed, 29 Jul 2026 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785339325; bh=A9brKcdT9wwXKY8x1FMedMH2NJeeysPM9WP7OtXM6K0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lfttkp2qHpY4WOt8pxF0/Zwxe2AXNInkAoeGpGMlrVi4LTOHAC0LB7ixqYKxLhFZg
 AKLl3KnlL9Od/IjxmkESk2iIKqeG7bYK9vDIKSY0Mkn0qU+xdPd02JlwQdf8U+H4r2
 LoHOyujpjzk1ILZzSoBEfVmhlMLRtH4IxUEt9X8c=
Message-ID: <ceaa75dd-a327-4714-b042-63d185398e46@arm.com>
Date: Wed, 29 Jul 2026 16:35:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260720-vm_bind_checks-v6-0-c2c7dbe93a73@collabora.com>
 <20260720-vm_bind_checks-v6-1-c2c7dbe93a73@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720-vm_bind_checks-v6-1-c2c7dbe93a73@collabora.com>
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

On 20/07/2026 16:48, Adrián Larumbe wrote:
> When a VM is created, caller has to specify the range of the address space
> carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
> UM-exposed BO's should not intersect with that region, but at the moment
> we're not checking this.
> 
> At first, I thought of giving these values to drm_gpuvm_init() through its
> reserve_{offset, range} arguments, but it turns out that is meant for VM
> address spans that are not managed through the usual drm_gpuvm split/merge
> circuit, so storing the end of the user VA range at VM creation time and
> doing a quick check in the vm_bind ioctl path was the simplest workaround.
> 
> The new check also makes sure vm_bind range doesn't overflow the size of a
> 64-bit unsigned integer. That was already being done further down the call
> stack inside drm_gpuvm_sm_map -> drm_gpuvm_range_valid, but it's best to
> fail early in the driver before GPUVM functions are invoked so that we
> won't waste time allocating vm_bind context resources.
> 
> Fixes: 12cf826bf1dd ("drm/panthor: Support sparse mappings")
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

I'll push both patches to drm-misc-next.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index f45ef5824ff2..80a1dac40a6a 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -310,6 +310,9 @@ struct panthor_vm {
>  		u64 end;
>  	} kernel_auto_va;
>  
> +	/** @user_va_range: Upper boundary of VAs VM users can map objects against. */
> +	u64 user_va_range;
> +
>  	/** @as: Address space related fields. */
>  	struct {
>  		/**
> @@ -2892,6 +2895,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
>  		va_range = full_va_range;
>  	}
>  
> +	vm->user_va_range = kernel_va_start;
> +
>  	mutex_init(&vm->mm_lock);
>  	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
>  	vm->kernel_auto_va.start = auto_kernel_va_start;
> @@ -2980,6 +2985,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
>  
> +	/* We don't allow mappings that overlap with kbo's reserved range */
> +	if (range_overflows(op->va, op->size, vm->user_va_range))
> +		return -EINVAL;
> +
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> 

