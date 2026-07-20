Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B103C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:24:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7599110E161;
	Mon, 20 Jul 2026 10:24:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GJAgDjIx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98DF10E161;
 Mon, 20 Jul 2026 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784543098; x=1816079098;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=LltGeeU7vo7iI3eIijgdx3uVLt6N7V5/DVwcL5PP3W8=;
 b=GJAgDjIxBQxjp3dL7E+NYb8axbEkEVLNLZbfwiYZpm/oe0cy+mfbXG9q
 Yy5SY+ZmYA6aWnQMBudWCU/d0BrFiEkMePNGVj9m9c6Of4Jn7OOOHt4qe
 ZBmx+VrcQwwI4ICG1K1/0Oc0VetqENK+uYel0Vur494NjSmmnp6k4Y3x7
 bZ+3UHC8z8fevxvxnbI2Ps2aK9wkBR/6TkOWaXtvwQ+xlxtjvdhcnVAWw
 +tg8Yk0eDYq+JkCyIkXz7l9hqGzz9qmMkf9Q6eASAKRIu745NJ4SlmBSR
 Y+8btxqZR7K8GvHk/GZzMG+yfbv1A9WaYckpfnxDpxF7cjW8vI+7cjfuB g==;
X-CSE-ConnectionGUID: E+YfiI5fT1ekorye/hQnbA==
X-CSE-MsgGUID: cqWLpvIfTwalK7LU634Qaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="95714064"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="95714064"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:24:57 -0700
X-CSE-ConnectionGUID: vhFDZFJZSaWnY4wghdbZoQ==
X-CSE-MsgGUID: MjnyVWmsRviGrq7NSwfK+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="253473401"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.170])
 ([10.245.244.170])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:24:48 -0700
Message-ID: <6e46688dfbe23afbedc58f2a71f5d9629b21dc77.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] drm/xe: Add watch_queue-based device event
 notification
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>
Cc: intel-xe@lists.freedesktop.org, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Michal Mrozek
 <michal.mrozek@intel.com>,  John Falkowski <john.falkowski@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Lahtinen Joonas	
 <joonas.lahtinen@linux.intel.com>, David Howells <dhowells@redhat.com>, 
 Christian Brauner	 <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Davidlohr Bueso	 <dave@stgolabs.net>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Dave Airlie <airlied@gmail.com>, Simona Vetter	
 <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, LMKL	
 <linux-kernel@vger.kernel.org>
Date: Mon, 20 Jul 2026 12:24:35 +0200
In-Reply-To: <al2kEOXTybHlMhuR@gsse-cloud1.jf.intel.com>
References: <20260612135340.116100-1-thomas.hellstrom@linux.intel.com>
 <20260612135340.116100-5-thomas.hellstrom@linux.intel.com>
 <al2kEOXTybHlMhuR@gsse-cloud1.jf.intel.com>
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

