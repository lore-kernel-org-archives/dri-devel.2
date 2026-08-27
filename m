Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDBFC61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A22610F038;
	Thu, 27 Aug 2026 13:08:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H8+6V1VT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F124C10E40E;
 Thu, 27 Aug 2026 13:08:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AF8B601F0;
 Thu, 27 Aug 2026 13:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9437F1F000E9;
 Thu, 27 Aug 2026 13:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787836135;
 bh=hlihuD2bku6uAmNNIK0jLwCSBtVFxBaYPAtWnozYKs8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H8+6V1VT9KVpxUNxVDDc34ynGn+4mXUAndqdVRJqMIEbU+Ls6o5nm0GpPzPHXVYYz
 a5Xxhgz6Cw27FZTqvjzGsRjcvof6i+2TiVyzE0lwU9l60bm13MtajfW1eY0lN7BrFE
 S2C8tk+j0ENEL5TQ/h6qayvJT+GrkueUnUIBNHqEaPbQusXMCuZ5xOfxTdx1xnk0Nz
 hTpd10mpdq/up00XmJ9Q9B+AYxOsJ0MGvecgGqrYkZzi+uBmsu4oAi6ytnUeTZePH+
 SB9W62FYS5S7OtwbXSfApZfwugjWyMNMP9sXOf7tePxlLXWYCttDBcplUA3V7WinpV
 zwEIy+oc6kytw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/10] dma-buf/tests: Convert st-dma-resv tests to use
 dma_resv_alloc
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-3-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:08:55 +0000
Message-Id: <20260827130855.9437F1F000E9@smtp.kernel.org>
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
- [Medium] Memory leak of manually allocated 'dma_fence' object on test fai=
lure path due to KUNIT_ASSERT_NOT_NULL aborting the test.
--

commit 2140307021746c828365fffb6d1a6a49b2fe2aa6
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
dma-buf/tests: Convert st-dma-resv tests to use dma_resv_alloc

This patch updates the test cases in st-dma-resv.c to use the new
dma_resv_alloc API instead of stack-allocated objects. It introduces
pointer allocations and adds reference counting verification by calling
dma_resv_put for cleanup.

> diff --git a/drivers/dma-buf/st-dma-resv.c b/drivers/dma-buf/st-dma-resv.c
> index 2c43d2d2b0169..b843d90417822 100644
> --- a/drivers/dma-buf/st-dma-resv.c
> +++ b/drivers/dma-buf/st-dma-resv.c
[ ... ]
> @@ -75,33 +77,35 @@ static void test_signaling(struct kunit *test)
> =20
>  	dma_fence_enable_signaling(f);
> =20
> -	dma_resv_init(&resv);
> -	r =3D dma_resv_lock(&resv, NULL);
> +	resv =3D dma_resv_alloc();
> +	KUNIT_ASSERT_NOT_NULL(test, resv);

[Severity: Medium]
Does this code leak the allocated dma_fence 'f' if the assertion fails?

In test_signaling(), 'f' is allocated right before this code block. If
dma_resv_alloc() fails due to memory pressure, KUNIT_ASSERT_NOT_NULL() will
abort the test execution immediately. This bypasses the err_free cleanup
label and leaves 'f' stranded without its corresponding dma_fence_put() cal=
l.

Since this pattern is repeated in the other tests below, would it be
possible to either reorder the allocations or use KUNIT_EXPECT_NOT_NULL()
to allow for proper cleanup on failure?

> +
> +	r =3D dma_resv_lock(resv, NULL);
[ ... ]
> @@ -119,23 +123,25 @@ static void test_for_each(struct kunit *test)
> =20
>  	dma_fence_enable_signaling(f);
> =20
> -	dma_resv_init(&resv);
> -	r =3D dma_resv_lock(&resv, NULL);
> +	resv =3D dma_resv_alloc();
> +	KUNIT_ASSERT_NOT_NULL(test, resv);

[Severity: Medium]
Similarly here in test_for_each(), does a failure on this assertion
leak the 'f' object?

> +
> +	r =3D dma_resv_lock(resv, NULL);
[ ... ]
> @@ -178,25 +184,27 @@ static void test_for_each_unlocked(struct kunit *te=
st)
> =20
>  	dma_fence_enable_signaling(f);
> =20
> -	dma_resv_init(&resv);
> -	r =3D dma_resv_lock(&resv, NULL);
> +	resv =3D dma_resv_alloc();
> +	KUNIT_ASSERT_NOT_NULL(test, resv);

[Severity: Medium]
Does this assertion also leak 'f' in test_for_each_unlocked() if it fails?

> +
> +	r =3D dma_resv_lock(resv, NULL);
[ ... ]
> @@ -248,24 +256,26 @@ static void test_get_fences(struct kunit *test)
> =20
>  	dma_fence_enable_signaling(f);
> =20
> -	dma_resv_init(&resv);
> -	r =3D dma_resv_lock(&resv, NULL);
> +	resv =3D dma_resv_alloc();
> +	KUNIT_ASSERT_NOT_NULL(test, resv);

[Severity: Medium]
Does this assertion also leak 'f' in test_get_fences() if it fails?

> +
> +	r =3D dma_resv_lock(resv, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D2
