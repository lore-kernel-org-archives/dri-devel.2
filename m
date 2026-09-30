Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12C0BCA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7237310F4D0;
	Wed, 30 Sep 2026 19:38:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OILzZ7JK";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC42D10F4D0;
 Wed, 30 Sep 2026 19:38:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m04L0K5Q623k45IjWXjm9dtAoJBwLsvXfDpHAhisXZOpd2XdiTGgYG8LhKvPntymvpL4lb/s/nTaEazMwUwpHc5EoRBD0tcfZx6b7HDbnkV7TG7ZwTlYOtEXGGK0RTgwLLU8DItxIxL6D1dDrn+WPjvIILgWCJmAiwROZeC6lTOkXGjjIZrWtJXVaN4+C+jAGwtL4AfZJwSs2P2yRtMGIT0+88sZDtXRIqwbk0wsq5DzAK1iAyMV2Ky3Pt3/EgojeKdMfrpf/0BuQV/Ux7d+b2uU5K1q+cRNurvyEiQPz6Vuc6QNzgFqbkGecWRSyily11kBgZjtQV2a/Te1g55kNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tY8M6grLcpB9pEpS4VnElnpg1muLYBzPiZkYhOVCRGA=;
 b=CyNhlvNGy7Lx2fAkfZy0gwOW2iwPQqAX8zDbmD4c41yzmvC3iYSho9Xx95J8oEjHhhU88oRtAVK2LuGAAGz7OjGlm9LKCSO/u3lbkmGFP8+iboOFzVK0QyRqjmq3Qfw2eX8TN05Rb9FksQ8RVGFXajJRfPfyREO5C8ZOKneCqv3Nh4dbTk+ZrmCSpDx4CzZo/Lq4uXQHMmG9ZWFrQU9Mg7z2OQgAYXwwzTWUAuUISXufEQ1GpshcvJVdTAmCm3UQ5bFFz2m0yDxYzrRYkgVrdK5tj9SBRP2wrPFIuK5+DbIryP4Y/qEdvJ53q5bkCBsKTfPVqV7K1jMhMm3SMinKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tY8M6grLcpB9pEpS4VnElnpg1muLYBzPiZkYhOVCRGA=;
 b=OILzZ7JKmlNDzk7bzbPMBuecpvRriFsNYnFKY/xDJPNCS9lFxyGf57aiVlE/cyd1rfDZXFlL2icviX4XW3n1jhE1Jv2ztA4GUAgWMHP2TqSESAxsEcQ8oL0ah3s7xOyiPSEdny1QVN7Fl7/1qi+hKbxr8CBwjRkf5ZUS2ZIaYjA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:38:17 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:38:15 +0000
