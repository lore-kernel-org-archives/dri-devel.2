Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817E8F94CB0
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 21:13:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D928C10E27F;
	Tue, 21 Apr 2026 21:13:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fCzy7YQ4";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E71C410ED9D;
 Tue, 21 Apr 2026 21:13:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uP2nKyjPC2pDib4paW9pN8LCylsyi56cONA9KJH4krCfkamkR3+F9JZt3ckxMTh+5dk84g4AM4x0q9zx0qRipQNeb8cYv1VFLbBFTCKd2pPGi8M7sFQm5HC7dQrodQy4fYVx+OfiKuKIVSqsQC1Zzud8rpxTVuR9pQrM4Ho1+WAcIAfWhvZ449qUaaSAzSw6BEDGL5Z/a/nB0U8q+a1Q4CGKAeAkmy346JmNlmyISqDFVq6BeWWcE0LfSvSa6FVyPfuMVgNQQ3Muh1yOWuGbWvsI7H3JLtbbs1jgqaUyxxfkng/gsOI2sEKa5MIi6kkPe0p+hoT9SCBy+XlcGcxOSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogcKRKQ3dBEHcjfZaMhFWQMHdXWkG462O7nt4IkSpcM=;
 b=E0k4t1PJjU/at9K9VSitIccRU8oryRcVY9C4iwL1K7Ft8zKmd+4NtOilESYDgT5B639WlPdmRU/14P8mzrHPKlyLvtLmmMhX+MdJSMN7dRzWQSsLhswN+WwPhwATb75RC1eqiVuGcoy2ujS8S20pXYClYJGLW0BY+7SNyQvoBYYR+UkD6eJLJvHPMdKxz6ALLCKvZ0cVi4Uvfh2B12fSxKWWgTRPRUNGT3rZEwRA9S82sDFRNhOWJ/+F/iOw+fQ69hsNY6XyssQZlUBCkO496w9C9tk/TjubcofMoAsuf6kNP9E57EtbDuvKBIIBnbTvejy9+YXRxb0hCDazIiVHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogcKRKQ3dBEHcjfZaMhFWQMHdXWkG462O7nt4IkSpcM=;
 b=fCzy7YQ4odiHBLnWhSoyPPSF5hIe2YlSG1RVuHme/xj7F5IJluuAOeTHofajAGVVn0qmzBQ1LQ2O1YkTiRQgOhP5AQ8l1NDSpj2FC0uVF37bG1c3k5q8GNikIBGm3WW9SDZz24wnX7pSQV+rEHrFBb6VZ3qkasE45jqeUvUgn4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ0PR12MB6805.namprd12.prod.outlook.com (2603:10b6:a03:44f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Tue, 21 Apr
 2026 21:13:34 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 21:13:34 +0000
Message-ID: <f3e54f4c-2a33-4040-ae81-9126b03f962a@amd.com>
Date: Tue, 21 Apr 2026 15:13:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 6/9] drm/amd/display: Implement CSC FF colorop
 color space mapping
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
References: <20260330153451.99472-1-harry.wentland@amd.com>
 <20260330153451.99472-7-harry.wentland@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260330153451.99472-7-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ0PR12MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c50c3f-0d18-4814-0905-08de9fead899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 5bj0zcSTPlDcKACwhiHQQQyX/FHxkcCfqYl8FHQkw3lN92CyDfwLoLlyTlYWSASTTS+8+X/IeyN2ZK13xllzrpCj44fb3ECWqgoTzS6gmmOfkBpKD1p1EtjgT3G1t/7uAmpAQjy/Inrrl6z2hYTLFo6X8ZWPm5XErqzd2aAXC+vArZnhbvjeuOGOvRC+or/sz5mE8im4W2dkJTgyVJjmCtKOa/GxmAJy2DR5dnUw+9wuEuOPhCJn9ePPC2bZY9zwJ2hJhRDYnhxp5EOHX8ZU81NG4dL7PjNdUYp9uGDd0orDnjq6EF5NIntQGiSdWQvsnbLn4nBxcKq4rWSGbOrzWU71xdNpyDZtGNsgFPbQtY/AWZmFz8J93m4ZdwJsGU3ceZZ2XIOxf8Y+MMgQ7CcSlsst8rMxNDoLlMmyTs402sWCn9Fp72C5JlQXRwOeBrBKxUBycpV3FecNmPangqqi/KZMpJX7EMKCeheYQDPXmgAW5nPKMXMEyGncKA3g6LGe9UAFgf2xU/dEFtJuDwpiTFofWwZj5uIP2RQW1Soze7JVlMURm20f9iX0C3lJPfEtp8iFUCbPV48qIVeXpeKYGNh9/qHli3bTWPd4j045/zGBPwwHv8TVQMf9vgQjDQuUa7S4EHer6E6YOgtB0vppmv3ZqfW0uGf7VNtaujaCtReGh1UBWp/we7UKnj3qpiPedv0YPsg1eZyzNvnELSR4kmRyMqfrcsh3XsrSFBZG+sQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?USthb29FVU44Yk9McDZPUlhjd3ZrWEduc3BVL1VOeFMyYS9HNXdkN2ZVWW1j?=
 =?utf-8?B?ajNmZGpacWhJdXJOMGh0MjZDVE9kcUF2S1lkSmlKb0lpQ200YUlyNDVRb2pV?=
 =?utf-8?B?aW9hVmlnTXppMGtDRjRvR0pWY3VaemVDNWdUb3B2ZXhvZlZ4U0ZmWVBpbGla?=
 =?utf-8?B?K2ljbWI4eXJTdkxiZ2lhSUpmSnYyMUxQeUZITkNuWEVaQktCMTg1Zm1kc3d1?=
 =?utf-8?B?RlhPSitmRVd1VkJ2bjFDMTQvZ0dtcU9Gdm53K05tSitUZndPbTUwZ1E4MXh2?=
 =?utf-8?B?Uy92dVVKbTM0UVh4QW5HcTNjaFFJTTBkZjZoWnIreXJyQmZreTQxd3dMdGJx?=
 =?utf-8?B?am1pd0NkZlhYOTdJazJoWGFYVjhSRWVEN2ZZNlJnOWV4N3RmR2cwQW15K1Iv?=
 =?utf-8?B?Znl6UGY1a3FmcWJLYlArWnhwYnhLQ0tLTDlVL1d6OGlnMC92dW55TXdkdWRR?=
 =?utf-8?B?RWpXelZDd2ZDbTNJTUV0N0xBNSs5MElwRVZISlZ3RGNqSjJBT3pCYUxzbE1F?=
 =?utf-8?B?Nzg4TnBZRTNvVEFkY1FMY1NVZUtFMDBnaklIRDFoeU5VMnhQT2tMNjhVcW5S?=
 =?utf-8?B?UXlabVRIcXdPS1NudlBiSHVLTCsycVBnR0YwUHFzRlBIQUhFeHVQYmt2L0lw?=
 =?utf-8?B?UnFNTjhsYS9SZ2JxNkRxWFlhYm05ektvY0tKTlM4bzlMdHFMZml5WmxiZ3Vl?=
 =?utf-8?B?U1BZNmkrcVAwbGo4aUp5WDQ4ZGpvR0ZnVnhWZE1UajdmZlFwSGxoTVlSb2Za?=
 =?utf-8?B?ZTYrOERURCsra3NjeHplZ2xaUkNtYVRZYjdIemZVYmx0RUZZNWtLdnVaZk0r?=
 =?utf-8?B?S1RnSlJUaFgzMU9tLzljaHo3NDZFT01UanJZcVd6clBEaklucFYxVkROM2dZ?=
 =?utf-8?B?cHVhMXhIZUE3ckRabi9vUUN6UFZFbTVDM3dlaUg1SDZsMVhpdytZNmo2MnR3?=
 =?utf-8?B?b3BSSkY1UEo3b3JvelRHMzgxQ2JDeHM2bmtBdDFlNDlna1VEbyt1N2N4SVF3?=
 =?utf-8?B?NnZYT2Fmc2JrcVVaZGpXRURhc1RNckc3TDhHUjJESEpScWp3TkNlZXoxMWhD?=
 =?utf-8?B?SGFEMnl0R1hMdXNMeFRpcGUwdnIrRFNtc2JyQTVSS0ZTNitlTEl3cW1lV1lR?=
 =?utf-8?B?Vnk1R3dZV0psSXAwOGhaa0dBd29QbnlUZHI4YXVacDZqcjg2cWE1NGlDRnM1?=
 =?utf-8?B?aHFsZllBNVNyaThXazl3enFtRUZiczdmb2V0YWJjWi9tN3ZGNTdVTm1nVDVU?=
 =?utf-8?B?dG1QcytoQTYvRHJLYlFhODFwRDdpRlBLbHpFVHRGckc0OXpZbkZGOEkvbGlk?=
 =?utf-8?B?eC9BYmcwTlExMExaSjV6UEx4NG13djRjeU1BYXRaZG52M2FraVZsRlIzQnA4?=
 =?utf-8?B?UW5GamsvYkg3WGlkQWVzTFNMbVFReVh3Z2VFNEdtZm5wbFE4OU1mTTZ1SkVT?=
 =?utf-8?B?Y3dBZmFXM2U2TXkxNktFMFIrSEc2cldRQ0ZoS3VHUFRGemNiTG9mY2poSVVt?=
 =?utf-8?B?Z1BmVDR4Q08zY1RGMXZrK3o5UmxwUklqbWQ1akxzMUZCbE9ibWlTWW9rTzdB?=
 =?utf-8?B?VXNsUFZ6S2NFN290Tjl4ZUVna1M3cGdrUjZMK0J1MHNZS1BIYXBNcm5aZXA2?=
 =?utf-8?B?cG55K2tYSUlTTVMrZHduSFB6V29adlMvbXFPa1JGcWVzN1VqNUlWZTcwYUhp?=
 =?utf-8?B?K2sxVTkwZXU3SXJjTVowcGNZZmV3VGhaVjBBZ0UxejJSdElRVzM4Ry9SOE9h?=
 =?utf-8?B?MUE3bjZaMGZmNFZPR1h6dkhLYmtsR05GZzArU1owQjNRMDZBTkovT2htWjMr?=
 =?utf-8?B?VWw0ZE1oUm5iZ053TEhObTBjTzVITHVDS2NMa2k4dHRBdGpmMmFuMFBadXB5?=
 =?utf-8?B?VzhOWlV0WStvbTB3b2lBVHdwTVhoQ1VpY28zZlNlcFJuMHZJcFNxbUkwWW44?=
 =?utf-8?B?dW10bjk3ZXd4TWhWdUVIcURNa3JUblFOeGh3TDVRZFRsdjVzVUpTMmNiamxD?=
 =?utf-8?B?WGFCSWRxK1JXbmhPSDRiMk1vTGJja2pTZDE2ZG1ucTd5djRZYW5jMVZTRFNz?=
 =?utf-8?B?YVZyamNZT29CelZYV2J4UFFNWU14MWNTN3dpK2ZwWkNYNmxkLzE4Yk54YXpD?=
 =?utf-8?B?UFhxM0VMVUxYUGlReWJnS1I1VENPbDFQcFhmd2MvcDZyblArY2xUTDc2YTdn?=
 =?utf-8?B?cGlCZkoyVm00d1NYcGVRbndPbDMxc0RqYTdRUXVZOVIwY21TWEtmMXVjd3ps?=
 =?utf-8?B?OWdIRWNOQi9aWnNMVW1LTlFMc0J5QStsZEhsZUp6eGllUVRRUUoxZ0Q5THlW?=
 =?utf-8?B?a3F4VGJ1eE1Uc1B1L1c5RDJIdHh2T0E0enlLTWp3SXZWeW5GZTRVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c50c3f-0d18-4814-0905-08de9fead899
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 21:13:33.9382 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNSuBCjmHwnVeh5qjVSZfsulvKQDe8xEaOegZ28/HA8vdDNsJPKBtaEja2g5fKvf8uVWm0aWP/E3Bc43L6hIMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6805
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

