Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB755C61DB4
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D618110E2AB;
	Mon, 24 Aug 2026 13:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cq/VJgqh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD5E10E1A9;
 Mon, 24 Aug 2026 13:15:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CAA142B95;
 Mon, 24 Aug 2026 13:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B364A1F000E9;
 Mon, 24 Aug 2026 13:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787577347;
 bh=XxLDEedc+fH0MClbI9nD7UrI/pQwIQVYtWd8rQeNnKg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cq/VJgqhQtFgfR9yQV/bP1/SnCzRTmGsFSOCg0yuPsY0hv90NAxNoozUEsX6K8sCb
 Noa4BkzrB4SWVuJOhAKk6GVsm33dyxZRcbMQT4rnWVIWygVtReT+CIGbHV4Rwxdo2p
 fzmp0ipgtiUhd4LTtjkHZmC110Qn3WtRLdMV7+bhuhTj0S96v2LUbHRk/VwOdxtnkg
 WCKn6daBm1jfwzT1idKpMPOINm1QLRkMuq1lagPJ2QhoTdCujiHEF0gQvQkzkZ7HtU
 Sn3fXQ2fnRaAQHwQ5wTzN6IaZr1OQ0hKYXL4xy8ihZ2bjKtb5EjZvO/pO0SQcSlaEo
 ch+zIOK5u7plw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/13] drm/panic: Return errno codes if panic output
 fails
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: imx@lists.linux.dev, intel-xe@lists.freedesktop.org, ojeda@kernel.org,
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Frank.Li@kernel.org, wsa+renesas@sang-engineering.com,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260824125201.218863-5-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
 <20260824125201.218863-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 13:15:46 +0000
Message-Id: <20260824131546.B364A1F000E9@smtp.kernel.org>
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
- [Medium] Using KUNIT_ASSERT_EQ causes kernel test memory to leak if the d=
rawing function returns an error, bypassing explicit resource cleanup.

Pre-existing issues:
- [High] Concurrent invocation of the debugfs trigger for planes on differe=
nt devices causes data races on global panic buffers, leading to memory cor=
ruption.
--

--- Patch [4]: [PATCH v2 04/13] drm/panic: Return errno codes if panic outp=
ut fails ---
commit 6a8545466378db489975c829328cc895f57550b4
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/panic: Return errno codes if panic output fails

Return errno codes from the panic output helpers to detect invalid panic
handling and avoid flushing the display if an error occurred. The panic
test cases are updated to assert these new return values.

> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 62490d32019cc..cc33a2b4bb52a 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c

[ ... ]

> @@ -945,9 +954,15 @@ static void draw_panic_plane(struct drm_plane *plane=
, const char *description)
> =20
>  	drm_panic_set_description(description);
> =20
> -	draw_panic_dispatch(&sb);
> -	if (plane->helper_private->panic_flush)
> -		plane->helper_private->panic_flush(plane);
> +	ret =3D draw_panic_dispatch(&sb);

[Severity: High]
This is a pre-existing issue, but can concurrent writes to the debugfs trig=
ger
corrupt global buffers?

If a user concurrently writes to the debugfs trigger files (drm_panic_plane=
_%d)
for planes on different DRM devices, draw_panic_plane() executes concurrent=
ly
because dev->mode_config.panic_lock is a per-device lock.

When DRM_PANIC_TYPE_QR is active, multiple threads could enter
drm_panic_get_qr_code_url() and modify the global static variables qrbuf1,
qrbuf2, and stream.workspace without cross-device synchronization:

drivers/gpu/drm/drm_panic.c:drm_panic_get_qr_code_url() {
    ...
    stream.next_in =3D kmsg;
    stream.avail_in =3D kmsg_len;
    stream.total_in =3D 0;
    stream.next_out =3D qrbuf2;
    stream.avail_out =3D QR_BUFFER2_SIZE;
    stream.total_out =3D 0;
    ...
}

Could this cause memory corruption during simultaneous debugfs writes?

> +	if (!ret) {
> +		/*
> +		 * Only flush if we have a panic screen to display. Otherwise
> +		 * it's probably better to leave the display output as-is.
> +		 */
> +		if (plane->helper_private->panic_flush)
> +			plane->helper_private->panic_flush(plane);
> +	}
> =20
>  	drm_panic_clear_description();

[ ... ]

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

[Severity: Medium]
Will this KUNIT_ASSERT_EQ() cause memory leaks if the test fails?

If params->draw_screen() returns an error, KUNIT_ASSERT_EQ() will abort the
test thread immediately. This means the test will skip explicit resource
cleanup, such as the vfree(fb) call at the end of
drm_test_panic_screen_user_map().

Should this use KUNIT_EXPECT_EQ() instead to allow the cleanup code to run?

> =20
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

[Severity: Medium]
Similarly here in drm_test_panic_screen_user_page(), if KUNIT_ASSERT_EQ()
aborts the test on failure, will it skip the free_pages: cleanup label,
resulting in a permanent memory leak?

> =20
>  	for (p =3D 0; p < npages; p++) {
>  		int bytes_in_page =3D (p =3D=3D npages - 1) ? fb_size - p * PAGE_SIZE =
: PAGE_SIZE;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824125201.2188=
63-1-tzimmermann@suse.de?part=3D4
