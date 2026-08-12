Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309B8C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:01:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ABDD10E32A;
	Wed, 12 Aug 2026 22:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5erptxjc";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4915510E32A;
 Wed, 12 Aug 2026 22:01:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdHS30CC7R016TWi8MFSOdT/KNfnglqCOC2xqD2jQ0ij0ZAJh5QwuDeYThwWuqXi3agtShQE8kcYbI1A9NWVm0y/yYCIZARtAELmDzBUv4MNpylJWA3J5m15hZQK/9AwceknpkG9K599SCZ8CJKoQ6yCtarwFCnwXYeZUtvKgG4ww0r//2lRoUn3ioyvNaygS97OMwrfQXAzs7MCEyOdFh+m0jZ8M14Mjc6ratbqWf3cPmrLF9BljO/bE9FqN/bgTOddhn1h292DdKrGughuGwuJGGYOEo32rk39kj3V4X2qoevdfBb6uIj+EYZq5F47uLxjsSamkOsz2MIiNfjX1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfPlVnHZNwm6RzqwDm8zS8chVg/D+EGupmxFLoMquCs=;
 b=dcTYNudLW6MdIHkVRQeiWT2vFYlWHMcCDrsEAsv3g+xC0KBMI0i8fZd8lkKixokJuRri/3xJ11c+3+ZuQpUfv/eKY/O4zyKs6BUGpvz+V4JGL5HVl02SO6/WMAiErheXWd7r0KlaP/4VkuzL7IKjgmbeINTSN8bDQTtAia+LL17j7dOzc+Z1m+WD4u3ejmzJp0t5fidy54YZZEgmSH/m0h/5ZAYY1wyheu8XIcTY7vRPZoBsAtrImgU96q4V8i/h1uqNzZXni0i6+58iXZykfFIhSlSezylQu2/Iy5ZkndCDc1vyhEMZ4q1k9GYyCytW9Z3S75rKrl9v8FQE91RO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfPlVnHZNwm6RzqwDm8zS8chVg/D+EGupmxFLoMquCs=;
 b=5erptxjcaz5Zf76GPLLi5+2tYP1BqZP5LYhjuOMqVnQun/ExQfwnXxw1wNGG11LwTQfH/bPNHNRD+r0dfTWSBpe+v6W0m7//4fTC5Gw0rgD2e5S0pZW2v2U78FpXmYr6lAB34DW0A9FEUadI0EKhy1aM2Q+NrrkvTi83JLfGPt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DSWPR12MB999177.namprd12.prod.outlook.com (2603:10b6:8:36f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 22:01:09 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 22:01:06 +0000
Message-ID: <fca20ece-553e-4c01-acac-de608ec5eb8d@amd.com>
Date: Wed, 12 Aug 2026 16:01:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, leandro.ribeiro@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: kernel-dev@igalia.com, Lyude Paul <lyude@redhat.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260804140758.107683-1-mwen@igalia.com>
 <20260804140758.107683-4-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260804140758.107683-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0251.namprd04.prod.outlook.com
 (2603:10b6:303:88::16) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DSWPR12MB999177:EE_
