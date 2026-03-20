Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA119108B901
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 11:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FD810EAC3;
	Fri, 20 Mar 2026 11:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="hO9pNdsk";
	dkim-atps=neutral
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com
 [91.218.175.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B0F210EAC3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 11:25:39 +0000 (UTC)
Message-ID: <0dd4b5ac-a9c4-4aff-a67a-ae43de10857e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1774005936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXQ/vYp6rCDQW4EhV/tYDmE/1pTk+r6ZdveQdIc7YLU=;
 b=hO9pNdskisE1/n235biSZGNG+brbHkO37EHqicP+P0Ut7HMvAKvILlgRLvyTV2YCnCU5kf
 HxQgNnYlFI0TKYr+ajPgXWEDeb7XSZAXBv/os2v0afkUIo/DmyoWHXc1D5JgYa0xe8VPLN
 98xtUeWnfvElBM7HTssIK2dOzesvoiI=
Date: Fri, 20 Mar 2026 12:25:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/sched: Add new KUnit test suite for concurrent job
 submission
To: Tvrtko Ursulin <tursulin@ursulin.net>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260219140711.3296237-1-marco.pagani@linux.dev>
 <e215efdd-c547-4ce4-affe-7198ed37c2a6@ursulin.net>
 <4793f2a5-9b08-4cd8-8e1e-d8a3a7125299@linux.dev>
 <3ac5825a-95e3-4b9a-aa7e-9b0107fa7b6b@ursulin.net>
 <7281dcf3-5c1a-47fa-81d1-ebf701d2cf81@linux.dev>
 <a9213f65-6747-417c-9b7b-7b2ed0a5c3d9@ursulin.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <a9213f65-6747-417c-9b7b-7b2ed0a5c3d9@ursulin.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
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



On 19/03/2026 09:50, Tvrtko Ursulin wrote:
> 
> 
> On 18/03/2026 17:23, Marco Pagani wrote:
> 
> 8><
> 
>>>>> Alternative approach could be to set a per test time budget and just
>>>>> keep the workers submitting until over. It would be simpler to
>>>>> understand and there would be more submit/complete overlap.
>>>>
>>>> I agree. Using a test time budget and having workers continuously
>>>> submit jobs until it expires would make better use of the test time.
>>>> I'm thinking that the simplest and most straightforward approach would
>>>> be to cyclically distribute periods among workers until they reach the
>>>> the largest possibile value below test duration, which would coincide
>>>> with the hyperperiod. This would also solve the issue of selecting a
>>>> suitable periods_cycle parameter that you mentioned earlier.
>>>> In practice, something like this:
>>>>
>>>> drm_sched_interleaved_params [...]
>>>> {
>>>>           .num_workers = N
>>>>           .test_max_time = T
>>>>           .job_base_period_us = P         /* Small GPU job, 100 us */
>>>> }
>>>>
>>>> period_us = job_base_period_us;
>>>> for (i = 0; i < params->num_workers; i++) {
>>>>           workers[i].period_us = period_us;
>>>>           period_us *= 2;
>>>>           if (period_us > test_max_time)
>>>>                   period_us = job_base_period_us;
>>>> }
>>>>
>>>>
>>>> What do you think?
>>>
>>>
>>> Again some time has passed so rather than going to re-read your patch I
>>> will go from memory. IIRC I was thinking something really dumb and 100%
>>> time bound with no need to think when coding and reviewing. Each thread
>>> simply does:
>>>
>>> ktime_t start = ktime_get();
>>>
>>> do {
>>>    .. thread doing its submission pattern thing ..
>>> } while (ktime_to_ms(ktime_sub(ktime_get(), start)) < test->time_ms);
>>>
>>> May miss the time target by a job period_us but who cares.
>>
>> Sorry for the delay. I got pulled into other things. I left out the worker
>> execution part since we already agreed on that. Instead, I've replied with
>> some pseudocode describing a new strategy for period assignments from test
>> parameters that takes into account your comments.
> 
> Sorry I misread when I saw test_max_time clamping I thought it was about 
> runtime control. I guess it makes sense to clamp it to avoid 
> over-shooting by too much. You removed the cyclical nature so I guess in 
> practice this will not happen? I mean number of workers vs base period 
> you don't expect more than one of them to get clamped?

I haven't removed the cyclical nature of workers submitting jobs. I
omitted that part because I thought we already agreed on it.

Anyway, I realized that unfortunately the strategy of using harmonic
periods to overlap submissions makes no sense given how the mock
scheduler serializes jobs into a single "execution" line. I'm now
thinking that using a narrower range of (multiple) submission periods
would be more effective to stress concurrent submissions.

I'm also thinking that splitting the single execution time budget into
equal shares among workers, and then computing the number of jobs that
fit into that share, is simpler and better suited for a test case
compared to a time-based approach. Let me share some pseudocode for
this new approach:

/* Parameters (test_duration must be larger than base_period)  */
drm_sched_interleaved_params [...]
{
        .num_workers = ...       /* 8 to 32 */
        .test_duration = ...     /* Few seconds */
        .base_period = ...       /* 100 us, small GPU job */
}

/* Setup phase common for all workers. */
workers_share = params->test_duration / params->num_workers;

/* Worker */
drm_sched_interleaved_worker()
{       
        period = (worker->id + 1) * base_period; 
        num_jobs = workers_share / period;

        for (i = 0; i < num_jobs; i++) {
                drm_mock_sched_job_set_duration_us(period);
                /* submit and wait for the job to complete */
        }	
}

What do you think?

Thanks,
Marco



