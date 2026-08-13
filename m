Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6ADEC5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B3BA10F494;
	Thu, 13 Aug 2026 17:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Sc5+xl58";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3A710F494;
 Thu, 13 Aug 2026 17:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OjndOFuLYIXJJcrewtPjeIQjJ2Tqi/m+3qbH9Fe3T/xoXh0xRWgsDY60Oof9Y4BQEPYcLEXopa4k81YNRKCp4MyLKYBJydHIxl1cTcB0WLneDyoKeqpaLta7iahj3fS+NMTnXDBlDxhp5+8dERj4q7QOMwEC60V0ex7gP51xx/QSKdB0LNNWNNCQ/6QiA5lf6HkFyoJGK/XOOO63KN17Wated2Zf5VzxluJT/VmCbTCo4i5hbR4XS5xsvYDH/1CDeJ0FRBbHlzNxDMN1EYD1k5iJ2i46UQngdhWPurPlvZwn+8ssdW7Sfn8WIn8W6Y+Dekm5T1n25rfUO2dkNj/+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onlKc7PGNoIIazC3Tt6z8WlvW6Q+WQZlC0CBIJmM5/o=;
 b=lRGxrrU3ETgSLWwop2Za20fzCAI7LWus62ycBvOg8cFjYQi3MXw+D1kSw//4pMtC7cO/srrZSYK6m1H9Gr3ed3v0SsnJp5YLn17GySVZDoEHt+P+W2FxkC6Osu6UJ4ZxNS0owyQebS3kPYNWAeInqPzNfEipIL+OqRpnkApPWyu1VTvKBH6hLcYD3TZB7Cvo1+Q0rcdG8EatxuaZBTkzxiHjefNFP3z7/ibIqeUeI6ApnvRVqXLUrZ/+yaatWnKCG9i+5IUyz3LRkyqUWkC+NleuA+o196UHlVkz7Ek/hGn7eqyOxfNl7PI0WABYs9+0yZiEy6PFZzmO8pvO15afmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onlKc7PGNoIIazC3Tt6z8WlvW6Q+WQZlC0CBIJmM5/o=;
 b=Sc5+xl58wZEFqe/EdTsxia6oCwWMfpTl5isGX9/y0QtnWwdYCdqcPAjXW1x+ET7xwrsBkFseglK6r9aFiNtDI/mL7bAVRwXirwm9ECw429Cnh1RCkzAeE3TJX5iXPMD2KRA37UDz0ImuSioxNT/uOCSmGKiPlW6NwPf/1dGkos4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 17:49:40 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 17:49:40 +0000
