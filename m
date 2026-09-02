Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963D5C624D0
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 11:09:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F303810EEC7;
	Wed,  2 Sep 2026 11:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wlf6oEsA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A1B10E4D2
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 11:09:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ADE8041190;
 Wed,  2 Sep 2026 11:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666CC1F000E9;
 Wed,  2 Sep 2026 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788347371;
 bh=oAEFVBIoNA52bDb6hFrcLoIAPVcFeQ1q4sbyExmNJVM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wlf6oEsAlzejsDY3s0fQ9HE5VpI/7/GLYLqMaBEluWtAtu4zIPKPskDc2AYXSDZRY
 NErPUIB3olgpXHZfeheysbKTzEq2dnldL7LR6WDgl9SZ7kq4jJKF4pG27QZ2Pees+C
 KzaIxFW3njFzuz0LOKRyI71H/K3pOXeEOUK7wKdORS38PrDBccx9RC7bwulSJPUbWS
 i5UGWha+03bpm0UT8/OuqA6jTE3AZAcKK4/QRA+V/bUHbmdSFpqrVnHaRCYMdVElZK
 Vs7z9t8TEfg0HFo2IZnR/PXb+w/u6P4Vk99vVEV4bhgFJ7U5vlTbcq0Ag3jk34OSyN
 NFKsB9cFazvrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/sched/tests: add a UAF regression test for
 the timeline name
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902105808.1541063-3-malhyuk97@gmail.com>
References: <20260902105808.1541063-1-malhyuk97@gmail.com>
 <20260902105808.1541063-3-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 11:09:31 +0000
Message-Id: <20260902110931.666CC1F000E9@smtp.kernel.org>
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
- [Medium] Test aborts skip scheduler cleanup leading to use-after-free cra=
sh in workqueue.
--

commit a5abd99d79c0acda1fdefe1fe2690846be11bd71
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

drm/sched/tests: add a UAF regression test for the timeline name

This commit adds a KUnit integration test to reproduce a use-after-free
bug in drm_sched_fence_get_timeline_name(). It tests the scenario where
a scheduler is freed while userspace still holds a reference to a finished
fence, querying the timeline name via the dma-fence API.

> diff --git a/drivers/gpu/drm/scheduler/tests/tests_integration.c b/driver=
s/gpu/drm/scheduler/tests/tests_integration.c
> new file mode 100644
> index 0000000000000..0572f1e3a80b2
> --- /dev/null
> +++ b/drivers/gpu/drm/scheduler/tests/tests_integration.c

[ ... ]

> +	/* Independent reference on the finished fence, as a sync_file would. */
> +	finished =3D dma_fence_get(&job->base.s_fence->finished);
> +
> +	done =3D drm_mock_sched_job_wait_scheduled(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);

[Severity: Medium]
If this assertion fails, the test aborts immediately, skipping the explicit
drm_mock_sched_fini() and drm_mock_sched_entity_free() cleanup calls at the
end of the function.

Since the sched object is allocated with kunit_kzalloc(), the KUnit framewo=
rk
will automatically free its memory on test abort. However, without calling
drm_mock_sched_fini(), the sched->submit_wq workqueue and sched->work_tdr
delayed work will remain active.

Could this cause a kernel panic due to a use-after-free when the active
workqueue tries to execute a work struct from the freed scheduler memory?

> +	drm_mock_sched_advance(sched, 1);
> +	done =3D drm_mock_sched_job_wait_finished(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);

[Severity: Medium]
Similarly, failing here aborts the test while leaving active workqueues
referencing the soon-to-be-freed scheduler.

Would it be safer to use KUNIT_EXPECT_TRUE() instead to allow the test to
continue to the cleanup phase, or use kunit_add_action() to ensure the
scheduler is always properly torn down?

> +
> +	/* Free the per-context scheduler while the finished fence is held. */
> +	drm_mock_sched_entity_free(entity);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902105808.1541=
063-1-malhyuk97@gmail.com?part=3D2
