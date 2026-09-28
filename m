Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB53FC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:49:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ABD710E90A;
	Mon, 28 Sep 2026 08:49:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kOxylGJ0";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1679510E8E9;
 Mon, 28 Sep 2026 08:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790585197; x=1822121197;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=MU07iEkm54n6/j3q7zgQc3NNQOJETAqtBVLrVw0Kek8=;
 b=kOxylGJ0hDtWdO5XKVqInpuesjsiuir0fHm/dN05Akj88bl9Mr0PdgSm
 T4tXQHitfYNTyb0MCB6YIAdqf2ydhgKy7QJpmgudpV9g+BOSMwnMh0/5z
 tS476ekDI6UsQjgBjXmkgUxEkSgA/IB9PUpCQDwhbarHVIc/oN38MUdF1
 uCBY9B/lhXoUIrdkhzf/t5s8qLTMLaEck102vZ6UeqEAEdMMt5uFofu7r
 XcZtYcDW5FwQUe4ngt/EMKVxfOx3SJR/lZLxjR+Qfcfwwqa/veUrdQtkr
 XN/v5D5yL7Dy/oU/SwInEP7iCaF22L6G+1Q4DaAJ22Gg1mZd8Z0mWhOQ0 A==;
X-CSE-ConnectionGUID: 8XSoF4z6QJiWOjOOkuk/3w==
X-CSE-MsgGUID: ijlLrPYhS+y0UXa9Gvzr4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90405862"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90405862"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 01:46:36 -0700
X-CSE-ConnectionGUID: 0AzwsF6STDGy+BUiLv1y5w==
X-CSE-MsgGUID: QPh4LyJuTOu1hPfU0y7/vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="301273685"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.73])
 ([10.245.244.73])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 01:46:35 -0700
Message-ID: <7fc614d0b666fb5ae9777c29ea2e79647030b198.camel@linux.intel.com>
Subject: Re: [PATCH v3 0/3] drm, drm/xe: Protect against premature module
 unloads
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: intel-xe@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Auld
 <matthew.auld@intel.com>, 	dri-devel@lists.freedesktop.org, Alice Ryhl
 <aliceryhl@google.com>, Alex Deucher	 <alexander.deucher@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>
Date: Mon, 28 Sep 2026 10:46:32 +0200
In-Reply-To: <DLOJ7S2IZW0R.2BNLLO5M3YL7M@kernel.org>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <DLOJ7S2IZW0R.2BNLLO5M3YL7M@kernel.org>
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

On Fri, 2026-09-25 at 18:18 +0200, Danilo Krummrich wrote:
> On Fri Sep 25, 2026 at 3:33 PM CEST, Thomas Hellstr=C3=B6m wrote:
> > Driver and shared DRM helper code is increasingly relying on bare
> > drm_device references (drm_dev_get()/drm_dev_put()) to keep a
> > device's
> > software state around, without also pairing that with a reference
> > on
> > the owning kernel module. Xe itself does this in several places,
> > and
> > so does drm_gpuvm for the lifetime of a GPU VM. None of these
> > references currently prevent the owning module from being unloaded
> > while they, or the teardown work they can still trigger, are
> > outstanding, meaning driver code can end up executing after its own
> > module's text has already been freed.
>=20
> Since you mention DRM GPUVM in a couple of places, how can this ever
> happen? It
> wouldn't make sense to keep a VM alive beyond driver unbind. I.e. it
> can't make
> its drm_device reference count reach module unload in the first
> place.

There seems to be a bit of misunderstanding here.

Driver unbind removes the struct device from the driver, triggers
device unplug, and eventually the devres release actions. IIRC the last
devres action removes a *single reference* on the struct drm_device.=20
Hence if there exists other reference holders on the struct drm_device
(open files, exported dma-bufs, exported drm_pagemaps as an example),
the drm_device will survive the driver unbind. So will open files and
thus drm_gpuvms until user-space decides to remove them.

Files, dma-bufs and drm_pagemaps all hold a driver module reference
until they have successfully released the drm_device. The requirement
is "If a drm_device reference is held, a module reference of the driver
providing the drm_device must also be held, or if it's held by the
driver itself, it must ensure at driver unload time that any drm_device
references it holds are released and drmm release callbacks have
finished executing."

What this series in effect does is to change this to to "The driver
won't unload until all drm_device references are gone, and all drmm
release callbacks have finished executing."

I agree that the use of drm_gpuvm in the documentation is a bit unfair.
Since the code calling drm_dev_get() and drm_dev_put() is intended to
be called from the driver, the reference in effect becomes the driver's
responsibility, but if someone would, in the future change that so that
those references are put from a worker from within the driver or even
within drm_gpuvm itself, things would break. If a future code reviewer,
developer or AI agent knows about the new drm_device reference
guarantee, then that will lessen the review scope and code will become
more rubost.

>=20
> Besides that, can you please remind me whether there are any other
> reasons than
> the release() callback why a DRM device must not outlive module
> unload?

The drmm release callbacks.

>=20
> I don't think the correct solution is to constrain module unload. The
> release()
> callback shouldn't really do anything other than free the memory of
> the
> drm_device allocation. All other resources a driver may have should
> be released
> on driver unbind.

That is not true. See above. The alternative would be, as mentioned in
the commit message of patch 2, IIRC that each drm_device itself hold a
module reference of the creating module. But then you wouldn't be able
to execute rmmod with devices alive, You would have to manually unbind
all devices first.


>=20
> There may be shared resources, such as e.g. a common workqueue, but
> those are
> module level things that have nothing to do with the DRM device.

I don't think that is correct either. Take a look at Matt Brost reply
to patch 3 there where he points out that the drm device (a base class
of the xe device) is acually referenced in a work item after the struct
drm_device reference is put. (There is a workqueue naming confusion in
xe, but I do believe that patch needs a fix). With the poposed series
in place a simple fix would be to hold a drm_device reference across
the workqueue item. The unload process would then block until all
devices are unreferenced, and then again at destroy_worqueue time
waiting for the work item epilogue to finish executing.

>=20
> I am aware that a few drivers implement release(), but TBH it looks
> pretty
> broken. qxl_drm_release() is a great example, and it already calls it
> out
> itself.

drm_release is not of major interest.

>=20
> > This series closes that gap for xe:
> >=20
> > - Patch 1 adds core DRM infrastructure allowing a driver to wait
> > for
> > =C2=A0 its outstanding device-release callbacks to finish before
> > =C2=A0 proceeding with module unload.
>=20
> Please see above; I also wonder why Xe cares in the first place. Xe
> doesn't
> implement release(), no?

See above.

>=20
> > - Patch 2 makes xe use this infrastructure to hold up module unload
> > =C2=A0 until every xe_device instance has actually been released, rathe=
r
> > =C2=A0 than only until the module's own refcount happens to reach zero,
> > =C2=A0 with a diagnostic if this ends up taking an unexpectedly long
> > time.
> >=20
> > - Patch 3 fixes a related, previously unprotected case where the
> > =C2=A0 teardown of a GPU VM or its address space mappings can be
> > deferred
> > =C2=A0 to run at an arbitrary later time, including after module unload
> > has
> > =C2=A0 already completed.
>=20
> Huh? GPUVM tracks the GPU's VA space mappings, but after driver
> unbind there's
> no access to the GPU to manage anything anymore. How can this even
> work?
>=20
>=20
>=20

As previously mentioned, software device state may well outlive a
driver unbind. This is all about its cleanup.

Thanks,
Thomas


>=20
> Thanks,
> Danilo
