Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8EAC79F9F
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B043910E2CB;
	Thu, 10 Sep 2026 16:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1BLyx+MR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D47F10E2B7;
 Thu, 10 Sep 2026 16:32:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkLBoPNs7omjJr/K7JCd0AK/23GFyeny1Rj0+wkWIvpceKy7CAYOjLMO8V1lg+FQVp1m36Yu6jm7RSZlj/DqybK3PxQNbjPrEk77tLOyc8szrljFEmtBPTiA3uxhhUhrxDhAXyZ+ODXulaHul3uQCSAdByHqODhHf48ikUbJKRDv+EcZTdrdkmQu43b88B5NJafdbwL6AUAi6fJD/9TyJCVpiLvakG3bLpEnAEqOFuybwEDnSUVEFx9Lat9NSViCOlG3gn5kN12rUqlHf7+XOWk88J2UdBdP5wxKL75M5V4xm34uBm/1i1RdhmDsIC5giEWP9F76h6kvYaGiY/0abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HAl4YIHYeSNg7S+vNu0F7P4VzzhesClEgVKCCVLT4wk=;
 b=H8V5Y8mpWnZhoQGGwn2zOohkeHLQ6jMiQbMbJnKsNQy5GEasKcAnzZu8FG0cDcHsAWl+Gw3zzjVr3D0sCRVBAs9QyRumYMhePUIxYQUJgJq2HHdcWF2mRWKT/dkdttLy93emOeAfwS4nw8KQ3zUW2kIBo37ItXb0lgJvzVmTf73ZEVtKlGjkT2VKvjYUpN5lnQNuNxIRmjr3PcutUUUdIP57h2STH3DTu2E1JsAQyEXcc7wHprM8aLvNCdJcO/XLq5hnZqNJgUBgpd0FB9B8EwQiSgT6ajV5wAc/WdN5ITcShOKmylGt0DErPX1O55A2ZVZrPU5bPAMk92mVCd3eHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HAl4YIHYeSNg7S+vNu0F7P4VzzhesClEgVKCCVLT4wk=;
 b=1BLyx+MRe0NSfynC+10IZI48zo5hnWnXnAhWwT9RVWctG6WKR79/J+d/YxFuE/Njnsxg0m92SAWV3DTKwZ2/+tf0YwMB95OGMnLcMXO5oESR8TwGNd+0M1dH7AFfCbbEduO7YY01KPBpfSYMWa2gRsf9t9nZp76QeTBEC0BLdAs=
Received: from CH2PR18CA0041.namprd18.prod.outlook.com (2603:10b6:610:55::21)
 by CY5PR12MB6455.namprd12.prod.outlook.com (2603:10b6:930:35::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 16:31:59 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::8a) by CH2PR18CA0041.outlook.office365.com
 (2603:10b6:610:55::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 16:31:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 16:31:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 11:31:58 -0500
Received: from [10.254.92.142] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 11:31:58 -0500
Message-ID: <80397669-ae75-43ce-a072-f94de5720ddf@amd.com>
Date: Thu, 10 Sep 2026 12:31:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 26/41] drm/amdgpu_dm: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <harry.wentland@amd.com>, <siqueira@igalia.com>
References: <20260908-drm-no-more-plane-reset-v4-0-a31b3fcfc989@kernel.org>
 <20260908-drm-no-more-plane-reset-v4-26-a31b3fcfc989@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260908-drm-no-more-plane-reset-v4-26-a31b3fcfc989@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CY5PR12MB6455:EE_
