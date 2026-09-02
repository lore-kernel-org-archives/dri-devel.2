Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8200FC624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC4E610E35F;
	Wed,  2 Sep 2026 15:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j+Ksrvqj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B493910E35F
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 15:04:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E92B6600C8;
 Wed,  2 Sep 2026 15:04:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770CF1F000E9;
 Wed,  2 Sep 2026 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788361497;
 bh=qnpHXv3Ko7xUdzCvkyCBM71OKQE9fCVx3dRVHHBPXuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j+Ksrvqj4ofTaQ3jeXPaWAd7cnZdNqxpUMwhmc6xHLmzRSuBSH9Sx84nIHiKICjtK
 oA+moMWt6co3wtcuK2zfx8TGBZSmNtMj5PFjFPxTqReN4jgM+PtHjwDUTg1NAVLfQv
 uSEigQ+P+pHu1F6+Z/FsV7NRifryAJO0NUfurlgSXNUmJgLFIZ689i2j/ZEyP/otLV
 rMDOBmPNYfn5rv40VxislmIPBd5dqFv7R40T2e5kg3L7kBNyV9Ua0lb/6XZZ2ugVe8
 y4hsYsBE/sXdsbdFFlAmEbp4l/vWVfzP0CCvYtivJJnnDGWXxng1wVCjNcvsR0GsUY
 30sqfo3ebG2bw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/sched/tests: add a UAF regression test for
 the timeline name
To: =?utf-8?b?Sm9uZ2h5dWsgS2ltKE1hbEh5dWsp?= <malhyuk97@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902144204.1843670-3-malhyuk97@gmail.com>
References: <20260902144204.1843670-1-malhyuk97@gmail.com>
 <20260902144204.1843670-3-malhyuk97@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:04:57 +0000
Message-Id: <20260902150457.770CF1F000E9@smtp.kernel.org>
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
- [Medium] Test abortion on `KUNIT_ASSERT_TRUE` failure skips manual cleanu=
p, causing Use-After-Free crashes from background tasks.
--

commit a2c80bbffa3f457ad719c5864b695730ec7e1976
Author: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

drm/sched/tests: add a UAF regression test for the timeline name

This commit adds an integration KUnit test to reproduce a use-after-free
in the drm_sched_fence timeline-name. It exercises the interaction between
the DRM scheduler and the dma-fence API by submitting a job, freeing the
scheduler, and querying the timeline name.

> diff --git a/drivers/gpu/drm/scheduler/tests/tests_integration.c b/driver=
s/gpu/drm/scheduler/tests/tests_integration.c
> new file mode 100644
> index 0000000000000..5e1ca6c6fa5a2
> --- /dev/null
> +++ b/drivers/gpu/drm/scheduler/tests/tests_integration.c
[ ... ]
> +static void drm_sched_dma_fence_uaf(struct kunit *test)
> +{
[ ... ]
> +	/* Let the job get scheduled (hw fence created), then signal + finish. =
*/
> +	done =3D drm_mock_sched_job_wait_scheduled(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);

[Severity: Medium]
If this assertion fails, the test aborts and skips manual cleanup like
drm_mock_sched_fini(). Because KUnit automatically frees memory allocated w=
ith
kunit_kzalloc() upon test abortion, active background tasks such as DRM
scheduler workqueues and job hrtimers will access freed memory.

Does this cause a use-after-free crash if the wait times out and returns fa=
lse?

> +	drm_mock_sched_advance(sched, 1);
> +	done =3D drm_mock_sched_job_wait_finished(job, HZ);
> +	KUNIT_ASSERT_TRUE(test, done);

[Severity: Medium]
Similarly, can a failure on this assertion cause a use-after-free by aborti=
ng
the test before the cleanup code runs?

> +
> +	/*
> +	 * Free the per-context scheduler while the finished fence is held.
> +	 * kunit_kfree() releases the backing memory immediately (rather than at
> +	 * test teardown) so that fence->sched becomes a dangling pointer now.
> +	 */
> +	drm_mock_sched_entity_free(entity);
> +	drm_mock_sched_fini(sched);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902144204.1843=
670-1-malhyuk97@gmail.com?part=3D2
