Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C07105F78C
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5238910EBD4;
	Fri, 13 Mar 2026 12:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G7iHho2+";
	dkim-atps=neutral
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A900310EBAB
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 11:33:01 +0000 (UTC)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-56b069fed64so806420e0c.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773401580; x=1774006380; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=haCHU4tFbveJ6fRvm0o+9mw9xNWZ6TKNuvNCvrgL1/c=;
 b=G7iHho2+7CRel2qIdSHTjdECZVybbnHzMJTN1eJ5pxQnfu4UFY60ChtUIqNnIqgdsE
 v2gukwa7ldekyqXfcocl/qxjfRiM0Yt9J3/tgWr3ai8RD4DinWgyscVSCeQGAefi3hM8
 DLNUMyugnqyFd8A67uMHcRvlLvW9/z4OZ/pV/nEBl0sw3GBQo/tr0IefAxvk2dhPzOfY
 w7Vp4lSJJYZOM5t+iYulpTCzLPtW5lyADuQE8+YAo+tUftpGH2vW8BId5hR9EiImTgHF
 ZOgWHpUIB8aeiVymmxnCkd1njAsmy8wjZjzzc9DnCn4xtjThFYi7SZMt+wPayS7OZraP
 FjhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773401580; x=1774006380;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haCHU4tFbveJ6fRvm0o+9mw9xNWZ6TKNuvNCvrgL1/c=;
 b=hDgnlKq6XbsrXlRM8Ca7osHQSl5Kc4S4EtDBaJy4ZQgMA+2QdunizMyE30O28QsL8k
 8QMcCCfadTXyWcxjUoKdJnJL+aTA5MeHV13c7U/pw8lm0CBP3Q6S7eWjaRw0PoBLX4Sv
 P4Tt2iuh+dcGp3V3tsJlygglOLoUTvvlmZoTTSdpBNxdN+pTz5C1bF6sU7uvuoC7pSyi
 uSwJI8cRoSqaqj1pOj+/2bc03+gTZxStegYPaWKcCn1R5clVxvG0DjNuYK5sotqwZLKV
 cxsmAQDF1qzbm0OVw3bDjwcX9NhAtfF5s7BNU7HCHKSVG05rBF6VaV5qnEww3clGEnvu
 ke6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwYRjGkbBx8Ed3n7d9kD00VU2mSrX5bhZ5uuj9ALcRDY98MG/LOhJJlbxHMTKiEoplYaoRXpr+gOo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfRI7nKiS4F44isxHGcv5JI92X8nHCBlmzdSNy01nl3EWwnad8
 Gz2jUlTVH9pZsbD+9BMu83GAbTpIpdgclV9FGVX5S83T8Uu23j0Nh52F
X-Gm-Gg: ATEYQzxijN/Aoo3XDrD3LWQYf56Vr+l1s5vbPVOnxpqVuMm5xsAr4/eBR3ne3or1NOg
 OJBhQaQxpCbNZhYpyNLQg4Rpvhcs8wbWKpf2EoTBlI0193ZyoBjoUP+WR/WZwJD+UKbTxuyEYOK
 BGSHlEwofWFhG1R92Rq9xRSv5Ukhsd0jBbJxS/BarXfDjrJdHGJqLLh7NNLH2iQUVLCHd/ATq7Z
 z7lzSpL2vdluMS9qlowWVcEvDmTDBiUddlskqPVz9rmP2fAVyr26DOpW6fAJYqbJI6DBnNygzPA
 lbj1IF9Xp4y5OaTQnMEKkV4LvilQqRIrK55vSFIgHfdNLwwnrpcqPtO5kWd2smmhDnExMXWAnMV
 A/pBWwWkc3eTX2HpTHLoF/sop7jvAH472pLA4IVtQuo6yc0NnHGhNzkRyJ+8AIWdz79l4kk1NZ/
 jvd1cGCQYvbo81tnQ09OKuOBFBScxoAkhDy1AvcJ5l7jeUr8mNY+8eaBM=
X-Received: by 2002:a05:6102:374b:b0:5f5:3638:776f with SMTP id
 ada2fe7eead31-6020e585d6fmr921073137.25.1773401580535; 
 Fri, 13 Mar 2026 04:33:00 -0700 (PDT)
Received: from fedora ([177.73.136.69]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-601deaa379asm3104070137.8.2026.03.13.04.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 04:32:59 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:32:52 -0300
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Loic Molinari <loic.molinari@collabora.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/shmem-helper: Fix Map huge page mapping in fault
 handler
Message-ID: <abP0L_3O0yC2GdS5@fedora>
References: <20260312155027.1682606-1-pedrodemargomes@gmail.com>
 <20260312173227.7e9f0389@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312173227.7e9f0389@fedora>
X-Mailman-Approved-At: Fri, 13 Mar 2026 12:18:51 +0000
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

On Thu, Mar 12, 2026 at 05:32:27PM +0100, Boris Brezillon wrote: 
> Do we really need to duplicate everything? Can't we rename
> drm_gem_shmem_fault() into drm_gem_shmem_any_fault() with a
> `bool try_pmd` passed as an argument, and then have
> drm_gem_shmem_[huge_]fault() as wrappers?
> 
> static vm_fault_t drm_gem_shmem_huge_fault(struct vm_fault *vmf,
> 					   unsigned int order)
> {
> 	if (order != PMD_ORDER)
> 		return VM_FAULT_FALLBACK;
> 
> 	return drm_gem_shmem_any_fault(vmf, true);
> }
> 
> static vm_fault_t drm_gem_shmem_fault(struct vm_fault *vmf)
> {
> 	return drm_gem_shmem_any_fault(vmf, false);
> }
> 

Ack.

> > @@ -643,6 +667,9 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
> >  
> >  const struct vm_operations_struct drm_gem_shmem_vm_ops = {
> >  	.fault = drm_gem_shmem_fault,
> > +	#ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> > +	.huge_fault = drm_gem_shmem_huge_fault,
> > +	#endif
> 
> Let's keep the #ifdef unindented:
> 
> #ifdef CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP
> 	.huge_fault = drm_gem_shmem_huge_fault,
> #endif
> 
> >  	.open = drm_gem_shmem_vm_open,
> >  	.close = drm_gem_shmem_vm_close,
> >  };
>

Ack.
I will send a v2 addressing these issues.
Thanks.

