Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C77CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E3210E89E;
	Mon, 28 Sep 2026 13:37:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HB5sFFc0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D638610EA7C;
 Mon, 28 Sep 2026 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790602668; x=1822138668;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=hS6xfJWEbfuIPdT5hJbkJ0BHqfUtsx5i7RXJJ6v6V9U=;
 b=HB5sFFc05PTCZPmi0oLFsJ35mVvyNk0VGSRgdBsy4NfCCbhSTq2zFZeZ
 k1G31neKmweK/y8i3ndXYAavPxjLciTnyDp7YGS2g7byFV+iKC+skbJ8O
 4QLPs5lfRmf9anMOc4LukIezcPePdca5+xlJ+KEC94HZH7Rv098vGMyMk
 IKedxndcpzlc6s1l5Zj3xoWiZVA+/ccsQr+0+FcuFC3geIbQfXJmZ07P9
 eibICXyf3RGTFsiwpH866nKoRPYIoDMLyI3SeDYz2Umo5QQriho1g2xTQ
 97pzr+4pcvjQedCx1lqCvf2ULexmJgVAGqVMwJ8DlLnSpK/9zd+mYUsy7 g==;
X-CSE-ConnectionGUID: DThYiD09RNGS2wtpHVRO7Q==
X-CSE-MsgGUID: uq++3jAJSqWjCJSPBryCFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94181223"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="94181223"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:37:47 -0700
X-CSE-ConnectionGUID: xcNV15dRS4WrYBis+TsONQ==
X-CSE-MsgGUID: IhTRK3xzSeWZLkubQ3+hSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="272853920"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.73])
 ([10.245.244.73])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 06:37:45 -0700
Message-ID: <3389776905c6ef2c20b2b3dd78041ea5db638a96.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/3] drm, drm/xe: Protect against premature module
 unloads
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: intel-xe@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, 	dri-devel@lists.freedesktop.org, Alice Ryhl
 <aliceryhl@google.com>, Alex Deucher	 <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>
Date: Mon, 28 Sep 2026 15:37:42 +0200
In-Reply-To: <DLQYY4O71Q54.2FZ1ZV8G5ZZPN@kernel.org>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <DLOJ7S2IZW0R.2BNLLO5M3YL7M@kernel.org>
 <7fc614d0b666fb5ae9777c29ea2e79647030b198.camel@linux.intel.com>
 <DLQVBJX4PK5G.2AK3E5K8U8UY7@kernel.org>
 <fdbc3d2ed7b23b09216df023e2be9ed707820c75.camel@linux.intel.com>
 <DLQYY4O71Q54.2FZ1ZV8G5ZZPN@kernel.org>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
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