X-MS-Office365-Filtering-Correlation-Id: f839f02c-4ac6-4ce3-f349-08df0f59094f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|42112799006|376014|1800799024|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: o7lvpKBsIRgJGxUO23VjXk8wHjqpauDL+sxb9bUSdYjz8vm4vWrC50hvYl7+vMx0oHTy6B0RDRQ9QcttjzEMBoCqV+2pCypdofpBGElIFo23suhurW6hsqK1EQOMIGv6yOTwylkgb2qLd4ZlNZ6lJBRZUWQ1lxbupXd2wdQrviMI3YTeSqoRMehsrqyQjXyrKrIPWHeGsek/THNO6+ZxZK7CKCpmbYKW9VL2sO3sPzDupbc3Q6b6+ZZ0hY65p8BMdlpTrFkAv0JsI7f5OedeLwBeuJg5UXMBgVQU7KAPHcCbpNtX+wQzIFPPMtg0r+Ml4QB+B+mawPJKx/u0ylqkRa02JWXcdkp4Dv8GNyHZYCwevsxX0aiL2Z0XaBnChveWcD6sCAoZlgQllYnZ+xogNZMBpQMDtUi5IhbGH+Fb//j7zm6YiNUpUk5TIHHpPfneI4+xdIMmVMKXyD+kCa1YlBBDizXx758LV/H3o2vUEJFg6CRWfJP/Wu1EJfupfcssI6Q/34s54orEhi3mKDUIjt2NJ1DU0En5+pCdTt7pasLoYuYSn6IQm8hZOlLbSc9KbMy5U/MLy10ECorzVCLEmGgm51ltlBik9ZoFWdVfJ5lFaK6xNdEqvB8d/T8DH1Nacfy15Q5kzVBBN/lD7+W6WilF+s8Two4OYwsGwOBgY9HzUIjpO3uXDiKCJwXrMosrK1pDmWP/P1N4xLZMNSC2DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(42112799006)(376014)(1800799024)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6QV8OvmFKb2FF7wQF6tRpTalWHyVKhWJXFfXw8jdb3oNY3Y9yxieiYk86QHQNV85i5h3PSymRpmRfA42Jt1PLBsglFsLFEUBqNVLUzuuFq3YkueQoCI5KoYTvjwAA2THGpcbx3sZ0z3D1RGY4qwpADS4tQgGsm1YkmJTbLjLHTTCtFFW7ux8aT8uh7i6vemYzZ+vJNxeSy4g/yUwkxNuHiuJqWcwV2I7Qdec+OWOSNN8+J1JX071Mas9IjTkAWnpU3dvYl+r06lJUJimReX+msU99+KYzs4DHa/Mk+29QgkKjII7J8W6l/qU1KdN96NmWuWiYa6ThW9jx6tdIbL3/cV+1WC7VsyPipt9GOYykXmBD07vmk5iIwdMEhiajIAELjxDSa1RCsmEQOCnfhMcPHz2te1FUDglaMtoPLh3nm4+hGKKqbwoiON1xCxayCrx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:31:59.2059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f839f02c-4ac6-4ce3-f349-08df0f59094f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6455
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



