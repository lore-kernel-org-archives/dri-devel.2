Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2663C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9882D10E08D;
	Wed, 23 Sep 2026 11:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="ceYSL3st";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8204310E08D;
 Wed, 23 Sep 2026 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1790164018;
 bh=6ZM7U7B23fZdP8KfJT13YymZsJzXrFdTfmOBL5ZqVLo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ceYSL3st+7DSoVOzMoqE6VusNMSF8XkpQfB66v67myqZlQVZMR25jlXVabewaaRfo
 2Ajl1A97jnOooMeeuv0TZwGb5wz+LOO96xa1MJhajqaASakgVTLKPDwY98ctVEEXhB
 u91avSNws4UBPTPaMZXepOCSuz0urtNS7Dng+wZmR61/XLLqu1JdaCaECfr9TTX8iJ
 CE5wOtOq6vqQHfuQnA1G6U4nS8TX18QAyGYf03bMTI2ftBVZ6O2p5IjxiucicTwJTW
 KsGCga1KKEZBQiI+kTqFV4YnXUe9c2+cGsXtBvC4jNyLjfQGYXlE6r8Web8cp565G7
 1fN8ew63gP0XA==
Message-ID: <22d31b4d-5efc-46ca-ab40-2205a77fa33d@lankhorst.se>
Date: Wed, 23 Sep 2026 13:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
To: Tvrtko Ursulin <tursulin@ursulin.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
 <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
 <20260709110200.2_5Eg8xF@linutronix.de>
 <a6c056ba-0847-4d2c-a7bd-39ac27eb15d5@lankhorst.se>
 <20260918083118.POmXtJuv@linutronix.de>
 <4c94abcc-2f0f-4454-999f-38640972dfe2@ursulin.net>
 <0ed50720-3533-4cd7-8579-0dc175a822dd@lankhorst.se>
 <32eb2a14-8684-4e61-98a0-882d12dddc16@ursulin.net>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <32eb2a14-8684-4e61-98a0-882d12dddc16@ursulin.net>
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

Hey,

On 9/23/26 09:19, Tvrtko Ursulin wrote:
> 
> On 18/09/2026 12:19, Maarten Lankhorst wrote:
>> Hey,
>>
>> On 9/18/26 11:44, Tvrtko Ursulin wrote:
>>>
>>> On 18/09/2026 09:31, Sebastian Andrzej Siewior wrote:
>>>> On 2026-07-09 13:36:57 [+0200], Maarten Lankhorst wrote:
>>>>> Hey,
>>>> Hi Maarten,
>>>>
>>>>> Yeah the problem was similar, I believe neither check should exist,
>>>>> instead the caller should give this information like the comment mentions.
>>>>
>>>> Any update here? Maybe I have been left out on reposts. Any chance this
>>>> gets in before the LTS of this year gets out?
>>>
>>> Side question, there was a bunch of sashiko issues against v4 - have those been addressed?
>>>
>>> As today it is the first time I see patch 7/7 which is a bit of a scary one. I have to ask how much does Intel commit to fixing out any potential breakage given the status of i915?
>>>
>>> + other maintainers FYI
>> Patch 7/7 addresses a real issue, it just happened to be more easily found on PREEMPT_RT.
> 
> In this case, have you pulled it out from the series and sent standalone?
> 
>> I haven't had much time to look at PREEMPT_RT lately, I'll see if I can get some time to look at
>> sashiko, but lack of reviews have not been helping.
>>
>> Every time I send out revised patches, it takes a few months before I receive a response.
>> By that time I have moved on to other projects, and finding time takes a lot of time again.
>> If the cycle took only a few days I could finish this quickly and get it merged.
> 
> Sounds like Intel is not officially supporting/funding your effort. I am also helping out unfunded in my private time so cannot really promise to improve things much in terms of promptness of reviews, or even promise to review in the short term.
> 
> In any case it sounds like the best plan is to send the fix which applies to !PREEMPT_RT as standalone and see if anyone bites. Problem still be merging such a large change so I expect maintainer acks will be needed in any case.

I've sent the other fixes instead, still missing 2 r-b's:

https://patchwork.freedesktop.org/series/174789/

I'll send 7/7 separately, and see what happens. If nothing else, it'll be on the mailing list to pick up. I believe that a concrete goal "Fix this specific code to work with PREEMPT_RT, it's the only thing holding us back", will eventually add motivation to merge the specific fixes, or develop another solution that will be accepted.
