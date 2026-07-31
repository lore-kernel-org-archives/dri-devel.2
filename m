Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD69C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 15:32:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39C4810F2D7;
	Fri, 31 Jul 2026 15:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mxC3uJ/p";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012022.outbound.protection.outlook.com [40.107.209.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E075510F2D7;
 Fri, 31 Jul 2026 15:32:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIKfWfaNTpER6GfHuS8uI7g8BtmdQpk39jezKI4EwGq7ALe6AVUfvFl6wUURWoUu45PM7VTVJTJt+/piP0OGzpvmaAgv+ZumnUgYrSuw6ol5pqzsWMJBUK3Z2lwR/j00zihI4/xWWGwhJZ9VOhgO1i1JnD+ZeuQ7MiYf0iJr12VsrWPzXRd1ZHYocN6x5p7tCFATCsP4CLK+VXaePSAdUu3p+ZaxxYXhbmlwiKNd8zAeU9j35R4gYSy3/prNcZJYwaTBJjMzn52FlPgLMfpA6RZwTtYq6Q5+R/rFkvPloNs5jT7cWVzhvvsTPyKlero4Zx4kqFjgK8W+4Xr8JU86mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5BdwZ7eWJoL9A+MX8pbJF9gbOrlorRi/KR5wD2u6M0=;
 b=KUlLDBXNNGFGCpW/0KNBnsR3p85pEYN3UxhDGvivB31GDgj/hsUkYaijaguvA0Pi6aDADzwh2YE8XVcm77dQjQ5OQ00RpEFUwCaMiRDxGmeSy0c5EBtzIsPgObFAfoX8T7uiSITZjUR4v7QFzKJOF+h+JKndj8BPdWm2fR+1j8Dhs01BAntrPnDrlFBT0lR6zKLHed08jaWNSCMly/7ANG/7WUDibkkKwbrCBbUj75mq+lTEIeowCq2+RPkGDqBp2d9nMf+DI2JjG+NTw8ruLJ4Qsp7Wa9bAONNiKje7RWn81UqyjsugySGM9PVYJlMsxJ3tjOyO/Z/bBNOHLmfRZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5BdwZ7eWJoL9A+MX8pbJF9gbOrlorRi/KR5wD2u6M0=;
 b=mxC3uJ/pnsd1JkBHyko9eiL0CBoCAqXKmssWh9QHDtTBz4DomrDXf5c/0Z0Gfj1LVnjWZmEFirlEZ64BgOm1ekNi7PT1zUKZHepteSqwiaNPnEmvs0YQTvzIB2PdaKRyg6Gg+iJxUas5kDNFZLtlfMPjuvLJtn4o2OjrkSKNOYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 15:32:04 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 15:32:03 +0000
Message-ID: <b2542af1-a97c-4840-8366-f7e056f7f8d4@amd.com>
Date: Fri, 31 Jul 2026 11:32:00 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] drm/vkms: Add KUnit test for YCbCr to RGB
 conversion matrices
