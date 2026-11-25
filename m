Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7697D606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XSPH4Mv3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 948F110E260;
	Wed, 25 Nov 2026 03:43:05 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 122F510E260;
 Wed, 25 Nov 2026 03:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DV1BxeFjJqnXUwYL9WHaHlR6OMRYekcTxTgqEZLYcw/C8t4HRwoyrNjjJAyiazI6PRq08v5cmtLApwUv83Mop/+hMyMRg0S8TlGWuYqXTYx69H64TM8XV6YQaPJiXyOGS8a70MrG2AoEJk6YtonATzCuR7tl9Cm+cb6lbSov7TKJIXDQavjDCxZypW0JFTEMlomk7GWTVvUY54uyxVd9cu1JLgrYQczaMpHpigUSUsn7ppiEmaelATdhQcpLgYHrMM6RbKUlOmfszZxewmlx+mQUUDnH1Tmsycxf/TukiD0Fzf858KMcfI/xyVtqylbize+zini+5IhwIWe8cuNpiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkisJFm7J7jvk9iBpDUlZNSJQb9zWXi/927zMo9LQLo=;
 b=YSHo+kFV3I7k2sk0yxO6fE06qkPRlIQ4WM5EkUKv7C3kVCZdLW/yfvA1fyBFEKVqF4qY7tX9NOE2pVb2O4CLyiZipFRmqcnLPIc4Qwc1boCysTpDhovyULNjjbgi1vkuruba6tZJ3p7jMC1y6dJDxbEk2Ub1j6HT8Edtb3+xSiM33KsGpbIHUj3ASC35OLGyTaSTFqaoQK5jHTmy19ScmPei4f5PaduFC4s1aG9tJAiqaiQlVorcfH1XMKnK0edWlGzZ9GjTdDxlfYU6ptCoOiGCP0BKKGOSas4I54R/nalCVlC6BIrEBybMeKTO3O0LQzggWD69L82JbgBWyvT0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkisJFm7J7jvk9iBpDUlZNSJQb9zWXi/927zMo9LQLo=;
 b=XSPH4Mv36AWVZ7WWu0Hbx/cj4wxMBYqWE0TG1BPrhlPEmvNIG8uz/tKnxvW/gvbYxX3MnIXPhZcVDMg4EG6iK0pslrNgW0gN+K5ejf+qAog5sQyT74p08nISaKJKQPOm1F2fYBrcfNn4U8FxVK9TREO/+7GnK8vdbY2wmFE6Yaw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18)
 by MN6PR12MB8590.namprd12.prod.outlook.com (2603:10b6:208:47c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 03:42:56 +0000
Received: from MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321]) by MW6PR12MB8705.namprd12.prod.outlook.com
 ([fe80::e75b:745c:ed13:f321%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:42:55 +0000
Message-ID: <ba6644ce-ee2f-42d6-aec2-3a29c0d897ac@amd.com>
Date: Tue, 24 Nov 2026 21:42:52 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] drm/amd/display: Use the wide curve for gamma 2.4
 and 2.6
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20261119195158.2546927-1-harry.wentland@amd.com>
 <20261119195158.2546927-3-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20261119195158.2546927-3-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0340.namprd03.prod.outlook.com
 (2603:10b6:303:dc::15) To MW6PR12MB8705.namprd12.prod.outlook.com
 (2603:10b6:303:24c::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8705:EE_|MN6PR12MB8590:EE_
X-MS-Office365-Filtering-Correlation-Id: 078acbe3-2d5f-44f3-0688-08df4aa62fe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|10067099003|11063799006|4143699003|56012099006|261021123027099003|261009223027099003|261021121427099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: R91LPy9kfTtmTVb8nNwQS+oMDI6KkovscnBqfd8CBoN4ww+1CMR7x2B55333vOyFSBUn/s9GYNOakDEtFDtTl7IvQhMPe3dWwl7NetivHFwz0QV0Qb6qoxi9t7rdjZlSdPS7qyhbMuQgFoMPsvRX7IhtjTYk0LxLogZTqYFfhg3UJbH3BKBzs9bWmmci+HsPJESxw0yI6gxeK/FzIaGCLRRg6YenAzXm58HZJgrQdAGYeywhPWHZmR2kahZkiY6gvQErL+IGqPbZfD+7cR/HhFA+ngL9ly6wkyPsc8NjnJJjXkJkYjXSdnec9EDFhurHkzTbi7u019OdqukObcsL5odxbzjsSgUaPdc/cRVuGwodxbkbalVIbFui5NoA+4Zlc2NR5FRbK2vUXy75LETlIN6LSVcABiL/Dhfjhq0xdZKiD68gVNvWJxCX9cwn9Jgt2GHw0FwLlXEKVFNmHYeK4R3o0NrrtFBq9QeL0mjgeaiQSyneen6hP3GgYzHD1tBGgXAUoPVPaw0dhA3jcILoln63NOMWTnRM/P8St6P408Ofo83FL0xsD6MtJ1jI82pRTs5EQtIKPHqDlk3GGarJMs8h3lQfNaECcYazZ73VQ94vJqz4EiKbVK+7RsFM3vlVpjfqILQoT7XM8HE1h9xLY7LS2AJkHfqzaXt9nM9ybn4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW6PR12MB8705.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261009223027099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkNqZVFQa1dkSTFLSXNEOTkwUGpweGEyV3VWYjV0ZGcyRkUvdUp0RzF1Tzk0?=
 =?utf-8?B?R3FNZUVFR1FKYWIrTWIrWElmaENXbGVhWklGcmljZHFSMitJYWtIak5PdHZm?=
 =?utf-8?B?QmE2WWQrNWcrYmZ3Wlc0bWJzc3YxWW1wVEZGcHN4ek9vMXVwd3g3dzZ3V3py?=
 =?utf-8?B?bisvN0h1cThEU0o5eW1Ob0xkdC9kaElqSzJNeDN6cUxtMkRtN0V1aE9GN1ov?=
 =?utf-8?B?Mmd1d1JLaGYyVzVyUFlieWQyNE0yZHFVQUw1UEhDS00yelBYeFN4NjQ3Uk92?=
 =?utf-8?B?MGRqU0NjZHJjN3ArZzBrS2NsYm1FTTVIRC9ud01aM2RpTmxlNnM2dUhsR0lV?=
 =?utf-8?B?b2RYemhRaWN6alpPeVRnTFE0aUpsTGpyL2NlMEcxYktnSnZTNmFHMHhmbitz?=
 =?utf-8?B?Y1pFQlpMU3Rhc2M2RUM0QUYzUm9SWGJwcUExQ0FjcXRuRGtiL2d4TXhteUds?=
 =?utf-8?B?clM1b0t2MVUyMDVtbXlyblpDOXhzYmw1RG9IVVFoczZaaDV2ZEJ6Z3VLMkpM?=
 =?utf-8?B?amd5akl0c212UjhNeVFRRHRrYndTTy9abnkrTy9oeVBXWXJESW9GNVZ2ZmJ2?=
 =?utf-8?B?YmJpa29YWGFDUGhGeFlpcXd5SGxUMmY2SDV0UWlGamtBNWR0a001RDJOdWV6?=
 =?utf-8?B?NWFsUzJyL1E2SHpRQU5Xci9QYUgrMUtkM1JNZjc4NnFUbmhqRlB5QVJlbmJn?=
 =?utf-8?B?VFVNaUZMYmtac2VXZzZQRkEvZGJnU2Nzd2daeXEzYUFhNExKSXhydVZiRGV2?=
 =?utf-8?B?YVRDMGFOZXNUU2lvc0luWWNTdXJha0g1eUJIUlo0YzVIN2x6elNwY0pkUFl4?=
 =?utf-8?B?bU1aOXNsdHNrcFpBbkVXOFpkNlZJOUxkL0MrY1JGRS9OZ2x3RVUxNE5ocnNF?=
 =?utf-8?B?WVNHK2dpVi9IUDdsTjNIVGFwRHlsbVdxODBUclNXYTluMkpLWWd0YTMwUHNE?=
 =?utf-8?B?eFB1cmdKNTVEcmNSM3ZNa1laUjRKckx2ZmQ4YlVSdlh4N3ZpNG85OURwZmlB?=
 =?utf-8?B?OXFycVdCOVFScGFZRmlZNkpsZ2F0Z2ZVNi81UFc1WWd4V084NnhLY1FxNjBZ?=
 =?utf-8?B?ODlBcmRqb0hsMExEdStDLzhKWDVBZTNUaWh0aFl4dzVEekdka3N6MFVWS1lW?=
 =?utf-8?B?ZHhla2dETXdqVEIvTFExR0xaaCtTUCs3cnFvRlQ4TFI2eWVTRzZ1aUJYZDhM?=
 =?utf-8?B?N2VGZHZIM0MyYUpub2w0VTNuUTU1dEFMS0liczRIempWREcxTFNLeVQ0YnJh?=
 =?utf-8?B?Vk1tYmQyc0FTTEx5QjNPb1dNS0pwelZMbzVONUMwbTBVU3VpU1pGQWxyOC9M?=
 =?utf-8?B?T09BbytrOHNMRkFKOUpqaUFXTERLUmpUbkJ0b2NXalN4M21NVWVoVDQ3c3FO?=
 =?utf-8?B?TFZZYUVmRGJhNGJlSm5BSy9CazV6ZE9PaFRPL0Q0NjZIUjkzNlNsYVEzczJE?=
 =?utf-8?B?akpQWVN4VWRMSzZURzlPY2NJNU9wL1ppcGthR0ZGaXRXVUpTbHk0bXg3VXZx?=
 =?utf-8?B?cVlCdExCQnEydTNjOTBld0QvcUtvTHVFQjEyTDNTL1owaWZYWUVXS29UYnBq?=
 =?utf-8?B?dEdpY01KNDZmSjVGczJWaVdVOUlxaVJMQzQwa3UwTFA0dHJReVI3WWdybTAr?=
 =?utf-8?B?TjgxU3N2L0EwYXlGZUoxN1QrSGl0Ry85N1hhMmxmdC9FYjRxdGJSYkFueDFE?=
 =?utf-8?B?dXBsR096cmhXNXFLbkppZWZVL2hGaGNnMVNGMmEyak03YXh2eklhdzBXT3M5?=
 =?utf-8?B?UUxUdktLSzJaVmd6VFpGeGsyTUs2OWJ5ck9VMWdYTFB3aHh2elZNSU5TS3E4?=
 =?utf-8?B?UFlSZG5FZmU4MnZyV2hHaE5YR0tSZ08zc29mcWxXNjY2THUwTENzNE1mOENx?=
 =?utf-8?B?WGtzeDM5K1N0YzNtVG01SnA3R3BReWxTd0hGSXBPb0JETDlUQlVHWDUya3dJ?=
 =?utf-8?B?QlU5MXN0cHBabkFCVEwzbVJCZDF2TGN1WFlTdGxEYTZ0amFyWmVXOEc4b0xo?=
 =?utf-8?B?SVJ5dDFSSmRJZ0d0VGpnNVZGSVo4WC9SdlB1L2p4WVlSV0srL0VWN3hZTndS?=
 =?utf-8?B?WjRwRjlkWDd5Sk43QUhDaTFvMzhod3Vyb2x2YUtnanNpK3NLR2dyUkdqT1gy?=
 =?utf-8?B?NENFSG8zR2NuWE1UOHZnYmd1V2F0dHh6RU9LOU5GaEZSTFR5bE1oVFErU2Yz?=
 =?utf-8?B?TGludVRqY1A1SVY4YmdqNVZzSDdWbjREOHhuTWJMTmluWi9NMkxHd2FoMmJu?=
 =?utf-8?B?T2RTY1Nqak5aLzlyUTAySTIvZ2M5eGpHYXdQK2IvaTY1bGMwTWZ3VUJoK3FV?=
 =?utf-8?Q?5N4jC2NPCbefZ+U4C6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 078acbe3-2d5f-44f3-0688-08df4aa62fe3
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8705.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:42:54.1122 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1B7EAmcDt3rS8y6sBlNh9yiDoycyJfV6nWplUIWdVVIunRQO2Z7RaaCnGnYoXSRvRnaqeeS03dqpTBIxaAS+yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8590
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/26 13:51, Harry Wentland wrote:
> cm3_helper_translate_curve_to_hw_format() puts PQ, gamma 2.2, and HLG
> on 32 regions from 2^-25 to 2^7. Gamma 2.4 and 2.6 used the other
> layout, 12 regions from 2^-12 to 2^0.
> 
> cm_helper_translate_curve_to_hw_format() has the same split, for PQ
> and gamma 2.2 only. DCN 3.0, 3.01, 3.1, and 3.14 program the plane
> shaper through dcn20_set_shaper_3dlut(), which calls that helper.
> 
> The inverse curve is the shaper, and its input is linear light from
> degamma. A 10-bit code v becomes (v/1023)^g. That is below 2^-12 for
> v = 1..31 at gamma 2.4 and v = 1..41 at gamma 2.6, so those codes come
> back as 0. On a gray ramp the round trip then misses the IGT bracket
> of 13. Gamma 2.4 needs a bracket of 33 and gamma 2.6 needs 41. Gamma
> 2.2 already uses the wide curve and its round trip is exact.
> 
> Use the 32-region curve for gamma 2.4 and 2.6 in both helpers. Its low
> end is 2^-25, which covers those dark codes. On DCN 4.0.1 the gamma
> 2.4 round trip is exact and gamma 2.6 is off by one 10-bit code, so
> the original bracket of 13 passes. The DCN 3.0 family path was not
> tested.
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c | 4 +++-
>   drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> index 502a2d9b155f..6b3cc0d81e34 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_cm_common.c
> @@ -355,7 +355,9 @@ bool cm_helper_translate_curve_to_hw_format(struct dc_context *ctx,
>   	memset(lut_params, 0, sizeof(struct pwl_params));
>   	memset(seg_distr, 0, sizeof(seg_distr));
>   
> -	if (output_tf->tf == TRANSFER_FUNCTION_PQ || output_tf->tf == TRANSFER_FUNCTION_GAMMA22) {
> +	if (output_tf->tf == TRANSFER_FUNCTION_PQ || output_tf->tf == TRANSFER_FUNCTION_GAMMA22 ||
> +		output_tf->tf == TRANSFER_FUNCTION_GAMMA24 ||
> +		output_tf->tf == TRANSFER_FUNCTION_GAMMA26) {

nitpick - it is better if new code can be aligned to above.

>   		/* 32 segments
>   		 * segments are from 2^-25 to 2^7
>   		 */
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> index eb299f7f9c41..8a76e985d359 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
> @@ -133,6 +133,8 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
>   	memset(seg_distr, 0, sizeof(seg_distr));
>   
>   	if (output_tf->tf == TRANSFER_FUNCTION_PQ || output_tf->tf == TRANSFER_FUNCTION_GAMMA22 ||
> +		output_tf->tf == TRANSFER_FUNCTION_GAMMA24 ||
> +		output_tf->tf == TRANSFER_FUNCTION_GAMMA26 ||

nitpick - it is better if new code can be aligned to above.

>   		output_tf->tf == TRANSFER_FUNCTION_HLG) {
>   		/* 32 segments
>   		 * segments are from 2^-25 to 2^7

