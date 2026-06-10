Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372FECD8CB2
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9811410E116;
	Wed, 10 Jun 2026 11:16:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="muk1qFAH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 660DD10E116
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 11:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781090198; x=1812626198;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=+AEhDYB3hQgU0JGtxuRBUjtVAYWp2uA3O9IFokUeQlA=;
 b=muk1qFAHNQoZEcKp1H5KRQWv5eMKENTsHKTSX362ayn1n5wwPZpZdg0Y
 1VC642pjJKVozoxnc1wLmsQh/KuNYsg+xb1KWCLgSYQpT9aJxv56x8OFS
 KnktVSzWlBpjbSZkdwU9iugliLdYd5NUcrpBLCWX0sMPPpnLikgeaGTre
 RR2XKtNjN6xsKOlZkPqsstzzk50vsr3nSGbdj0yYWiCT0zP70rO2Se2EJ
 HCOx6sh3iYGafMQzlyyKI7heSciv0tVgVxPYqDYeCoPTOhuSzmOY/t8Tl
 T3Oaf9T0HQ8MZIHy2op4s2A3DAR7yO0ObAfeKwk2EnQWKxXwo/ovjvVwe w==;
X-CSE-ConnectionGUID: gZQjqRQZReOZ4sG8QbcLgw==
X-CSE-MsgGUID: CkYMVXx4S1aFp39e5yUxxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="92198505"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="92198505"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:16:38 -0700
X-CSE-ConnectionGUID: NgojO17xQMqHmtLTAAI9mA==
X-CSE-MsgGUID: SO/9xLc8TbW3xhCyh50GyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245013006"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost)
 ([10.245.244.3])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:16:35 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, Dave Airlie <airlied@gmail.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Simona Vetter
 <simona@ffwll.ch>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: turning on sashiko.dev for dri-devel
In-Reply-To: <aigsGomurnOVWLVO@phenom.ffwll.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <CAPM=9tyvm1jAX5udJ8OU+39XzwZRATjjhHAWDn7kJug+NZKBuA@mail.gmail.com>
 <aigsGomurnOVWLVO@phenom.ffwll.local>
Date: Wed, 10 Jun 2026 14:16:32 +0300
Message-ID: <9c86f832d2bf4cb26c419d76d9ebf94ebb74383e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 09 Jun 2026, Simona Vetter <simona.vetter@ffwll.ch> wrote:
> On Thu, May 28, 2026 at 10:14:41AM +1000, Dave Airlie wrote:
>> Hey,
>> 
>> Just want to give a heads-up that I intend to ask Roman to enable
>> sashiko.dev AI patch review to be enabled for dri-devel in a week.
>> Will request it replies to the list at for a trial period I think it
>> balances time wasted best, but also allows people won't don't want to
>> see the AI reviews to just bin it on their end in their mail filters.
>> 
>> I also encourage the development of drm subsystem rules either via
>> documentation updates or review prompts,
>> https://github.com/masoncl/review-prompts
>
> Bit late my take, ignoring all the big picture questions (which are maybe
> more suitable for the hallway track at next xdc - I do have strong
> opinions on all this), the one reasons I think this is worth it is better
> docs.
>
>> There has been some recent discussion
>> https://lwn.net/Articles/1073583/ about merging the review prompts to
>> the kernel or providing them as documentation.
>
> Like Jon Corbet also pointed out, whether it's because people feel more
> comfy giving clear instructions to machines, or whether the faster cycle
> possible with an llm getting everything wrong until you're extremely clear
> with everything, very often code agents docs seem to be much better. So if
> we can land those in the main docs and if this bot helps people (for as
> long as the vc splurge may last) to improve the docs we have so it spits
> out more useful replies, then I think it's worth to enable it.

I believe we don't write lots of detailed instructions for people,
because it's a lot of work to write and maintain, and people just won't
read or follow all the instructions anyway. That does lead to tribal
knowledge and allows people to shout "it's not documented, how was I
supposed to know", but tomes of detailed documentation isn't all that
much better. It should be a balance. But LLMs won't get bored reading
the instructions, and often actually follow them too.

> For me though this does not remove the need for review, which is
> fundamentally about ensuring that at least 2 human contributors have the
> illusion (we all know that we're often not that good for real
> understanding, this stuff is hard) of understanding a patch set, why we
> need it, and how it goes about solving that problem.
>
> And at the meta level above that, the point of having that review is to
> encourage collaboration across teams and companies, and improve our
> community knowledge of how to and how not to write gpu drivers.

Agreed. I have yet to see AI review with genuinely useful feedback about
design or long-term subsystem goals. It's all details. Ditto for AI
assisted patches, for that matter.

One thing that's bugging me though is the absolute flood of review with
"Pre-existing issues". 151 such review comments in the past week. Like,
sure, we have pre-existing issues, but we can't block patches based on
that, or we'll only be fixing pre-existing issues the rest of the year
or so. Perhaps it's useful information as static analysis, but somehow
it should be separated from patch review a bit better.


BR,
Jani.


-- 
Jani Nikula, Intel
