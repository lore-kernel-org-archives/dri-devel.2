Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1250C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C1D910E815;
	Mon, 31 Aug 2026 12:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bmGaYkWX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D248C10E7EB;
 Mon, 31 Aug 2026 12:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788180035; x=1819716035;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=gMHDOQFK8cFHhTqRVnSQ8VkRu9LC8o2oJEBdHC89wgI=;
 b=bmGaYkWXdg+LMQ4P1EIxzTbcu3s0DevkfMRUzl/rbPTbEOg1PwmIlAfr
 Rs7vx8FGMZdiQJdHnIls1iaae+95RINoYjo19wqVbObFVSSStz/+HYf47
 6oGCAfErk7/2XhQwfSFj2rzIX90H/WeiE9ti/z8fNrs61tp2NpXpBvK3Q
 tLymgw5gScElsvvYn2+q5sLaJrtMjUskQvKJ7Alojphfp6+qnU3IJhzlB
 9JTMTOH1KmI366E1tggMiTxea2XWDRYTW12cWAwgTaizOqkClyMTj5YaM
 rMTBiqi7r9/imoQcSJmy3tmPy7C8NpaDnfU5XGf/IG50i3fx3nVwGn8Ef g==;
X-CSE-ConnectionGUID: BUxWfuZ2QtObpxYqGf4ryQ==
X-CSE-MsgGUID: WfgLHAasSu2lmc7Z8KI/gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88348522"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="88348522"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:40:35 -0700
X-CSE-ConnectionGUID: avQH6mskQXOtYXmkTNMJrQ==
X-CSE-MsgGUID: CUxohwINScmcLgCPUbz8QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; d="scan'208";a="272978170"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.41])
 ([10.245.244.41])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 05:40:31 -0700
Message-ID: <f9088335650f61364384d279d30210d99513f08e.camel@linux.intel.com>
Subject: Re: [PATCH v5 0/4] drm: Add common drm_work_fence/drm_user_fence
 helpers and convert XE
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, Matthew Brost	
 <matthew.brost@intel.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Mika
 Kuoppala <mika.kuoppala@linux.intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  "dri-devel@lists.freedesktop.org"	
 <dri-devel@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"	
 <intel-xe@lists.freedesktop.org>
Date: Mon, 31 Aug 2026 14:40:29 +0200
In-Reply-To: <IA0PR12MB82085C11DA7C77450210BE1F90A92@IA0PR12MB8208.namprd12.prod.outlook.com>
References: <20260827062142.4038272-1-srinivasan.shanmugam@amd.com>
 <20260831054154.107602-1-srinivasan.shanmugam@amd.com>
 <772d17307920288d82c55518322d2b65686fcd25.camel@linux.intel.com>
 <IA0PR12MB8208B09EDCF4E0D77B58299290A92@IA0PR12MB8208.namprd12.prod.outlook.com>
 <8278316a3ed83374568103f509d64d71aab8fa32.camel@linux.intel.com>
 <IA0PR12MB82085C11DA7C77450210BE1F90A92@IA0PR12MB8208.namprd12.prod.outlook.com>
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

