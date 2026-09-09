Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3151C79FBF
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C402510E175;
	Wed,  9 Sep 2026 14:51:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q3MzKuIF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29A3310E175;
 Wed,  9 Sep 2026 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788965487; x=1820501487;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=S6Bg5dd0rBRENwk7hGa55DW3vqRfuWWzVAUJKJGp/Xk=;
 b=Q3MzKuIFtd3+o1DRa1YMndxWC717gdIOr/oxY3eBRQHC2YtZV23pWK72
 SLWnJdvTkn7Gk3HVJ1g1e4XoeQnQulUd8ecZx4ME36CwDpe3W8IRa9nWt
 WZce8h44DXnBX7AnNHAaMeKnlJydGsnByDm9ujVwFeFl280Qp+kXirDMM
 bdNH0vFuIwqgdRnf5CtKIUbd501E+uJMLgqsWNRGjIYFuU9jQgRM78z/0
 L6pWSXHiIkJOu3qs+6e2IL2M9hGYi0+7NYWVHjkWh7XDQSLyqP48+FwpF
 yER7itAyiSgcmPaNoWUGLY1/Pk48bOx7ghuxkKMAjYXulHhONbZmWx6de A==;
X-CSE-ConnectionGUID: xZBgGUTzRUWbF4TZRkRstQ==
X-CSE-MsgGUID: pOkRfrUrThqtu7m+EodZYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89263198"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89263198"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 07:51:26 -0700
X-CSE-ConnectionGUID: 88RNOmbkSHiGwLK5a5PqvQ==
X-CSE-MsgGUID: ILfhd0crSpuNLp0FcqyurA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="267662499"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.37])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 07:51:22 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3c7020e8-eeab-4cc2-9286-2ca613c08e07@amd.com>
References: <20260903145952.848051-1-mika.kuoppala@linux.intel.com>
 <20260903145952.848051-5-mika.kuoppala@linux.intel.com>
 <20260903152224.AD48C1F00A3F@smtp.kernel.org>
 <178878748003.179185.16833574173741290547@jlahtine-mobl>
 <178894801687.37859.4186888279082797860@jlahtine-mobl>
 <aqEzHQMrI8p9XVcu@phenom.ffwll.local>
 <785085e8-c9db-4d84-ab55-3a8caf9f4a35@amd.com>
 <178895308548.62143.17472983986994555742@jlahtine-mobl>
 <3c7020e8-eeab-4cc2-9286-2ca613c08e07@amd.com>
Subject: Re: FUSE deadlocks vs. copy_from_user() and locks (Was: Re: [PATCH
 v10 04/27] drm/xe/eudebug: Introduce discovery for resources)
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>,
 Joanne Koong <joannelkoong@gmail.com>, Amir Goldstein <amir73il@gmail.com>,
 intel-xe@lists.freedesktop.org, fuse-devel@lists.linux.dev,
 sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?utf-8?q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
To: Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>,
 Simona Vetter <simona.vetter@ffwll.ch>
Date: Wed, 09 Sep 2026 17:51:18 +0300
Message-ID: <178896547895.102087.5758513424678942429@jlahtine-mobl>
User-Agent: alot/0.13.dev2+g40c57d620
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

