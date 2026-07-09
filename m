Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD797C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:36:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C4010F50B;
	Thu,  9 Jul 2026 11:36:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="MjzX/KKk";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156EF10F509;
 Thu,  9 Jul 2026 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783596972;
 bh=j4+z7f5vbuz2wqPcUwSFKi5xweL3dHMSJMt9QQCDbzc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MjzX/KKkbjfUKn072h7zpDyN8yfWVfjPI/YOQ8OB4hGnlqDw01zeNwWqwLjHgPrsV
 npXjLdNWO566z+XGzuNAPuE7nZ/BXHp8oAB6i0xy69SRdV6n2v/PovhgiWPTUUfSZP
 OHh9ypGYZJeEE+alJWZsIRgpN6+C14ix5PZ2scqvQQXX4Uaz6BpVjTgtBWBVTTCiN5
 f49RneRdgRlLyW2BVfYOPIg2aJTmK5dEo0oA10L61pa5ayb2TJs6cIcsACCGQ2iBtF
 4bWdOXKaJYBTjzNC9Pbs9FvzwcuLxfIwPc9GwLkMtWjSu83m1Xf0kUB7q81iBygTB+
 ZyZhnjxwfat8g==
Message-ID: <a6c056ba-0847-4d2c-a7bd-39ac27eb15d5@lankhorst.se>
Date: Thu, 9 Jul 2026 13:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706122026.IJAiyhhw@linutronix.de>
 <c4222f81-72b2-4eea-a900-da327f0df928@lankhorst.se>
 <20260709110200.2_5Eg8xF@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260709110200.2_5Eg8xF@linutronix.de>
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

On 7/9/26 13:02, Sebastian Andrzej Siewior wrote:
> On 2026-07-09 11:53:52 [+0200], Maarten Lankhorst wrote:
>> Hello Sebastian,
> Hi Maarten,
> 
>> The test results are available, mostly looks good except 1 spurious incomplete.
>>
>> I tried reproducing it, but was unable to. It seems that pre-existing incompletes
>> on the specific IGT testcase already happened before the changes.
>>
>> Do you want to review the patches you didn't author, so I can move forward?
>> Even if you are uncomfortable to review the signalers_lock changes, it should
>> be possible to have the rest reviewed and merged upstream.
> 
> This looks good to me. The condition in 5/7 is the as in 3/7. Not sure
> if this should be merged into a helper or if it should be passed from
> the caller. But it seems the information of the calling context is lost.
> 
> Please move forward ;)

Yeah the problem was similar, I believe neither check should exist,
instead the caller should give this information like the comment mentions.

It's best not to try to change i915 too much though, I can try without both
3/7 and 5/7 now that the plan is to disable some problematic perf events and
not run selftests in various conditions that should no longer happen.

Kind regards,
~Maarten Lankhorst
