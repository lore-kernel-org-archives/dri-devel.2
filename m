Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8247FCA5FC5
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:34:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D877310F42B;
	Wed, 30 Sep 2026 19:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hs8EcwcK";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF3510F42B;
 Wed, 30 Sep 2026 19:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ncdnog3x8spUYZTNY0RrLeuH1025Ayli2pbN7/5IySsKg7fBgKuI0MDQ4P7YCP5AUFJVIuacOjnviT9OcKVqHnZ3T5RYw3qP9gQKL12FbmI9DuON/LVL4l0FzGg9stBTHMiKKnVeYn3Ovl1gwCx4TwgP6O0Q3Zw6XGZ928JTQluNbJsK1m7Wl0WHIW29m4tH/Ixc4upgwZ01+i813jHBjo2yK4e7vmB5Bg/XLodUtZynK5nCcUZAzZ7d1fsaWP3QM1IQ2bz1O4v79lMYmGqJHnfLX2OqKAVOI9+HcZwBy4h3D2OvE05NZPI+3NUSUafWSzi8lFKiaybBwvJT+DoW2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7mblhHZMugseAnvxyLUcj/9ru0tcCoZD5ey6bqBBxg=;
 b=sdWMoBuDKhVxmHd4cAp03c8ksZ3uJYn/qhjRj8t18BvZzXj803gz0XHpAkwy9jAUaTxzqfxSud7SOR1POkxcxJ1BafpAFEidDr5dP4HnU7rvlLOrlx2ixJ+G6fhsVLiNf2Dmg0gaHrGOfXqas9QPLaiO3CnEGJsc1LCdERSL7BLr7O8TDRLvqxbXdoDpxP+gNEJDZdcUlAZwKCQsNxCkY5RZ6vdrMhj8yPlGaQ8KLJ4CtXiTJqf3OIMp0TIbsqsYfITlk7KuyYE+z3yNg24osI5J8QS5lzA63j4hMWa9jR83qos8U6AWekVtWwK+/FARMgGVyWGgVQmEXIT80icjFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7mblhHZMugseAnvxyLUcj/9ru0tcCoZD5ey6bqBBxg=;
 b=hs8EcwcKJtYMuZHPm8jHXXVU2BFxuz9sO+wQ5tq9rlfw2hzOX7lf0rP/LYtqk2w7EnGTSgykfnIHMyNyv6I7mi0cj9hgXgEOBkeN3aS0Tx1xJOQB1/iRCsUx2SlEN+YdATgQBD8MlL6NQkFFpB8WeDdtZzmrTbkceuWBuZLa+D0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CH1PR12MB9646.namprd12.prod.outlook.com (2603:10b6:610:2af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 19:34:24 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:34:24 +0000
Message-ID: <e67003e6-a277-4004-9b75-f87dc1482d78@amd.com>
Date: Wed, 30 Sep 2026 15:34:16 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] drm/amd/display: truly bypass plane colorop 3x4
 matrix and hdr mult
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
 dri-devel@lists.freedesktop.org
