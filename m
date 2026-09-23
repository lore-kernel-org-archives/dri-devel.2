Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D6B8C98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7333210F0DE;
	Wed, 23 Sep 2026 16:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cQd8byvZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DA4A10E967;
 Wed, 23 Sep 2026 16:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790182470; x=1821718470;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=sR2JTNeIt2Bd3YpUo7q6IodMzR1FkWUtQTYdLlsbvng=;
 b=cQd8byvZnkLVB8RHkA8t6SO0XdPTUzPi3+gOh3DC6e2Q8aI+sj9/zYnp
 m32Sl80wE+Bj9pIUZQZrqU87/GrEqlAhKmxYObaAvgaOX4TVeQcMXI4cw
 /NiGPSyDo0LR0uDqoiQAWKdvfG6r+1SewimweCxpAC6tQUL/JYhsaidaY
 2kctLdK2Zh5HemG57IT7ziY/DIGMCcCa/Xbzes9egaQy31/R3BsrSB7Ih
 1dEsur5CANjqMTFVFMujn+DL1cfwC/kvdpyfKpFrElzDg8DerGsY7/5B7
 mlZQqmEfWMSrhtfEWrXZMIHXEGGa8rsyUSnGVl0VSUMeF/Qa21dy7VQFF Q==;
X-CSE-ConnectionGUID: Y+g6luWSTyi58i5WM7f0CQ==
X-CSE-MsgGUID: 8swMTIAxTV2d0m1ICw8zeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="116425362"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="116425362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 09:54:30 -0700
X-CSE-ConnectionGUID: ayObFwfkRBGBVVTGTHxVbg==
X-CSE-MsgGUID: UwAXNvqtShuSaMCNbz1CUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; d="scan'208";a="272285002"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.213])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2026 09:54:28 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <PH8PR11MB804034417C9C4625B7F20F2BF4822@PH8PR11MB8040.namprd11.prod.outlook.com>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260630225349.984AB1F000E9@smtp.kernel.org>
 <178290749714.224587.15234445443946207851@jlahtine-mobl>
 <178292444166.273574.16738251742448073960@jlahtine-mobl>
 <PH8PR11MB8040EFAAE8210F2C6B53AC1BF4842@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179005959984.27165.4749331452130832177@jlahtine-mobl>
 <PH8PR11MB8040A8F215B997982530CE44F4832@PH8PR11MB8040.namprd11.prod.outlook.com>
 <179014632773.19856.4107893493544612438@jlahtine-mobl>
 <PH8PR11MB804034417C9C4625B7F20F2BF4822@PH8PR11MB8040.namprd11.prod.outlook.com>
Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
 Wa_22013059131
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Roper,
 Matthew D" <matthew.d.roper@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>
To: "Yao, Jia" <jia.yao@intel.com>,
 "sashiko-bot@kernel.org" <sashiko-bot@kernel.org>,
 "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
Date: Wed, 23 Sep 2026 19:54:24 +0300
Message-ID: <179018246485.152778.2589066724213973485@jlahtine-mobl>
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

Quoting Yao, Jia (2026-09-23 19:01:32)
> Hi @Joonas Lahtinen,
>=20
> When shifting from WA option #2 to option #1,    removing a global settin=
g ->   adding a per-context setting.  We thought it was a per-context opera=
tion.  However, due to the "weakest link" effect, this remains a global ope=
ration.
> Thus, making it per-client has no effect either.  Containers will interfe=
re with each other.

They would not. On the impacted SKU, the RCS and CCS at any given time
can only run workloads with matching address space. Those workloads must
originate from the same DRM client as there is no address space sharing
across DRM clients implemented in i915.

It's only when multi-CCS SKU would need the same W/A, we would need
further scheduling decision to ensure 2 CCS workloads are not competing
for the global setting.

With per DRM client enforcement, both RCS and CCS should be able to
write the global setting without a conflict. And when a context from new
DRM client is scheduled it, it should be able to program the global
value to its liking as the same address space limitation guarantees the
other workloads are not in the HW anymore.

Regards, Joonas

