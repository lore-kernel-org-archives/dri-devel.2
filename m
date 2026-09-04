Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A046CC624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:16:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBE6110E4AF;
	Fri,  4 Sep 2026 08:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KigiehpX";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 092B910E4AF
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:15:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F8FE60A6D;
 Fri,  4 Sep 2026 08:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEED51F00A3D;
 Fri,  4 Sep 2026 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788509758;
 bh=HYx0qjTvjVaqxPXbtto6OKsC69YfKqML24dA7y0sJ4Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KigiehpX0DVaDYPN9rQOf2DOoFVEYURF1VtumID9eb+n8Hem+xu7bdGuRtsPW52Db
 9AqQO8IDUIheyQaA37eu93BGFCcnBMNVHNC7w7Fuj+lTJLXDbmwzs6fMB9cMh9g+ZS
 idkeXBaGtHYxwoJxo9gbkOvSD+kp3Xxpl0huTokm0m9RqGQAr7Hr527Tdncqjm2vMp
 Nrk0mUogae1+kAHsiQ6ZEdl+/dsgbsmfy50KxYSq5qlTiJHa2uup1Zd7fD5Qo6Pkfg
 40Zm2nu9+vtkYK7yYpKaERLOTuSrxUhcsFF9Al1ayzHKX1qNPrJ+IRIpCg1DnahQuk
 xzsd9+WSf1UUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] drm/sched/tests: add a UAF regression test for
 the timeline name
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904080618.2098450-4-malhyuk97@gmail.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-4-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:15:57 +0000
Message-Id: <20260904081557.BEED51F00A3D@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] KUnit assertion failure aborts the test without tearing down the=
 DRM scheduler, leading to a use-after-free crash.
--

commit 5e3b2d1526bb334b5c71995b67ba48f0b45424d6
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

drm/sched/tests: add a UAF regression test for the timeline name

This patch introduces a KUnit test to reproduce a use-after-free issue=20
related to the drm_sched_fence timeline name. It submits a job on a mock=20
scheduler and verifies the timeline name can be safely queried after the=20
scheduler is freed.

> diff --git a/drivers/gpu/drm/scheduler/tests/tests_integration.c b/driver=
s/gpu/drm/scheduler/tests/tests_integration.c
> new file mode 100644
> index 0000000000000..4a2d5571440d2
> --- /dev/null
> +++ b/drivers/gpu/drm/scheduler/tests/tests_integration.c

[ ... ]

> +static void drm_sched_dma_fence_uaf(struct kunit *test)
> +{
> +	struct drm_mock_sched_entity *entity;
> +	struct drm_mock_scheduler *sched;
> +	struct drm_mock_sched_job *job;
> +	struct dma_fence *finished;
> +	const char __rcu *name;
> +	bool done;
> +
> +	sched =3D drm_mock_sched_new(test, MAX_SCHEDULE_TIMEOUT);
> +	entity =3D drm_mock_sched_entity_new(test, DRM_SCHED_PRIORITY_NORMAL,
> +					   sched);
> +	job =3D drm_mock_sched_job_new(test, entity);
> +
> +	/* The s_fence is only created by drm_sched_job_arm(). */
> +	drm_mock_sched_job_submit(job);
> +
> +	/* Independent reference on the finished fence =3D=3D userspace sync_fi=
le. */
> +	finished =3D dma_fence_get(&job->base.s_fence->finished);
> +
> +	/* Let the job get scheduled (hw fence created), then signal + finish. =
*/
> +	done =3D drm_mock_sched_job_wait_scheduled(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);

[Severity: Medium]
Will a failure here in drm_sched_dma_fence_uaf() abort the test and skip the
drm_mock_sched_fini() teardown?

If this assertion fails, the test thread aborts immediately. Because=20
drm_mock_sched_fini() is bypassed, any active kernel mechanisms from the DR=
M=20
scheduler might still hold references to sched->base.=20

When KUnit's automated cleanup runs (since sched was allocated with=20
kunit_kzalloc), could those mechanisms access the freed memory and cause a=
=20
use-after-free crash in the test runner?

> +	drm_mock_sched_advance(sched, 1);
> +	done =3D drm_mock_sched_job_wait_finished(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);

[Severity: Medium]
Similarly, if this job finish assertion fails, does aborting the test also=
=20
bypass the manual cleanup phase below, causing the same use-after-free issue
during KUnit teardown?

> +
> +	/*
> +	 * Free the per-context scheduler while the finished fence is held.
> +	 * kunit_kfree() releases the backing memory immediately (rather than at
> +	 * test teardown) so that fence->sched becomes a dangling pointer now.
> +	 */
> +	drm_mock_sched_entity_free(entity);
> +	drm_mock_sched_fini(sched);
> +	kunit_kfree(test, sched);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904080618.2098=
450-1-malhyuk97@gmail.com?part=3D3
