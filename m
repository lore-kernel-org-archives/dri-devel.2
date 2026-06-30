Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51951C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661BC10E1EE;
	Tue, 30 Jun 2026 13:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="ThoULKvY";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E8F10E1EE
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 13:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782824501; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nthbJqtvONO2/nwe8d1zeggxE633bxM3tISdxZ9/g3pG52haAxcpzl35qw67YfktREiapvUBCEGIl/MI9LOSVGlau3P7YZ8h2FMLbNaH/GtiDwfnXSliRfaVfW2BUPdUngYLUCbOJPkhSJXTSOqOxtIp52m66SUhubVeBzCGZZw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782824501;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=p2SG0TMOHZ0GVS52q7Vq5mLYI7uuqPD8eXhp/+nyhfQ=; 
 b=YXGwCtt4/YRI/DofMoup8Z8X+NXagYhkW/MbG3tCcpb4eI85a/OPWdCGlIDc6Q6MyVJjPcNfKCE+4S2XGf0V8xJ2ORFS0n8wX5jXg+OGriB5dyGnbcR46m6zQwevF0he71C/4IpVmiPhaH6/G46lH80BS2kOnU7DLteJvZ1mk80=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782824501; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=p2SG0TMOHZ0GVS52q7Vq5mLYI7uuqPD8eXhp/+nyhfQ=;
 b=ThoULKvYekyV3DeuAxxxsVsCAhOOFovLRJ8P0ABIKQA40dUVZ2fMGnoyxX9ux856
 qbf2e4FQxegcTuiHS91L5Fj+W7ioLYiOFJ9RrCRlj2tWUpyySUhOivslZPYaf8sAGhy
 QtJl4zftHBRDNTRm3qN0V0UyHGz27RwQ13tyejiI=
Received: by mx.zohomail.com with SMTPS id 1782824498318744.2704169078715;
 Tue, 30 Jun 2026 06:01:38 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 4/4] drm/panthor: Check for sparse binding range
 overflow
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Sashiko <noreply@sashiko.dev>
In-Reply-To: <20260630102336.0097aef3@fedora-2.home>
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
 <20260629-vm_bind_checks-v3-4-85e6740f6c2e@collabora.com>
 <20260630102336.0097aef3@fedora-2.home>
Date: Tue, 30 Jun 2026 14:01:33 +0100
Message-Id: <178282449383.3118423.12729371394612188562.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2951;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=wLaDT5J34qt7Cngw7dzJHK8HWfrTrUtjDpUsFDZdFDk=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqQ74uqChTsgdZm1704Af+31xQx6hwhJBG+AJWj
 be+TkVPjUuJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakO+LgAKCRAOJn5M7lND
 PW0RDACc9eUBsBT7UBCvSEwhXePc4vrgrOD/RzNImpKl0DepfeD1ZCIuUfNVOf+Tp+xxC8KgnDK
 rufmB8JI89TrUGY5JC6GfAN7yJdjhQVFb2uDp1B5cyq9cPYNB3AWB/fbReQdEzXAQFCk6SfARH0
 NHTze2QTErZYXWBB+1LM36BSFem2YBSNOGW0qNXjWsawJtrPPz4xB2aDPu1iPNJzQOX+HiZfx67
 Zj0e2wHfpMXZ3gr4uzkoqE//a538QWICs1a5gNX33fQhSAtbAsSD1B6AxULLpxtYDzvl51L/Qp3
 pIO+nm7JyvEcERWy2xeMjgRUq54zdb/w1NLCZ32IM9VuK+QcCXQVw6gXLJq5tSMQqmung5K/HDC
 xP1YeotyxXeKjRRvKS0SaWOK/13Mzp9raBn5fSFI0CwM/j1MQ8KjGtHqaH9nfJpTa5jEZ/78a16
 3joa8SRgNE64b8INmITrRntOkQeerERXaYGxBaf5NWOUD27DISGn1X083NVYB0gbqf1Ig=
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

On 2026-06-30 10:23:36+02:00, Boris Brezillon wrote:
> On Mon, 29 Jun 2026 21:17:08 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > This check is being already carried out further down the call stack inside
> > drm_gpuvm_sm_map -> drm_gpuvm_range_valid, but it's best to fail early in
> > the driver before GPUVM functions are invoked so that we won't waste time
> > allocating vm_bind context resources.
> > 
> > Reported-by: Sashiko <noreply@sashiko.dev>
> > Closes: https://sashiko.dev/#/message/20260623204220.CDB1B1F000E9%40smtp.kernel.org
> > Fixes: 12cf826bf1dd ("drm/panthor: Support sparse mappings")
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 77fdad4e5166..8bd9b975e5ce 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -1328,6 +1328,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
> >  	struct drm_gpuvm_bo *preallocated_vm_bo;
> >  	struct sg_table *sgt = NULL;
> >  	int ret;
> > +	u64 end;
> >  
> >  	if (!bo)
> >  		return -EINVAL;
> > @@ -1353,6 +1354,10 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
> >  	if (is_sparse && (op->bo_handle || op->bo_offset))
> >  		return -EINVAL;
> >  
> > +	/* Protect against sparse VA range overflow */
> > +	if (is_sparse && check_add_overflow(op->va, op->size, &end))
> > +		return -EINVAL;
> 
> Why should we limit this to sparse? Feels like the overflow check is
> good to have for non-sparse as well.

You're right, it should be done for all unmaps. On top of that, Sashiko pointed this out:

New issues:
- [Low] The newly added overflow check in `panthor_vm_prepare_unmap_op_ctx` is mathematically dead code because the `MAP_SPARSE` flag is explicitly rejected for UNMAP operations.
- [Low] The overflow check in `panthor_vm_prepare_map_op_ctx` is artificially restricted to sparse mappings, bypassing early protection for non-sparse mappings.

So it turns out that by limiting the overflow check to sparse unmaps, I've introduced a NOP.
That also made me think that even though in the uAPI we state the following:

* @DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE: Sparsely map a virtual memory range
*
* Only valid with DRM_PANTHOR_VM_BIND_OP_TYPE_MAP.

I wrote no checks to validate this for the sparse mappings patch series.
So for v4 I'll be doing the overflow check unconditionally in panthor_vm_prepare_unmap_op_ctx() and also
return -EINVAL if DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE is among the op flags.

Second Sashiko issue isn't relevant because right at the next statement we're clamping limiting mapping
ranges to the size of BOs.

Cheers,
Adrian


