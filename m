Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37526C61DC6
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7724A10F307;
	Fri, 28 Aug 2026 09:09:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mhv/XYcr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0929D10F307;
 Fri, 28 Aug 2026 09:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787908146; x=1819444146;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=hzoxafoDvKtm30VmfjqOmN6WXzEwAjyeJ19/FBBenGo=;
 b=mhv/XYcrwE3ZGmkIdeX82J3PNRDU5tAonDxp2bt9YTTexVg9jZsW10Tg
 ZP2HsS6jx50dcBtHfEJiJocRm7ShGojsjuyQ0cEquIK/1gQuFp6KJigjJ
 IkC//VZeFdl4sU7GHX8cyKf5zyNYdiyhm/zyECGlYYhvvNnaiIC+p7d+e
 JB206AdWGrwgfjWYISKCpolyJ7L0Sqe8YCp/JTvUMTQGar7KID96mM3ge
 c3I71kBy77KaZ5YoQXw96DCL8X18lfJuuXrhLXwoeN6V1F9rLJAPXgAPQ
 qc8eDWnc2OMI2hEZAmu1yPoC5JpYHxvAXbUb+pV8i+oA7MXsdUenDobWN A==;
X-CSE-ConnectionGUID: hhY4io+mRcmMEEwnce6aMg==
X-CSE-MsgGUID: 1+MFhFmDQgGdLogNV9MYGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="99575100"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="99575100"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 02:09:05 -0700
X-CSE-ConnectionGUID: XWJPNHv8SQ2e6kD5m1Scyg==
X-CSE-MsgGUID: ts8BLPMcSP+EP+Af/BY8DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="273362163"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.245.246.114])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 02:09:02 -0700
Message-ID: <756222a03760054ffebf187e581c60ce4025c023.camel@linux.intel.com>
Subject: Re: [PATCH v2 5/8] drm/i915/gt/selftests: Use drm_* prints in
 aggregated gt selftests
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Andi Shyti <andi.shyti@kernel.org>, Krzysztof Karas
 <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Jani
 Nikula <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Date: Fri, 28 Aug 2026 11:08:59 +0200
In-Reply-To: <apDJpcatw9isIKdL@zenone.zhora.eu>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
 <20260818095624.3254368-6-krzysztof.karas@intel.com>
 <apDJpcatw9isIKdL@zenone.zhora.eu>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
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

On Fri, 2026-08-28 at 01:38 +0200, Andi Shyti wrote:
> Hi Krzysztof,
>=20
> ...
>=20
> > @@ -400,11 +400,10 @@ static int intel_mmio_bases_check(void *arg)
> >  			u32 base =3D info->mmio_bases[j].base;
> > =20
> >  			if (ver >=3D prev) {
> > -				pr_err("%s(%s, class:%d, instance:%d): mmio base for graphics ver =
%u is before the one for ver %u\n",
> > -				       __func__,
> > -				       intel_engine_class_repr(info->class),
> > -				       info->class, info->instance,
> > -				       prev, ver);
> > +				drm_err(NULL,
> > +					"%s(%s, class:%d, instance:%d): mmio base for graphics ver %u is =
before the one for ver %u\n",
> > +					__func__, intel_engine_class_repr(info->class),
> > +					info->class, info->instance, prev, ver);
>=20
> yah! drm_err(NULL, ...) is quite pointless. If there is no way
> for retrieving the drm device, then let's just stick to pr_*,
> this is their role.

While I said in one of my comments to 3/5 that I'm not sure if that makes=
=C2=A0
sense, maybe it does.  With drm_*(NULL, ...), log messages are still
tagged=C2=A0with [drm] at least.  So as a minimum, in line with my comment =
to=C2=A0
1/5, I=C2=A0think commit message of 1/5 that introduces only drm_*(NULL, ..=
.)=C2=A0
could=C2=A0tell us that we want that [drm] tag even without context, unless=
 we=C2=A0
don't=C2=A0want it, then prefer to keep pr_*().

Thanks,
Janusz

>=20
> Thanks,
> Andi
>=20
> >  				return -EINVAL;
> >  			}
