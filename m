Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1FDF53D92
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 20:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 587B110E4D5;
	Mon, 16 Mar 2026 20:10:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UUc9DBG1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB83510E4BE;
 Mon, 16 Mar 2026 20:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773691834; x=1805227834;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ty5xUhInvoKJw/e7faRl28+8kUcSScJz8LSABd9pIDk=;
 b=UUc9DBG1oiQAWqgg4wEZkygfy0a63ZA6eP9qaq57YlSMp4shzq4T6UhM
 tyNaZswiRkse3B70jjAWQuDdPBinP/nKc0S5gCJmGetui/GCWCI54JdQI
 Yj6OH1h8mQq6bUxRqM+pSL7OtrSkQVqVFivMeqsCJ8VkAi52N8NLCGb92
 u7flctJyCpfXl1gpJGJ9Ouy/z82cPaQ0f0zrobmTaVNe3cYMJrqdEfEx3
 ibHYr2hBprmbSIK+EHut2NeXOe3ILk0LhAk187pJyUwLVuMGZwHPQpbD9
 vJxnDrsCSPTfEYkVLfCNjXMlIxnLAAOhj223cXA+5QflyDE4+6maYYrxV w==;
X-CSE-ConnectionGUID: Z7co87W6RdasglS5lKsTkA==
X-CSE-MsgGUID: s7K53DPuR2GjerFuo9QLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="97328354"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="97328354"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 13:10:33 -0700
X-CSE-ConnectionGUID: C+CBYj2lSDSiy8nPigcOLQ==
X-CSE-MsgGUID: ISIEfI/7QHOuXTnbKgeOvw==
X-ExtLoop1: 1
Received: from zzombora-mobl1.ger.corp.intel.com (HELO [10.245.244.233])
 ([10.245.244.233])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 13:10:31 -0700
Message-ID: <99d0cdb184b5e67634f8306da0ffd7ffce2f041b.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] drm: Provide a drm_dev_release_barrier() function
 to wait for device release callbacks
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Dave Airlie <airlied@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org
Date: Mon, 16 Mar 2026 21:10:29 +0100
In-Reply-To: <9a5f1dab-eeba-477a-84cc-8e565b9c5de6@amd.com>
References: <20260316162002.13479-1-thomas.hellstrom@linux.intel.com>
 <20260316162002.13479-2-thomas.hellstrom@linux.intel.com>
 <9a5f1dab-eeba-477a-84cc-8e565b9c5de6@amd.com>
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

On Mon, 2026-03-16 at 18:42 +0100, Christian K=C3=B6nig wrote:
> On 3/16/26 17:20, Thomas Hellstr=C3=B6m wrote:
> > If helper components, like for example drm_pagemap hold references
> > to
> > drm devices, it's typically possible for the drm driver module to
> > be
> > unloaded without that reference being dropped,=20
>=20
> That is an extremely bad idea to begin with, drm_devices should
> reference the module who issued them.

They typically don't. If that were the case you wouldn't be able to
rmmod a module and have device cleanup happen:

module_exit();

pci_unregister_driver()-><starts device removal>
devm_release()-><drop drm device reference>
drmm_release()
...
<module unloads>

I was under the impression that this was the behaviour of most device
drivers and also drm drivers if display isn't enabled.
(used to work with xe but doesn't anymore for unknown reason).

Module references are typically held by open files, display and dma-
bufs, but not by devices.

Like surely you can rmmod for example a serial device driver and have
it implicitly unbind its devices, but not if a device have a file
opened.=20

>=20
> > resulting in execution out
> > of freed memory. Such components are therefore required to hold a
> > module refcount on the module that created the drm device, and
> > ensure
> > that module reference is dropped after all references to the drm
> > device are dropped.
> >=20
> > To relax that, drivers can keep a drm device-count and ensure that
> > the
> > module isn't unloaded until the drm device-count has dropped to
> > zero
> > and that the caller that decremented the last device-count has
> > finished
> > executing driver callbacks.
>=20
> Stop for a second. The question is why would anybody want to relax
> that?
>=20
> That unbinding a driver from a device is separated from module
> unloading is a design we had in Linux since the very beginning.
>=20
>=20
And that is kept here, You can unbind and rebind a device at any time,
the difference is that for a module whose devices are unused by user-
space, a rmmod triggers an implicit unbind / cleanup instead of removal
being blocked requiring an explicit unbind of all devices.

Thanks,
Thomas


> Regards,
> Christian.
>=20
> >=20
> > To help with the latter, add a drm_dev_release_barrier() function.
> > The function ensures that any caller that has started executing
> > device release callbacks has also finished executing them.
> >=20
> > Use SRCU for the implementation.
> >=20
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0drivers/gpu/drm/drm_drv.c | 25 +++++++++++++++++++++++++
> > =C2=A0include/drm/drm_drv.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A02 files changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index 2915118436ce..9fa72adf173d 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -898,21 +898,46 @@ struct drm_device *drm_dev_alloc(const struct
> > drm_driver *driver,
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(drm_dev_alloc);
> > =C2=A0
> > +DEFINE_STATIC_SRCU(drm_dev_release_srcu);
> > +
> > =C2=A0static void drm_dev_release(struct kref *ref)
> > =C2=A0{
> > =C2=A0	struct drm_device *dev =3D container_of(ref, struct
> > drm_device, ref);
> > +	int idx;
> > =C2=A0
> > =C2=A0	/* Just in case register/unregister was never called */
> > =C2=A0	drm_debugfs_dev_fini(dev);
> > =C2=A0
> > +	idx =3D srcu_read_lock(&drm_dev_release_srcu);
> > =C2=A0	if (dev->driver->release)
> > =C2=A0		dev->driver->release(dev);
> > =C2=A0
> > =C2=A0	drm_managed_release(dev);
> > +	srcu_read_unlock(&drm_dev_release_srcu, idx);
> > =C2=A0
> > =C2=A0	kfree(dev->managed.final_kfree);
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * drm_dev_release_barrier() - Ensure drm device release callbacks
> > are finished
> > + *
> > + * If a device release method or any of the drm managed release
> > callbacks
> > + * have been called for a device, wait until all of them have
> > finished
> > + * executing. This function can be used to help determine whether
> > it's safe
> > + * to unload a driver module.
> > + *
> > + * Assume for example the driver maintains a device count which is
> > decremented
> > + * using a drmm callback or a device release callback. From a drm
> > device
> > + * lifetime POV, it's then safe to unload the driver when that
> > device-count
> > + * has reached zero and drm_dev_release_barrier() has been called.
> > + */
> > +void drm_dev_release_barrier(void)
> > +{
> > +	synchronize_srcu(&drm_dev_release_srcu);
> > +}
> > +EXPORT_SYMBOL(drm_dev_release_barrier);
> > +
> > +
> > =C2=A0/**
> > =C2=A0 * drm_dev_get - Take reference of a DRM device
> > =C2=A0 * @dev: device to take reference of or NULL
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index 42fc085f986d..b288a885cf45 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -489,6 +489,7 @@ void drm_dev_exit(int idx);
> > =C2=A0void drm_dev_unplug(struct drm_device *dev);
> > =C2=A0int drm_dev_wedged_event(struct drm_device *dev, unsigned long
> > method,
> > =C2=A0			 struct drm_wedge_task_info *info);
> > +void drm_dev_release_barrier(void);
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * drm_dev_is_unplugged - is a DRM device unplugged