X-MS-Office365-Filtering-Correlation-Id: fee17d56-2646-4096-b9fe-08def8bd353b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|4143699003|6133799003|921020;
X-Microsoft-Antispam-Message-Info: nxkhJLB3I6GLWTpjz7kuMbrXcDJnhIFRdaux/NHHhkbywE//+abRsfjz9mgrVafZD4VW4yK8VcdcO3MNlgJvQcH3gAzKXmYMhN6VHieT/RdhdF9NCMrgtCE4oDtWjIGxEDAQol7vVTz3d5BTOCWMjROz6Sw3OK4n4nY5J+M9hd0+sgNhGBoQnnhv0oXQs4nAJhETRnMIJBrl16m96yAAgbhuFpzkE3Gq5X/BALnJDU2vgkBCcTYgpkkN/0+ZkhgPoH2BoCXEbuT1LQVbDhj+hsmM4yVIdJDU9arXsG63URmDh0ffhcrx9aM3tGGhmewIniqrfRblQF8GINc7XfhdKJmpM/xjTPJdSVlfYiHHYcw4SDuRpsfZjt5N8WS0wo2RSZItuXtPGdtgKjXc8dXlAymRByDfr5rU14nNgLRyti6nNLMvs9ZLhktMfUQvg7aWMatRp0CQMKbp0P28AAUv0AgcqGHqFByK+v6i1+EVlCfKeXkLBj96tmNDEz5seOV+RONyAGhNCS1nBPoOcRc/FA1gkcfbf6H63YBd/Zx9igwf2XgJUdPoP+qSL8gnn8fKhJe3DoLGTh2SDCX/IAJJRyKKQw9ozEynq4+JJToaeQDNdqcIs3jEbPmN5TbMsc7PIRxdI1C+Xz1T5LPBIIPFh6e40PlpO0YnHy8IfzcYyMiPV/M0HafAWjaupl5NGKgF0oM2uLfjP1euWXdlVYB2cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(4143699003)(6133799003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVlDb2l5ajA1WG1Qd3M5MC9KWTdjS2FQT1ljZ3FVT3pJeFk1T2JyUUJ0SmE5?=
 =?utf-8?B?UWsrbVlaWkNGQlJiL0ZoMUgyclMyTnpoclhEVW4yQ0FSSmRDUkdlWGtyalVJ?=
 =?utf-8?B?QXpIajEvYUc1cjVVY3U3SHdUTmtybHE3NVRJTjJmQVMvLzlqblhKcUt3YVBp?=
 =?utf-8?B?d3lXR2ViVzJ2ZUNTOE56TlREWmtKRU5XN3JvS2F6TldQKzhhbUhtSkxPVmgz?=
 =?utf-8?B?Nmt0b1ZYSjdqNTl2dUZ2S1kvSG11QkhyblZabVVRWFpwV0MvMlozZUJtVU9v?=
 =?utf-8?B?M3ducnAzUjlhaWVubXZIYk1xV1JaQjlCNHJScXVzdzVRTjVRU3dYSmVMYTlN?=
 =?utf-8?B?NkpNbkFSTitVMERYbDhNNVRZWmUwdTZFd2JKVDV0MW1SNlJ4YWF2L2ZyS3Yw?=
 =?utf-8?B?ZEs0VGlmd3R0SXIzN1NUcGtaRlR4UmVybjZDL25zVjVna0xrc2QrYkhuQXhp?=
 =?utf-8?B?T1phTlQ5R2JGYnY3cHY4U3hBMkFFdjlpbmcvMkVCOEt5eTcvWGllMnNVdDhm?=
 =?utf-8?B?ODEwMHlxSmdxUERpa2htRUNvcXZnY1d6K0lsWmlLWlQwVjg2Ui9zRmUrWjR4?=
 =?utf-8?B?ZnZlU3EzK3NPdDVUZ1Y2QVdGeFJ4QTZUVjgrV1JYcXVqbzVxYzVHeS8xK2lI?=
 =?utf-8?B?ZEk5OUhLY3Jmd0FXZ1ZpR3B4VithMTFWOTJXTEE4bGRxSzZJRms0Z1E2UGJp?=
 =?utf-8?B?NTU3b0RlbkNJZG94OGh6VGtEV2xQdTc2Vk51bGVJazVHWlpVRjJGbm5OSnho?=
 =?utf-8?B?QVFYOVJXV3JlMlN2UGs4dzg5M0Q4UzlyRm4ybVEvQXhnSlE1ZGxvaFZmZElS?=
 =?utf-8?B?b2t1SU4yWDhwSEVRdksvSmhod2J1UUdud1R1b1FFbHd2UHBOSTQ1a1E1OFN5?=
 =?utf-8?B?NXMyTDlVb3NRblo4Z3lyNnVnSXd4M05FZlNCZndpcHhUSUtFdTIydlRaV29X?=
 =?utf-8?B?dXBtSzAvU0NkYWgxbWNSNDF4UTJ0V243YTBKQ3NjRTlSN2dNajdBKzNmdnRj?=
 =?utf-8?B?Rmt5bEhPZzNYV3ZtNnpKV0NxWkNsOGszZ0RnSkV1eUpqSzNxK0NCcUN4Z0hV?=
 =?utf-8?B?T01wRmVtM2FWYmxEZ0M3dlZ6Ui9CaytMTThHVFpWUmRvQXV2eGpQWWs5OE5m?=
 =?utf-8?B?bENnbVJxMXZBNUZFblFTeG5RbURLZ2UyNWVYZkNqVnZnYVpDaFFMS0lQT3ZL?=
 =?utf-8?B?RHo3ck5kbDQ3OHdsOGFEYk9rRG80MGVLY00xeHVmOVgxM21YaTgreDlOTkZk?=
 =?utf-8?B?dDA5SUpkdjhybjJIQTh5UHRUcjM1QThXVG5vRjE1S1RqcjBsYVJKcUdNcGJF?=
 =?utf-8?B?RzJVMWkzb2kzOEdybzVDNG1NQ0tTZWV5OVVnaWhrZ2RiVW9qSm13ME1JOFV2?=
 =?utf-8?B?TGliQmpTa1hPdVc2L1VhQ251Z256MjlzM1NFWXlyK0FXVGc5RWxSdS9wazZP?=
 =?utf-8?B?U2xHZGtXTVY0VUF3Z3lZcncyZERDQkVlVHZPNVdGbW01czVORlVPYXZGUnQ5?=
 =?utf-8?B?dVkyUGt0RE8rVXF3U1ZCUnpRV0dtQ05lbVpudm5lL2FsZ0R2Mkxxa3JkRmc1?=
 =?utf-8?B?ZEFaaVRrQ2R0c3ZqZlhQcmV1SHFhZlh6MlhrL0NkME1PclpTWXMrL3BRWThs?=
 =?utf-8?B?bDJlZFpWUWp5Q0svRHlYeXdERUlVMlU0dnRTNC9kaWFsZ2pwWXFFUS9xWHJG?=
 =?utf-8?B?dXZRQ2FjczMzak1QMUZROWxXbkRZQ1padjJDbmtTUkhPaStWcVZZZERoTHBn?=
 =?utf-8?B?RFlJSER6WG5Idm54MEwvSGhmUnc5SU1Ga0NseGJHNC9DYnJoS2hmVXNTRTI2?=
 =?utf-8?B?b3FJY3ZtcUhTV0VZWGxHeThod1JvaXdSOVRvZHVULzRKOUxBRFl0eVdhaWxU?=
 =?utf-8?B?MG5JYWt0aTB2NCtySHpHVUU3Ykk5enVaQTZweXQrWmNKVXowRW5FZGFQM1lq?=
 =?utf-8?B?TzNUUzhMYnIzeHhlRkRHbTk3enNTKzU3NkJIcktDMW54N05QTEU0VmwwMzhh?=
 =?utf-8?B?OFVLbWRPQVdwblNaY1h4QlBQL1BFTy9hNmRpVDBzc2szRmVRUm1rQXpNS1RX?=
 =?utf-8?B?QTVMSTNJR1pLcmFzSTQySHg4MmI3SXVYQWsvTGJKSEhlRXJZRDV3S1hDQ3Br?=
 =?utf-8?B?SEIxNzEwb2U5NzlwL1paUFM2NFFjYkFjTEFQL056Ym96WVRyQTgvWEJhYWsv?=
 =?utf-8?B?SjlMaGVHUGZNZUpkaTFra2RpVy9zclZUaGt2S3F3SWZ2MXpVT2ZJMGpzQmdm?=
 =?utf-8?B?MklwcmtJQjYwS1JjZGxGMG40bkVTV0hwaWRuNEN1OXBLc1JJNkV5dUdsTjhT?=
 =?utf-8?Q?45XXofcLLDhVwRCGC7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee17d56-2646-4096-b9fe-08def8bd353b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 22:01:06.1166 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LfJqDUog9MPx1a3xlO0wY/wkGmxbEX7lqXxHvFP/LsDLDrQotqSkb5hfWIzqrlPUB/QI1wXzVg5ztmwAqbg1Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999177
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



