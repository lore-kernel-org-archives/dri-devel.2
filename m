Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC64DC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C2E10F56E;
	Thu,  3 Sep 2026 12:26:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fM46XJ2C";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03FA10F56E
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:26:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 100F16022E;
 Thu,  3 Sep 2026 12:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA441F00A3A;
 Thu,  3 Sep 2026 12:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788438409;
 bh=8JNsP8mQILNnw+Lb5m27qynHAW47ZvTGFWinHsHD0bY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fM46XJ2CxuM1bshwkdXwK6i6hsMyZVnLG8l7l42rY1p+itz01/RTOzceeK7CaPYGr
 U3nOl8KWENyBZf38fLfqa6N+hykCMW7JiKE7mu92oU6OeUa61mn+0FVFUjSniTEb66
 ZEmMGyzGMzq7IXKdGyXtV9lmby6jq474dMohkNs1oV+y1tU+fvN+17SOOFc6tmFy07
 TKIwDLBca+KT3ELxQQo8N5jlOapnENXg6GaOWBaoLoklaXAHbVp0njqdkVia30b80/
 WMzyX6jbN6alZ1aaWBkJn5FLd++b5gk8v8xRqtHeUmQEPf/nQpqjHoDCGsLrdCyHqR
 z8QkEp7Y3DKWQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/sched: Create a fake device for KUnit tests
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903121558.782854-1-oushixiong1025@163.com>
References: <20260903121558.782854-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 12:26:48 +0000
Message-Id: <20260903122649.8FA441F00A3A@smtp.kernel.org>
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
- [High] Mock scheduler workqueues are leaked and cause Use-After-Free on K=
Unit assertion failures.
--

commit cd473696df99f11e05b48a9d612fa14552094751
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sched: Create a fake device for KUnit tests

This commit addresses a NULL-pointer dereference in the drm_sched_job trace
event by registering a mock device using kunit_device_register() and
assigning it to the scheduler arguments during test initialization.

> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/g=
pu/drm/scheduler/tests/mock_scheduler.c
> index 8e9ae7d980eb2..12dc61f56192e 100644
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
> +	snprintf(name, sizeof(name), "%s-%u", args.name, ++instance);
> +	dev =3D kunit_device_register(test, name);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +
> +	args.dev =3D dev;
> +
>  	ret =3D drm_sched_init(&sched->base, &args);

[Severity: High]
This is a pre-existing issue, but does this allocation structure leave the
scheduler's submit workqueue vulnerable to a use-after-free on test failure=
s?

In drm_sched_init(), a new submit_wq workqueue is created since
args->submit_wq is NULL. This workqueue is not managed by KUnit. If a test
encounters an assertion failure later (for example, hitting
KUNIT_ASSERT_TRUE(test, done) in drm_sched_basic_submit()), the KUnit
test thread is immediately aborted, bypassing manual cleanup routines like
drm_mock_sched_fini().

Because sched and sched->dev are managed by KUnit (via kunit_kzalloc
and kunit_device_register), they will be automatically freed upon test
abort. However, the unmanaged submit_wq remains active, and any pending
work items will execute and access the freed sched and sched->dev
memory, potentially causing a kernel crash.

Could a KUnit-managed cleanup hook like kunit_add_action() be used
after drm_sched_init() to ensure the workqueue is safely destroyed even if
the test thread aborts?

>  	KUNIT_ASSERT_EQ(test, ret, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903121558.7828=
54-1-oushixiong1025@163.com?part=3D1
