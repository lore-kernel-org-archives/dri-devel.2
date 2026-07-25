Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A093DC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 06:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A4F897FD;
	Sat, 25 Jul 2026 06:02:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JvggBJdc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D82897FD;
 Sat, 25 Jul 2026 06:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJHhN3df2lwR8MlA4xpK3Ah8VugkvyK1H9YNGuSxMUAGrmeLINF6PjZZz1KhcFWcYjZDPk8/Z5Lhmdmc6qDCG77IOZEJJMURW2G7f/s2LEPrjXUvzPEhBLChYJ7BwXN4FVcMnl9c+MHhszBB8Lv+18PZLbizKjzsrISKWfyG28suhuT0CN3VAjXimALeRv/PM1cqJiJ88da8yFPNlDrhy6AoppI4R0vVE5GGEsJjV052u+yx1JuOFrEpVhm+bOpbol1jkzO/IAyvTnxsR/nvnJ5Udml3EOEDi0PAS6MxAcEBmUGp54dEd+eTtchJoQC46QMNagms0XvXD0pdAIyFZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45ng9eNnVNNKlXdgb4SM9/39J1liInCUlJ+X5W4v5HM=;
 b=zQTjhmlcZ9jjpAGw1cjEMUuGik7lp/EivDwzPXlRK3XEb7klPw7Y594LNMoXydhPpO2ly1iLEizYEYAEnoUDp1Rg8/toaCffNG1m93Qw9jZvQ16BDKHLpIkxmCa8t/by2rJnNgR8KFff/hIorsC7tMKELsdhLTtxYSqIDsP10r3NWXj7orY91u0UpAJeqFLuqDDXMscNkNPNrUpMNUaaFPO1A3o4fMTg0hY9ax9gJkDf884c7r9PdEMjLUfj+wxisZ2jgI6mVYtzjPml0LkOfiFSj77kggu34dRtOBHr1rp4oXaUtCU4mla87kWyo+6M091nZcSlLsZbT8O6AMf+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45ng9eNnVNNKlXdgb4SM9/39J1liInCUlJ+X5W4v5HM=;
 b=JvggBJdc3xYJbfv/fcfeJBLgs/M5y4KRTXOZJcBVQPZWCXED3Gmy8RO+JjdmWyGYXvggjEY4D8vpk4Mr1mitzprlIhMFY7bsWE8oS39eG0eRTlwMFcVT+bmAAbH4/yGQBBnoKny0K81ejWfIJ5S42EsnAn5m83RGtMCu1Xzd7RU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA0PPF1D04084C7.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bca) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sat, 25 Jul
 2026 06:02:30 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.012; Sat, 25 Jul 2026
 06:02:29 +0000
