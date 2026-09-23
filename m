Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296CCC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 06:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E93310E7FF;
	Wed, 23 Sep 2026 06:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WG/P6Su8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DDA10E7FF;
 Wed, 23 Sep 2026 06:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790146334; x=1821682334;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=hTMiXPl4WbKEJ1YMTZWqxrXiBFu1K6Gg2Aq+TrT3yiQ=;
 b=WG/P6Su8Q2J1G6j2p/pvJGk1bi8eVgHE4LNXbCnUfOLZvXqqLeMId7eq
 wNuBo4qcWX9QzdYUbDupXsmb33aIYVuY3/554NRcXbJOLomJYFTICKM67
 Eg2neqtbaP7jyWBZIHya5dwWs23/HTv+m0o4XvWetnuZ3fkvJH9E1vTQ/
 Xxb2wonh3EpiQrWHrucwa77dI5KVxxOIyMAmHhqV6f4ERcbZIomrpAgT+
 IvRq+gGW5WQE9tsLaMI6gnYmMIVHf5q4aFkJImMHQfZkbhjOQ8Si8U71T
 RxKeD8zU9TY96YpHWMF4m8xflBmZIR/RAk6OHr4KWvXsnsWfbpQug5tUA A==;
X-CSE-ConnectionGUID: OO0lAb5cS+OeOeaFV2a/8Q==
X-CSE-MsgGUID: cU/T8RjWRAKSz++JCDgeUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="102167908"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="102167908"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 23:52:13 -0700
X-CSE-ConnectionGUID: K0PZ+RDiTLmTX4t+ilRhUQ==
X-CSE-MsgGUID: 69MZ1TYBTKOhG5aDx4RwEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="273654392"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.213])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 23:52:10 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
 <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
To: "Yao, Jia" <jia.yao@intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Date: Wed, 23 Sep 2026 09:52:07 +0300
Message-ID: <179014632773.19856.4107893493544612438@jlahtine-mobl>
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

Quoting Yao, Jia (2026-09-22 17:34:08)
> Hi @Joonas Lahtinen,
>=20
> For RCS -> UNSET
> For CCS
> 1. Old compute runtime -> UNSET
> 2. New compute runtime -> USER
>=20
> If we take there's only one compute runtime version, and priority USER > =
UNSET?  Where's the conflict come from?

See below.

> But if we take there's more than one compute runtime version, and their p=
riority is equal,  UNSET can cover USER,  USER can cover UNSET,  even with =
two clients they could cover each other.

I didn't follow this part. How does the priority come into play?

We have to keep switching the mode as the DRM clients come and go.

> We should take it easy.
> Once we reached USER, set by new compute, we should latch it, for the WA =
has been implemented by USER.

That won't work. If you are running two different containers, you may
have different compute runtime versions. Also, Mesa can be submitting
to CCS too for async compute, AFAIK.

To properly cover things, we should make it into per DRM-client setting
and switch the mode accordingly when different DRM client is run.

And for the given SKU with only one CCS, as explained earlier, it should
be already guaranteed that two different DRM clients are not active on
the hardware at the same time due to the address space mathing
requirement between RCS and CCS.

If this needs to be extended to multi CCS SKUs, then it'd be a bigger
implementation effort.

Regards, Joonas

>=20
> Thanks,
> Jia=20
>=20
> > -----Original Message-----
> > From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Sent: Monday, September 21, 2026 11:47 PM
> > To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
> > reviews@lists.linux.dev
> > Cc: dri-devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; R=
oper,
> > Matthew D <matthew.d.roper@intel.com>; Tvrtko Ursulin
> > <tursulin@ursulin.net>
> > Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
> > Wa_22013059131
> >=20
> > Quoting Yao, Jia (2026-09-21 20:33:03)
> > > Hi @Lahtinen, Joonas,
> > >
> > > The key is LSC_CHICKEN_BIT_0 is a global register.
> > >
> > > Even we use per-client,  we should consider the following cases:
> > >
> > > 1. Should conflicting configurations within a client be rejected?
> > > I recommend the first setting should be latched.
> >=20
> > From uAPI perspective it would be simpler to set this at the DRM client=
 level at
> > once. However we don't seem to have such uAPI in active use currently (=
all
> > drm_noop) so you'd have to compare the complexity between indirectly
> > setting it at DRM client level by first created context or adding such =
an uAPI to
> > set it explicitly per client.
> >=20
> > > 2. Should conflicting configurations across different clients be reje=
cted?
> > > I think the latter setting can cover previous one.
> >=20
> > DRM clients need to be indepenent from the driver perspective, we can't=
 do
> > that.
> >=20
> > The whole point of making it per DRM client is that given the impacted =
SKU
> > only has 1 CCS engine. We have the address space matching requirement
> > between CCS and RCS, so when both CCS and RCS are running, we know they
> > belong to the same DRM client and thus they will not conflict with the =
WA
> > mode. And if only one of them is running, there can be no conflict eith=
er as it's
> > just one context.
> >=20
> > > Even like this, still can't cover all the race condition.
> >=20
> > Which race conditions do you think would remain? We definitely have to
> > eliminate any race conditions to land this.
> >=20
> > Regards, Joonas
