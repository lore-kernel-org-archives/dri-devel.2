Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD6DC61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A0E10F03A;
	Thu, 27 Aug 2026 13:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ha1riBng";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6505710F033;
 Thu, 27 Aug 2026 13:12:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C6B09601EF;
 Thu, 27 Aug 2026 13:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE9D1F000E9;
 Thu, 27 Aug 2026 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787836369;
 bh=lBl28xqZ5qWIALwECe0B+I2+YIN2M4Q92M8ij4/dg7A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ha1riBngDFmsbNHBvkFi2PlQdupNfqqSD9W6pSmd8Zd4iYMarz7PdVe/NhJIpfok6
 +b0SGUbPl0C8CjmoZ06WNx0ouGajK3Vpb45GpIdxuR7jen94Mirmi7aZKc00rVoIOm
 ck2jHK764CvYC4QkpDSS9Y25CNUVZe0QNcoipUHorogBc/hs03m2vNrlaIeZ70bHAn
 /pD3PnuyBHIqMpAQjy70lyKEC4qetlnbFKsCqQfullPAow+VCJPOt94NwDzApUuTBm
 /J7mHD2l945/TMDVxBjlv6BHUPuY1DJKm/1UlYTivHiCT1bg4G/p3yQ9DoWeetDMOP
 OSFgvV8G7MUYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/10] drm/ttm/tests: Use dma_resv_alloc in test files
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-10-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-10-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:12:48 +0000
Message-Id: <20260827131249.3CE9D1F000E9@smtp.kernel.org>
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
- [Medium] Permanent memory leak of dynamically allocated `dma_resv` object=
s in test files due to unmanaged allocations without proper cleanup on succ=
ess and error paths.
--

commit 12a4cfd4069727fd22b42f06cb1cc43d2134b9c2
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/ttm/tests: Use dma_resv_alloc in test files

This commit replaces dma_resv_init usage with dma_resv_alloc() in the TTM
test files, moving away from embedded structures to reference-counted
dynamic allocations.

> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_test.c
> @@ -339,14 +339,12 @@ static void ttm_bo_unreserve_bulk(struct kunit *tes=
t)
[ ... ]
>  	err =3D ttm_device_kunit_init(priv, ttm_dev, 0);
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	priv->ttm_dev =3D ttm_dev;
> =20
> -	dma_resv_init(resv);
> +	resv =3D dma_resv_alloc();
> +	KUNIT_ASSERT_NOT_NULL(test, resv);
> =20
>  	bo1 =3D ttm_bo_kunit_init(test, test->priv, BO_SIZE, resv);
>  	bo2 =3D ttm_bo_kunit_init(test, test->priv, BO_SIZE, resv);

[Severity: Medium]
Does this leak the dynamically allocated dma_resv object?

Because resv is no longer KUnit-managed, and both bo1 and bo2 take referenc=
es
to it via ttm_bo_kunit_init(), it seems the object will never be fully free=
d.=20
While this function has a dma_resv_put(resv) at the end, bo1 and bo2 are=20
never explicitly destroyed (e.g., via ttm_bo_fini() as seen in other tests),
leaving the refcount elevated on the success path.

> @@ -441,11 +439,9 @@ static void ttm_bo_fini_shared_resv(struct kunit *te=
st)
>  	KUNIT_ASSERT_EQ(test, err, 0);
>  	priv->ttm_dev =3D ttm_dev;
> =20
> -	external_resv =3D kunit_kzalloc(test, sizeof(*ttm_dev), GFP_KERNEL);
> +	external_resv =3D dma_resv_alloc();
>  	KUNIT_ASSERT_NOT_NULL(test, external_resv);
> =20
> -	dma_resv_init(external_resv);
> -
>  	fence =3D kunit_kzalloc(test, sizeof(*fence), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, fence);

[Severity: Medium]
Can this leak external_resv on the error path?

If the kunit_kzalloc() for the fence fails, the KUNIT_ASSERT_NOT_NULL() mac=
ro=20
will abort the test thread immediately. This bypasses the explicit=20
dma_resv_put(external_resv) cleanup at the end of the function, leaking the
unmanaged allocation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D9
