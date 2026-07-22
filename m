Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70194C44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD13710EDAD;
	Wed, 22 Jul 2026 14:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iS2HBzZc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 624DB10EDAD
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:01:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0ED540A71;
 Wed, 22 Jul 2026 14:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C8D1F000E9;
 Wed, 22 Jul 2026 14:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784728911;
 bh=3WI8Zf0J6/vDjk7W4+p9lAv/B7zXUqzMCPi2qCULAfE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iS2HBzZc1kp9Wg9rxjHjteMAi64VcfEamnrhW+dIXpX64q4b+E20cVeH29p81HkAe
 InVTzjZuV/dfxAzojI3iJq95Wy59xeJ49DBCZDmm19xLhKNeK0G7QSpAb3UNJ5iP/Y
 Y6nqKQG+z/69yQSLwxi6426Mu3e+F5ewMAGSYHdKSByIMqh0B7YN+EGGhezjHFhm/g
 TMYqNdnodVWJFxJoqfuoOCgrjolD2SLJsXpBC8N+eDnv9zldNDdEO6pttj6YhjOKKy
 cLuQ5Nn02gMoFBJySKOAtpyhw1mH+C7ojKItnR3lSXJBVbGIKaBQ3N1n9Ic+vnwT1V
 ZPv9t3QF0snoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/11] drm/vkms: Add KUnit test for YCbCr to RGB
 conversion matrices
To: "Harry Wentland" <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722134607.136293-4-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-4-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:01:51 +0000
Message-Id: <20260722140151.A9C8D1F000E9@smtp.kernel.org>
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
- [Low] Compilation error due to function signature mismatch in KUnit test
--

--- Patch [3]: [PATCH v4 03/11] drm/vkms: Add KUnit test for YCbCr to RGB c=
onversion matrices ---
commit dd6b42b44f3cdb2524b236663ae684d8ead8a59a
Author: Harry Wentland <harry.wentland@amd.com>

drm/vkms: Add KUnit test for YCbCr to RGB conversion matrices

The existing yuv_u16_to_argb_u16 test performs a full RGB->YCbCr->RGB round
trip with a tolerance of 0x1ff. This patch adds a parameterised test that
checks the exact S31.32 fixed-point coefficients and luma offset returned by
get_conversion_matrix_to_argb_u16() against reference values.

> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/=
drm/vkms/tests/vkms_format_test.c
> index 789c59d07ffb6..e746b18bf37b0 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
[ ... ]
> +static void vkms_format_test_conversion_matrix(struct kunit *test)
> +{
> +	const struct conversion_matrix_case *param =3D test->param_value;
> +	struct conversion_matrix matrix;
> +
> +	get_conversion_matrix_to_argb_u16(DRM_FORMAT_NV12, param->encoding,
> +					  param->range, false, &matrix);

[Severity: Low]
Will this compile when the VKMS KUnit tests are enabled?

The newly added test code calls get_conversion_matrix_to_argb_u16() with 5
arguments, passing false as the 4th argument. However, the function signatu=
re
in vkms_formats.h only accepts 4 arguments, which will cause a 'too many
arguments to function' compiler error.

> +
> +	for (size_t i =3D 0; i < 3; i++) {
> +		for (size_t j =3D 0; j < 3; j++) {
> +			KUNIT_EXPECT_EQ_MSG(test, matrix.matrix[i][j],
> +					    param->expected.matrix[i][j],
> +					    "matrix[%zu][%zu] mismatch for %s - %s",
> +					    i, j,
> +					    drm_get_color_encoding_name(param->encoding),
> +					    drm_get_color_range_name(param->range));
> +		}
> +	}
> +
> +	KUNIT_EXPECT_EQ(test, matrix.y_offset, param->expected.y_offset);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722134607.1362=
93-1-harry.wentland@amd.com?part=3D3
