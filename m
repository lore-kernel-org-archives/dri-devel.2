Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F115C982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C48C10E0E5;
	Fri, 18 Sep 2026 10:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AesZuwD1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3EC910E0C8;
 Fri, 18 Sep 2026 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789726328; x=1821262328;
 h=mime-version:content-transfer-encoding:in-reply-to:
 references:subject:from:cc:to:date:message-id;
 bh=5de4J7uo+CgCIXFwu7a4Esv/7de3E0WbJXUmEhuJ4b4=;
 b=AesZuwD1eqaoR7Hwz5FBxxZs6qWMaebkhIdvAI40THLkamPb5rXbK7/k
 SU+iZ309azVK7WW9H5x9mgr96sPAIuAoKKacYNe/KTAnkyPRWs+yEi9YG
 rdbu74R+blvpmfNeoxPghPKqPsu3+glGZJ1oUZGJja+ztF9G0+ekv3jKp
 iAIKUW/+ZjvLaJCTy/2bG6NXHDOv9usEF1eDffq77Hqtlyh0gJz6eYtBD
 6E4gRuwtTy9syeVnm966JBcHK+ztHKriuSar+rM5N3LlCGNtR6sPSP6EV
 QAUFUQqwaBkoWxqcMGplQYxLhI12bJDLhJc9qSyEe8kHd8caEMEG79qIj A==;
X-CSE-ConnectionGUID: xZpqCmKqRNCL/3Atw3X1pw==
X-CSE-MsgGUID: VNW9B0shTiigY/wlH6cdMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90238528"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="90238528"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:12:07 -0700
X-CSE-ConnectionGUID: Kk7+0y3kRbO6P58QOEd0bg==
X-CSE-MsgGUID: 8RD7H50dQeaAFrZH/hSHuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2520664"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost)
 ([10.245.245.180])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:12:05 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4c94abcc-2f0f-4454-999f-38640972dfe2@ursulin.net>
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
 <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
 <20260709110200.2_5Eg8xF@linutronix.de>
 <a6c056ba-0847-4d2c-a7bd-39ac27eb15d5@lankhorst.se>
 <20260918083118.POmXtJuv@linutronix.de>
 <4c94abcc-2f0f-4454-999f-38640972dfe2@ursulin.net>
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
To: Jani Nikula <jani.nikula@intel.com>, Maarten Lankhorst <dev@lankhorst.se>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Date: Fri, 18 Sep 2026 13:12:02 +0300
Message-ID: <178972632228.60564.16756848994208751058@jlahtine-mobl>
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

Quoting Tvrtko Ursulin (2026-09-18 12:44:43)
>=20
> On 18/09/2026 09:31, Sebastian Andrzej Siewior wrote:
> > On 2026-07-09 13:36:57 [+0200], Maarten Lankhorst wrote:
> >> Hey,
> > Hi Maarten,
> >=20
> >> Yeah the problem was similar, I believe neither check should exist,
> >> instead the caller should give this information like the comment menti=
ons.
> >=20
> > Any update here? Maybe I have been left out on reposts. Any chance this
> > gets in before the LTS of this year gets out?
>=20
> Side question, there was a bunch of sashiko issues against v4 - have=20
> those been addressed?
>=20
> As today it is the first time I see patch 7/7 which is a bit of a scary=20
> one. I have to ask how much does Intel commit to fixing out any=20
> potential breakage given the status of i915?

I'd say there is very close to zero chance of accepting patch 7. And
that would take massive functional and performance validation efforts
done by the person wanting the patch to get merged.

And yes, there would also need to be commitment to fix any fallout by
that same person in weekly -rc cadence. So please raise your hand, whoever
wants to volunteer.

There's already the earlier much smaller patch about vblank that needs
to get reviewes and acceptance and it hasn't been able to be driven
to completion.

So projecting from that, I don't exactly expect patch like 7 in this
series to get merged in any near future without somebody really stepping
forward and signing to do all the validation and and perf regression
testing.

Regards, Joonas
