Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67C6C5DF97
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 21:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B5A10F3BD;
	Fri, 21 Aug 2026 21:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UHQ57+GI";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010024.outbound.protection.outlook.com [52.101.46.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0D210F3B4;
 Fri, 21 Aug 2026 21:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCWfsYqmGzYsck7Yat2A1HM63ZVoVc5i3zCGvg9KCKpFi8Z2rRi+2jyeKo3GrXZi5CdxehOWuvHyK/vS9x5uCffSBA8SPYu7ygANcXHJSNa+ruwpZmdyckBfSoVEw1oSFiOX1qqntQDxTMUV/WAfdWlQYCu5Ytd0Pb1CZPE1eVPKBaK/c+yc9TcE7mgkmgisufbYuQS0I2BKyKSH5Xg+X2JF1pAhrXHbWdqCRplxoQw6I7NON5n5XT/PTXWkYitAU1Gsev7HQ5w/jgTL+gGQc1zhpG01Pw4AaS3TbNAemiboEJSkUBNDvZm2/a4EA0ipgKuAqZpZfqorXuFoNfyRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JA8Hafl6enaUzSy4tBSFK7r9I1/ebT/Zbm4MnesKvwU=;
 b=heM8Y4aUWjSige4pLPbozJzYks0vSNOuOM6+wmjXhqgnP+0PuuqRqQQpFkHuojMKkYjvSR+hdfNQUwLTBa/9nXGzmmqLaL9IJSeoGuOfU5I1draYZJMPHSNTclWpEd7/sOhhg/6ccP8SkPEzl96r+osmIIzrY2wRAKVFVvWjeQbDm5ErMzlzUcUKKst6bByQvYV4q/f5NNoyA6rGrORryvqC71PW5+v4A3UM4LjXwT+az1XCsdwl7yy2eN0GAQ5Kw/lGjPfauo0p82PvKyNq8KIHemKLN/D+FFDg2z3JnRI6irP3f5PVrF6dksRl6zBx0KLNW0aJIZHII9mGdw5bEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JA8Hafl6enaUzSy4tBSFK7r9I1/ebT/Zbm4MnesKvwU=;
 b=UHQ57+GIHgdHV5tePgGeZ95B8668csqDZwWoDDW7Hn4dhEWw/Lm5ANBLCPfWBSLqAYmkpfsJ6qD1Paqzn0/fQZKWztvEILYmd4p/UdKJ78SorOzhin5fVYpTqMl0a3VRExa8dHgLpvttcUxw2LALaLoBcs3wu2Hl4LKOnPf751U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 21:48:17 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 21:48:17 +0000
