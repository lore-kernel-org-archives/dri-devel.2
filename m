Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9A5C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69B5D10ED9B;
	Wed, 26 Aug 2026 17:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w9DehY4k";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DFA010ED9B;
 Wed, 26 Aug 2026 17:09:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VveR0mw01ducVajoqiXyTxz2XyUaiCUHK0dn5gk+vpsRnCxWzKbt9m9MhvkL0qTrjBFrv+v/C9kffrkhjV/hapH5V9ajZiBrQRZdaDa1DGi5OdCRRCQ7x7/ODuThVl+g6/zbD7NNE46DWIs3qMJ/Ttg/GoMYnERGsS9AYGtmrmERV1CS3XjIG/80tcJClIKweJI/Z/faW7btzKYOmKgtLvzqPB23mQ905EP9tAoXAkZJfhypzblwGqRmx0QjdpYmZO/mZsoi3tf1dZ6KF5/S8eVd2p+i2LbEtBj3W5mx40Ed8CP4Y2d/FCtXxJY/4cFZ7t3Y1BYGn24FNxO8+N1Rtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHEvlm5k536ux55NwHpp4mfJ6n5Qb4h2On1iKrn6ijI=;
 b=AUE3WSwGMckymq3dDpAWqLejbJwmsrwv8GCTr1gONQDCMiHQHEZvhOSn7ulHwQHEKnnvuFz/8ns6Ll6XQ1b/fjy665Uy3oOGzV6YrpEQlhqVU+ERLaa/qQk6vW/Z4Af2yv3SioglHoEjG896oCKtycsQ2ChYNSwLFri4dEdZLdz+5UDnMrZKlPmSxwRE1bviYglKGEzL7haEGIvluzgGdLuhdw776QBTGYzLoQHO7qGpDFVWwAMbJ0GTbprzOVzbVN5OKEREB1b66WwB20YKQHhDTnvJT3PQYj/3jRZp9GIvhKkyVuqYKlWL53vwcekMoFTUmj9t7gLF2XJJ58xgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHEvlm5k536ux55NwHpp4mfJ6n5Qb4h2On1iKrn6ijI=;
 b=w9DehY4kvALsp/DR3EhRjf4ieIGyvCaLJecDdCYkdtr4qo0S7uJFeOE2vBbXgOy4Fc9bC8Svw0ZzGOH96dQ/W9eOAhS9cyXE0XYGFAi7mWiYBV14/iZy17Oe1AcZTVNIhLL0YtyN+2m1mJOWLWqhSDfiPKdKSHlPP2cIoXJozdQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 17:09:09 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0360.008; Wed, 26 Aug 2026
 17:09:05 +0000
