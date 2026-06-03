Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E78ECD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:13:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60A5210F9E4;
	Wed,  3 Jun 2026 08:13:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="s7z5E/kb";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F4CD10F9E4
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 08:13:40 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gVgSd3yYtz9vGg;
 Wed,  3 Jun 2026 10:13:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1780474417; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jicCzYPrLRpeExbigfDchv+w8kzKYpz/+T1cq4aySbE=;
 b=s7z5E/kbWh6IHMvZZNZbfEIt3jY2Y5xa+EAX1Kbdq2pYQLnEd6vut7nVkFsEp/mxQAME0y
 nAgukiLzA2OSxNJlBW1VAi27+iP0ZOewJ7i27N3LKdVCB8l9PBPzx5nzFjCvxlEPtcGsfP
 T/la5DZcnwIp8kN7X0hhYofCEiaSROssrBY2fNsHhXiCBuykFKDgW5OCylUL7guSUs5kDo
 hRjMW/wJnr1vNPBUrSfU8G9u/Aq2/b8Pt5l0OaXQnzoJK3fPxqtVHRN2KvrTb7LGj6qPS0
 H/JN8zBdavXjUIdUHuFV22Ek+jIzOO53Xon56xVPklGv6yDU2v6Nu2NF/6/rRg==
Message-ID: <612201f3278817a2b3b22790d6881bd49347b97d.camel@mailbox.org>
Subject: Re: [PATCH v4] drm/sched: Add test suite for concurrent job
 submissions
From: Philipp Stanner <phasta@mailbox.org>
To: Marco Pagani <marco.pagani@linux.dev>, Tvrtko Ursulin
 <tursulin@ursulin.net>,  Matthew Brost <matthew.brost@intel.com>, Danilo
 Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Christian =?ISO-8859-1?Q?K=F6nig?=	 <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst	 <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>,  Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Wed, 03 Jun 2026 10:13:30 +0200
In-Reply-To: <20260520093350.1036001-1-marco.pagani@linux.dev>
References: <20260520093350.1036001-1-marco.pagani@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: w4ia3wfz9g97rt6jgmkrzjmp8h9bg7j9
X-MBO-RS-ID: d2dc8b86bc1651a7b91
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-05-20 at 11:33 +0200, Marco Pagani wrote:
> Add a new test suite to simulate concurrent job submissions to the DRM
> scheduler, as this functionality is not covered by current test suites.
>=20
> The new test suite includes two initial test cases: (i) a test case for
> parallel job submission and (ii) a test case for interleaved job
> submission and completion. In the first test case, worker threads
> concurrently submit jobs to the scheduler, and then the timeline is
> manually advanced to complete them in bulk. In the second test case,
> worker threads concurrently submit sequences of jobs of different
> durations to the mock scheduler using a sliding window to better model
> real-world workloads. The timeline is advanced automatically by the
> finishing jobs, interleaving submission with completion.
>=20
> Signed-off-by: Marco Pagani <marco.pagani@linux.dev>

Pushed to drm-misc-next

Thanks for the contribution and your endurance, Marco

Regards
Philipp

