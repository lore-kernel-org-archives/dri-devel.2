Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890A5C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E5010E86B;
	Mon, 28 Sep 2026 10:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BcptKPE3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8954F10E86B;
 Mon, 28 Sep 2026 10:13:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C9EB40C49;
 Mon, 28 Sep 2026 10:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E26E1F000FF;
 Mon, 28 Sep 2026 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790590399;
 bh=YAJXTTYkvsAFcfBGYS155YJHozDA+TjMNiy15/bKkgQ=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=BcptKPE3lwy5a1kx92qwporUDCej45l1zQsiKMIcyIH+saWhhXh1NClPIewHaM+lb
 UynbcaX12/nbEbv/3VDZ74NHqBfTofFaYYj1Gh5bALwJnvAB2ll7eTqn6F+tj52b3X
 +TXGhnBxKc0et8sJAga824s3yhBtN8YFZlAqb0CslWl2K5LhLOMIUlU7hOLVCOD/cL
 FzpIg/AciTdzxIaqLjBKrVcicyHOtw5tfz7zUpmDMdU+q7I3Q9wqmjXlvJytjhNr7D
 9fcX06Ac5R2//PVFjw7saaL6QxCKaJJDAf4TE8ALQeN3M5NvPLIw1vje8WpHFKNfNp
 KK9qN8/PssWPA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 12:13:15 +0200
Message-Id: <DLQVBJX4PK5G.2AK3E5K8U8UY7@kernel.org>
Cc: <intel-xe@lists.freedesktop.org>, "Matthew Brost"
 <matthew.brost@intel.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 "Matthew Auld" <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Alex Deucher"
 <alexander.deucher@amd.com>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>
To: =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 0/3] drm, drm/xe: Protect against premature module
 unloads
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <DLOJ7S2IZW0R.2BNLLO5M3YL7M@kernel.org>
 <7fc614d0b666fb5ae9777c29ea2e79647030b198.camel@linux.intel.com>
In-Reply-To: <7fc614d0b666fb5ae9777c29ea2e79647030b198.camel@linux.intel.com>
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

On Mon Sep 28, 2026 at 10:46 AM CEST, Thomas Hellstr=C3=B6m wrote:
> On Fri, 2026-09-25 at 18:18 +0200, Danilo Krummrich wrote:
>> On Fri Sep 25, 2026 at 3:33 PM CEST, Thomas Hellstr=C3=B6m wrote:
>> > Driver and shared DRM helper code is increasingly relying on bare
>> > drm_device references (drm_dev_get()/drm_dev_put()) to keep a
>> > device's
>> > software state around, without also pairing that with a reference
>> > on
>> > the owning kernel module. Xe itself does this in several places,
>> > and
>> > so does drm_gpuvm for the lifetime of a GPU VM. None of these
>> > references currently prevent the owning module from being unloaded
>> > while they, or the teardown work they can still trigger, are
>> > outstanding, meaning driver code can end up executing after its own
>> > module's text has already been freed.
>>=20
>> Since you mention DRM GPUVM in a couple of places, how can this ever
>> happen? It
>> wouldn't make sense to keep a VM alive beyond driver unbind. I.e. it
>> can't make
>> its drm_device reference count reach module unload in the first
>> place.
>
> There seems to be a bit of misunderstanding here.
>
> Driver unbind removes the struct device from the driver, triggers
> device unplug, and eventually the devres release actions. IIRC the last
> devres action removes a *single reference* on the struct drm_device.

Correct.

> Hence if there exists other reference holders on the struct drm_device
> (open files, exported dma-bufs, exported drm_pagemaps as an example),
> the drm_device will survive the driver unbind. So will open files and
> thus drm_gpuvms until user-space decides to remove them.

There's two lifetimes we have to deal with in drivers: the lifetime of (bus=
 /
physical) device resources, which are managed by the driver and the softwar=
e
state that is represented through the class device to userspace (e.g. file
handles).

The former is bounded to the scope where the driver is bound to the device =
and
the latter is unbounded and indeed depends on userspace.

Either the subsystem or the driver has to decouple those lifetimes. I.e. if=
 the
driver is unbound it should clean up all GPUVMs as they represent the GPU's
virtual address space and hence are associated with the hardware. However, =
the
driver should not operated the hardware anymore after driver unbind.

So, in your case it seems that file lifetime and VM lifetime are conflated
although they should be separate.

We can't have userspace to decide when we drop device resources, such as DM=
A
mappings, I/O memory mappings, etc.

