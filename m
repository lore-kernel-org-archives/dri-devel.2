Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C636C44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F127D10F4A8;
	Thu,  9 Jul 2026 09:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="ZnR/aZ5i";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF9F10F4A7;
 Thu,  9 Jul 2026 09:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783590787;
 bh=+/h3p/bzlPlYOc3yEyyvW+IkQ+A1ztref4CYgH1i6go=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZnR/aZ5iIuBMkXDVchJcbuUrqgEtgTBgqctsav5jy1lRbjabDYBKiCHeKcZdxOw4O
 FjhAOpC8PqhkZAs7t2XuPqK8/ofvtHfee/6jSjBEDsY9I+AZrzlPTtR7vmW8xMJvdt
 xSDf8K8AKBZSAHnJPvq492kzaplEtG3ovvzYmMYwJR1dWZWZqa9HOer8lIFe+kRrys
 OZCCOiTuqDsU+08O9vTzeNqiyz9dQb3nEDzgBX7msKwPA5Qp1p5ssSgAAhJeC8++3g
 ug8uLvSk9qs/FJPAvIF7qML4u5U6E2SPBxiFy/lfTpccQ5DsRKNoEqG2z4sY9t4lB5
 pwFt2mFlNZcMg==
Message-ID: <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
Date: Thu, 9 Jul 2026 11:53:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260706122026.IJAiyhhw@linutronix.de>
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

Hello Sebastian,

The test results are available, mostly looks good except 1 spurious incomplete.

I tried reproducing it, but was unable to. It seems that pre-existing incompletes
on the specific IGT testcase already happened before the changes.

Do you want to review the patches you didn't author, so I can move forward?
Even if you are uncomfortable to review the signalers_lock changes, it should
be possible to have the rest reviewed and merged upstream.

Kind regards,
~Maarten Lankhorst

On 7/6/26 14:20, Sebastian Andrzej Siewior wrote:
> On 2026-07-06 13:48:16 [+0200], Maarten Lankhorst wrote:
>> All fixes to make the core i915 module (without display) working correctly on
>> PREEMPT_RT.
>>
>> Some fixes are still needed, as the selftests still fail. But otherwise the
>> test results were looking good on PREEMPT_RT.
>>
>> It looks like the patch that added a spinlock caused a regression on !PREEMPT_RT,
>> and may even have caused similar test failures on PREEMPT_RT, so to fix it
>> I removed RCU entirely, and converted to a locked implementation instead.
>>
>> This time at least, i915 live selftests pass on !PREEMPRT_RT for at least 1 machine
>> with same config as CI.
> 
> I saw the version counter overflowed and is at 4 here. I appreciate all
> the work. May I ask how are things?
>  
> Sebastian

