Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F908CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 14:34:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0BC810E78C;
	Mon, 11 May 2026 14:34:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UOssy0za";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50ACF10E78C
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778510057;
 bh=+EtlGDMNHag4LPtxK77nadoZyLknYFRarBU9wYVDM3k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=UOssy0zaKsUMqNst00nQotyB/EAJpDX6Bg2Gf3poDJDZCiQsBxZNtB1IplatHf3sV
 KceO+u2zh27hArp69y47euOYCxvhhDWfMDkYN8u3a8iMoXW1N7UalRLeZ2Dg3GKpoB
 LKv4/8VO14oNMh0gXhFTK4MovZlJzMJOMarQvmeAPuVm2Dn+WlB4b+37txLVG+bzJA
 w4zKpGWLP6ME2TFA7HTpJZK2wmbtWJwW+M9eyFOv81W68biriH0qihY25nZkfRI9mD
 WY194+LGg8vq+iXBh+sP+RfkcBHo91rm33wVAJwY8YShc7dTjihJv1A5UETK2h2AnW
 Fzw2vd/UjZpjw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9415917E0698;
 Mon, 11 May 2026 16:34:16 +0200 (CEST)
Date: Mon, 11 May 2026 16:34:13 +0200
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
Message-ID: <20260511163413.73f77e6b@fedora>
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

