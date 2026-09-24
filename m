Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBC0C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F01410E11B;
	Thu, 24 Sep 2026 07:22:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mAjrDwB8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFF3310E11B;
 Thu, 24 Sep 2026 07:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790234522; x=1821770522;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=3eO2esDzpMgPrXkNVB739XwTuf+0PeqS+3NX0dzmaSc=;
 b=mAjrDwB8TKbBB5s8pLDvGGk+GsmHvU0X2usgNXJGwo/DyZK3p4HevGxn
 xpYfz234BZqCTOhGLEYmmqXjGXDQZQic3sIb85dQY8CFKCIbFfBcU2Ao3
 gU3YaF67hMQ9M7hIIQtgVrQNIrIFM6r83na1k5oagQN8K46UN0laoNTLu
 b3/u95xUoLBQPA42jhYTJyxc+Zhymu5cZVLOH8XzJ8BzScgDpMkh3Rqmi
 SAZvaklRWNpEd+0yTVSDCYbSR26Ylss11xkFFawauqJ2EWj6HIa6EOl/q
 P8zzkzBU4ZGtZUJJgJU1glxVXj7uiSuMeAfrzv5bgmkWtW+54O4hFjvpG w==;
X-CSE-ConnectionGUID: cWALDd4ERuyyL54nD6yRPg==
X-CSE-MsgGUID: ki5U7jvDTC+xmZJ71okFIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93494123"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93494123"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 00:22:01 -0700
X-CSE-ConnectionGUID: LtFP9j+eRyOoRn5LqgaEeg==
X-CSE-MsgGUID: nK38M4nmQyWwBV5Y2NZNXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="274074788"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.136])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 00:22:00 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8e01832b-4a94-4f0b-86c3-71664d22a326@intel.com>
References: <20260630225349.984AB1F000E9@smtp.kernel.org>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
 <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179014632773.19856.4107893493544612438@jlahtine-mobl>
 <PH8PR11MB804034417C9C4625B7F20F2BF4822@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179018246485.152778.2589066724213973485@jlahtine-mobl>
 <6e40b68c-bbfa-47b6-81e9-5076738d0abd@intel.com>
 <20260923202952.GA730830@mdroper-desk1.amr.corp.intel.com>
 <8e01832b-4a94-4f0b-86c3-71664d22a326@intel.com>
Subject: Re: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 Tvrtko Ursulin <tursulin@ursulin.net>
To: "Yao, Jia" <jia.yao@intel.com>, Matt Roper <matthew.d.roper@intel.com>
Date: Thu, 24 Sep 2026 10:21:56 +0300
Message-ID: <179023451637.16584.7933241196219120051@jlahtine-mobl>
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

