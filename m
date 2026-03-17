Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63898FED9EC
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:04:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CD110E5D9;
	Tue, 17 Mar 2026 17:04:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="jAbwNoKY";
	dkim-atps=neutral
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F141910E6FB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 17:04:15 +0000 (UTC)
Message-ID: <4793f2a5-9b08-4cd8-8e1e-d8a3a7125299@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1773767053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNkBblZhmOu/0QIYxqKCiet9FWXMcWfz8lWJ4icPfEU=;
 b=jAbwNoKYZCZtCfo8B+j8TLpscTGQDWVsfJeqCgyRBy8Im3TJuLujO4ED0WmlY5LjpmM6/y
 QtrmiOBmjVuDlxEHvuJkkasERSaEgofAbYALluZ9Q5ROx0TzOf2QINZl1NyenIVf2z3/yu
 J8R3smmGxRf/FOcyZ1bBPgAIKDHjeO8=
Date: Tue, 17 Mar 2026 18:04:07 +0100
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Marco Pagani <marco.pagani@linux.dev>
In-Reply-To: <e215efdd-c547-4ce4-affe-7198ed37c2a6@ursulin.net>
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



On 23/02/2026 17:25, Tvrtko Ursulin wrote:
> 
> On 19/02/2026 14:07, Marco Pagani wrote:
>> Add a new test suite to simulate concurrent job submissions to the DRM
>> scheduler. The suite includes two initial test cases: (i) a primary test
>> case for parallel job submission and (ii) a secondary test case for
>> interleaved job submission and completion. In the first test case, worker
>> threads concurrently submit jobs to the scheduler and then the timeline is
>> manually advanced. In the second test case, worker threads periodically
>> submit a sequence of jobs to the mock scheduler. Periods are chosen as
>> harmonic, starting from a base period, to allow interleaving between
>> submission and completion. To avoid impractically large execution times,
>> periods are cycled. The timeline is advanced automatically when the jobs
>> completes. This models how job submission from userspace (in process
>> context) may interleave with job completion (hrtimer callback interrupt
>> context, in the test case) by a physical device.
>>
>> Signed-off-by: Marco Pagani <marco.pagani@linux.dev>
>> ---
>> Changes in v1:
>> - Split the original suite into two test cases (Tvrtko Ursulin).
>> - General test refactoring and variable renaming for clarity.
>> - Changed parameters to have a fairer workload distribution.
>> - Improved cleanup logic.
>> - Added kunit_info() prints for tracing workers.
>> ---
>>   drivers/gpu/drm/scheduler/tests/tests_basic.c | 338 ++++++++++++++++++
>>   1 file changed, 338 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/scheduler/tests/tests_basic.c b/drivers/gpu/drm/scheduler/tests/tests_basic.c
>> index 82a41a456b0a..391edcbaf43a 100644
>> --- a/drivers/gpu/drm/scheduler/tests/tests_basic.c
>> +++ b/drivers/gpu/drm/scheduler/tests/tests_basic.c
>> @@ -2,6 +2,8 @@
>>   /* Copyright (c) 2025 Valve Corporation */
>>   
>>   #include <linux/delay.h>
>> +#include <linux/completion.h>
>> +#include <linux/workqueue.h>
>>   
>>   #include "sched_tests.h"
>>   
>> @@ -235,6 +237,341 @@ static void drm_sched_basic_cancel(struct kunit *test)
>>   	KUNIT_ASSERT_EQ(test, job->hw_fence.error, -ECANCELED);
>>   }
>>   
>> +struct sched_concurrent_context {
>> +	struct drm_mock_scheduler *sched;
>> +	struct workqueue_struct *sub_wq;
>> +	struct kunit *test;
>> +	struct completion wait_go;
>> +};
>> +
>> +KUNIT_DEFINE_ACTION_WRAPPER(drm_mock_sched_fini_wrap, drm_mock_sched_fini,
>> +			    struct drm_mock_scheduler *);
>> +
>> +KUNIT_DEFINE_ACTION_WRAPPER(drm_mock_sched_entity_free_wrap, drm_mock_sched_entity_free,
>> +			    struct drm_mock_sched_entity *);
>> +
>> +static void complete_destroy_workqueue(void *context)
>> +{
>> +	struct sched_concurrent_context *ctx = (struct sched_concurrent_context *)context;
>> +
>> +	complete_all(&ctx->wait_go);
>> +
>> +	destroy_workqueue(ctx->sub_wq);
>> +}
>> +
>> +static int drm_sched_concurrent_init(struct kunit *test)
>> +{
>> +	struct sched_concurrent_context *ctx;
>> +	int ret;
>> +
>> +	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
>> +
>> +	init_completion(&ctx->wait_go);
>> +
>> +	ctx->sched = drm_mock_sched_new(test, MAX_SCHEDULE_TIMEOUT);
>> +
>> +	ret = kunit_add_action_or_reset(test, drm_mock_sched_fini_wrap, ctx->sched);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	/* Use an unbounded workqueue to maximize job submission concurrency */
>> +	ctx->sub_wq = alloc_workqueue("drm-sched-submitters-wq", WQ_UNBOUND,
>> +				      WQ_UNBOUND_MAX_ACTIVE);
>> +	KUNIT_ASSERT_NOT_NULL(test, ctx->sub_wq);
>> +
>> +	ret = kunit_add_action_or_reset(test, complete_destroy_workqueue, ctx);
>> +	KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +	ctx->test = test;
>> +	test->priv = ctx;
>> +
>> +	return 0;
>> +}
>> +
>> +struct drm_sched_parallel_params {
>> +	const char *description;
>> +	unsigned int num_jobs;
>> +	unsigned int num_workers;
>> +};
>> +
>> +static const struct drm_sched_parallel_params drm_sched_parallel_cases[] = {
>> +	{
>> +		.description = "Workers submitting multiple jobs against a single entity",
> 
> Each worker has own entity so the description is a bit confusing.

Right, I'll change it "Multiple workers submitting multiple jobs from their entity"
as you suggested in the following email.

>> +		.num_jobs = 4,
>> +		.num_workers = 16,
>> +	},
>> +};
>> +
>> +static void
>> +drm_sched_parallel_desc(const struct drm_sched_parallel_params *params, char *desc)
>> +{
>> +	strscpy(desc, params->description, KUNIT_PARAM_DESC_SIZE);
>> +}
>> +
>> +KUNIT_ARRAY_PARAM(drm_sched_parallel, drm_sched_parallel_cases, drm_sched_parallel_desc);
>> +
>> +struct parallel_worker {
>> +	struct work_struct work;
>> +	struct sched_concurrent_context *ctx;
>> +	struct drm_mock_sched_entity *entity;
>> +	struct drm_mock_sched_job **jobs;
>> +	unsigned int id;
>> +};
>> +
>> +static void drm_sched_parallel_worker(struct work_struct *work)
>> +{
>> +	const struct drm_sched_parallel_params *params;
>> +	struct sched_concurrent_context *test_ctx;
>> +	struct parallel_worker *worker;
>> +	unsigned int i;
>> +
>> +	worker = container_of(work, struct parallel_worker, work);
>> +	test_ctx = worker->ctx;
>> +	params = test_ctx->test->param_value;
>> +
>> +	wait_for_completion(&test_ctx->wait_go);
>> +
>> +	kunit_info(test_ctx->test, "Parallel worker %u started\n", worker->id);
>> +
>> +	for (i = 0; i < params->num_jobs; i++)
>> +		drm_mock_sched_job_submit(worker->jobs[i]);
>> +}
>> +
>> +/*
>> + * Spawns workers that submit a sequence of jobs to the mock scheduler.
>> + * Once all jobs are submitted, the timeline is manually advanced.
>> + */
>> +static void drm_sched_parallel_submit_test(struct kunit *test)
>> +{
>> +	struct sched_concurrent_context *ctx = test->priv;
>> +	const struct drm_sched_parallel_params *params = test->param_value;
>> +	struct parallel_worker *workers;
>> +	unsigned int i, j, completed_jobs;
>> +	bool done;
>> +	int ret;
>> +
>> +	workers = kunit_kcalloc(test, params->num_workers, sizeof(*workers),
>> +				GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, workers);
>> +
>> +	/*
>> +	 * Init workers only after all jobs and entities have been successfully
>> +	 * allocated. In this way, the cleanup logic for when an assertion fail
>> +	 * can be simplified.
>> +	 */
>> +	for (i = 0; i < params->num_workers; i++) {
>> +		workers[i].id = i;
>> +		workers[i].ctx = ctx;
>> +		workers[i].entity = drm_mock_sched_entity_new(test,
>> +							      DRM_SCHED_PRIORITY_NORMAL,
>> +							      ctx->sched);
>> +
>> +		ret = kunit_add_action_or_reset(test, drm_mock_sched_entity_free_wrap,
>> +						workers[i].entity);
>> +		KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +		workers[i].jobs = kunit_kcalloc(test, params->num_jobs,
>> +						sizeof(*workers[i].jobs), GFP_KERNEL);
>> +		KUNIT_ASSERT_NOT_NULL(test, workers[i].jobs);
>> +
>> +		for (j = 0; j < params->num_jobs; j++)
>> +			workers[i].jobs[j] = drm_mock_sched_job_new(test,
>> +								    workers[i].entity);
>> +	}
>> +
>> +	for (i = 0; i < params->num_workers; i++) {
>> +		INIT_WORK(&workers[i].work, drm_sched_parallel_worker);
>> +		queue_work(ctx->sub_wq, &workers[i].work);
>> +	}
>> +
>> +	complete_all(&ctx->wait_go);
>> +	flush_workqueue(ctx->sub_wq);
>> +
>> +	for (i = 0; i < params->num_workers; i++) {
>> +		for (j = 0; j < params->num_jobs; j++) {
>> +			done = drm_mock_sched_job_wait_scheduled(workers[i].jobs[j],
>> +								 HZ);
>> +			KUNIT_ASSERT_TRUE(test, done);
>> +
>> +			done = drm_mock_sched_job_is_finished(workers[i].jobs[j]);
>> +			KUNIT_ASSERT_FALSE(test, done);
> 
> This second assert does not seem to be bringing much value, but instead 
> makes the reader ask themselves why it is there. Remove it?
> 
> Hmm in fact this whole loop could be removed. All that it is needed 
> below is to wait for the last job to be completed.

I'll reply to this in the following mail since Philip joined the conversation.
 
>> +		}
>> +	}
>> +
>> +	completed_jobs = drm_mock_sched_advance(ctx->sched,
>> +						params->num_workers * params->num_jobs);
>> +	KUNIT_ASSERT_EQ(test, completed_jobs, params->num_workers * params->num_jobs);
>> +
>> +	for (i = 0; i < params->num_workers; i++) {
>> +		for (j = 0; j < params->num_jobs; j++) {
>> +			done = drm_mock_sched_job_is_finished(workers[i].jobs[j]);
>> +			KUNIT_ASSERT_TRUE(test, done);
>> +		}
>> +	}
> 
> So here, after advancing you just need to wait on the last job to complete.
> 
> Not a deal breaker to have it verbose but usually the less is better and 
> easier to spot the key thing being tested and what are the functional steps.
> 
>> +}
>> +
>> +struct drm_sched_interleaved_params {
>> +	const char *description;
>> +	unsigned int job_base_period_us;
>> +	unsigned int periods_cycle;
>> +	unsigned int num_jobs;
>> +	unsigned int num_workers;
>> +};
>> +
>> +static const struct drm_sched_interleaved_params drm_sched_interleaved_cases[] = {
>> +	{
>> +		.description = "Workers submitting single jobs against a single entity",
> 
> As with the parallel description.

Agreed.
 
>> +		.job_base_period_us = 100,
>> +		.periods_cycle = 10,
>> +		.num_jobs = 1,
>> +		.num_workers = 32,
>> +	},
>> +	{
>> +		.description = "Workers submitting multiple jobs against a single entity",
>> +		.job_base_period_us = 100,
>> +		.periods_cycle = 10,
>> +		.num_jobs = 4,
>> +		.num_workers = 16,
>> +	},
>> +};
>> +
>> +static void
>> +drm_sched_interleaved_desc(const struct drm_sched_interleaved_params *params, char *desc)
>> +{
>> +	strscpy(desc, params->description, KUNIT_PARAM_DESC_SIZE);
>> +}
>> +
>> +KUNIT_ARRAY_PARAM(drm_sched_interleaved, drm_sched_interleaved_cases,
>> +		  drm_sched_interleaved_desc);
>> +
>> +struct interleaved_worker {
>> +	struct work_struct work;
>> +	struct sched_concurrent_context *ctx;
>> +	struct drm_mock_sched_entity *entity;
>> +	struct drm_mock_sched_job **jobs;
>> +	unsigned int id;
>> +	unsigned int period_us;
>> +	unsigned int timeout_us;
>> +};
>> +
>> +static void drm_sched_interleaved_worker(struct work_struct *work)
>> +{
>> +	const struct drm_sched_interleaved_params *params;
>> +	struct sched_concurrent_context *test_ctx;
>> +	struct interleaved_worker *worker;
>> +	unsigned int i;
>> +	bool done;
>> +
>> +	worker = container_of(work, struct interleaved_worker, work);
>> +	test_ctx = worker->ctx;
>> +	params = test_ctx->test->param_value;
>> +
>> +	wait_for_completion(&test_ctx->wait_go);
>> +
>> +	kunit_info(test_ctx->test, "Interleaved worker %u with period %u us started\n",
>> +		   worker->id, worker->period_us);
>> +
>> +	/* Release jobs as a periodic sequence */
>> +	for (i = 0; i < params->num_jobs; i++) {
>> +		drm_mock_sched_job_set_duration_us(worker->jobs[i], worker->period_us);
>> +		drm_mock_sched_job_submit(worker->jobs[i]);
>> +
>> +		done = drm_mock_sched_job_wait_finished(worker->jobs[i],
>> +							usecs_to_jiffies(worker->timeout_us));
>> +		if (!done)
>> +			kunit_info(test_ctx->test, "Job %u of worker %u timedout\n",
>> +				   i, worker->id);
>> +	}
>> +}
>> +
>> +/*
>> + * Spawns workers that submit a periodic sequence of jobs to the mock scheduler.
>> + * Uses harmonic periods to allow interleaving and cycles through them to prevent
>> + * excessively large execution times. Since the scheduler serializes jobs from all
>> + * workers, the timeout is set to the hyperperiod with a 2x safety factor. Entities
>> + * and jobs are pre-allocated in the main thread to avoid using KUnit assertions in
>> + * the workers.
>> + */
>> +static void drm_sched_interleaved_submit_test(struct kunit *test)
>> +{
>> +	struct sched_concurrent_context *ctx = test->priv;
>> +	const struct drm_sched_interleaved_params *params = test->param_value;
>> +	struct interleaved_worker *workers;
>> +	unsigned int period_max_us, timeout_us;
>> +	unsigned int i, j;
>> +	bool done;
>> +	int ret;
>> +
>> +	workers = kunit_kcalloc(test, params->num_workers, sizeof(*workers),
>> +				GFP_KERNEL);
>> +	KUNIT_ASSERT_NOT_NULL(test, workers);
>> +
>> +	period_max_us = params->job_base_period_us * (1 << params->periods_cycle);
>> +	timeout_us = params->num_workers * period_max_us * 2;
>> +
>> +	/*
>> +	 * Init workers only after all jobs and entities have been successfully
>> +	 * allocated. In this way, the cleanup logic for when an assertion fail
>> +	 * can be simplified.
>> +	 */
>> +	for (i = 0; i < params->num_workers; i++) {
>> +		workers[i].id = i;
>> +		workers[i].ctx = ctx;
>> +		workers[i].timeout_us = timeout_us;
>> +
>> +		if (i % params->periods_cycle == 0)
>> +			workers[i].period_us = params->job_base_period_us;
>> +		else
>> +			workers[i].period_us = workers[i - 1].period_us * 2;
> 
> Are the two if statements effectively equivalent to:
> 
>   period_us = params->job_base_period_us << (i % params->periods_cycle);
> 
> ?

Yes. Actually, I was very undecided between using the closed form and the
iterative form. In the end, I went with the iterative one because I thought
it would be easier to understand and maintain, and this code is not
performance-critical. However, I don't have a strong opinion on this.
Either way works for me.

> Also, do you have an idea how to locally calculate a suitable 
> periods_cycle instead of having to come up with a number in the 
> drm_sched_interleaved_params array. Just strikes me as hard to know what 
> to put in there if someone would want to add a test.

Please see below.
 
>> +
>> +		workers[i].entity = drm_mock_sched_entity_new(test,
>> +							      DRM_SCHED_PRIORITY_NORMAL,
>> +							      ctx->sched);
>> +
>> +		ret = kunit_add_action_or_reset(test, drm_mock_sched_entity_free_wrap,
>> +						workers[i].entity);
>> +		KUNIT_ASSERT_EQ(test, ret, 0);
>> +
>> +		workers[i].jobs = kunit_kcalloc(test, params->num_jobs,
>> +						sizeof(*workers[i].jobs), GFP_KERNEL);
>> +		KUNIT_ASSERT_NOT_NULL(test, workers[i].jobs);
>> +
>> +		for (j = 0; j < params->num_jobs; j++) {
>> +			workers[i].jobs[j] = drm_mock_sched_job_new(test,
>> +								    workers[i].entity);
>> +			done = drm_mock_sched_job_is_finished(workers[i].jobs[j]);
>> +			KUNIT_ASSERT_FALSE(test, done);
> 
> Same as above, this is asserted by a basic test case so I'd just remove it.
> 
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < params->num_workers; i++) {
>> +		INIT_WORK(&workers[i].work, drm_sched_interleaved_worker);
>> +		queue_work(ctx->sub_wq, &workers[i].work);
>> +	}
>> +
>> +	complete_all(&ctx->wait_go);
>> +	flush_workqueue(ctx->sub_wq);
>> +
>> +	for (i = 0; i < params->num_workers; i++) {
>> +		for (j = 0; j < params->num_jobs; j++) {
>> +			done = drm_mock_sched_job_is_finished(workers[i].jobs[j]);
>> +			KUNIT_ASSERT_TRUE(test, done);
>> +		}
>> +	}
> 
> Here as well you could wait just for the last job per worker.
> 
> On the overal submission pattern - Don't you end up with a very uneven 
> activity between the workers? Because the job duration is doubling and 
> workers are single-shot, once the low index workers are done they are 
> done, and all that remains are the higher ones, and so the wave of fewer 
> and fewer active workers continues. Low index worker do not end up 
> racing with the job completions of the high index workers but only 
> between themselves, and even that with the cycle=10 workers=16 case is 
> even more limited.

Good point.

> Alternative approach could be to set a per test time budget and just 
> keep the workers submitting until over. It would be simpler to 
> understand and there would be more submit/complete overlap.

I agree. Using a test time budget and having workers continuously
submit jobs until it expires would make better use of the test time.
I'm thinking that the simplest and most straightforward approach would
be to cyclically distribute periods among workers until they reach the
the largest possibile value below test duration, which would coincide
with the hyperperiod. This would also solve the issue of selecting a
suitable periods_cycle parameter that you mentioned earlier.
In practice, something like this:

drm_sched_interleaved_params [...]
{
        .num_workers = N
        .test_max_time = T
        .job_base_period_us = P         /* Small GPU job, 100 us */
}

period_us = job_base_period_us;
for (i = 0; i < params->num_workers; i++) {
        workers[i].period_us = period_us;        
        period_us *= 2;
        if (period_us > test_max_time)
                period_us = job_base_period_us;
}


What do you think?

Thanks,
Marco