Message-ID: <a4fde5da-9712-4595-8f9a-ee20a48e5c3f@amd.com>
Date: Wed, 26 Aug 2026 11:08:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amd/display: advertise PIXEL_NONE and PREMULTI
 blend mode for DCE
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, daniels@collabora.com,
 harry.wentland@amd.com, leandro.ribeiro@collabora.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 pekka.paalanen@collabora.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Daniel Wheeler <Daniel.Wheeler@amd.com>, kernel-dev@igalia.com,
 Lyude Paul <lyude@redhat.com>,
 =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?= <viktor_jaegerskuepper@freenet.de>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260826104143.39077-1-mwen@igalia.com>
 <20260826104143.39077-4-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260826104143.39077-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0153.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::26) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: e177870e-0beb-429c-f385-08df0394bbac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|23010399003|921020|6133799003|10067099003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qfg//v+ynQaVlMWAFnuUGPLo5u4oUHedlwW5TB/typEEDYxENDXjgyhj6a3L5hSjQPzmCxMNUnT+8ledtLLCF0vgrldkXapjvu3kZNkhtarr9Er0tQdlbGe0XYHc+nPIhXGUOM3Eqw/qh9Ao5iyHpDrnjHcvRRefOhCj0rftwYw8WKid5v4jn1ivj5DYV64TgFZOwPUuQdmKks2h/Ggq2v++zzdWPlYPXLS4k9scr4FvVvPRmM96y1SFzJfyBHPF/J0M80rBpkUqk3sANi/fYXmcF9O14NAvMFfO66fDlYXM1OHql54tRc2LFjlhTsaCLs2z7iB8Hhdvlezk2Ov+OV9WqvIKxtpWPoUp1XIsSfF9XE1dOrKuj5WD/HTPo8Bffd90fyzMUIwkJSjCSyMsjOICVsbaUg+IqhtI/DGB+fgL0l7wzvTqbTtRGqOrxwps/9mW7Mo87sP6yJ2EWZqy4DkV7n8cH0EdZCvmJPob12BCY0z/SnN3pmfKh+T1iJhHEvkyQ1EbVmn55w6Cm309q1dL9KnIIpPZQnk3fC/jH6Z16A31RCMqNr/YoIYHLR3mWTaAQIUuXy8jAUKE9QWIAdQIEjX3kwT7TJSyfrlzvWq0mdwb3Cz1isDdQ2/EibzcbfSCsutpnG5KKMAZmKj6AZSYas8pPVAhbJlcMqu2OJPtXbIllDRl0BkyJAyaLxwdbq+VchGIuEjV9onIfCp0pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTRUUUdNRDF6QmNGKzhYTDZQWDF5eUFGTU4rb3YxYXhmZEx0NVE2U25PUThR?=
 =?utf-8?B?bm5LTG9Ma3hYdzNLM0c5eWI0cWM4WGJMUDRwVlZkY3YvOEkvTFc5V0ZNSjZP?=
 =?utf-8?B?UkpjMzB1b3JjdmJuK1cwZHM4eHN0Z3JFNDJMeDBzODMxNXZrNlJiQUJndVJO?=
 =?utf-8?B?N2JOc0dOZm1NdW0zclQ5Vnl4alcvMWJYcXk2UmtvTFMwaTNNYWg1QTVmaGRG?=
 =?utf-8?B?dU9HcXB4Y2ZMaTZLcGtKM0QzdVBZMXRWQ1RnYzlJbGVFaTlLeXhzNzB0LzBO?=
 =?utf-8?B?TldRSmwwaDYxUXhoWXhBMzVKL1B3a0w0WGx2dFR5bGdRZkowRFhpenNQWEdx?=
 =?utf-8?B?b1FZa2JqeGZRbHZSU3F4cGNSdzI5UEN3cUhybTRkWWwxaXVWc3BxU21Rcm9r?=
 =?utf-8?B?YUhqZlJKSDBpSkdUT0cwbnpPL2REb0c0NXJ1MXhxNVcvN1JpazRsQWIwbXZG?=
 =?utf-8?B?Q2ZTSEdVVncvaVlFdVJhS2krWVQ5TFBOZGhHRmhidzk1N1lDaDFUVXdKcmNP?=
 =?utf-8?B?UUVwZjQ2d09CWXFvMDhvYW0vL2t5YS9ROGRxeUxwazllbmc1YU1lZzZPblNO?=
 =?utf-8?B?RmtCSmJGMlJOcmEzc2dMSGZHUmdGamRlWXJiZUhVdS9vb044Mzc2dS8xZEVp?=
 =?utf-8?B?emMyd0tMKy84TkVGZ3h0Qzc3TnBROTNaZnJ3dGdNeU4xMURHUFhBaTNMYTZO?=
 =?utf-8?B?QzNaZUtKWmlTb3ViMkE3TkFaQkpxZzFkT0pMVWhwc3FMbnBaZkR4Y3M4RElw?=
 =?utf-8?B?NDRpSzlmVGtsSUVNTEV6bCtEQktoR08wVitDN3dRRytkdkVKQ3FHOEJJMGJD?=
 =?utf-8?B?VzVWaERQZER2ajY0Z1ZVeHFBOHY3TjdDL3h2a2xzYm1YTWFVQnI1eTh6citL?=
 =?utf-8?B?Ukh1cGtsSWc2NFNPOFRSdzNiSDVOeFFTRjZwV3crczNOQ2I4ZXZmN2x6K0FU?=
 =?utf-8?B?a3NsNDkrdmZDMCtIa1hseDI5L1h1dWs1ZmtCR3F6TmgydmpWUWM3K1JFQmNv?=
 =?utf-8?B?V0tGOGlrY2NVWjFuSkFvT0svWW1USUMzUnZQSm5rN0RGQ3l1WVltOVY1ZmtV?=
 =?utf-8?B?Wi8vUlMwMHo4M0JPalVvTTQ5RHdrS0tmNGFrZFBIUkFVa2VWUUFlMy9yNnZz?=
 =?utf-8?B?M0Fub0tta2QycDk4Rm91RGNqNmJiTG56UHZzNG5wQnpYQWhwWkVLemRGSnBm?=
 =?utf-8?B?aFRxN0huUFFOVHZQRUVJdXNrQy9nTmdCbHpGR05DN3hGbGNucWRHenBtbVJs?=
 =?utf-8?B?SGNTaVJpRHB3am5BQmhmNHZYbU04V1R1ZHBVV09XSzVSVjgvUmt1T0Frekor?=
 =?utf-8?B?T2dvMkNCSExjQW85Q3BWZ3U0NWc5d1REejhxZTE4b01VRUZ2VVFCN1VPenpr?=
 =?utf-8?B?cUtSVVhvcDVGUGE4WHB6QmVib2ZSOFlvU3BEUlgxckdJNlNyVXF5TS9PWTJj?=
 =?utf-8?B?R1Q2QzNOSmdCNmpScy8wY1RxWmdCYjVTVFhYdWVzM3pCUG9OZkM5SDZTeUxz?=
 =?utf-8?B?L2tPN2tjenhiVVFqaWt1aUgxZjJ1QlFWK0JBYW90OHJJU1R2b0c1TXNZTW0w?=
 =?utf-8?B?REk0a3pCMHhzY1pvanMrNzhmYzlYdG5xRllRQ2RZWUwxSWhQZEpVejhHdmo5?=
 =?utf-8?B?TGpQQ3lQSUpSV1FSZWp0dE5JQXdLRUxWU1E5V25SMzU4NllIQk02SEtBdW54?=
 =?utf-8?B?eTNwU3hralVEZm0rNnBJS1FibUlvM1loYnpsdXl0VnJQenR1MHg3K0dFekNt?=
 =?utf-8?B?Z2NNZ2hIT0VsREs0ZDdONUZ3QWxvM2x4U29IMnlOWUptVExoQkx0Y2NRUFkx?=
 =?utf-8?B?cSttMkQ0dW4vaytCNm50YWhIUFk4TEgzVS9CNVVCbnkrM1FqWU4raUlWT0lZ?=
 =?utf-8?B?T25TMXJGOXVDQUwrTkVMT1FuVXYwMUpPdkovSVl4MzBWc2ppcmRDdzYwRzdT?=
 =?utf-8?B?Qno5VkJoUWY4ckZ5M3c4KzdCdjVzVFRQcEZSRUkzdnNGSGs1V2l4T3FEMy9m?=
 =?utf-8?B?dTUxdnJlZ2l5MFl3R0VZVUIrVDlJQVV2cU8xeGZ6NFNuTzVQT0hZM3E0bWU3?=
 =?utf-8?B?QS9SWS9nSVpvYmNmOGZOSXRzS0hGRFk0QUwrdnZKQlczOUxEVFQxUk1rSXlr?=
 =?utf-8?B?Tm5HWjF3UzFKQ1ZtRUpPOGhoc2NPZDRnRHVJMEM3cVZyaXlqbmhQS1pONGQr?=
 =?utf-8?B?WGNtQ0Vsb0tUdG93czg5WGZud05MZmxoZkY5NUlzR3JMQlB3bnhKVmRvUVRy?=
 =?utf-8?B?WVBZZEZ4TUswcWRKTVNSN0p5MDdzUWdFb08yYmtiYndpZ09rMTg2TUNNQWky?=
 =?utf-8?B?WU50eHdHdTUrUWc3K0Mveko1bDBQSE5sdXNlWFk0d0ZjT1pzVWMyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e177870e-0beb-429c-f385-08df0394bbac
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 17:09:05.1209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A68V4jF8/bLI5LmFJXPrDlxxG3lp/gja5RwZz+atl13rcjMep196srafQQ90tnAzzOpb4AlLlwh8fdR4J1aEbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

