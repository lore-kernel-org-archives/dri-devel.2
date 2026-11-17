Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC4606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 01:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0duNk02
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB1310EAF4;
	Tue, 17 Nov 2026 01:33:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106A910EAF4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 01:33:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D328D42AE9;
 Tue, 17 Nov 2026 01:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6491F000C4;
 Tue, 17 Nov 2026 01:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794879193;
 bh=EFfdHrYATIoETT6Ln+x1dtfUdIJEFYgRQOumM7I68lw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H0duNk02YZ2ULlZV9GyCPWEutQqEyYj+O30J8MwxzcT+lnbYkC8xXsJqwP/atr23W
 dNJBliRnSeWs9Sa6i+As8De0OdkMTtp1j4a9RA8+4XUwSYDs6FTRa9+gq7lrbKn163
 IY8soHH32DCJP0bn+S2MMtcQvx8RAbMMRAshOCsJVJ6Kj5y6O9oa/O1NTyQHd5jdD3
 i4lC/0oTmrDu9RCpSz15b3q5plrIVBlXMVh+yiv1NThviph/AztsrRyx84zA/fjzy7
 0s1V06SIOO9cRe7pRiXcydJa1DTFE55sBwoBRl3p0yqVRgGb3R/39gwJz+FVplL2wN
 b2+9al59orzBA==
Message-ID: <sashiko-outbox-218047@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/5] drm/vkms: Add KUnit test for RGB565 writeback
 conversion
To: "Sidharth Saha" <ssaha2000@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261116-rgb565-test-v1-1-27f49c1aa694@gmail.com>
References: <20261116-rgb565-test-v1-0-27f49c1aa694@gmail.com>
 <20261116-rgb565-test-v1-1-27f49c1aa694@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 01:33:13 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/vkms: non-routable noreply email in Signed-off-by trailer
- [Medium] drm/vkms: missing sentinel in vkms_format_test_cases causes
  OOB read
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Medium] drm/vkms: CPU stalls due to 64-bit division in
  argb_u16_to_RGB565() [1]
--

commit 7e8259d89165f4b4d4681ffd3d36be55b127f91e
Author: Sidharth Saha <ssaha2000@gmail.com>

> drm/vkms: Add KUnit test for RGB565 writeback conversion
>
> argb_u16_to_RGB565() reduces each 16-bit channel to 5 or 6 bits. Its
> rounding was fixed in commit ab87f558dcfb ("drm/vkms: Fix RGB565 pixel
> conversion"), lost again in commit cc4fd2934d41 ("drm/vkms: Isolate
> writeback pixel conversion functions"), and restored by "drm/vkms: make
> argb_u16_to_RGB565 round resulting values". Add a KUnit test so it can't
> silently regress again.
>
> The test checks hand-computed values for zero, maximum, the 0x8000
> midpoint, inputs on either side of the first rounding step, and distinct
> per-channel values to catch channel placement errors.
>
> Make argb_u16_to_RGB565() visible to KUnit so the test can call it.
>
> Signed-off-by: Sidharth Saha <40047656+Sidharth-Saha@users.noreply.github=
.com>

[Severity: High]
The Signed-off-by trailer uses a non-routable GitHub noreply email address
that does not match the commit Author address (<ssaha2000@gmail.com>).

> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/=
drm/vkms/tests/vkms_format_test.c
> index bbb1ad18c99ff..a8ef93b9c806c 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c

[ ... ]

> @@ -265,9 +265,45 @@ KUNIT_ARRAY_PARAM(yuv_u16_to_argb_u16, yuv_u16_to_ar=
gb_u16_cases,
>  static struct kunit_case vkms_format_test_cases[] =3D {
>  	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_argb_=
u16_gen_params),
> -	{}
> +	KUNIT_CASE_PARAM(vkms_format_test_argb_u16_to_RGB565, rgb565_gen_params=
),
>  };

[Severity: Medium]
Does removing the trailing {} sentinel from vkms_format_test_cases[] cause
an out-of-bounds read when KUnit iterates over the suite?

kunit_suite_for_each_test_case() walks suite->test_cases until it sees a
NULL run_case pointer, so running or enumerating the vkms-format suite will
read past the end of the array and treat adjacent memory as a test case.
Note that a later patch in this series, commit "drm/vkms: Add KUnit tests
for RGB565 and BGR565 read conversion", restores the trailing {} entry.

> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/v=
kms_formats.c
> index b0078d6efb908..c5ee2d6a920f6 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -685,7 +685,7 @@ static void argb_u16_to_channels(u16 *out_r, u16 *out=
_g, u16 *out_b, u16 *out_a,
>  		*out_a =3D u16_to_channel(a_size, in_pixel->a);
>  }
> =20
> -static void argb_u16_to_RGB565(u8 *out_pixel, const struct pixel_argb_u1=
6 *in_pixel)
> +VISIBLE_IF_KUNIT void argb_u16_to_RGB565(u8 *out_pixel, const struct pix=
el_argb_u16 *in_pixel)
>  {
>  	__le16 *pixel =3D (__le16 *)out_pixel;
>  	u16 r, g, b;
> @@ -694,6 +694,7 @@ static void argb_u16_to_RGB565(u8 *out_pixel, const s=
truct pixel_argb_u16 *in_pi
> =20
>  	*pixel =3D cpu_to_le16(r << 11 | g << 5 | b);
>  }
> +EXPORT_SYMBOL_IF_KUNIT(argb_u16_to_RGB565);

[Severity: Medium]
This problem wasn't introduced by this patch, but argb_u16_to_RGB565() (via
argb_u16_to_channels() -> u16_to_channel()) and argb_u16_from_RGB565()
perform 64-bit fixed-point divisions with drm_fixp_div() on every channel
of every pixel [1]:

drivers/gpu/drm/vkms/vkms_formats.c:u16_to_channel() {
	s64 fp_ratio =3D drm_fixp_div(drm_int2fixp(65535), drm_int2fixp((1 << size=
) - 1));
	s64 fp_channel =3D drm_int2fixp(in);

	return drm_fixp2int_round(drm_fixp_div(fp_channel, fp_ratio));
}

When vkms_writeback_row() or plane reading converts an entire framebuffer,
running software-emulated 64-bit divisions per pixel causes severe CPU
stalls and rendering performance degradation on 32-bit architectures.

[1] https://sashiko.dev/#/bug/linux-7999e4a9-b93f-4927-aea8-f7c41dab6826

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-rgb565-tes=
t-v1-0-27f49c1aa694@gmail.com?part=3D1