Quoting Christian K=C3=B6nig (2026-09-09 16:03:30)
> On 9/9/26 13:24, Joonas Lahtinen wrote:
> > (+ userfaultfd maintainers)
> >=20
> > Quoting Christian K=C3=B6nig (2026-09-09 14:02:21)
> >> On 9/9/26 12:21, Simona Vetter wrote:
> >>> On Wed, Sep 09, 2026 at 01:00:16PM +0300, Joonas Lahtinen wrote:
> >>>> (Adding bunch of FUSE folks and DRM folks in the hopes of coming to a
> >>>> resolution here.)
> >>>>
> >>>> Quoting Joonas Lahtinen (2026-09-07 16:24:40)
> >>>>> Quoting sashiko-bot@kernel.org (2026-09-03 18:22:23)
> >>>>>> Thank you for your contribution! Sashiko AI review found 2 potenti=
al issue(s) to consider:
> >>>>>> - [High] Global ordered workqueue stall via copy_from_user block w=
hile holding ioctl_lock.
> >>>>>> - [Medium] Event sequence numbers (seqno) can be queued out-of-ord=
er in the event stream due to a race between seqno generation and event que=
uing.
> >>>>>> --
> >>>>>>
> >>>>>> commit e2061e72d8e954a17bde35e9c970ee41bc2db0ad
> >>>>>> Author: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> >>>>>>
> >>>>>>     drm/xe/eudebug: Introduce discovery for resources
> >>>>>>
> >>>>>> This commit introduces a resource discovery mechanism for debugger=
 connections.
