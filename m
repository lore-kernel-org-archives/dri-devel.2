Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BD8CDE002
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:55:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A00110EE96;
	Wed, 24 Jun 2026 10:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dOoJNJJq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0D9210E095;
 Wed, 24 Jun 2026 10:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782298519; x=1813834519;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=tSQKiZLoAj9wMv6AVFyxdekkE3IHGmlYoUnvYQF+Cfw=;
 b=dOoJNJJqOn5RGMVjc12xoYoaou+iScACG6NrWaQJP7vNieL9hr/Qxytt
 1a24mkDvUgPQiUvKzXmiLzcet25aJSxHu7JZyRSaWw0yNtBjlVYr3K/gy
 D6KNh0YDxy7BuPyQmq1ajf4mdm/TCNtiua6c1+uitL62zAOF76nBxj0b5
 F0MRQyCY/bZYtvGd1MXbO6T9MQsw2z/8R7+nHf0TowDCJy9Eb9WwB2Jnd
 xO67zxz6XAXzC/TiEMarlhCuBD3J2nluKFkWHFTG+RQlMxv6h8W6UtCcy
 kf4P9PHe1IVqB8RQZlHn/up0UKbB/3UGfIhKw/dwxKulPBjt40VFSjza1 Q==;
X-CSE-ConnectionGUID: Sp5wfdqAT0O8p4k7LkCPgQ==
X-CSE-MsgGUID: in9GhegATMu5Rr7dRRwUng==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83060545"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="83060545"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2026 03:55:19 -0700
X-CSE-ConnectionGUID: xslLh6faT4u3Z44MamtUVg==
X-CSE-MsgGUID: s2dMlfp2R72oGFQOrwC9fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; d="scan'208";a="246902281"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.147])
 by fmviesa007-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 03:55:16 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ajuyD3vOdMdvbGqx@intel.com>
References: <AM9PR06MB78601E2636164181A4689CC281EF2@AM9PR06MB7860.eurprd06.prod.outlook.com>
 <ajqXK-fZnty-YGCK@intel.com>
 <178228365985.16303.14222363163462260344@jlahtine-mobl>
 <ajuyD3vOdMdvbGqx@intel.com>
Subject: Re: [PATCH] drm/i915: Calculate CDCLK on modeset after sanitizing
 pre-os programming
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?utf-8?q?Gabr=C3=ADel_Arth=C3=BAr_P=C3=A9tursson?=
 <gabriel.petursson@jbtmarel.com>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
 "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
 "tursulin@ursulin.net" <tursulin@ursulin.net>
To: Ville =?utf-8?b?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Date: Wed, 24 Jun 2026 13:55:13 +0300
Message-ID: <178229851360.107728.7349366780272154676@jlahtine-mobl>
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

Quoting Ville Syrj=C3=A4l=C3=A4 (2026-06-24 13:31:43)
> On Wed, Jun 24, 2026 at 09:47:39AM +0300, Joonas Lahtinen wrote:
> > Quoting Ville Syrj=C3=A4l=C3=A4 (2026-06-23 17:24:43)
> > > This smells like the same thing I already fixed with
> > > commit 3f9de66f8acb ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL
> > > without a full PLL re-enable")
> > >=20
> > > Sadly it looks like I forgot to cc:stable it :/
> > >=20
> > > Jani, can you pick that up for -fixes and slap a cc:stable on it?
> >=20
> > I'll include it in drm-intel-next-fixes, do we have a
> > Fixes: tag to add?
>=20
> It's been basically broken forever so the correct fixes
> tags probably aren't super useful.
>=20
> However the nastier user visible regression happened in=20
> commit ba91b9eecb47 ("drm/i915/cdclk: Decouple cdclk from
> state->modeset") which therefore might make sense as a
> fixes tag. But if we put that in then I'm worried that it
> won't get backported to older kernels. I guess we could throw
> that in there along with the ancient commits that actually
> introduced the problem.
>=20
> So something along the lines of:
> Fixes: ba91b9eecb47 ("drm/i915/cdclk: Decouple cdclk from state->modeset")
> Fixes: d66a21947e21 ("drm/i915/bxt: Sanitize CDCLK to fix breakage during=
 S4 resume")
> Fixes: c73666f394fc ("drm/i915/skl: If needed sanitize bios programmed cd=
clk")

Thanks, applied with those and Cc: stable with "# v4.5+" picking
the earliest version of the three.

Regards, Joonas

>=20
> --=20
> Ville Syrj=C3=A4l=C3=A4
> Intel
