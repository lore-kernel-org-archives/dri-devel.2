Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F754C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA27D10F8C3;
	Fri,  4 Sep 2026 07:35:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BLro0HAo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2F310F8C3
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 07:35:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3899860A75;
 Fri,  4 Sep 2026 07:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C44321F00A3D;
 Fri,  4 Sep 2026 07:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788507311;
 bh=pI45vFrnw1PHhnoxp32ELN1zi/ByVneZAcr41kTSzQI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BLro0HAoH9lliJZac7Qz2zkmXYj4sZ4nODGjebFtjYfeHRHnOjA+mFKmxL/asG3oB
 ysvrfAUv/crQZmDmlLa3G0NK5e/rQ2IthQiJMaDmIF5j5NT9jDGCgXOFcO/wFAJ7WV
 VE4KVuVgckaLd60MTIBKOWMMJylRJJLVRAFSthJ14iCewE/6ESOB/BVmtwFQ9+mZSn
 ShvTMQBCuO5NQMglH2JuiaFDc8rVlwfXYKDvOwLPyBcZKxwRyvF3ydDLwxGQKGeV0Y
 gLyWkJX+oRSMwiL2tMB9jFq7BQglX5uIB2hFq0Y7tpl9nGNEocVLa1PEVgRC4rWMsS
 db0p5UuErEJlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/sched: Create a fake device for KUnit tests
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260904072149.436181-1-oushixiong1025@163.com>
References: <20260904072149.436181-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 07:35:11 +0000
Message-Id: <20260904073511.C44321F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Newly added mock device is freed on test abort while scheduler wor=
kqueues are still running.

Pre-existing issues:
- [High] NULL pointer dereference in test suite exit functions if drm_mock_=
sched_new() aborts during initialization.
--

commit 87ec4ea74ea7485f78bc8e603289f73cd4461eb5
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sched: Create a fake device for KUnit tests

This commit creates a dummy device using kunit_device_register() for the
mock scheduler in KUnit tests. This prevents a NULL pointer dereference
in the drm_sched_job trace event which relies on sched->dev.

> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/g=
pu/drm/scheduler/tests/mock_scheduler.c
> index 8e9ae7d980eb2..2dfa3efef2100 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
[ ... ]
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
>  	KUNIT_ASSERT_NOT_NULL(test, sched);
> =20
> +	snprintf(name, sizeof(name), "%s-%u", args.name, instance++);
> +	dev =3D kunit_device_register(test, name);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);

[Severity: High]
This is a pre-existing issue, but does this assertion expose a crash in
the test suite's exit functions?

If kunit_device_register() fails in drm_mock_sched_new(), the
KUNIT_ASSERT_NOT_ERR_OR_NULL macro aborts the initialization sequence.
Control returns to the KUnit framework without test->priv being initialized.

When the framework subsequently runs the suite's exit function
(drm_sched_basic_exit()), it extracts test->priv and passes it to
drm_mock_sched_fini(), which unconditionally dereferences the NULL pointer.

Could this lead to a kernel panic during test failure rather than cleanly
reporting the error?

> +
> +	args.dev =3D dev;
> +
>  	ret =3D drm_sched_init(&sched->base, &args);
>  	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: High]
Could tying the mock device to the KUnit test lifecycle cause a
use-after-free if the test aborts?

The device allocated with kunit_device_register() is automatically freed
when the KUnit test thread exits. However, drm_sched_init() spawns
background tasks (scheduler workqueues) that hold references to this
device.

If a subsequent test assertion fails (e.g., KUNIT_ASSERT_FALSE in
drm_sched_test_credits()), the test aborts, skipping the manual
drm_mock_sched_fini() cleanup. KUnit will automatically free the mock
device, but the background tasks remain active and may attempt to access
the freed device memory.

Should the scheduler cleanup be registered as a deferred KUnit action to
ensure the workqueues are stopped before the device is freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904072149.4361=
81-1-oushixiong1025@163.com?part=3D1
