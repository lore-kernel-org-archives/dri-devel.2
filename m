Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF0BC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 14:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 616F010F813;
	Fri,  3 Jul 2026 14:01:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hmruICJg";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DA04910F813
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 14:01:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D697E16F3;
 Fri,  3 Jul 2026 07:00:59 -0700 (PDT)
Received: from [10.1.29.35] (e122027.cambridge.arm.com [10.1.29.35])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B1BB3F85F;
 Fri,  3 Jul 2026 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783087264; bh=bwkcT/Qxzy/P0ql38yyH51i2Q3/SJtzYVYo2wVtGok0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hmruICJgdlocZDY+QIw5D35F0vfiyWh2PD+WQhDj/5enNbJhdGGVKWljQnKD4Vwt7
 gPU++DFs2+g6Msce/xdr4jniVxZyygw16+cbpwlk9EhdfeOJ3MUe/YOrHaepFGWnX0
 jeKbeVBS4MfZhDQLDjopI241S0/Ks8i3/5GtIWjg=
Message-ID: <497d6db8-42dc-4712-a8a3-46b658bcc4d9@arm.com>
Date: Fri, 3 Jul 2026 15:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] drm/panthor: Add vm_bind region with kbo range
 overlap check
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
 <20260629-vm_bind_checks-v3-1-85e6740f6c2e@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260629-vm_bind_checks-v3-1-85e6740f6c2e@collabora.com>
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

On 29/06/2026 21:17, Adrián Larumbe wrote:
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
> Fixes: tag and reference the relevant sparse binding support commit.
> Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 31cc57029c12..94789777aac4 100644
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
> @@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
>  		va_range = full_va_range;
>  	}
>  
> +	vm->user_va_range = kernel_va_start;
> +
>  	mutex_init(&vm->mm_lock);
>  	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
>  	vm->kernel_auto_va.start = auto_kernel_va_start;
> @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
>  
> +	/* We don't allow mappings that overlap with kbo's reserved range */
> +	if (op->va + op->size > vm->user_va_range)

This can overflow, although you partially handle this case in patch 4.
Can we simply move the overflow check from patch 4 here along with the
user_va_range check?

Thanks,
Steve

> +		return -EINVAL;
> +
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> 