>=20
> Thanks,
> Jia
> > -----Original Message-----=20
> > From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Sent: Tuesday, September 22, 2026 11:52 PM
> > To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
> > reviews@lists.linux.dev
> > Cc: dri-devel@lists.freedesktop.org; intel-gfx@lists.freedesktop.org; R=
oper,
> > Matthew D <matthew.d.roper@intel.com>; Tvrtko Ursulin
> > <tursulin@ursulin.net>
> > Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
> > Wa_22013059131
> >=20
> > Quoting Yao, Jia (2026-09-22 17:34:08)
> > > Hi @Joonas Lahtinen,
> > >
> > > For RCS -> UNSET
> > > For CCS
> > > 1. Old compute runtime -> UNSET
> > > 2. New compute runtime -> USER
> > >
> > > If we take there's only one compute runtime version, and priority USE=
R >
> > UNSET?  Where's the conflict come from?
> >=20
> > See below.
> >=20
> > > But if we take there's more than one compute runtime version, and the=
ir
> > priority is equal,  UNSET can cover USER,  USER can cover UNSET,  even =
with
> > two clients they could cover each other.
> >=20
> > I didn't follow this part. How does the priority come into play?
> >=20
> > We have to keep switching the mode as the DRM clients come and go.
> >=20
> > > We should take it easy.
> > > Once we reached USER, set by new compute, we should latch it, for the=
 WA
> > has been implemented by USER.
> >=20
> > That won't work. If you are running two different containers, you may h=
ave
> > different compute runtime versions. Also, Mesa can be submitting to CCS=
 too
> > for async compute, AFAIK.
> >=20
> > To properly cover things, we should make it into per DRM-client setting=
 and
> > switch the mode accordingly when different DRM client is run.
> >=20
> > And for the given SKU with only one CCS, as explained earlier, it shoul=
d be
> > already guaranteed that two different DRM clients are not active on the
> > hardware at the same time due to the address space mathing requirement
> > between RCS and CCS.
> >=20
> > If this needs to be extended to multi CCS SKUs, then it'd be a bigger
> > implementation effort.
> >=20
> > Regards, Joonas
> >=20
> > >
> > > Thanks,
> > > Jia
> > >
> > > > -----Original Message-----
> > > > From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > > > Sent: Monday, September 21, 2026 11:47 PM
> > > > To: Yao, Jia <jia.yao@intel.com>; sashiko-bot@kernel.org; sashiko-
> > > > reviews@lists.linux.dev
> > > > Cc: dri-devel@lists.freedesktop.org;
> > > > intel-gfx@lists.freedesktop.org; Roper, Matthew D
> > > > <matthew.d.roper@intel.com>; Tvrtko Ursulin <tursulin@ursulin.net>
> > > > Subject: RE: [PATCH v9] drm/i915/dg2: Add per-context control for
> > > > Wa_22013059131
> > > >
> > > > Quoting Yao, Jia (2026-09-21 20:33:03)
> > > > > Hi @Lahtinen, Joonas,
> > > > >
> > > > > The key is LSC_CHICKEN_BIT_0 is a global register.
> > > > >
> > > > > Even we use per-client,  we should consider the following cases:
> > > > >
> > > > > 1. Should conflicting configurations within a client be rejected?
> > > > > I recommend the first setting should be latched.
> > > >
> > > > From uAPI perspective it would be simpler to set this at the DRM
> > > > client level at once. However we don't seem to have such uAPI in
> > > > active use currently (all
> > > > drm_noop) so you'd have to compare the complexity between indirectly
> > > > setting it at DRM client level by first created context or adding
> > > > such an uAPI to set it explicitly per client.
> > > >
> > > > > 2. Should conflicting configurations across different clients be =
rejected?
> > > > > I think the latter setting can cover previous one.
> > > >
> > > > DRM clients need to be indepenent from the driver perspective, we
> > > > can't do that.
> > > >
> > > > The whole point of making it per DRM client is that given the
> > > > impacted SKU only has 1 CCS engine. We have the address space
> > > > matching requirement between CCS and RCS, so when both CCS and RCS
> > > > are running, we know they belong to the same DRM client and thus
> > > > they will not conflict with the WA mode. And if only one of them is
> > > > running, there can be no conflict either as it's just one context.
> > > >
> > > > > Even like this, still can't cover all the race condition.
> > > >
> > > > Which race conditions do you think would remain? We definitely have
> > > > to eliminate any race conditions to land this.
> > > >
> > > > Regards, Joonas
