Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B36C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 06:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78EC310E2F1;
	Mon, 21 Sep 2026 06:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fkpZp60f";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5AEB10E225;
 Mon, 21 Sep 2026 06:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789973511; x=1821509511;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=SUr2x92m0kq0N82NhWMY7MpEDbdPZzPwC/maMFz4Ze0=;
 b=fkpZp60f9QlIPcg1M+UjUF416OkSdtv+AgInHpWkz/rNxYzrJseBX5uD
 Qa06f7tkcyRxtxhwk1tCpPKzpEYB3xaxUZvUcsBoe9UwLK6bsF9XhBwvR
 MK2HmPF1Tuw573Pk2Q2cOh/E7usCJ1OVuIFMyarsWpeQ9J2bqUBPQz7w1
 ThrU53QQ0rv73LQCN5J7kysz+QwbqQhwvJOTzTA5HCBxWfyFLkYzhANol
 0r5GVLh0zxrB0bkNhfYF/0rbFAeOx2H7uxe8lvjFpAtmuYYgrdxUzATsd
 SXBuADm662Ugde6U+lRKnCLLSgNkNw+fJofygEedneO3drsz8IINw6sQz Q==;
X-CSE-ConnectionGUID: jnRkyxj8SuCj38qSrKXI7w==
X-CSE-MsgGUID: NRDi+pkxQQSedHbN0WngOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11911"; a="94292574"
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="94292574"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:51:50 -0700
X-CSE-ConnectionGUID: nWKMdSgDRYO74M9Q0HEw1Q==
X-CSE-MsgGUID: MqvGeTRZRrGzuqZuk+UK/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,114,1787036400"; d="scan'208";a="272683213"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost)
 ([10.245.244.142])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2026 23:51:48 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <43a77431-f24e-4e26-890b-d60b1844f028@lankhorst.se>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
 <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
 <20260709110200.2_5Eg8xF@linutronix.de>
 <a6c056ba-0847-4d2c-a7bd-39ac27eb15d5@lankhorst.se>
 <20260918083118.POmXtJuv@linutronix.de>
 <4c94abcc-2f0f-4454-999f-38640972dfe2@ursulin.net>
 <178972632228.60564.16756848994208751058@jlahtine-mobl>
 <43a77431-f24e-4e26-890b-d60b1844f028@lankhorst.se>
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
To: Jani Nikula <jani.nikula@intel.com>, Maarten Lankhorst <dev@lankhorst.se>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Date: Mon, 21 Sep 2026 09:51:45 +0300
Message-ID: <178997350548.20141.1094942452589748749@jlahtine-mobl>
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

Quoting Maarten Lankhorst (2026-09-18 17:24:39)
> Hello,
>=20
>=20
> On 9/18/26 12:12, Joonas Lahtinen wrote:
> > Quoting Tvrtko Ursulin (2026-09-18 12:44:43)
> >>
> >> On 18/09/2026 09:31, Sebastian Andrzej Siewior wrote:
> >>> On 2026-07-09 13:36:57 [+0200], Maarten Lankhorst wrote:
> >>>> Hey,
> >>> Hi Maarten,
> >>>
> >>>> Yeah the problem was similar, I believe neither check should exist,
> >>>> instead the caller should give this information like the comment men=
tions.
> >>>
> >>> Any update here? Maybe I have been left out on reposts. Any chance th=
is
> >>> gets in before the LTS of this year gets out?
> >>
> >> Side question, there was a bunch of sashiko issues against v4 - have=20
> >> those been addressed?
> >>
> >> As today it is the first time I see patch 7/7 which is a bit of a scar=
y=20
> >> one. I have to ask how much does Intel commit to fixing out any=20
> >> potential breakage given the status of i915?
> >=20
> > I'd say there is very close to zero chance of accepting patch 7. And
> > that would take massive functional and performance validation efforts
> > done by the person wanting the patch to get merged.
> >=20
>=20
> I don't mind taking the responsibility to debug and troubleshoot if thing=
s break.
> Patch 7/7 fixes a real bug that is hard to trigger otherwise, but can mos=
t definitely
> happen.
>=20
> I believe it should be treated it as any other fix, merge it and when the=
re are
> bug reports, solve those.
>
> Most of my energy and work is going to other projects now, so I won't be =
able to do
> the entire validation in advance.

For a patch with such potential to cause breakage (functional and
performance), we really need the validation efforts up front.

> I will definitely ensure CI is clean and passing,
> it's how I came across this bugfix in the first place.
>=20
> If bug reports come in and point to this patch, I will be able to take a =
look and
> solve the reported issues, but I won't be able to hunt for them in advanc=
e.

I think somebody will actually need to run real workloads on such kernel
across a few HW generations.

Couple of browser based GPU benchmarks and video transcode benchmarks
would be a good start.

> It's only a few weeks until the -rc cutoff, so we can make it part of the=
 next cycle.

Definitely not a fan of sending such a patch to mainline under the holiday
season without any testing.

Regards, Joonas

> > And yes, there would also need to be commitment to fix any fallout by
> > that same person in weekly -rc cadence. So please raise your hand, whoe=
ver
> > wants to volunteer.
> >=20
> > There's already the earlier much smaller patch about vblank that needs
> > to get reviewes and acceptance and it hasn't been able to be driven
> > to completion.
> >=20
> > So projecting from that, I don't exactly expect patch like 7 in this
> > series to get merged in any near future without somebody really stepping
> > forward and signing to do all the validation and and perf regression
> > testing.
> >=20
> > Regards, Joonas
> Kind regards,
> ~Maarten Lankhorst