On 2026-09-08 10:46, Maxime Ripard wrote:
> The plane reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> The conversion was done using the following Coccinelle semantic patch:
> 
> @@
> identifier funcs;
> symbol drm_atomic_helper_plane_reset;
> symbol drm_atomic_helper_plane_create_state;
> @@
> 
> struct drm_plane_funcs funcs = {
>   ...,
> - .reset = drm_atomic_helper_plane_reset,
> + .atomic_create_state = drm_atomic_helper_plane_create_state,
>   ...,
> };
> 
> @match_struct_reset@
> identifier funcs, reset_func;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
>     .reset = reset_func,
>     ...,
> };
> 
> @reset_uses_helpers depends on match_struct_reset@
> identifier match_struct_reset.reset_func;
> @@
> 
>  void reset_func(...)
>  {
>  	<+...
> (
>  	__drm_atomic_helper_plane_reset(...);
> |
> 	__drm_gem_reset_shadow_plane(...);
> )
>  	...+>
>  }
> 
> @match_struct_destroy@
> identifier funcs, destroy_func;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
>     .atomic_destroy_state = destroy_func,
>     ...,
> };
> 
> @script:python renamed_func@
> old_name << match_struct_reset.reset_func;
> new_name;
> @@
> if old_name.endswith("_reset"):
>     coccinelle.new_name = old_name.replace("_reset", "_create_state")
> else:
>     coccinelle.new_name = old_name
> 
> @update_struct depends on match_struct_reset && reset_uses_helpers@
> identifier match_struct_reset.funcs, match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> @@
> struct drm_plane_funcs funcs = {
>     ...,
> -   .reset = reset_func,
> +   .atomic_create_state = new_name,
>     ...,
> };
> 
> @drop_destroy depends on update_struct && match_struct_destroy@
> identifier match_struct_reset.reset_func;
> identifier match_struct_destroy.destroy_func;
> identifier container_func;
> identifier P;
> symbol drm_atomic_helper_plane_destroy_state;
> symbol __drm_atomic_helper_plane_destroy_state;
> @@
> 
>  void reset_func(struct drm_plane *P)
>  {
>  	...
> (
> -	if (P->state) {
> - 		<+...
> (
> -		drm_atomic_helper_plane_destroy_state(P, P->state);
> |
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> |
> -		P->funcs->atomic_destroy_state(P, P->state);
> |
> -		destroy_func(P, P->state);
> )
> - 		...+>
> - 	}
> |
> -	drm_WARN_ON_ONCE(P->dev, P->state);
> |
> -	WARN_ON(P->state);
> )
>  	...
> (
> -	kfree(P->state);
> |
> -	kfree(container_func(P->state));
> |
>  	// kfree is optional
> )
> (
> -	P->state = NULL;
> |
>  	// plane->state clearing is optional
> )
>  	...
>  }
> 
> @drop_destroy_mtk depends on update_struct@
> identifier P;
> symbol __drm_atomic_helper_plane_destroy_state;
> symbol to_mtk_plane_state;
> @@
> 
>  void mtk_plane_reset(struct drm_plane *P)
>  {
>  	...
> -	if (P->state) {
> -		__drm_atomic_helper_plane_destroy_state(P->state);
> -		...
> -	} else {
>  		...
> -	}
>  	...
>  }
> 
> @transform_nv50_wndw depends on update_struct@
> identifier S;
> @@
> 
>  void nv50_wndw_reset(...)
>  {
>  	...
> -	if (WARN_ON(!(S = kzalloc_obj(*S))))
> +	S = kzalloc_obj(*S);
> +	if (WARN_ON(!S))
>  		return;
>  	...
>  }
> 
> @transform_kzalloc depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier P, S;
> statement ST;
> statement list STL;
> @@
> 
>  void reset_func(struct drm_plane *P)
>  {
>  	<...
>  	S = kzalloc_obj(*S);
> (
> -	if (S)
> -	{
> -		STL
> -	}
> +	if (!S) return;
> +
> +	STL
> |
> -	if (S) ST
> +	if (!S) return;
> +
> +	ST
> )
> 	...>
>  }
> 
> @transform_body depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier S, P;
> expression PS;
> @@
> - void reset_func(struct drm_plane *P)
> + struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	S = kzalloc_obj(*S);
> 	...
> (
>  	if (!S) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (WARN_ON(!S)) {
> 		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> |
>  	if (S == NULL) {
>  		...
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  	}
> )
> 	...
> (
> -	__drm_atomic_helper_plane_reset(P, PS);
> +	__drm_atomic_helper_plane_state_init(PS, P);
> |
> -	__drm_gem_reset_shadow_plane(P, PS);
> +	__drm_gem_shadow_plane_state_init(P, PS);
> )
> 	...
> }
> 
> @update_early_return depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	<+...
> -	return;
> +	return ERR_PTR(-EINVAL);
> 	...+>
> }
> 
> @update_return_plane depends on update_struct@
> identifier match_struct_reset.reset_func;
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_atomic_helper_plane_state_init(PS, P);
> 	...
> +
> +	return PS;
> }
> 
> @update_return_shadow depends on update_struct@
> identifier renamed_func.new_name;
> identifier P;
> expression PS;
> @@
>  struct drm_plane_state *new_name(struct drm_plane *P)
> {
> 	...
>  	__drm_gem_shadow_plane_state_init(P, PS);
> 	...
> +
> +	return &PS->base;
> }
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
Leo

