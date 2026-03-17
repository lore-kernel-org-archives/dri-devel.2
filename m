Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E85FED9F8
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BF310E068;
	Tue, 17 Mar 2026 17:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="XWI70B3i";
	dkim-atps=neutral
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D2ED10E068
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:27:41 +0000 (UTC)
Message-ID: <8075c105-c7a1-4223-bf67-aa7f0c1b6f76@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1773768459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEUVrIe1WvC7kxazRgiFJn+y6LPhde6wBwXAiDK8aXM=;
 b=XWI70B3i1CT1LDB540BSz86c4rNQ8TVLPX+RUSz/FFBDl1yT6YCeR5WOgfRMopU8HXn7JO
 bR40/zUtYsV9PYC/GQ+I0imXLz4cKwe0cOWEsxQehVFf3s4CeyPGkTRO4fWbjr/diyKy9n
 Vsk6KIwrM5VsXZvyBlpxLy7RYr5JSAk=
Date: Tue, 17 Mar 2026 18:27:26 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/sched: Add new KUnit test suite for concurrent job
 submission
To: Tvrtko Ursulin <tursulin@ursulin.net>, phasta@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260219140711.3296237-1-marco.pagani@linux.dev>
 <e215efdd-c547-4ce4-affe-7198ed37c2a6@ursulin.net>
 <f5c76fe9d70f106f58b9f06f644534c2cead96fd.camel@mailbox.org>
 <62024790-d792-4789-9452-f5b294969a9a@ursulin.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <62024790-d792-4789-9452-f5b294969a9a@ursulin.net>
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



On 25/02/2026 10:03, Tvrtko Ursulin wrote:
> 
> On 25/02/2026 07:47, Philipp Stanner wrote:
>> On Mon, 2026-02-23 at 16:25 +0000, Tvrtko Ursulin wrote:
>>>
>>> On 19/02/2026 14:07, Marco Pagani wrote:
>>>> Add a new test suite to simulate concurrent job submissions to the DRM
>>>> scheduler. The suite includes two initial test cases: (i) a primary test
>>>> case for parallel job submission and (ii) a secondary test case for
>>>> interleaved job submission and completion. In the first test case, worker
>>>> threads concurrently submit jobs to the scheduler and then the timeline is
>>>> manually advanced. In the second test case, worker threads periodically
>>>> submit a sequence of jobs to the mock scheduler. Periods are chosen as
>>>> harmonic, starting from a base period, to allow interleaving between
>>>> submission and completion. To avoid impractically large execution times,
>>>> periods are cycled. The timeline is advanced automatically when the jobs
>>>> completes. This models how job submission from userspace (in process
>>>> context) may interleave with job completion (hrtimer callback interrupt
>>>> context, in the test case) by a physical device.
>>
>> I still maintain the opinion expressed the last time: that the commit
>> message should make explicit why the patch / test is added. Which this
>> doesn't do. It just says: "We add X", but not "Currently, the problem
>> is that YZ, thus we need X".
>> (also breaking longer commit messages into paragraphs is nice)
>>
>> Also see my comments about interleaved submits below.
> 
> I'll address the ones addressed to me.
> 
> 8><
> 
>>>> +struct drm_sched_parallel_params {
>>>> +	const char *description;
>>>> +	unsigned int num_jobs;
>>>> +	unsigned int num_workers;
>>>> +};
>>>> +
>>>> +static const struct drm_sched_parallel_params drm_sched_parallel_cases[] = {
>>>> +	{
>>>> +		.description = "Workers submitting multiple jobs against a single entity",
>>>
>>> Each worker has own entity so the description is a bit confusing.
>>
>> Do you have a suggestion for a better one?
> 
> Along the lines of:
> 
> "Multiple workers submitting multiple jobs from their entity"
> 
> 8><
> 
>>>> +	}
>>>> +
>>>> +	for (i = 0; i < params->num_workers; i++) {
>>>> +		INIT_WORK(&workers[i].work, drm_sched_parallel_worker);
>>>> +		queue_work(ctx->sub_wq, &workers[i].work);
>>>> +	}
>>>> +
>>>> +	complete_all(&ctx->wait_go);
>>>> +	flush_workqueue(ctx->sub_wq);
>>>> +
>>>> +	for (i = 0; i < params->num_workers; i++) {
>>>> +		for (j = 0; j < params->num_jobs; j++) {
>>>> +			done = drm_mock_sched_job_wait_scheduled(workers[i].jobs[j],
>>>> +								 HZ);
>>
>> same
>>
>>>> +			KUNIT_ASSERT_TRUE(test, done);
>>>> +
>>>> +			done = drm_mock_sched_job_is_finished(workers[i].jobs[j]);
>>>> +			KUNIT_ASSERT_FALSE(test, done);
>>>
>>> This second assert does not seem to be bringing much value, but instead
>>> makes the reader ask themselves why it is there. Remove it?
>>>
>>> Hmm in fact this whole loop could be removed. All that it is needed
>>> below is to wait for the last job to be completed.
>>
>> I suppose it's being tested whether all jobs are finished. That sounds
>> clean and not harmful to me.
> 
> No, it is assert false. It is testing the jobs have been scheduled but 
> not completed before the timeline is manually advanced. Both those 
> behaviours are already covered by the existing basic test cases.
> 
> In my view the general best practice is to focus on the thing being 
> tested, which in this case is the submission side of things. The rest 
> can just distract the reader. And in this case that is parallel 
> submission, which is all done and dusted by the time flush_workqueue 
> above finishes. Everything after that point is just test cleanup.

I see what you mean. By that point, concurrent submission is complete, so it
may be considered outside the scope of this test. However, my intent was to
check that the basic behaviour of the scheduler also holds after the concurrent
submissions of multiple jobs, which is not covered by the basic test case.
That said, I'm open to removing those asserts if you and Philipp believe
they are redundant.

Thanks,
Marco
