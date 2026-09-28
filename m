Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB66BCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:03:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24B9110E874;
	Mon, 28 Sep 2026 13:03:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="o2xCEyWX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2383910E5F1;
 Mon, 28 Sep 2026 13:03:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4718A60052;
 Mon, 28 Sep 2026 13:03:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF871F00893;
 Mon, 28 Sep 2026 13:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790600632;
 bh=LbDVoKu8g6bKdmdJ18P7XM+4AoDCrVi//WDEW2JBZn8=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=o2xCEyWXH2JklBG5d38zf8novVXr0bY4COQbWF34NBnstdMSAkKdLcFQcJALoADal
 Af9TyIG0mUmdTMcbZ05Uh07ODekJj45SRLfxSWwt6OTwwgbW0s35pKElg0UmmbwrqJ
 pMcdzYxk5/s3ISFcGwNBLcMgAl5yRzyPNOjNewCKcqEnqLqmAri17TNG+LYQX9HHn6
 rXlFLwcSB/a8xKkl14sglrQKlx1MUgUiTp+SnQyqRnEgB6HnpOpZPAWIHiH9Tduu0k
 jYA67gKjX7L35GP+aeb/GBPXA2BxSlYroijCYUSqMGyCW/ipABlSPPRqod7c44A7d7
 wLzj5eDBxfh8g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 15:03:48 +0200
Message-Id: <DLQYY4O71Q54.2FZ1ZV8G5ZZPN@kernel.org>
Subject: Re: [PATCH v3 0/3] drm, drm/xe: Protect against premature module
 unloads
Cc: <intel-xe@lists.freedesktop.org>, "Matthew Brost"
 <matthew.brost@intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Matthew Auld" <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <DLOJ7S2IZW0R.2BNLLO5M3YL7M@kernel.org>
 <7fc614d0b666fb5ae9777c29ea2e79647030b198.camel@linux.intel.com>
 <DLQVBJX4PK5G.2AK3E5K8U8UY7@kernel.org>
 <fdbc3d2ed7b23b09216df023e2be9ed707820c75.camel@linux.intel.com>
In-Reply-To: <fdbc3d2ed7b23b09216df023e2be9ed707820c75.camel@linux.intel.com>
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

On Mon Sep 28, 2026 at 2:13 PM CEST, Thomas Hellstr=C3=B6m wrote:
> On Mon, 2026-09-28 at 12:13 +0200, Danilo Krummrich wrote:
>> On Mon Sep 28, 2026 at 10:46 AM CEST, Thomas Hellstr=C3=B6m wrote:
>> > On Fri, 2026-09-25 at 18:18 +0200, Danilo Krummrich wrote:
>> > > On Fri Sep 25, 2026 at 3:33 PM CEST, Thomas Hellstr=C3=B6m wrote:
>> > > > Driver and shared DRM helper code is increasingly relying on
>> > > > bare
>> > > > drm_device references (drm_dev_get()/drm_dev_put()) to keep a
>> > > > device's
>> > > > software state around, without also pairing that with a
>> > > > reference
>> > > > on
>> > > > the owning kernel module. Xe itself does this in several
>> > > > places,
>> > > > and
>> > > > so does drm_gpuvm for the lifetime of a GPU VM. None of these
>> > > > references currently prevent the owning module from being
>> > > > unloaded
>> > > > while they, or the teardown work they can still trigger, are
>> > > > outstanding, meaning driver code can end up executing after its
>> > > > own
>> > > > module's text has already been freed.
>> > >=20
>> > > Since you mention DRM GPUVM in a couple of places, how can this
>> > > ever
>> > > happen? It
>> > > wouldn't make sense to keep a VM alive beyond driver unbind. I.e.
>> > > it
>> > > can't make
>> > > its drm_device reference count reach module unload in the first
>> > > place.
>> >=20
>> > There seems to be a bit of misunderstanding here.
>> >=20
>> > Driver unbind removes the struct device from the driver, triggers
>> > device unplug, and eventually the devres release actions. IIRC the
>> > last
>> > devres action removes a *single reference* on the struct
>> > drm_device.
>>=20
>> Correct.
>>=20
>> > Hence if there exists other reference holders on the struct
>> > drm_device
>> > (open files, exported dma-bufs, exported drm_pagemaps as an
>> > example),
>> > the drm_device will survive the driver unbind. So will open files
>> > and
>> > thus drm_gpuvms until user-space decides to remove them.
>>=20
>> There's two lifetimes we have to deal with in drivers: the lifetime
>> of (bus /
>> physical) device resources, which are managed by the driver and the
>> software
>> state that is represented through the class device to userspace (e.g.
>> file
>> handles).
>>=20
>> The former is bounded to the scope where the driver is bound to the
>> device and
>> the latter is unbounded and indeed depends on userspace.
>>=20
>> Either the subsystem or the driver has to decouple those lifetimes.
>> I.e. if the
>> driver is unbound it should clean up all GPUVMs as they represent the
>> GPU's
>> virtual address space and hence are associated with the hardware.
>> However, the
>> driver should not operated the hardware anymore after driver unbind.
>
> I disagree here. At unbind time we decouple the HW and SW state, The
> device no longer uses it's pointers to the page-table so, for example
> VRAM page-tables can be torn down, system page-tables lose their dma-
> mappings, but in xe we don't tear down the page-table structure itself.
>
> If HW accesses are properly protected by drm_dev_enter() /
> drm_dev_exit(), Hw won't be accessed after unbind.
>
>
>>=20
>> So, in your case it seems that file lifetime and VM lifetime are
>> conflated
>> although they should be separate.
>
> I view the VM as software state, page-table pointers, dma-mappings and
> VRAM storage as HW state.
>
> It seems like what we're not agreeing on is where to separate those. I
> see no reason as to why we would complicate the driver to remove more
> than necessary at unbind time?

