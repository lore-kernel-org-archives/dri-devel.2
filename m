Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C761C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C2710E265;
	Wed, 26 Aug 2026 08:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="He84PYhe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5532010E265
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 08:26:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB05943BA3;
 Wed, 26 Aug 2026 08:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D4B1F000E9;
 Wed, 26 Aug 2026 08:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787732795;
 bh=1T/HdTgbHNvmdRmKpjg8X44h6HokpntyTVibaPFWiwk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=He84PYheaLe5BZQOVlwOPBCZlwLLsygIWCtAahYoLobZHgss054mi0fIABjHURBOe
 SlruYapOqbouQNOjG0pL+cflo6BIzMqSuR97HsWsrdMRJQUC0FARa3IDqNWzDe31HS
 jmvK7/6BcD9e7p8BXdeVd6Ss6LAt4AoRhMpjQ5KorFrVQLzpFM6MErM5aslvYyKqek
 8CqGOTSxblCRZiQHsIeOIMjuWT5H2yAkQ1E8tRlHdthI7374Y2kkBjjG5AT+7I0dIk
 eZJBHnFcvhPH6cXBVpo36dfN0lZ7QWLTwe4XzzbXYaxZemHW9Ka59Vcbvpk3v7AA4s
 pnQxu/pwROR+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/sched: Create faux device for KUnit tests
To: oushixiong1025@163.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260826081543.508257-1-oushixiong1025@163.com>
References: <20260826081543.508257-1-oushixiong1025@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 08:26:35 +0000
Message-Id: <20260826082635.A3D4B1F000E9@smtp.kernel.org>
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
- [Medium] Faux device leaked when mock scheduler creation fails due to KUn=
it assertions.

Pre-existing issues:
- [High] NULL pointer dereference in `drm_mock_sched_fini()` if test setup =
fails.
--

commit 5bc8606c57dc89a513fd1bbffd71d60a4195c774
Author: Shixiong Ou <oushixiong@kylinos.cn>

drm/sched: Create faux device for KUnit tests

The DRM scheduler KUnit tests currently pass NULL for the dev field in
drm_sched_init_args, which causes a NULL pointer dereference in the
drm_sched_job trace event when it calls dev_name() on sched->dev.

Use faux_device_create() to create a fake device for the mock scheduler,
so the scheduler always has a valid device pointer.

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
Does this leak the faux device if drm_sched_init() fails?

If drm_sched_init() returns an error, the KUNIT_ASSERT_EQ() macro will abort
the test thread immediately. The test->priv pointer is never assigned, and =
the
manual cleanup in drm_mock_sched_fini() is bypassed.

Since there is no kunit_add_action() to automatically clean up the faux
device, it seems the faux device and its associated memory and sysfs nodes
will be permanently leaked.

[ ... ]
> @@ -324,6 +337,7 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct =
kunit *test, long timeout)
>  void drm_mock_sched_fini(struct drm_mock_scheduler *sched)
>  {
>  	drm_sched_fini(&sched->base);
> +	faux_device_destroy(sched->faux_dev);
>  }

[Severity: High]
This is a pre-existing issue, but can this function be called with a NULL
sched pointer?

If drm_mock_sched_new() aborts via a KUnit assertion (e.g., if
drm_sched_init() fails), the assignment to test->priv in the test .init
handler is never reached, leaving it NULL. KUnit always runs the test suite=
's
.exit handler during teardown, which extracts the NULL test->priv pointer a=
nd
passes it to drm_mock_sched_fini().

This function unconditionally performs pointer arithmetic and dereferences
sched without checking if it is NULL. The patch adds a second unsafe
dereference here (sched->faux_dev) to the already existing one
(&sched->base).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826081543.5082=
57-1-oushixiong1025@163.com?part=3D1