> Files, dma-bufs and drm_pagemaps all hold a driver module reference
> until they have successfully released the drm_device. The requirement
> is "If a drm_device reference is held, a module reference of the driver
> providing the drm_device must also be held, or if it's held by the
> driver itself, it must ensure at driver unload time that any drm_device
> references it holds are released and drmm release callbacks have
> finished executing."
>
> What this series in effect does is to change this to to "The driver
> won't unload until all drm_device references are gone, and all drmm
> release callbacks have finished executing."
>
> I agree that the use of drm_gpuvm in the documentation is a bit unfair.
> Since the code calling drm_dev_get() and drm_dev_put() is intended to
> be called from the driver, the reference in effect becomes the driver's
> responsibility, but if someone would, in the future change that so that
> those references are put from a worker from within the driver or even
> within drm_gpuvm itself, things would break. If a future code reviewer,
> developer or AI agent knows about the new drm_device reference
> guarantee, then that will lessen the review scope and code will become
> more rubost.
>
>>=20
>> Besides that, can you please remind me whether there are any other
>> reasons than
>> the release() callback why a DRM device must not outlive module
>> unload?
>
> The drmm release callbacks.

Right, I forgot about them for a second. However, they are similar to the
release() callbacks as in they are the wrong cleanup model for driver priva=
te
structures.

drmm is a great tool for common subsystem structures that lifetime wise tie=
 to
the drm_device. But it is the wrong lifetime model for stuff that is used t=
o
operate the device, as this should be torn down on device unbind.

I had a quick look at Xe and found this for instance:

	 drmm_add_action_or_reset(&xe->drm, control_fini_action, gt)

control_fini_action() stops a worker that writes device registeres, which m=
ust
not be done after driver unbind anymore.

Now, there's two options, either after driver unbind this work is never run=
ning
(which would be correct), but then this could have been
devm_add_action_or_reset(), or it does actually run after driver unbind, bu=
t
this would violate the driver model.

>> I don't think the correct solution is to constrain module unload. The
>> release()
>> callback shouldn't really do anything other than free the memory of
>> the
>> drm_device allocation. All other resources a driver may have should
>> be released
>> on driver unbind.
>
> That is not true. See above.

I know it is not true in practice, but we are doing the wrong thing. We are
conflating the unbounded userspace lifetime with the bounded lifetime from =
the
driver model.

I also know that we can't fix this easily, but I want to create some awaren=
ess,
especially when we introduce more band aid for the status quo, such that we=
 can
subsequently address the fundamental lifetime problems.

>> There may be shared resources, such as e.g. a common workqueue, but
>> those are
>> module level things that have nothing to do with the DRM device.
>
> I don't think that is correct either. Take a look at Matt Brost reply
> to patch 3 there where he points out that the drm device (a base class
> of the xe device) is acually referenced in a work item after the struct
> drm_device reference is put. (There is a workqueue naming confusion in
> xe, but I do believe that patch needs a fix). With the poposed series
> in place a simple fix would be to hold a drm_device reference across
> the workqueue item. The unload process would then block until all
> devices are unreferenced, and then again at destroy_worqueue time
> waiting for the work item epilogue to finish executing.

Well, but the workqueue itself has a bounded lifetime, which should either =
be
driver unbind or module unload (when shared between driver instances). The =
work
items themselves should ideally not extend beyond driver unbind, because th=
ere
shouldn't be anything to do for the driver after unbind, because all the
hardware should be torn down and not touched at this point anymore.

I had another brief look at Xe and found this:

	drmm_add_action_or_reset(&xe->drm, ggtt_fini_early, ggtt)

where ggtt_fini_early() destroys a workqueue. It also calls

	drm_mm_takedown(&ggtt->mm);

which IIUC is the range allocator for the global GTT. (The hardware is gone=
 on
driver unbind (i.e. no more GGTT is available for the driver), so there's
shouldn't be a need for this drm_mm to live longer than driver unbind).

This model ties the lifetime of all shorter lived resources that are bounde=
d to
the driver unload scope to the unbounded lifetime of the drm_device that is
controlled by userspace.

I.e. the model is backwards and hence also extends your driver structures a=
nd
callback entry points not only beyond driver unbind, but also potentially b=
eyond
module unload.

If it would be done the other way around, tear down everything on driver un=
load,
and then use default trampolines for userspace still trying to call into th=
e
driver (which is also what DMA fence does and other subsystem do), all thos=
e
issues go away.

>> > - Patch 3 fixes a related, previously unprotected case where the
>> > =C2=A0 teardown of a GPU VM or its address space mappings can be
>> > deferred
>> > =C2=A0 to run at an arbitrary later time, including after module unloa=
d
>> > has
>> > =C2=A0 already completed.
>>=20
>> Huh? GPUVM tracks the GPU's VA space mappings, but after driver
>> unbind there's
>> no access to the GPU to manage anything anymore. How can this even
>> work?
>
> As previously mentioned, software device state may well outlive a
> driver unbind. This is all about its cleanup.

GPUVM shouldn't be lifetime wise tied to a software state, it represents
hardware resoruces.