Message-ID: <bcbd2ce2-d668-4992-8ba9-8d20a0065b18@amd.com>
Date: Thu, 13 Aug 2026 11:49:38 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/amd/display: fix missing blend-mode-prop
 warning for DCN
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, leandro.ribeiro@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Daniel Wheeler <Daniel.Wheeler@amd.com>, kernel-dev@igalia.com,
 Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260813143605.106104-1-mwen@igalia.com>
 <20260813143605.106104-3-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260813143605.106104-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0385.namprd04.prod.outlook.com
 (2603:10b6:303:81::30) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: 6958e4aa-f68a-46ef-99fe-08def9633fe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|23010399003|1800799024|11063799006|4143699003|56012099006|10067099003|6133799003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: mtzRf3DR3AkyV0hvtD15S4gl53TcA4+yRj0FcqQu2IZTxfOYVZgWrwfrzPG7vaXJoEVBhEXP4khBzc8K5sBUwV+lYO7fYKtb/uTqmMdMKp9JUW3Gzi8hWox9USYHMVTPptca+t6Oa3v5Q7bO3LK2IOpP/GfLQlaTnskpHATwTJhhBDvzvRdtgFs0gXyZEUnXmA/w/R8+olZTiWCOQxVZAlJNRVl/ChHgJHs0wGG7TrxSDapZaBT6mBFK8kjVCl/H4vY7B4duLOjmT9Oc5Mh0xfO305OJu8a8ade4eEG5EcX2wqtTO2ZyW8R75c/Gn8PtNTWfXc7r4tYrorlic8QIEiF7CQyfkufXbqJHdPAeD7bZsQQWiRhWhQ3eRDWMi/kvklPEeDQjiUle2wXrHCMRyN7BCiTFRlfGi+uO62FIzxk2jVF0BqigPkaGJWlqygyCPZEtrrh+vViqVYoQcbO/ymvB6fvraDTFdsinMfJR/U791/u97Gjaf4kT3Bfe6ZByvLaURNKg9j+jPUqCOwMaehS6UvDZ8GKnDOL8b2yM0tbjlgjnk6D5uQ70tUjBoGMZmpCt30rYBNTjr3l0aNaa7Qea3tcdPuzvddUDCCMknZ99NuprE2VCs+GzUlkGHkDe/OuN+oJj1GA5+7zp4dHjJkl817rgFlTyhbJrPdlutqJwxPj0sUsFXv3NZN8TOAtwOmRYew66mIXB30ZQdXa1tA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(6133799003)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdjRFNxeHRMRVF2bWtkN2NDM0IwY0owUlhFYnhJRmh5RzEva2krQXJKeHA0?=
 =?utf-8?B?ZUlIeE1JTFA2cGRTcU8vQzB3aUNTMWtMSkVVekNTUXM5U1ZBaUtCZkY3NnVh?=
 =?utf-8?B?UCtLV3BPOWJzRUt1M2pzY3hDbTl5MGtJOUp6b0VpVTkxaGRFWlQvTkRmNVNK?=
 =?utf-8?B?ODV3V1F5Z1c5dDdaS0xmaWdnRUNiNXg5alBjQTFOUm9ZMVBIYjBXYThIa2JR?=
 =?utf-8?B?ejhFdUlJQ0dybmFzQWozWTAzTFU4UjR0bTNRNkZMZit1a3BETytmMWZXVEV1?=
 =?utf-8?B?K0lPZzhRSW9acWxSWTdpYWV2NHpGMVQ2QkpudzJWRkVzajJYdDJkeFVNYUZ0?=
 =?utf-8?B?amlzZ0wvZjlSYi9CdU1PR3l4dnRueDVZQnRuejRjdlN3YkNtTVk2VHdPbTZR?=
 =?utf-8?B?QW5pR1pzUFJYTUdmQnIxWGRPOVNSak85V0RwS2xoMkhhbXROUXppSUdvVis4?=
 =?utf-8?B?OVhSdGJwNUJYQU1PRy9jYi9qMUd3Zyt6WXZGSHl4d3g3cC9JNnIwV0ozS3Bv?=
 =?utf-8?B?MGdJbEZHTWVvR1VCbzBUd1Yyd2lwSTh2U3hHdTNlYUJaRk5JUG4wVlhlMGcr?=
 =?utf-8?B?TWlHcm9hYTcvTks3UTdpbEpWMnR5Y25UOTlBSUFNMkwxS3VnRU5xcjN0L3lI?=
 =?utf-8?B?UXNFZnN0cmlOUUFvTVBYWkUvVWVKaGpWNlFQZW55L1RVZlhMTHg3UCtuZUFO?=
 =?utf-8?B?eGUyZ0k1cFJtcDVhUGJPd0J6enljZEVFQ2xDTXZoODBJeTduZzI3SitZM2gr?=
 =?utf-8?B?Z0xmNDA0OWV1VGpqU1RWZk1KR2dNNGI5MDV0bUltMUlkK0E5bzBmQzhTaXFj?=
 =?utf-8?B?TEFwTDhiRHRDNE1ZbFJTaHYwWFdHcllIcTBQKzBEam41RDcybnFEYmxTeXBt?=
 =?utf-8?B?aVRMbXRkRVpvYjAyS0Z3elNQcnQrQVBDTFppZ253ZjhLNkd0ZXZQUVl3bnI4?=
 =?utf-8?B?Q3dyQ2Z1ZWtwWk1SaG5pRGxHQ2RBaFdKeGxGUy9VK2FzNkwwSHZPdEMrSzBI?=
 =?utf-8?B?RHNTQWllNmcxRFNTZmpodHFPNi9HOVNiR0FEQ1J3OVZCeHZFTzFOUHlxNlBp?=
 =?utf-8?B?R1BsZVpMeUhMR3ZMRU03RzdDRUQ3OFhYVzMySWZmbm1Cc2N3anl3UEY1Uzhs?=
 =?utf-8?B?WTA0b2ZZK2Nqd3lLMk5veGpzTlFnN1ZydXcxK0QrN1dHOTkrSzBIQTZSZlov?=
 =?utf-8?B?T1hWQ3cybzYvNDVHVFV0cTdSektVeEhmK0JicVhGRjNSSkJWV3BVM2dWRWNi?=
 =?utf-8?B?amh6NHhPR2hPZnVaR1VaRkpSbWdUWEYzM0hGV09PZXBnR1h5K3JPSmVZbXpl?=
 =?utf-8?B?VWYwakZuNElhZ2NZSlVleU13U2hBVUNrWU96UXo3YkFrODYvRHNiZWI3c2JF?=
 =?utf-8?B?UEd3WnVMajN2TUdjYzlOZnM5R0xDa01aeGFBUjFBcncxVTVMSFIvdTVmMkdJ?=
 =?utf-8?B?a25rZnIzZml6NHBzL0F2SCtYSWkya09BeHJydUVTNFoxVVNKMktlTURSMVcz?=
 =?utf-8?B?UnNva2hWSXpPR0dvMElvQW00MW9IcEtlTzlGSHErMy8xZVM4K04rR3hVbTVT?=
 =?utf-8?B?cWVjQnhXbE4rc2dJTEZiOVh2aklLUGhBN0k4Q1ZVeGhyZ1pjMzVoUk03dnVF?=
 =?utf-8?B?SFZUNitTNTFMMFViN01CK0k2NGs0MUJnR3JGVWdXUVNxSEJyVjNXQVdjTEU4?=
 =?utf-8?B?aDl0TnhOTG8wc1lPemVkS3F3OE9ZOE0rNC80Z1FRMkVlU3ZjNmo1WFUyMzQ3?=
 =?utf-8?B?UVVpWnlCYmkvMTlwSXZiOHFSOHNBSkFhRlA2eFlXaGM3WUhPU1NaSWJkOUZF?=
 =?utf-8?B?bXN4Q3VQRW1kb2QrOHJmcGVQVVk5dnczaXhnaFIvbGVKdVllbW1USU1sWWo3?=
 =?utf-8?B?cXFna21yMlNNQlNYQ0c3aHhVY2F0TitnT1NhVSt5dHVmeUtFMGFJSTJmdlRL?=
 =?utf-8?B?dEFWN296U0JiK3o3aTJtbm1QUWVQcjVBK1RJOWFYUmc5Y0xSUXBqeUtSQ3Q4?=
 =?utf-8?B?ZWQxcTd5N25ML2ZndzUxL04yNEtFQXh5M0JkaVd5S01iR0tTbEJzSlRZRTJS?=
 =?utf-8?B?YVdxZytMOTRoMkxYbHNrTlFhV0dNUURBSlBVcWdUUGEyczBuY3B4cndGYStQ?=
 =?utf-8?B?R3dKMlJkdENlQmRJMlQ5Vlh0eEJFdmlHalh6am1qU012UjdHYTk2MjBWUXdZ?=
 =?utf-8?B?eTRsS2ZSMnZ2YXJWRFN0cThteWlBUFp6bHJNZVZISFM5V0hpajZnVzZQeWox?=
 =?utf-8?B?NnVPR1lTRk5KNC9QcURMU1VhcnAxRFU0dE8vWFV0dmxOUjFXMGk0QTM4U2U1?=
 =?utf-8?Q?mCEoXsd9qbacyxIe15?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6958e4aa-f68a-46ef-99fe-08def9633fe4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 17:49:40.4195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qseGZ7214hdRn8AWHjRCDhUx9QN5MH1GVeQVj2uQy8D0bJsu0ZJ6LAecNva5ko3jCnQlfFbHp1xFWIA6rMetSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057
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

