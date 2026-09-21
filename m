Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49546C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD6710E1B0;
	Mon, 21 Sep 2026 07:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="SzNqHWIM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F86F89B12;
 Mon, 21 Sep 2026 07:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789974406; x=1821510406;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=pfvNuL85tpqf9A94P/LM4q0tGzI99tv1K+8bnESVWBU=;
 b=SzNqHWIMnVMrGo6F3UsJ8EEdGUY449eTZZNy2GgBm/4/NMTKQTnxZADL
 XQWBOfmAztA/+yayN/vRBgP+k22jOzQX/8wY8sySqTwtN5x0UNINDUwdg
 jmln6pgvyAm1IyitotQXvN7WZePOkPSTx1JzGe5O0VzDDMsUkmVDh6OO0
 DFVzbSCkoduyyStRh/J9IuOggvfI3A3Qaysf15l5FYZY2cqTiDY7m7W+6
 wOA77EmK9HX+ql4XRXmgkNLVptxs5mPQgLWn6vcNbBJEGI8zcABLWGDPk
 Ga7VtTQfQgt+x660WDBnPc0Jtk1HzLr+IW4tRBv+QVUGWLLHTd4chyrCC w==;
X-CSE-ConnectionGUID: 2M4PgbhzSQGlL9gvfrf4lA==
X-CSE-MsgGUID: lWcWIPJsQS+a3ccgMGC3jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="92969431"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="92969431"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 00:06:45 -0700
X-CSE-ConnectionGUID: JWGpGHJPQhyoMFybkiqDcA==
X-CSE-MsgGUID: jC7IjkcaSqWZaBXhmnYqwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="269060970"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.155])
 ([10.245.244.155])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 00:06:43 -0700
Message-ID: <4d00cb0ed704f95966b2223bfef04c0c34bdec05.camel@linux.intel.com>
Subject: Re: [PATCH 1/5] drm/xe: Hold a device reference across deferred VM
 destruction
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: Arvind Yadav <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, rodrigo.vivi@intel.com, 
 himal.prasad.ghimiray@intel.com
Date: Mon, 21 Sep 2026 09:06:41 +0200
In-Reply-To: <aq2+HkGwXhv4UUlp@gsse-cloud1.jf.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
 <20260916095337.3104891-2-arvind.yadav@intel.com>
 <aqyueX3xWoVJ6P8b@gsse-cloud1.jf.intel.com>
 <2b196d015b37329cd6eda25c565c83c5e5f77a7f.camel@linux.intel.com>
 <aq2+HkGwXhv4UUlp@gsse-cloud1.jf.intel.com>
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

On Fri, 2026-09-18 at 15:41 -0700, Matthew Brost wrote:
> On Fri, Sep 18, 2026 at 09:22:53AM +0200, Thomas Hellstr=C3=B6m wrote:
> > On Thu, 2026-09-17 at 20:22 -0700, Matthew Brost wrote:
> > > On Wed, Sep 16, 2026 at 03:23:33PM +0530, Arvind Yadav wrote:
> > > > xe_vm_free() is the drm_gpuvm vm_free callback. It hands the
> > > > final
> > > > teardown to vm_destroy_work_func() on a workqueue and returns.
> > > >=20
> > > > drm_gpuvm_free() drops its device reference immediately after
> > > > the
> > > > callback returns:
> > > >=20
> > > > 	gpuvm->ops->vm_free(gpuvm);
> > > > 	drm_dev_put(drm);
> > > >=20
> > > > vm_destroy_work_func() then keeps using device state:
> > > > xe_pm_runtime_put()
> > > > for an LR mode VM, ttm_lru_bulk_move_fini() on xe->ttm, and the
> > > > tile
> > > > iteration. If the freed VM held the last device reference, the
> > > > work
> > > > runs
> > > > against a released xe_device.
> > > >=20
> > > > Take a device reference in xe_vm_free() and drop it once
> > > > vm_destroy_work_func() has finished using the device.
> > > >=20
> > > > Cc: Matthew Brost <matthew.brost@intel.com>
> > >=20
> > > This is a fix, IMO. Ideally, we should probably push the delayed-
> > > destroy
> > > semantics into gpuvm if they are really needed. I'm also
> > > questioning
> > > whether the VM destroy worker is actually required. This dates
> > > back
> > > to
> > > the very early days of Xe, and I doubt we've ever revisited
> > > whether
> > > it
> > > is necessary.
> > >=20
> > > Let's follow up with one of the following:
> > > - Introduce async destroy in gpuvm and have it own the
> > > drm_dev_get/put.
> > > - Drop delayed destroy entirely in Xe.
> >=20
> > We need to keep in mind that the drm file keeps a reference on the
> > Xe
> > module. So once the last close() callback has executed, the module
> > can
>=20
> Yikes, so drm_dev_get won't prevent the module from unloading?

