Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BAFC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B433310EBC9;
	Tue,  4 Aug 2026 20:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q+dFdrG+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E280710EBC9
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:42:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8B82341AEE;
 Tue,  4 Aug 2026 20:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EEA1F000E9;
 Tue,  4 Aug 2026 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785876157;
 bh=TrP27D0fSTImEBhUioGj8feGNsdtko/BvrshrefOhrk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Q+dFdrG+tTKpt3YNRm+RO8K5Wep+1+kjBqR/rJRlVzBjJ7/nV8R3mEI/RNuaE9TnV
 MDgp7jiiuxLrtqHBunH/dgYs4ia+QkWgs26taG51FMStlWiZoolU/g5cdhTpP2RFdA
 ZtFCVaF/IxN/Z7Dzpl4mPK1ciMj8751JiYeCHyP7c4d98WRR7/zDSQTLl0ODbmNhPC
 0NrnEidp6mxJnQVw8WM90DynKFEjIiy4TXZsRZnhPJqnSYWuIRFhQeyzcIUXFKkEAy
 qr9OQTcm3AgcSZDouqt8txbuSkjOpoVyPzo3Yg+2CUamv9jfTm63j/oBq1jXguaAxJ
 oqQ4hZZebsvsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/11] drm/vkms: remove linear_eotf
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804203351.148521-5-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
 <20260804203351.148521-5-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:42:36 +0000
Message-Id: <20260804204237.43EEA1F000E9@smtp.kernel.org>
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
- [Medium] The `vkms_color_test_linear` KUnit test loop relies on a hardcod=
ed multiplier of `0x101` that was designed for a 256-element LUT. The patch=
 replaces `linear_eotf` (256 elements) with `test_linear_lut` (16 elements)=
 without adjusting the multiplier. Since the loop now only executes 16 time=
s (`i` from 0 to 15), the evaluated channel values only range from `0x0000`=
 to `0x0F0F` (~5.8% of the 16-bit color space). The test fails to exercise =
the remaining 94% of the color range and leaves 14 out of the 16 elements o=
f `test_linear_lut` completely untested. To restore proper test coverage ov=
er the `0x0000` to `0xFFFF` range, both instances of `0x101` should be upda=
ted to `0x1111` (since `15 * 0x1111 =3D 0xFFFF`).
--

--- Patch [4]: [PATCH 04/11] drm/vkms: remove linear_eotf ---
commit e4769cf1ca6d6dd3c89f50766f7a24a69c53cccb
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

drm/vkms: remove linear_eotf

This patch removes the linear_eotf LUT, which was only used for testing,
and updates the kunit color tests to use test_linear_lut instead.

> diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/d=
rm/vkms/tests/vkms_color_test.c
> index 3489513af3527..28614edb8eb18 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> @@ -126,8 +126,8 @@ static void vkms_color_test_lerp(struct kunit *test)
> =20
>  static void vkms_color_test_linear(struct kunit *test)
>  {
> -	for (int i =3D 0; i < linear_eotf.lut_length; i++) {
> -		int linear =3D apply_lut_to_channel_value(&linear_eotf, i * 0x101, LUT=
_RED);
> +	for (int i =3D 0; i < test_linear_lut.lut_length; i++) {
> +		int linear =3D apply_lut_to_channel_value(&test_linear_lut, i * 0x101,=
 LUT_RED);

[Severity: Medium]
Since the new test_linear_lut only has 16 elements (compared to the 256
elements in linear_eotf), does leaving the multiplier as 0x101 mean we
only test values up to 0x0f0f (~5.8% of the 16-bit color space)?

Should both instances of 0x101 in this loop be updated to 0x1111 so that
the final iteration (15 * 0x1111) reaches 0xffff, restoring coverage over
the full color range?

> =20
> -		KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(linear, 0x101), i);
> +		KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(linear, 0x101), i);
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203351.1485=
21-1-leandro.ribeiro@collabora.com?part=3D4
