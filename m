Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0FAC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E63E210F498;
	Thu,  3 Sep 2026 09:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O6GCz86u";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A85D10F498
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:36:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48CC9600C8;
 Thu,  3 Sep 2026 09:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779821F000E9;
 Thu,  3 Sep 2026 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788428189;
 bh=eEVXzclCY3N/gsaKYs1NrOcPH/+3yo1KDKKfVvSeYqQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=O6GCz86uTNsnRwq4BI0UdNM+4FoZnpEKT+zkv92LME7ynDS5sHLRu08zO5EfJ1tCc
 HiH5V6UvjPm+RajqcS0u7X1HrRczMhfLqyM40Wuq7FAkDJV9YlrsSQkbYBjxFHtWsB
 mivZjEwuEg5jY7wuwpEt9Sl8LiX9iWG3nzXrO7cKqEsygl4ajmbQ3HrGTFXcex9/x7
 dwvUSlNm97bpZw831VTpYZ8yR65zd93GEhLCEGfow34BWYv8Nl3j56hClnF7vB3jxU
 nvykuzHi4B8soBC+tTf7ZYD8zDKmYozNSai/DUKFMcunjNBJZv/qf3LBDqeRuGMxL5
 3hXNCL8xkGpVA==
Date: Thu, 3 Sep 2026 11:36:25 +0200
From: Maxime Ripard <mripard@kernel.org>
To: oushixiong1025@163.com
Cc: Matthew Brost <matthew.brost@intel.com>, 
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>, 
 Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: Re: [PATCH RESEND] drm/sched: Create faux device for KUnit tests
Message-ID: <apk_YgCd8fbXC7Lx@houat>
References: <20260903090256.552317-1-oushixiong1025@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="vuulpcyigbnspu6n"
Content-Disposition: inline
In-Reply-To: <20260903090256.552317-1-oushixiong1025@163.com>
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


--vuulpcyigbnspu6n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND] drm/sched: Create faux device for KUnit tests
MIME-Version: 1.0

Hi,

On Thu, Sep 03, 2026 at 05:02:56PM +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> The DRM scheduler KUnit tests currently pass NULL for the dev field in
> drm_sched_init_args, which causes a NULL pointer dereference in the
> drm_sched_job trace event when it calls dev_name() on sched->dev.
>=20
> Use faux_device_create() to create a fake device for the mock scheduler,
> so the scheduler always has a valid device pointer. This avoids the
> trace event crash without requiring the production code to accept a NULL
> device pointer, which conceptually makes no sense for a scheduler.
>=20
> An atomic counter is used to generate unique device names, since
> multiple mock schedulers can exist simultaneously across different
> test suites.
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
>  drivers/gpu/drm/scheduler/tests/mock_scheduler.c | 14 ++++++++++++++
>  drivers/gpu/drm/scheduler/tests/sched_tests.h    |  2 ++
>  2 files changed, 16 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c b/drivers/g=
pu/drm/scheduler/tests/mock_scheduler.c
> index 14403a762335..cd87e405bb1e 100644
> --- a/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> +++ b/drivers/gpu/drm/scheduler/tests/mock_scheduler.c
> @@ -1,6 +1,8 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2025 Valve Corporation */
> =20
> +#include <linux/device/faux.h>
> +
>  #include "sched_tests.h"
> =20
>  /*
> @@ -10,6 +12,8 @@
>   * Test cases are implemented in a separate file.
>   */
> =20
> +static atomic_t drm_mock_sched_instance =3D ATOMIC_INIT(0);
> +
>  /**
>   * drm_mock_sched_entity_new - Create a new mock scheduler entity
>   *
> @@ -296,11 +300,20 @@ struct drm_mock_scheduler *drm_mock_sched_new(struc=
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
> =20
> @@ -323,6 +336,7 @@ struct drm_mock_scheduler *drm_mock_sched_new(struct =
kunit *test, long timeout)
>  void drm_mock_sched_fini(struct drm_mock_scheduler *sched)
>  {
>  	drm_sched_fini(&sched->base);
> +	faux_device_destroy(sched->faux_dev);
>  }

What's wrong with drm_kunit_helper_alloc_device(), or kunit_device_register=
()?

Maxime

--vuulpcyigbnspu6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCapk/mAAKCRAnX84Zoj2+
dq36AYCmkQLjePG4c0c/9Q7SCXi6p+2rTtN49hAqC27AranW/qxBLY14QxYSbj/F
hR7gMnABgLth8E7SzxyPLv4bbgibQbYcBJNMitXrWtmUqq8pFrNiGY/GE58CozHF
VjJHgT+tiQ==
=g0bm
-----END PGP SIGNATURE-----

--vuulpcyigbnspu6n--
