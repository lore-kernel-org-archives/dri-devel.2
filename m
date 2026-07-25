Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77759C531F9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 06:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB5CC10E105;
	Sat, 25 Jul 2026 06:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M+6tisAE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4C1510E0BB;
 Sat, 25 Jul 2026 06:02:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpntA/J//38nQa9dZrVdTh4579o5flZbrIgxbh2uIIr/nN57NaMtqtlrmHkXRFEIpE8+46qZFhwKU9FW9pRxjjdQv9upW7e1cyqrK1azA56et2H75kYQGpM6ONNr+7qC9Fh0yeKdCQ2YSG8k5P1NUaHlXeAoTFkiF7oLa3bb1epgXntEnfOUa1zKQdm8NjyC6ND6TZmbMSCCqFM/ienzJu2oolfvctU7VFTL5GjPwoPxRrlEbGXXMgR3zjDH0U0gYQiP61G8yWidVP1e00nrUM8MpDLcxV7E5XkNFWsHzgS8S0//bhbBjbWFEXhkUcrl8PUOCOr52yCk4fCEFJ4tdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibqpycNflMt29e93x9MPj+vtxqHsycTuRgIZfNqvKs4=;
 b=HBAy9LVlBSOR7U1iQG/TiWQ7/f/1I4mHIZIQhmuW1qOHI8Q8cvTg6z+ZD39Chz5h2LnweP2DAmEI9byb9CoxwvoI0q6zcdfCSsyCMOgx0UHTlUz0zWorg1hOrU9KUbExOPRNaEcQ95g9quUzM6E5o2LuEDfQz7BAmRHemQJhcllUsUB2yBGuZ1bIoPrKPrjyKzOFZ6kvZZ2DZdosQBxzJqEUhIyvzxpqx2eK1heLCa8ZS3ZBjmNe5+PysPIgS7wpF/HkwAIGYTqiLjZEtUius2C9ESj3hmtj8zYf77CbVmVnkvlDyO5/oXiCN35FfRmv8MVlsosjLirICuhbtBt2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibqpycNflMt29e93x9MPj+vtxqHsycTuRgIZfNqvKs4=;
 b=M+6tisAEzK8IpwpdR7o9fJnV1NYC3DXIYz2ol3GdBAVc1g2v+lGqQTzW68+Lnn0ihPE4675kCNubeCm4wpGHI6ll0KEq1pmU+8v4L0awt3LhyQrmiB/PgPMf1DH2nZNNuV+zFlT93Nx9HonZxYqyQBvb9cHnbneBls35K3ify64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 06:02:45 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 06:02:45 +0000
