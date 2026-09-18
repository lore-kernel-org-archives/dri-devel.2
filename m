Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E446DC982DC
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A078110F2E6;
	Fri, 18 Sep 2026 11:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="C0ckz4ua";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDA410F2E6;
 Fri, 18 Sep 2026 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1789730359;
 bh=GXZ96OfNecmNSW0OMTeZ6CVtyLVGDalnRKwldr7+V98=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=C0ckz4uaQmExJlGerK/Sa7sEB9sphaPQ/rS5w1fCo3g/9sMrXBhRhWmAWwpH0ycj+
 e2aI4vIg2zVz1afubovg3Iv7V6dOTac1QoJpZexYFq2kE7JVw8wI2oUHApwJFVUe4+
 vAQ/yzAxfSiRw6dLPJV6lzHIjpS3Tv2YLzllMowDiWft3MzXHZu08D8uD/xcVJXv4C
 yIRkVG0/fwTernMdLsaou+xQugcXY3yinlzc1JhEZVWvJ5ogpI7nz/pPFbiGr47t5p
 7AHGKIzM5E4yU3uZOSItSYmFunOGJa6Pd+rMlBgrot5M5hDXyrsRAC2cHMQqb+ujgk
 R/SG9XiqzMbsQ==
Message-ID: <0ed50720-3533-4cd7-8579-0dc175a822dd@lankhorst.se>
Date: Fri, 18 Sep 2026 13:19:18 +0200
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
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <4c94abcc-2f0f-4454-999f-38640972dfe2@ursulin.net>
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

On 9/18/26 11:44, Tvrtko Ursulin wrote:
> 
> On 18/09/2026 09:31, Sebastian Andrzej Siewior wrote:
>> On 2026-07-09 13:36:57 [+0200], Maarten Lankhorst wrote:
>>> Hey,
>> Hi Maarten,
>>
>>> Yeah the problem was similar, I believe neither check should exist,
>>> instead the caller should give this information like the comment mentions.
>>
>> Any update here? Maybe I have been left out on reposts. Any chance this
>> gets in before the LTS of this year gets out?
> 
> Side question, there was a bunch of sashiko issues against v4 - have those been addressed?
> 
> As today it is the first time I see patch 7/7 which is a bit of a scary one. I have to ask how much does Intel commit to fixing out any potential breakage given the status of i915?
> 
> + other maintainers FYI
Patch 7/7 addresses a real issue, it just happened to be more easily found on PREEMPT_RT.

I haven't had much time to look at PREEMPT_RT lately, I'll see if I can get some time to look at
sashiko, but lack of reviews have not been helping.

Every time I send out revised patches, it takes a few months before I receive a response.
By that time I have moved on to other projects, and finding time takes a lot of time again.
If the cycle took only a few days I could finish this quickly and get it merged.

Kind regards,
~Maarten Lankhorst
