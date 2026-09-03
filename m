Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C84C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C0B10E0E5;
	Thu,  3 Sep 2026 09:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bcpCbaxS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F18310E0E5
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:12:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E326D600C8;
 Thu,  3 Sep 2026 09:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7831B1F000E9;
 Thu,  3 Sep 2026 09:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788426745;
 bh=VmQoztAehZhjOiHBJEPc2BGvZFMx3uEKjIfpeMGE/jc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bcpCbaxSzjuowLSWJpytqWop0XhuxJOvB3xvpLhefKDedUHkNB14es1qrw1uGhl1y
 6aoNy5v5C5771PQI7i76+/wjr98LSpFF/75aUoWDR9FDb2Gp0BEOfFSRvqCVO5mIr1
 r2Zdd28bq7q8o/OF9rcAhY9ALYpSn90dXhmLd5KIlNa8xz2SWNeReCD0skKmlXd8aT
 iJOlXNt/mnUjBPj0UD5vrEzleKzA5xlljptygVCWny7Gwax+17SgSCws0YKT5tFq2H
 DMZvys+efDl6H+Ia6WJMFUR5Tae96E+WrfcDRab0SK28H3jazibdEKYsC2N0Erpv2+
 Lhj9V/FiUZdvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] drm/sched: Create faux device for KUnit tests
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260903090256.552317-1-oushixiong1025@163.com>
References: <20260903090256.552317-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:12:24 +0000
Message-Id: <20260903091225.7831B1F000E9@smtp.kernel.org>
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
- [Medium] Unmanaged 'faux_device' will be leaked if KUnit assertions fail,=
 leaving a dangling sysfs device.
--

commit 55011cc21a49b0f659a9ade7e86087adb7a9989c
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sched: Create faux device for KUnit tests

This commit updates the DRM scheduler KUnit tests to use a faux device
instead of passing a NULL device pointer to the scheduler initialization.
This prevents a NULL pointer dereference in the drm_sched_job trace event
which expects a valid device pointer.

> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/g=
pu/drm/scheduler/tests/mock_scheduler.c
> index 8e9ae7d980eb2..b6954224254e0 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
[ ... ]
> @@ -297,11 +301,20 @@ struct drm_mock_scheduler *drm_mock_sched_new(struc=
t kunit *test, long timeout)
>  		.name		=3D "drm-mock-scheduler",
>  	};
>  	struct drm_mock_scheduler *sched;
> +	char name[64];
>  	int ret;
> =20
>  	sched =3D kunit_kzalloc(test, sizeof(*sched), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, sched);
> =20
> +	snprintf(name, sizeof(name), "drm-mock-scheduler-%d",
> +		 atomic_inc_return(&drm_mock_sched_instance));
> +
> +	sched->faux_dev =3D faux_device_create(name, NULL, NULL);
> +	KUNIT_ASSERT_NOT_NULL(test, sched->faux_dev);
> +
> +	args.dev =3D &sched->faux_dev->dev;
> +
>  	ret =3D drm_sched_init(&sched->base, &args);
>  	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Medium]
If drm_sched_init() fails in drm_mock_sched_new(), will this KUNIT_ASSERT_E=
Q()
abort the test and leak the faux device allocated above?

Since faux_device_create() allocates and registers a device, but the faux_d=
ev
is not directly managed by KUnit (for example, via kunit_add_action), an
assertion failure here would cause the test to exit immediately without cal=
ling
faux_device_destroy(). This could lead to a leak of the struct device and i=
ts
sysfs registration, leaving stale entries behind on test failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903090256.5523=
17-1-oushixiong1025@163.com?part=3D1
