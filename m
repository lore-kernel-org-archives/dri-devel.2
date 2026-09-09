Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEEBC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A00710F035;
	Wed,  9 Sep 2026 09:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TlYlpdO7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F03310E54B;
 Wed,  9 Sep 2026 09:13:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E31B601FD;
 Wed,  9 Sep 2026 09:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2501F00A3A;
 Wed,  9 Sep 2026 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788945208;
 bh=AAwOGRQaoDxWa8W7YOl+0hmbLzFBwRTEXNQVM25Bff0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TlYlpdO7bvC67o1WGv48JCynadP305FzSV9BC0UybWtpH/5USq7wEyD8cHUKrO3RV
 JX9POh+lypSjH6LXWpafFZmXOXGR+HXsqW4Z0VPZAG1N0bro7lr3pbCZEcs13RLIWI
 lMnScwf/QySwfpo5cdpDXgazphMJMwgpFY3/HTPzfu8aae4/hTSNgBnxaTTub3kp0o
 jld9b3mAROMsBX4pM1SyH3obGkn6fyl/FKUegxWvQS21cEEzXFM+Q+K097T4sLjcpd
 Qedntbf3g5hEAB5DjLxXI/PpLmoChEJSVejFCm4yVLnrGPVfb+JtsYNRWo3nLnBhIg
 EG3xzSDNnINcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/14] drm/panic: Return errno codes if panic output
 fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: gary@garyguo.net, wsa+renesas@sang-engineering.com, imx@lists.linux.dev,
 "Eugenio
 Perez" <eperezma@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Frank.Li@kernel.org, virtualization@lists.linux.dev, ojeda@kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260909085826.64529-5-tzimmermann@suse.de>
References: <20260909085826.64529-1-tzimmermann@suse.de>
 <20260909085826.64529-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:13:26 +0000
Message-Id: <20260909091326.EB2501F00A3A@smtp.kernel.org>
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
- [Low] Memory leak on test failure due to KUNIT_ASSERT_EQ aborting the tes=
t without cleanup.
--

commit 9d8cd66dd2ff7109b373380125b5d333a64fb982
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Return errno codes if panic output fails

This commit modifies the panic output helpers to return errno codes, allowi=
ng
detection of invalid panic handling and avoiding display flushes on error.
The KUnit tests are also updated to assert that these new return values
indicate success.

> diff --git a/drivers/gpu/drm/tests/drm_panic_test.c b/drivers/gpu/drm/tes=
ts/drm_panic_test.c
> index ad2f3a2f93b6a..fdd77b0cc54c9 100644
> --- a/drivers/gpu/drm/tests/drm_panic_test.c
> +++ b/drivers/gpu/drm/tests/drm_panic_test.c

[ ... ]

> @@ -102,7 +102,8 @@ static void drm_test_panic_screen_user_map(struct kun=
it *test)
>  	sb->height =3D params->height;
>  	sb->pitch[0] =3D params->width * sb->format->cpp[0];
> =20
> -	params->draw_screen(sb);
> +	ret =3D params->draw_screen(sb);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Low]
If KUNIT_ASSERT_EQ() fails here, does this abort the test and bypass the
subsequent vfree(fb) cleanup step?

If draw_screen() returns a non-zero error code (for instance, due to an
unsupported size or missing font), it looks like this will leak the vmalloc=
'd
framebuffer since the test aborts before the free can execute.

>  	for (i =3D 0; i < fb_size; i++)
>  		drm_panic_check_color_byte(test, fb[i]);

[ ... ]

> @@ -146,7 +147,8 @@ static void drm_test_panic_screen_user_page(struct ku=
nit *test)
>  	sb->height =3D params->height;
>  	sb->pitch[0] =3D params->width * sb->format->cpp[0];
> =20
> -	params->draw_screen(sb);
> +	ret =3D params->draw_screen(sb);
> +	KUNIT_ASSERT_EQ(test, ret, 0);

[Severity: Low]
Similarly, if KUNIT_ASSERT_EQ() fails here, does it abort the test and
bypass the free_pages cleanup block?=20

It appears this would cause a leak of both the allocated pages and the pages
pointer array on test failure.

>  	for (p =3D 0; p < npages; p++) {
>  		int bytes_in_page =3D (p =3D=3D npages - 1) ? fb_size - p * PAGE_SIZE =
: PAGE_SIZE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909085826.6452=
9-1-tzimmermann@suse.de?part=3D4
