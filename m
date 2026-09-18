Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C754C982DA
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AB510E8FC;
	Fri, 18 Sep 2026 14:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="Rcxa7+ab";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692B010E3E8;
 Fri, 18 Sep 2026 14:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1789741478;
 bh=bDTUM+9dvgRBrmyVJ4C1tivQMZH4gidWEZsLJcqUTZs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Rcxa7+abU1Zs1qaTpBQGGFYre+8gLilmQfSpfTaInWpoUDxHtRoN9trMllh02LlpB
 8o8w2x+LzlrS83qSIXBfvyJeeQeIdVL9kEPi7V4WVK0v7zMoWMF28oPN+lLqRDuL/C
 JH+mCiaD7lWEMP+sT9VhFwpIsjK6R+c7QPr5hyblCNEmtsmsYLIQ5oNHeYNmOEPWux
 d6EHPU66DPg9JI82kFfRhCf+F02sFd2QpgeeEfDZ/sbV62Oq/oo6hEhLg064jrqF9O
 0AMKRDkqK28DPv9U2r49UfGnye7tI6cga+exkUCoq6pnm+Fm/c0/C4/044vglTpvyY
 42vHX8TE9hZ+g==
Message-ID: <43a77431-f24e-4e26-890b-d60b1844f028@lankhorst.se>
Date: Fri, 18 Sep 2026 16:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
 <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
 <20260709110200.2_5Eg8xF@linutronix.de>
 <a6c056ba-0847-4d2c-a7bd-39ac27eb15d5@lankhorst.se>
 <20260918083118.POmXtJuv@linutronix.de>
 <4c94abcc-2f0f-4454-999f-38640972dfe2@ursulin.net>
 <178972632228.60564.16756848994208751058@jlahtine-mobl>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <178972632228.60564.16756848994208751058@jlahtine-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello,


On 9/18/26 12:12, Joonas Lahtinen wrote:
> Quoting Tvrtko Ursulin (2026-09-18 12:44:43)
>>
>> On 18/09/2026 09:31, Sebastian Andrzej Siewior wrote:
>>> On 2026-07-09 13:36:57 [+0200], Maarten Lankhorst wrote:
>>>> Hey,
>>> Hi Maarten,
>>>
>>>> Yeah the problem was similar, I believe neither check should exist,
>>>> instead the caller should give this information like the comment mentions.
>>>
>>> Any update here? Maybe I have been left out on reposts. Any chance this
>>> gets in before the LTS of this year gets out?
>>
>> Side question, there was a bunch of sashiko issues against v4 - have 
>> those been addressed?
>>
>> As today it is the first time I see patch 7/7 which is a bit of a scary 
>> one. I have to ask how much does Intel commit to fixing out any 
>> potential breakage given the status of i915?
> 
> I'd say there is very close to zero chance of accepting patch 7. And
> that would take massive functional and performance validation efforts
> done by the person wanting the patch to get merged.
> 

I don't mind taking the responsibility to debug and troubleshoot if things break.
Patch 7/7 fixes a real bug that is hard to trigger otherwise, but can most definitely
happen.

I believe it should be treated it as any other fix, merge it and when there are
bug reports, solve those.

Most of my energy and work is going to other projects now, so I won't be able to do
the entire validation in advance. I will definitely ensure CI is clean and passing,
it's how I came across this bugfix in the first place.

If bug reports come in and point to this patch, I will be able to take a look and
solve the reported issues, but I won't be able to hunt for them in advance.

It's only a few weeks until the -rc cutoff, so we can make it part of the next cycle.

> And yes, there would also need to be commitment to fix any fallout by
> that same person in weekly -rc cadence. So please raise your hand, whoever
> wants to volunteer.
> 
> There's already the earlier much smaller patch about vblank that needs
> to get reviewes and acceptance and it hasn't been able to be driven
> to completion.
> 
> So projecting from that, I don't exactly expect patch like 7 in this
> series to get merged in any near future without somebody really stepping
> forward and signing to do all the validation and and perf regression
> testing.
> 
> Regards, Joonas
Kind regards,
~Maarten Lankhorst
