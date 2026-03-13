Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451BE105F7AF
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:35:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1A210E13E;
	Fri, 13 Mar 2026 14:35:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3k6yb9ZE";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7985210E0B0;
 Fri, 13 Mar 2026 14:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnL1VFk7Re569gw3iqAwc4ikv57AQeBPDhTE+Du7oUqduh0rMICr9ieHYN2lUWSyYesBV2DX2vKULY+vGq6qFAhjtQUO5X5hqpwWm4IYsDjZmOPiErhld4CpujHH8COnrncSN8/VKDMoicyGdgAUpqcfd4pt+WIvkKCT2qdum3RjSmnXdMZxA+V+5owmP/ihs8Obg0OBYGSm5yjgytAL09RCytI7+JqxiDqW/MPMdTR6ijORA7TO86twiL6nakpnbNPE1BeuHpwG6rdkCgKHm60OFIbHcvOSCVWiPUwAkCMP2bcwxHeLzMQD45cue5Ylo5PUERigzsJqDY/GF1ro+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j0OdmAFP+vWE05KVPGSjqdw1M86ZsR1I02tBQNP6Eo=;
 b=t39p22jl12VnQl2h7SpkjemHBWEO6a5EhZu2YFCumkd/GPIzbMnYzyiJvhv1XJ7bRdrcNHZtbna1kFUj14XFFKAi2HRAyJ6D/04mkA1+jLQUOkhoLc6rUAiVA+mNM47E76KDOzygiIZgSFCD/9jR9DbFvABdTT1GD6SlaTcUFHvC2nIy/tFokuqCFel7c608Wbh/ABWKz2rKyXuse1OK5gPUPyfFWJ6z9Uth8go+NFoadCeZQbAaEhALeX4lOYTk9KgCvGm+PGrzgscuLPfPeILPfCjckFVWfm60uvky5DP1+bqCBes34dDkpVj9MG6G5RwgE9UfcLynmHiwvDx45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j0OdmAFP+vWE05KVPGSjqdw1M86ZsR1I02tBQNP6Eo=;
 b=3k6yb9ZEfxzgitNi09vljXCbmcj7LRCutsu7XcvUQhAsDzKHMAKAYGb4lBMFrAmAQqDdlEVH34FaimeQZ7wH8FrYuW6t7N521502TTbiDLQqDn/rQpHGgcRUdHjtVT3Z6l7iKjaL4L8OBCQsOw6yE1BbBSacjZaD/m7E8sngclw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 14:35:46 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%4]) with mapi id 15.20.9723.008; Fri, 13 Mar 2026
 14:35:46 +0000
Message-ID: <15e4fec4-0bb7-41e2-9543-1b1df3905172@amd.com>
Date: Fri, 13 Mar 2026 10:35:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix gamma 2.2 colorop TFs
To: Alex Hung <alex.hung@amd.com>, sunpeng.li@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, contact@emersion.fr, daniels@collabora.com,
 mwen@igalia.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Xaver Hugl <xaver.hugl@kde.org>