To: Pekka Paalanen <pekka.paalanen@collabora.com>,
 Robert Mader <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-4-harry.wentland@amd.com>
 <f24753a9-43c6-455d-b6b3-20b7fd406fbc@collabora.com>
 <20260730171921.4e819e13@fluorite>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260730171921.4e819e13@fluorite>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0023.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:85::19) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3daa1e04-d229-41cf-7b14-08deef18df38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bjwQq+F5SpPXSePJtzF3U+d1p2njE7J4CsKC0NsBq0/zvenDsryauJ0ckDF6WcV+IxZl5qgmjrxZzh4bgBbaDuVHEsYKzBdwhVZPFqgK/sQG2k7DdTolAOK2JhppnlHjBBB9ocOHJ7MT6tx5VJcXtRxqGPKkNlCZsmeSaIEJUOBxkbyKtCr1dju/LxF2s8c22qrNmaPykk69AYNglaurhYutGpgM2LPJvGsQYHHptgdwFym7Rsmmq9Al8VfLerzicQ0ZG098k5D7CZkoKlEjWnpWoA7erQT4Oc1Hv+Y6yRNHop7fvSt/nOOdJnW8oaE3rS3L2pmT+g+7Ho+zVPuEtF2qD240HIJv76Yu4WLGuqQmAgegVqUoBYNSqBrT2sGKdhIuR/tLVRtwjPwfH+2QV75IlmyLqryYlp42eXMrxQeqsyfSOR10hZFnVl+JC/QDwe63lCuKE+xIoTizCWf7BJQ0oUvVHwNiXQquYqQfnA51/itu8N2ZkMfkr9h5rRh8f4tRdEn1WF66ccp30j4xwpUTavTfEGFFwhs3MsmOt+IGRH8POySgaQw0J1jQzpxFXWK7jJFlCDeaXNvPuhJOCZaOOsGip5/IQeaM/uk36sTHYX/3Y6biz/9sB1zh9ZFIHgEfKZInNK+rwLAiuC9gzeVxrkbWUtcPP8KgLAxumdE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWNFamlOYlBHdzRDMGtBanJmT2MxVk00b1crd2tNNzlPMFBiTDFLbGY2WGpn?=
 =?utf-8?B?TXpraWpIWFB6NkoraUlvc2lheS9FS2x2R2lwMk5zUURWTGJRdkFRRkJGbDla?=
 =?utf-8?B?bUcrdHJzN01Dcm80L2dqOVZqdnpDanBxV2dEemxPZHhoQTVjMXhZeEprV0tX?=
 =?utf-8?B?dWw1R1RMMVhXdWFRMFRHNVRzVy9vR0ZOdmYxaDJSc3VVWVVDaDYrU0duQ1Ru?=
 =?utf-8?B?dGFVbDdTQW5MTTZXSlVvSVBQeG9USmtxaG16bnZoRmdRUFVxVkdNNzFoekhs?=
 =?utf-8?B?bVBBNFNxRmh4WXNhVFlXT3lyTjFBMzIrS2RPVnB3cDdnS2FVZlk3WTBOSnBG?=
 =?utf-8?B?ZEFpanFhOVFYd3pYcVg5a3ZtbmlySkZEWXZPQ2hXZUZLQm9TQ29aSnd5L1ZZ?=
 =?utf-8?B?eGNraGN3Y0lJNUU1b0drUW9EcFlUMU1nelZMOUQ5S2hnOGEzK3ZkUzFYSFdC?=
 =?utf-8?B?NW5BL0lRZWlmcUJPcU9WakRNN0VpZjRZbFdsS215MmZOQllFMDFLL2hRZG9l?=
 =?utf-8?B?ajJ3cms1YlR5V2lYb1orSnhGaTNDY0lKSm04TUMrbk9KQUJWTWFZZzVPYnZq?=
 =?utf-8?B?YlEzczdndU0zTFkweDhHRDN6SUVueXNpc2tFL3I4ZXZ1VEEvSWhZTXRhdWRv?=
 =?utf-8?B?OEJXNFluc2p1eHNSKzF5VTFYcWphUTh6S0MvR0Y3NUgrQURNSjhDU0Iyd0xM?=
 =?utf-8?B?dU9ESWtDcHRSTWM0bTVhVXRHNGg1YnJLSDJLYngyZkkyYnQ1TXdPMURscjZO?=
 =?utf-8?B?T3V1SUFlWVBQQXowdVl0b093ZE1lV2ZweWtET3NlNGQ1NXZSMU1wYmFzMDRS?=
 =?utf-8?B?dEVvT25KUlR3NENtK0dHRWhPc2ltSEVCY0h6cHdrL1Q3d3lPa1pGUW1WVVdJ?=
 =?utf-8?B?dVRLV21qTWRoUjNweEJoQXpHdHZ2K0hYWDdud0kzUFljcWZQZDV4alRWbmI5?=
 =?utf-8?B?NzZrTnRkZEdhQUlCeGtSWlpoaUpjMVhYUTMwaTIvaXpIM1lkcW9DZlNVYTZT?=
 =?utf-8?B?STVRSForSW9rMTR3dk1VL1ord0craTJhTVd0R3dFNzZvdnpkdXZ2TGo1dlgx?=
 =?utf-8?B?TUF0QVFERjZ3endkbmcxU2dudHJWR05UVFBrQy8remllUUJaeFJZSXFTaGtt?=
 =?utf-8?B?T2lUNU1UaXBUOU45Wk95cEpmZmxoanVIUTNleE01V1BZOWtGNHNpb1I4TjZ2?=
 =?utf-8?B?WkZhcFpMQkxGWnpVbjZ1b29acXhqVEhvWWJzV2RxMG1FUDZJbHFtRUhaZjBl?=
 =?utf-8?B?cEZqZGZnNk4wV3VpRkk2WXQvNDIzbUp3S0I4VDc0TVRSbW02aHA1cnFQMzBK?=
 =?utf-8?B?bmNpY0oyNWVLUmt3VWNZUEJVOUdJdnlvdkU3Q0JGR09tRWJIM1ZGY3lkU3pI?=
 =?utf-8?B?ZXNDK3c1YnQ4TGV5eHRjVjhWbWI3bUtNNjMvT1JhTnRIUUVocFExc0dyL1JF?=
 =?utf-8?B?WWs4QjVaN0VjbHVNQkdNZ1dvVGdmK09HSmd0MUluSlh5dGRyNUR3cnlXbWto?=
 =?utf-8?B?alJLMnk1MVgvM2F4U3U2ZjgvU0JxTEgyU3hWYlVLOFVrdmlHR1ZTZVlUbkth?=
 =?utf-8?B?RnRpcDE2dTV1ZENrNTNQRGFVUGw1VXpVSlRybUlXbG9HR281T0M0a0xuQXNs?=
 =?utf-8?B?bjBEZEQyZG5GZGc0cDdkeVY0UHp5U1FwSnhHQTQyNWYwWVdLdEs4ZzY0NE9p?=
 =?utf-8?B?MW1zbC9mbmNSSW1XMG4wWU12TitveTBObDF6cVhvaXBJMnRhNEtwRU9hYjVI?=
 =?utf-8?B?UmlBMkpWUzJ3cW1qTlExajA5QlIrdTB0VzZTL0t2OGt5QjVRYlVIZ296R2RH?=
 =?utf-8?B?TVB3RzhkbmtZMEhKc0NYOFZXeG90amhNWGFPUzc3YkJtalBFaHFMUUF3ZFow?=
 =?utf-8?B?dldiMWRzWnNMdlVnV05GQk9mK1lESDRpa2Q3TW10TU1QcEZwMWpYd3ZaODB3?=
 =?utf-8?B?b1AxWXFGMWUzVTVPdXlmNklWQURrYzM3WGcwYTAwS2FQeGpCa29NYjV3MjNs?=
 =?utf-8?B?aDJnekIyQnFPTXgyeGdpWnBKNEpLOXprNU1aVWtXelNCTVJDQXgweVJmTG54?=
 =?utf-8?B?ektWM1F4b0psOE5zWG93UUFVcms5OWRVQVBOa2NuTWVldTExNVFGd201MzBh?=
 =?utf-8?B?c0pvdUdIZ1Y3ME9QUkxyQlREdU1XNUV6Q0o3M2tqclZjdkk4Zmp3MklTVHRh?=
 =?utf-8?B?Y1Vlc0FjaDB0YUQ2SFpIZmlaVUV1aEk5SkFzRHYySHk5a1lOcjVwM2lTclB4?=
 =?utf-8?B?UWxjRTB0RXJHRUpFMFZoQ1pWNit6YXJoVG9XQkpqODZNVmErYnVleTNQZGJC?=
 =?utf-8?B?bnJXeUZ1Yk82Q20ycEpLZC9OaU1EcEVDc24yT2JvNG10NHRsTjBzQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daa1e04-d229-41cf-7b14-08deef18df38
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 15:32:03.8429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pXgpOTkdz1cJ8suOY/q2JvuCY+TR60+Vi3sv4N3H45MXrmFwCAzNH8kRJAFWYbw1/HJAx+RFbqwGnxRoypGZ7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
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