Message-ID: <d5d8b8c6-ac79-4211-bf19-a1411d98afd7@amd.com>
Date: Fri, 21 Aug 2026 15:48:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd/display: advertise PIXEL_NONE as blend
 mode for DCE generations
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
 <20260813143605.106104-4-mwen@igalia.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260813143605.106104-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0173.namprd04.prod.outlook.com
 (2603:10b6:303:85::28) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH3PR12MB8970:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e4f712-ce77-45e4-2e9b-08deffcde8ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info: LaV/esPW273Ca8PHYrQkyd14swV6Y4EeT2N/guxbhgNUVHNsMCzQjS7m2N3uY9bMUHpjgVY2HlR+TN7BF5SHw9AhskWgews/PcH/NYEH9pNg//BMSY5beVULuGUYdoXf1L4IycfBWDUTdeNxAZoa0ApEdh5lNZHazDA3T+j+MXBWB8B7d4qQ15YutNAxA3/lFkAnbTLLf1WkAGuFrq6lCwRpf4i8Jh4zik8nrnMjK5Ml2N7vnz8fPO3tiGeu46T/qB2/osArS8vY9ttP3tSHfATMtm1/7HpcWFy48jtKcIlTtljt/ocRHPYv2UcZv0uyhN9rtXXx/lHAHd1VO1Y8q0kI4dDvArWFKmFDzdnEZXxFZqphhv6lBkm5uSyzyUQHxH3L05ZOJxYTyYi2MMvFaPk/Jj+4zCYpTRN8qZ5aYXwdKL89ZLFih1Lpt6QtUJoU8NzGuH3y041J0Vwz3TDPUGtSuYSVv/j4rBroaAgO9uTaKC/uj7/EVm5znd41yNVHtK6CtBi1r7yfwOyjGIONaxFKsXb7DDO1mcuiik0Yo5oPnnqQXExkj3D/1aTKndZ9G6nCEFHNRA1q130/uI3uyS9xdgRDWMONfzbnGPc5bT3pA8cc+bUYcpev5RaGxGThsrPRI1FdBVP/j5ZAeKcC/vIyGybt2uBgmTCr+5ZOql11N1iqnpWIkTqBd+imFmTHqoquFLxClHMkywXR6R9Elg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1YeXJRMWtyTytTZUpFbnpVczBFVnEwc1JjUXpYU3JKRWxkVVhaWHoxZ0ty?=
 =?utf-8?B?VjVqeUlkWkdvZ2xVKzFpSlA1RlFZUTlDbUhQTCtBV3pBcmV3dHVJLzZ6VUR2?=
 =?utf-8?B?ODVmcEFQaFYzNFNwdUFIYUJ3UTRScmpGclYrSVI5ektRdmMzUDg2VTFLOC9i?=
 =?utf-8?B?cE1GRW9ESWtSSFVHL1Z1Qng1MXl1Yk1JVXA4Y2FKd3EwUDRsUk9SeFFCVGs5?=
 =?utf-8?B?N0ZlOUVzdjA5bmpyTnhSakFIYWVxNXFzRlFmdDFJTnYxck15VURGRWVtVEVQ?=
 =?utf-8?B?ckZvcTRKTkVQM2pkYXZGdjVOVXQrSmtpcDhtWE10NXZkRWUweUpyMHRpcEpJ?=
 =?utf-8?B?ajBWQ2tUcVNNbGtoQUhLWHdYaEVxQUxtMlVWNmpQaDNNd1I2dFloR1p0RTBm?=
 =?utf-8?B?eFZWOUN0NUNVRkNmM2dtK2I3VWVlQy8rWmxBUGhkUmUrMUV4VWM2RGxBeGph?=
 =?utf-8?B?NkJ0N3hwUG5EUlZwZHBEalVTRk8vdWtBKzFEd2ZpdHQzdjJEM3c3bTBLRkti?=
 =?utf-8?B?ajV6QityWVlRSzVUN3EzMjU4NzFOYVJ4QlVFK1ltU1hSbWxHZGVYRDNTMXpZ?=
 =?utf-8?B?ZUQ5My91b1FQeDlPNzBpWERLaTQ0WHQ5N1dFQVNPOTZNVGlMb0lrcGpMbU9a?=
 =?utf-8?B?UTAxMXM0ektVU0ZYMVpKZFV0UGpqalF6NU9QVDIwVVdCcTlRdkE1RDF5WTQ3?=
 =?utf-8?B?WDRvcmd2Yi9YNXBwTDdUdzc2cmc3KytnbjByRTJGd245bU1aR0E2c1lIQkNj?=
 =?utf-8?B?dlE0eEhmRlVoUkJZZWt6UkpUb3pla0pwZzMzdllWSnlCVmk1Ylc0Qkl2WUhL?=
 =?utf-8?B?dE9ob1cwQ1RKeVp6SUx2dGRrcHloRE5yVU5ibUNuT2VGZS83YnZVcEczWlVV?=
 =?utf-8?B?WVV1ZGg4NHVteFl1YXdYUEJnQldrQXdRbmdpYTlBcGcxeGpjb3VySm5tc1FR?=
 =?utf-8?B?aXRrekdWNUV3QytsNVZCUU9JRGxINzc1MTlUTjg1cTFlcFBwRUZpNXBzUGZ5?=
 =?utf-8?B?MEprL0tuc1dnQ0dGbTk1UGlsQnlrMVdvWW9xSTFOeThwdS9UY2l1c204L3VD?=
 =?utf-8?B?bGNRaWdRRUpvL2lWQ3I5RWVmUjZkdmttUGkvV1NFTk43dlArN2I2bkVPS0pS?=
 =?utf-8?B?V1QrZDhQRkhJREYwRWJOQ3hISG1lV0hrdUFMVEk1S1FvWTlaWUNteHZhaEdV?=
 =?utf-8?B?NzIrNUd6Q1BMMEZqVHgxSGJrZTNhMWxCeUp5Ykk0NUVEY3ZwbmtQVCthNVpQ?=
 =?utf-8?B?NUVUeG4rOTlnQTU0cVlpMU4ybkIxMDFtNzBDZkVBbXRFUExuTUJWSUFQZDZL?=
 =?utf-8?B?elIybmJxSjdPVG4xTVdZZlhMaGdyczhsMkNTQ1dRWEtBVVY3YzVIT2prUm1P?=
 =?utf-8?B?TEdQWExpeUh4WDNrNEpva25iYWo5dkN6dWljdUxCNU9rVXNHU0JPQkh0ZGRT?=
 =?utf-8?B?c2M2OCtWYUZVZnU0T3NVbFN1cGJqRW1OZTBEOThNYzkyclhJNGtKUE9IZU9I?=
 =?utf-8?B?eGtuYnpHWG5vY2UyWHdaTmc0Zm5SMDB0WndWOFJhQ3BlRm02V0ZIcXRmTTVn?=
 =?utf-8?B?VGhpRHNMb0lTODFBSWhKYTNtdzFidC80RmNrVlY2S3MyWTk0emwvb25rNHNo?=
 =?utf-8?B?RzZmN2lXY2VYaEIvVk11aUhwU1VuLzFoZjE3cmFpTDZSZ2dmK1JJSzE0b1Vj?=
 =?utf-8?B?ZklMaW5WMjN3cnI4Q2FjTWYrdDFrcDA5QVk5bi9TaHZuOWZ4Y0UwQjgrWWl0?=
 =?utf-8?B?V3k3Yzl2TzhBQzRLVFZoT1UzV2lZM25adjNnZjl1UitLc3J2Y0hiY2JOaGFB?=
 =?utf-8?B?cjh6OThZcGk2T08reUJLRjliVDRxYzU0NWlMNGVyWitueWRLL2lqVFg1bU1w?=
 =?utf-8?B?NDVLb1dSY0FnbEF1SDBmUjY1REVRbklvQXZrbW81KzJCSlh6My9XY1BOWG1D?=
 =?utf-8?B?dTVxU2hSVEJCQXptdGlheHBySHBXSjN5WnNNV3B6YmFEK1Ywakk4SWlGWWhn?=
 =?utf-8?B?ZnBxa1VUSHFDUnNjL0J1Q0dPdXRUc2dqN1VPTCtsVzU2ZnRFMDFJRVJmdmVz?=
 =?utf-8?B?NVBWZmZtd2M3T0tEb1Byb3lEeWZzZWs2ZERqSUF5bEI2YWJMNmZoYXNZdlR6?=
 =?utf-8?B?aXcvc082SE8zeVFsM3FrNWFCSEtva0RyaFdMMmR6Z1drWmpzQnNUanVuSEhJ?=
 =?utf-8?B?UGpkMFpLNndRSGhGZFY0bkpHYnIzMG8xZXROeEhLeEg0UXp4ZEFlT3FQdnBs?=
 =?utf-8?B?WndybEhxUENJNGlieEpaMjNLYWJPbEc2bzJiQnBjMHc0SWRlOEJlQ1hIbTlI?=
 =?utf-8?B?VUNwcVEyenEvN25RM3VEbDBSWFNFdkdheWxvNGFsZkZpeTRhL2R0UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e4f712-ce77-45e4-2e9b-08deffcde8ec
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 21:48:17.6103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uspGYu14gPIkk+7LDSUPhDK8rqKF8P01CTUAJbBqdrKy3fr6Osv4Dg1EqkwEWSchT5QkL88JcDPmdJNaPuTqBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

