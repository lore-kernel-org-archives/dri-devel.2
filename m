Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2B606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PMR/XewZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9160A10F31F;
	Mon, 19 Oct 2026 16:39:04 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013051.outbound.protection.outlook.com
 [40.93.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123F510F2D3;
 Mon, 19 Oct 2026 16:38:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFjYatkQgyqJ/S4eXdcd34Arrb6XU/SkIVNUvhYh/m3zf8fusB9nU7xTHkQA+IMCCEsk1F/1ieAxea04w/Q3FPaCrgc5UVZdVFoC4uytw/VzG0lE9ukzzBsw85nSL2zaig2F8zYjrZzQZQkkZ5HoHxrZjlGA8vTH5L3tWgR7rBEhVMHtpT8pke+fGzCUDkeQ1dZ6o5K0JJwJGHMdpUnwjFKqiwn9N0lRaQZgMRERyCTsQpLyeam8OnPOX2WOIpnFcpocGXIgZ/F61HMPpjBQLfcV1gzJJNwtINfRiSbh6EU/PCnSKVklpWPk9P9gfQ4+96Rzs/+2HvkYZ35KooUejw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBEzgghCPz3UX3AuxQ+LkqyNbMI0Ujl3TW3LAZqa3CM=;
 b=IRTPeuY9O8Yk0O1mFhD46rQi3i3klrGGgWR5/22UJS6yejXlWyMOmjPTn9dFKy6qhC8rVjw6c9bclldGBagq8eVmZP0B2ZAqAzewymXnWZx/U8OwBPbAJLAqS0UpTVnVCNdsCnIFcF+5qGJV0/EVcCR6taUfqKTJmDxHBuaUcaeKOuwNLKUMGTTVJZ3eByhhWdyDJ+btFABdxhufBoMZpce65CCTAhssb4X1ShvsKHZ2+eyc8Cd2jqMniPECT5+ifCxaet/LFMEakY+TPcxJbmUKM830r7mG+pKsmHN6p1Tzb4sCnAwZbAF95n++liU8s2wrCzRv8ZjviA53i2iaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBEzgghCPz3UX3AuxQ+LkqyNbMI0Ujl3TW3LAZqa3CM=;
 b=PMR/XewZIs984M1nI4m3LiIdRsNc6nwr7c0AOjsOjSd0wHqFBxUSYp7ZEP2T8d/chJyhAQ6YLQrLOyBOA4V8eiGuwtuE543/w6XWDdKYV8nUPV7FI/MQ3gdRctERPw8yspUiIMmF8ty4XV+ec5JSj6OeLEbjdD+rESbBrnF0+vU=
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 16:38:51 +0000
Received: from BN3PEPF00022BCA.namprd03.prod.outlook.com
 (2603:10b6:408:113:cafe::a0) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 16:38:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCA.mail.protection.outlook.com (10.167.248.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 16:38:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:38:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 11:38:41 -0500
Received: from [10.254.92.67] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 11:38:40 -0500
Message-ID: <a94849ae-f553-4752-a236-746fa89e23fa@amd.com>
Date: Mon, 19 Oct 2026 12:38:47 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 66/75] drm/amdgpu: dm: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 <amd-gfx@lists.freedesktop.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-66-586c9c026823@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCA:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: c1620d3c-7f1a-4a39-2cdb-08df2dff7459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|42112799006|82310400026|56012099006|4143699003|11063799006|5023799004|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: eo6LE1R2zQiiKIUwSsjidFJ9/iAm+C29QD1+NAOmnSNkwHy3EtWtopHdQknp3l3s5T32wDeUhsLz5YEkjM1Wxn8Ni6J8q4IgWh7nAglKXfoK9I08zZwm2fBCnAkvRoAg1i0vbaGN0OdSxdSzn4ltMLbQHKAgQLyjfId+GDt1m4zpv5Qw38n5VKwese4O+6B1DTbn6NcWWIQcwkGX899dKyYWF5zDeJ2pfcl0dezZoitYFnspogDCoWFKBMzRGWhi6FzH8BM4i7NO1fyXevV0APLjEXOhYBIr7InqrnZM7pY6gy6pbkRkqfp9IhBkXVUIogG8CrU2x69nDf8SFHyyRQNcSHTQuhOr0LMV+UEoeNi5AOjPdOZjcBArmeIJWmzRcG6uAr1nVNHKVAY+ezGFpvPEUXmpm+29tPr08NtDU5sk4Uz3SetnBibYdejx1IxUTSunp8ct+F52f8l24Ibylavx0JhCWm//tWyLf3A4n5483iOaqZ4wv+C4ipmj2ZyC7r2a/Q3RnlknCyGw+W7RC3CAYbjJ+MpPgqoaGa4BHSCrgFvL29pjQseMafkwry4bPtgLS0wFCYqqAMQY0PzecBUoMcvTLWVfOlIEiI1csln6Fr8Hq5j62xIHxN2Cy9oibxjnrfYo+g7a2P233mcEyMVgxFBYxZNtax9EIfk1qYEr7Japho2U8jfQUmYZbSxAeYp0pJ5DIgufbE0Rzr7/vQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(42112799006)(82310400026)(56012099006)(4143699003)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LJm1qF7yAmmUcHX3Db44uj5mTSSGsKVk8059Hht2yXSN2Z+4WwptvfAA5Fy+eF9f04ic5ZWsv+HVsfEUHosZf27q6iucvyqW+97ccD5iZSad0XsXmJgzV+oL+lD7qiqZOMF9yDK6AJAbLfljD+NnKR97hzPjCmU4MfxHjj/hFKqIdWz7xNuERWL8ndWsKJiBEqrloQM1OuiPjwKDot7VWrX07gUSu5AUflBJKO25ZE3izwUdYINJfgIY8QhB1/Xzc9fl8SDhEeCK60A4REIXlT9bNehTOFuV4CHXaGGIPMNQTAgK8kEucQ/MvwXCdEAR0Nb2W0yGgigGD0YAVdoe6+pN60TAHND3sFwGc4M0K2nI0PZHSsLA7CjfARLo6OCkabLeQDOLy6VVFt5MeNTWddMWBPQLzT+7dhYESgCBepFELyrs9crEiTTMEk6A2wqH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 16:38:50.1410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1620d3c-7f1a-4a39-2cdb-08df2dff7459
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026-10-14 13:27, Maxime Ripard wrote:
> The amdgpu_dm connector reset implementation creates a custom state
> subclass, but only initializes a pristine state without resetting any
> hardware. This is equivalent to what atomic_create_state expects.
> Convert to it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 32 ++++----
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.h    |  3 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  4 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 14 +++-
>  .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 90 ++++++++++++++--------
>  5 files changed, 91 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> index 3a4e98b08ac1..2c22f00f521c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> @@ -1939,26 +1939,20 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
>  
>  	kfree(connector);
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_connector_destroy);
>  
> -void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
> +struct drm_connector_state *
> +amdgpu_dm_connector_atomic_create_state(struct drm_connector *connector)
>  {
> -	struct dm_connector_state *old_state =
> -		to_dm_connector_state(connector->state);
>  	struct dm_connector_state *state;
>  
>  	state = kzalloc_obj(*state);
>  	if (!state)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  
> -	if (connector->state)
> -		__drm_atomic_helper_connector_destroy_state(connector->state);
> -
> -	kfree(old_state);
> -
> -	__drm_atomic_helper_connector_reset(connector, &state->base);
> +	__drm_atomic_helper_connector_state_init(&state->base, connector);
>  
>  	state->scaling = RMX_OFF;
>  	state->underscan_enable = false;
>  	state->underscan_hborder = 0;
>  	state->underscan_vborder = 0;
> @@ -1970,12 +1964,14 @@ void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector)
>  		if (amdgpu_dm_abm_level <= 0)
>  			state->abm_level = ABM_LEVEL_IMMEDIATE_DISABLE;
>  		else
>  			state->abm_level = amdgpu_dm_abm_level;
>  	}
> +
> +	return &state->base;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_reset);
> +EXPORT_IF_KUNIT(amdgpu_dm_connector_atomic_create_state);
>  
>  struct drm_connector_state *
>  amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector)
>  {
>  	struct dm_connector_state *state =
> @@ -2070,11 +2066,11 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *conn
>  	}
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_force);
>  
>  static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.detect = amdgpu_dm_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = amdgpu_dm_connector_destroy,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
> @@ -3197,12 +3193,20 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>  
>  	/*
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.
>  	 */
> -	if (aconnector->base.funcs->reset)
> -		aconnector->base.funcs->reset(&aconnector->base);
> +	if (!aconnector->base.state &&
> +	    aconnector->base.funcs->atomic_create_state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +		if (IS_ERR(conn_state))
> +			return;
> +
> +		aconnector->base.state = conn_state;
> +	}
>  
>  	aconnector->connector_id = link_index;
>  	aconnector->bl_idx = -1;
>  	aconnector->dc_link = link;
>  	aconnector->base.interlace_allowed = false;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> index 79698deacf61..4a73fc607f38 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> @@ -48,11 +48,12 @@ struct drm_crtc;
>  struct drm_device;
>  struct drm_display_mode;
>  struct drm_edid;
>  struct drm_property;
>  
> -void amdgpu_dm_connector_funcs_reset(struct drm_connector *connector);
> +struct drm_connector_state *
> +amdgpu_dm_connector_atomic_create_state(struct drm_connector *connector);
>  
>  struct drm_connector_state *
>  amdgpu_dm_connector_atomic_duplicate_state(struct drm_connector *connector);
>  
>  int amdgpu_dm_connector_atomic_set_property(struct drm_connector *connector,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index a5b15bef8aa0..cb189c098ec3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -256,11 +256,11 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
>  EXPORT_IF_KUNIT(amdgpu_dm_mst_connector_early_unregister);
>  
>  static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = dm_dp_mst_connector_destroy,
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.atomic_set_property = amdgpu_dm_connector_atomic_set_property,
>  	.atomic_get_property = amdgpu_dm_connector_atomic_get_property,
>  	.late_register = amdgpu_dm_mst_connector_late_register,
> @@ -736,11 +736,11 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
>  
>  	/*
>  	 * Initialize connector state before adding the connectror to drm and
>  	 * framebuffer lists
>  	 */
> -	amdgpu_dm_connector_funcs_reset(connector);

I'm actually not sure why there was a state reset here. amdgpu_dm_connector_init_helper() is called earlier in this func and that already did a reset.

> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);