On 8/4/26 08:00, Melissa Wen wrote:
> DCE can support PREMULTI and COVERAGE blend mode depending on its
> generation, however current driver implementation either doesn't expose
> more than primary and cursor plane, or doesn't program registers for any
> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
> warning according to current DCE plane caps, create blend mode property
> with PIXEL_NONE only for primary planes, instead of the DRM default
> PREMULTI.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index a276f3730044..60ccf1f9fcd9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1923,14 +1923,18 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>   	if (res)
>   		return res;
>   
> -	/* TODO: Check which blend modes are supported in DCE-generation
> -	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
> -	 * property accordingly.
> +	/* Blend mode support varies on DCE generations according to HW caps
> +	 * and number of planes per CRTC. However, as current driver
> +	 * implementation only creates one primary and one cursor plane per
> +	 * CRTC for DCE (overlay is only created if
> +	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode ends up
> +	 * being always PIXEL_NONE across DCE versions.
>   	 */
> -	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_NONE));
> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
>   	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
>   	    plane_cap &&
> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL &&
>   	    plane_cap->per_pixel_alpha) {

A nitpick - the conditions are no longer aligned and becomes harder to 
read. Could you please fix it when sending V3?

Thanks

>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>   					  BIT(DRM_MODE_BLEND_PREMULTI) |