Quoting Yao, Jia (2026-09-24 00:20:51)
>=20
> On 9/23/2026 1:29 PM, Matt Roper wrote:
> > On Wed, Sep 23, 2026 at 11:06:56AM -0700, Yao, Jia wrote:
> >> On 9/23/2026 9:54 AM, Joonas Lahtinen wrote:
> >>> Quoting Yao, Jia (2026-09-23 19:01:32)
> >>>> Hi @Joonas Lahtinen,
> >>>>
> >>>> When shifting from WA option #2 to option #1,    removing a global s=
etting ->   adding a per-context setting.  We thought it was a per-context =
operation.  However, due to the "weakest link" effect, this remains a globa=
l operation.
> >>>> Thus, making it per-client has no effect either.  Containers will in=
terfere with each other.
> >>> They would not. On the impacted SKU, the RCS and CCS at any given time
> >>> can only run workloads with matching address space. Those workloads m=
ust
> >>> originate from the same DRM client as there is no address space shari=
ng
> >>> across DRM clients implemented in i915.
> >>>
> >>> It's only when multi-CCS SKU would need the same W/A, we would need
> >>> further scheduling decision to ensure 2 CCS workloads are not competi=
ng
> >>> for the global setting.
> >>>
> >>> With per DRM client enforcement, both RCS and CCS should be able to
> >>> write the global setting without a conflict. And when a context from =
new
> >>> DRM client is scheduled it, it should be able to program the global
> >>> value to its liking as the same address space limitation guarantees t=
he
> >>> other workloads are not in the HW anymore.
> >>>
> >>> Regards, Joonas
> >> I understand the benefit of address-space isolation.
> >>
> >> However, The bit 15 appears to be a global register rather than an
> >> address-space-specific state.
> > That's why we're doing the special dance with INDIRECT_CTX --- by
> > re-writing the register on every context switch, we've somewhat turned a
> > global register into a per-context register.
> >
> > If it were possible for two completely unrelated contexts to be running
> > at the same time (e.g., one on RCS and one on CCS), then we'd wind up
> > with a case where:
> >
> >   * LRC A switches in on engine X and sets the register the way it wants
> >   * LRC B switches in on engine Y and changes the register to the other
> >     setting, even though LRC A is still running in parallel
> >
> > But fortunately that's not possible on DG2-G11.  On that platform
> > there's only a single CCS engine (so no possibility for conflicts
> > between, for example, CCS0 and CCS1).  And there's also another
> > workaround (implemented in the GuC's scheduler) that ensures that the
> > RCS and CCS engines are only allowed to run concurrently for LRCs that
> > have the same address space.  If you try to run two unrelated contexts
> > at the same on the RCS and CCS, then they'll run sequentially rather
> > than in parallel.
> >
> >
> > Matt
>=20
> I see. However, if the GuC scheduler already guarantees that workloads=20
> from different address spaces are serialized, why don't we use a per-VM=20
> (per-address-space) setting instead of a per-client one?

That is a possibility, that was one of the early suggestions.

However per-VM level control is not foreseen at this time. So we
probably should still enforce all VMs within DRM client to match.

It all boils down what leads to the most simple implementation.

Regards, Joonas

>=20
> Thanks,
>=20
> Jia
>=20
> >
> >> If the register itself is not address-space isolated,
> >>
> >> I'm struggling to see how address-space isolation alone resolves the
> >> concern.
> >>
> >> Thanks,
> >>
> >> Jia
> >>
> >>>> Thanks,
> >>>> Jia
> >>>>> -----Original Message-----
> >>>>> From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> >>>>> Sent: Tuesday, September 22, 2026 11:52 PM
> >>>>> To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
> >>>>> reviews@lists.linux.dev
> >>>>> Cc: dri-devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.or=
g; Roper,
> >>>>> Matthew D <matthew.d.roper@intel.com>; Tvrtko Ursulin
> >>>>> <tursulin@ursulin.net>
> >>>>> Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
> >>>>> Wa_22013059131
> >>>>>
> >>>>> Quoting Yao, Jia (2026-09-22 17:34:08)
> >>>>>> Hi @Joonas Lahtinen,
> >>>>>>
> >>>>>> For RCS -> UNSET
> >>>>>> For CCS
> >>>>>> 1. Old compute runtime -> UNSET
> >>>>>> 2. New compute runtime -> USER
> >>>>>>
> >>>>>> If we take there's only one compute runtime version, and priority =
USER >
> >>>>> UNSET?  Where's the conflict come from?
> >>>>>
> >>>>> See below.
> >>>>>
> >>>>>> But if we take there's more than one compute runtime version, and =
their
> >>>>> priority is equal,  UNSET can cover USER,  USER can cover UNSET,  e=
ven with
> >>>>> two clients they could cover each other.
> >>>>>
> >>>>> I didn't follow this part. How does the priority come into play?
> >>>>>
> >>>>> We have to keep switching the mode as the DRM clients come and go.
> >>>>>
> >>>>>> We should take it easy.
> >>>>>> Once we reached USER, set by new compute, we should latch it, for =
the WA
> >>>>> has been implemented by USER.
> >>>>>
> >>>>> That won't work. If you are running two different containers, you m=
ay have
> >>>>> different compute runtime versions. Also, Mesa can be submitting to=
 CCS too
> >>>>> for async compute, AFAIK.
> >>>>>
> >>>>> To properly cover things, we should make it into per DRM-client set=
ting and
> >>>>> switch the mode accordingly when different DRM client is run.
> >>>>>
> >>>>> And for the given SKU with only one CCS, as explained earlier, it s=
hould be
> >>>>> already guaranteed that two different DRM clients are not active on=
 the
> >>>>> hardware at the same time due to the address space mathing requirem=
ent
> >>>>> between RCS and CCS.
> >>>>>
> >>>>> If this needs to be extended to multi CCS SKUs, then it'd be a bigg=
er
> >>>>> implementation effort.
> >>>>>
> >>>>> Regards, Joonas
> >>>>>
> >>>>>> Thanks,
> >>>>>> Jia
> >>>>>>
> >>>>>>> -----Original Message-----
> >>>>>>> From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> >>>>>>> Sent: Monday, September 21, 2026 11:47 PM
> >>>>>>> To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
> >>>>>>> reviews@lists.linux.dev
> >>>>>>> Cc: dri-devel@lists.freedesktop.org;
> >>>>>>> intel-gfx@lists.freedesktop.org; Roper, Matthew D
> >>>>>>> <matthew.d.roper@intel.com>; Tvrtko Ursulin <tursulin@ursulin.net>
> >>>>>>> Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
> >>>>>>> Wa_22013059131
> >>>>>>>
> >>>>>>> Quoting Yao, Jia (2026-09-21 20:33:03)
> >>>>>>>> Hi @Lahtinen, Joonas,
> >>>>>>>>
> >>>>>>>> The key is LSC_CHICKEN_BIT_0 is a global register.
> >>>>>>>>
> >>>>>>>> Even we use per-client,  we should consider the following cases:
> >>>>>>>>
> >>>>>>>> 1. Should conflicting configurations within a client be rejected?
> >>>>>>>> I recommend the first setting should be latched.
> >>>>>>>   From uAPI perspective it would be simpler to set this at the DRM
> >>>>>>> client level at once. However we don't seem to have such uAPI in
> >>>>>>> active use currently (all
> >>>>>>> drm_noop) so you'd have to compare the complexity between indirec=
tly
> >>>>>>> setting it at DRM client level by first created context or adding
> >>>>>>> such an uAPI to set it explicitly per client.
> >>>>>>>
> >>>>>>>> 2. Should conflicting configurations across different clients be=
 rejected?
> >>>>>>>> I think the latter setting can cover previous one.
> >>>>>>> DRM clients need to be indepenent from the driver perspective, we
> >>>>>>> can't do that.
> >>>>>>>
> >>>>>>> The whole point of making it per DRM client is that given the
> >>>>>>> impacted SKU only has 1 CCS engine. We have the address space
> >>>>>>> matching requirement between CCS and RCS, so when both CCS and RCS
> >>>>>>> are running, we know they belong to the same DRM client and thus
> >>>>>>> they will not conflict with the WA mode. And if only one of them =
is
> >>>>>>> running, there can be no conflict either as it's just one context.
> >>>>>>>
> >>>>>>>> Even like this, still can't cover all the race condition.
> >>>>>>> Which race conditions do you think would remain? We definitely ha=
ve
> >>>>>>> to eliminate any race conditions to land this.
> >>>>>>>
> >>>>>>> Regards, Joonas
