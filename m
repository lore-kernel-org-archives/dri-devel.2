Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA22FC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22DED10E25B;
	Thu, 16 Jul 2026 11:00:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="bTtO2NTd";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7AD10E25B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 11:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784199602; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=IT0xARpCdXwPC3fM9ynbORQcECKmvzd3y3yhZfgKzBulx0B3WSpq8FaXvyz4XjP87rY2CfCfQ4KeXrggMPKNNxm9q/m7oNI92rZZL4fczq1cfWcxHSFQdFBwsrIBjAOi55AYIopggyiuvJp2n1RJ6xNW6zLFichHWaAXTZfNobI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784199602;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Kz3BQ98o67H7tR9dTpm4zDNXU3HjViusz9OfQjQItlY=; 
 b=SdPRqkCKBCQ0WxANHQF0mypTMH90B6z4zxefVHbODQzR3m96Y5dx9kW4BqXLVR/kHnmF+yjCr//RpUShjabaXmnIm7axRKRAebhYDLg5/f2gDvdUSWRZgEF0OryxltkRJfpQnbLI1XieV5HWokVyGrZpsH08tg7JVKJD3GQyU0Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784199602; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
 bh=Kz3BQ98o67H7tR9dTpm4zDNXU3HjViusz9OfQjQItlY=;
 b=bTtO2NTd2vve+N3M4aZDIBMForJ45b1q8S/8fwBpokivS25ilwXeB713l6HLsvJ4
 rERa/jgMSKY6wJX7E/wNIbkynbO2/Kq8szz6KneHGWGloxKU/D6RQ920bkuOazZ6zf9
 kZ5fSG2w3GmqJMQhJHIi6qwR7koaoOpf6tAK7y1s=
Received: by mx.zohomail.com with SMTPS id 1784199600205710.3550584601786;
 Thu, 16 Jul 2026 04:00:00 -0700 (PDT)
Date: Thu, 16 Jul 2026 11:59:55 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
Message-ID: <ali5l5hvVhU6yRM-@sobremesa>
References: <20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com>
 <20260713-vm_bind_checks-v5-1-0d2314af8d9d@collabora.com>
 <c3fc19e6-6629-4908-8dc0-ff627899fc98@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3fc19e6-6629-4908-8dc0-ff627899fc98@arm.com>
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

On 16.07.2026 10:27, Steven Price wrote:
> On 13/07/2026 09:48, Adrián Larumbe wrote:
> > When a VM is created, caller has to specify the range of the address space
> > carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
> > UM-exposed BO's should not intersect with that region, but at the moment
> > we're not checking this.
> > 
> > At first, I thought of giving these values to drm_gpuvm_init() through its
> > reserve_{offset, range} arguments, but it turns out that is meant for VM
> > address spans that are not managed through the usual drm_gpuvm split/merge
> > circuit, so storing the end of the user VA range at VM creation time and
> > doing a quick check in the vm_bind ioctl path was the simplest workaround.
> > 
> > The new check also makes sure vm_bind range doesn't overflow the size of a
> > 64-bit unsigned integer. That was already being done further down the call
> > stack inside drm_gpuvm_sm_map -> drm_gpuvm_range_valid, but it's best to
> > fail early in the driver before GPUVM functions are invoked so that we
> > won't waste time allocating vm_bind context resources.
> > 
> > Fixes: tag and reference the relevant sparse binding support commit.
>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Can you dig out the relevant commit ;)

Oops. Will do.

> > Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Thanks,
> Steve
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 31cc57029c12..910c8e579770 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -310,6 +310,9 @@ struct panthor_vm {
> >  		u64 end;
> >  	} kernel_auto_va;
> >  
> > +	/** @user_va_range: Upper boundary of VAs VM users can map objects against. */
> > +	u64 user_va_range;
> > +
> >  	/** @as: Address space related fields. */
> >  	struct {
> >  		/**
> > @@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
> >  		va_range = full_va_range;
> >  	}
> >  
> > +	vm->user_va_range = kernel_va_start;
> > +
> >  	mutex_init(&vm->mm_lock);
> >  	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
> >  	vm->kernel_auto_va.start = auto_kernel_va_start;
> > @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
> >  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
> >  		return -EINVAL;
> >  
> > +	/* We don't allow mappings that overlap with kbo's reserved range */
> > +	if (range_overflows(op->va, op->size, vm->user_va_range))
> > +		return -EINVAL;
> > +
> >  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
> >  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
> >  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> > 

Adrian Larumbe