On 8/26/26 04:37, Melissa Wen wrote:
> DCE can support PREMULTI and COVERAGE blend mode depending on its
> generation, however current driver implementation either doesn't expose
> more than primary and cursor plane, or doesn't program registers for any
> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
> warning according to current DCE plane caps, create blend mode property
> with PIXEL_NONE and PREMULTI for primary planes. As long as the
> background is black and there is no overlay plane, PIXEL_NONE and
> PREMULTI are equivalent, and PREMULTI has been the mandatory/default
> mode for years, so keep it to avoid regressions.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>
> Tested-by: Dan Wheeler <daniel.wheeler@amd.com> #v3
> Reviewed-by: Alex Hung <alex.hung@amd.com> #v3
> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com> #v2
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 
> ---
> v3:
> - fix indentation (Alex H)
> v4:
> - add PREMULTI to avoid regression (reported by Viktor)
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 24 +++++++++++++------
>   1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index ab9bbe8ca333..402f0d333150 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1923,14 +1923,24 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
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
> +	 * DC_PLANE_TYPE_DCN_UNIVERSAL), the primary plane blend mode is
> +	 * ignored across DCE versions. Keep PREMULTI to avoid uAPI
> +	 * regressions: it was the default/mandatory mode for many years and,
> +	 * with no overlay plane, primary composes on top of a black
> +	 * background, where PREMULTI and PIXEL_NONE are equivalent.
>   	 */
> -	if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> -	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> -	    plane_cap && plane_cap->per_pixel_alpha &&
> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> +					  BIT(DRM_MODE_BLEND_PREMULTI);
> +
> +		drm_plane_create_blend_mode_property(plane, blend_caps);
> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> +		   plane_cap && plane_cap->per_pixel_alpha) {
>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>   					  BIT(DRM_MODE_BLEND_COVERAGE);

