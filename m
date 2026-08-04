Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DA8C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC22210E06B;
	Tue,  4 Aug 2026 20:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fxfML3WO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 662FA10E06B
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:47:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF92C600AA;
 Tue,  4 Aug 2026 20:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC1C1F000E9;
 Tue,  4 Aug 2026 20:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785876469;
 bh=eoqiOsSEROFCfOAtAfZQG2+N5Zis3ypA+6rvkT30SJU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fxfML3WOsrxtRgAIOV5U4nNaDV12Uegpm/W76qYBHB0KOIpWyHV1V2oP1toG/aUYk
 rlMHH24J517EOup0FYuKyYr9S9nLThiW8WI9DasgrrDmKab8Bq48jBPY5AnKICbb6l
 DT+WjvPY0w8kLwgBV6r6BaLUcRfogS93nOX5Hy5o3XAXmwccKK9Uz9FyoVlgCQMxPl
 8jhDZ5io4JNfAxlkpHaEfjjuTBFngzDcgf855zr/S9pjaT5H7L04U2jm+Xt8+VFCc6
 njopt+wvqvIXK7uglUV8piiK1nW85wOT3fo2HzMZsDX6J19V0gs8MBdyL/hJdyXCht
 Uns83HNxzQxSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/11] drm/vkms: rename get_lut_index() to
 get_uniform_lut_index()
To: "Leandro Ribeiro" <leandro.ribeiro@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804203351.148521-8-leandro.ribeiro@collabora.com>
References: <20260804203351.148521-1-leandro.ribeiro@collabora.com>
 <20260804203351.148521-8-leandro.ribeiro@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 20:47:48 +0000
Message-Id: <20260804204748.EBC1C1F000E9@smtp.kernel.org>
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
- [Medium] Test coverage for linear LUT interpolation was severely reduced =
due to a mismatched scaling factor.

Pre-existing issues:
- [High] Incorrect element size used for gamma LUT validation in atomic che=
ck rejects valid LUTs on 32-bit platforms.
--

--- Patch [7]: [PATCH 07/11] drm/vkms: rename get_lut_index() to get_unifor=
m_lut_index() ---
commit e4d9729afe7e5d9d0339bd7d09cfdb05b9aad78b
Author: Leandro Ribeiro <leandro.ribeiro@collabora.com>

drm/vkms: rename get_lut_index() to get_uniform_lut_index()

In the next commits we'll add non-uniform LUTs, and this function will
be used exclusively by uniform LUTs. So rename it to make this clearer.

> diff --git a/drivers/gpu/drm/vkms/tests/vkms_color_test.c b/drivers/gpu/d=
rm/vkms/tests/vkms_color_test.c
> index cfcd7e8e76407..bb9d84377b979 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_color_test.c
> @@ -86,31 +86,31 @@ static const struct vkms_color_lut test_linear_lut =
=3D {
>  	.channel_value2index_ratio =3D 0xf000fll
>  };

[Severity: Medium]
In drivers/gpu/drm/vkms/tests/vkms_color_test.c:vkms_color_test_linear(), t=
he
multiplier is set to 0x101:

	for (int i =3D 0; i < test_linear_lut.lut_length; i++) {
		int linear =3D apply_lut_to_channel_value(&test_linear_lut, i * 0x101, LU=
T_RED);

		KUNIT_EXPECT_EQ(test, DIV_ROUND_CLOSEST(linear, 0x101), i);
	}

Since the new 16-element LUT has a step size of 0x1111, do we need to update
the 0x101 multiplier to match?

Currently, the 16 test iterations only reach up to 15 * 0x101 =3D 0xF0F. Be=
cause
the first interval spans from 0x0 to 0x1111, all test iterations fall entir=
ely
within the very first interpolation interval, leaving over 90% of the chann=
el
range untested.

[ ... ]

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but I noticed a potential problem in vkms_atomic_check() in
drivers/gpu/drm/vkms/vkms_drv.c:

	if (new_crtc_state->gamma_lut->length / sizeof(struct drm_color_lut *)
	    > VKMS_GAMMA_LUT_SIZE)
		return -EINVAL;

Does this calculation correctly determine the number of elements?=20

The blob length is divided by the size of a pointer
(sizeof(struct drm_color_lut *)) instead of the size of the structure itself
(sizeof(struct drm_color_lut)). On 32-bit architectures, this doubles the
calculated element count and causes valid atomic commits containing a full
gamma LUT to be rejected with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804203351.1485=
21-1-leandro.ribeiro@collabora.com?part=3D7