Message-ID: <c741aa10-fa0f-4563-9985-d4da17193830@amd.com>
Date: Sat, 25 Jul 2026 00:02:27 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] drm/vkms: Fix limited-range YCbCr to RGB
 conversion scaling
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-3-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260722134607.136293-3-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA0PPF1D04084C7:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5e5e50-2e75-4fab-7adc-08deea124f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WrvVRr6lJxCn2kDNmCOAn9fwC0FCkcC84vVhyARfpOBUwYJ2ZnuAb+kZ+PdYH1TVruP/5T+Xnz+HhePGnM3VgTyYsy+mup02f7KPfTKvC3m+W9hRLKv8UAdANukHrccwrvO9zLApuwXTr0Zmc7AIP90Tale0l6yAB0ZzZC4oyvupiK8Ywg227fbwY41aJLjekhTflj9SaUVgIiM2QxF0YD22/M/qbqMIH6fH7c4T5YkzB7lPJ5fNFbhkmaGVfnwpUlKOpVD9ER+jdavNuhBJhponsJLhHjHNSnOBte3suYkKaIPpw/DD2+Ab7/7Qh/ons4rPYHpSBwTaLNbjy01keSPQQApygrdJtZ+mvsq2foAAXYEVgcrx2C3UOjnOw77BwKPBWv9Yjk/pJ58WA1+iuNkkm24qYRQjqMknpGC7mTnR+O4ao8RXWxptrJbcvPaY6BNOoMaMp0hUx1Q9XpL4c6AQiT/CW+LMhrSo64zirvcianetyMmMOSjS5KP4paLz4tqdUxHn2/0LID6fBBSbtCCXSy+CwoLu0VZdxyu+TZZTrRPudhZ4i18DrwXCyQ/fgWHvMFOyuIJ2SEheLbo4pFWpXJM4Mvx2TThDJ12gJWx6XOFEtYHExwbAbnd3UAwcRussRh7xtlyYzw36Z7NlrLRs8y21BL+g5ABbvZy3YFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzU5bnBSdEhDdSt5NWpZUGxmaDNBakxrcldvMnlMNnBseFRjYlU0bkJqYytn?=
 =?utf-8?B?SGhOeUZCY2M0R1FwZ2VPbTh6TFEvT0xFTjVPS1VFVlpUeW5FOG5WY0M0RFhs?=
 =?utf-8?B?Z25ybGorVzJOVTc5cVR2MVhDVmdJWFlUN2F2RnNTZC9FcStOQm9zRlROT0VB?=
 =?utf-8?B?cEthZWZHcEVPZkpuWG5ocGNNMmdIdkJvcEgzbEhqcXMrWHE1TExsN3ZzMFQ3?=
 =?utf-8?B?SFhRSnZ6cFNwZXdCODZteG5DQklsNFFJRmtMWXUwTEc0aWdEU0NjWXdvTm1M?=
 =?utf-8?B?UG9mcXJGYW56RHJ3SklMeDlvSXRGM1JnSzRtN2tCd0tCcXdlWmc0ajlIbzV1?=
 =?utf-8?B?RXJCNWRsN3J5QjZqaG01VEI1bWRBMzBuek50YVZhc2VkOXdvQXhseUZrK0tE?=
 =?utf-8?B?WkRqK00rZkNja25CQlNSZnVtd3J5YXlUcEFlOGNDUXZRZTMyQkh5VFlnSm8y?=
 =?utf-8?B?R3RQTVB6eHU1VktQUU1WMGdMZThzbXltM2pzN2Jzb0pCOGRZOHNZU1ozcm1z?=
 =?utf-8?B?eFBPWEdiK05XZnBjb0hobmMyb2tKdnJmUXhzcVpnd1VwemNQQXpLQU8xZTdP?=
 =?utf-8?B?L2N1WmxrTHVoRkRGNTQzM3cwYzdib3JkQUl3bDRDSFViY0k2QnJXdmhEUWJV?=
 =?utf-8?B?Mmd1dUZydzFtSG5GUGlLMVd1ZjJ6Wlo3cEh5b3BUSTREejZqL3VsTUVHMVRX?=
 =?utf-8?B?Yi9taG00c0x2Z09uZXdsdmE3VHNET2FCT3IrRmwxQTNRTVNCL2J4dE0yV252?=
 =?utf-8?B?UW5RUlJJa2JPVTVrZXZUMkIyc004SzEwT1o0eG04SlNsaUpvTmNLdXZUb2NV?=
 =?utf-8?B?b294VCttUU12eDZXOUQwdGlrSHBQRG9NUldPTmxzazBOQjlyQk5QV1pyOE1q?=
 =?utf-8?B?bHFhZmpBT3NETjE0M1hzTXpIcE9Lc2thdUxSZ2NDcEx6cFViOWM1dHFjRmtn?=
 =?utf-8?B?RmZyQmxHdU5CYno4em9JeHRXc2lTTmQ1eHQwdFNrRUtVYVRuTVR5V0IxdzVx?=
 =?utf-8?B?S2szR1lJdUF0d0QvaVFlNzEzcUNmb1J1c2ZDVDJ0NkVsbE95THBCVW0zcXo3?=
 =?utf-8?B?dUp4OFY4Sm9KeTFBejBST25RR2tDWEQ5KzdMdm1qVVJ0Yjgwb2ZDUmdwQXEr?=
 =?utf-8?B?WldMZ3E3d2l4K2p3Wk1YSVpIczNHWlVqbnB0dVdFUGk2aldtUUFTWVYwRTFE?=
 =?utf-8?B?MWZvcmdZRkFZYnFjVWdaU2VYTVcvbkQ4Uk01V0FQcHJwWFdiTmhTbnVsNXlY?=
 =?utf-8?B?eGZNanRJM1RmTjE1NTc2WGlFQlJpR1NnL3RLU3pYL3JXejNGV0Z1YkwvWitx?=
 =?utf-8?B?NGhlZXd4SjdQaE9ZblZaZXp2ME1HMkwwM1FkMHg4dFFIY3p5UmNaSVZHZEFB?=
 =?utf-8?B?OU9RVUtWQVFKV0dwRU94bU9KQ2FCWGtmcDIxRVV6T2h6anplN2pVTnhyaU5V?=
 =?utf-8?B?aU1tRVZBajFVYndHdlZaa0t3R241RFZTU0RXcU04eVlLVUp0MXQ2bFdyd2w3?=
 =?utf-8?B?UDlucExmd3dhZVBTNG1MZTZUNC9FWXZqVVcxdnQxMDZxRm1RZUMyd2JGekk4?=
 =?utf-8?B?b0ZVVjNPMTZ5Vi9laDZQOTlKQ0ptajFLQmUxb2dTblRqREs3OGtnT0ZVSFJE?=
 =?utf-8?B?cFNYdngvU2JOZmZWdlVhMDg0VndsamN3a21TSmVTR1ArbmdOQW5MSDNqUzJS?=
 =?utf-8?B?czdpWW84K0JFTEhLWWhZSHRISklBY05Dc0FXY3IvVGZ3blpxbkpzQjZVN3hm?=
 =?utf-8?B?WFU3bFh5OHVKSlJUY2ZVUnRRUlRSbmFVVnFWMW5vNlc1REhDQy9ZZGdkOEJG?=
 =?utf-8?B?NDNleVY4TUZKTUhEUUhMNysxVUNtU3ZrRzFHYVoxbTN0ZFJRY2FhZTNHRy9F?=
 =?utf-8?B?SHk5NkF2ejhCdm1zNzA0K00vQVFHdjlKcC9XcUIzZUtBZUtLWDMya3FRSEZO?=
 =?utf-8?B?U1VNUXRmdzV2U21YVi9ITTZSZDNyellkdm1QZS9EL0U2Um9mWmd1ekxUL0R5?=
 =?utf-8?B?d3ROUHhsdzJhaEhFZzZJR094eWFIS3ZId1E0SDhHTHRrVkVnbEpGQVM2VzY0?=
 =?utf-8?B?RzcvelFpQk9tU2FRdThVWkdiZDNXV3pHK1JRNmhzdG93a29SdUpIdjVvam45?=
 =?utf-8?B?d0dJTElOQUVISzNpaHJ2aWZsU0tCTlY0d1FOVjhORFg2V1NScmRqY1JTeGE0?=
 =?utf-8?B?K3dOajMvbUlqUXBtTklZdTcrMjZhbWljQ0U0SlBmd3FLaGpzeFVYRXZ6WjZh?=
 =?utf-8?B?M0JsU0JZM3ZlWjhvWHpzNlAxblRNWDNtSXlaUlQ0aFhFbjdiZ1ZXR2xKVzQz?=
 =?utf-8?Q?EniRZBF9GfEXl3XKBO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5e5e50-2e75-4fab-7adc-08deea124f31
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2026 06:02:29.3759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: givIUqEhXs2F1LNT+YwLughxEBMpd2EDc2oblddpSkDStq+hL1kL7kORF2kWAfjS2pHYpNwBr1Tmjz6Ddq3Fvg==
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
> The limited-/studio-range YCbCr to RGB conversion matrices were generated
> with colour.matrix_YCbCr(is_legal=True, bits=8), which normalises the
> narrow range by 2^bits (256 for 8-bit) rather than by the full-range
> maximum 2^bits - 1 (255). As a result the luma scale was 256/219 and the
> chroma scale 256/224 instead of the correct 255/219 and 255/224.
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

