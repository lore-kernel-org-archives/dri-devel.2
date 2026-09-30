Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5591CA5FCC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF8E010F42F;
	Wed, 30 Sep 2026 19:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4z6UzAP";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011050.outbound.protection.outlook.com [52.101.62.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9889610E263;
 Wed, 30 Sep 2026 19:19:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1Ue67aKRKIx+qTcvZDfwUBdff5Uq0VUuzRkLNuZCrAK9khe8UQLMKg/t0Rs3CE0D0DuiEK0gvpt6IlAS6gtWlyqp5dQnw2cIQiX8R665bfR3WSw3WVw1KdP2nGs4TTFZ7uHbRGOWi4JbsbR6ZrTzHS5mnkA6UKJZbUNnjaDGI0uuHcSE0yRaIZiXUco9GCuFt2ep8qJAIsMbFDbus7DNHtb/ZL3mBSQNKI76Za4DcRbh/YBQkhkr+wkLvRhGdkV0U5ztB5co2M6SuYVRos2jgXhEQiSYabZwn/ZIe0bBqDAfVZ31XkV1FNhBR+0Wj/7iYy/73Ay8RyqM5fIbm+S5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtdeQBjCiTLS6d6jcw+i+WUefwW2Vme5icurAQ5gnd8=;
 b=no+ilUiSjtfABBUfegDh7cCugFDVCwZ7tI9/tBBOv01Z2fNedrH0OIgoc/JFNVeLmhP2SE+81rK+HdrLx8ZHocOw4N8AAvWPUry12tbCeq8dDVTPTZjoyGobtA/OKfIXngUfQdvr4n7QzgIxxBQsMydJGKNOezeBu1wxi6jNpdwSC2IYVELHI2osO2x8bNqjUFtcfmvPOjauliZMbylx6Ch9GE4fbtKqfwdPjeGv0WtLnwpjp7x/qvw73F76EC+9NBIot0VERCzaLkP2BnzOzAGLj7Bm/VGlDvd9uW2y5ITTEM3sIjMMzu1QyDPEXMP2QBWxpaO/KW9IkrHy7k2w+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtdeQBjCiTLS6d6jcw+i+WUefwW2Vme5icurAQ5gnd8=;
 b=h4z6UzAPh8xENDRMwSG0tB2F5pAePUBwyazZi8KY7mCq4y5cz2CGTJ1yZCZTpMs8IQ+E8OzW5FHHy613gJ7dVFe6YRuCMT1OLDI+zrD+Ym7IdrGLHUHo+mozAq8K5bv2eTHa+K81RTQo7disD6vgdCZGKAYusg1XNF/q7zvyXPM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DS2PR12MB9664.namprd12.prod.outlook.com (2603:10b6:8:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:18:19 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:18:16 +0000
Message-ID: <15aaa974-9f8e-4768-81b0-0a3ff2578412@amd.com>
Date: Wed, 30 Sep 2026 15:18:08 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] drm/atomic: reject colorop update from inactive
 color pipeline
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
 <20260811171011.184964-3-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-3-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0394.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::23) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DS2PR12MB9664:EE_
