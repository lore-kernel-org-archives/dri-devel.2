Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F02CC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:07:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EB510EB89;
	Tue,  1 Sep 2026 08:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aeWNvQFF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6424D10EB89;
 Tue,  1 Sep 2026 08:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788250026; x=1819786026;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=hh9w/syNOusTLP+T+ZKlMVwLnIsXdN3qpyHHtYOXd98=;
 b=aeWNvQFFQ6B4fEpkaOfP1qwnBGNCKtn6CEOP2NwqGjNxrUa6rN4CQV9v
 M8KPF/4RZ/HP3ot5vfZSrtNZ1iIul9bx9AHpvjwrzRShfdYgpG8uKCFO6
 e8+q8Grr+nl7Pc1RcKQzAHfPEoMrwybPgqTCAObJRqrsnoNlLJe/ULHC6
 hfqV2JDLTD94KQUwql8aZFY3HRLhSQnLy8YutOut4CsJXYWat9sW8Z21f
 QOEROiW8gGfa5x3wmh+Hx4kR0OAqUwUbl24acv8BW6FRAEJoOg2WeduEG
 NBhP21Ms8IR+SI+xZlAaddaoPVrEJo8g4r/4m34nAI8BtoL9jsCqSbMjC Q==;
X-CSE-ConnectionGUID: MMDTQrVuSPmKwSKQinAF1A==
X-CSE-MsgGUID: d0fw8ppsRLqldkDbLxBHbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="106191965"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="106191965"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 01:07:06 -0700
X-CSE-ConnectionGUID: cSjPu50MQh6ApZSeQs5ZnQ==
X-CSE-MsgGUID: jD8FpPaCSvaYaHSHBivpcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="274294078"
Received: from mwiniars-mobl.ger.corp.intel.com (HELO
 jkrzyszt-mobl2.ger.corp.intel.com) ([10.245.246.167])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 01:07:03 -0700
Message-ID: <ae095644e460f5a278da56c4eb47a5aaac37b19e.camel@linux.intel.com>
Subject: Re: [PATCH] drm/i915/selftests: Wait longer for request to start
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, Jani Nikula
 <jani.nikula@linux.intel.com>,  Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin	 <tursulin@ursulin.net>, Andi Shyti
 <andi.shyti@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, 	dri-devel@lists.freedesktop.org,
 igt-dev@lists.freedesktop.org
Date: Tue, 01 Sep 2026 10:07:01 +0200
In-Reply-To: <2fn7euzh5tuunytl5lgkefiitsjrprvsiqyphb77p5q4qz3enw@yj63s65lvdgw>
References: <20260831093510.3496388-2-janusz.krzysztofik@linux.intel.com>
 <2fn7euzh5tuunytl5lgkefiitsjrprvsiqyphb77p5q4qz3enw@yj63s65lvdgw>
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

Hi Krzysztof,

On Tue, 2026-09-01 at 06:19 +0000, Krzysztof Karas wrote:
> Hi Janusz,
>=20
> On 2026-08-31 at 11:33:08 +0200, Janusz Krzysztofik wrote:
> > CI extreamly sporadically (five times over last six mohths) reported
> extreamly -> extremely, mohths -> months

Heh, thanks, those were results of my last minute polishing, apparently
with spell checker off, sorry.

>=20
> > failures of igt@i915_selftest@live@hangcheck on ARL-S machines.  The
> > selftest was timing out while waiting up to 1 second for a request
> > supposed to trigger a GPU hang to be started.  It occurred possible to
> > reproduce this issue manually by running the selftest in a loop for a
> > few hours.
> >=20
> > Among results from 5 occurrences reported by CI so far, and two manual
> > reproductions, two of them contained messages that suggested a
> > posssibility of the awaited request to actually start soon after
> > timeout.  With the timeout extended from 1 to 2 seconds, it occurred no
> > longer possible to trigger the failure, even when running the test in a
> > loop for 10, then for 12 hours, on the same machine where it was failin=
g
> > before in 2-3 hours.
> >=20
> > Assume the conditions that prevented the hang requests to start within =
1
> > second were always transient, and 2 seconds is sufficient for those
> > requests to start effectively on machines in the CI environment.  Fix
> > the issue by using that value as the timeout.
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/166=
24
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> > ---
> >  drivers/gpu/drm/i915/gt/selftest_hangcheck.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c b/drivers/gpu=
/drm/i915/gt/selftest_hangcheck.c
> > index 00dfc37221fac..53f3ce5c33a47 100644
> > --- a/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> > +++ b/drivers/gpu/drm/i915/gt/selftest_hangcheck.c
> > @@ -278,7 +278,7 @@ static bool wait_until_running(struct hang *h, stru=
ct i915_request *rq)
> >  			     10) &&
> >  		 wait_for(i915_seqno_passed(hws_seqno(h, rq),
> >  					    rq->fence.seqno),
> > -			  1000));
> > +			  2000));
> >  }
> > =20
> >  static int igt_hang_sanitycheck(void *arg)
> > --=20
> > 2.54.0
> >=20
>=20
> Patch is trivial, so:
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>

Thank you :-)

>=20
> though, it would probably need a rebase, since it does not apply
> cleanly for CI build process.

Please note that was only a response from an attempt to apply the patch to
IGT sources (I sent a copy to igt-dev@lists.freedesktop.org).

Thanks,
Janusz
