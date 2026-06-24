Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E5CCDE003
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A5610E0A0;
	Wed, 24 Jun 2026 15:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="eQhZvEpl";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4BCD10E0A0
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 15:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782314052; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RlyaE3trBJs+ASZp3lNN3A3uDwWLG32UG8R/N1hlG3w/4dowzoJPgv9lkquytkRK/ueSikWkj6LjzR+fQ67GXoZCxfDY7evboWdZr8hk1ZSa0kXnv5Y2+vYG9whtMTwD6apTexwd3WFViaq9wOgCYu/h2yJTOJxcnXucGA35wt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782314052;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=OVSxDTaxKiuJfA4Jyh4yxWn1ocbjEZFe82cnOOR1KB0=; 
 b=PnhWKL2Q/Dfa3Kknp74lJucVEINxoIMfKc7D33AdqUHP79vSRMteO1by0cwG782D8UzgZZSyODfMjn9OZSRi9LeBmBjzTGU9JsQEhx1qG2LtgoFhMZbCqaKt4M/IeKChq2eUPkZMuVECpxuW1JMUtsDnG5P38hkzR+W/pioP6iI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782314052; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Date:Date:Message-Id:Message-Id:Reply-To;
 bh=OVSxDTaxKiuJfA4Jyh4yxWn1ocbjEZFe82cnOOR1KB0=;
 b=eQhZvEplR62YL9Hnjlh9SKNdkqX6hR66jN6tpKDs0ISkzMc08NW+bKFqxdlf5YsL
 VRQH8Xvx9TH37muMeh3i1VgzscQJzcukDLv/FocklYgd53+DEwfNsiru30VD6ylIPn4
 WGvGZr8i02BFfNZBRb0jq74O6edQyk9gDM48exGY=
Received: by mx.zohomail.com with SMTPS id 178231405100749.28902298574724;
 Wed, 24 Jun 2026 08:14:11 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <a3e1136d-8854-47a6-9ada-d94e70a5f751@arm.com>
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
 <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
 <a3e1136d-8854-47a6-9ada-d94e70a5f751@arm.com>
Date: Wed, 24 Jun 2026 16:14:01 +0100
Message-Id: <178231404195.4098752.7306517513763497783.b4-reply@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2944;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=VDQNOIPdfNXLGguUidsilIMvbQ87NDUgyzY3Po/e5Os=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqO/RA5WFIxIGkwhnHSfZwO+rg6SRy4l/Ys3ohW
 0eQJ/Uc0Y6JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajv0QAAKCRAOJn5M7lND
 PXS5DACtHvfLwUQF535eJvhoSFf3M5UTcEm2KYmurHe3HartBLkWu898wXDqvSUeJaE915TFOrG
 69iJ+5ZiE4L7DxPH2PP6etTOQC6TnpsWXAcZEDgr0LAku3unEQDVENNhHc+c3yT9yexaEylE9PK
 AjT7abrzqHbR7vK/dmEhUrZyOM9ftrwYLAOInvxj9RpDsMWQ70ucAUv9W+za9IMxVumS4isZIiq
 M3nE7krltmTPe0R87V/NUysI25CqibNnej6GXtlFFh+XY9+pQLKnmN30NJ7gQD8QN0pfeGmXrNs
 Wys2lrd+JhKgXMyC859V0T5osEEWqJVe4FUjzK8CzIf8rzSbpjUTOVmOoQk6U+O7SfUjCfLuoi+
 DZjfUPsgF5TgSr6SifVjlwADsS5npd1P8xpZCD3+ueBq6xM0p/ajmCAohrctFxn9hkPDOwKdaVQ
 q2t8wyms03ndgjy3rboOrs+aEssNppF3Y8DYfiTSg+GH4nZ9wN9Pm8L8tkjnkVtGYQBI0=
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

On 2026-06-24 15:49:32+01:00, Steven Price wrote:
> On 19/06/2026 13:41, Adrián Larumbe wrote:
> 
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
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 31cc57029c12..a8de4fe6b231 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -310,6 +310,9 @@ struct panthor_vm {
> >  		u64 end;
> >  	} kernel_auto_va;
> >  
> > +	/** @user_va_end: Last VA in the address range VM users can map objects against. */
> > +	u64 user_va_end;
> > +
> >  	/** @as: Address space related fields. */
> >  	struct {
> >  		/**
> > @@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
> >  		va_range = full_va_range;
> >  	}
> >  
> > +	vm->user_va_end = kernel_va_start - 1;
> > +
> >  	mutex_init(&vm->mm_lock);
> >  	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
> >  	vm->kernel_auto_va.start = auto_kernel_va_start;
> > @@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
> >  	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
> >  		return -EINVAL;
> >  
> > +	/* We don't allow mappings that overlap with kbo's reserved range */
> > +	if (op->va + op->size > vm->user_va_end)
> > +		return -EINVAL;
> 
> Minor issue, but this is off-by-one. If you attempt to map just the last
> page then op->va==kernel_va_start - PAGE_SIZE and op->size == PAGE_SIZE.
> But this check will reject it.
> 
> I suggest removing the "- 1" from user_vm_end, which also means it
> matches the user_va_range we pass back to user space (will appropriate
> comment/name updates).

On top of that, we need an overflow check on (op->va + op->size) for sparse
mappings. At the moment panthor_vm_prepare_map_op_ctx() does bound checks
for normal bindings, but since sparse mappings aren't bounded other than the
user/lernel VA space split, we'll need a fix for that to. I'll add another
Fixes: tag and reference the relevant sparse binding support commit.

> Thanks,
> Steve

Cheers,
Adrian