Exactly.

> Different
> issue, right?

Yes, but if we move into GPUVM it would affect other drivers. I believe
the issue is fixable on a per-driver basis.

>=20
> > typically be unloaded, causing execution UAF. It's therefore not
> > really
> > recommended to keep file-related structures around with a refcount
> > after close.
> >=20
> > Device references however typically don't necessarily keep the
> > module
> > pinned. I had a series to fix this for xe only, (Got stalled) [1],
> > but
> > in general we should be careful about leaking that assumption into
> > DRM
> > code.
> >=20
>=20
> So what is the fix here? I believe gpuvm has a drm_dev_ ref and it
> async
> teardown which breaks drm_dev_ assumption. I don't see an issue with
> this patch or my suggest follow up.

While the fix for xe is the below series, And I will respin that, If we
move more device refcounts into GPUVM, that will affect other drivers
that aren't yet fixed. Note drm_pagemap handles this with the dev
unhold work, not sure if that is applicable also with GPUVM.=20

Either way, I don't want to block the series due to a fix missing. Just
want us to keep this in mind since it increases the probability of the
real bug hitting.

>=20
> > [1] https://patchwork.freedesktop.org/series/163298/
>=20
> Should we push on this? I don't really see an issue with series as
> long
> as 'rmmod xe' works if display isn't holding a module ref.

Yes, I'll respin.
Thanks,
Thomas


>=20
> Matt
>=20
> >=20
> > Thanks,
> > Thomas
> >=20
> >=20
> > >=20
> > > As a temporary fix that can be backported, this looks good to me,
> > > so
> > > with a Fixes tag:
> > >=20
> > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > >=20
> > > > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > Assisted-by: Claude:claude-opus-4-8
> > > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > > ---
> > > > =C2=A0drivers/gpu/drm/xe/xe_vm.c | 9 +++++++++
> > > > =C2=A01 file changed, 9 insertions(+)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > > b/drivers/gpu/drm/xe/xe_vm.c
> > > > index efa5ff6cc823..264bdab75de2 100644
> > > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > > @@ -2054,12 +2054,21 @@ static void vm_destroy_work_func(struct
> > > > work_struct *w)
> > > > =C2=A0		xe_file_put(vm->xef);
> > > > =C2=A0
> > > > =C2=A0	kfree(vm);
> > > > +
> > > > +	drm_dev_put(&xe->drm);
> > > > =C2=A0}
> > > > =C2=A0
> > > > =C2=A0static void xe_vm_free(struct drm_gpuvm *gpuvm)
> > > > =C2=A0{
> > > > =C2=A0	struct xe_vm *vm =3D container_of(gpuvm, struct xe_vm,
> > > > gpuvm);
> > > > =C2=A0
> > > > +	/*
> > > > +	 * drm_gpuvm drops its device reference as soon as
> > > > this
> > > > callback
> > > > +	 * returns, but vm_destroy_work_func() still uses
> > > > device
> > > > state. Hold a
> > > > +	 * reference across the deferred work.
> > > > +	 */
> > > > +	drm_dev_get(&vm->xe->drm);
> > > > +
> > > > =C2=A0	/* To destroy the VM we need to be able to sleep */
> > > > =C2=A0	queue_work(system_dfl_wq, &vm->destroy_work);
> > > > =C2=A0}
> > > > --=20
> > > > 2.43.0
> > > >=20
