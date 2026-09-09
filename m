Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E93C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:24:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBE610E147;
	Wed,  9 Sep 2026 11:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CpCx1zha";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0C2610E147;
 Wed,  9 Sep 2026 11:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788953096; x=1820489096;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=cvVFhXBmgFXlYV+tk99qU5Tx4j17ZIhxHwpHwQD5ZD0=;
 b=CpCx1zhaH1+e9GsDYIooNlaZvu5amkRfWBxqeAhupNZ2FlX2Dv3UKfH+
 psxRPIfFEpmuu2X5tpb9dTmv4o2xsHCrNE9vQ/vxCTtv/kzgeKX8i8K8X
 WXrMpDGjIoslpB8y7sMmTqZT7pLAlH8zZ2Ea8zQhP4OCujvuGXmbdnNeH
 bAHxMPfj2AeCq1Z0Jgw72wYqz52QyMXQCOrHjQMPENUpZWiURYbwyfOTD
 PIm2GM4vgbIaYEzhdCNJiCk4z+3rC92kmk7Np9Ae4+igOjBjtjLcnb7jU
 r5rGqiUlMOHECHOek/DKfs2Y/BvwLN8ijpKZdS4XGB/Rc7bCbt4AmmxT5 g==;
X-CSE-ConnectionGUID: npJINcISR1Cirboqq7JvCg==
X-CSE-MsgGUID: fCt5i0H1Sbet7HHMktNn3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106745370"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="106745370"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 04:24:54 -0700
X-CSE-ConnectionGUID: mFZnOXZhR1WLuvbLKEzLXw==
X-CSE-MsgGUID: FJCsdA1ZRDm/2lW/TD+CdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="268041571"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.37])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 04:24:49 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <785085e8-c9db-4d84-ab55-3a8caf9f4a35@amd.com>
References: <20260903145952.848051-1-mika.kuoppala@linux.intel.com>
 <20260903145952.848051-5-mika.kuoppala@linux.intel.com>
 <20260903152224.AD48C1F00A3F@smtp.kernel.org>
 <178878748003.179185.16833574173741290547@jlahtine-mobl>
 <178894801687.37859.4186888279082797860@jlahtine-mobl>
 <aqEzHQMrI8p9XVcu@phenom.ffwll.local>
 <785085e8-c9db-4d84-ab55-3a8caf9f4a35@amd.com>
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
Date: Wed, 09 Sep 2026 14:24:45 +0300
Message-ID: <178895308548.62143.17472983986994555742@jlahtine-mobl>
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

(+ userfaultfd maintainers)

Quoting Christian K=C3=B6nig (2026-09-09 14:02:21)
> On 9/9/26 12:21, Simona Vetter wrote:
> > On Wed, Sep 09, 2026 at 01:00:16PM +0300, Joonas Lahtinen wrote:
> >> (Adding bunch of FUSE folks and DRM folks in the hopes of coming to a
> >> resolution here.)
> >>
> >> Quoting Joonas Lahtinen (2026-09-07 16:24:40)
> >>> Quoting sashiko-bot@kernel.org (2026-09-03 18:22:23)
> >>>> Thank you for your contribution! Sashiko AI review found 2 potential=
 issue(s) to consider:
> >>>> - [High] Global ordered workqueue stall via copy_from_user block whi=
le holding ioctl_lock.
> >>>> - [Medium] Event sequence numbers (seqno) can be queued out-of-order=
 in the event stream due to a race between seqno generation and event queui=
