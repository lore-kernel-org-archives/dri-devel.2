Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDECC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0955E10E861;
	Tue, 28 Jul 2026 15:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="BoTR8gPP";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE9D110E713;
 Tue, 28 Jul 2026 15:11:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785251477; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NHGlV6NtX30BatGWgnjkodTfwQRV/LAVCcIibCVTiTE9BEBBcc19C5W9I9ZJdZtHe+5LgB32eefI8ZodKtaomPVLtNNDwQEcfgnM2yCozEhvJ/OghxgFBzyVwzNB3zWYg6VgZ4v33GMdViS39VyrStMTM0HWCNMvCzgcDeZzRlc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785251477;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=jYkK6lXlHec/yo2Mdvqq9xeIg01QvKzH13q6ig5pKx4=; 
 b=dcu5Hx0jWK9jQMnNCW6w9ylpjpwcnc18/mosvR+n49Bot35JFJCjaBufxkoGcybFHRsXRp2Y+iYRmVp58WeWLKRqWcv7MIdyD2xkpXLsPAyAyhzy2mQ62/BD39bV1iaeCRGNLSZcOa8QHKKHEP4X1zyn3TjaGsKJ+bCbo0K1G5s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785251477; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=jYkK6lXlHec/yo2Mdvqq9xeIg01QvKzH13q6ig5pKx4=;
 b=BoTR8gPP5ewR9qzxZC3QDv8KECH4AO1982m8Pu7kFC3wkkO/U4x2lvRrhNe5ivps
 6pnImB8u/HUtJ+L4B2gGDg86sSiwj9sdpykvNExFk+gu/yoVm4ygB/rzvERErUwvx3Q
 6bRH+flLjUfnYHhswjwUPJUvxxaD54R364+1/7Fg=
Received: by mx.zohomail.com with SMTPS id 178525147659829.065885387314438;
 Tue, 28 Jul 2026 08:11:16 -0700 (PDT)
Message-ID: <81c2e5ef-0fbb-451d-a1cb-8c1d96ffd656@collabora.com>
Date: Tue, 28 Jul 2026 17:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] drm/vkms: Fix limited-range YCbCr to RGB
 conversion scaling
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-3-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-3-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 22.07.26 15:45, Harry Wentland wrote:
> The limited-/studio-range YCbCr to RGB conversion matrices were generated
> with colour.matrix_YCbCr(is_legal=True, bits=8), which normalises the
> narrow range by 2^bits (256 for 8-bit) rather than by the full-range
> maximum 2^bits - 1 (255). As a result the luma scale was 256/219 and the
> chroma scale 256/224 instead of the correct 255/219 and 255/224.

I'm a bit embarrassed that the Weston CI didn't catch this - looks like 
our "fuzzy" ranges [1] are a bit too high :/

I verified that with this patch the corresponding tests (testing all six 
combinations) still succeed. The reasoning also makes total sense to me 
- but I didn't check the values yet.

Thus for now:

Tested-by: Robert Mader <robert.mader@collabora.com>

1: 
https://gitlab.freedesktop.org/wayland/weston/-/blob/0bb1ce3bd3a6ba1867b52ea0916bb864e26f7300/tests/harness/weston-test-client-helper.c#L2240

