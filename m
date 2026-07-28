Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6595C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:17:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08CE210E95E;
	Tue, 28 Jul 2026 15:17:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="Tyv1jQvY";
	dkim-atps=neutral
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com
 [136.143.188.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8303010E95D;
 Tue, 28 Jul 2026 15:17:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785251859; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OY+xcp1qPjdaWbDgiEqtg8Rm8DRVYbGIOzGYHwmAm5Cb9qsqVqh/dgzlWS24dSSD1HVtjeJPOCcVQKo1kpxr1R6uOOGZYHfTJNip752NERBpzGpD4XYwuRcDBKu3Qv1evBckS4k4+WJ7ywvcQfaMex/8M7m/esED6P8xD11V6y8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785251859;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=/3245s+WIJM5WfX9Sovv9ivArZH82MVlC2lkJGR8Wjk=; 
 b=mb0s4ooPYw7mVLWeWn1I1GBIGPs9Tfaww468Xsc7UAr1+5EDjaOXSf3IhIjCLXtz24g7m3NgyZ7UHvZ/j6HZPX/N8sDRG1h/nUhrteu7GPtMg1JVidlMsTdhxaA2OzcGMopRCwYs0ad7SluAw4ShspgFC1pMj8zWEXZIltBCbq8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785251859; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
 bh=/3245s+WIJM5WfX9Sovv9ivArZH82MVlC2lkJGR8Wjk=;
 b=Tyv1jQvYo8Uql8P4q7qYEvPYW3sw+Ih+lroFgOlA3MN+phNOev3IWOUCrWnBpBOG
 87pyvTcpcXL5dKDaoUQ6r2XZTeYBApTwcW/SeirLEjkqpry6gzGOGvH4KMrvHbxjGT+
 i8fdtlAEqfMO+HPGBy7EruztwTQlSjliYk9D1Pb8=
Received: by mx.zohomail.com with SMTPS id 1785251856894116.72725239123395;
 Tue, 28 Jul 2026 08:17:36 -0700 (PDT)
Message-ID: <f24753a9-43c6-455d-b6b3-20b7fd406fbc@collabora.com>
Date: Tue, 28 Jul 2026 17:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] drm/vkms: Add KUnit test for YCbCr to RGB
 conversion matrices
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-4-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-4-harry.wentland@amd.com>
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

TBH this test feels a bit redundant to me, given that it just repeats 
the exact values, which again just get memcpy'd. I suggest to drop it.