ng.
> >>>> --
> >>>>
> >>>> commit e2061e72d8e954a17bde35e9c970ee41bc2db0ad
> >>>> Author: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> >>>>
> >>>>     drm/xe/eudebug: Introduce discovery for resources
> >>>>
> >>>> This commit introduces a resource discovery mechanism for debugger c=
onnections.
> >>>> When a debugger connects, all existing resources for the target clie=
nt are
> >>>> relayed as events via an ordered workqueue, and DRM ioctls are block=
ed using
> >>>> an rw_semaphore until discovery is complete.
> >>>>
> >>>>> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe=
_device.c
> >>>>> index 032a7ec5fbc8d..f10959b898297 100644
> >>>>> --- a/drivers/gpu/drm/xe/xe_device.c
> >>>>> +++ b/drivers/gpu/drm/xe/xe_device.c
> >>>> [ ... ]
> >>>>> @@ -238,8 +239,12 @@ static long xe_drm_ioctl(struct file *file, un=
signed int cmd, unsigned long arg)
> >>>>> =20
> >>>>>       ACQUIRE(xe_pm_runtime_ioctl, pm)(xe);
> >>>>>       ret =3D ACQUIRE_ERR(xe_pm_runtime_ioctl, &pm);
> >>>>> -     if (ret >=3D 0)
> >>>>> +     if (ret >=3D 0) {
> >>>>> +             bool lock =3D xe_eudebug_discovery_lock(file, cmd);
> >>>>>               ret =3D drm_ioctl(file, cmd, arg);
> >>>>
> >>>> [Severity: High]
> >>>> Does holding the discovery lock across drm_ioctl() create a vector f=
or a
> >>>> workqueue stall?=20
> >>>>
> >>>> If an unprivileged user maps the ioctl argument pointer to a blockin=
g FUSE
> >>>> or userfaultfd region, drm_ioctl() can be stalled indefinitely during
> >>>> copy_from_user() while holding xef->eudebug.ioctl_lock for read.
> >>>
> >>> Don't think this is a very realistic vector to address, as it would
> >>> also extend to every other copy_from_user() and also to userptr across
> >>> all drivers.
>=20
> Yeah I don't think that this is a major problem.
>=20
> Using copy_from_user() while holding a lock is usually fundamentally brok=
en in the first place.

Well, ultimately also applies to userptr. How would we go about
implementing that without any outer locks?

Grab locks, figure out what pages are needed, release locks, pre-fault,
re-grab locks and do best attempt to resolve? And that's going to be a
live-lock at best again.

That'd be a massive undertaking for each driver, I think.

> But there are other issues which are much more problematic.
>=20
> >>>
> >>> Having a malfunctioning FUSE driver and getting a malfunctioning syst=
em
> >>> as a result is probably somewhat expected.
> >>
> >> Based on further chatting on this with Sima, I was volunteered to pull
> >> together the discussion here.
> >>
> >> We seem to have Sashiko picking up on patterns about accessing userspa=
ce
> >> memory with locks held and potential for copy_from_user() (or userptr)=
 to
> >> then take indefinitely long to resolve. And that spreads to deadlocks
> >> everywhere situation very fast.
> >>
> >> Based on reading of [1] and [2], it seems pretty much expected FUSE
> >> drivers can trivially deadlock and ultimately in worst case the situat=
ion
> >> can only be solved by manually aborting those connections by sysadmin.
>=20
> The real problem comes with userfaultfd and the combination with HMM.
>=20
> Drivers implementing HMM usually use a background workers to resolve reco=
verable page faults using the function hmm_range_fault().
>=20
> If userfaultfd together with hmm_range_fault() can block those background=
 workers indefinitely it can block other applications from using the HW wit=
hout any sysadmin having any chance to figure out what is going on.
>=20
> That is a classic local deny of service attack and I fear hmm_range_fault=
() needs something like a timeout to handle that.

From my position, if userspace is injected to the dependency path for
resolving page-faults, with potentially unbounded execution times, the
timeouts would better be asserted at the FUSE/UFFD side and then simply
failing the operations with a bang if not met.

> >> It also seems (from the Sashiko comments) that by design, there's no
> >> upper bound for how long an operation can take, so a bad FUSE driver
> >> may stall for however long it sees fit to serve page-fault or in the
> >> case of [3] it may decide to not actually populate the PTEs (or maybe
> >> invalidate them immediately).
> >>
> >> Should we really be refactoring the whole kernel for the sake of
> >> knowingly allowing potentially malicious userspace driver to idefinite=
ly
> >> stall or incorrectly resolve page faults? That'll be quite a lot of
> >> complexity added to all the other drivers.
>=20
> +1
>
> Regards,
> Christian.

I was also meaning to convey that I don't think indefinitely blocking
copy_from_user() is acceptable, either. However earlier you seemed to
indicate towards that being something we should expect?

Regards, Joonas

> >>
> >> Or should there be more protections on FUSE / uffd to ensure such
> >> idefinitive stall can't happen? Or maybe this is just an academic
> >> problem and we amend review-prompts not to bring it up?
> >>
> >> Or maybe I missed some part of the FUSE docs and this isn't a real
> >> problem?
> >=20
> > Thanks for typing this up, matches what I think is going on here.
> >=20
> >> Regards, Joonas
> >>
> >> PS. There is a related patch in [3] which tries to address the problem,
> >> but we'll quickly run into live-locks and other issues even if we
> >> refactored things into: pre-fault, take locks, do _nofault() access, a=
nd
> >> retry if that fails.
> >=20
> > Yeah just quickly wanting to add here that in my opinion, trying to sort
> > this out in all the various subsystem is not how we should even start to
> > think about this issue. This would be a fundamental change in how
> > subsystems are allowed to nest locking with stuff that can trigger
> > userspace faults.
> >=20
> > I did ponder a bit how this could be solved on the fuse side of things,
> > maybe with some seccomp style filters. Like maybe lockdep could be
> > enlisted to help catch deadlocks, with a special "this is a fuse proces=
s,
> > it all defacto runs in fault handler context. But that only catches bugs
> > in normal use, not malicious exploits. And given that userspace can cho=
ose
> > the timing and unblock at will (I think so at least), this is pretty
> > powerful tool for being nasty to the kernel.
> >=20
> > But mostly I want to really, really stand back in awe about this issue =
and
> > not think too hard about it.
> >=20
> > Cheers, Sima
> >=20
> >> [1] https://www.kernel.org/doc/html/next/filesystems/fuse.html#kernel-=
userspace-interface
> >> [2] https://www.kernel.org/doc/html/next/filesystems/fuse.html#abortin=
g-a-filesystem-connection
> >> [3] https://sashiko.dev/#/patchset/20260827062142.4038272-1-srinivasan=
.shanmugam%40amd.com
> >=20
>