I can confirm IGT's "kms_plane_alpha_blend --run-subtest alpha-basic" no 
longer fails with v3.

On 8/13/26 08:30, Melissa Wen wrote:
> validate_blend_mode_for_alpha_formats() warns when a plane supports
> formats with alpha but doesn't expose the blend mode property. Fix this
> by adding the same overlay plane blend modes to primary plane, since
> they are all universal planes in DCN-generation. Cursor planes support
> ARGB8888 format and CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA is set by
> default (other color formats are not implemented), so only expose
> support to PREMULTI, which is the default blend mode on DRM.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 
> ---
> v3:
> - keep primary planes w/o alpha property
> - re-order if-conditions for readability
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 21 ++++++++++++++++---
>   1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 1b564cfe2120..ab9bbe8ca333 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1923,16 +1923,31 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>   	if (res)
>   		return res;
>   
> -	if (plane->type == DRM_PLANE_TYPE_OVERLAY &&
> -	    plane_cap && plane_cap->per_pixel_alpha) {
> +	/* TODO: Check which blend modes are supported in DCE-generation
> +	 * planes, i.e. DC_PLANE_TYPE_DCE_RGB/UNDERLAY and expose blend mode
> +	 * property accordingly.
> +	 */
> +	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> +	    plane_cap && plane_cap->per_pixel_alpha &&
> +	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>   					  BIT(DRM_MODE_BLEND_COVERAGE);
>   
> -		drm_plane_create_alpha_property(plane);
>   		drm_plane_create_blend_mode_property(plane, blend_caps);
> +
> +		if (plane->type == DRM_PLANE_TYPE_OVERLAY)
> +			drm_plane_create_alpha_property(plane);
>   	}
>   
> +	/* Cursor color format is set to CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA
> +	 * by default, so only advertise DRM_MODE_BLEND_PREMULTI blend mode for
> +	 * this type of plane.
> +	 */
> +	if (plane->type == DRM_PLANE_TYPE_CURSOR)
> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PREMULTI));
> +
>   	if (plane->type == DRM_PLANE_TYPE_PRIMARY) {
>   		/*
>   		 * Allow OVERLAY planes to be used as underlays by assigning an

