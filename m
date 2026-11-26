Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B43606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SPYVax4O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36B61122CA;
	Thu, 26 Nov 2026 10:35:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 406F41122CA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795689353; x=1827225353;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=FgNe3nugFZeV71SeyfshH50GVN++IY2a+btOVUjfL4Y=;
 b=SPYVax4Ok7MuKnuI/sk9KB3CwdNRLrqD7AhVYHFtkFCsj6b2zuOVMR3c
 DZGjxpOg1V70f/tZcwjrEXq8niULhhHsG+vHqrq8sIqm2+OjFCIh0r8uG
 jluHoEoX2VAKfCmfRWN3UTP4ooKHuXrZ9pPJqwVAv/8clvu/l1rDvZ958
 RkkyLsRpDs/a7Sjm3UECc78a3RgFc6Sk3kiXA2VGazyqwfPKFHUUezKki
 ZpTMLFTZxiYBSTm4Kh+AxQP4v4oTYtafEGPZZuPJO9xyK58gAuuNVALda
 +4rTvJgwDW3ejLgUUKYyKeiBHhBxJn25vO0NiHS3499BN8zHIBT9xWBF7 w==;
X-CSE-ConnectionGUID: EIdyKxI1Qk+O++L2k+ZzEg==
X-CSE-MsgGUID: Er3yBWPgTei4dvszKis4Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488604"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488604"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 02:35:52 -0800
X-CSE-ConnectionGUID: 3yrZouwzSoWDotNLteVopw==
X-CSE-MsgGUID: CB8U29JYTsq294QmACscEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="13818277"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO [10.245.244.129])
 ([10.245.244.129])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 02:35:51 -0800
Message-ID: <f74f2d71cc1881e5bc6f6a6e7d51cab4ce26d3f6.camel@linux.intel.com>
Subject: Re: [RFC PATCH 0/2] drm/ttm: fix excessive idle memory retention
From: Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
To: "Eduardo P. Gomez" <eduardoprocopiogomez@gmail.com>
Cc: Natalie Vock <nat@pixelcluster.dev>, Arun Pravin	
 <arunpravin.paneerselvam@amd.com>, dri-devel@lists.freedesktop.org, Matthew
 Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>
Date: Thu, 26 Nov 2026 11:35:48 +0100
In-Reply-To: <CAKL2PNqdc=mLi5r87uywkQDQz2eO7hnn3=g71cgKjrv0tq4OQg@mail.gmail.com>
References: <20261124222812.511867-1-eduardoprocopiogomez@gmail.com>
 <114377fd4c275215e40c3991bb935b8c41aa3d36.camel@linux.intel.com>
 <CAKL2PNo7Vp7O4FRWGPV-ZuSqk60B4xh4pXUzcgYEEdqm_sUemg@mail.gmail.com>
 <ff8167523ddaa4b6e2d59be81cb06ff663251c0e.camel@linux.intel.com>
 <CAKL2PNqdc=mLi5r87uywkQDQz2eO7hnn3=g71cgKjrv0tq4OQg@mail.gmail.com>
Organization: Intel Sweden AB, Registration Number: 556189-6027
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-2.fc43) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-25 at 16:36 -0300, Eduardo P. Gomez wrote:
> Hi Thomas,
>=20
> > Did you actually see any instance of remaining GPUReclaim memory
> > when OOM
> was hit?
>=20
> Yes. Twice actually. During a userspace memory-pressure test on my 32
> GiB
> desktop running kernel 7.3.5 without my TTM patch, the kernel
> reported two
> global OOMs and killed kde-ram (the test I mentioned before) both
> times:
>=20
> =C2=A0=C2=A0=C2=A0 2026-11-23 21:43:51 -0300. gpu_reclaim:10045728kB=C2=
=A0 global_oom
> =C2=A0=C2=A0=C2=A0 2026-11-23 21:44:08 -0300=C2=A0 gpu_reclaim:10045736kB=
=C2=A0 global_oom
>=20
> About 9.58 GiB was still reported as reclaimable GPU memory at the
> time of
> each OOM.
>=20
> The full kernel log for the first event is here:
> https://paste.rs/ajafn

Judging from the log there is also a high number of inactive_file pages
available that are not reclaimed.

This IMO points to something odd happening with reclaim itself rather
than something specific to the ttm pool shrinker?

Thanks,
Thomas