This can certainly be done, correct. But, the VM itself represents a GPU's
virtual address space and takes ownership of the corresponding hardware
resources.

We can indeed revoke the hardware resources from the VM implementation and
leave it in place. But this messes with the ownership model within the VM
implementation:

Because now, and you say this a couple of times below, we need to guard all
relevant entry points into the VM code with guards, such as
drm_dev_{enter/exit}().

IOW, it creates partially uninitialized structures with stale pointers that=
 we
now have to guard against.

It makes much more sense to tear down everything that owns device resources=
 on
driver unbind. I.e. why keep structures with stale pointers around that we =
have
to guard against in the first place?

It also gets us rid of the module unload issue as it allows us to prevent
callbacks into the driver code after driver unbind on the subsystem level.

>> We can't have userspace to decide when we drop device resources, such
>> as DMA
>> mappings, I/O memory mappings, etc.
>
> We don't (Unless we have bugs, and you may have stumbled on those
> below?) Those should be removed at unbind time. We should also revoke
> dma-buf mappings and SVM migrates all dma-buf mappings to system.
>
>>=20
>> > Files, dma-bufs and drm_pagemaps all hold a driver module reference
>> > until they have successfully released the drm_device. The
>> > requirement
>> > is "If a drm_device reference is held, a module reference of the
>> > driver
>> > providing the drm_device must also be held, or if it's held by the
>> > driver itself, it must ensure at driver unload time that any
>> > drm_device
>> > references it holds are released and drmm release callbacks have
>> > finished executing."
>> >=20
>> > What this series in effect does is to change this to to "The driver
>> > won't unload until all drm_device references are gone, and all drmm
>> > release callbacks have finished executing."
>> >=20
>> > I agree that the use of drm_gpuvm in the documentation is a bit
>> > unfair.
>> > Since the code calling drm_dev_get() and drm_dev_put() is intended
>> > to
>> > be called from the driver, the reference in effect becomes the
>> > driver's
>> > responsibility, but if someone would, in the future change that so
>> > that
>> > those references are put from a worker from within the driver or
>> > even
>> > within drm_gpuvm itself, things would break. If a future code
>> > reviewer,
>> > developer or AI agent knows about the new drm_device reference
>> > guarantee, then that will lessen the review scope and code will
>> > become
>> > more rubost.
>> >=20
>> > >=20
>> > > Besides that, can you please remind me whether there are any
>> > > other
>> > > reasons than
>> > > the release() callback why a DRM device must not outlive module
>> > > unload?
>> >=20
>> > The drmm release callbacks.
>>=20
>> Right, I forgot about them for a second. However, they are similar to
>> the
>> release() callbacks as in they are the wrong cleanup model for driver
>> private
>> structures.
>>=20
>> drmm is a great tool for common subsystem structures that lifetime
>> wise tie to
>> the drm_device. But it is the wrong lifetime model for stuff that is
>> used to
>> operate the device, as this should be torn down on device unbind.
>
> The current model used by xe (and amdgpu AFACT, that also ties vm
> lifetime to file lifetime) is to block all hardware access and dma at
> unbind time. The rest is state that doesn't necessarily need to be torn
> down at unbind time. I believe the current separation is mostly done
> with drm_dev_enter() / drm_dev_exit() and why should we enforce a
> change of that? I'd say the drivers should be free to release what's
> convenient.

