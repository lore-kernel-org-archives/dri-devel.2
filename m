Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F3BCD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 09:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3570A10E9D6;
	Tue, 12 May 2026 09:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="oe7hHhrH";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3E52110E9D6
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 09:04:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47D47165C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:04:10 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 441723F85F
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778576655; bh=7/rHwnAjxk8POUQFzwEt3vTJKHKgkGpNUNJxDedCl60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oe7hHhrHati225RsORXeBQar7SIT94jNvKXwos/vr5j8klhhlTfMuooJ2oxM/M6rM
 gAJRmz/oB5kPE6Rv0yr2bJSwabtOWt7ZoDVqXTGUYo66rVLUB6rAABtsvLJCsQWO7T
 QoiAI/jJKMiOt25zcd8OaNThSiOoxgw88z8W08Uc=
Date: Tue, 12 May 2026 10:04:05 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 kernel@collabora.com,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panthor: Wrap register accessor helpers for type
 safety
Message-ID: <agLtBfZyYkHEoP3S@e142607>
References: <20260508-panthor-gpu-read-type-v1-1-733a9d8b3a11@collabora.com>
 <20260511135641.790f797d@fedora>
 <O_1AymfMSq2IN-FA9jyHHw@collabora.com>
 <20260511171207.69723480@fedora>
 <274d5844-f5ea-42f1-94e5-b4bc7f9dbaa1@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <274d5844-f5ea-42f1-94e5-b4bc7f9dbaa1@arm.com>
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