> >>>>>> When a debugger connects, all existing resources for the target cl=
ient are
> >>>>>> relayed as events via an ordered workqueue, and DRM ioctls are blo=
cked using
> >>>>>> an rw_semaphore until discovery is complete.
> >>>>>>
> >>>>>>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/=
xe_device.c
> >>>>>>> index 032a7ec5fbc8d..f10959b898297 100644
> >>>>>>> --- a/drivers/gpu/drm/xe/xe_device.c
> >>>>>>> +++ b/drivers/gpu/drm/xe/xe_device.c
> >>>>>> [ ... ]
> >>>>>>> @@ -238,8 +239,12 @@ static long xe_drm_ioctl(struct file *file, =
unsigned int cmd, unsigned long arg)
> >>>>>>> =20
> >>>>>>>       ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
> >>>>>>>       ret =3D ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
> >>>>>>> -     if (ret >=3D 0)
> >>>>>>> +     if (ret >=3D 0) {
> >>>>>>> +             bool lock =3D xe_eudebug_discovery_lock(file, cmd);
> >>>>>>>               ret =3D drm_ioctl(file, cmd, arg);
> >>>>>>
> >>>>>> [Severity: High]
> >>>>>> Does holding the discovery lock across drm_ioctl() create a vector=
 for a
> >>>>>> workqueue stall?=20
> >>>>>>
> >>>>>> If an unprivileged user maps the ioctl argument pointer to a block=
ing FUSE
> >>>>>> or userfaultfd region, drm_ioctl() can be stalled indefinitely dur=
ing
> >>>>>> copy_from_user() while holding xef->eudebug.ioctl_lock for read.
> >>>>>
> >>>>> Don't think this is a very realistic vector to address, as it would
> >>>>> also extend to every other copy_from_user() and also to userptr acr=
oss
> >>>>> all drivers.
> >>
> >> Yeah I don't think that this is a major problem.
> >>
> >> Using copy_from_user() while holding a lock is usually fundamentally b=
roken in the first place.
> >=20
> > Well, ultimately also applies to userptr. How would we go about
> > implementing that without any outer locks?
> >=20
> > Grab locks, figure out what pages are needed, release locks, pre-fault,
> > re-grab locks and do best attempt to resolve? And that's going to be a
> > live-lock at best again.
>=20
> Yeah and that is exactly what you *must* do for userptrs.
>=20
> There is no really alternative to that because you can't grab the same lo=
ck outside a page fault you do inside an MMU notfier.

Sure, not same locks. But essentially any device or HW unit level
locks held while dealing with userptr or using copy_from_user() would
now become potential deadlocks automatically. No need to take any nested
locks, it's just that whichever shared lock is taken will immediately
become a potential deadlock for completely unrelated DRM client and
thus also different process.

> So all drivers who use userptrs basically implement the following sequenc=
e:
>=20
> 1. Take a copy of page table update sequence number.
> 2. Walk page tables, extract PFNs.
> 3. Prepare your DMA operations.
> 4. Grab the MMU notifier lock.
> 5. Compare your sequence number, if it doesn't match revert everything an=
d try again.
> 6. Submit your DMA operation to the HW
> 7. Drop the MMU notifier lock.
>=20
> What you describe above for eudebug sounds a lot like it won't work corre=
ctly, you can't work with outside locks in the userptr handling.

For the eudebug scenario here it's not to do with userptr. The access is
now done in patch 13 with access_process_vm() and hopefully in future
with access_remote_vm().

This lock we actually can easily refactor out. It's just a lock to
easily allow generating a coherent snapshot of DRM client resources
and debug metadata.

I'm just raising to concern generically for any userspace memory
access path be it copy_from_user() or userptr. Any lock taken on the
outside of such handling will become poisoned for all other DRM clients.

> > That'd be a massive undertaking for each driver, I think.
> >=20
> >> But there are other issues which are much more problematic.
> >>
> >>>>>
> >>>>> Having a malfunctioning FUSE driver and getting a malfunctioning sy=
stem
> >>>>> as a result is probably somewhat expected.
> >>>>
> >>>> Based on further chatting on this with Sima, I was volunteered to pu=
ll
> >>>> together the discussion here.
> >>>>
> >>>> We seem to have Sashiko picking up on patterns about accessing users=
pace
> >>>> memory with locks held and potential for copy_from_user() (or userpt=
r) to
> >>>> then take indefinitely long to resolve. And that spreads to deadlocks
> >>>> everywhere situation very fast.
> >>>>
> >>>> Based on reading of [1] and [2], it seems pretty much expected FUSE
> >>>> drivers can trivially deadlock and ultimately in worst case the situ=
ation
> >>>> can only be solved by manually aborting those connections by sysadmi=
n.
> >>
> >> The real problem comes with userfaultfd and the combination with HMM.
> >>
> >> Drivers implementing HMM usually use a background workers to resolve r=
ecoverable page faults using the function hmm_range_fault().
> >>
> >> If userfaultfd together with hmm_range_fault() can block those backgro=
und workers indefinitely it can block other applications from using the HW =
without any sysadmin having any chance to figure out what is going on.
> >>
> >> That is a classic local deny of service attack and I fear hmm_range_fa=
ult() needs something like a timeout to handle that.
> >=20
> > From my position, if userspace is injected to the dependency path for
> > resolving page-faults, with potentially unbounded execution times, the
> > timeouts would better be asserted at the FUSE/UFFD side and then simply
> > failing the operations with a bang if not met.
>=20
> That won't work like that. Both FUSE and UFFD can take any time they want=
 for an operation.

Wouldn't that then directly mean that anything to do with page-faults
would immediately exclude everything related to dma-bufs?

> >>>> It also seems (from the Sashiko comments) that by design, there's no
> >>>> upper bound for how long an operation can take, so a bad FUSE driver
> >>>> may stall for however long it sees fit to serve page-fault or in the
> >>>> case of [3] it may decide to not actually populate the PTEs (or maybe
> >>>> invalidate them immediately).
> >>>>
> >>>> Should we really be refactoring the whole kernel for the sake of
> >>>> knowingly allowing potentially malicious userspace driver to idefini=
tely
> >>>> stall or incorrectly resolve page faults? That'll be quite a lot of
> >>>> complexity added to all the other drivers.
> >>
> >> +1
> >>
> >> Regards,
> >> Christian.
> >=20
> > I was also meaning to convey that I don't think indefinitely blocking
> > copy_from_user() is acceptable, either. However earlier you seemed to
> > indicate towards that being something we should expect?
>=20
> Correct, that copy_from_user() can take any amount of time is perfectly e=
xpected.
>=20
> The problem is that most GPU HW currently can't deal with that because it=
 can't take the work of the HW in case of a fault.

Doesn't that then raise the question if indefinitely stalling page fault
responses or improperly handling page fault responses is actually reasonable
if we want to support most GPU HW? Which I kinda hope we do want to support.

Regards, Joonas

>=20
> Regards,
> Christian.
>=20
> >=20
> > Regards, Joonas
