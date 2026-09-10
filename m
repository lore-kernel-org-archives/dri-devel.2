Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2439CC79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:45:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4978B10E5D9;
	Thu, 10 Sep 2026 10:45:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S9ZnpE2N";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B209B10E5D6;
 Thu, 10 Sep 2026 10:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789037130; x=1820573130;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=vkOKMGgc9G7SbMZgQ3hTfb/RlQAm2HAlcp/Na0PUsyU=;
 b=S9ZnpE2NOAlNTslaRgiYrOV+a5NQejC53A/MDSBAk7ts3znRhWm2Gtly
 8LD+3O3D/5lXc85uBcJiFIrQqA9s/kmlLYCpWtwJhMILP5lrh3s8/ZP+g
 4BLI/fjV+AK3FXsc6jaUPj/GN13ckK7AfhRozHTt+OYVI9KFqbO5QMVL7
 nLHR5BPMTNXy87s2GJEl6ySdmQoHPoct4/61SZiWUle0Hx4WEqTLBweyZ
 DsODkKRvyRejANY1lsgm7zh6ZobsOLIoSvhYwESFORQEB41bb7r7KAJIW
 s9P8IGcpKs+ddca0Ga7+YkaWAegaNtwEsz9Z5g19vMxHdYek5Gy2Jq3W2 w==;
X-CSE-ConnectionGUID: 0iJysYvZSiWdvDHcJgSvIA==
X-CSE-MsgGUID: BXiKw2ISQkqnhnUWjCMfnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="77040992"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="77040992"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:45:29 -0700
X-CSE-ConnectionGUID: PSTvUKuFRtqX2OHvm6VlXA==
X-CSE-MsgGUID: WH6QmlO0SDKE2lyOeSFA6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="270241267"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.193])
 ([10.245.245.193])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 03:45:27 -0700
Message-ID: <5c1b30dcb4342bd0ee43815434f8df4912709b8a.camel@linux.intel.com>
Subject: Re: [PATCH 00/13] drm/xe: Isolate wedged devices from hardware access
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com, 
 rodrigo.vivi@intel.com
Date: Thu, 10 Sep 2026 12:45:24 +0200
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

On Thu, 2026-08-27 at 15:47 +0530, Arvind Yadav wrote:
> A permanently wedged device can still access hardware through pending
> work,
> existing VRAM mappings and background driver paths. This can cause
> unwanted
> DMA or MMIO access while userspace is preparing device recovery.
>=20
> This series separates temporary PCI error recovery from permanent
> wedging and
> introduces a common device-I/O-blocked state.
>=20
> After a permanent wedge, the driver:
> - stops queued VM, SVM and GuC work.
> - shuts down the display.
> - invalidates existing CPU mappings to VRAM.
> - maps later CPU faults to a per-BO dummy page.
> - stops interrupts and clears PCI bus mastering.
> - rejects new VRAM allocations.
> - notifies userspace only after isolation completes.
> - drops queued page faults and stops VM, SVM and GuC work.
>=20
> System suspend waits for wedge isolation to complete before skipping
> the
> normal suspend path. The worker cannot reach synchronize_srcu() until
> all
> GTs have been declared wedged and their pending fences have been
> signalled.
>=20
> The device remains isolated until userspace performs the advertised
> recovery,
> such as driver rebind or bus reset.
>=20
> The series also fixes IRQ uninstall so requested handlers are freed
> after
> interrupts have already been suspended.
>=20
> Arvind Yadav (13):
> =C2=A0 drm/xe/irq: Always free requested IRQs on uninstall
> =C2=A0 drm/xe: Separate AER reset state from device wedging
> =C2=A0 drm/xe: Drop queued page faults when device I/O is blocked
> =C2=A0 drm/xe: Stop VM work when device I/O is blocked
> =C2=A0 drm/xe: Send wedged notification from a worker
> =C2=A0 drm/xe: Reuse one dummy page per BO after wedge
> =C2=A0 drm/xe: Invalidate existing VRAM mappings on wedge
> =C2=A0 drm/xe/irq: Serialize IRQ suspend and resume
> =C2=A0 drm/xe: Isolate a wedged device before notifying userspace
> =C2=A0 drm/xe/ttm: Reject VRAM allocations on wedged devices
> =C2=A0 drm/xe/guc: Skip timeout recovery on a wedged device
> =C2=A0 drm/xe: Skip PM notifier preparation for wedged devices
> =C2=A0 drm/xe: Block BO VM access when device I/O is unavailable
>=20
> =C2=A0drivers/gpu/drm/xe/display/xe_display.c |=C2=A0 18 +++-
> =C2=A0drivers/gpu/drm/xe/xe_bo.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 101 +++++++++++++++++++-
> =C2=A0drivers/gpu/drm/xe/xe_bo.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/xe/xe_bo_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0drivers/gpu/drm/xe/xe_device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 118 ++++++++++++++++++++--
> --
> =C2=A0drivers/gpu/drm/xe/xe_device.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +++
> =C2=A0drivers/gpu/drm/xe/xe_device_types.h=C2=A0=C2=A0=C2=A0 |=C2=A0 26 +=
+++++
> =C2=A0drivers/gpu/drm/xe/xe_guc_ct.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0drivers/gpu/drm/xe/xe_guc_pc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +-
> =C2=A0drivers/gpu/drm/xe/xe_guc_rc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0drivers/gpu/drm/xe/xe_guc_submit.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 13 ++-
> =C2=A0drivers/gpu/drm/xe/xe_guc_tlb_inval.c=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +=
-
> =C2=A0drivers/gpu/drm/xe/xe_irq.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 32 +++++--
> =C2=A0drivers/gpu/drm/xe/xe_pagefault.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 40 ++++++++
> =C2=A0drivers/gpu/drm/xe/xe_pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 23 ++++-
> =C2=A0drivers/gpu/drm/xe/xe_pci_error.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 22 ++---
> =C2=A0drivers/gpu/drm/xe/xe_pm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 ++++++
> =C2=A0drivers/gpu/drm/xe/xe_sriov_pf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/gpu/drm/xe/xe_svm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 21 ++++-
> =C2=A0drivers/gpu/drm/xe/xe_ttm_vram_mgr.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 4 +
> =C2=A0drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 ++++
> =C2=A021 files changed, 446 insertions(+), 60 deletions(-)

Hi, Arvind.

I think this series lacks context to some extent. Much of the code is
also inheritly racy [1]. because current hardware accesses aren't
drained before reset or wedging. What I think is needed here is a
design detailing

1) What type of user-space accesses and workqueues are completely
blocked (for example sharing the newly introduced vram_userfault.srcu)
This can perhaps also be combined with the drm SRCU since I figure
there might be multiple places where we ensure hardware is present
using drm_dev_enter / drm_dev_exit and also want to check whether it's
wedged or not.

See an example in
https://gitlab.freedesktop.org/thomash/kernel/-/commits/wedge?ref_type=3Dhe=
ads
(Note that this is just an example, not fully adapted to the intentions
in this series).

2) How is user-space supposed to respond to a recoverable PCIe reset?
Currently? If a change is planned, In the future? Is it the case that
currently we flag "In reset" and then force the user to close its drm
connection and re-discover a recovered device? Is this about to change
and hence the distinction between PCIe reset and permanent wedging?

It looks like AMD might have an rwsem that just blocks callers over a
reset and perhaps notifies them that, for example VRAM is lost. In any
case, in addition to locking out new callers we need to drain old
callers:

[1]
Thread A                   Thread B

is_io_allowed()
			    disable_io()

access_hardware()	    reset()

Bang!

Thanks,
Thomas
