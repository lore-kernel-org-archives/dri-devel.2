Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB119CDB481
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:49:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55A3A10E08C;
	Wed, 24 Jun 2026 14:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="uSt2o4+b";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0DB8010E08C
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 14:49:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4CD72944;
 Wed, 24 Jun 2026 07:49:33 -0700 (PDT)
Received: from [10.57.80.146] (unknown [10.57.80.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6B53F62B;
 Wed, 24 Jun 2026 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782312578; bh=dC6yLgSD24dCQW7aW4L3yU0ARGBkfl+NeBQGhJFN724=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uSt2o4+boIOBZcx+BIRTuO74pIJ2hGZsxX/psMM7Pm4YvuzXcrtFBrGL7MFsqwBqf
 UGTQL/XktWfdQ84vf8px+B6MdMyAPrRlzX1W0QAlPGaFN54z+kAwM4aj0clpgoX0TN
 q4PjcXhwwhpBQ7pqYvY5WtFD45BokSL4WXOhsol4=
Message-ID: <a3e1136d-8854-47a6-9ada-d94e70a5f751@arm.com>
Date: Wed, 24 Jun 2026 15:49:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
 <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
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

On 19/06/2026 13:41, Adrián Larumbe wrote:
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
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 31cc57029c12..a8de4fe6b231 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -310,6 +310,9 @@ struct panthor_vm {
>  		u64 end;
>  	} kernel_auto_va;
>  
> +	/** @user_va_end: Last VA in the address range VM users can map objects against. */
> +	u64 user_va_end;
> +
>  	/** @as: Address space related fields. */
>  	struct {
>  		/**
> @@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
>  		va_range = full_va_range;
>  	}
>  
> +	vm->user_va_end = kernel_va_start - 1;
> +
>  	mutex_init(&vm->mm_lock);
>  	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
>  	vm->kernel_auto_va.start = auto_kernel_va_start;
> @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
>  		return -EINVAL;
>  
> +	/* We don't allow mappings that overlap with kbo's reserved range */
> +	if (op->va + op->size > vm->user_va_end)
> +		return -EINVAL;

Minor issue, but this is off-by-one. If you attempt to map just the last
page then op->va==kernel_va_start - PAGE_SIZE and op->size == PAGE_SIZE.
But this check will reject it.

I suggest removing the "- 1" from user_vm_end, which also means it
matches the user_va_range we pass back to user space (will appropriate
comment/name updates).

Thanks,
Steve

> +
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
>  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> 