That asside, looks like this can overwrite the alloc'd state from init_helper() without freeing. So to keep the previous behavior and avoid regressing, perhaps we can do this:

	conn_state = amdgpu_dm_connector_atomic_create_state(connector);
	if (!IS_ERR(conn_state)) {
		if (connector->state)
			connector->funcs->atomic_destroy_state(connector, connector->state);
		connector->state = conn_state;
	}
>  
>  	drm_dp_mst_get_port_malloc(port);
>  
>  	return connector;
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> index 6f91a992d43f..8181fcac299d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
> @@ -223,11 +223,11 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
>  };
>  
>  static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  static const struct drm_connector_helper_funcs amdgpu_dm_wb_conn_helper_funcs = {
> @@ -259,11 +259,19 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
>  		return res;
>  	/*
>  	 * Some of the properties below require access to state, like bpc.
>  	 * Allocate some default initial connector state with our reset helper.
>  	 */
> -	if (wbcon->base.base.funcs->reset)
> -		wbcon->base.base.funcs->reset(&wbcon->base.base);
> +	if (!wbcon->base.base.state &&
> +	    wbcon->base.base.funcs->atomic_create_state) {
> +		struct drm_connector_state *conn_state;
> +
> +		conn_state = amdgpu_dm_connector_atomic_create_state(&wbcon->base.base);

Nit: functionally the same, but would `wbcon->base.base.funcs->atomic_create_state(&wbcon->base.base);` be clearer?

Thanks,
Leo

> +		if (IS_ERR(conn_state))
> +			return PTR_ERR(conn_state);
> +
> +		wbcon->base.base.state = conn_state;
> +	}
>  
>  	return 0;
>  }
>  EXPORT_IF_KUNIT(amdgpu_dm_wb_connector_init);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> index 8117aaf41f22..ebf8155326cb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
> @@ -1466,23 +1466,23 @@ static void dm_test_decide_crtc_timing_no_crtc_clock(struct kunit *test)
>  
>  	KUNIT_EXPECT_EQ(test, drm_mode.crtc_clock, 0);
>  	KUNIT_EXPECT_EQ(test, drm_mode.crtc_hdisplay, 0);
>  }
>  
> -/* Tests for amdgpu_dm_connector_funcs_reset() */
> +/* Tests for amdgpu_dm_connector_atomic_create_state() */
>  
>  static const struct drm_connector_funcs dm_test_connector_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  /**
> - * dm_test_funcs_reset_sets_defaults - Test funcs_reset sets defaults
> + * dm_test_atomic_create_sets_defaults - Test funcs_reset sets defaults
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
> +static void dm_test_atomic_create_sets_defaults(struct kunit *test)
>  {
>  	struct device *dev;
>  	struct drm_device *drm;
>  	struct drm_connector *connector;
>  	struct dm_connector_state *dm_state;
> @@ -1499,13 +1499,13 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
>  	KUNIT_ASSERT_NOT_NULL(test, connector);
>  
>  	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>  			    DRM_MODE_CONNECTOR_DisplayPort, NULL);
>  
> -	amdgpu_dm_connector_funcs_reset(connector);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
>  
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
>  	dm_state = to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->scaling, (int)RMX_OFF);
>  	KUNIT_EXPECT_FALSE(test, dm_state->underscan_enable);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->underscan_hborder, 0);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->underscan_vborder, 0);
> @@ -1513,14 +1513,14 @@ static void dm_test_funcs_reset_sets_defaults(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, dm_state->vcpi_slots, 0);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->pbn, 0);
>  }
>  
>  /**
> - * dm_test_funcs_reset_edp_abm_level - Test funcs_reset eDP sets ABM
> + * dm_test_atomic_create_edp_abm_level - Test funcs_reset eDP sets ABM
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
> +static void dm_test_atomic_create_edp_abm_level(struct kunit *test)
>  {
>  	struct device *dev;
>  	struct drm_device *drm;
>  	struct drm_connector *connector;
>  	struct dm_connector_state *dm_state;
> @@ -1540,25 +1540,26 @@ static void dm_test_funcs_reset_edp_abm_level(struct kunit *test)
>  	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>  			    DRM_MODE_CONNECTOR_eDP, NULL);
>  
>  	/* Test with abm_level > 0 */
>  	amdgpu_dm_set_abm_level_param(3);
> -	amdgpu_dm_connector_funcs_reset(connector);
>  
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> +
>  	dm_state = to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level, 3);
>  
>  	amdgpu_dm_set_abm_level_param(saved_abm_level);
>  }
>  
>  /**
> - * dm_test_funcs_reset_edp_abm_disabled - Test funcs_reset eDP ABM
> + * dm_test_atomic_create_edp_abm_disabled - Test funcs_reset eDP ABM
>   * disabled
>   * @test: The KUnit test context
>   */
> -static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
> +static void dm_test_atomic_create_edp_abm_disabled(struct kunit *test)
>  {
>  	struct device *dev;
>  	struct drm_device *drm;
>  	struct drm_connector *connector;
>  	struct dm_connector_state *dm_state;
> @@ -1578,13 +1579,14 @@ static void dm_test_funcs_reset_edp_abm_disabled(struct kunit *test)
>  	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>  			    DRM_MODE_CONNECTOR_eDP, NULL);
>  
>  	/* Test with abm_level <= 0 → immediate disable */
>  	amdgpu_dm_set_abm_level_param(-1);
> -	amdgpu_dm_connector_funcs_reset(connector);
>  
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
> +
>  	dm_state = to_dm_connector_state(connector->state);
>  	KUNIT_EXPECT_EQ(test, (int)dm_state->abm_level,
>  			(int)ABM_LEVEL_IMMEDIATE_DISABLE);
>  
>  	amdgpu_dm_set_abm_level_param(saved_abm_level);
> @@ -1618,12 +1620,12 @@ static void dm_test_atomic_dup_state_copies_fields(struct kunit *test)
>  	KUNIT_ASSERT_NOT_NULL(test, connector);
>  
>  	drmm_connector_init(drm, connector, &dm_test_connector_funcs,
>  			    DRM_MODE_CONNECTOR_HDMIA, NULL);
>  
> -	amdgpu_dm_connector_funcs_reset(connector);
> -	KUNIT_ASSERT_NOT_NULL(test, connector->state);
> +	connector->state = amdgpu_dm_connector_atomic_create_state(connector);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, connector->state);
>  
>  	/* Modify original state fields */
>  	dm_state = to_dm_connector_state(connector->state);
>  	dm_state->scaling = RMX_CENTER;
>  	dm_state->underscan_enable = true;
> @@ -4884,11 +4886,11 @@ static struct dm_test_destroy_ctx *dm_test_destroy_ctx_alloc(struct kunit *test)
>   * drm_connector_init() requires funcs->destroy to be set, so a dedicated funcs
>   * table wires it to amdgpu_dm_connector_destroy() (the test invokes it
>   * directly; the connector is removed from the device before teardown).
>   */
>  static const struct drm_connector_funcs dm_test_destroy_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.destroy = amdgpu_dm_connector_destroy,
>  };
>  
> @@ -6251,17 +6253,21 @@ static void dm_test_restore_state_no_connector_state(struct kunit *test)
>   */
>  static void dm_test_restore_state_no_encoder(struct kunit *test)
>  {
>  	struct drm_device *drm = dm_test_alloc_drm(test);
>  	struct amdgpu_dm_connector *aconnector;
> +	struct drm_connector_state *conn_state;
>  
>  	aconnector = dm_test_add_connector(test, drm,
>  					   DRM_MODE_CONNECTOR_HDMIA);
>  	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
> -	aconnector->base.funcs->reset(&aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, aconnector->base.state);
> +
> +	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	aconnector->base.state = conn_state;
>  	/* connector->encoder left NULL. */
>  
>  	dm_restore_drm_connector_state(drm, &aconnector->base);
>  
>  	KUNIT_EXPECT_NULL(test, aconnector->base.encoder);
> @@ -6275,20 +6281,25 @@ static void dm_test_restore_state_no_encoder(struct kunit *test)
>   * dc stream, so the function returns before comparing sinks.
>   */
>  static void dm_test_restore_state_no_stream(struct kunit *test)
>  {
>  	struct drm_device *drm = dm_test_alloc_drm(test);
> +	struct drm_connector_state *conn_state;
>  	struct amdgpu_dm_connector *aconnector;
>  	struct dm_crtc_state *acrtc_state;
>  	struct drm_encoder *enc;
>  	struct drm_crtc *crtc;
>  
>  	aconnector = dm_test_add_connector(test, drm,
>  					   DRM_MODE_CONNECTOR_HDMIA);
>  	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
> -	aconnector->base.funcs->reset(&aconnector->base);
> +
> +	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	aconnector->base.state = conn_state;
>  
>  	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, enc);
>  	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, crtc);
> @@ -6313,21 +6324,26 @@ static void dm_test_restore_state_no_stream(struct kunit *test)
>   * nothing to restore, so the forced atomic commit is not issued.
>   */
>  static void dm_test_restore_state_same_sink(struct kunit *test)
>  {
>  	struct drm_device *drm = dm_test_alloc_drm(test);
> +	struct drm_connector_state *conn_state;
>  	struct amdgpu_dm_connector *aconnector;
>  	struct dm_crtc_state *acrtc_state;
>  	struct dc_stream_state *stream;
>  	struct drm_encoder *enc;
>  	struct drm_crtc *crtc;
>  
>  	aconnector = dm_test_add_connector(test, drm,
>  					   DRM_MODE_CONNECTOR_HDMIA);
>  	aconnector->dc_sink = kunit_kzalloc(test, 1, GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, aconnector->dc_sink);
> -	aconnector->base.funcs->reset(&aconnector->base);
> +
> +	conn_state = aconnector->base.funcs->atomic_create_state(&aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	aconnector->base.state = conn_state;
>  
>  	enc = kunit_kzalloc(test, sizeof(*enc), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, enc);
>  	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, crtc);
> @@ -7030,10 +7046,11 @@ static void dm_test_mode_valid_no_dc_sink(struct kunit *test)
>   */
>  static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
>  {
>  	struct dm_test_cvs_ctx *ctx =
>  		dm_test_cvs_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
> +	struct drm_connector_state *conn_state;
>  	struct dc_sink *em_sink;
>  
>  	em_sink = kunit_kzalloc(test, sizeof(*em_sink), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, em_sink);
>  
> @@ -7042,12 +7059,14 @@ static void dm_test_mode_valid_force_on_no_stream(struct kunit *test)
>  	ctx->aconnector->base.force = DRM_FORCE_ON;
>  
>  	/* drm_connector_cleanup() kfree()s connector->state, so it must not
>  	 * point at KUnit-managed memory.
>  	 */
> -	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
> +	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	ctx->aconnector->base.state = conn_state;
>  	ctx->aconnector->base.state->max_requested_bpc = 4;
>  
>  	KUNIT_EXPECT_EQ(test,
>  			amdgpu_dm_connector_mode_valid(&ctx->aconnector->base,
>  						       ctx->mode),
> @@ -7557,10 +7576,11 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
>  {
>  	struct dm_test_uad_ctx *ctx =
>  		dm_test_uad_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
>  	struct dc_sink *old_sink = dm_test_uad_owned_sink();
>  	struct dc_crtc_timing *timing = kzalloc_obj(*timing, GFP_KERNEL);
> +	struct drm_connector_state *conn_state;
>  
>  	KUNIT_ASSERT_NOT_NULL(test, old_sink);
>  	KUNIT_ASSERT_NOT_NULL(test, timing);
>  
>  	mutex_init(&ctx->adev->dm.audio_lock);
> @@ -7568,12 +7588,14 @@ static void dm_test_update_after_detect_disconnect(struct kunit *test)
>  	ctx->aconnector->timing_requested = timing;
>  	ctx->aconnector->num_modes = 3;
>  	ctx->aconnector->audio_inst = 5;
>  	ctx->link->local_sink = NULL;
>  
> -	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
> +	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	ctx->aconnector->base.state = conn_state;
>  	ctx->aconnector->base.state->content_protection =
>  		DRM_MODE_CONTENT_PROTECTION_ENABLED;
>  
>  	amdgpu_dm_update_connector_after_detect(ctx->aconnector);
>  
> @@ -9197,10 +9219,11 @@ struct dm_test_fs_caps_ctx {
>   * parser to succeed install one.
>   */
>  static struct dm_test_fs_caps_ctx *
>  dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
>  {
> +	struct drm_connector_state *conn_state;
>  	struct dm_test_fs_caps_ctx *ctx;
>  	struct dc_context *dc_ctx;
>  	struct device *dev;
>  	struct dc *dc;
>  
> @@ -9222,12 +9245,15 @@ dm_test_fs_caps_ctx_alloc(struct kunit *test, enum signal_type sink_signal)
>  	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
>  	KUNIT_ASSERT_EQ(test,
>  			drmm_connector_init(ctx->drm, &ctx->aconnector->base,
>  					    &dm_test_connector_funcs,
>  					    DRM_MODE_CONNECTOR_DisplayPort, NULL), 0);
> -	amdgpu_dm_connector_funcs_reset(&ctx->aconnector->base);
> -	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector->base.state);
> +
> +	conn_state = amdgpu_dm_connector_atomic_create_state(&ctx->aconnector->base);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, conn_state);
> +
> +	ctx->aconnector->base.state = conn_state;
>  	KUNIT_ASSERT_EQ(test,
>  			drm_connector_attach_vrr_capable_property(&ctx->aconnector->base), 0);
>  
>  	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
> @@ -9628,11 +9654,11 @@ dm_test_force_dup_state_fail(struct drm_connector *connector)
>  {
>  	return NULL;
>  }
>  
>  static const struct drm_connector_funcs dm_test_force_fail_funcs = {
> -	.reset = amdgpu_dm_connector_funcs_reset,
> +	.atomic_create_state = amdgpu_dm_connector_atomic_create_state,
>  	.atomic_duplicate_state = dm_test_force_dup_state_fail,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  /* The atomic modeset check dereferences the helper funcs unconditionally. */
> @@ -9845,14 +9871,14 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
>  	/* decide_crtc_timing_for_drm_display_mode */
>  	KUNIT_CASE(dm_test_decide_crtc_timing_scale_enabled),
>  	KUNIT_CASE(dm_test_decide_crtc_timing_matching_mode),
>  	KUNIT_CASE(dm_test_decide_crtc_timing_no_copy),
>  	KUNIT_CASE(dm_test_decide_crtc_timing_no_crtc_clock),
> -	/* amdgpu_dm_connector_funcs_reset */
> -	KUNIT_CASE(dm_test_funcs_reset_sets_defaults),
> -	KUNIT_CASE(dm_test_funcs_reset_edp_abm_level),
> -	KUNIT_CASE(dm_test_funcs_reset_edp_abm_disabled),
> +	/* amdgpu_dm_connector_atomic_create_state */
> +	KUNIT_CASE(dm_test_atomic_create_sets_defaults),
> +	KUNIT_CASE(dm_test_atomic_create_edp_abm_level),
> +	KUNIT_CASE(dm_test_atomic_create_edp_abm_disabled),
>  	/* amdgpu_dm_connector_atomic_duplicate_state */
>  	KUNIT_CASE(dm_test_atomic_dup_state_copies_fields),
>  	/* amdgpu_dm_fill_hdr_info_packet */
>  	KUNIT_CASE(dm_test_fill_hdr_null_metadata),
>  	KUNIT_CASE(dm_test_fill_hdr_zeroes_output),
> 