> ---
> Cc: alexander.deucher@amd.com
> Cc: amd-gfx@lists.freedesktop.org
> Cc: christian.koenig@amd.com
> Cc: harry.wentland@amd.com
> Cc: siqueira@igalia.com
> Cc: sunpeng.li@amd.com
> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    | 28 ++++++++++++--------
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h    |  2 +-
>  .../display/amdgpu_dm/tests/amdgpu_dm_plane_test.c | 30 ++++++++--------------
>  3 files changed, 29 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 824ef3ce5de0..f9655f534d3b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1786,28 +1786,27 @@ static const struct drm_plane_helper_funcs dm_primary_plane_helper_funcs = {
>  	.atomic_async_update = amdgpu_dm_plane_atomic_async_update,
>  	.get_scanout_buffer = amdgpu_display_get_scanout_buffer,
>  	.panic_flush = amdgpu_dm_plane_panic_flush,
>  };
>  
> -STATIC_IFN_KUNIT void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane)
> +STATIC_IFN_KUNIT struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(struct drm_plane *plane)
>  {
>  	struct dm_plane_state *amdgpu_state;
>  
>  	amdgpu_state = kzalloc_obj(*amdgpu_state);
>  	if (!amdgpu_state)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  
> -	if (plane->state)
> -		plane->funcs->atomic_destroy_state(plane, plane->state);
> -
> -	__drm_atomic_helper_plane_reset(plane, &amdgpu_state->base);
> +	__drm_atomic_helper_plane_state_init(&amdgpu_state->base, plane);
>  	amdgpu_state->degamma_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
>  	amdgpu_state->hdr_mult = AMDGPU_HDR_MULT_DEFAULT;
>  	amdgpu_state->shaper_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
>  	amdgpu_state->blend_tf = AMDGPU_TRANSFER_FUNCTION_DEFAULT;
> +
> +	return &amdgpu_state->base;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_reset);
> +EXPORT_IF_KUNIT(amdgpu_dm_plane_drm_plane_create_state);
>  
>  STATIC_IFN_KUNIT struct drm_plane_state *
>  amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane)
>  {
>  	struct dm_plane_state *dm_plane_state, *old_dm_plane_state;
> @@ -2166,11 +2165,11 @@ dm_plane_init_colorops(struct drm_plane *plane)
>  
>  static const struct drm_plane_funcs dm_plane_funcs = {
>  	.update_plane	= drm_atomic_helper_update_plane,
>  	.disable_plane	= drm_atomic_helper_disable_plane,
>  	.destroy	= drm_plane_helper_destroy,
> -	.reset = amdgpu_dm_plane_drm_plane_reset,
> +	.atomic_create_state = amdgpu_dm_plane_drm_plane_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
>  	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
>  	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
>  	.format_mod_supported_async = amdgpu_dm_plane_format_mod_supported,
>  #ifdef AMD_PRIVATE_COLOR
> @@ -2276,13 +2275,20 @@ int amdgpu_dm_plane_init(struct amdgpu_display_manager *dm,
>  	res = dm_plane_init_colorops(plane);
>  	if (res)
>  		return res;
>  #endif
>  
> -	/* Create (reset) the plane state */
> -	if (plane->funcs->reset)
> -		plane->funcs->reset(plane);
> +	/* Create the plane state */
> +	if (plane->funcs->atomic_create_state) {
> +		struct drm_plane_state *plane_state;
> +
> +		plane_state = plane->funcs->atomic_create_state(plane);
> +		if (IS_ERR(plane_state))
> +			return PTR_ERR(plane_state);
> +
> +		plane->state = plane_state;
> +	}
>  
>  	return 0;
>  }
>  
>  bool amdgpu_dm_plane_is_video_format(uint32_t format)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> index 092ade738ce9..6aaea290206d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
> @@ -115,11 +115,11 @@ void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
>  int amdgpu_dm_plane_atomic_async_check(struct drm_plane *plane,
>  				       struct drm_atomic_commit *state, bool flip);
>  int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
>  				 struct drm_atomic_commit *state);
>  void amdgpu_dm_plane_panic_flush(struct drm_plane *plane);
> -void amdgpu_dm_plane_drm_plane_reset(struct drm_plane *plane);
> +struct drm_plane_state *amdgpu_dm_plane_drm_plane_create_state(struct drm_plane *plane);
>  struct drm_plane_state *amdgpu_dm_plane_drm_plane_duplicate_state(struct drm_plane *plane);
>  void amdgpu_dm_plane_drm_plane_destroy_state(struct drm_plane *plane,
>  					     struct drm_plane_state *state);
>  void amdgpu_dm_plane_add_modifier_dedup(uint64_t **mods, uint64_t *size,
>  					uint64_t *cap, uint64_t mod);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> index ba97092c7bb8..ab425ee14f30 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
> @@ -2922,40 +2922,32 @@ static void dm_test_panic_flush_no_dc_state(struct kunit *test)
>  static const struct drm_plane_funcs dm_test_plane_reset_funcs = {
>  	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
>  };
>  
>  /**
> - * dm_test_plane_reset_initializes_state() - Verify reset installs default state.
> + * dm_test_plane_create_state_initializes_state() - Verify create_state allocates default state.
>   * @test: KUnit test context.
>   *
> - * Verify amdgpu_dm_plane_drm_plane_reset() destroys the existing plane state,
> - * allocates a fresh dm_plane_state, and initializes the AMD-specific transfer
> - * function and HDR multiplier defaults.
> + * Verify amdgpu_dm_plane_drm_plane_create_state() allocates a fresh
> + * dm_plane_state, and initializes the AMD-specific transfer function and HDR
> + * multiplier defaults.
>   */
> -static void dm_test_plane_reset_initializes_state(struct kunit *test)
> +static void dm_test_plane_create_state_initializes_state(struct kunit *test)
>  {
> -	struct dm_plane_state *old_state;
> +	struct drm_plane_state *plane_state;
>  	struct dm_plane_state *new_state;
>  	struct drm_plane *plane;
>  
>  	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, plane);
>  
> -	/*
> -	 * Provide an existing state plus a funcs table so reset exercises the
> -	 * destroy-existing-state path. The destroy hook frees this state, so it
> -	 * must be a plain (non-KUnit-managed) allocation.
> -	 */
> -	old_state = kzalloc(sizeof(*old_state), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, old_state);
>  	plane->funcs = &dm_test_plane_reset_funcs;
> -	plane->state = &old_state->base;
>  
> -	amdgpu_dm_plane_drm_plane_reset(plane);
> +	plane_state = amdgpu_dm_plane_drm_plane_create_state(plane);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane_state);
>  
> -	KUNIT_ASSERT_NOT_NULL(test, plane->state);
> -	new_state = to_dm_plane_state(plane->state);
> +	new_state = to_dm_plane_state(plane_state);
>  	KUNIT_EXPECT_EQ(test, new_state->degamma_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
>  	KUNIT_EXPECT_EQ(test, new_state->hdr_mult, AMDGPU_HDR_MULT_DEFAULT);
>  	KUNIT_EXPECT_EQ(test, new_state->shaper_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
>  	KUNIT_EXPECT_EQ(test, new_state->blend_tf, AMDGPU_TRANSFER_FUNCTION_DEFAULT);
>  
> @@ -3096,12 +3088,12 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
>  	KUNIT_CASE(dm_test_atomic_check_helper_failure),
>  	KUNIT_CASE(dm_test_atomic_check_color_pipeline_conflict),
>  	KUNIT_CASE(dm_test_atomic_check_scaling_failure),
>  	/* amdgpu_dm_plane_panic_flush() */
>  	KUNIT_CASE(dm_test_panic_flush_no_dc_state),
> -	/* amdgpu_dm_plane_drm_plane_reset() */
> -	KUNIT_CASE(dm_test_plane_reset_initializes_state),
> +	/* amdgpu_dm_plane_drm_plane_create_state() */
> +	KUNIT_CASE(dm_test_plane_create_state_initializes_state),
>  	/* amdgpu_dm_plane_drm_plane_duplicate_state() */
>  	KUNIT_CASE(dm_test_plane_duplicate_state_copies_fields),
>  	/* amdgpu_dm_plane_drm_plane_destroy_state() */
>  	KUNIT_CASE(dm_test_plane_destroy_state_minimal),
>  	/* amdgpu_dm_plane_add_modifier() */
> 