On Mon, 2026-09-28 at 15:03 +0200, Danilo Krummrich wrote:
> On Mon Sep 28, 2026 at 2:13 PM CEST, Thomas Hellstr=C3=B6m wrote:
> > On Mon, 2026-09-28 at 12:13 +0200, Danilo Krummrich wrote:
> > > On Mon Sep 28, 2026 at 10:46 AM CEST, Thomas Hellstr=C3=B6m wrote:
> > > > On Fri, 2026-09-25 at 18:18 +0200, Danilo Krummrich wrote:
> > > > > On Fri Sep 25, 2026 at 3:33 PM CEST, Thomas Hellstr=C3=B6m wrote:
> > > > > > Driver and shared DRM helper code is increasingly relying
> > > > > > on
> > > > > > bare
> > > > > > drm_device references (drm_dev_get()/drm_dev_put()) to keep
> > > > > > a
> > > > > > device's
> > > > > > software state around, without also pairing that with a
> > > > > > reference
> > > > > > on
> > > > > > the owning kernel module. Xe itself does this in several
> > > > > > places,
> > > > > > and
> > > > > > so does drm_gpuvm for the lifetime of a GPU VM. None of
> > > > > > these
> > > > > > references currently prevent the owning module from being
> > > > > > unloaded
> > > > > > while they, or the teardown work they can still trigger,
> > > > > > are
> > > > > > outstanding, meaning driver code can end up executing after
> > > > > > its
> > > > > > own
> > > > > > module's text has already been freed.
> > > > >=20
> > > > > Since you mention DRM GPUVM in a couple of places, how can
> > > > > this
> > > > > ever
> > > > > happen? It
> > > > > wouldn't make sense to keep a VM alive beyond driver unbind.
> > > > > I.e.
> > > > > it
> > > > > can't make
> > > > > its drm_device reference count reach module unload in the
> > > > > first
> > > > > place.
> > > >=20
> > > > There seems to be a bit of misunderstanding here.
> > > >=20
> > > > Driver unbind removes the struct device from the driver,
> > > > triggers
> > > > device unplug, and eventually the devres release actions. IIRC
> > > > the
> > > > last
> > > > devres action removes a *single reference* on the struct
> > > > drm_device.
> > >=20
> > > Correct.
> > >=20
> > > > Hence if there exists other reference holders on the struct
> > > > drm_device
> > > > (open files, exported dma-bufs, exported drm_pagemaps as an
> > > > example),
> > > > the drm_device will survive the driver unbind. So will open
> > > > files
> > > > and
> > > > thus drm_gpuvms until user-space decides to remove them.
> > >=20
> > > There's two lifetimes we have to deal with in drivers: the
> > > lifetime
> > > of (bus /
> > > physical) device resources, which are managed by the driver and
> > > the
> > > software
> > > state that is represented through the class device to userspace
> > > (e.g.
> > > file
> > > handles).
> > >=20
> > > The former is bounded to the scope where the driver is bound to
> > > the
> > > device and
> > > the latter is unbounded and indeed depends on userspace.
> > >=20
> > > Either the subsystem or the driver has to decouple those
> > > lifetimes.
> > > I.e. if the
> > > driver is unbound it should clean up all GPUVMs as they represent
> > > the
> > > GPU's
> > > virtual address space and hence are associated with the hardware.
> > > However, the
> > > driver should not operated the hardware anymore after driver
> > > unbind.
> >=20
> > I disagree here. At unbind time we decouple the HW and SW state,
> > The
> > device no longer uses it's pointers to the page-table so, for
> > example
> > VRAM page-tables can be torn down, system page-tables lose their
> > dma-
> > mappings, but in xe we don't tear down the page-table structure
> > itself.
> >=20
> > If HW accesses are properly protected by drm_dev_enter() /
> > drm_dev_exit(), Hw won't be accessed after unbind.
> >=20
> >=20
> > >=20
> > > So, in your case it seems that file lifetime and VM lifetime are
> > > conflated
> > > although they should be separate.
> >=20
> > I view the VM as software state, page-table pointers, dma-mappings
> > and
> > VRAM storage as HW state.
> >=20
> > It seems like what we're not agreeing on is where to separate
> > those. I
> > see no reason as to why we would complicate the driver to remove
> > more
> > than necessary at unbind time?
>=20
> This can certainly be done, correct. But, the VM itself represents a
> GPU's
> virtual address space and takes ownership of the corresponding
> hardware
> resources.
>=20
> We can indeed revoke the hardware resources from the VM
> implementation and
> leave it in place. But this messes with the ownership model within
> the VM
> implementation:
>=20
> Because now, and you say this a couple of times below, we need to
> guard all
> relevant entry points into the VM code with guards, such as
> drm_dev_{enter/exit}().
>=20
> IOW, it creates partially uninitialized structures with stale
> pointers that we
> now have to guard against.
>=20
> It makes much more sense to tear down everything that owns device
> resources on
> driver unbind. I.e. why keep structures with stale pointers around
> that we have
> to guard against in the first place?
>=20
> It also gets us rid of the module unload issue as it allows us to
> prevent
> callbacks into the driver code after driver unbind on the subsystem
> level.
>=20
> > > We can't have userspace to decide when we drop device resources,
> > > such
> > > as DMA
> > > mappings, I/O memory mappings, etc.
> >=20
> > We don't (Unless we have bugs, and you may have stumbled on those
> > below?) Those should be removed at unbind time. We should also
> > revoke
> > dma-buf mappings and SVM migrates all dma-buf mappings to system.
> >=20
> > >=20
> > > > Files, dma-bufs and drm_pagemaps all hold a driver module
> > > > reference
> > > > until they have successfully released the drm_device. The
> > > > requirement
> > > > is "If a drm_device reference is held, a module reference of
> > > > the
> > > > driver
> > > > providing the drm_device must also be held, or if it's held by
> > > > the
> > > > driver itself, it must ensure at driver unload time that any
> > > > drm_device
> > > > references it holds are released and drmm release callbacks
> > > > have
> > > > finished executing."
> > > >=20
> > > > What this series in effect does is to change this to to "The
> > > > driver
> > > > won't unload until all drm_device references are gone, and all
> > > > drmm
> > > > release callbacks have finished executing."
> > > >=20
> > > > I agree that the use of drm_gpuvm in the documentation is a bit
> > > > unfair.
> > > > Since the code calling drm_dev_get() and drm_dev_put() is
> > > > intended
> > > > to
> > > > be called from the driver, the reference in effect becomes the
> > > > driver's
> > > > responsibility, but if someone would, in the future change that
> > > > so
> > > > that
> > > > those references are put from a worker from within the driver
> > > > or
> > > > even
> > > > within drm_gpuvm itself, things would break. If a future code
> > > > reviewer,
> > > > developer or AI agent knows about the new drm_device reference
> > > > guarantee, then that will lessen the review scope and code will
> > > > become
> > > > more rubost.
> > > >=20
> > > > >=20
> > > > > Besides that, can you please remind me whether there are any
> > > > > other
> > > > > reasons than
> > > > > the release() callback why a DRM device must not outlive
> > > > > module
> > > > > unload?
> > > >=20
> > > > The drmm release callbacks.
> > >=20
> > > Right, I forgot about them for a second. However, they are
> > > similar to
> > > the
> > > release() callbacks as in they are the wrong cleanup model for
> > > driver
> > > private
> > > structures.
> > >=20
> > > drmm is a great tool for common subsystem structures that
> > > lifetime
> > > wise tie to
> > > the drm_device. But it is the wrong lifetime model for stuff that
> > > is
> > > used to
> > > operate the device, as this should be torn down on device unbind.
> >=20
> > The current model used by xe (and amdgpu AFACT, that also ties vm
> > lifetime to file lifetime) is to block all hardware access and dma
> > at
> > unbind time. The rest is state that doesn't necessarily need to be
> > torn
> > down at unbind time. I believe the current separation is mostly
> > done
> > with drm_dev_enter() / drm_dev_exit() and why should we enforce a
> > change of that? I'd say the drivers should be free to release
> > what's
> > convenient.
>=20
> See the reasons above, it is not a good layer for the lifetime
> decoupling.
>=20
> > Also if drm_gpuvms are designed to not outlive the struct device,
> > why
> > do they need to take a struct drm_device reference in the first
> > place,
> > I mean I brought this problem up then and IIRC I think you argued
> > the
> > reference was needed and punted any problems it caused to the
> > drivers?
>=20
> The lifetime of the hardware resources that are owned by a GPUVM
> implementation
> is restricted by the underlying bus device (e.g. PCI) being bound to
> the driver.
>=20
> The lifetime of the DRM device as a class device is technically
> independent, it
> can live longer (which is likely), but it could technically also be
> shorter
> lived (which drivers don't do in practice). But even though drivers
> don't do
> this in practice, the dependency should be expressed: if GPUVM stores
> a pointer
> to a DRM device, it has to take a reference count.

It doesn't have to in a model where all users are removed before the
drm device is freed. Following your argument, shouldn't that drm_device
reference should also be accompanied by a module reference? Except that
will block rmmod?


>=20
> > > I had a quick look at Xe and found this for instance:
> > >=20
> > > 	 drmm_add_action_or_reset(&xe->drm, control_fini_action,
> > > gt)
> > >=20
> > > control_fini_action() stops a worker that writes device
> > > registeres,
> > > which must
> > > not be done after driver unbind anymore.
> > >=20
> > > Now, there's two options, either after driver unbind this work is
> > > never running
> > > (which would be correct), but then this could have been
> > > devm_add_action_or_reset(), or it does actually run after driver
> > > unbind, but
> > > this would violate the driver model.
> >=20
> > Agreed, Unless there is something protecting the hardware access
> > after
> > unplug in that control subsystem, that's a genuine bug, but that's
> > separate from this discussion
>=20
> I argue that it is related; surely, we can keep everything around
> until the DRM
> device is destroyed and just guard every single (callback) entry
> point.
>=20
> But, that's far more complicated and error prone than just shutting
> down the hardware
> on driver unbind and tear down all entry points on the subsystem
> level; it
> messes with the ownership model of structures leaving stale pointers
> behind.
>=20
> As mentioned, this is what subsystems commonly do in the kernel, and
> I don't see
> why DRM would be special in this regard.

Without knowing for sure, I think this was the route taken with
hotplugging.

>=20
> > > > > I don't think the correct solution is to constrain module
> > > > > unload.
> > > > > The
> > > > > release()
> > > > > callback shouldn't really do anything other than free the
> > > > > memory
> > > > > of
> > > > > the
> > > > > drm_device allocation. All other resources a driver may have
> > > > > should
> > > > > be released
> > > > > on driver unbind.
> > > >=20
> > > > That is not true. See above.
> > >=20
> > > I know it is not true in practice, but we are doing the wrong
> > > thing.
> > > We are
> > > conflating the unbounded userspace lifetime with the bounded
> > > lifetime
> > > from the
> > > driver model.
> >=20
> > I don't think we are. As long as all HW access is given up or
> > blocked,
> > we're fine.
>=20
> Right, what you describe above works, but it leaves stale pointers
> and invalid
> structures behind that we then need to guard against.

But isn't essentially what you describe a design where we release all
dma_buf, file- and drm_pagemap references of struct drm_device at
module_unload time. That would replace their references with SRCU
protecting the drm_device pointer, falling back to a stub behaviour
when unbind has been called. So the "Can I access hardware?" would be
replaced by a "Can I access the DRM device?".=20

That's an interesting idea, but would probably need careful work so
fence waits etc. doesn't block the SRCU read sections. And ofc to avoid
user-space regressing.

>=20
> Don't get me wrong, I don't object to this patch series. Well, at
> least not too
> much, requiring drivers to call drm_dev_release_barrier() in module
> unload is
> pretty ugly, and I don't know any other subsystem that has such a
> guard, because
> they do structurally prevent callbacks into drivers after driver
> unbind and
> drivers hence tie the lifetime of structures to driver unbind.

FWIW, IIRC that SRCU is only strictly needed when non-driver code
(pagemap, files and dma-buf) drops the last drm_device reference
without having a module reference. And there is no such code (yet)
AFAIK, so I can drop that patch to when we think it's necessary and we
have other driver buy-ins.


Thanks,
Thomas