> On Monday, 11 May 2026 13:56:41 Central European Summer Time Boris Brezillon wrote:
> > Hi Nicolas,
> > 
> > On Fri, 08 May 2026 20:00:54 +0200
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:
> >   
> > > In Commit a8f5738779a9 ("drm/panthor: Pass an iomem pointer to GPU
> > > register access helpers"), the gpu register access helpers were changed
> > > from taking a pointer to a struct panthor_device in their first
> > > argument, to taking a void pointer.
> > > 
> > > This can cause problems, as patches based on panthor before this change
> > > will still compile fine after it. struct panthor_device * implicitly
> > > casts to a void pointer, resulting in completely wrong semantics.
> > > 
> > > Prevent this problem by wrapping the affected functions with macros that
> > > specifically check for and reject the struct panthor_device * type as
> > > the first argument.
> > > 
> > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > ---
> > >  drivers/gpu/drm/panthor/panthor_device.h | 68 +++++++++++++++++++++++++-------
> > >  1 file changed, 53 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> > > index 4e4607bca7cc..91e9f499bf69 100644
> > > --- a/drivers/gpu/drm/panthor/panthor_device.h
> > > +++ b/drivers/gpu/drm/panthor/panthor_device.h
> > > @@ -630,49 +630,87 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
> > >  
> > >  extern struct workqueue_struct *panthor_cleanup_wq;
> > >  
> > > -static inline void gpu_write(void __iomem *iomem, u32 reg, u32 data)
> > > +static inline void _gpu_write(void __iomem *iomem, u32 reg, u32 data)
> > >  {
> > >  	writel(data, iomem + reg);
> > >  }
> > >  
> > > -static inline u32 gpu_read(void __iomem *iomem, u32 reg)
> > > +static inline u32 _gpu_read(void __iomem *iomem, u32 reg)
> > >  {
> > >  	return readl(iomem + reg);
> > >  }
> > >  
> > > -static inline u32 gpu_read_relaxed(void __iomem *iomem, u32 reg)
> > > +static inline u32 _gpu_read_relaxed(void __iomem *iomem, u32 reg)  
> > 
> > First off, I'm not a huge fan of these _ prefixes to convey the "internal,
> > don't use directly" information. If we're going to have macros around these
> > helpers (meaning these helpers won't be used directly), I'd rather have a
> > fully descriptive name like gpu_{write,read}_iomem[_relaxed]() and a comment
> > stating that they should never be used.  
> 
> Agreed.
> 
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
> iomem of panthor_fw. But neither does my proposal below.
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
> 
> Anway, I think it's probably best if I abandon this and you just send
> your patch to the list with a real base. I only have one comment on it,
> which I've included inline.
> 
> > 
> > Regards,
> > 
> > Boris
> >   
> > --->8---  
> > [... snip ...]
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index 9d4500850561..d4cc105afe24 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -55,8 +55,8 @@ struct panthor_as_slot {
> >   * struct panthor_mmu - MMU related data
> >   */
> >  struct panthor_mmu {
> > -       /** @iomem: CPU mapping of MMU_AS_CONTROL iomem region */
> > -       void __iomem *iomem;
> > +       /** @regs: CPU mapping of MMU_AS_CONTROL iomem region */
> > +       struct panthor_reg_bank regs;
> >  
> >         /** @irq: The MMU irq. */
> >         struct panthor_irq irq;
> > @@ -527,7 +527,7 @@ static int wait_ready(struct panthor_device *ptdev, u32 as_nr)
> >         /* Wait for the MMU status to indicate there is no active command, in
> >          * case one is pending.
> >          */
> > -       ret = gpu_read_relaxed_poll_timeout_atomic(mmu->iomem, AS_STATUS(as_nr), val,
> > +       ret = gpu_read_relaxed_poll_timeout_atomic(mmu->regs, AS_STATUS(as_nr), val,
> >                                                    !(val & AS_STATUS_AS_ACTIVE), 10, 100000);
> >  
> >         if (ret) {
> > @@ -545,7 +545,7 @@ static int as_send_cmd_and_wait(struct panthor_device *ptdev, u32 as_nr, u32 cmd
> >         /* write AS_COMMAND when MMU is ready to accept another command */
> >         status = wait_ready(ptdev, as_nr);
> >         if (!status) {
> > -               gpu_write(ptdev->mmu->iomem, AS_COMMAND(as_nr), cmd);
> > +               gpu_write(ptdev->mmu->regs, AS_COMMAND(as_nr), cmd);
> >                 status = wait_ready(ptdev, as_nr);
> >         }
> >  
> > @@ -598,9 +598,9 @@ static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
> >         panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
> >                                       panthor_mmu_as_fault_mask(ptdev, as_nr));
> >  
> > -       gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
> > -       gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
> > -       gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), transcfg);
> > +       gpu_write64(mmu->regs, AS_TRANSTAB(as_nr), transtab);
> > +       gpu_write64(mmu->regs, AS_MEMATTR(as_nr), memattr);
> > +       gpu_write64(mmu->regs, AS_TRANSCFG(as_nr), transcfg);
> >  
> >         return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
> >  }
> > @@ -636,9 +636,9 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
> >         if (recycle_slot)
> >                 return 0;
> >  
> > -       gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), 0);
> > -       gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), 0);
> > -       gpu_write64(mmu->iomem, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> > +       gpu_write64(mmu->regs, AS_TRANSTAB(as_nr), 0);
> > +       gpu_write64(mmu->regs, AS_MEMATTR(as_nr), 0);
> > +       gpu_write64(mmu->regs, AS_TRANSCFG(as_nr), AS_TRANSCFG_ADRMODE_UNMAPPED);
> >  
> >         return as_send_cmd_and_wait(ptdev, as_nr, AS_COMMAND_UPDATE);
> >  }
> > @@ -791,7 +791,7 @@ int panthor_vm_active(struct panthor_vm *vm)
> >          */
> >         fault_mask = panthor_mmu_as_fault_mask(ptdev, as);
> >         if (ptdev->mmu->as.faulty_mask & fault_mask) {
> > -               gpu_write(ptdev->mmu->irq.iomem, INT_CLEAR, fault_mask);
> > +               gpu_write(ptdev->mmu->irq.regs, INT_CLEAR, fault_mask);
> >                 ptdev->mmu->as.faulty_mask &= ~fault_mask;
> >         }
> >  
> > @@ -1738,7 +1738,7 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
> >         mutex_lock(&ptdev->mmu->as.slots_lock);
> >         if (vm->as.id >= 0 && size) {
> >                 /* Lock the region that needs to be updated */
> > -               gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
> > +               gpu_write64(ptdev->mmu->regs, AS_LOCKADDR(vm->as.id),
> >                             pack_region_range(ptdev, &start, &size));
> >  
> >                 /* If the lock succeeded, update the locked_region info. */
> > @@ -1800,8 +1800,8 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
> >                 u32 access_type;
> >                 u32 source_id;
> >  
> > -               fault_status = gpu_read(mmu->iomem, AS_FAULTSTATUS(as));
> > -               addr = gpu_read64(mmu->iomem, AS_FAULTADDRESS(as));
> > +               fault_status = gpu_read(mmu->regs, AS_FAULTSTATUS(as));
> > +               addr = gpu_read64(mmu->regs, AS_FAULTADDRESS(as));
> >  
> >                 /* decode the fault status */
> >                 exception_type = fault_status & 0xFF;
> > @@ -1832,7 +1832,7 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
> >                  * Note that COMPLETED irqs are never cleared, but this is fine
> >                  * because they are always masked.
> >                  */
> > -               gpu_write(mmu->irq.iomem, INT_CLEAR, mask);
> > +               gpu_write(mmu->irq.regs, INT_CLEAR, mask);
> >  
> >                 if (ptdev->mmu->as.slots[as].vm)
> >                         ptdev->mmu->as.slots[as].vm->unhandled_fault = true;
> > @@ -3255,7 +3255,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
> >         if (ret)
> >                 return ret;
> >  
> > -       mmu->iomem = ptdev->iomem + MMU_AS_BASE;
> > +       mmu->regs.iomem = ptdev->iomem + MMU_AS_BASE;
> >         ptdev->mmu = mmu;
> >  
> >         irq = platform_get_irq_byname(to_platform_device(ptdev->base.dev), "mmu");
> > @@ -3264,7 +3264,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
> >  
> >         ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
> >                                       panthor_mmu_fault_mask(ptdev, ~0),
> > -                                     ptdev->iomem + MMU_INT_BASE);
> > +                                     mmu->regs.iomem + MMU_INT_BASE);  
> 
> This is wrong. Before, we used an effective whole-device offset of 0x2000.
> Now it's 0x4400.

Uh, right. I hate the fact sometimes xxx_INT_BASE is some offset into
the the xxx_BASE regbank (GPU_INT_BASE), and other times
({MMU,JOB}_INT_BASE), it's an absolute offset from the start of the
whole IO region.
