Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0F2CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 15:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E084010E7D3;
	Mon, 11 May 2026 15:12:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="egMCxhEa";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F2810E7D3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778512330;
 bh=MFENZ4IvnRLDiAxhWlbpAStaP0Sjba2UXqKDzZyF6Z0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=egMCxhEasf/qfX+Nj/nspopH7DsaQKvjHcJHhCWcWwyHHjKLySy34QhimEBg/GwOh
 g3VUjs77a9XeQK8RKBfQAXBVVrbe+wXB6nsC3c6NlTATqFJISpaLz0vZRReoV2tNGx
 pV/VDHILWgXAIJqDaUNLHeGg9/gPWloCoO21gqH30HuogtLAH+40FYkfIzgtvUDclL
 4PmxbMMXNVReYIMHcfFIdHFyQA8qwP0O6dYEHK71ODbFHsl/MWj0gStuFhZSIDTP5j
 6zEfWHgl4XIq1RdmuIGoM3whcS18B0ubPObWB3iNqNlkMgrlAXAht9ic0+BILi7hGd
 OPYdflhxWmhcg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 65BAB17E040C;
 Mon, 11 May 2026 17:12:10 +0200 (CEST)
Date: Mon, 11 May 2026 17:12:07 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, Steven Price <steven.price@arm.com>, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Wrap register accessor helpers for type
 safety
Message-ID: <20260511171207.69723480@fedora>
In-Reply-To: <O_1AymfMSq2IN-FA9jyHHw@collabora.com>
References: <20260508-panthor-gpu-read-type-v1-1-733a9d8b3a11@collabora.com>
 <20260511135641.790f797d@fedora>
 <O_1AymfMSq2IN-FA9jyHHw@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Mon, 11 May 2026 15:53:31 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

> >   
> > >  {
> > >  	return readl_relaxed(iomem + reg);
> > >  }
> > >  
> > > -static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> > > +/*
> > > + * The function signature of gpu_read/gpu_write/gpu_read_relaxed/... used to
> > > + * take a &struct panthor_device* as the first parameter. During the split of
> > > + * iomem ranges into individual sub-components, this was changed to take a
> > > + * void __iomem* instead. These wrappers exists Tto avoid situations wherein
> > > + * pre-refactor patches are applied in error, as they'd compile fine. That's
> > > + * because the old calling convention's first parameter implicitly casts to a
> > > + * void pointer.
> > > + */
> > > +
> > > +#define gpu_write(iomem, reg, data) ({					\
> > > +	static_assert(!__same_type((iomem), struct panthor_device *));	\  
> > 
> > Hm, this only covers ptdev being passed as an iomem pointer. I know it's
> > the only case we had so far, but if we're going to add type enforcement,
> > I think I'd prefer if we were covered for more than just ptdev.
> > 
> > One way of doing that would be to wrap the `void __iomem *iomem` in an
> > explicit type like:
> > 
> > struct panthor_reg_bank {
> > 	void __iomem *iomem;
> > };
> > 
> > which then gets passed to gpu_{read,write} helpers (see the diff below).  
> 
> Hm, okay, the diff below is smaller than I feared. Though it doesn't get
> us type checking for someone, say, trying to read GPU_STATUS with the
> iomem of panthor_fw.

Yep, that's annoying, though solving that would require connecting reg
definitions (in panthor_xxx_regs.h) to a specific reg_bank, which is
only doable if we provide per-component accessors like:

#define mmu_reg(_mmu, _name) ((_mmu)->iomem + MMU_ ##)

#define mmu_read(_mmu, _name) gpu_read_iomem(mmu_reg(_mmu, _name))
#define mmu_write(_mmu, _name, _val) \
	gpu_write_iomem(mmu_reg(_mmu, _name),_ val)

> But neither does my proposal below.
> 
> > 
> > The other way would be to pass the component, and have the macro
> > do the <component>->iomem deref, but there's a few places where reg banks
> > are accessed outside of the components that own them (panthor_hw.c).  
> 
> Yeah, I prototyped going down something along that route by having
> the register accessors be generics that are implemented by each
> component, and it's a bit messy. Either you expose the struct
> definitions of individual components so that this header has visibility
> into them (not great), or you add boilerplate "do this accessor
> operation for this component" helpers for every component, which is both
> verbose and possibly causes the inlining to no longer work, though I have
> yet to verify that.
> 
> If we do want to go down this route (though I'm not sure, since your
> reg bank solution seems to get us the same guarantees but without bringing
> generics into this), then the following may be an okay idea:
> 
> I think having just the iomem deref genericised may be a good middle
> ground. If instead of making it a deref, we make it return the pointer
> to the member into the component that it can then deref, then the
> component-specific part can be pure (since offset of the iomem member
> is constant so for a particular pointer to a component, the pointer to
> the iomem member only depends on the passed-in pointer to component.)
> 
> This should make sure that when the compiler gets
> 
> panthor_gpu_write(ptdev->gpu, foo, bar);
> val = panthor_gpu_read(ptdev->gpu, baz);
> 
> it can optimise the expanded
> 
> iomem = *panthor_get_iomem_ptr(ptdev->gpu);
> panthor_actual_write(iomem, foo, bar);
> iomem = *panthor_get_iomem_ptr(ptdev->gpu);
> val = panthor_actual_read(iomem, baz);
> 
> to the simplified
> 
> iomem = *panthor_get_iomem_ptr(ptdev->gpu);
> panthor_actual_write(iomem, foo, bar);
> val = panthor_actual_read(iomem, baz);
> 
> because panthor_get_iomem_ptr will be known to return the same value
> when called with the same input param.

Right, as long as the compiler sees the definition of
panthor_get_<component>_iomem_ptr() (which should be the case any time a
read/write happens inside the panthor_<component>.c compilation unit),
it hopefully inlines the whole thing and you get the iomem pointer from
a direct deref rather than a function call. LTO might even give us link
time optim for the bits in panthor_hw.c where the compiler can't see
through struct panthor_{gpu,pwr}.

This being said, there's still no guarantee that one would mix regs and
banks randomly, like

	gpu_read(ptdev->mmu, GPU_ID);

> 
> Anway, I think it's probably best if I abandon this and you just send
> your patch to the list with a real base. I only have one comment on it,
> which I've included inline.

Let's wait for Liviu's and Steve's feedback before taking any action,
cause that's still quite a lot of changes, and it's not clear it will
help much once we've got all the pending patchset rebased on misc-next
(that's a mistake you do once at rebase time, once you've got bitten,
you tend to be more careful ;-)).