> ---
> Changes in v4:
> - Changed teardown order to prevent a use-after-free (reported by Philipp=
)
> ---
> =C2=A0drivers/gpu/drm/scheduler/tests/tests_basic.c | 359 +++++++++++++++=
+++
> =C2=A01 file changed, 359 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/tests/tests_basic.c b/drivers/gpu/=
drm/scheduler/tests/tests_basic.c
> index a5a5a35a87b0..da5c4952780f 100644
> --- a/drivers/gpu/drm/scheduler/tests/tests_basic.c
> +++ b/drivers/gpu/drm/scheduler/tests/tests_basic.c
> @@ -1,7 +1,11 @@
> =C2=A0// SPDX-License-Identifier: GPL-2.0
> =C2=A0/* Copyright (c) 2025 Valve Corporation */
> =C2=A0
> +#include <linux/completion.h>
> =C2=A0#include <linux/delay.h>
> +#include <linux/minmax.h>
> +#include <linux/time.h>
> +#include <linux/workqueue.h>
> =C2=A0
> =C2=A0#include "sched_tests.h"
> =C2=A0
> @@ -235,6 +239,360 @@ static void drm_sched_basic_cancel(struct kunit *te=
st)
> =C2=A0	KUNIT_ASSERT_EQ(test, job->hw_fence.error, -ECANCELED);
> =C2=A0}
> =C2=A0
> +struct sched_concurrent_context {
> +	struct drm_mock_scheduler *sched;
> +	struct workqueue_struct *sub_wq;
> +	struct kunit *test;
> +	struct completion wait_go;
> +};
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(drm_mock_sched_fini_wrap, drm_mock_sched_fin=
i,
> +			=C2=A0=C2=A0=C2=A0 struct drm_mock_scheduler *);
> +
> +KUNIT_DEFINE_ACTION_WRAPPER(drm_mock_sched_entity_free_wrap, drm_mock_sc=
hed_entity_free,
> +			=C2=A0=C2=A0=C2=A0 struct drm_mock_sched_entity *);
> +
> +static void complete_destroy_workqueue(void *context)
> +{
> +	struct sched_concurrent_context *ctx =3D context;
> +
> +	complete_all(&ctx->wait_go);
> +
> +	destroy_workqueue(ctx->sub_wq);
> +}
> +
> +static int drm_sched_concurrent_init(struct kunit *test)
> +{
> +	struct sched_concurrent_context *ctx;
> +	int ret;
> +
> +	ctx =3D kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx);
> +
> +	init_completion(&ctx->wait_go);
> +
> +	ctx->sched =3D drm_mock_sched_new(test, MAX_SCHEDULE_TIMEOUT);
> +
> +	ret =3D kunit_add_action_or_reset(test, drm_mock_sched_fini_wrap, ctx->=
sched);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	/* Use an unbounded workqueue to maximize job submission concurrency */
> +	ctx->sub_wq =3D alloc_workqueue("drm-sched-submitters-wq", WQ_UNBOUND,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WQ_UNBOUND_MAX_ACTIVE);
> +	KUNIT_ASSERT_NOT_NULL(test, ctx->sub_wq);
> +
> +	ret =3D kunit_add_action_or_reset(test, complete_destroy_workqueue, ctx=
);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ctx->test =3D test;
> +	test->priv =3D ctx;
> +
> +	return 0;
> +}
> +
> +struct drm_sched_parallel_params {
> +	const char *description;
> +	unsigned int num_jobs;
> +	unsigned int num_workers;
> +};
> +
> +static const struct drm_sched_parallel_params drm_sched_parallel_cases[]=
 =3D {
> +	{
> +		.description =3D "Parallel submission of multiple jobs per worker",
> +		.num_jobs =3D 8,
> +		.num_workers =3D 16,
> +	},
> +};
> +
> +static void
> +drm_sched_parallel_desc(const struct drm_sched_parallel_params *params, =
char *desc)
> +{
> +	strscpy(desc, params->description, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +KUNIT_ARRAY_PARAM(drm_sched_parallel, drm_sched_parallel_cases, drm_sche=
d_parallel_desc);
> +
> +struct parallel_worker {
> +	struct work_struct work;
> +	struct sched_concurrent_context *ctx;
> +	struct drm_mock_sched_entity *entity;
> +	struct drm_mock_sched_job **jobs;
> +	unsigned int id;
> +};
> +
> +static void drm_sched_parallel_worker(struct work_struct *work)
> +{
> +	const struct drm_sched_parallel_params *params;
> +	struct sched_concurrent_context *test_ctx;
> +	struct parallel_worker *worker;
> +	unsigned int i;
> +
> +	worker =3D container_of(work, struct parallel_worker, work);
> +	test_ctx =3D worker->ctx;
> +	params =3D test_ctx->test->param_value;
> +
> +	wait_for_completion(&test_ctx->wait_go);
> +
> +	kunit_info(test_ctx->test, "Parallel worker %u submitting %u jobs start=
ed\n",
> +		=C2=A0=C2=A0 worker->id, params->num_jobs);
> +
> +	for (i =3D 0; i < params->num_jobs; i++)
> +		drm_mock_sched_job_submit(worker->jobs[i]);
> +}
> +
> +/*
> + * Spawns workers that submit a sequence of jobs to the mock scheduler.
> + * Once all jobs are submitted, the timeline is manually advanced.
> + */
> +static void drm_sched_parallel_submit_test(struct kunit *test)
> +{
> +	struct sched_concurrent_context *ctx =3D test->priv;
> +	const struct drm_sched_parallel_params *params =3D test->param_value;
> +	struct parallel_worker *workers, *worker;
> +	struct drm_mock_sched_job *job;
> +	unsigned int i, j, completed_jobs, total_jobs;
> +	bool done;
> +	int ret;
> +
> +	KUNIT_ASSERT_GT(test, params->num_workers, 0);
> +	KUNIT_ASSERT_GT(test, params->num_jobs, 0);
> +
> +	workers =3D kunit_kcalloc(test, params->num_workers, sizeof(*workers),
> +				GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, workers);
> +
> +	/*
> +	 * Init workers only after all jobs and entities have been successfully
> +	 * allocated. In this way, the cleanup logic for when an assertion fail
> +	 * can be simplified.
> +	 */
> +	for (i =3D 0; i < params->num_workers; i++) {
> +		worker =3D &workers[i];
> +		worker->id =3D i;
> +		worker->ctx =3D ctx;
> +		worker->entity =3D drm_mock_sched_entity_new(test,
> +							=C2=A0=C2=A0 DRM_SCHED_PRIORITY_NORMAL,
> +							=C2=A0=C2=A0 ctx->sched);
> +
> +		worker->jobs =3D kunit_kcalloc(test, params->num_jobs,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*worker->jobs), GFP_KERNEL);
> +		KUNIT_ASSERT_NOT_NULL(test, worker->jobs);
> +
> +		for (j =3D 0; j < params->num_jobs; j++) {
> +			job =3D drm_mock_sched_job_new(test, worker->entity);
> +			worker->jobs[j] =3D job;
> +		}
> +
> +		ret =3D kunit_add_action_or_reset(test, drm_mock_sched_entity_free_wra=
p,
> +						worker->entity);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +	}
> +
> +	for (i =3D 0; i < params->num_workers; i++) {
> +		worker =3D &workers[i];
> +		INIT_WORK(&worker->work, drm_sched_parallel_worker);
> +		queue_work(ctx->sub_wq, &worker->work);
> +	}
> +
> +	complete_all(&ctx->wait_go);
> +	flush_workqueue(ctx->sub_wq);
> +
> +	for (i =3D 0; i < params->num_workers; i++) {
> +		worker =3D &workers[i];
> +		for (j =3D 0; j < params->num_jobs; j++) {
> +			job =3D worker->jobs[j];
> +			done =3D drm_mock_sched_job_wait_scheduled(job, HZ);
> +			KUNIT_EXPECT_TRUE(test, done);
> +		}
> +	}
> +
> +	total_jobs =3D params->num_workers * params->num_jobs;
> +	completed_jobs =3D drm_mock_sched_advance(ctx->sched, total_jobs);
> +	KUNIT_EXPECT_EQ(test, completed_jobs, total_jobs);
> +
> +	for (i =3D 0; i < params->num_workers; i++) {
> +		worker =3D &workers[i];
> +		for (j =3D 0; j < params->num_jobs; j++) {
> +			job =3D worker->jobs[j];
> +			done =3D drm_mock_sched_job_wait_finished(job, HZ);
> +			KUNIT_EXPECT_TRUE(test, done);
> +		}
> +	}
> +}
> +
> +struct drm_sched_interleaved_params {
> +	const char *description;
> +	unsigned int test_duration_ms;
> +	unsigned int job_base_duration_us;
> +	unsigned int num_workers;
> +	unsigned int num_in_flight_jobs;
> +};
> +
> +static const struct drm_sched_interleaved_params drm_sched_interleaved_c=
ases[] =3D {
> +	{
> +		.description =3D "Interleaved submission of multiple jobs per worker",
> +		.test_duration_ms =3D 1000,
> +		.job_base_duration_us =3D 100,
> +		.num_workers =3D 16,
> +		.num_in_flight_jobs =3D 8,
> +	},
> +};
> +
> +static void
> +drm_sched_interleaved_desc(const struct drm_sched_interleaved_params *pa=
rams, char *desc)
> +{
> +	strscpy(desc, params->description, KUNIT_PARAM_DESC_SIZE);
> +}
> +
> +KUNIT_ARRAY_PARAM(drm_sched_interleaved, drm_sched_interleaved_cases,
> +		=C2=A0 drm_sched_interleaved_desc);
> +
> +struct interleaved_worker {
> +	struct work_struct work;
> +	struct sched_concurrent_context *ctx;
> +	struct drm_mock_sched_entity *entity;
> +	struct drm_mock_sched_job **jobs;
> +	unsigned int id;
> +	unsigned int job_count;
> +	unsigned int job_duration_us;
> +};
> +
> +static void drm_sched_interleaved_worker(struct work_struct *work)
> +{
> +	struct sched_concurrent_context *test_ctx;
> +	const struct drm_sched_interleaved_params *params;
> +	struct interleaved_worker *worker;
> +	unsigned int i, j, max_in_flight_job;
> +	unsigned long timeout;
> +	bool done;
> +
> +	worker =3D container_of(work, struct interleaved_worker, work);
> +	test_ctx =3D worker->ctx;
> +	params =3D test_ctx->test->param_value;
> +
> +	wait_for_completion(&test_ctx->wait_go);
> +
> +	kunit_info(test_ctx->test, "Worker %u submitting %u jobs of %u us start=
ed\n",
> +		=C2=A0=C2=A0 worker->id, worker->job_count, worker->job_duration_us);
> +
> +	timeout =3D msecs_to_jiffies(params->test_duration_ms * 2);
> +
> +	/* Fill the submission window */
> +	max_in_flight_job =3D min(worker->job_count, params->num_in_flight_jobs=
);
> +	for (i =3D 0; i < max_in_flight_job; i++)
> +		drm_mock_sched_job_submit(worker->jobs[i]);
> +
> +	/* Keep the window full by submitting a new job at once until done */
> +	for (i =3D 0; i < worker->job_count; i++) {
> +		done =3D drm_mock_sched_job_wait_finished(worker->jobs[i], timeout);
> +		if (!done)
> +			kunit_info(test_ctx->test, "Job %u of worker %u timed out\n",
> +				=C2=A0=C2=A0 i, worker->id);
> +
> +		j =3D i + max_in_flight_job;
> +		if (j < worker->job_count)
> +			drm_mock_sched_job_submit(worker->jobs[j]);
> +	}
> +}
> +
> +/*
> + * Spawns workers that submit a sequence of jobs to the mock scheduler. =
Job
> + * durations are chosen as multiples of a base duration value specified =
as
> + * a test parameter. Since the scheduler serializes jobs from all worker=
s,
> + * the total test duration budget is divided into equal shares among wor=
kers.
> + * These shares are then used to compute the number of jobs that each wo=
rker
> + * can submit.
> + */
> +static void drm_sched_interleaved_submit_test(struct kunit *test)
> +{
> +	const struct drm_sched_interleaved_params *params =3D test->param_value=
;
> +	struct sched_concurrent_context *ctx =3D test->priv;
> +	struct interleaved_worker *workers, *worker;
> +	struct drm_mock_sched_job *job;
> +	unsigned int worker_share_us;
> +	unsigned int i, j;
> +	bool done;
> +	int ret;
> +
> +	KUNIT_ASSERT_GT(test, params->num_workers, 0);
> +	KUNIT_ASSERT_GT(test, params->job_base_duration_us, 0);
> +
> +	workers =3D kunit_kcalloc(test, params->num_workers, sizeof(*workers),
> +				GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, workers);
> +
> +	/* Divide the available test time into equal shares among the workers *=
/
> +	worker_share_us =3D (params->test_duration_ms * USEC_PER_MSEC) /
> +			=C2=A0 params->num_workers;
> +
> +	/*
> +	 * Init workers only after all jobs and entities have been successfully
> +	 * allocated. In this way, the cleanup logic for when an assertion fail=
s
> +	 * can be simplified.
> +	 */
> +	for (i =3D 0; i < params->num_workers; i++) {
> +		worker =3D &workers[i];
> +		worker->id =3D i;
> +		worker->ctx =3D ctx;
> +
> +		worker->job_duration_us =3D params->job_base_duration_us * (i + 1);
> +		worker->job_count =3D worker_share_us / worker->job_duration_us;
> +		worker->job_count =3D max(1U, worker->job_count);
> +
> +		worker->entity =3D drm_mock_sched_entity_new(test,
> +							=C2=A0=C2=A0 DRM_SCHED_PRIORITY_NORMAL,
> +							=C2=A0=C2=A0 ctx->sched);
> +
> +		worker->jobs =3D kunit_kcalloc(test, worker->job_count,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(*worker->jobs), GFP_KERNEL);
> +		KUNIT_ASSERT_NOT_NULL(test, worker->jobs);
> +
> +		for (j =3D 0; j < worker->job_count; j++) {
> +			job =3D drm_mock_sched_job_new(test, worker->entity);
> +			drm_mock_sched_job_set_duration_us(job, worker->job_duration_us);
> +
> +			worker->jobs[j] =3D job;
> +		}
> +
> +		ret =3D kunit_add_action_or_reset(test, drm_mock_sched_entity_free_wra=
p,
> +						worker->entity);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +	}
> +
> +	for (i =3D 0; i < params->num_workers; i++) {
> +		worker =3D &workers[i];
> +		INIT_WORK(&worker->work, drm_sched_interleaved_worker);
> +		queue_work(ctx->sub_wq, &worker->work);
> +	}
> +
> +	complete_all(&ctx->wait_go);
> +	flush_workqueue(ctx->sub_wq);
> +
> +	for (i =3D 0; i < params->num_workers; i++) {
> +		worker =3D &workers[i];
> +		for (j =3D 0; j < worker->job_count; j++) {
> +			job =3D worker->jobs[j];
> +			done =3D drm_mock_sched_job_is_finished(job);
> +			KUNIT_EXPECT_TRUE(test, done);
> +		}
> +	}
> +}
> +
> +static struct kunit_case drm_sched_concurrent_tests[] =3D {
> +	KUNIT_CASE_PARAM(drm_sched_parallel_submit_test, drm_sched_parallel_gen=
_params),
> +	KUNIT_CASE_PARAM(drm_sched_interleaved_submit_test, drm_sched_interleav=
ed_gen_params),
> +	{}
> +};
> +
> +static struct kunit_suite drm_sched_concurrent =3D {
> +	.name =3D "drm_sched_concurrent_tests",
> +	.init =3D drm_sched_concurrent_init,
> +	.test_cases =3D drm_sched_concurrent_tests,
> +	.attr =3D {
> +		.speed =3D KUNIT_SPEED_SLOW,
> +	},
> +};
> +
> =C2=A0static struct kunit_case drm_sched_cancel_tests[] =3D {
> =C2=A0	KUNIT_CASE(drm_sched_basic_cancel),
> =C2=A0	{}
> @@ -556,6 +914,7 @@ static struct kunit_suite drm_sched_credits =3D {
> =C2=A0};
> =C2=A0
> =C2=A0kunit_test_suites(&drm_sched_basic,
> +		=C2=A0 &drm_sched_concurrent,
> =C2=A0		=C2=A0 &drm_sched_timeout,
> =C2=A0		=C2=A0 &drm_sched_cancel,
> =C2=A0		=C2=A0 &drm_sched_priority,
