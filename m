Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F7CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4966910F4E8;
	Thu,  9 Jul 2026 11:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="ESASVCNH";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BACB10E6AA;
 Thu,  9 Jul 2026 11:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783594965;
 bh=Zz7/rasQV2uTEidthlwpJ9dCfB8OzVa/75a0tdy523c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ESASVCNHqliomNvNGTPUybU0wqXjQkrI607E+V1rMORsucYkKmF4+OtENgQHmt85N
 owuZnBvoZw+p4Fb03OWG4/xDk4Y8JW9LUPaJZkqbiCbLATn6GdugFZPbD6m+edZY7O
 77ZMDR3KqbYsfQuLsShgZ3AojLkWtMFCoZoMTyCHi5cyzvW05lYuQ6S6JwL/rTzwfn
 6fX01vMUDXRDPPxf0rH8oE2oAdfN7N29ILQOvpD8P3NwwfMaeUbHrjg6Cl9LYAsFPJ
 hOqXPlaoGlJm+B7WR0t5RuP4D+mqbxv0KAZdMq8k6qImrAhhTtKX2Guo8s913Ter0Q
 wDFlDF7mgsMgg==
Message-ID: <89f1eb47-44fb-41bf-bc4b-a3693125e0b2@lankhorst.se>
Date: Thu, 9 Jul 2026 13:03:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] drm/i915/gt: Fix selftests on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260706114823.752313-1-dev@lankhorst.se>
 <20260706114823.752313-5-dev@lankhorst.se>
 <20260709103650.VxAAiEnx@linutronix.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260709103650.VxAAiEnx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Correct, this should be in the commit message, let me update it.

On 7/9/26 12:36, Sebastian Andrzej Siewior wrote:
> On 2026-07-06 13:48:20 [+0200], Maarten Lankhorst wrote:
>> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
>> ---
>>  drivers/gpu/drm/i915/gt/selftest_engine_pm.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
>> index 10e556a7eac45..c1eff9edd8a5e 100644
>> --- a/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
>> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_pm.c
>> @@ -277,11 +277,11 @@ static int live_engine_busy_stats(void *arg)
>>  		st_engine_heartbeat_disable(engine);
>>  
>>  		ENGINE_TRACE(engine, "measuring idle time\n");
>> -		preempt_disable();
>> +		migrate_disable();
>>  		de = intel_engine_get_busy_time(engine, &t[0]);
> 
> this change has been made probably due to guc_engine_busyness(). Looking
> at execlists_engine_busyness() then there is a seqcount_t and the writer
> side does local_irq_disable() during the update so this should work.
> The comment says the writer is serialized but I don't see how (maybe
> there is just one). So…
> 
> Sebastian
Would the below look good?

The engine->busyness() callbacks called from the selftests are on PREEMPT_RT
not safe with preemption disabled, because all spinlocks are converted to
rt-mutexes.

This is also a problem for perf events, where we have to disable
the busyness events on PREEMPT_RT.

Previous attempts to fix this failed, so convert the selftest code to read
engine->busyness()  with migrate_disable() instead of preempt_disable() to
prevent selftest failures on PREEMPT_RT.

