Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32A15C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF7710E9B4;
	Tue,  8 Sep 2026 06:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Cbt3K+9h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD28610E9B4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 06:07:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7711601DB;
 Tue,  8 Sep 2026 06:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825E01F00A3A;
 Tue,  8 Sep 2026 06:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788847665;
 bh=xVuhFNDv7umXYgL5PnmeRDPkmFzaypKwT8RlKfJsiws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Cbt3K+9haGSrgdBXqGgpxaLCf2hffaEbEPxWXHME952yFi3o5k/z/QygOiXCRMBxH
 aT1PyI9GElOo6pzNDrmjnmDW9mQcJWgpKaP8GAGw4yMB35ymUkZXDLZIk7gm//w9dw
 I44aesxBQkA4ZAl3yL3p1Lwbzh9Xu9rKByOMplsYRcJydCK4dg81KbWnlsyc1hTrT9
 euyj1tjksZyelPILgCW6AbnSfRCDQwv/JtYovMIZYUIQIyAeeuawUEOD2F72rUprBr
 nk/Wf3wOqjXULz7fhDtW1+65Sd128PVrBzIk3MumYNEnDsyq/zAc0/wOYSJkfNq9HA
 fs0a4aBqcN/pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/sched: Create a fake device for KUnit tests
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260908055941.351486-1-oushixiong1025@163.com>
References: <20260908055941.351486-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:07:45 +0000
Message-Id: <20260908060745.825E01F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Pre-existing UAF in KUnit tests due to un-canceled background work=
 on test failure.
--

commit a8f2ea9fa48640427fb6cda0751abea77a6dd44f
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sched: Create a fake device for KUnit tests

The DRM scheduler KUnit tests pass NULL for the dev field in
drm_sched_init_args, which causes a NULL-pointer dereference in the
drm_sched_job trace event. This patch gives the mock scheduler a fake
device with kunit_device_register(), ensuring it is cleaned up at test
exit.

> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/g=
pu/drm/scheduler/tests/mock_scheduler.c
> index 8e9ae7d980eb2..6a21e0b40c6d7 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> @@ -297,11 +300,19 @@ struct drm_mock_scheduler *drm_mock_sched_new(struc=
t kunit *test, long timeout)
>  		.name		=3D "drm-mock-scheduler",
>  	};
>  	struct drm_mock_scheduler *sched;
> +	struct device *dev;
> +	char name[64];
>  	int ret;
> =20
>  	sched =3D kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a pre-existing
use-after-free issue in the KUnit tests due to uncanceled background work
on test failure.

Because sched is allocated with kunit_kzalloc() here, KUnit's automatic
garbage collection frees the memory when a test exits or aborts on failure.
However, tests in tests_basic.c use assertions that abort immediately:

drivers/gpu/drm/scheduler/tests/tests_basic.c:drm_sched_basic_cancel() {
    ...
	done =3D drm_mock_sched_job_wait_scheduled(job, HZ);
	KUNIT_ASSERT_TRUE(test, done);

	drm_mock_sched_entity_free(entity);
	drm_mock_sched_fini(sched);
}

If the KUNIT_ASSERT_TRUE() assertion fails, drm_mock_sched_fini() is skippe=
d.
The sched memory is freed by KUnit, but the background work items=20
(work_run_job, work_tdr) and workqueues queued by drm_sched_init() are never
canceled.=20

Could these work items eventually execute, accessing the freed sched memory
and causing a kernel crash?

This same unhandled cleanup path appears in other tests, such as
drm_sched_test_credits():

drivers/gpu/drm/scheduler/tests/tests_basic.c:drm_sched_test_credits() {
    ...
	done =3D drm_mock_sched_job_wait_scheduled(job[0], HZ);
	KUNIT_ASSERT_TRUE(test, done);
    ...
	drm_mock_sched_fini(sched);
}

>  	KUNIT_ASSERT_NOT_NULL(test, sched);
> =20
> +	snprintf(name, sizeof(name), "%s-%u", args.name, instance++);
> +	dev =3D kunit_device_register(test, name);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	args.dev =3D dev;
> +
>  	ret =3D drm_sched_init(&sched->base, &args);
>  	KUNIT_ASSERT_EQ(test, ret, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908055941.3514=
86-1-oushixiong1025@163.com?part=3D1