See the reasons above, it is not a good layer for the lifetime decoupling.

> Also if drm_gpuvms are designed to not outlive the struct device, why
> do they need to take a struct drm_device reference in the first place,
> I mean I brought this problem up then and IIRC I think you argued the
> reference was needed and punted any problems it caused to the drivers?

The lifetime of the hardware resources that are owned by a GPUVM implementa=
tion
is restricted by the underlying bus device (e.g. PCI) being bound to the dr=
iver.

The lifetime of the DRM device as a class device is technically independent=
, it
can live longer (which is likely), but it could technically also be shorter
lived (which drivers don't do in practice). But even though drivers don't d=
o
this in practice, the dependency should be expressed: if GPUVM stores a poi=
nter
to a DRM device, it has to take a reference count.

>> I had a quick look at Xe and found this for instance:
>>=20
>> 	 drmm_add_action_or_reset(&xe->drm, control_fini_action, gt)
>>=20
>> control_fini_action() stops a worker that writes device registeres,
>> which must
>> not be done after driver unbind anymore.
>>=20
>> Now, there's two options, either after driver unbind this work is
>> never running
>> (which would be correct), but then this could have been
>> devm_add_action_or_reset(), or it does actually run after driver
>> unbind, but
>> this would violate the driver model.
>
> Agreed, Unless there is something protecting the hardware access after
> unplug in that control subsystem, that's a genuine bug, but that's
> separate from this discussion

I argue that it is related; surely, we can keep everything around until the=
 DRM
device is destroyed and just guard every single (callback) entry point.

But, that's far more complicated and error prone than just shutting down th=
e hardware
on driver unbind and tear down all entry points on the subsystem level; it
messes with the ownership model of structures leaving stale pointers behind=
.

As mentioned, this is what subsystems commonly do in the kernel, and I don'=
t see
why DRM would be special in this regard.

>> > > I don't think the correct solution is to constrain module unload.
>> > > The
>> > > release()
>> > > callback shouldn't really do anything other than free the memory
>> > > of
>> > > the
>> > > drm_device allocation. All other resources a driver may have
>> > > should
>> > > be released
>> > > on driver unbind.
>> >=20
>> > That is not true. See above.
>>=20
>> I know it is not true in practice, but we are doing the wrong thing.
>> We are
>> conflating the unbounded userspace lifetime with the bounded lifetime
>> from the
>> driver model.
>
> I don't think we are. As long as all HW access is given up or blocked,
> we're fine.

Right, what you describe above works, but it leaves stale pointers and inva=
lid
structures behind that we then need to guard against.

>> I also know that we can't fix this easily, but I want to create some
>> awareness,
>> especially when we introduce more band aid for the status quo, such
>> that we can
>> subsequently address the fundamental lifetime problems.
>>=20
>> > > There may be shared resources, such as e.g. a common workqueue,
>> > > but
>> > > those are
>> > > module level things that have nothing to do with the DRM device.
>> >=20
>> > I don't think that is correct either. Take a look at Matt Brost
>> > reply
>> > to patch 3 there where he points out that the drm device (a base
>> > class
>> > of the xe device) is acually referenced in a work item after the
>> > struct
>> > drm_device reference is put. (There is a workqueue naming confusion
>> > in
>> > xe, but I do believe that patch needs a fix). With the poposed
>> > series
>> > in place a simple fix would be to hold a drm_device reference
>> > across
>> > the workqueue item. The unload process would then block until all
>> > devices are unreferenced, and then again at destroy_worqueue time
>> > waiting for the work item epilogue to finish executing.
>>=20
>> Well, but the workqueue itself has a bounded lifetime, which should
>> either be
>> driver unbind or module unload (when shared between driver
>> instances). The work
>> items themselves should ideally not extend beyond driver unbind,
>> because there
>> shouldn't be anything to do for the driver after unbind, because all
>> the
>> hardware should be torn down and not touched at this point anymore.
>
> Hardware isn't touched but I don't think there is any reason for
> cleanup tasks to stop executing at unbind time?

Well, it has the implications as stated above. And it means that instead of
having a global SRCU read side critical section for a global entry point, w=
e are
forced to leave invalid pointers behind and have drivers protect them each
individually with SRCU (i.e. drm_dev_enter() / drm_dev_exit()).

>> I had another brief look at Xe and found this:
>>=20
>> 	drmm_add_action_or_reset(&xe->drm, ggtt_fini_early, ggtt)
>>=20
>> where ggtt_fini_early() destroys a workqueue. It also calls
>>=20
>> 	drm_mm_takedown(&ggtt->mm);
>>=20
>> which IIUC is the range allocator for the global GTT. (The hardware
>> is gone on
>> driver unbind (i.e. no more GGTT is available for the driver), so
>> there's
>> shouldn't be a need for this drm_mm to live longer than driver
>> unbind).
>
> Yes, this *can* probably be taken down at unbind time at the expense of
> subsystem and structure validity checking, but it doesn't have to.

Same reasoning as above.

>> This model ties the lifetime of all shorter lived resources that are
>> bounded to
>> the driver unload scope to the unbounded lifetime of the drm_device
>> that is
>> controlled by userspace.
>>=20
>> I.e. the model is backwards and hence also extends your driver
>> structures and
>> callback entry points not only beyond driver unbind, but also
>> potentially beyond
>> module unload.
>>=20
>> If it would be done the other way around, tear down everything on
>> driver unload,
>> and then use default trampolines for userspace still trying to call
>> into the
>> driver (which is also what DMA fence does and other subsystem do),
>> all those
>> issues go away.
>
> But that is arguably something that's never going to happen, and even
> if it is, I think that's mostly orthogonal to code keeping references
> to drm_device.

Well, I hope we can move to this model eventually.

I don't think it is orthogonal, if we don't have driver entry pointer after
driver unbind anymore, there is no module unload problem anymore. And struc=
ts
that keep a reference to a struct drm_device shouldn't be a problem in this
regard either.

>> > > > - Patch 3 fixes a related, previously unprotected case where
>> > > > the
>> > > > =C2=A0 teardown of a GPU VM or its address space mappings can be
>> > > > deferred
>> > > > =C2=A0 to run at an arbitrary later time, including after module
>> > > > unload
>> > > > has
>> > > > =C2=A0 already completed.
>> > >=20
>> > > Huh? GPUVM tracks the GPU's VA space mappings, but after driver
>> > > unbind there's
>> > > no access to the GPU to manage anything anymore. How can this
>> > > even
>> > > work?
>> >=20
>> > As previously mentioned, software device state may well outlive a
>> > driver unbind. This is all about its cleanup.
>>=20
>> GPUVM shouldn't be lifetime wise tied to a software state, it
>> represents
>> hardware resoruces.
>
> So then we can remove it's drm device reference? Why would it need to
> keep a reference to the software state guaranteed to outlive it?

There is no structural guarantee that it can't happen that the DRM device i=
s
destroyed first, then GPUVM and then the driver is unbound.

> Regardless, I can remove all mentions of GPUVM in the documentation,

That's not my main concern, but I found it to be a good example for what
actually is my concern:

The lifetime model in DRM often conflates software and hardware state
structurally; whether the consequence is either that we just keep hardware
resources alive for longer than they should be alive, or whether we tear th=
em
down and leave invalid pointers behind that we then protect with lots of ma=
nual
guard sections does not matter too much for me. Both is a consequence of th=
e
structurally conflated lifetime and ownership.

> but that doesn't remove the fact that keeping a reference to a struct
> drm_device without a module reference or a module presence guarantee is
> extremely fragile, and will be also in a model that removes a larger
> part of its software state at unbind time. IMO removing that fragility
> is a good thing.

Don't get me wrong, I don't object to this patch series. Well, at least not=
 too
much, requiring drivers to call drm_dev_release_barrier() in module unload =
is
pretty ugly, and I don't know any other subsystem that has such a guard, be=
cause
they do structurally prevent callbacks into drivers after driver unbind and
drivers hence tie the lifetime of structures to driver unbind.

But then there's reality and the things are as they are right now, so it mi=
ght
just be necessary. However, I hope that in the future we can improve this a=
nd
have the subsystem provide the required guards on the subsystem callback le=
vel.