References: <20260311211837.2482799-1-alex.hung@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260311211837.2482799-1-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::33) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: dc5c8ab3-9e90-4c6d-327a-08de810dd035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: GmJiUCNY5PJW3BFSK2En/xEt+Pfw5wtfzNLgKE98VZOieGkDM415zXu6RsGOn9QKAzCOSCbV13P+AJ1lOBG/8nv/NHmkOyJi6e2mw/a/tEprWrWJ8X8tJVHuR8ZJ6KmJYH4NYIQ6wDxG/wCA/xh9OC/jetf5x/1O/32Jn490VtBf9rhtPiwaTPnNhOLJK+6UQ9RvaNebm9LMpsUg0lEcSK48nJJc35KKzSX88amXKV2ZAaClyXCJDXZZMIXbg8UBQUALmOdxGrWVUvmjtWaC9QLCaitdWXNEvYMZq4RD/8zc3VMcsbXqbVER5iAEipwlVfHHlqOToUephkwVGR+aPaCtvzwgHjk9uYQX331IEmaOE5ob36M033rfNvXFEUjA7Ui/qI5sb7+ajVeMa7Hhmjfu6lZkBJ2i3uQ6csWAYb/HrL61g6KlPgdaQHOvuoZ3LkgwdAhQZKBPzNBsAWFJffpwFPWO93Ojasuwzv22A+QKLZdCfCl4MYppIkZEOrUqc3hCrjhaIZaAxCwZJa0kC70bPmgTfByq1Rijsfx5jZ/qFkfG/+s/M/Ck+SgprJLwrayQqKNOcdeuNxfiAk8d+0ucObRK/6RytC5SWnQ0gmiR39ZxyWtFiPp5/t+tn7afpulMEbTEzSrJQn3LRNLI4BC//LeI6J2EzRzHhDil33vy4Jk27ZxsSFWrVL6ixxyngxeyWidftHITOC5ZF0hCMJzbmkoK6weonRTfALayPHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sml3YVVpTUprd09ZOU55T1RqN3R3QVdjSXRkV1ZJaElSMGVxcUk4cjBaQURX?=
 =?utf-8?B?Y25Ta25TRW5Ob0ZrdXplTkVienREZTF0ZUdabjBWWk96MFJtc1h0OHpPcTQ0?=
 =?utf-8?B?eGJyeE8zS2xMaElNNHMxRHhWU1hqZ2FnVkVPZGJqelFlZk5PR0RvSUdXTW5y?=
 =?utf-8?B?Z1E4MTZWRDV0NmhOZDhUWmU5WlN5STZ1U2dwUjVpL2hkVm9RdVRzQ1IyemdK?=
 =?utf-8?B?eVNXdG9MbWdNSmlIcFN4UUljRjZwTmZubWw1YThiL3dWcVlETjNuYmRDekNL?=
 =?utf-8?B?K0VJSmhqbFB4K0pHWGwzdEZtM1ZsTCtxT1UzeHVHekFNVmRwYjc3WjBieWhH?=
 =?utf-8?B?SkFtUWRmcC9uYmlNUStpYkRqekJ0Z3l4cTF3WlNFZFc3MnZ6OStqeXFCc2JD?=
 =?utf-8?B?cWpGZTFQSGwzQ2Z1eldTdWppSDFhK0d2am5QMkdQTU9aOUVtNkYvVUVrWDBa?=
 =?utf-8?B?ODRTVjRMMzlzVTRuYS9hUWZMdDl0S0d6akxPR0MvZVJUU04rY1V3VWc0dzlu?=
 =?utf-8?B?NmZoYlVKQ2prNXJKdUNYTktld2tibXZtV1dGOXlpazVoNVM2SVgrdHVyV1M4?=
 =?utf-8?B?RlpUVUtEcE1vaE9BaWlKd2lwSHRBNDhpRWJzMENrSFRmcWhQOG0yTDVrVlFL?=
 =?utf-8?B?RVYrV0UzT043UHl3ZUtldHN5VkVQY1ZMS1B3dmhnZUtpYlNyZTlybVlJMXZM?=
 =?utf-8?B?aWNLODBSQjMxS29kNFFVSEFpZncxZzU1bG5lMzRIaG44ZHVrR3lFeHk2ZWdK?=
 =?utf-8?B?TFl6SXB2ZytFVUV3dnF1TWhYZWVKYnBZWGEzYUJUZ2tNWnhxSVpyWDYzZWRy?=
 =?utf-8?B?SVlNLzgyR24zYUJrUlJvdE1FMUhSb3M1QnpqZ0p5enlldUhrbEwyUFEzVzJO?=
 =?utf-8?B?N2w2WVNoNWxWczdWOXFuY1lwQ1c5SSswNjk3M1RCQXRZWXR0SGJXcTFIdGpt?=
 =?utf-8?B?RkRFWVB1azJVVG5XbFAzaHJSNEVadTg3ejFxSm8rS3ZkV1JFT1JNZ3U4eWJy?=
 =?utf-8?B?MWZtRnU5QjI1NHdqSmpTUUtPeUg5NUcyalpuOVVEZUlTQ0JhWjRObGVVejFC?=
 =?utf-8?B?RjJ0aG9xMGwvb0ZRZVZYS0dqcXpYYnNUSzc2c1d3Uk9Ya0RiemJCeExSOXJa?=
 =?utf-8?B?cFlXK2FodDl4L2lXRXJLUHQydVpiRlFJaDZtN1F1Lzl4ZXUzQW16RWYrZXZH?=
 =?utf-8?B?VjI1dEExQVVJejNwemg0anZ2OVd6OVJ2MklUbVhmNW1SQWF2ajc5M1pURmtk?=
 =?utf-8?B?c0JqN0txc1JXQUhxMnlrZFNuSFgybDhEM29UYmF1MHQyOEhqZG01U0p1Ny9R?=
 =?utf-8?B?Zm5yM21TWkZRSHdSTTJnRDU5SVdvOFJzNitXazNTUjZNeEY1WlFpMVJIQ1Vu?=
 =?utf-8?B?Qk4yb2w5RnN1cDQ4dlF6cHpkY3B5UDU2OHdOM2JqUURkL3YydDQzNm1yS1Bp?=
 =?utf-8?B?SEYzYTZrb3Y3aGxOVHZNQ21laUFqd1dGOGJ6M3cwS0Fkb21lUzZVNUJjNnZS?=
 =?utf-8?B?SVNkbkVuZ1JIZFlja1JsLzJaR0VBS2w2YThBWjFhc083eXdzdmVMZE8zb1hO?=
 =?utf-8?B?YWlocUUrT2htaXNkbWdmWm5CMG80ZUkxd3BsUEpqWkxwdXNIVm12S01lenYr?=
 =?utf-8?B?YndjQUpvaWNxSUZjTXNqNi9XbVVuVXQvR3pzcWFZc0hUVi9ybzRKVlFXc3d6?=
 =?utf-8?B?eURFZDhhdkFCVmtUVGUxWVJ6dmJ6N2JsUmplakR0c3lEQ2N4RklHN3hGby8x?=
 =?utf-8?B?MnlOUnJwOGxaakxQVTMvMWV4UWcyWWozd2QvTmpiWjRydmxHUmpqbWF5aE95?=
 =?utf-8?B?Y2RQNDBDT3NRRWE1dFBCRXNwQlJqeXRKNkN6a2pYeHNnTThlSjdFU1JEcVlX?=
 =?utf-8?B?MENxRjQwZ0JPMDZmdG15MnNqNkFNQlBNL1ZseXFmR3dMN1VVaWM5WjFGZklM?=
 =?utf-8?B?cVVwbGt1cnN6eUh0aHlsajl6OWVGQjFqYVVPVU4rcHhJQ1Jwdk5pZWY2b2lM?=
 =?utf-8?B?NmU0YmdCajJhUnZBOG1JTVRRTXhPWEYyUGxoaWk4N0k0Wm1KVnpuc2RoOUhP?=
 =?utf-8?B?K1V0QW8zd2pibjQ3NlpRZXc0Q08vaU82YTk5L1RINUdGSEo2LzQwTytXbVVG?=
 =?utf-8?B?OHFnNndnQjUxQkpqRE9TVUoxRGhTZkpVdVE3NkkwWWw3a2hMV1VzQVJ0SVhl?=
 =?utf-8?B?K2hMa3Z1eSsvSlMyUEdYdHdUb0UybTF6dlE5RnJBbERqN3ZoSWd0aUxQb3NJ?=
 =?utf-8?B?TmhjMGc3cy9ybWxnTkNsR2Uvdk9wQ3dJQlNkRHp4cGFwb3NaTEtKeDU3bVFF?=
 =?utf-8?B?VklIZ2FFalhWYWEwcGVoN2Y2bExOK1NNMzRla1hRR1lBS0hVUjB2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5c8ab3-9e90-4c6d-327a-08de810dd035
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:35:46.2173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixVvQxZ5UtdswFhRw0IoSiLzKGOKx+flX7PdLhzLKzin0rR2MSEZvTOufXpeHIbIClPS/bHwVYIA5k0Pt1NXBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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



On 2026-03-11 17:18, Alex Hung wrote:
> Use GAMMA22 for degamma/blend and GAMMA22_INV for shaper so
> curves match the color pipeline.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5016
> Tested-by: Xaver Hugl <xaver.hugl@kde.org>
> Signed-off-by: Alex Hung <alex.hung@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index d59ba82d3d7c..aa4658867e55 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -37,19 +37,19 @@ const u64 amdgpu_dm_supported_degam_tfs =
>  	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
>  
>  const u64 amdgpu_dm_supported_shaper_tfs =
>  	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
>  
>  const u64 amdgpu_dm_supported_blnd_tfs =
>  	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
>  	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
> -	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> +	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
>  
>  #define MAX_COLOR_PIPELINE_OPS 10
>  

