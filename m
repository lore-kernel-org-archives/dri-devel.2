Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252C0C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A72D910E799;
	Wed, 23 Sep 2026 07:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="bg8ZxXd0";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10DEE10E812
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 07:19:11 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c2940ef15d3so74037666b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1790147949; x=1790752749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ft6XgyJ5wQGlqXKRn4SVkQ1bgRUrF5cWG3Ko+MjzV64=;
 b=bg8ZxXd03rUjsV+hDTpUsj2+NDlQkroO4Q5/wkrNkFxfY5xWlQpaJLVS03DEFp6MCK
 fj+uU5vjARINTfpWNeqOfIfWzHjJYD+nVncmUx93heRofQPkLKH5K28i6Ry07Mo7ECNe
 cqeMxDMoIRsObY0GorUKTMa0yam0Ch7AXgcW4MLhppDTZmmBqVUlKHqi3GAFxpLxdQH2
 Oth6kx372xYS1ljCy3EPGJ1M+2T46Z37wxhubO6bFlFRhAqZ2LUghEG2doqd087pBTKj
 PEqP8UAExw8QMH1gwBahVyNtAqZXMdmOtcYg9hyD6nLfj0cQ7Y2mX3TGKvkUO97JiEvN
 B4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790147949; x=1790752749;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ft6XgyJ5wQGlqXKRn4SVkQ1bgRUrF5cWG3Ko+MjzV64=;
 b=u+uh6q/vgwH0GnTcd9CNImo5/1qMwyVf2iZR8zHrS3S6ss5kcFBCrsM51w1qoUy+i0
 HCytdPVHz+BxgEtYM5uS7FmCIwkzBct6dnZhUdjeYjQM66fV6rnZ24LNNT6x7MZXI3Ba
 WNMJ8FDqeG4+TOtrGr4ESK3Nxi0yDcmu2hWXndYiZF4RTCbM9211lkChDblbgCRXQ3Pt
 xYn7tCwXM1ZgftG/D5k52cowHrK9S39m9YtPgzABQ1FHASfmm4wUY2P9hsvjmtzRfITp
 sJeenIzj54hSfTI2ap6BWn3NGdswEz/Ac9hWS9hBJwhMG9ga+vBCUUjCCKwBbpbroL15
 3hKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxebLRCx2uRM44Y8bD/eLXpfWpnfPPt9ZrIwDiz1oplB2szPPj50CtGRfXqmoz/P8oxmG4mKn2Boco=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mv4GJ4tS4zuYpIB0XtY8zgJmTQPBQ23gQODRGTU0YRK8jl5JHp
 1TuISKrjRfNRpnukGOF8IVxdBIAd9uNBAhvH66r7F1ErlRGwQb2NoaYkFacBWEHaPe8=
X-Gm-Gg: AYBFou1gXZT70Aknxbxw0fzYy2gqL7M1GkX0FABPTHpNiHyiEagyXSE0VxcpIEz5zRn
 0eTOUCAoFza8BevLHqzbfwxMDQQUnxH6hbaHRx+gh8YDUCuzEUBmjGrXBASqlMqgQRBtz/e3oX1
 QTgEQ0n46j+b6wgOGxXBI67Lyd+b6Ec4qC1LPLqxWRrP5fDwBvkUh3IfDbEY7wX/PP/31mjxZM6
 QUyxwXVaJvk8W3S9pDmoYChEwROhyV6zu+OUvYrkDd/iD2CAZxSuMlIXcoclOM1wL2nsL1ihybO
 PAj4bZ1HYmLTNkimLF3dCYVPgRclI46IiowFMRCSpzIjDszY8MCgFJlEBGWccNCuoZNuAFu5MAA
 hsc1sI04Bp/eHiq6pF8qkDg49wLq0FogGmqvgeDvF+Wmg2P7Jo0YcZ9AvoJjIaN1kAQauX/+VvI
 K2s6ggZrwYTWr8QG5iUpx/hHYdjC/0CRkHMooyjDqAB9L9yUNoRw50Ny++TlKB6/yeSa+pDMbOM
 w/EFrcgsiTM9w==
X-Received: by 2002:a17:907:c23:b0:c29:f5d5:5aa1 with SMTP id
 a640c23a62f3a-c2aae27ba7dmr122903466b.43.1790147948799; 
 Wed, 23 Sep 2026 00:19:08 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6e3677sm56238766b.62.2026.09.23.00.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 00:19:08 -0700 (PDT)
Message-ID: <32eb2a14-8684-4e61-98a0-882d12dddc16@ursulin.net>
Date: Wed, 23 Sep 2026 08:19:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
To: Maarten Lankhorst <dev@lankhorst.se>,
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
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <0ed50720-3533-4cd7-8579-0dc175a822dd@lankhorst.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 18/09/2026 12:19, Maarten Lankhorst wrote:
> Hey,
> 
> On 9/18/26 11:44, Tvrtko Ursulin wrote:
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
>> Side question, there was a bunch of sashiko issues against v4 - have those been addressed?
>>
>> As today it is the first time I see patch 7/7 which is a bit of a scary one. I have to ask how much does Intel commit to fixing out any potential breakage given the status of i915?
>>
>> + other maintainers FYI
> Patch 7/7 addresses a real issue, it just happened to be more easily found on PREEMPT_RT.

In this case, have you pulled it out from the series and sent standalone?

> I haven't had much time to look at PREEMPT_RT lately, I'll see if I can get some time to look at
> sashiko, but lack of reviews have not been helping.
> 
> Every time I send out revised patches, it takes a few months before I receive a response.
> By that time I have moved on to other projects, and finding time takes a lot of time again.
> If the cycle took only a few days I could finish this quickly and get it merged.

Sounds like Intel is not officially supporting/funding your effort. I am 
also helping out unfunded in my private time so cannot really promise to 
improve things much in terms of promptness of reviews, or even promise 
to review in the short term.

In any case it sounds like the best plan is to send the fix which 
applies to !PREEMPT_RT as standalone and see if anyone bites. Problem 
still be merging such a large change so I expect maintainer acks will be 
needed in any case.

Regards,

Tvrtko

