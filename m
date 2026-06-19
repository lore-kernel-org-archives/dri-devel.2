Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537B9CD98F0
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 02:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A0E10E013;
	Fri, 19 Jun 2026 02:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="F6UpifMR";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC8710E013
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 02:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781835414; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FJGjrK2vciwcM61KW0ltd1r3zKUeq8oQ1f0quL1W+Yw/aso7Sa+vDzcWfZoPLBWZukubY2fyS8yani8B5q5/Kh7mxN3GITLaoMfM8pr5NaX3v8J5tTOyUduT/soiIh13lMsnx+xxJECpMN7ueZz8JOY9HPVId1hVIpPeomPueJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781835414;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=jdlEJ0nPoS4wK5zEqKDXE85HyPE1Mn72/UWGbHYnNWo=; 
 b=FzvPDt6ul5iV3ql5VgdeKoiQb/3DBnZC3pXptNjmWTftB2ljrl4Er/3kUfXB/7fYIVz62Lz/54/A/3hj16qq3Ey1fmOddOQvBtOxdu7/EFwU54EsqVcjVNQKgvI7NRuLtP8sqCbH0BiynjZ+AvzWbQ4wwPLJXs/ySjnQ/J3BTlY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781835414; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=jdlEJ0nPoS4wK5zEqKDXE85HyPE1Mn72/UWGbHYnNWo=;
 b=F6UpifMRtr/JBgbbOi2N/P5IWatjQ8ceSgmL4+9iIQObKrP2/r1xTTOvCjq51sye
 qUYPN+crb4N6pY7CY477o9k3o72tp+71HOT06OGU5XgTfjlRLAcYRMNo6dpRU2v1RI2
 oN1FEoaSxq4OowWiHJAghnGi20Bg685/P0uvypIs=
Received: by mx.zohomail.com with SMTPS id 1781835413567336.9815265196404;
 Thu, 18 Jun 2026 19:16:53 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] drm/panthor: Add vm_bind region with kbo range
 intersection check
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260617205003.07e4275e@fedora-2.home>
References: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
 <20260616-vm_bind_checks-v1-1-956198602ae3@collabora.com>
 <20260617205003.07e4275e@fedora-2.home>
Date: Fri, 19 Jun 2026 03:16:37 +0100
Message-Id: <178183539797.1716788.5917731920154470392.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4263;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=3+ClM2jCUCrkcPwoT3pFFiLSM/LI7EC4s99PQ+OBgeQ=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqNKaTJhyUXYUrEkRV9WCQ0qL43wokPrg2zlkAe
 vDoYKGDY0+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajSmkwAKCRAOJn5M7lND
 PWuwC/9uksJnDrt3A0fSBBHfnoe0lqJr+uUUwk0L5QtponPy0dbtBafskeezwkMgk5JbCQWa4y/
 yahCRyJRgR7a+QmhhSejsI0N2olk8cBqz8wDbRAsmt/b0KrD/HIKtfvonCbcML1MDascDmEG1bZ
 W9EZaFm2PiKWCWlskjkvRkEmTBx/oN2GCZFevIOIK8AYDpJZnKnNmSi9AQNnWZN/aVj+JcZ2/FB
 4A/bqtBpzjBa08JnY4OoZswERWqIJ/A9lSf0p6/4r6MIBOz5vcBBVIhaIttcdLy9Ovjz/nqDIIT
 O6kahMuAXz+V4sC+MvXXn7tLc0TAhDzZvN51ON5IYw2UlTwhmm35unNFh0kkzpdhJgJ5A3VU1ih
 5dkNRX5CFMvLHUA9ZsgOHgiYxkHyoGgx3mSajUK6HQ8d34l+vTDVWMSr0go3daE/PrLfA5urVkI
 qhDXpwasTQu14svK4XIMpSo6o6YE74GvMtw/f/lvEVQWMREaPuIKQfJhrr9fThWJcKTOA=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

On 2026-06-17 20:50:03+02:00, Boris Brezillon wrote:
> On Tue, 16 Jun 2026 15:46:43 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > When a VM is created, caller has to specify the range of the address space
> > carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
> > UM-exposed BO's should not intersect with that region, but at the moment
> > we're not checking this.
> > 
> > At first, I thought of giving these values to drm_gpuvm_init() through its
> > reserve_{offset, range} arguments, but it turns out that is meant for VM
> > address spans that are not managed through the usual drm_gpuvm split/merge
> > circuit, so I had no choice but to sort of duplicate that functionality in
> > Panthor. That means we also need to keep that interval recorded in the VM.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 31cc57029c12..5625f3d34031 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -301,6 +301,15 @@ struct panthor_vm {
> >  	/** @mm_lock: Lock protecting the @mm field. */
> >  	struct mutex mm_lock;
> >  
> > +	/** @kernel_va: VA-range reserved for kernel BOs. */
> > +	struct {
> > +		/** @kernel_va.start: Start of the VA-range for kernel BOs. */
> > +		u64 start;
> > +
> > +		/** @kernel_va.range: Size of the automatic VA-range for kernel BOs. */
> > +		u64 range;
> > +	} kernel_va;
> 
> We can do with a single user_va_end.
> 
> > +
> >  	/** @kernel_auto_va: Automatic VA-range for kernel BOs. */
> >  	struct {
> >  		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel BOs. */
> > @@ -1309,6 +1318,24 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
> >  	return 0;
> >  }
> >  
> > +static bool
> > +panthor_vm_is_kernel_address(struct panthor_vm *vm,
> > +			     const struct drm_panthor_vm_bind_op *op)
> 
> Rather than checking if the VA is not in the kernel range, I'd check
> that the VA is in the user range, since that's what we want to enforce,
> and if we ever decide to carve out extra sections above the user-range
> that the UMD is not supposed to access, we would still catch invalid
> map/unmap ops.
> 
> > +{
> > +	u32 op_type = op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK;
> > +	u64 end, kstart, krange, kend;
> > +
> > +	if (op_type == DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
> > +		return false;
> 
> IIRC, we force op->va and op->size to be zero in that case[1], so no
> need for this extra check IMHO.
> 
> > +
> > +	end = op->va + op->size;
> > +	kstart = vm->kernel_va.start;
> > +	krange = vm->kernel_va.range;
> > +	kend = kstart + krange;
> > +
> > +	return krange && op->va < kend && kstart < end;
> 
> A single
> 
> 	op->va + op->size <= vm->user_va_end;
> 
> would do, at which point I'm not too sure adding a helper makes sense.

I'll do this for v2.

> > +}
> > +
> >  #define PANTHOR_VM_BIND_OP_MAP_FLAGS \
> >  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
> >  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
> > @@ -2891,6 +2918,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
> >  	} else {
> >  		min_va = 0;
> >  		va_range = full_va_range;
> > +		vm->kernel_va.start = kernel_va_start;
> > +		vm->kernel_va.range = kernel_va_size;
> >  	}
> >  
> >  	mutex_init(&vm->mm_lock);
> > @@ -2981,6 +3010,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
> >  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
> >  		return -EINVAL;
> >  
> > +	/* We don't allow mappings that intersect with kbo's reserved range */
> > +	if (panthor_vm_is_kernel_address(vm, op))
> > +		return -EINVAL;
> > +
> >  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
> >  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
> >  		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> 
> [1]https://elixir.bootlin.com/linux/v7.0.11/source/include/uapi/drm/panthor_drm.h#L588