References: <20260811171011.184964-1-mwen@igalia.com>
 <20260811171011.184964-7-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-7-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0399.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::6) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bf997e-c433-4e2f-bf08-08df1f29d509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|23010399003|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: tMGnNaAR1Q0SRWyfDOKH+CYMb/Jx00MlmEKh7rqKek6Umiu5mH4KuK335Y8sR5er2lVcJ/tEN4OhiCpvwAU6GvptSioFYP2pauvHIjWiA2kodRvyPJxV+M9tYSAKQJTEMhncaZujajja3ElVSQ9R6Gu3M8n3Ee5nldyV0EQ4HvKRU0+1Hn0zM71cUX3vrmyDYIuzaOhHs3yubiUyI26xDSQvQXBbcS7hex/fXRGPRPgPeiBfiC7Im905uorxr4CgXheZqflnAMQ/dPlh9luLr9Z3wvx3Ao4b2uqxzh4CEmgZHuRAhu/+kta+Td3y7PtRRBbxqt+FZyTOfhLsS6yWtq9Y7OAtOkLqX3vYSdTPPcSjyFrS6HWcdgWIyU6Jw54YDnTpafh7yapiK/iCKyyzJkMRUPcKXObElK+i70ts4wWiHlc8UKhHFU1xhgFyABFOSKWF/opxkVDgSDW+6Z/3y+sioZdomPVsVqCHGgMmjpuReaUSELOp+Uyes2ecnxseYVzrI7ALU2xW6cXENLe7YaJs6zKf04ZI3oAjPb2e+/ri1GSsJETzUHe4jIoITur8skdb4ArkzfPE9f2ej2Ip1aL1wnTY6QJB0oSTPXlqfaFnWoJpnxIyxAEKR5Lipr2hYW5f4EiR+Vslb6dkPF7Rfv4l5fA1Xls9Th3fZNPDMLFLEIX84pkfb54YzTymIBdnX4QRRX6F4xfFqq1FFAAYVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1M4RWxmMXpZby80aDduMFRKTWdWNFN3OFN4QllSbERtTnhLbXplSlRsWW1N?=
 =?utf-8?B?c1c4OEoyaU42NFlJL1FZWUh3VURyV0cwVGJYRUsvOHc1ZjZIaXFBNEdEaWxr?=
 =?utf-8?B?OXlCN2c0eTdUTXJYdWgxeVE4WW9FcnR0MEx1OUswdEM4RUtqSzA0RitHdis2?=
 =?utf-8?B?cFZlYkluSE5ZWkNUWkVYcmEyM2RVdUNYSUNVOVZSWENWdkZkeExsMnZPNVBr?=
 =?utf-8?B?UXgxaisvSFpPZHp1bjhYZmxXeDd4Wm1nMFlzSlN3MEtFbkxGWUNGM3JtY2Uz?=
 =?utf-8?B?cWhYOXVwTGpkcmRWZTR1NHUrakFlc2ZOTFNkbnA4b1Y3bU9kdDZSUk5WNGRs?=
 =?utf-8?B?RjFPK0hqTmM1R21Za1NCaTRNdStrWkpUSmIwQnNySUpyWUdNNHNiMHVockRE?=
 =?utf-8?B?bnAyS3N5b0NmV2dFVHkwRlJOVzRhVEtMMTVXL2JFcThaRzh3ZUUwbWQ5RXRw?=
 =?utf-8?B?Ymh5cExWSlA3TEpqUVJIMGthYXVjQUNwSXhZc3pWWkVMV0YvNk53VHZKMFlP?=
 =?utf-8?B?dFd5MG84NEJURUc1UTlMV29BSGxoSzNJYzlxaElLQlc5OHZkcVRrejV4SzEr?=
 =?utf-8?B?bnNvczlMaW5NcFlqdUQ2Z2hpUlFMRG5vZFdzakQvWWFNVDdTelF4UlA3cmQv?=
 =?utf-8?B?bFBYVGUvRCt5QzkrZWNSZ1ZWUDgxQmNKSGZzWjNXNXZYY0MyR1dhVE85OTI3?=
 =?utf-8?B?bFBqQUpTVGpkQlB3bjJVSjN0SjAwdkRJazhjb1luQUVsajJoa0VJTWY0cU5S?=
 =?utf-8?B?OE16Und2Rmo1Y1BIL3BRWkR3bG12aW1IL0NzcEpYdy9zTk9zdzdPUG9NQ1R4?=
 =?utf-8?B?TjVCek5mSU5OVW9Ub2dKVGo3VTJmRk5sZzMzTHRYenMvclVDbTNBaFVsb2JW?=
 =?utf-8?B?OFhQYll4eFF0bjhtOGY0MS9NQUxYc3grbUJNNXdwMmdNWDlXUDB4QkFIdWJG?=
 =?utf-8?B?Rzl5elhxVXRpTjA3SzczY3g2ZzI3eWRZNG1Qd0djNXNYNk9xTVU3K2tSTWZy?=
 =?utf-8?B?VEdYRThRN1hIVk40czNCTXA3T2o4RTcydGVyUWZDaDJObjlPbnJaOXFQUG0w?=
 =?utf-8?B?Y1ZvZzR2WVFUWUpHSVBZajNFWE56OEdXVThqZ3JPYmlFUHdHVHRsVmFFS1Bk?=
 =?utf-8?B?K04rNmUvakZwcTNsMXZUay90QXdrd0k4RWdXMkVuWml6bzZud2dTYjRyVmtR?=
 =?utf-8?B?b080dHZXRmh4U0ZJTDFwOTVEQk5Uc2laK1cwZlRwZkZWY2xKdEtqUXM2OFE4?=
 =?utf-8?B?QU1wQ1p0ZmxyQ1o5b1NKTis2T3JJZkV0ZS9wN3pDS3NycXQvQThncWszamF6?=
 =?utf-8?B?Y3dxVlRCTzVBZ2Y3K29VaFhGQnlpY2NDTzA2OGExL1VaMzZQek1MWUs0eS85?=
 =?utf-8?B?ODE5cjI5OEY4Yk00ODVrdm5yczRUMUlGYUhrNHFzNXJsSEh3Uk9WMzhIN3F1?=
 =?utf-8?B?SmIzekN4cmJ2VlVQRkFVNFZlTUFqYnk5bGdJM0ZVZ0tQQUpJQmdqRHhFaGh3?=
 =?utf-8?B?YXRiRW9nT2JWRTZKMWpycWhmbmxsTEpPZ0ZrUitlYmMxYjQ3RVRjNnhEbmN1?=
 =?utf-8?B?ZjNHWHZCYmtMdmo2dlVLam5WVCtkUEc1Y3NmYyt5cWs1dkZVaFd6NEVYQkZr?=
 =?utf-8?B?ZUs0b09ZZGFmaUZnZFhjeStvQm9TeFRkUUNXVkY2dTVScExDNXdlYkJPdE5W?=
 =?utf-8?B?dlJ1UWk3dmwvMXBXSjNMMmpSZ2tmZUVjUEovUVZraUFGeXRJdEl1RThmc2xP?=
 =?utf-8?B?dWsyV3lUMU0wUGliZzBwdk1mZ0t5VkFhNUJ2YTRoZjFZbElCL3dPcnozYk95?=
 =?utf-8?B?M25ETzMvNWVwOU41c2Q4ZFgvMS9tenpTa0ZoeVUyMzhuUktNOUg0bExxN1l6?=
 =?utf-8?B?SlczT3lSdFFCa3gvSks5TXF2U0JKZlVQV0dRTmZjTEFpSFFYWkIwSmtvcm5C?=
 =?utf-8?B?a1kxS3V6NVZSMlA5bERmRFNkcG9kNkJweFM1M2UvR0N0OW1BamR2RThFSHJ0?=
 =?utf-8?B?T0JRUytNNHFHNU1lWUh3dm1kSzYzVGo2dXBmNGIzeUpEOE9nQmczOW0yY2Fv?=
 =?utf-8?B?ZmlLamJZL2Y1eGtlR05HZnV2MkM2bmZVNm0zUmd3WTlYVHZhSFMxTUZESnNk?=
 =?utf-8?B?ZlltaEdVUENueTdUU3Q1Mjh2OSszWXoyZHI2TlhKcmQzZnFqeC9TMm1zaGxQ?=
 =?utf-8?B?b0R3czZVeUZCbUdBS0pGeDE4a1puSDdETUpJUkQxcmgxS0o1TmFPdjNDeURi?=
 =?utf-8?B?azBpcnBaeEtBNnVQc0xQTnJNaW4rSmMvbG9teFdvdkpRQW1ubi9tK2VKcVpI?=
 =?utf-8?B?VkxMTG5yODJITllzMVErcndUajhlb3UwWjdKcGpVQWY0K1MwMlFKZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bf997e-c433-4e2f-bf08-08df1f29d509
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:34:24.0509 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CEF324FBPlFZNPd65iCawRNhO1n/HrqFVZxwElJW+uDp4hZ//QfghFKAugb5vfTif9R+YdUSoj04WCnBveoaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646
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
> Latent issue as the driver is currently just skipping programming 3x4
> matrix and hdr multiplier blocks on bypass. Reset to default values if
> the bypass property is set true.
> 
> Acked-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c    | 18 ++++++++++++++----
>   1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 357c7c5c85cf..450a1469d0fd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1595,7 +1595,13 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
>   		}
>   	}
>   
> -	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_CTM_3X4) {
> +	if (colorop_state && colorop->type == DRM_COLOROP_CTM_3X4) {
> +		if (colorop_state->bypass) {
> +			dc_plane_state->gamut_remap_matrix.enable_remap = false;
> +			dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
> +			return 0;
> +		}
> +
>   		drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
>   		blob = colorop_state->data;
>   		if (blob->length == sizeof(struct drm_color_ctm_3x4)) {
> @@ -1634,9 +1640,13 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
>   		}
>   	}
>   
> -	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_MULTIPLIER) {
> -		drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
> -		dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
> +	if (colorop_state && colorop->type == DRM_COLOROP_MULTIPLIER) {
> +		if (colorop_state->bypass) {
> +			dc_plane_state->hdr_mult = dc_fixpt_one;
> +		} else {
> +			drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
> +			dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
> +		}
>   	}
>   
>   	return 0;