On Mon, May 11, 2026 at 04:55:22PM +0100, Steven Price wrote:
> On 11/05/2026 16:12, Boris Brezillon wrote:
> > On Mon, 11 May 2026 15:53:31 +0200
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> > 
> >>>   
> >>>>  {
> >>>>  	return readl_relaxed(iomem + reg);
> >>>>  }
> >>>>  
> >>>> -static inline void gpu_write64(void __iomem *iomem, u32 reg, u64 data)
> >>>> +/*
> >>>> + * The function signature of gpu_read/gpu_write/gpu_read_relaxed/... used to
> >>>> + * take a &struct panthor_device* as the first parameter. During the split of
> >>>> + * iomem ranges into individual sub-components, this was changed to take a
> >>>> + * void __iomem* instead. These wrappers exists Tto avoid situations wherein
> >>>> + * pre-refactor patches are applied in error, as they'd compile fine. That's
> >>>> + * because the old calling convention's first parameter implicitly casts to a
> >>>> + * void pointer.
> >>>> + */
> >>>> +
> >>>> +#define gpu_write(iomem, reg, data) ({					\
> >>>> +	static_assert(!__same_type((iomem), struct panthor_device *));	\  
> >>>
> >>> Hm, this only covers ptdev being passed as an iomem pointer. I know it's
> >>> the only case we had so far, but if we're going to add type enforcement,
> >>> I think I'd prefer if we were covered for more than just ptdev.
> >>>
> >>> One way of doing that would be to wrap the `void __iomem *iomem` in an
> >>> explicit type like:
> >>>
> >>> struct panthor_reg_bank {
> >>> 	void __iomem *iomem;
> >>> };
> >>>
> >>> which then gets passed to gpu_{read,write} helpers (see the diff below).  
> >>
> >> Hm, okay, the diff below is smaller than I feared. Though it doesn't get
> >> us type checking for someone, say, trying to read GPU_STATUS with the
> >> iomem of panthor_fw.
> > 
> > Yep, that's annoying, though solving that would require connecting reg
> > definitions (in panthor_xxx_regs.h) to a specific reg_bank, which is
> > only doable if we provide per-component accessors like:
> > 
> > #define mmu_reg(_mmu, _name) ((_mmu)->iomem + MMU_ ##)
> > 
> > #define mmu_read(_mmu, _name) gpu_read_iomem(mmu_reg(_mmu, _name))
> > #define mmu_write(_mmu, _name, _val) \
> > 	gpu_write_iomem(mmu_reg(_mmu, _name),_ val)
> > 
> >> But neither does my proposal below.
> >>
> >>>
> >>> The other way would be to pass the component, and have the macro
> >>> do the <component>->iomem deref, but there's a few places where reg banks
> >>> are accessed outside of the components that own them (panthor_hw.c).  
> >>
> >> Yeah, I prototyped going down something along that route by having
> >> the register accessors be generics that are implemented by each
> >> component, and it's a bit messy. Either you expose the struct
> >> definitions of individual components so that this header has visibility
> >> into them (not great), or you add boilerplate "do this accessor
> >> operation for this component" helpers for every component, which is both
> >> verbose and possibly causes the inlining to no longer work, though I have
> >> yet to verify that.
> >>
> >> If we do want to go down this route (though I'm not sure, since your
> >> reg bank solution seems to get us the same guarantees but without bringing
> >> generics into this), then the following may be an okay idea:
> >>
> >> I think having just the iomem deref genericised may be a good middle
> >> ground. If instead of making it a deref, we make it return the pointer
> >> to the member into the component that it can then deref, then the
> >> component-specific part can be pure (since offset of the iomem member
> >> is constant so for a particular pointer to a component, the pointer to
> >> the iomem member only depends on the passed-in pointer to component.)
> >>
> >> This should make sure that when the compiler gets
> >>
> >> panthor_gpu_write(ptdev->gpu, foo, bar);
> >> val = panthor_gpu_read(ptdev->gpu, baz);
> >>
> >> it can optimise the expanded
> >>
> >> iomem = *panthor_get_iomem_ptr(ptdev->gpu);
> >> panthor_actual_write(iomem, foo, bar);
> >> iomem = *panthor_get_iomem_ptr(ptdev->gpu);
> >> val = panthor_actual_read(iomem, baz);
> >>
> >> to the simplified
> >>
> >> iomem = *panthor_get_iomem_ptr(ptdev->gpu);
> >> panthor_actual_write(iomem, foo, bar);
> >> val = panthor_actual_read(iomem, baz);
> >>
> >> because panthor_get_iomem_ptr will be known to return the same value
> >> when called with the same input param.
> > 
> > Right, as long as the compiler sees the definition of
> > panthor_get_<component>_iomem_ptr() (which should be the case any time a
> > read/write happens inside the panthor_<component>.c compilation unit),
> > it hopefully inlines the whole thing and you get the iomem pointer from
> > a direct deref rather than a function call. LTO might even give us link
> > time optim for the bits in panthor_hw.c where the compiler can't see
> > through struct panthor_{gpu,pwr}.
> > 
> > This being said, there's still no guarantee that one would mix regs and
> > banks randomly, like
> > 
> > 	gpu_read(ptdev->mmu, GPU_ID);
> > 
> >>
> >> Anway, I think it's probably best if I abandon this and you just send
> >> your patch to the list with a real base. I only have one comment on it,
> >> which I've included inline.
> > 
> > Let's wait for Liviu's and Steve's feedback before taking any action,
> > cause that's still quite a lot of changes, and it's not clear it will
> > help much once we've got all the pending patchset rebased on misc-next
> > (that's a mistake you do once at rebase time, once you've got bitten,
> > you tend to be more careful ;-)).
> 
> This is always the problem with changing this sort of thing - I was
> somewhat wary of the whole split things by component series. But I think
> there's some hardware changes in the pipeline that effectively require
> something like that. And perhaps going forward the code will be slightly
> easier to reason about.

Yes, unfortunately Arch15 brings a lot of components shifting their relative
positions and some registers widening, which breaks the neat, generic thing
we had until now.

> 
> Boris' patch is certainly the neater - the static_assert is rather a
> point fix and doesn't solve the underlying problem. I'm beginning to
> wonder if we should have gone with a mmu_write/job_write/gpu_write()
> split at the function level. Which would have the benefit of not having
> to deal with iomem pointers.

Once the dust settles that would be my preferred option too. I don't like
the fact that we expose the iomem pointer everywhere and in some places
that's the start of the component block, in other is the start of the
registers handling IRQs, etc.

> 
> Ultimately as a C programmer I tend to feel it's a case of "once bitten,
> twice shy" and you learn to be careful around things like this. Rust
> programmers tend to have the opposite viewpoint and want the compiler to
> detect anything incorrect, but given it's a C driver I'm not sure there
> is a fully robust way of making this "safe".
> 
> TLDR; I'd be happy to merge (a fixed version of) Boris' patch (after
> some sanity testing). I'm not convinced it's worth trying too hard to
> introduce lots of type safety as C really doesn't give us the tools.

Yes, I'm happy with Boris' change. I'm also not convinced on the benefit
of trying to prevent future patches from using outdated versions of the
function signatures, unless someone ends up backporting them to kernels
that are old and things compile but get broken.

Best regards,
Liviu

> 
> Thanks,
> Steve
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