On 22.07.26 15:45, Harry Wentland wrote:
> The existing yuv_u16_to_argb_u16 test performs a full RGB->YCbCr->RGB
> round trip with a tolerance of 0x1ff. That tolerance is required because
> fully saturated primaries clamp their chroma at encode time and cannot
> round-trip exactly, but it also makes the test unable to detect small
> scaling errors in the conversion matrices (such as using a 2^n instead
> of a 2^n - 1 full-range maximum for limited range, an error of ~129 at
> gray - below the tolerance).
>
> Add a parameterised test that checks the exact S31.32 fixed-point
> coefficients and luma offset returned by
> get_conversion_matrix_to_argb_u16() for each encoding and range against
> reference values. This directly pins the matrices and catches
> sub-tolerance regressions that the round-trip test cannot.
>
> Assisted-by: Copilot:claude-opus-4.8
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 122 ++++++++++++++++++
>   1 file changed, 122 insertions(+)
>
> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> index 789c59d07ffb..e746b18bf37b 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
> @@ -263,8 +263,130 @@ KUNIT_ARRAY_PARAM(yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_cases,
>   		  vkms_format_test_yuv_u16_to_argb_u16_case_desc
>   );
>   
> +/*
> + * struct conversion_matrix_case - Reference matrix to test the YUV to RGB
> + * conversion matrices returned by get_conversion_matrix_to_argb_u16()
> + *
> + * @encoding: Encoding of the conversion matrix under test
> + * @range: Range of the conversion matrix under test
> + * @expected: Expected S31.32 fixed-point matrix and luma offset
> + *
> + * The limited-range coefficients use the studio-range scaling mandated by the
> + * DRM UAPI and IGT's igt_ycbcr_to_rgb_matrix(): the narrow range is expanded
> + * relative to a full-range maximum of 2^n - 1 (255 for 8-bit), i.e. luma by
> + * 255/(235 - 16) and chroma by 255/(240 - 128). Generating them with the
> + * common 2^n normalisation (as colour.matrix_YCbCr(is_legal=True) does) is off
> + * by a factor of 256/255. See the DRM_COLOROP_FM_YCBCR*_LIMITED_RGB
> + * documentation in <drm/drm_colorop.h>.
> + */
> +struct conversion_matrix_case {
> +	enum drm_color_encoding encoding;
> +	enum drm_color_range range;
> +	struct conversion_matrix expected;
> +};
> +
> +static struct conversion_matrix_case conversion_matrix_cases[] = {
> +	{
> +		.encoding = DRM_COLOR_YCBCR_BT601,
> +		.range = DRM_COLOR_YCBCR_FULL_RANGE,
> +		.expected = { .matrix = {
> +			{ 4294967296, 0,           6021544149 },
> +			{ 4294967296, -1478054095, -3067191994 },
> +			{ 4294967296, 7610682049,  0 },
> +		}, .y_offset = 0 },
> +	},
> +	{
> +		.encoding = DRM_COLOR_YCBCR_BT601,
> +		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
> +		.expected = { .matrix = {
> +			{ 5000989317, 0,           6854882848 },
> +			{ 5000989317, -1682606224, -3491669458 },
> +			{ 5000989317, 8663946082,  0 },
> +		}, .y_offset = 16 },
> +	},
> +	{
> +		.encoding = DRM_COLOR_YCBCR_BT709,
> +		.range = DRM_COLOR_YCBCR_FULL_RANGE,
> +		.expected = { .matrix = {
> +			{ 4294967296, 0,          6763714498 },
> +			{ 4294967296, -804551626, -2010578443 },
> +			{ 4294967296, 7969741314, 0 },
> +		}, .y_offset = 0 },
> +	},
> +	{
> +		.encoding = DRM_COLOR_YCBCR_BT709,
> +		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
> +		.expected = { .matrix = {
> +			{ 5000989317, 0,          7699764272 },
> +			{ 5000989317, -915895824, -2288828138 },
> +			{ 5000989317, 9072696586, 0 },
> +		}, .y_offset = 16 },
> +	},
> +	{
> +		.encoding = DRM_COLOR_YCBCR_BT2020,
> +		.range = DRM_COLOR_YCBCR_FULL_RANGE,
> +		.expected = { .matrix = {
> +			{ 4294967296, 0,          6333358775 },
> +			{ 4294967296, -706750298, -2453942994 },
> +			{ 4294967296, 8080551471, 0 },
> +		}, .y_offset = 0 },
> +	},
> +	{
> +		.encoding = DRM_COLOR_YCBCR_BT2020,
> +		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
> +		.expected = { .matrix = {
> +			{ 5000989317, 0,          7209850391 },
> +			{ 5000989317, -804559491, -2793551177 },
> +			{ 5000989317, 9198842076, 0 },
> +		}, .y_offset = 16 },
> +	},
> +};
> +
> +/*
> + * vkms_format_test_conversion_matrix - Verify the YUV to RGB conversion matrices
> + *
> + * This test checks that get_conversion_matrix_to_argb_u16() returns the exact
> + * fixed-point coefficients expected for each encoding and range. Unlike the
> + * round-trip test above, it is sensitive to small (sub-tolerance) scaling
> + * errors such as using a 2^n instead of a 2^n - 1 full-range maximum for the
> + * limited-range matrices.
> + */
> +static void vkms_format_test_conversion_matrix(struct kunit *test)
> +{
> +	const struct conversion_matrix_case *param = test->param_value;
> +	struct conversion_matrix matrix;
> +
> +	get_conversion_matrix_to_argb_u16(DRM_FORMAT_NV12, param->encoding,
> +					  param->range, false, &matrix);
> +
> +	for (size_t i = 0; i < 3; i++) {
> +		for (size_t j = 0; j < 3; j++) {
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
> +
> +static void vkms_format_test_conversion_matrix_case_desc(struct conversion_matrix_case *t,
> +							 char *desc)
> +{
> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
> +		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(t->range));
> +}
> +
> +KUNIT_ARRAY_PARAM(conversion_matrix, conversion_matrix_cases,
> +		  vkms_format_test_conversion_matrix_case_desc
> +);
> +
>   static struct kunit_case vkms_format_test_cases[] = {
>   	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_gen_params),
> +	KUNIT_CASE_PARAM(vkms_format_test_conversion_matrix, conversion_matrix_gen_params),
>   	{}
>   };
>   

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

