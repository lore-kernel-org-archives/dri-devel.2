Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 179C0C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3619010F549;
	Thu, 24 Sep 2026 13:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E0k+/ry1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D83810F539;
 Thu, 24 Sep 2026 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255453; x=1821791453;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=vxZHUgAV1NGMnOX0ExiQPdVOApOMW2k9MGIcoqalUJw=;
 b=E0k+/ry1RxJSzxWa79NnCtWWcb7D3As0FMn4B8P5wTsLJyIk+nwJMTII
 SxQYDh87cvnojcZ4ZogrwtWMDdtjfxOBm87qNyzZB1uoAr/XpA+9FX7gq
 Kf9lQ9hWDCLcP0+oNDA7EvFICtXI+UxLfKHUY2jC9I6Go+QnirEfD8grN
 JcVXb7ybJOQ39LD6zgtWxQ6NKkL5OAH52hICW/0MYP+fS9ysCMKUxeokN
 Wqg/noGsuBd5Jj5PJhbKc9RemEXoPYI7Ze1Gsi7dKqCcjPftTYptL9FH1
 rChwqohkDpSJBGdqM5E0qffJpaFetqh8yRK41qSQan9Lm1rWZ+gj0xxU5 g==;
X-CSE-ConnectionGUID: jRP9K0coQkqvGd0Sr2eotw==
X-CSE-MsgGUID: 3O9OgT+DTzyRaIIU4pWw3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="90066972"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="90066972"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:10:52 -0700
X-CSE-ConnectionGUID: xFYz4EnMScKpYZ9B6N+Z0w==
X-CSE-MsgGUID: ZO0G/H2ESm2Mfg58AAK/tw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="277416208"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.129])
 ([10.245.244.129])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:10:50 -0700
Message-ID: <91adcc043e3fedb0afd0857de9e87a71381e960c.camel@linux.intel.com>
Subject: Re: [PATCH v2 1/3] drm: Provide a drm_dev_release_barrier()
 function to wait for device release callbacks
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Rodrigo Vivi	
 <rodrigo.vivi@intel.com>, Matthew Auld <matthew.auld@intel.com>, 
 dri-devel@lists.freedesktop.org, Danilo Krummrich <dakr@kernel.org>, Alice
 Ryhl	 <aliceryhl@google.com>, Alex Deucher <alexander.deucher@amd.com>
Date: Thu, 24 Sep 2026 15:10:47 +0200
In-Reply-To: <bcff99b0-4933-4f31-a2ee-dc88da13d207@amd.com>
References: <20260924080455.25458-1-thomas.hellstrom@linux.intel.com>
 <20260924080455.25458-2-thomas.hellstrom@linux.intel.com>
 <bcff99b0-4933-4f31-a2ee-dc88da13d207@amd.com>
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

On Thu, 2026-09-24 at 13:19 +0200, Christian K=C3=B6nig wrote:
> On 9/24/26 10:04, Thomas Hellstr=C3=B6m wrote:
> > Driver and drm helper code is increasingly relying on holding a
> > bare
> > &drm_device reference (drm_dev_get()) without also holding a module
> > reference on the module that created the device.
> >=20
> > For example drm_gpuvm_init() takes a drm_dev_get() reference on the
> > &drm_gpuvm's behalf with no accompanying module reference at all,
> > and
> > drm_gpuvm_free() later calls the driver-supplied gpuvm->ops-
> > >vm_free()
> > callback, which lives in the driver module, before dropping that
> > reference. xe also takes bare drm_device references itself from
> > several asynchronous contexts, such as GuC submission fence
> > workers,
> > EU stall, OA and PMU sampling code, relying only on those
> > references
> > being dropped before the underlying xe_device, and eventually the
> > driver module, can be torn down.
> >=20
> > If the module that created such a device is unloaded while one of
> > these bare references is still outstanding, and the corresponding
> > drm_dev_put() only completes after the module has already been
> > removed, the driver's ->release() callback, any drm managed release
> > actions, or a driver callback such as gpuvm->ops->vm_free(), all of
> > which live in that module's, by then freed, code, can end up being
> > invoked out of memory that no longer contains valid code.
> >=20
> > Requiring every one of these bare drm_device references to also
> > take a
> > module reference, as drm_pagemap does today via try_module_get(),
> > doesn't scale to shared helpers and driver-internal code with many
> > call sites, and is easy to get wrong.
> >=20
> > Fix this properly by letting drivers keep a drm device-count and
> > ensure the module isn't unloaded until that count has dropped to
> > zero
> > and until any release callback that had already started executing
> > has
> > also finished executing.
> >=20
> > To help with the latter, add a drm_dev_release_barrier() function.
> > The function ensures that any caller that has started executing
> > device release callbacks has also finished executing them.
> >=20
> > Use SRCU for the implementation.
> >=20
> > Rather than a single SRCU domain shared by all drivers, which would
> > mean drm_dev_release_barrier() could unnecessarily block a driver's
> > module unload on unrelated drivers' release callbacks, require each
> > driver that wants to use drm_dev_release_barrier() to supply its
> > own
> > SRCU domain via a new &drm_driver.release_srcu field. Drivers
> > should
> > define a static SRCU domain (DEFINE_STATIC_SRCU()) and set this
> > field
> > to point at it. Leaving the field unset means @release and drm
> > managed
> > release actions for that driver's devices simply aren't
> > synchronized
> > against, and calling drm_dev_release_barrier() for such a driver is
> > a
> > no-op that triggers a warning.
>=20
> That sounds like overkill to me.
>=20
> I mean I can understand that you don't want to use RCU, but a single
> static SRCU for the DRM subsystem should pretty do the trick.