On 3/30/26 09:34, Harry Wentland wrote:
> Add __set_dm_plane_colorop_csc_ff() which maps the CSC FF type
> enum to the appropriate dc_color_space for DC programming:
> 
>    YUV601_RGB601         -> COLOR_SPACE_YCBCR601
>    YUV601_LIMITED_RGB601 -> COLOR_SPACE_YCBCR601_LIMITED
>    YUV709_RGB709         -> COLOR_SPACE_YCBCR709
>    YUV709_LIMITED_RGB709 -> COLOR_SPACE_YCBCR709_LIMITED
>    YUV2020_RGB2020       -> COLOR_SPACE_2020_YCBCR_FULL
>    YUV2020_LIMITED_RGB2020 -> COLOR_SPACE_2020_YCBCR_LIMITED
> 
> When CSC FF is bypassed, color_space is set to COLOR_SPACE_UNKNOWN.
> 
> Update amdgpu_dm_plane_set_colorop_properties() to process the
> CSC FF colorop first (before DEGAM), matching the new pipeline
> order.
> 
> Assisted-by Claude:claude-opus-4.6
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 68 ++++++++++++++++++-
>   1 file changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index cd1e58b8defc..d5b4190e635c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -1492,6 +1492,61 @@ __set_colorop_in_tf_1d_curve(struct dc_plane_state *dc_plane_state,
>   	return 0;
>   }
>   
> +static int
> +__set_dm_plane_colorop_csc_ff(struct drm_plane_state *plane_state,
> +			      struct dc_plane_state *dc_plane_state,
> +			      struct drm_colorop *colorop)
> +{
> +	struct drm_colorop *old_colorop;
> +	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
> +	struct drm_atomic_state *state = plane_state->state;
> +	int i = 0;
> +
> +	old_colorop = colorop;
> +
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> +		if (new_colorop_state->colorop == old_colorop) {
> +			colorop_state = new_colorop_state;
> +			break;
> +		}
> +	}
> +
> +	if (!colorop_state)
> +		return -EINVAL;
> +
> +	if (colorop_state->bypass) {
> +		dc_plane_state->color_space = COLOR_SPACE_UNKNOWN;
> +		return 0;
> +	}
> +
> +	switch (colorop_state->csc_ff_type) {
> +	case DRM_COLOROP_CSC_FF_YUV601_RGB601:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR601;
> +		break;
> +	case DRM_COLOROP_CSC_FF_YUV601_LIMITED_RGB601:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR601_LIMITED;
> +		break;
> +	case DRM_COLOROP_CSC_FF_YUV709_RGB709:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR709;
> +		break;
> +	case DRM_COLOROP_CSC_FF_YUV709_LIMITED_RGB709:
> +		dc_plane_state->color_space = COLOR_SPACE_YCBCR709_LIMITED;
> +		break;
> +	case DRM_COLOROP_CSC_FF_YUV2020_RGB2020:
> +		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_FULL;
> +		break;
> +	case DRM_COLOROP_CSC_FF_YUV2020_LIMITED_RGB2020:
> +		dc_plane_state->color_space = COLOR_SPACE_2020_YCBCR_LIMITED;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	dc_plane_state->update_flags.bits.full_update = 1;
> +
> +	return 0;
> +}
> +
>   static int
>   __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
>   			       struct dc_plane_state *dc_plane_state,
> @@ -1879,10 +1934,21 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
>   	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
>   	int ret;
>   
> -	/* 1D Curve - DEGAM TF */
> +	/* CSC Fixed-Function (YUV to RGB) */
>   	if (!colorop)
>   		return -EINVAL;
>   
> +	ret = __set_dm_plane_colorop_csc_ff(plane_state, dc_plane_state, colorop);
> +	if (ret)
> +		return ret;
> +
> +	/* 1D Curve - DEGAM TF */
> +	colorop = colorop->next;
> +	if (!colorop) {
> +		drm_dbg(dev, "no degamma colorop found\n");
> +		return -EINVAL;
> +	}
> +
>   	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
>   	if (ret)
>   		return ret;