On 8/13/26 08:30, Melissa Wen wrote:
> DCE can support PREMULTI and COVERAGE blend mode depending on its
> generation, however current driver implementation either doesn't expose
> more than primary and cursor plane, or doesn't program registers for any
> blend mode other than PIXEL_NONE. To fix the missing-blend-mode-prop
> warning according to current DCE plane caps, create blend mode property
> with PIXEL_NONE only for primary planes, instead of the DRM default
> PREMULTI.
> 
> Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
> Reviewed-by: Leandro Ribeiro <leandro.ribeiro@collabora.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 
> ---
> v3:
> - fix indentation (Alex H)
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index ab9bbe8ca333..3b5b6943b67d 100644
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
> -	     plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> -	    plane_cap && plane_cap->per_pixel_alpha &&
> -	    plane_cap->type == DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +	if (plane_cap && plane_cap->type != DC_PLANE_TYPE_DCN_UNIVERSAL) {
> +		drm_plane_create_blend_mode_property(plane, BIT(DRM_MODE_BLEND_PIXEL_NONE));
> +	} else if ((plane->type == DRM_PLANE_TYPE_OVERLAY ||
> +		    plane->type == DRM_PLANE_TYPE_PRIMARY) &&
> +		   plane_cap && plane_cap->per_pixel_alpha) {
>   		unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
>   					  BIT(DRM_MODE_BLEND_PREMULTI) |
>   					  BIT(DRM_MODE_BLEND_COVERAGE);