>
> This over-scales every limited-range conversion by a factor of 256/255,
> producing an error of up to ~3/255 (8-bit) and causing IGT tests that
> compare software-computed surfaces against VKMS-processed ones to fail.
>
> Recompute the three limited-range matrices from first principles rather
> than relying on colour's is_legal scaling:
>
>   1. Start from the standard ITU-R YCbCr -> RGB relations for the luma
>      weights Kr, Kb (Kg = 1 - Kr - Kb) of each encoding (BT.601, BT.709
>      and BT.2020 non-constant luminance). These are the same relations
>      that produce the existing full-range matrices.
>   2. Expand the studio input range to full range relative to a full-range
>      maximum of 2^n - 1: the luma coefficient by 255/(235 - 16) and the
>      chroma coefficients by 255/(240 - 16). This matches the DRM UAPI
>      definition and IGT's igt_ycbcr_to_rgb_matrix().
>   3. Convert each coefficient to S31.32 fixed point (round(coeff * 2^32)).
>
> The full-range matrices (is_legal=False) are unaffected as they use exact
> 1.0/2.0 scaling.
>
> Update the limited-range reference values in the vkms-format KUnit test
> accordingly: the expected YCbCr inputs now use the studio-range encoding
> consistent with the corrected matrices (8-bit value v placed at v * 257,
> i.e. relative to a full-range maximum of 255).
>
> Fixes: fe22d21e9342 ("drm/vkms: Add YUV support")
> Assisted-by: Copilot:claude-opus-4.8
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 36 ++++++------
>   drivers/gpu/drm/vkms/vkms_formats.c           | 55 +++++++++++++------
>   2 files changed, 55 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> index a7788fbc45dc..789c59d07ffb 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -101,12 +101,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
>   		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>   		.n_colors = 6,
>   		.colors = {
> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> -			{ "red",   { 0x517b, 0x5a34, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> -			{ "green", { 0x908e, 0x35cc, 0x2237 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> -			{ "blue",  { 0x28f7, 0xf000, 0x6dc9 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> +			{ "red",   { 0x51cd, 0x5a8e, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> +			{ "green", { 0x911e, 0x3602, 0x2259 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> +			{ "blue",  { 0x2920, 0xf0f0, 0x6e37 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>   		}
>   	},
>   	/*
> @@ -151,12 +151,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
>   		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>   		.n_colors = 6,
>   		.colors = {
> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> -			{ "red",   { 0x3e8f, 0x6656, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> -			{ "green", { 0xaca1, 0x29aa, 0x1a45 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> -			{ "blue",  { 0x1fd0, 0xf000, 0x75bb }, { 0xffff, 0x0000, 0x0000, 0xffff }},
> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> +			{ "red",   { 0x3ece, 0x66bc, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> +			{ "green", { 0xad4e, 0x29d4, 0x1a5f }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> +			{ "blue",  { 0x1ff0, 0xf0f0, 0x7631 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>   		}
>   	},
>   	/*
> @@ -201,12 +201,12 @@ static struct yuv_u16_to_argb_u16_case yuv_u16_to_argb_u16_cases[] = {
>   		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>   		.n_colors = 6,
>   		.colors = {
> -			{ "white", { 0xeb00, 0x8000, 0x8000 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> -			{ "gray",  { 0x7dee, 0x8000, 0x8000 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> -			{ "black", { 0x1000, 0x8000, 0x8000 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> -			{ "red",   { 0x4988, 0x60b9, 0xf000 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> -			{ "green", { 0xa47b, 0x2f47, 0x1902 }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> -			{ "blue",  { 0x1cfd, 0xf000, 0x76fe }, { 0xffff, 0x0000, 0x0000, 0xffff }},
> +			{ "white", { 0xebeb, 0x8080, 0x8080 }, { 0xffff, 0xffff, 0xffff, 0xffff }},
> +			{ "gray",  { 0x7e6c, 0x8080, 0x8080 }, { 0xffff, 0x8080, 0x8080, 0x8080 }},
> +			{ "black", { 0x1010, 0x8080, 0x8080 }, { 0xffff, 0x0000, 0x0000, 0x0000 }},
> +			{ "red",   { 0x49d2, 0x611a, 0xf0f0 }, { 0xffff, 0xffff, 0x0000, 0x0000 }},
> +			{ "green", { 0xa520, 0x2f76, 0x191b }, { 0xffff, 0x0000, 0xffff, 0x0000 }},
> +			{ "blue",  { 0x1d1a, 0xf0f0, 0x7775 }, { 0xffff, 0x0000, 0x0000, 0xffff }},
>   		}
>   	},
>   };
> diff --git a/drivers/gpu/drm/vkms/vkms_formats.c b/drivers/gpu/drm/vkms/vkms_formats.c
> index dfb8e13cba87..4d5fcaeb82c5 100644
> --- a/drivers/gpu/drm/vkms/vkms_formats.c
> +++ b/drivers/gpu/drm/vkms/vkms_formats.c
> @@ -788,15 +788,36 @@ static const struct conversion_matrix yuv_bt601_full = {
>   };
>   
>   /*
> - * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.601"],
> - *                                  is_legal = True,
> - *                                  bits = 8) * 2**32).astype(int)
> + * BT.601 limited-/studio-range YCbCr to full-range RGB.
> + *
> + * The coefficients are derived as follows:
> + *
> + *  1. Take the standard ITU-R YCbCr -> RGB relations for luma weights
> + *     Kr, Kb (Kg = 1 - Kr - Kb), with Y in [0, 1] and Cb, Cr in
> + *     [-0.5, 0.5]. For BT.601 Kr = 0.299 and Kb = 0.114:
> + *
> + *       R = Y                                + 2 * (1 - Kr)          * Cr
> + *       G = Y - 2 * (1 - Kb) * Kb / Kg * Cb - 2 * (1 - Kr) * Kr / Kg * Cr
> + *       B = Y + 2 * (1 - Kb)          * Cb
> + *
> + *     These are exactly the yuv_bt601_full coefficients above.
> + *
> + *  2. Expand the studio input range to full range, relative to a
> + *     full-range maximum of 2^n - 1 (255 for 8-bit): the luma
> + *     coefficient is scaled by 255/(235 - 16) and the chroma
> + *     coefficients by 255/(240 - 16). This matches the DRM UAPI
> + *     definition and IGT's igt_ycbcr_to_rgb_matrix(). Note this differs
> + *     from colour.matrix_YCbCr(is_legal=True), which normalises by 2^n
> + *     and is thus off by a factor of 256/255.
> + *
> + *  3. Convert each coefficient to S31.32 fixed point, i.e.
> + *     round(coeff * 2^32).
>    */
>   static const struct conversion_matrix yuv_bt601_limited = {
>   	.matrix = {
> -		{ 5020601039, 0,           6881764740 },
> -		{ 5020601039, -1689204679, -3505362278 },
> -		{ 5020601039, 8697922339,  0 },
> +		{ 5000989317, 0,           6854882848 },
> +		{ 5000989317, -1682606224, -3491669458 },
> +		{ 5000989317, 8663946082,  0 },
>   	},
>   	.y_offset = 16,
>   };
> @@ -816,15 +837,14 @@ static const struct conversion_matrix yuv_bt709_full = {
>   };
>   
>   /*
> - * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.709"],
> - *                                  is_legal = True,
> - *                                  bits = 8) * 2**32).astype(int)
> + * BT.709 limited-range YCbCr to full-range RGB (Kr = 0.2126, Kb = 0.0722).
> + * Derived as described for yuv_bt601_limited.
>    */
>   static const struct conversion_matrix yuv_bt709_limited = {
>   	.matrix = {
> -		{ 5020601039, 0,          7729959424 },
> -		{ 5020601039, -919487572, -2297803934 },
> -		{ 5020601039, 9108275786, 0 },
> +		{ 5000989317, 0,          7699764272 },
> +		{ 5000989317, -915895824, -2288828138 },
> +		{ 5000989317, 9072696586, 0 },
>   	},
>   	.y_offset = 16,
>   };
> @@ -844,15 +864,14 @@ static const struct conversion_matrix yuv_bt2020_full = {
>   };
>   
>   /*
> - * numpy.around(colour.matrix_YCbCr(K=colour.WEIGHTS_YCBCR["ITU-R BT.2020"],
> - *                                  is_legal = True,
> - *                                  bits = 8) * 2**32).astype(int)
> + * BT.2020 non-constant-luminance limited-range YCbCr to full-range RGB
> + * (Kr = 0.2627, Kb = 0.0593). Derived as described for yuv_bt601_limited.
>    */
>   static const struct conversion_matrix yuv_bt2020_limited = {
>   	.matrix = {
> -		{ 5020601039, 0,          7238124312 },
> -		{ 5020601039, -807714626, -2804506279 },
> -		{ 5020601039, 9234915964, 0 },
> +		{ 5000989317, 0,          7209850391 },
> +		{ 5000989317, -804559491, -2793551177 },
> +		{ 5000989317, 9198842076, 0 },
>   	},
>   	.y_offset = 16,
>   };

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

