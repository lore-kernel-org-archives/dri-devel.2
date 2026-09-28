Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F88BC9832F
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:51:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E42D610E8FB;
	Mon, 28 Sep 2026 08:51:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dG5dCYhp";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1983E10E8F8;
 Mon, 28 Sep 2026 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790585429; x=1822121429;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=N5LHrt8Ot5ljGL19Wc9wYdQ/hfjCeEGeLFlEWM/8vMQ=;
 b=dG5dCYhpZH869Up4eOfi6V3VhR2IcyKeavjZFYbfBCj+W0PmnnT/ytoI
 ld/Xdzgtns4FH49tEwVt/igYoa7BLEjm/v4Ebt02NM6OLkvd+grd8+OsX
 RuJvxf1KJsf9o/TAnO0E1mWm+QcOTQmhQ+LhfBUzJ4VTJ89HHaHm49WAA
 hjap49umYlVp2DmLSiKzmoiMcJ7S2G5Mae6a+t92ucWGnhtLxw+UhWfkW
 +pJVLa7BglbnTylWMiPaI3Fh7gtjSXkEPkV51KD4zzVTjjIz6GZ3ZGPXV
 MkLDIwyysv+XZArAMdbMwnuqF4YwYpHCcVIMCHA15THDDrAkpyM88luRI A==;
X-CSE-ConnectionGUID: dNfasiPFSiaTGzLOtSpeLw==
X-CSE-MsgGUID: hekQjHiGTbGYxzQ7Fmi6pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90232573"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="90232573"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 01:50:29 -0700
X-CSE-ConnectionGUID: Kha+xhJcQt66VOPQrcUy+A==
X-CSE-MsgGUID: f0wv1qDSTxa0Os1cExJ6sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; d="scan'208";a="278814081"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.73])
 ([10.245.244.73])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 01:50:26 -0700
Message-ID: <b9ff5018454d2cc06b1dec9e3e2c1b866f0249e2.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/3] drm/xe: Route deferred xe_vma/xe_vm teardown off
 system_dfl_wq
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, dri-devel@lists.freedesktop.org,
 Danilo Krummrich <dakr@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,
 Alex Deucher <alexander.deucher@amd.com>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>
Date: Mon, 28 Sep 2026 10:50:24 +0200
In-Reply-To: <arbXBmprEiRY6fXR@gsse-cloud1.jf.intel.com>
References: <20260925133335.149679-1-thomas.hellstrom@linux.intel.com>
 <20260925133335.149679-4-thomas.hellstrom@linux.intel.com>
 <arbR+2Sxc9snuKSM@gsse-cloud1.jf.intel.com>
 <arbXBmprEiRY6fXR@gsse-cloud1.jf.intel.com>
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