X-MS-Office365-Filtering-Correlation-Id: 357ca787-b125-4cd0-6685-08df1f27946e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|366016|23010399003|10067099003|56012099006|11063799006|4143699003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NVHH11jEx/VfIA9NP/fR7BRDAon07A/Q89/9fnsLXkgyLWrQAKC+EY7z14b9h9pGOL1C4r3b4PpBXa7IilaJRymXrr+IPVj5tXtWIMCgimlKK0ZMo9lw9VK6b9wl0RWSY1P86sV4Z9upM3zqa59lFAT6PLwP955yW0RgDQVYDmixoFjhKuOeNfHCr3eO6XmvGO5jEE3M+HSvrsPLcOmKtLk1GgWJUWesEKEZjWaH+Jdu+eRq5htIkqey9eiUB+c/6TU/NGIox1eQEtJv+547CZ5K11YqzUY5idQk88cIOFyfnZtZ2fis+M8lkLvB8v3PKbaILES/XyWCdAUvhLKubD+aqEX736cBWABf73RkIrvJyTv1AXC5OPSFYJdXrOn9touvvNdjrunUaxw0gKtjRAM/bM1wZ2XyIpWwQK5G0DrOJvwoamjOjh5PI4yOvZGlebrgRYiySL36uUEB4KkKZ8hHizpDfGYww3x0hv8HZ7P36B1Z0o+K0phEuR2WCb0pkZK1ATHMNCBRDj95cQam5hiN5eT+g3GpH0nZnFANgCfenZgKALTi5cE7Aqh+4pC30k0vxe5DJ7hpI4v9tKiKq6ks5QuUgMDpOonR4S0h1Ca5n1qn+HlNpgD6SYycYpVh6M62Kxbr4/e9xjXtIpv4YE44/O6pp5vesblFzBwNKCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(921020)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWkrbUlNc2E0Z3M3alpma2tjY3pIK29qUy9SN211dWRLTDR0YzlJZFZhektT?=
 =?utf-8?B?SUZ1b1NLR3pqTWJQNmZWajhIVWhqazFvMU9kOFE3UVpydllQaFVOYWRTOExl?=
 =?utf-8?B?VG1BaWVrUStueEVleTZBSEw1SkF0QjlpaWk4NzBiMy9lMUdMdk9PMHNOaWVZ?=
 =?utf-8?B?clpEWm55eGNzNk0wRjdvZFEyRFBTRWJLcVJlOG1wdW5uNjdKWTJiNHoyRUJX?=
 =?utf-8?B?OGdOa0UwdTkvR2FJWXFHUVRCS0VyZVJQU1h6RVpTanM3MU1iV3EyQXVwcTZx?=
 =?utf-8?B?eDJrUndpMGFrMWNzVllQUDQxUjRwQU5NWGwzdkFtN21tYWxDQ0xRSkx1bW01?=
 =?utf-8?B?UDBnQjZQRVQ3SXdDY1lZd05aRkNuZXpUU1FtVWtRcVNSVStPOU9uZFpaMDhP?=
 =?utf-8?B?Z0hJYTdqaE9LL3BEcWEraGVLdGExZ0FmYng3SGZlbU1IM2VYWHBGeUUrcnAy?=
 =?utf-8?B?d2tyM0dDT3NpVmpVWlZiYVZ2djNJTVF3R2xvN1VQbStEMUJIbFd5R3ZRd1pI?=
 =?utf-8?B?SGJmYjM5WjZGWFFIS2N5bWZ0d0R0Q1NzbTE1b2llVitUUHhqVDE1ZDlINUxi?=
 =?utf-8?B?aGFmd0JnU1QvS2IyODdjb3h4QUFScHR5cThEckMvMUIvZGk4WU90NlBpVE53?=
 =?utf-8?B?WXRQK2JJZzIyeVZVQnBveElQNnpQazZpV1VoT2x5Ny9hTGx0aE15Q3dsVmsv?=
 =?utf-8?B?L1FMUyt3TVNBemlhN3NFWVJIb0YwL0xQWFdBOUc2U0Z3Z1loZHFuSjlpNWNm?=
 =?utf-8?B?amhpemdiMTUwLzltWmpYdEV6cW8yK3NKMDJic1Y3MExpa2FIamV0VkJ4aXlP?=
 =?utf-8?B?QXIzV2QyaEFkbWl4bWFCTEdYMHFvSXdRUzFwWTRvbG90a3pQOUZIV2x6cmRP?=
 =?utf-8?B?a3ZxN2xiNHJMRURRak1NWGRoY25Wa1lXaTY1Q0VEdzlNS1E4bGFDUUFKRTg2?=
 =?utf-8?B?eFN6ZDdHa2JVcURRMzBpSi8xczA3N3dTUXQwSi9QQUU1enlUMWtWSU84QjhH?=
 =?utf-8?B?cXY2M2hWM1pQOTJEUjJQZFBaajNoYVF1dWVDTzZoOW1jMENQdzlIbVJNMGx2?=
 =?utf-8?B?YjlSb0JHdllaZUtjS1Z0NGhwSWZvcG1FOWpsZ0Rxam9wc0Jsell6KzVCUklM?=
 =?utf-8?B?eThaWDRJSURFVGFLb2RyYWtIdVNzWkRGcW1RalhjVU12ZlJ2dTMwYk0rRTVh?=
 =?utf-8?B?TmlVc3BZWmM1YU52ZExkcGZqZTdnc29KdjAyUDdGaS9USlJRNWhjZml2QzFB?=
 =?utf-8?B?NURCQmduNXBxemEzLzVBRUMzcmJDaUxKaldOUW9kNFRzYWMreXRsY2dVU1Vk?=
 =?utf-8?B?VUViaGVsMUM2MjFhRHZ1YXhyZEdwWkpMM1NWd1ZTeTNSOWNTdTVoNTdxZzcr?=
 =?utf-8?B?TUFidXBQZTVpQ2NhZ2xmU2QrNWVZdFFFQlI5ZUgva2wrMFpJblQ3a1JsSUFn?=
 =?utf-8?B?K3VFMnZPeDFMbE5aeFc1ZThTdlExSlR1Ukl3QW1uV2pyN25kdS9RUEVRN09s?=
 =?utf-8?B?SXpHWFQ4MzI0MTN6Y1hOQWYzQUppREtuN1dvMHlDK3d5U1BlbWNIc0RuVTUv?=
 =?utf-8?B?WUVrc3BKSlBrdnh3ME9raDgwNjZWUHhIaExDQ3ozTVR0NVRRbnBzRnZvRmdh?=
 =?utf-8?B?azEwZUlrVFhEUTZPZnE4NjBWN252aEpRNlFtM3lPWVRhMzNFVFRPWjFPRitM?=
 =?utf-8?B?UHdHZkcwa1RrR2oxN25obGZ1TEl3R1JlYUdCMktPaXJOeU1meXRsdTVJVVhu?=
 =?utf-8?B?ZFJVL0U2d3FVeHZ1NnpkeG9TWWgxYTVTQUsrV1dCemNFWGIyMEhNZWVnZWhr?=
 =?utf-8?B?MElqYXlLUU40SmU4cnVnN3VOQVd6b1d6ZVFWVUNkTVNRLy9NZWlCeTZreHZx?=
 =?utf-8?B?aW1DaDNzV2grZkZjY3hkYlZJSE5HUFM2NGZjOEVUYmdhUFlsWWdmbjdMVzJP?=
 =?utf-8?B?eVo1Wi9sSzVuTWtuaEV2YURjYkhCNWg1eWNSU0p4VXZoSnJvaVRxNlYvRlY1?=
 =?utf-8?B?QS9Ed2VuTEM0RmpuT0xNalhtdTJON0o3NHJPWkNmU2c5SytyTFdJRGRIVmN0?=
 =?utf-8?B?OUJscTVvQmlPVjREbXJ1dEdFMCt3NU1GRWpNRUZsek52cFNicTk0cVlIZHpJ?=
 =?utf-8?B?bENLTHQ5MlZ5aEVFUHJjQkd3QjR4WHdIRnp4ZWo0R0NFUGN4RlBhajdoV213?=
 =?utf-8?B?aUJkeEk2Qm0reTJLRjU4MUllSit4bnN1Vnk3M3JWMnkwYytiUXFJdmsrSHQ3?=
 =?utf-8?B?cVN4R1grS3V3bm4reFJrQU1HTkRQWGZTRlh2TEJEdmFQMGNBUWhqS0ZidmRU?=
 =?utf-8?B?Y1JxZE54RVR4R2RMNk96TDVaSGxxNmZDZ1d4TkExRDNkNERGeEFsZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357ca787-b125-4cd0-6685-08df1f27946e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:18:16.5967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8Cgpaoc2Cs+MVQdM9y+KwWQAgU09t8YNcM6f2QiAha6e9T3x6f4uuAIO2o4kZpMG0CGsEUPWUrmaPF8xnbFig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9664
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
> A colorop can only be changed while it is part of an active color
> pipeline, or in the same commit that activates or deactivates that
> pipeline. Enforce this contract by checking that the colorop belongs to
> the color pipeline of a plane in its current, new or old state, and
> rejecting the state change otherwise. Do the check in
> drm_atomic_check_only() rather than when the colorop property is set, so
> it doesn't depend on the order userspace sets properties within a
> commit.
> 
> Link: https://lore.kernel.org/dri-devel/20260519211111.228303-1-mwen@igalia.com/
> Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Acked-by: Harry Wentland <harry.wentland@amd.com> #v3
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
> ---
> v4:
> - skip check when just duplicating state for suspend/resume persistence
> - rewrite commit message and better explain the change (John H.)
> ---
>   drivers/gpu/drm/drm_atomic.c | 76 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 76 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index f00df28e2051..86e4348cad58 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -943,6 +943,71 @@ drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
>   	return 0;
>   }
>   
> +/*
> + * drm_atomic_colorop_check - check new colorop state
> + * @new_colorop_state: new colorop state to check
> + *
> + * Ensure that the colorop in @new_colorop_state belongs to an active color
> + * pipeline, i.e. it's in the chain of colorops set to the color_pipeline
> + * property of current, old or new plane state.
> + *
> + * Userspace is allowed to finalize colorop's settings in the same commit that
> + * deactivates its pipeline, and the changes should persist for when that
> + * pipeline is reactivated later. So changes to colorop in the old plane
> + * state's pipeline are accepted even though it won't drive hardware updates.
> + *
> + * Skip this check for duplicated state, since all colorop states must persist
> + * in suspend/resume regardless of whether it belongs to an active color
> + * pipeline or not.
> + *
> + * Returns: 0 on success, -EINVAL otherwise.
> + */
> +static int drm_atomic_colorop_check(const struct drm_colorop_state *new_colorop_state)
> +{
> +	struct drm_atomic_commit *state = new_colorop_state->state;
> +	struct drm_plane *plane = new_colorop_state->colorop->plane;
> +	struct drm_plane_state *new_plane_state, *old_plane_state;
> +	struct drm_colorop *colorop;
> +
> +	if (state->duplicated)
> +		return 0;
> +
> +	/* Not a plane colorop */
> +	if (!plane)
> +		return 0;
> +
> +	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
> +
> +	/* No changes in the plane state. Check current-committed plane state */
> +	if (!new_plane_state) {
> +		drm_for_each_colorop_in_pipeline(colorop, plane->state->color_pipeline)
> +			if (colorop == new_colorop_state->colorop)
> +				return 0;
> +		return -EINVAL;
> +	}
> +
> +	if (WARN_ON(!old_plane_state))
> +		return -EINVAL;
> +
> +	/* Check if the colorop is active in the new plane state */
> +	drm_for_each_colorop_in_pipeline(colorop, new_plane_state->color_pipeline)
> +		if (colorop == new_colorop_state->colorop)
> +			return 0;
> +
> +	/* Same color pipeline as new; no point walking old. Colorop isn't active */
> +	if (new_plane_state->color_pipeline == old_plane_state->color_pipeline)
> +		return -EINVAL;
> +
> +	/* Check if the colorop was active in the old plane state */
> +	drm_for_each_colorop_in_pipeline(colorop, old_plane_state->color_pipeline)
> +		if (colorop == new_colorop_state->colorop)
> +			return 0;
> +
> +	/* Colorop is not part of an active color pipeline. */
> +	return -EINVAL;
> +}
> +
>   static void drm_atomic_colorop_print_state(struct drm_printer *p,
>   					   const struct drm_colorop_state *state)
>   {
> @@ -1748,6 +1813,8 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
>   	struct drm_plane *plane;
>   	struct drm_plane_state *old_plane_state;
>   	struct drm_plane_state *new_plane_state;
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *new_colorop_state;
>   	struct drm_crtc *crtc;
>   	struct drm_crtc_state *old_crtc_state;
>   	struct drm_crtc_state *new_crtc_state;
> @@ -1764,6 +1831,15 @@ int drm_atomic_check_only(struct drm_atomic_commit *state)
>   			requested_crtc |= drm_crtc_mask(crtc);
>   	}
>   
> +	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
> +		ret = drm_atomic_colorop_check(new_colorop_state);
> +		if (ret) {
> +			drm_dbg_atomic(dev, "[COLOROP:%d:%d] isn't in an active color pipeline.\n",
> +				       colorop->base.id, colorop->type);
> +			return ret;
> +		}
> +	}
> +
>   	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
>   		ret = drm_atomic_plane_check(old_plane_state, new_plane_state);
>   		if (ret) {