Message-ID: <dd7a424f-c6bb-4fc2-8738-c969541aec94@amd.com>
Date: Wed, 30 Sep 2026 15:38:06 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] drm/amd/display: don't ignore failure on blend
 colorop setup
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sebastian.wick@redhat.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>, dri-devel@lists.freedesktop.org
References: <20260811171011.184964-1-mwen@igalia.com>
 <20260811171011.184964-10-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-10-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 298eb0d8-fcc4-41c2-ac6f-08df1f2a5eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: cGWZSWWmbLNlFbcwqlMGp+GXVxtwCx7IW2lHow7QclM04IctaNNXr8n51oKog9x5PtsQAoqbBVLCfU5/p80xQ8AtkcB5SXLgHZ1EbNZ9yog5g3FFm5R5DvIYV7nBnnrTLylVxHu8aqXOhSge/bAIF2+M5Z+tAKpr3EZ7z5R4R28a8lV9kUweOUhXDZSuSq15B4QNXhT/QFc7+ujiexM4/60fSij161ODN0xpckxl+vnOz5jPtobsaoesVe7gnC+t08Qut5bcKF+Ac3BeLsP8eAgG0+FacqFP9EW/wSaqR2SsROlgKDXQ4b6JWBcMJLy2mfd58m2LFesnaf16yluy5M40Tfi7nNX6fZFPmbwxphIJjgch/VVWZtjJ2lMA5Kx80mwIjotVytVz8s9yH2ITwtSm1MPKhGmbcAbVA/vAVqj2Kkwddaa6BU7sSzJiN5o1PA1vJdRDBu6AirE4ITHgTrn69It/Xx67T4378esO80Isvrz0fxUxn9IRnVLe37zvk8WJ+dofT18v5Od/icsYtXgyrfnOo0trHt7AaEWFHUEMWKPdMOF1xX2cKSSJWsR+UtQPyl84pMHlnMOdv5SMXtG5sJtxbtVxVNnGJiOFzWwGENNOxGU0HUfRWJrGHhGTVL941ztrquieav/RQqqScHwlBgcZvfNrKGwKaaX0WqEUqSIZflMRWn8QoeQWLGxrNyWi4dCVekl2Su+Bf8WRmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGcwa0ZXL1BpU2FDNkxkUmNTY0xURXdheFFaUWdBa0Y4T0o4RGJVTUxUbWlz?=
 =?utf-8?B?bHIxNzV2S1RxVnpRdW96UGswWGVWdU9pWUg3QUpmUkJnZDNUd1RMNFRJYmF6?=
 =?utf-8?B?ak8wb1ZuNi9qK3JETFIrYzBvMDhGMk50TFpSK3ZlR3dqbDgzQWdYY1ZYVE1J?=
 =?utf-8?B?ZEE2eFkvZVdkazZuUjFuMUJWajF2NXNQMW5zNWdkUXlqNkgxZ0J2bzdqZlVI?=
 =?utf-8?B?T0xoSFdJOEVkbFF6cmw5Vk1USU14WWdmSHV1YW5UYjllWlM3Q3M2bWtYS0xs?=
 =?utf-8?B?RGNzYUp3SWNuZXdCMTJNMzRaU0lIWkhaVXFZdU1WOVZJY0pWTDk1V0xCSHJ3?=
 =?utf-8?B?N0k3aTB6emd4UU4wY0FTS1kxK2w1SFR5ZTM3VzRmQXpLV0hOeGN6c1UxL2J2?=
 =?utf-8?B?OUw1Yk1qNlYxTVA2NkRFQU9JZ2dXMUg3a0xKYzBZcURpSFNGeWhIa2lHQTN6?=
 =?utf-8?B?MkpWL2YvNkRTdzhDZXYrM1ZVdnlhYmVncTlZMzMzOFRnVHhNWmwyVWNoblVE?=
 =?utf-8?B?Mm8vZFowOWJjcE1aS2M3cG1iNlowQUtDVUJWZ0ZZSUNybXBhQWxYT2NXcWtO?=
 =?utf-8?B?ZXNjWkRPUG16WDR4c01ybVJ3M1dDQ21yUGd6L3ZtOFpCVGcwWDlOaGk5RTh0?=
 =?utf-8?B?SnBZd21lZ0RZUWw0V3lqZ2hoNWtTbTNjK0RCT3M2cThNZWJzbHg3VVhlNTRj?=
 =?utf-8?B?OFlOM3VkU0lPdUZreXVCMGlXU3R6Q0VjbHZ2Zm1BZmZEZUJlb0cvZnJWSWhU?=
 =?utf-8?B?OXN1LzJQUFJ6bWM2dnlIZlhPcGFSY0E3bHNXek1BR2ZrVzNCNUhPOENLTm5M?=
 =?utf-8?B?b1E1Vlg0akdwNjJ0UE5KS28xUE0rTlhRa2FrK3RlWlpMaTdFMU1nRjZqc3lo?=
 =?utf-8?B?TDR3YWdEck90UGFnRjg3bzU0RkFXUGlQY2VtUTlmVDlxblNqWks0dmdkOWxy?=
 =?utf-8?B?cHhXZHVadkpxY1VYK2UrUytUTEM5TzV6anhOQ2VrOGl4TGxIbEN1a1ZSQTd5?=
 =?utf-8?B?cW9KajZlNEFySi9mdXZXUkZYYlYvSjBHdFZuY21LSXBrVkNKSU5hNHdNNHEv?=
 =?utf-8?B?eTNGakZubkVQcXFqV1NiaUxtVnRkY01XZ2k0eGxwNDRRc0Z3ckVZOCs0L3J4?=
 =?utf-8?B?OUZ5cDlzc2hzdzNPekZNWlZPZnJTY1Q3MGFiMnVod0h2aDFxWS9qRjRqZ2p2?=
 =?utf-8?B?dXY4cHJPZzNGVzB4NzVUWitpc1FSQ2FqZkN0VzBCcysxSEVETGtkeTlqWnlp?=
 =?utf-8?B?Qkh4K1J5ZXgwNVFselg3TEdqU29wZE84cTFGWjc3Z25kR0FZcGdFamZkT0lI?=
 =?utf-8?B?aVl3VWRJb0NqYWdJMEM5U1ZDMFVMVHovNGxZME1la3pGVUpjZE1SYzl2VUw3?=
 =?utf-8?B?MWpKY1R4QUxhTnJXb3VwUy9PaFdubFEyN3ZqYXNqdXVjV0ZqWUZxUTNEUDVW?=
 =?utf-8?B?eGdCZFVpWjJWeUFNZ1NHYzR3TjVOczdPNjlFTG9veDBrQUd3SG0yVHhkVXN4?=
 =?utf-8?B?RDAxN1VUNithUmI3STc1Q2tML1dqa041WjgwM1RwZmZYTVUzNHFjSUVrZzYx?=
 =?utf-8?B?dG1CeTRTZmw0TEloNVRDSXhVb29WRWRLUmVodCttUCs4OXB2RmNSdU1zUHVB?=
 =?utf-8?B?cU1VWHBaSitRb1BjajZBSU5TWWpOT0VncG1lZUljSGhpREg1U1V1TGVXNlRI?=
 =?utf-8?B?TXZTVnVYeFlMMk9vckJ4NU9PWTdSeUw0TjNwSnd3cFhZVDdLRGlDMFdIazJM?=
 =?utf-8?B?ZUxJRDZpTEx6S3ZyaW9TWkw3bnRINzNueWZhamhhTUtYUEpsREM1cnF2SXVS?=
 =?utf-8?B?aWd6ZExzNkl1SzBnbFF2OW5xT0Q1S2JPM000Ti9DZ245L21VdTl0bTZURkYx?=
 =?utf-8?B?YlVrK3QrSjlZUFU2RXpJTUlDZ2h6ekFmNWJHcU1IL3VycmwwM2N6dWhrZGhV?=
 =?utf-8?B?TE54WUR1WnhJbGNQaFhpZGlWMzhvOHhDNHdXQnlBQ2IxOEdFTDhNN1NOcGl4?=
 =?utf-8?B?N3E4V3JwSGNqcXhpS1VwR2JTc1p1b0pQcVlxa1gwZlhnVm5pRWxhZGs0Q0FS?=
 =?utf-8?B?enovMEVHSnEzRGlLQ0F3ZGJsd0xkOWMyeFpuc0h2YUpraUNGU3g3Q0JyZmFz?=
 =?utf-8?B?YURvbGhZY3BBbTNCVHM0QUl4UXl0cWNXekx1QzY2bEtvMGpVblYyVUtNZ1ls?=
 =?utf-8?B?WWdWd3ZtQXJmL09VTVNnYnQ1Rkk3enB3c1lUbStLczZWanRwNGtCc25lUTJ6?=
 =?utf-8?B?TDQ5cXEwbUtYR004Ykhva094b0tULzF4OU1NTEh4V3N4RUdjRTRSQU5QU2VT?=
 =?utf-8?B?UXdVamtsbzBlWm9NTko3WVczd1YxVDRRb3hUeTVJcmU3bm9XVVNJQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 298eb0d8-fcc4-41c2-ac6f-08df1f2a5eda
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:38:15.2265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+GdBbSik/a0AK623PnmjQ4dBnf4JZC77ur1suZxfX6i2wIuSzFunlB2fLPj8k+5uc6/KDVp+QTHXyxpr35xUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
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