On Sun, 2026-07-19 at 21:29 -0700, Matthew Brost wrote:
> On Fri, Jun 12, 2026 at 03:53:40PM +0200, Thomas Hellstr=C3=B6m wrote:
> > Add a watch_queue notification channel tied to struct xe_file so
> > that
> > userspace can subscribe to asynchronous GPU device events via the
> > general kernel notification mechanism.
> >=20
> > Introduce DRM_IOCTL_XE_WATCH_QUEUE to let userspace subscribe a
> > notification pipe (opened with pipe2(O_NOTIFICATION_PIPE)) to the
> > device
> > event stream.=C2=A0 Embed the watch_id field (0-255) in the
> > WATCH_INFO_ID
> > field of every notification, allowing multiple watches to share a
> > single
> > pipe and be told apart by the reader.
> >=20
> > Deliver notifications as struct drm_xe_watch_notification records,
> > with
> > type always set to WATCH_TYPE_DRM_XE_NOTIFY and subtype drawn from
> > enum
> > drm_xe_watch_event.=C2=A0 Define DRM_XE_WATCH_EVENT_VM_ERR as the first
> > event, posted by the preempt-rebind worker when a VM encounters an
> > unrecoverable error.=C2=A0 Expose xe_watch_queue_post_vm_err_event() as
> > the
> > in-kernel posting API.
> >=20
> > Add event definitions in a separate uapi header,
> > <drm/xe_drm_events.h>.
> > The main reason is that the header needs to include
> > <linux/watch_queue.h>
> > which in turn includes <linux/fcntl.h> which may conflict with the
> > system <fcntl.h>. Hence user-space must pay special attention when
> > including this file.
> >=20
> > Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> > Signed-off-by: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > ---
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/gpu/drm/xe/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/gpu/drm/xe/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/gpu/drm/xe/xe_device.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 7 ++
> > =C2=A0drivers/gpu/drm/xe/xe_device_types.h |=C2=A0=C2=A0 6 ++
> > =C2=A0drivers/gpu/drm/xe/xe_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A0drivers/gpu/drm/xe/xe_vm_types.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +
> > =C2=A0drivers/gpu/drm/xe/xe_watch_queue.c=C2=A0 | 111
> > +++++++++++++++++++++++++++
> > =C2=A0drivers/gpu/drm/xe/xe_watch_queue.h=C2=A0 |=C2=A0 20 +++++
> > =C2=A0include/uapi/drm/xe_drm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 45 +++++++++++
> > =C2=A0include/uapi/drm/xe_drm_events.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
62 +++++++++++++++
> > =C2=A011 files changed, 260 insertions(+)
> > =C2=A0create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.c
> > =C2=A0create mode 100644 drivers/gpu/drm/xe/xe_watch_queue.h
> > =C2=A0create mode 100644 include/uapi/drm/xe_drm_events.h
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 8c0d9965c636..b7e02cfa692b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12900,6 +12900,7 @@ F:	Documentation/gpu/xe/
> > =C2=A0F:	drivers/gpu/drm/xe/
> > =C2=A0F:	include/drm/intel/
> > =C2=A0F:	include/uapi/drm/xe_drm.h
> > +F:	include/uapi/drm/xe_drm_events.h
> > =C2=A0
> > =C2=A0INTEL ELKHART LAKE PSE I/O DRIVER
> > =C2=A0M:	Raag Jadav <raag.jadav@intel.com>
> > diff --git a/drivers/gpu/drm/xe/Kconfig
> > b/drivers/gpu/drm/xe/Kconfig
> > index 4d7dcaff2b91..dbdc2fb49c53 100644
> > --- a/drivers/gpu/drm/xe/Kconfig
> > +++ b/drivers/gpu/drm/xe/Kconfig
> > @@ -25,6 +25,7 @@ config DRM_XE
> > =C2=A0	select DRM_MIPI_DSI
> > =C2=A0	select RELAY
> > =C2=A0	select IRQ_WORK
> > +	select WATCH_QUEUE
> > =C2=A0	# xe depends on ACPI_VIDEO when ACPI is enabled
> > =C2=A0	# but for select to work, need to select ACPI_VIDEO's
> > dependencies, ick
> > =C2=A0	select BACKLIGHT_CLASS_DEVICE if ACPI
> > diff --git a/drivers/gpu/drm/xe/Makefile
> > b/drivers/gpu/drm/xe/Makefile
> > index 8e7b146880f4..fc8b4023a044 100644
> > --- a/drivers/gpu/drm/xe/Makefile
> > +++ b/drivers/gpu/drm/xe/Makefile
> > @@ -150,6 +150,7 @@ xe-y +=3D xe_bb.o \
> > =C2=A0	xe_vsec.o \
> > =C2=A0	xe_wa.o \
> > =C2=A0	xe_wait_user_fence.o \
> > +	xe_watch_queue.o \
> > =C2=A0	xe_wopcm.o
> > =C2=A0
> > =C2=A0xe-$(CONFIG_I2C)	+=3D xe_i2c.o
> > diff --git a/drivers/gpu/drm/xe/xe_device.c
> > b/drivers/gpu/drm/xe/xe_device.c
> > index 867d7c55dc03..788ef2fbd6e5 100644
> > --- a/drivers/gpu/drm/xe/xe_device.c
> > +++ b/drivers/gpu/drm/xe/xe_device.c
> > @@ -9,6 +9,7 @@
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/fault-inject.h>
> > =C2=A0#include <linux/units.h>
> > +#include <linux/watch_queue.h>
> > =C2=A0
> > =C2=A0#include <drm/drm_client.h>
> > =C2=A0#include <drm/drm_gem_ttm_helper.h>
> > @@ -77,6 +78,7 @@
> > =C2=A0#include "xe_vsec.h"
> > =C2=A0#include "xe_wait_user_fence.h"
> > =C2=A0#include "xe_wa.h"
> > +#include "xe_watch_queue.h"
> > =C2=A0
> > =C2=A0#include <generated/xe_device_wa_oob.h>
> > =C2=A0#include <generated/xe_wa_oob.h>
> > @@ -112,6 +114,8 @@ static int xe_file_open(struct drm_device *dev,
> > struct drm_file *file)
> > =C2=A0	file->driver_priv =3D xef;
> > =C2=A0	kref_init(&xef->refcount);
> > =C2=A0
> > +	init_watch_list(&xef->watch_list, NULL);
> > +
> > =C2=A0	task =3D get_pid_task(rcu_access_pointer(file->pid),
> > PIDTYPE_PID);
> > =C2=A0	if (task) {
> > =C2=A0		xef->process_name =3D kstrdup(task->comm,
> > GFP_KERNEL);
> > @@ -126,6 +130,8 @@ static void xe_file_destroy(struct kref *ref)
> > =C2=A0{
> > =C2=A0	struct xe_file *xef =3D container_of(ref, struct xe_file,
> > refcount);
> > =C2=A0
> > +	remove_watch_from_object(&xef->watch_list, NULL, 0, true);
> > +
> > =C2=A0	xa_destroy(&xef->exec_queue.xa);
> > =C2=A0	mutex_destroy(&xef->exec_queue.lock);
> > =C2=A0	xa_destroy(&xef->vm.xa);
> > @@ -216,6 +222,7 @@ static const struct drm_ioctl_desc xe_ioctls[]
> > =3D {
> > =C2=A0	DRM_IOCTL_DEF_DRV(XE_VM_GET_PROPERTY,
> > xe_vm_get_property_ioctl,
> > =C2=A0			=C2=A0 DRM_RENDER_ALLOW),
> > =C2=A0	DRM_IOCTL_DEF_DRV(XE_VM_RESTART, xe_vm_restart_ioctl,
> > DRM_RENDER_ALLOW),
> > +	DRM_IOCTL_DEF_DRV(XE_WATCH_QUEUE, xe_watch_queue_ioctl,
> > DRM_RENDER_ALLOW),
> > =C2=A0};
> > =C2=A0
> > =C2=A0static long xe_drm_ioctl(struct file *file, unsigned int cmd,
> > unsigned long arg)
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h
> > b/drivers/gpu/drm/xe/xe_device_types.h
> > index 32dd2ffbc796..ca726ada30a7 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -11,6 +11,7 @@
> > =C2=A0#include <drm/drm_device.h>
> > =C2=A0#include <drm/drm_file.h>
> > =C2=A0#include <drm/ttm/ttm_device.h>
> > +#include <linux/watch_queue.h>
> > =C2=A0
> > =C2=A0#include "xe_devcoredump_types.h"
> > =C2=A0#include "xe_drm_ras_types.h"
> > @@ -632,6 +633,11 @@ struct xe_file {
> > =C2=A0
> > =C2=A0	/** @refcount: ref count of this xe file */
> > =C2=A0	struct kref refcount;
> > +
> > +#ifdef CONFIG_WATCH_QUEUE
> > +	/** @watch_list: per-file notification source for device
> > events */
> > +	struct watch_list watch_list;
> > +#endif
> > =C2=A0};
> > =C2=A0
> > =C2=A0#endif
> > diff --git a/drivers/gpu/drm/xe/xe_vm.c
> > b/drivers/gpu/drm/xe/xe_vm.c
> > index b69a2e5bd9c9..232de0d948d2 100644
> > --- a/drivers/gpu/drm/xe/xe_vm.c
> > +++ b/drivers/gpu/drm/xe/xe_vm.c
> > @@ -13,6 +13,7 @@
> > =C2=A0#include <drm/drm_print.h>
> > =C2=A0#include <drm/ttm/ttm_tt.h>
> > =C2=A0#include <uapi/drm/xe_drm.h>
> > +#include <uapi/drm/xe_drm_events.h>
> > =C2=A0#include <linux/ascii85.h>
> > =C2=A0#include <linux/delay.h>
> > =C2=A0#include <linux/kthread.h>
> > @@ -45,6 +46,7 @@
> > =C2=A0#include "xe_trace_bo.h"
> > =C2=A0#include "xe_vm_madvise.h"
> > =C2=A0#include "xe_wa.h"
> > +#include "xe_watch_queue.h"
> > =C2=A0
> > =C2=A0#ifdef CONFIG_FAULT_INJECTION
> > =C2=A0static DECLARE_FAULT_ATTR(rebind_enospc);
> > @@ -584,6 +586,7 @@ static void preempt_rebind_work_func(struct
> > work_struct *w)
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	if (err) {
> > +		xe_watch_queue_post_vm_err_event(vm->xef, vm->id,
> > err);
> > =C2=A0		if ((err =3D=3D -ENOMEM || err =3D=3D -ENOSPC) &&
> > xe_vm_is_restartable(vm)) {
> > =C2=A0			vm->preempt.rebind_deactivated =3D true;
> > =C2=A0			drm_dbg(&vm->xe->drm, "Rebind deactivated
> > VM on error %pe\n",
> > @@ -2229,6 +2232,7 @@ int xe_vm_create_ioctl(struct drm_device
> > *dev, void *data,
> > =C2=A0	if (err)
> > =C2=A0		goto err_close_and_put;
> > =C2=A0
> > +	vm->id =3D id;
> > =C2=A0	args->vm_id =3D id;
> > =C2=A0
> > =C2=A0	return 0;
> > diff --git a/drivers/gpu/drm/xe/xe_vm_types.h
> > b/drivers/gpu/drm/xe/xe_vm_types.h
> > index 7d295c3b8456..19a673099588 100644
> > --- a/drivers/gpu/drm/xe/xe_vm_types.h
> > +++ b/drivers/gpu/drm/xe/xe_vm_types.h
> > @@ -407,6 +407,8 @@ struct xe_vm {
> > =C2=A0	bool batch_invalidate_tlb;
> > =C2=A0	/** @xef: Xe file handle for tracking this VM's drm client
> > */
> > =C2=A0	struct xe_file *xef;
> > +	/** @id: The id of the VM in the VM table of @xef. */
> > +	u32 id;
> > =C2=A0};
> > =C2=A0
> > =C2=A0/** struct xe_vma_op_map - VMA map operation */
> > diff --git a/drivers/gpu/drm/xe/xe_watch_queue.c
> > b/drivers/gpu/drm/xe/xe_watch_queue.c
> > new file mode 100644
> > index 000000000000..32763591075b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/xe/xe_watch_queue.c
> > @@ -0,0 +1,111 @@
> > +// SPDX-License-Identifier: MIT
> > +/*
> > + * Copyright =C2=A9 2026 Intel Corporation
> > + */
> > +
> > +#include <linux/slab.h>
> > +#include <linux/timekeeping.h>
> > +#include <linux/watch_queue.h>
> > +
> > +#include <uapi/drm/xe_drm.h>
> > +#include <uapi/drm/xe_drm_events.h>
> > +
> > +#include "xe_device.h"
> > +#include "xe_device_types.h"
> > +#include "xe_macros.h"
> > +#include "xe_watch_queue.h"
> > +
> > +/**
> > + * struct xe_watch_notification_vm_err - kernel-side VM error
> > event notification
> > + * @base: common watch notification header; type is
> > %WATCH_TYPE_DRM_XE_NOTIFY,
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 subtype is %DRM_XE_WATCH_=
EVENT_VM_ERR
> > + * @vm_id: ID of the VM that hit error
> > + * @error_code: error code describing the error condition
> > (negative errno)
> > + * @timestamp_ns: CLOCK_MONOTONIC timestamp in nanoseconds at the
> > point the
> > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 error was detected
> > + *
> > + * Layout mirrors &struct drm_xe_watch_notification_vm_err.
> > + */
> > +struct xe_watch_notification_vm_err {
> > +	struct watch_notification base;
> > +	u32 vm_id;
> > +	s32 error_code;
> > +	u64 timestamp_ns;
> > +};
> > +
> > +/**
> > + * xe_watch_queue_ioctl() - Subscribe a pipe to per-file device
> > event notifications
> > + * @dev: DRM device
> > + * @data: pointer to &struct drm_xe_watch_queue from userspace
> > + * @file: DRM file handle of the subscribing process
> > + *
> > + * Subscribes a notification pipe to receive Xe device events for
> > the calling
> > + * process's file handle.=C2=A0 Only events scoped to this file (e.g.
> > VM error on a
> > + * VM owned by this file) are delivered.=C2=A0 The pipe must have been
> > opened with
> > + * O_NOTIFICATION_PIPE and sized with %IOC_WATCH_QUEUE_SET_SIZE
> > before calling
> > + * this IOCTL.
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int xe_watch_queue_ioctl(struct drm_device *dev, void *data,
> > struct drm_file *file)
> > +{
> > +	struct xe_file *xef =3D file->driver_priv;
> > +	struct xe_device *xe =3D to_xe_device(dev);
> > +	struct drm_xe_watch_queue *args =3D data;
> > +	struct watch_queue *wqueue;
> > +	struct watch *watch;
> > +	int ret;
> > +
> > +	if (XE_IOCTL_DBG(xe, args->flags || args->pad))
> > +		return -EINVAL;
> > +	if (XE_IOCTL_DBG(xe, args->watch_id > 0xff))
> > +		return -EINVAL;
> > +
> > +	wqueue =3D get_watch_queue(args->fd);
> > +	if (XE_IOCTL_DBG(xe, IS_ERR(wqueue)))
> > +		return PTR_ERR(wqueue);
> > +
> > +	watch =3D kzalloc_obj(*watch, GFP_KERNEL | __GFP_ACCOUNT);
> > +	if (XE_IOCTL_DBG(xe, !watch)) {
> > +		ret =3D -ENOMEM;
> > +		goto out_put_queue;
> > +	}
> > +
> > +	init_watch(watch, wqueue);
> > +	watch->id =3D 0;
> > +	watch->info_id =3D (u32)args->watch_id <<
> > WATCH_INFO_ID__SHIFT;
> > +
> > +	ret =3D add_watch_to_object(watch, &xef->watch_list);
> > +	if (XE_IOCTL_DBG(xe, ret))
> > +		kfree(watch);
> > +
> > +out_put_queue:
> > +	put_watch_queue(wqueue);
> > +	return ret;
> > +}
> > +
> > +/**
> > + * xe_watch_queue_post_vm_err_event() - Post a VM error event
> > + * @xef: xe file handle that owns the VM
> > + * @vm_id: userspace ID of the VM that hit error
> > + * @error_code: error code describing the error condition
> > (negative errno)
> > + *
> > + * Posts a %DRM_XE_WATCH_EVENT_VM_ERR notification carrying @vm_id
> > and
> > + * @error_code to every pipe that @xef has subscribed via
> > + * %DRM_IOCTL_XE_WATCH_QUEUE.=C2=A0 Only the owning process is
> > notified,
> > + * preventing information leaks to other clients.
> > + */
> > +void xe_watch_queue_post_vm_err_event(struct xe_file *xef, u32
> > vm_id,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error_code)
> > +{
> > +	struct xe_watch_notification_vm_err n =3D {};
> > +
> > +	n.base.type=C2=A0=C2=A0=C2=A0 =3D WATCH_TYPE_DRM_XE_NOTIFY;
> > +	n.base.subtype =3D DRM_XE_WATCH_EVENT_VM_ERR;
> > +	n.base.info=C2=A0=C2=A0=C2=A0 =3D watch_sizeof(struct
> > xe_watch_notification_vm_err);
> > +	n.vm_id=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D vm_id;
> > +	n.error_code=C2=A0=C2=A0 =3D error_code;
> > +	n.timestamp_ns =3D ktime_get_ns();
> > +
> > +	post_watch_notification(&xef->watch_list, &n.base,
> > current_cred(), 0);
>=20
> Is this reclaim safe (i.e., could we post a watch notification in
> direct
> reclaim from our shrinker)? From my look, I think the answer is yes.
> I
> ask because whatever we land here, I think the answer must be KMD-
> >UMD
> events are reclaim safe.

From my understanding, inside post_watch_notification() there is no
memory allocation, and the only locks that become tainted are
spinlocks, so this should be safe, and tainting the spinlocks would not
affect any existing or future users in the tree.

/Thomas


>=20
> Matt=20
>=20
> > +}
> > diff --git a/drivers/gpu/drm/xe/xe_watch_queue.h
> > b/drivers/gpu/drm/xe/xe_watch_queue.h
> > new file mode 100644
> > index 000000000000..ad199ee68205
> > --- /dev/null
> > +++ b/drivers/gpu/drm/xe/xe_watch_queue.h
> > @@ -0,0 +1,20 @@
> > +/* SPDX-License-Identifier: MIT */
> > +/*
> > + * Copyright =C2=A9 2026 Intel Corporation
> > + */
> > +
> > +#ifndef _XE_WATCH_QUEUE_H_
> > +#define _XE_WATCH_QUEUE_H_
> > +
> > +#include <linux/types.h>
> > +
> > +struct drm_device;
> > +struct drm_file;
> > +struct xe_file;
> > +
> > +int xe_watch_queue_ioctl(struct drm_device *dev, void *data,
> > +			 struct drm_file *file);
> > +void xe_watch_queue_post_vm_err_event(struct xe_file *xef, u32
> > vm_id,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int error_code);
> > +
> > +#endif /* _XE_WATCH_QUEUE_H_ */
> > diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
> > index 8d5e3f06b8d4..0083dd712f7e 100644
> > --- a/include/uapi/drm/xe_drm.h
> > +++ b/include/uapi/drm/xe_drm.h
> > @@ -86,6 +86,7 @@ extern "C" {
> > =C2=A0 *=C2=A0 - &DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY
> > =C2=A0 *=C2=A0 - &DRM_IOCTL_XE_VM_GET_PROPERTY
> > =C2=A0 *=C2=A0 - &DRM_IOCTL_XE_VM_RESTART
> > + *=C2=A0 - &DRM_IOCTL_XE_WATCH_QUEUE
> > =C2=A0 */
> > =C2=A0
> > =C2=A0/*
> > @@ -112,6 +113,7 @@ extern "C" {
> > =C2=A0#define DRM_XE_EXEC_QUEUE_SET_PROPERTY	0x0e
> > =C2=A0#define DRM_XE_VM_GET_PROPERTY		0x0f
> > =C2=A0#define DRM_XE_VM_RESTART		0x10
> > +#define DRM_XE_WATCH_QUEUE		0x11
> > =C2=A0
> > =C2=A0/* Must be kept compact -- no holes */
> > =C2=A0
> > @@ -132,6 +134,7 @@ extern "C" {
> > =C2=A0#define
> > DRM_IOCTL_XE_EXEC_QUEUE_SET_PROPERTY	DRM_IOW(DRM_COMMAND_BASE + DRM_XE_=
EXEC_QUEUE_SET_PROPERTY,structdrm_xe_exec_queue_set_property)
> > =C2=A0#define
> > DRM_IOCTL_XE_VM_GET_PROPERTY		DRM_IOWR(DRM_COMMAND_BASE + DRM_XE_VM_GET=
_PROPERTY,structdrm_xe_vm_get_property)
> > =C2=A0#define
> > DRM_IOCTL_XE_VM_RESTART			DRM_IOW(DRM_COMMAND_BASE + DRM_XE_VM_RESTART,=
structdrm_xe_vm_restart)
> > +#define
> > DRM_IOCTL_XE_WATCH_QUEUE		DRM_IOW(DRM_COMMAND_BASE + DRM_XE_WATCH_QUEUE=
,structdrm_xe_watch_queue)
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * DOC: Xe IOCTL Extensions
> > @@ -2653,6 +2656,48 @@ enum drm_xe_ras_error_component {
> > =C2=A0	[DRM_XE_RAS_ERR_COMP_SOC_INTERNAL] =3D "soc-
> > internal"		\
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * DOC: DRM_XE_WATCH_QUEUE
> > + *
> > + * Subscribe a notification pipe to receive device events for the
> > calling
> > + * process's DRM file handle.=C2=A0 Events are scoped to the
> > subscribing file:
> > + * only events that belong to that file (for example, VM error on
> > a VM created
> > + * through the same file) are delivered, preventing information
> > leaks between
> > + * processes sharing the same GPU device.
> > + *
> > + * The pipe must first be opened with O_NOTIFICATION_PIPE (i.e.
> > O_EXCL passed
> > + * to pipe2()) and sized via %IOC_WATCH_QUEUE_SET_SIZE before
> > subscribing.
> > + *
> > + * Events are delivered as notification records read from the
> > pipe.=C2=A0 The
> > + * @watch_id field is embedded in the notification info field and
> > can be used
> > + * to distinguish multiple watches sharing a pipe.
> > + *
> > + * Currently defined event subtypes:
> > + *=C2=A0 - %DRM_XE_WATCH_EVENT_VM_ERR - a VM owned by this file has
> > encountered an error
> > + */
> > +
> > +/**
> > + * struct drm_xe_watch_queue - subscribe to device event
> > notifications
> > + *
> > + * Used with %DRM_IOCTL_XE_WATCH_QUEUE.=C2=A0 Notifications are scoped
> > to the
> > + * DRM file handle used to issue this IOCTL.
> > + */
> > +struct drm_xe_watch_queue {
> > +	/** @fd: file descriptor of pipe opened with
> > O_NOTIFICATION_PIPE */
> > +	__u32 fd;
> > +
> > +	/**
> > +	 * @watch_id: identifier (0=E2=80=93255) embedded in the watch
> > notification
> > +	 * info field; allows multiplexing several watches on one
> > pipe
> > +	 */
> > +	__u32 watch_id;
> > +
> > +	/** @flags: must be zero */
> > +	__u32 flags;
> > +
> > +	/** @pad: reserved, must be zero */
> > +	__u32 pad;
> > +};
> > =C2=A0#if defined(__cplusplus)
> > =C2=A0}
> > =C2=A0#endif
> > diff --git a/include/uapi/drm/xe_drm_events.h
> > b/include/uapi/drm/xe_drm_events.h
> > new file mode 100644
> > index 000000000000..6cc7528bfb9b
> > --- /dev/null
> > +++ b/include/uapi/drm/xe_drm_events.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: MIT */
> > +/*
> > + * Copyright =C2=A9 2026 Intel Corporation
> > + */
> > +
> > +#ifndef _UAPI_XE_DRM_EVENTS_H_
> > +#define _UAPI_XE_DRM_EVENTS_H_
> > +
> > +#include <linux/types.h>
> > +#include <linux/watch_queue.h>
> > +
> > +#if defined(__cplusplus)
> > +extern "C" {
> > +#endif
> > +
> > +/**
> > + * enum drm_xe_watch_event - Xe device watch event subtypes
> > + *
> > + * Subtypes for notifications delivered via
> > %WATCH_TYPE_DRM_XE_NOTIFY when
> > + * reading from a pipe subscribed with %DRM_IOCTL_XE_WATCH_QUEUE.
> > + */
> > +enum drm_xe_watch_event {
> > +	/**
> > +	 * @DRM_XE_WATCH_EVENT_VM_ERR: a VM has encountered an
> > error.
> > +	 *
> > +	 * Indicates that a fatal or resource error occurred
> > within the given
> > +	 * VM.=C2=A0 The vm_id of the affected VM is carried in the
> > +	 * @drm_xe_watch_notification_vm_err::vm_id field of the
> > extended
> > +	 * notification record.
> > +	 */
> > +	DRM_XE_WATCH_EVENT_VM_ERR =3D 0,
> > +};
> > +
> > +/**
> > + * struct drm_xe_watch_notification_vm_err - VM error event
> > notification
> > + *
> > + * Notification record delivered for %DRM_XE_WATCH_EVENT_VM_ERR.
> > + * The record type is always %WATCH_TYPE_DRM_XE_NOTIFY and the
> > subtype is
> > + * %DRM_XE_WATCH_EVENT_VM_ERR.
> > + */
> > +struct drm_xe_watch_notification_vm_err {
> > +	/** @base: common watch notification header */
> > +	struct watch_notification base;
> > +
> > +	/** @vm_id: ID of the VM that encountered an error */
> > +	__u32 vm_id;
> > +
> > +	/** @error_code: error code describing the error condition
> > (negative errno) */
> > +	__s32 error_code;
> > +
> > +	/**
> > +	 * @timestamp_ns: CLOCK_MONOTONIC timestamp in nanoseconds
> > at the
> > +	 * point the error was detected
> > +	 */
> > +	__u64 timestamp_ns;
> > +};
> > +
> > +#if defined(__cplusplus)
> > +}
> > +#endif
> > +
> > +#endif /* _UAPI_XE_DRM_EVENTS_H_ */
> > --=20
> > 2.54.0
> >=20