On Mon, 2026-08-31 at 12:36 +0000, SHANMUGAM, SRINIVASAN wrote:
> AMD General
>=20
> > -----Original Message-----
> > From: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > Sent: Monday, August 31, 2026 5:52 PM
> > To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > Matthew Brost <matthew.brost@intel.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Mika Kuoppala
> > <mika.kuoppala@linux.intel.com>; Maarten Lankhorst
> > <maarten.lankhorst@linux.intel.com>;
> > dri-devel@lists.freedesktop.org; intel-
> > xe@lists.freedesktop.org
> > Subject: Re: [PATCH v5 0/4] drm: Add common
> > drm_work_fence/drm_user_fence
> > helpers and convert XE
> >=20
> > On Mon, 2026-08-31 at 11:13 +0000, SHANMUGAM, SRINIVASAN wrote:
> > > AMD General
> > >=20
> > > > -----Original Message-----
> > > > From: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > > > Sent: Monday, August 31, 2026 3:46 PM
> > > > To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > Matthew
> > > > Brost <matthew.brost@intel.com>; Koenig, Christian
> > > > <Christian.Koenig@amd.com>; Deucher, Alexander
> > > > <Alexander.Deucher@amd.com>
> > > > Cc: amd-gfx@lists.freedesktop.org; Mika Kuoppala
> > > > <mika.kuoppala@linux.intel.com>; Maarten Lankhorst
> > > > <maarten.lankhorst@linux.intel.com>;
> > > > dri-devel@lists.freedesktop.org; intel-
> > > > xe@lists.freedesktop.org
> > > > Subject: Re: [PATCH v5 0/4] drm: Add common
> > > > drm_work_fence/drm_user_fence helpers and convert XE
> > > >=20
> > > > On Mon, 2026-08-31 at 11:11 +0530, Srinivasan Shanmugam wrote:
> > > > > When a GPU dma-fence signals, drivers often need to perform
> > > > > work
> > > > > that cannot run in IRQ context. This pattern is currently
> > > > > open-coded in multiple drivers.
> > > > >=20
> > > > > This series introduces two layered helpers:
> > > > >=20
> > > > > Patch 1 introduces drm_work_fence =E2=80=94 a generic embeddable =
base
> > > > > structure that handles the dma-fence-callback-to-workqueue
> > > > > pattern.
> > > > > Any driver needing deferred fence work can use this directly.
> > > > >=20
> > > > > Patch 2 introduces drm_user_fence =E2=80=94 a thin layer on top o=
f
> > > > > drm_work_fence that adds kthread_use_mm() support for drivers
> > > > > that
> > > > > need to access userspace memory when a fence signals.
> > > > >=20
> > > > > Patch 3 converts XE to use drm_user_fence. XE continues to
> > > > > write a
> > > > > fence completion value to a userspace VA using the new
> > > > > helper.
> > > > >=20
> > > > > Patch 4 adds optional per-signal compare functionality to
> > > > > drm_user_fence.
> > > > > When cmp_addr is set, the worker is called only if the value
> > > > > at
> > > > > cmp_addr satisfies the configured comparison. This enables
> > > > > AMDGPU's EOP eventfd per-signal filtering without open-coding
> > > > > the
> > > > > read+compare
> > > > > pattern.
> > > > >=20
> > > > > A follow-on patch (not in this series) will wire AMDGPU's
> > > > > render-
> > > > > node EOP eventfd signaling path to drm_work_fence.
> > > > >=20
> > > > > v5:
> > > > > =C2=A0- Split drm_user_fence into drm_work_fence (generic) and
> > > > > drm_user_fence
> > > > > =C2=A0=C2=A0 (MM-borrowing subclass) per Matthew Brost's suggesti=
on.
> > > > > =C2=A0- Add per-signal compare functionality
> > > > > (drm_user_fence_set_compare())
> > > > > =C2=A0=C2=A0 per Christian K=C3=B6nig's suggestion.
> > > > > =C2=A0- Use mmput_async() instead of mmput() to avoid potential
> > > > > deadlock in
> > > > > =C2=A0=C2=A0 MMU notifier release path. (Sashiko review)
> > > > >=20
> > > > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > > > Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > > > > Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> > > > > Cc: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
> > > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > > Cc: dri-devel@lists.freedesktop.org
> > > > > Cc: intel-xe@lists.freedesktop.org
> > > > > Cc: amd-gfx@lists.freedesktop.org
> > > >=20
> > > > I think the get_user() and put_user() of 64-bit values in drm
> > > > (driver
> > > > common) code is not safe for typical use-cases on 32-bit
> > > > systems.
> > > > For xe we
> > > > officially don't (yet at least) support 32-bit systems so hence
> > > > the
> > > > code is a bit sloppy but for drm helpers I'm not sure we can
> > > > get
> > > > away with this. At least not without some form of warning or
> > > > assert.
> > > >=20
> > > > I think to make 32-bit systems 64-bit user-fence safe, we would
> > > > need
> > > > to user
> > > > pin_user_pages() combined with cmpxchg64() and a similar
> > > > cmpxchg
> > > > operation on the user-space side.
> > >=20
> > > Hi Thomas,
> > >=20
> > > Thanks for the review.
> > >=20
> > > For the 32-bit safety concern on get_user() of u64 values =E2=80=94 s=
ince
> > > no
> > > current GPU driver supports 32-bit user fences (XE explicitly
> > > excludes
> > > 32-bit, and AMDGPU targets modern hardware), would adding a
> > > BUILD_BUG_ON or IS_ENABLED(CONFIG_64BIT) guard in
> > > drm_user_fence_set_compare() be acceptable for now?
> > >=20
> > > If a 32-bit driver ever needs this in the future, we can follow
> > > up
> > > with pin_user_pages() + cmpxchg64() for proper atomic access.
> > >=20
> > > Does that approach work for you?
> >=20
> > Xe supports building on 32-bit but not running. Can we use a
> > drm_WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT)) or similar somewhere?
> > Perhaps that was your second suggestion?
>=20
> Hi Thomas,
>=20
> Yes, that matches our suggestion. We will add:
>=20
> =C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(!IS_ENABLED(CONFIG_64BIT));
>=20
> in drm_user_fence_set_compare(). We cannot use drm_WARN_ON_ONCE()
> since drm_user_fence has no struct drm_device * reference.
>=20
> Is plain WARN_ON_ONCE acceptable, or should we add a drm_device
> pointer to drm_user_fence_set_compare() to use drm_WARN_ON_ONCE()?

For this purpose, IMO WARN_ON_ONCE() is fine. Not sure if drm has a
general recommendation to add a device pointer, though.

Thanks,
Thomas


>=20
> Thanks,
> Srini