Message-ID: <e0b7b3fd-1707-4809-9899-19d1e56bba78@amd.com>
Date: Sat, 25 Jul 2026 00:02:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] drm/vkms: Add KUnit test for YCbCr to RGB
 conversion matrices
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-4-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260722134607.136293-4-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e88cdc-1bc3-48ee-cc90-08deea1258f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 568zpzva53/MsA8XJZtuUJBcmSUmQMXx9VTaIGfrzEa0CX/ltWw4RuD4XQPtS/xet71ZU9rQMkb2psjvwAMjvditRHnMzcoaEkoQy1Jm0nxMUTYT6DpNEevmHbY6Bi0PzcJjI/09Xa/sOUuDnuTEMAuJ1dY4axWZm2lTriNYwUVNwxvEn7iSfudhUXVfNLgnksI6oI9yYKSe2VFTeKGdOB0b369sZzCOWo08l0UWS9o6dPipmPUMAKS6TBrapcLTgCJMZHoLq94jjkP2YaF50e+A1iUu+EUf/XoRJgn12PZei5uVh629EJNh/IXnkuVEW9QpRspr/2Y9rOONyzp1qTzjXPogomrYXMa4SHlhZ3okzcQI95DKet22SWIVrzD60Fr3PTmpgISBLvvZM6pIWgZ4FNKf48iZ/WSzwvIq11FHW3u8RscmecRlsf/I5sP4quwtdTHNjJOP9qlpituEjQRe0jO/Nq2tvZIIi7SS+cTqylGRyFJjtNRH1+ucjFj1hEKyhQla260qnIlSDJy6B9L5Z8n2z+fv84o8lv9kPCbPFyl9Pq2f33pTzCXfC7JMjGB9OXY4V8klk0VXyE/Fd03mylh06/9sVrxDaoUw/xwTseFP6eV8O0jvW4N+0+puN2pcwiQw32IRj5Z5nPFg6fK0pvYS5CfmTXkfx3kOP/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWxqdnVoQi9CWWpsL2dCTVJrQTFNMUM2dWhER054WWNvelUrQlZmWE9wd2JS?=
 =?utf-8?B?OTg4dFEzcy9XSzVUbE1hNkl2NlllMk84UkFrVEdlYTgxQTdxYVQrVUhHWWhR?=
 =?utf-8?B?Sm12MTZsL0hkU2JNM0JxQ21HemhlSE1EOXpmSVNPT29KclpiTDVJQ0R2Z2VT?=
 =?utf-8?B?bm8wTkJIb040YnpzUnNhZ09IcVR0WVo5REZqS1RFTG1uVGFjUGc0QVZzMzBQ?=
 =?utf-8?B?czh6UWtYeGJXcUx4RUVQcCtYVUNCQ0svc3krU2Q4Y3V6REgrZlM1bWtYbFBs?=
 =?utf-8?B?VzZwQnZScjFtWC95eVQxWVdxckNKZlZrVkdlV0lqcnArQVZIV2xibzdkaDVh?=
 =?utf-8?B?NFVCT2tmM0RnTEhHdnVlWXRWSmhNRGFSdnVLMStsTGZYNVpRdUQ0MXFuZlFh?=
 =?utf-8?B?bVFnYkl0Z2NpODlZS0o0cGNJZkRtMWRkL1BCb1kvby9uYVMzVmJUZ0xQTUFE?=
 =?utf-8?B?VUh1bUFJV1FlQ0x4UHJDSDR0a3BVaEtSZDVmSGV2emVJeWdwQlVMN2pobnpL?=
 =?utf-8?B?TTdzR1JrcWl6WlR6NWVHSGpXaGRsbEFWTnBrWHY1eGQrckdQd25waHROVnlo?=
 =?utf-8?B?L3EyYWpFb2dJZ0J2cllHNXpZL3YzRXNuTjZmVHdTZ3U3ZXJSK0hUSGFuQzF6?=
 =?utf-8?B?UkZhbWwzbWk2dDVGKysyWXdxOFR0bmZWQWFCUHdpZXNXOWI2NVRKRGwyZnA1?=
 =?utf-8?B?WXJ1UGJ4M2FaQlRJbndMWmlXNlNMS0NQMUEyRG5wYUFqWVRIUnYzNkt0bGow?=
 =?utf-8?B?Q0dCZ3cycVg5SnpkTFdrMmk0R3NOSW1yUjlPU1ZobG9qN285SER4L1RCR3Z4?=
 =?utf-8?B?QVBQNElyM2s5dURaUng0b0kyM3lqOVkrSXpkSUpra1lEV0JzMjZCczZvSnZt?=
 =?utf-8?B?UXM0SzNIdTMzbjAxeGNjLzIxMXRzdlZTZG1nNTNJWlVPUDc5NGpQcjVOSlVx?=
 =?utf-8?B?MUo2UURmWmYvQ1g4NFZzNU1KNXRDV1ViTi9OdWkyYkpzSjZ1MHl3WDcrTVRX?=
 =?utf-8?B?bEhKd0hVY0JNMmJ2TEd2MzU4b3F1Q2JGVUxSZFdUTjY5VlEyUU9MRHNtdENy?=
 =?utf-8?B?WVZYODFYVHd6a0F0cXd0K1FOSFFXaEZHWWZ1ZkxydkhIbXJZZXY5ZVlmeUlL?=
 =?utf-8?B?WHJFVnJocmhnbTl6TmxIVDh4dkhwSzZpRzArUTRiVnZFTm41TUVGT2NadXVZ?=
 =?utf-8?B?WVBvUUprNTlRaXF6YnQ5S0RiYVJYcWRWWnZEZVJocm90MmxyWW9BTXA5T0p3?=
 =?utf-8?B?V1JmSVRlcXFsL1R1bjZpYWp5U21mRmZ5Q1YwZEJCM0c1NVZVVnJvR1IycWVZ?=
 =?utf-8?B?Ynd3cm1DQnorZVpUcVlRVG1zYXVlaDdSOUViQmJNSFc5TC9ZSlg5QSswWEcr?=
 =?utf-8?B?SDBZL1FzWWRUK0pmTDJwKzB3VTl2L2ZQWHZQMWp4ekhPdVBaYjRDYUdZMDg0?=
 =?utf-8?B?d0ZIcUs3dW4wSGdzYzRzdnQ1M2tRU1ZZTUFqbFdqNG51S1BrNkNMQ3lQbWVI?=
 =?utf-8?B?azFTeVhmNWIvZTY5aERJMTNqanFSM2U1Z2htemszK2FDVFIrbVRDWHhxaWZZ?=
 =?utf-8?B?eW9sWnIwSzBaZzhvUFZBelN0dWpEZCs5dnVwa3oybkZkcEg4NUpwS3E5SnRM?=
 =?utf-8?B?Um1HSGp2VUt5dDZ5emFidlV1alpVNHFlMEJyOTNiZWlvR1BFQ3hhY2JLanNo?=
 =?utf-8?B?WGdMMzFRMlhoVHhVK3R4Z2VwSzJNZUM2OURReVFRNGhRWG5MRU5QODNFZEdJ?=
 =?utf-8?B?VzlUaXhYbFNQanJSM1hyUWNQV00ycVhGZEpUK3hnTy9WblpxOEplTldNRS9o?=
 =?utf-8?B?WXViOUluMnFsNEw5Qmd1anRwcm9pUWZYUTdkRjlIOWFlWERlRExQbitEYjNv?=
 =?utf-8?B?RDRIVXZ2TEE4TVBsN0p6Smc0MSt0cXEwdlpuUHNjWmlCN0EwTzJGcCtaeVlK?=
 =?utf-8?B?cTFSYW9IM3NEc3lVdnh1aXJmTmFTWHdsaDk3WTVKTG13OElYTzRJdkxwUFdM?=
 =?utf-8?B?cHZ5NENUNzNUZVhueUYzWUtpanRiS2xpRkl1TExBTEVsa0RPYVU4Z2hPRHFs?=
 =?utf-8?B?SWlLUFowUUJOUkpNNC9nd1krbmRkdFZicXErOUordXg0ckV6aEkzeXh0QkU2?=
 =?utf-8?B?ODJ5V3d3SlhXdnlsRlM2dlZtcnlFMlpjT3Jyb1pxQXo5eW5ZUVdVVkhTMFN3?=
 =?utf-8?B?dFlGV1F6K2tkT0VmVFhYVnk1V2VjSnBjUk1PYTBSRVlheDlhK1JwUVJRWW04?=
 =?utf-8?B?dzk5bGcxN2tvNjNmZTRUaFJVVURNSlV6bnBxbmJFMDhPL295QVVDemtBZHIw?=
 =?utf-8?Q?c98nAqTZuCO2nzytRM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e88cdc-1bc3-48ee-cc90-08deea1258f0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 06:02:45.7043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thyLe/usxRonbiMlIj0+IvAGtRQRg0HNJOe0VmClIWYWHf9kHZ/OaoqdxRl8D0lZDlSFIbB74Fd72VqWXQngPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF1D04084C7
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 7/22/26 07:45, Harry Wentland wrote:
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

