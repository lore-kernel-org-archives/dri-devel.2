Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5D6CA5FC1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0E6810F49A;
	Wed, 30 Sep 2026 19:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qORdFvoB";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C55710E227;
 Wed, 30 Sep 2026 19:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UbRHTWZr3WQsoST+KpBV6dp0CBvv2jaSXt2pDZzeGYQ+C/58T6Fq/k8nmEKcluLrS/gxo0BuFgsTyn3EL49yvfaYYnoJby/mjHDihmTDTVQXJLCTqGIMExK9804o/i2IPwHIjt3VaLptUwd9pSVou2R7mvaFPg5k79deFpCRTvZw3cmyNuU9Bw9fNTG50+WrCRabvGL5ke66wx8oekBjpuBX+BHPmdav1MtSxWrN51OqgYFgS20+jW6xSTtQBQhHdOujjN2nuv8+Un0tXCzXKr0VSXnjDi4zmnAey5w7zB7I3bvo5aiS6YeIDee755eTr0eK9zy3Ro/JtE+u+mx3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4Q12rYw6kFlLScgs/r6BJDc8qX2EPxe0l+KHVNlank=;
 b=atmA4siCpMoNGSzROggDHbNZjLRt1/FRkNE6jaWp+VYkOsyHnv6bPdBdDBePOu+7COHCwWmYP2TLQAliX587jxXzJd20dArRtGDvwhOkmtIXHvfucI157+BQEd7ZSMATcTD+z35g4hG/U6MIADUTa6Yg8SPqcO2aYBcPS1XGffXVK55yC35hCbiLNRKFFlPnyFrY70u18dle59h6IWX2DTS5zxeLdtw/yXh1lv1XpcTnDQtderhIjjtOhWl3VW9rVlQoymx0fvm7RDNvmvaunhX+I6PR8ZFkbrO7Pyh1bLxirhneljcYG4+HtPEYf24icq+qCAPbEs8CMiHD2zWDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4Q12rYw6kFlLScgs/r6BJDc8qX2EPxe0l+KHVNlank=;
 b=qORdFvoB/sq3G8Uf5ZuldwsXAh10ijtgwJUuQ06QShgpLYL6HP6zhuOXKngGwJNGtLuG808mRzdtprKVR2DRR7sYTdnzRpWe0cCofxlp+noEQrqLCaMCVKvmCUBza9AZf8uencpVHwgi3TWvzW6jIvCkQWd9TH9dTB+OyAxYoyg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CH1PR12MB9646.namprd12.prod.outlook.com (2603:10b6:610:2af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 19:32:47 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:32:47 +0000
Message-ID: <858df042-b00b-47cc-98a6-33055c023a0b@amd.com>
Date: Wed, 30 Sep 2026 15:32:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] drm/amd/display: only check colorops of an
 active color pipeline
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
 <20260811171011.184964-6-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-6-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0405.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::18) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d51428-bf11-4d6d-9c5f-08df1f299b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|23010399003|56012099006|4143699003|10067099003|11063799006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info: ukZrULHcUW2XQc/NjqGtbdcWd2i4VrDIPVvvbdFpnAYGBilGpPukcOLUzGaQx3uVV2I8tu6FDB7FZk966ak+RCYDjuWLUrObwER4El9QKL98K9YT3n4RuLmIMhMS0gxP8GcT01gAk8zSK7SunqSMst0NMsCdn0VypWs3JGLZrN9bgzHqL+JmEnTv6VO20HvTFvXHO76t2Q1EMLafB61+5pOEhfDW3irbRdZRrbmK6jjj6oeIWJtqTD0pqDd6/ThogZ5FTlY9NGbKU4r1ckJoMABTWwlAr0ZONloeAN+c4/NGAdFCTRKKP6a0+Nw4bWjjhZ8M8awqAmUB01hhJgrL6Az6kKwxJhxmHcwF+9zlRF0CyJOaW5i8+hOnB0urKB5obsE1bBrgXiiZB1jds35brsgXow2yRgfmKAevdMJIRt+W6gJjwWXx0hQpz20/296TPj06/UpfeLh3uzUXA3qtLODzBb/CCO3miwpwmYFOrQNP4BFxick3WNGZ+S48TT+2IKQHtwWqR5ei9w4qs/UPq1gButeVousw+2EtwyFT8Krmk1Fa+T7pN5kutrdHR019jz84S7++V0CpvAbkabuOxPJpVImxZEAxtUuEtLBryEMTzhotVKnrJgSt9IrE31TFLt4VAcwtQNigJHxXnJjkcqjwf2ORS8kJ6kwbocriInsFb3nBEaWYp2WLe/CHC6E6yd1arDfEmZp7W5qgn2dodQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(56012099006)(4143699003)(10067099003)(11063799006)(22082099003)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVhUaDRRRlFkenFUcnpsb0JsaEgvRlllVTZod1NvTzlzaGZNVGM3OHM1M3Nk?=
 =?utf-8?B?RmE4cnJ6enZEbjZJWk9wKzZ6WCs3UEI4YmNOalFCamorMGtQR1YrRzd3RjBN?=
 =?utf-8?B?bWZrWG0rQlhRR2lVak9xTVNiYkhHZHVBLzcxNURaZGRlVDJJMnU2dHFDWCtp?=
 =?utf-8?B?RjdnaFYyMUZOdklMelk4aE9YYmpqUUhRcmNtaVJmNnVQZFRNK2ordWV5ek55?=
 =?utf-8?B?bFJxNXRoalZrRWI3bGx0TjNhNEZBbjJobXlzaVd3TkFXUVFsYlNVdmZEeUFD?=
 =?utf-8?B?eksvT1ZKbGU4cXpLYS9IQ254cG9QcWVXNDd2SWZickhKRTJmb3lRRU5SeDRE?=
 =?utf-8?B?WDdjTDVWQzhUNkpvUVd3TEZjcjVjVld4V1owZzVNRGt4WGx4QVFIUkVGUWlz?=
 =?utf-8?B?YVpMMXZPUmFhaU5VVkcxWXV2WmNCQ3hUTDdpVjJScFhESVRLVW43LzEvcEVR?=
 =?utf-8?B?cGhqSlJWUUhuMFltUjBxeURONEFTME9DWHh2cWVvU240bHlHbno2NzlXdlZT?=
 =?utf-8?B?M1ZwWThXckg0eklxbGhjQ0IzT0Qvb1pwZVhHNm55U2RXbjdaZzExcGUwbnhX?=
 =?utf-8?B?QjFwdnFRZ29Wa1NZR1l4cENZTUQzTG9JZENnclFlWFYyRWtNNkYvZUxCbHI3?=
 =?utf-8?B?b1Rmd01Ld09hOFI0ZGtLcEs0Z3dmdnplUHJMQlowY0NNRkN4REoyWEErWk1P?=
 =?utf-8?B?cEVmbHMvb1lWUStMRUhBZE4rak5VMzlwN2tyazR2TnFnZHI3TkVoeFhhM0V6?=
 =?utf-8?B?MmwwRUc2UkMvbnI1blRzTmxVeGNDWXZUQ1dEM2Y2d0NvaGFaeFlGcHpDc2Q2?=
 =?utf-8?B?aTBzN0t5MGdKTGdsRXRVdklnZi9BalcraHlKU1BEQzUyNktIVzEvTlRCaGdQ?=
 =?utf-8?B?ZnJQVzF0MWdYZmNEak9qWk9IZzVFNWtwYm9mQXRKSG9mbk1yNTJodDFBd2Nk?=
 =?utf-8?B?M2hubjV2aGRLY0UrVjdaQ1ZsTWN0ZFZWbzdlYUtIcjYrVS9rdGhMUXB1bzRq?=
 =?utf-8?B?Q01Ndjk1Nk13M3M4YUovMVdHWDcxbGhGNDNSRUR6WGY4dmlRTzRGc0FwOUdV?=
 =?utf-8?B?QWljanNxakNTVHBrNnRKSGsrZW1KTGllRitpc0hyNGJtTTNNNGpXK0xvVkdJ?=
 =?utf-8?B?YTZnRHJ3QkI4UEdGMEphOUpnZkhTZ2hVWGNJZ2x6T21sdE5KaUtRSDNHSUha?=
 =?utf-8?B?RFVNRlZjdzE4R3JKZVhkUElkVHVPZ0tUTWgyallOcG5lTVA1N0p4eW1aVjBr?=
 =?utf-8?B?Zmp4WDA4OHRPVVp2VnFFKzRzODB5N0c4UHVFVE5Nd1MzbzVpRTM1WFVjL2F3?=
 =?utf-8?B?R09lWUlWcmRHTEpraytaa3VqTXkxOEVFcE1CSEY3RzJCOEU2MFNFUmxvWVQ5?=
 =?utf-8?B?eHhCWDhLcWppazZLcHkyMkhuOFFzRWJoVi9ndW9JTnBkaFBqNXVmMHNaSVli?=
 =?utf-8?B?djBTV1REN1daM1N2aUhRWGN2aE1IUlBCWDc2UThIc1lMZE9qMWQ4bWVsM3JR?=
 =?utf-8?B?bUd2WFQrWVZna3Vjc1FBQVJ6YlM2TFYvcGF5S2RZREg1T1VqM1p0Q0ptKzNK?=
 =?utf-8?B?bnNvT2htK29BeXpzS1gwelFPQ0dqM2JDSnhOL0xwT1IraXJiNDVDY1NwbzY3?=
 =?utf-8?B?MHRQa0VYZTJyajlOSE02UnNrRzNxNnBDRy9aVGs4SFY1cFJHcHFWUWp3anFC?=
 =?utf-8?B?WjRIQ0Mzbmk2SGpvR1lkOGlqOG5rYmhYd3hLakd2ZmRNbWRnOFhpYTNVb1Rw?=
 =?utf-8?B?Z3hhbENOQWs4dnlKS3oySUk1aVRLWUtQbkxIQTV4RUxlSmIwYWJBZXpMRVNo?=
 =?utf-8?B?YThYSTRTYTJzSnJLMzg1aEFsWi9wUVMvVGRMUUlUNkRGQjl2ZTRvQ3dhWEVw?=
 =?utf-8?B?REE2NHppZ3NZTEYyOHVaRHplUWtJekpkWFN2NTAyRUs0U21VcFBhaFpOMmQy?=
 =?utf-8?B?WEJKajVtdWIwVWNrNnpEQXNTbmxqSUcxcWVCNXkyYk5WMHZUbjNRVGljUlVQ?=
 =?utf-8?B?VVk4KzBucVZEcTlWNHREdGZkL0ZJakhSV0gvalVFSVVhOURSd2xvaDZEQjR6?=
 =?utf-8?B?VkRHMTNzREV5a1NObnRPMk9XQjY2OEZzMEdxYzhoUiswNmNGR0VWeEhuRzN3?=
 =?utf-8?B?WDRKSk5ac2dvaEl4RmNhUlZLRDNKMllBcnVGaEI0OElpQllOdE50UStkOGhy?=
 =?utf-8?B?VnNxWHhUUE00U013ZzJFbXdZbUw5VTJoLzVpcUE4OG5idHV5VzVmdVJwcEtV?=
 =?utf-8?B?aXVGN05oMW8zZ3pnRTFpVlBIekFiK3RFaExhQkJhVzdia21QZHY3KzAwRXZE?=
 =?utf-8?B?UFFHVHVEbjI5UG5sU0dnZzRVRkc0OHFGcFRoc2NtVUZtV3orSUtGdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d51428-bf11-4d6d-9c5f-08df1f299b70
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:32:47.3702 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0pkhraNczNXnY7+zZdwiqRcAIVcgkQ9ETQUfmkb9ycDjnHsjbJm61rB9TFwAwAAATnNuhGxKAkLOh8vhvA6gA==
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
> dm_plane_color_pipeline_active() iterates every colorop state in the
> atomic commit, so colorops of a pipeline that userspace deactivated via
> plane COLOR_PIPELINE are still taken into account, even though their
> BYPASS property is irrelevant once the pipeline is off. Walk the color
> pipeline of the plane state under evaluation instead, falling back to
> the committed colorop state when a colorop isn't in the atomic commit.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Fixes: d3a549f4df78 ("drm/amd/display: Use overlay cursor when color pipeline is active")
> Acked-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> 

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
> 
> v4:
> - drop the ternary and add just a warn_on since both current callers
>    iterate planes already in the atomic state. (John H.)
> - explain the reason to use commited colorop (John H.)
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++++-----
>   1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d0e612371c8f..384541b9ac9c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6551,9 +6551,9 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state, struct dr
>    * @use_old: if true, inspect the old colorop states; otherwise the new ones
>    *
>    * A color pipeline may be selected (color_pipeline != NULL) but still is
> - * inactive if every colorop in the chain is bypassed.  Only return
> - * true when at least one colorop has bypass == false, meaning the cursor
> - * would be subjected to the transformation in native mode.
> + * inactive if every colorop in the chain is bypassed. Only return true when at
> + * least one colorop has bypass == false, meaning the cursor would be subjected
> + * to the transformation in native mode.
>    *
>    * Return: true if the pipeline modifies pixels, false otherwise.
>    */
> @@ -6561,18 +6561,33 @@ static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *state,
>   					   struct drm_plane *plane,
>   					   bool use_old)
>   {
> +	struct drm_plane_state *plane_state = use_old ?
> +					      drm_atomic_get_old_plane_state(state, plane) :
> +					      drm_atomic_get_new_plane_state(state, plane);
>   	struct drm_colorop *colorop;
> -	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
> -	int i;
> +	struct drm_colorop_state *cstate;
>   
> -	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_colorop_state, i) {
> -		struct drm_colorop_state *cstate = use_old ? old_colorop_state : new_colorop_state;
> +	if (drm_WARN_ON(plane->dev, !plane_state))
> +		return false;
>   
> -		if (cstate->colorop->plane != plane)
> -			continue;
> +	/*
> +	 * A commit may change only some colorops of a pipeline, and only those
> +	 * have old and new states here. Telling whether the pipeline modifies
> +	 * pixels requires every colorop of the selected pipeline, so fall back
> +	 * to the committed state of the untouched ones; it's both their old
> +	 * and new state.
> +	 */
> +	drm_for_each_colorop_in_pipeline(colorop, plane_state->color_pipeline) {
> +		cstate = use_old ?
> +			 drm_atomic_get_old_colorop_state(state, colorop) :
> +			 drm_atomic_get_new_colorop_state(state, colorop);
> +
> +		if (!cstate)
> +			cstate = colorop->state;
>   		if (!cstate->bypass)
>   			return true;
>   	}
> +
>   	return false;
>   }
>   