On 2026-07-30 10:19, Pekka Paalanen wrote:
> On Tue, 28 Jul 2026 17:17:34 +0200
> Robert Mader <robert.mader@collabora.com> wrote:
> 
>> TBH this test feels a bit redundant to me, given that it just repeats 
>> the exact values, which again just get memcpy'd. I suggest to drop it.
> 
> I agree.
> 

Agreed. The goal was to create specific tests that fail with the old
conversion matrices and pass with the new ones but there's little
value in tests that are so specific.

Harry

> If these reference matrices were produced by completely different means
> instead of being checked in as "binaries", e.g. by floating-point
> calculations from first principles at test time, they might have some
> use.
> 
> What would actually be useful is to record the script used to produce
> these "binary" numbers in the first place. It's much easier to review
> such a script, than try to come up with one's own in order to check if
> the "binary" numbers are correct (like I did when reviewing these
> patches).
> 
> I've been wondering, what is the source code - the preferential format
> for modification - the numbers recorded here, or the scripts producing
> them.
> 
> 
> Thanks,
> pq
> 
>> On 22.07.26 15:45, Harry Wentland wrote:
>>> The existing yuv_u16_to_argb_u16 test performs a full RGB->YCbCr->RGB
>>> round trip with a tolerance of 0x1ff. That tolerance is required because
>>> fully saturated primaries clamp their chroma at encode time and cannot
>>> round-trip exactly, but it also makes the test unable to detect small
>>> scaling errors in the conversion matrices (such as using a 2^n instead
>>> of a 2^n - 1 full-range maximum for limited range, an error of ~129 at
>>> gray - below the tolerance).
>>>
>>> Add a parameterised test that checks the exact S31.32 fixed-point
>>> coefficients and luma offset returned by
>>> get_conversion_matrix_to_argb_u16() for each encoding and range against
>>> reference values. This directly pins the matrices and catches
>>> sub-tolerance regressions that the round-trip test cannot.
>>>
>>> Assisted-by: Copilot:claude-opus-4.8
>>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>>> ---
>>>   drivers/gpu/drm/vkms/tests/vkms_format_test.c | 122 ++++++++++++++++++
>>>   1 file changed, 122 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/vkms/tests/vkms_format_test.c b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>>> index 789c59d07ffb..e746b18bf37b 100644
>>> --- a/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>>> +++ b/drivers/gpu/drm/vkms/tests/vkms_format_test.c
>>> @@ -263,8 +263,130 @@ KUNIT_ARRAY_PARAM(yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_cases,
>>>   		  vkms_format_test_yuv_u16_to_argb_u16_case_desc
>>>   );
>>>   
>>> +/*
>>> + * struct conversion_matrix_case - Reference matrix to test the YUV to RGB
>>> + * conversion matrices returned by get_conversion_matrix_to_argb_u16()
>>> + *
>>> + * @encoding: Encoding of the conversion matrix under test
>>> + * @range: Range of the conversion matrix under test
>>> + * @expected: Expected S31.32 fixed-point matrix and luma offset
>>> + *
>>> + * The limited-range coefficients use the studio-range scaling mandated by the
>>> + * DRM UAPI and IGT's igt_ycbcr_to_rgb_matrix(): the narrow range is expanded
>>> + * relative to a full-range maximum of 2^n - 1 (255 for 8-bit), i.e. luma by
>>> + * 255/(235 - 16) and chroma by 255/(240 - 128). Generating them with the
>>> + * common 2^n normalisation (as colour.matrix_YCbCr(is_legal=True) does) is off
>>> + * by a factor of 256/255. See the DRM_COLOROP_FM_YCBCR*_LIMITED_RGB
>>> + * documentation in <drm/drm_colorop.h>.
>>> + */
>>> +struct conversion_matrix_case {
>>> +	enum drm_color_encoding encoding;
>>> +	enum drm_color_range range;
>>> +	struct conversion_matrix expected;
>>> +};
>>> +
>>> +static struct conversion_matrix_case conversion_matrix_cases[] = {
>>> +	{
>>> +		.encoding = DRM_COLOR_YCBCR_BT601,
>>> +		.range = DRM_COLOR_YCBCR_FULL_RANGE,
>>> +		.expected = { .matrix = {
>>> +			{ 4294967296, 0,           6021544149 },
>>> +			{ 4294967296, -1478054095, -3067191994 },
>>> +			{ 4294967296, 7610682049,  0 },
>>> +		}, .y_offset = 0 },
>>> +	},
>>> +	{
>>> +		.encoding = DRM_COLOR_YCBCR_BT601,
>>> +		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>>> +		.expected = { .matrix = {
>>> +			{ 5000989317, 0,           6854882848 },
>>> +			{ 5000989317, -1682606224, -3491669458 },
>>> +			{ 5000989317, 8663946082,  0 },
>>> +		}, .y_offset = 16 },
>>> +	},
>>> +	{
>>> +		.encoding = DRM_COLOR_YCBCR_BT709,
>>> +		.range = DRM_COLOR_YCBCR_FULL_RANGE,
>>> +		.expected = { .matrix = {
>>> +			{ 4294967296, 0,          6763714498 },
>>> +			{ 4294967296, -804551626, -2010578443 },
>>> +			{ 4294967296, 7969741314, 0 },
>>> +		}, .y_offset = 0 },
>>> +	},
>>> +	{
>>> +		.encoding = DRM_COLOR_YCBCR_BT709,
>>> +		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>>> +		.expected = { .matrix = {
>>> +			{ 5000989317, 0,          7699764272 },
>>> +			{ 5000989317, -915895824, -2288828138 },
>>> +			{ 5000989317, 9072696586, 0 },
>>> +		}, .y_offset = 16 },
>>> +	},
>>> +	{
>>> +		.encoding = DRM_COLOR_YCBCR_BT2020,
>>> +		.range = DRM_COLOR_YCBCR_FULL_RANGE,
>>> +		.expected = { .matrix = {
>>> +			{ 4294967296, 0,          6333358775 },
>>> +			{ 4294967296, -706750298, -2453942994 },
>>> +			{ 4294967296, 8080551471, 0 },
>>> +		}, .y_offset = 0 },
>>> +	},
>>> +	{
>>> +		.encoding = DRM_COLOR_YCBCR_BT2020,
>>> +		.range = DRM_COLOR_YCBCR_LIMITED_RANGE,
>>> +		.expected = { .matrix = {
>>> +			{ 5000989317, 0,          7209850391 },
>>> +			{ 5000989317, -804559491, -2793551177 },
>>> +			{ 5000989317, 9198842076, 0 },
>>> +		}, .y_offset = 16 },
>>> +	},
>>> +};
>>> +
>>> +/*
>>> + * vkms_format_test_conversion_matrix - Verify the YUV to RGB conversion matrices
>>> + *
>>> + * This test checks that get_conversion_matrix_to_argb_u16() returns the exact
>>> + * fixed-point coefficients expected for each encoding and range. Unlike the
>>> + * round-trip test above, it is sensitive to small (sub-tolerance) scaling
>>> + * errors such as using a 2^n instead of a 2^n - 1 full-range maximum for the
>>> + * limited-range matrices.
>>> + */
>>> +static void vkms_format_test_conversion_matrix(struct kunit *test)
>>> +{
>>> +	const struct conversion_matrix_case *param = test->param_value;
>>> +	struct conversion_matrix matrix;
>>> +
>>> +	get_conversion_matrix_to_argb_u16(DRM_FORMAT_NV12, param->encoding,
>>> +					  param->range, false, &matrix);
>>> +
>>> +	for (size_t i = 0; i < 3; i++) {
>>> +		for (size_t j = 0; j < 3; j++) {
>>> +			KUNIT_EXPECT_EQ_MSG(test, matrix.matrix[i][j],
>>> +					    param->expected.matrix[i][j],
>>> +					    "matrix[%zu][%zu] mismatch for %s - %s",
>>> +					    i, j,
>>> +					    drm_get_color_encoding_name(param->encoding),
>>> +					    drm_get_color_range_name(param->range));
>>> +		}
>>> +	}
>>> +
>>> +	KUNIT_EXPECT_EQ(test, matrix.y_offset, param->expected.y_offset);
>>> +}
>>> +
>>> +static void vkms_format_test_conversion_matrix_case_desc(struct conversion_matrix_case *t,
>>> +							 char *desc)
>>> +{
>>> +	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "%s - %s",
>>> +		 drm_get_color_encoding_name(t->encoding), drm_get_color_range_name(t->range));
>>> +}
>>> +
>>> +KUNIT_ARRAY_PARAM(conversion_matrix, conversion_matrix_cases,
>>> +		  vkms_format_test_conversion_matrix_case_desc
>>> +);
>>> +
>>>   static struct kunit_case vkms_format_test_cases[] = {
>>>   	KUNIT_CASE_PARAM(vkms_format_test_yuv_u16_to_argb_u16, yuv_u16_to_argb_u16_gen_params),
>>> +	KUNIT_CASE_PARAM(vkms_format_test_conversion_matrix, conversion_matrix_gen_params),
>>>   	{}
>>>   };
>>>     
>>
> 