On Fri, 2026-09-25 at 13:18 -0700, Matthew Brost wrote:
> On Fri, Sep 25, 2026 at 12:56:43PM -0700, Matthew Brost wrote:
> > On Fri, Sep 25, 2026 at 03:33:35PM +0200, Thomas Hellstr=C3=B6m wrote:
> > > xe_vma_destroy() can defer the final teardown of a struct xe_vma
> > > to a
> > > dma_fence completion callback (vma_destroy_cb()), and
> > > xe_vm_free() (the
> > > drm_gpuvm_ops.vm_free callback) always defers struct xe_vm
> > > teardown to
> > > a work item, since destroying a VM needs to sleep. Both used to
> > > queue
> > > their work on system_dfl_wq, a global, kernel-wide workqueue that
> > > xe
> > > has no control over and never waits on during module unload.
> > >=20
> > > drm_gpuvm_free() drops its drm_device reference immediately after
> > > calling xe_vm_free(), without waiting for the deferred work to
> > > run.
> > > The same applies one level down: whichever xe_vma or xe_vm
> > > reference
> > > happens to be the last one can trigger this chain from a
> > > dma_fence
> > > callback that may fire at an arbitrary time, including after the
> > > owning file has already been closed and its own module reference
> > > dropped. Since nothing tracks or waits for work queued on
> > > system_dfl_wq, `rmmod xe` could succeed and free the module's
> > > text
> > > while vma_destroy_work_func() or vm_destroy_work_func() is still
> > > queued or running on it, jumping into freed code.
> > >=20
> > > Fix this by queueing this work on xe_destroy_wq instead, the
> > > existing
> > > module-lifetime workqueue already used for GuC exec queue
> > > teardown.
> > > Unlike a per-device workqueue, this requires no dereference of a
> > > struct xe_device that may already be gone by the time a deferred
> > > callback fires, and unlike system_dfl_wq it is guaranteed to be
> > > drained by xe_destroy_wq_module_exit() before the module is
> > > unloaded,
> > > following the drm_pagemap_dev_hold()/unhold_work precedent of
> > > using a
> > > workqueue that is waited on at module unload rather than a bare
> > > module
> > > reference. The previous commit's reordering of
> > > xe_destroy_wq_exit()
> > > to run after xe_device_exit() guarantees that xe_destroy_wq is
> > > only
> > > torn down once the device-count has reached zero, i.e. after any
> > > xe_vma or xe_vm whose teardown queues work here has already
> > > dropped
> > > its drm_device reference and thus already queued that work.
> > >=20
> > > Signed-off-by: Thomas Hellstr=C3=B6m
> > > <thomas.hellstrom@linux.intel.com>
> > > Assisted-by: LLM
> > > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/xe/xe_module.c | 6 ++++--
> > > =C2=A0drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++--
> > > =C2=A02 files changed, 7 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/xe/xe_module.c
> > > b/drivers/gpu/drm/xe/xe_module.c
> > > index c61bd33546f2..897724cb5cfb 100644
> > > --- a/drivers/gpu/drm/xe/xe_module.c
> > > +++ b/drivers/gpu/drm/xe/xe_module.c
> > > @@ -114,8 +114,10 @@ static void xe_destroy_wq_module_exit(void)
> > > =C2=A0 * xe_destroy_wq_queue() - Queue work on the destroy workqueue
> > > =C2=A0 * @work: work item to queue
> > > =C2=A0 *
> > > - * The destroy workqueue has module lifetime and is used for GuC
> > > exec queue
> > > - * teardown that can outlive a single xe_device. SVM pagemap
> > > destroy uses the
> > > + * The destroy workqueue has module lifetime, and is guaranteed
> > > to outlive
> > > + * any xe_device, and to be drained before the module is
> > > unloaded. It is used
> > > + * for GuC exec queue and xe_vm/xe_vma teardown that can be
> > > deferred past the
> > > + * lifetime of the xe_device that triggered it. SVM pagemap
> > > destroy uses the
> > > =C2=A0 * per-device xe->destroy_wq instead.
> > > =C2=A0 *
> > > =C2=A0 * Return: %true if @work was queued, %false if it was already
> > > pending.
> > > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > > b/drivers/gpu/drm/xe/xe_vm.c
> > > index 390da884c727..ee369e6c3b28 100644
> > > --- a/drivers/gpu/drm/xe/xe_vm.c
> > > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > > @@ -29,6 +29,7 @@
> > > =C2=A0#include "xe_exec_queue.h"
> > > =C2=A0#include "xe_gt.h"
> > > =C2=A0#include "xe_migrate.h"
> > > +#include "xe_module.h"
> > > =C2=A0#include "xe_pagefault.h"
> > > =C2=A0#include "xe_pat.h"
> > > =C2=A0#include "xe_pm.h"
> > > @@ -1249,7 +1250,7 @@ static void vma_destroy_cb(struct dma_fence
> > > *fence,
> > > =C2=A0	struct xe_vma *vma =3D container_of(cb, struct xe_vma,
> > > destroy_cb);
> > > =C2=A0
> > > =C2=A0	INIT_WORK(&vma->destroy_work, vma_destroy_work_func);
> > > -	queue_work(system_dfl_wq, &vma->destroy_work);
> > > +	xe_destroy_wq_queue(&vma->destroy_work);
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0static void xe_vm_assert_write_mode_or_garbage_collector(struct
> > > xe_vm *vm)
> > > @@ -2059,7 +2060,7 @@ static void xe_vm_free(struct drm_gpuvm
> > > *gpuvm)
> > > =C2=A0	struct xe_vm *vm =3D container_of(gpuvm, struct xe_vm,
> > > gpuvm);
> > > =C2=A0
> > > =C2=A0	/* To destroy the VM we need to be able to sleep */
> > > -	queue_work(system_dfl_wq, &vm->destroy_work);
> > > +	xe_destroy_wq_queue(&vm->destroy_work);
> >=20
> > Actually this is still unsafe, right?
> >=20
> > destroy_work touches vm->xe which could be gone after gpuvm drops
> > potentially the final drm_dev_put, right?
> >=20
>=20
> Ignore this - we flush this queue before destorying any device.

Actually I think you have a point. The module-wide queue is destroyed
as the very last thing the module does. Having both a per-device
destroy queue and a module-wide one is confusing. Let me double-check
this. With this series we could just grab a device reference and
release it when we're done.

Thanks,
Thomas




>=20
> Matt
>=20
> > Matt=20
> >=20
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0struct xe_vm *xe_vm_lookup(struct xe_file *xef, u32 id)
> > > --=20
> > > 2.55.0
> > >=20