Agreed. I'll change that in v3.

Thanks,
Thomas

>=20
> Regards,
> Christian.
>=20
> >=20
> > Since &drm_driver.release_srcu is a new field, every existing
> > struct
> > drm_driver instance in the tree was scanned to confirm none of them
> > would leave it uninitialized with indeterminate content. All in-
> > tree
> > instances have static storage duration (plain or const static
> > file-scope objects), or are members of a KUnit test fixture zeroed
> > via
> > kunit_kzalloc(); no instance is stack-allocated or heap-allocated
> > without zeroing. Objects with static storage duration are
> > guaranteed
> > by the C standard to have any member without an explicit
> > initializer
> > zero-initialized, so the new field is reliably NULL, and
> > drm_dev_release() simply skips the SRCU critical section, for all
> > drivers that don't set it.
> >=20
> > v2:
> > - Use plain WARN_ON_ONCE() instead of drm_WARN_ON_ONCE(NULL, ...)
> > in
> > =C2=A0 drm_dev_release_barrier(), since passing a NULL drm_device cause=
d
> > =C2=A0 the warning path itself to dereference that NULL pointer inside
> > =C2=A0 dev_driver_string()/dev_name() (sashiko)
> >=20
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Assisted-by: LLM
> > ---
> > =C2=A0drivers/gpu/drm/drm_drv.c | 56
> > +++++++++++++++++++++++++++++++++++++++
> > =C2=A0include/drm/drm_drv.h=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++++++++++++=
+++
> > =C2=A02 files changed, 80 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index 0cdc606af8d1..32a03170383c 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -921,18 +921,57 @@ EXPORT_SYMBOL(drm_dev_alloc);
> > =C2=A0static void drm_dev_release(struct kref *ref)
> > =C2=A0{
> > =C2=A0	struct drm_device *dev =3D container_of(ref, struct
> > drm_device, ref);
> > +	struct srcu_struct *srcu =3D dev->driver->release_srcu;
> > +	int idx =3D -1;
> > =C2=A0
> > =C2=A0	/* Just in case register/unregister was never called */
> > =C2=A0	drm_debugfs_dev_fini(dev);
> > =C2=A0
> > +	if (srcu)
> > +		idx =3D srcu_read_lock(srcu);
> > +
> > =C2=A0	if (dev->driver->release)
> > =C2=A0		dev->driver->release(dev);
> > =C2=A0
> > =C2=A0	drm_managed_release(dev);
> > =C2=A0
> > +	if (srcu)
> > +		srcu_read_unlock(srcu, idx);
> > +
> > =C2=A0	kfree(dev->managed.final_kfree);
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * drm_dev_release_barrier() - Ensure drm device release callbacks
> > are finished
> > + * @driver: driver whose release callbacks to wait for
> > + *
> > + * If a device release method or any of the drm managed release
> > callbacks
> > + * have been called for a device created with @driver, wait until
> > all of
> > + * them have finished executing. This function can be used to help
> > determine
> > + * whether it's safe to unload a driver module.
> > + *
> > + * Assume for example the driver maintains a device count which is
> > decremented
> > + * using a drmm callback or a device release callback. From a drm
> > device
> > + * lifetime POV, it's then safe to unload the driver when that
> > device-count
> > + * has reached zero and drm_dev_release_barrier() has been called.
> > + *
> > + * @driver must have &drm_driver.release_srcu set to a driver-
> > owned
> > + * &struct srcu_struct for this function to have anything to wait
> > for.
> > + *
> > + * This function only waits for the &drm_driver.release callback
> > and drm
> > + * managed release actions to finish. It does not, by itself,
> > guarantee that
> > + * whoever called drm_dev_put() to drop the reference triggering
> > that release
> > + * has itself finished running. See drm_dev_put() for that
> > invariant.
> > + */
> > +void drm_dev_release_barrier(const struct drm_driver *driver)
> > +{
> > +	if (WARN_ON_ONCE(!driver || !driver->release_srcu))
> > +		return;
> > +
> > +	synchronize_srcu(driver->release_srcu);
> > +}
> > +EXPORT_SYMBOL(drm_dev_release_barrier);
> > +
> > =C2=A0/**
> > =C2=A0 * drm_dev_get - Take reference of a DRM device
> > =C2=A0 * @dev: device to take reference of or NULL
> > @@ -958,6 +997,23 @@ EXPORT_SYMBOL(drm_dev_get);
> > =C2=A0 *
> > =C2=A0 * This decreases the ref-count of @dev by one. The device is
> > destroyed if the
> > =C2=A0 * ref-count drops to zero.
> > + *
> > + * If this call may drop the last reference, the calling code
> > itself is
> > + * responsible for ensuring it isn't unloaded (for example as part
> > of a
> > + * module) before this call has returned. This matters in
> > particular for
> > + * drivers relying on drm_dev_release_barrier() to determine when
> > it's safe to
> > + * unload, since that function only waits for the
> > &drm_driver.release
> > + * callback and drm managed release actions to finish, not for
> > whoever calls
> > + * drm_dev_put() to finish calling it.
> > + *
> > + * A common case is dropping the last reference from a deferred
> > context, such
> > + * as a workqueue item. In that case it's the responsibility of
> > whoever
> > + * queued that work item to guarantee it has run to completion
> > before the
> > + * module can unload, for example by draining a module-lifetime
> > workqueue at
> > + * module exit time. Holding a module reference only until the
> > work item
> > + * starts running is insufficient: that reference would already be
> > dropped
> > + * before this call runs, even though this call is what may still
> > need the
> > + * module's code to remain resident.
> > =C2=A0 */
> > =C2=A0void drm_dev_put(struct drm_device *dev)
> > =C2=A0{
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index b23830494ed4..30bb8727a896 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -48,6 +48,7 @@ struct drm_display_mode;
> > =C2=A0struct drm_mode_create_dumb;
> > =C2=A0struct drm_printer;
> > =C2=A0struct sg_table;
> > +struct srcu_struct;
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * enum drm_driver_feature - feature flags
> > @@ -255,6 +256,28 @@ struct drm_driver {
> > =C2=A0	 */
> > =C2=A0	void (*release) (struct drm_device *);
> > =C2=A0
> > +	/**
> > +	 * @release_srcu:
> > +	 *
> > +	 * Optional driver-owned SRCU domain used to synchronize
> > completion of
> > +	 * the @release callback and drm managed release actions
> > with
> > +	 * drm_dev_release_barrier().
> > +	 *
> > +	 * Left unset, @release and drm managed release actions
> > for this
> > +	 * driver's devices aren't synchronized with
> > drm_dev_release_barrier()
> > +	 * at all, and calling drm_dev_release_barrier() for this
> > driver is a
> > +	 * no-op that triggers a warning.
> > +	 *
> > +	 * Drivers that want to use drm_dev_release_barrier(), for
> > example to
> > +	 * help determine when it's safe to unload the driver
> > module, should
> > +	 * define their own static SRCU domain
> > (DEFINE_STATIC_SRCU()) and set
> > +	 * this field to point at it. Each driver should use its
> > own domain,
> > +	 * so that drm_dev_release_barrier() only waits for that
> > driver's own
> > +	 * release callbacks, rather than also for unrelated
> > drivers sharing
> > +	 * the same domain.
> > +	 */
> > +	struct srcu_struct *release_srcu;
> > +
> > =C2=A0	/**
> > =C2=A0	 * @master_set:
> > =C2=A0	 *
> > @@ -485,6 +508,7 @@ void drm_dev_exit(int idx);
> > =C2=A0void drm_dev_unplug(struct drm_device *dev);
> > =C2=A0int drm_dev_wedged_event(struct drm_device *dev, unsigned long
> > method,
> > =C2=A0			 struct drm_wedge_task_info *info);
> > +void drm_dev_release_barrier(const struct drm_driver *driver);
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * drm_dev_is_unplugged - is a DRM device unplugged