On 2026-08-11 12:45, Melissa Wen wrote:
> __set_input_tf_32() can fail on ENOMEM and let the blend transfer
> function setup in an unstable state. Check its return value and only
> enable blend if transfer function was successfully configured.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: 5ed78b44e4e6 ("drm/amd/display: add shaper and blend colorops for 1D Curve Custom LUT")
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_color.c   | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index ad67106c6435..c528daefac5e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1835,7 +1835,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   	const struct drm_color_lut32 *blend_lut = NULL;
>   	struct drm_device *dev = colorop->dev;
>   	uint32_t blend_size = 0;
> -	int i = 0;
> +	int i = 0, ret;
>   
>   	tf->type = TF_TYPE_BYPASS;
>   	dc_plane_state->cm.flags.bits.blend_enable = 0;
> @@ -1870,8 +1870,10 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
>   		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
>   		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
> +		ret = __set_input_tf_32(NULL, tf, blend_lut, blend_size);
> +		if (ret)
> +			return ret;
>   		dc_plane_state->cm.flags.bits.blend_enable = 1;
> -		__set_input_tf_32(NULL, tf, blend_lut, blend_size);
>   	}
>   
>   	if (lut_state && !lut_state->bypass) {
> @@ -1879,13 +1881,16 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
>   		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
>   		tf->tf = default_tf;
>   		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
> -		dc_plane_state->cm.flags.bits.blend_enable = 1;
>   		blend_lut = __extract_blob_lut32(lut_state->data, &blend_size);
>   		blend_size = blend_lut != NULL ? blend_size : 0;
>   
>   		/* Custom LUT size must be the same as supported size */
> -		if (blend_size == lut_colorop->size)
> -			__set_input_tf_32(NULL, tf, blend_lut, blend_size);
> +		if (blend_size == lut_colorop->size) {
> +			ret = __set_input_tf_32(NULL, tf, blend_lut, blend_size);
> +			if (ret)
> +				return ret;
> +			dc_plane_state->cm.flags.bits.blend_enable = 1;
> +		}
>   	}
>   
>   	return 0;

