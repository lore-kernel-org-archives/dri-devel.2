Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E483CC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:42:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21DD810E47F;
	Thu, 10 Sep 2026 16:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5nj2B7xp";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49F4710E47F;
 Thu, 10 Sep 2026 16:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtkuraN6Tmzc4ik0zVqcY65DdYBvdaAyvteiDUiwvQRwIP+aCh/Yl2wDC6Ua8hPP/VllOBC7uOe8I62hvdMwKbvGcOOpVeb5fLsII9+eW94oviqwyejrnjJS8ygZepj5cM0lpsz7w4waEDsTpW3fbUfIFt+jDgz8xxX5+ZAPER8PAgef3nTIUk3CdDEohf3stO3hLl75ZUshAXfHvDl1RpPGqkHIUWEEbqn+qUQWM6pgf4XRxRaXOD7ubkz8Ef/mG/eeE1nbI+tNCN5hSkCc2dTzDiBV/zTtM48O3oXFhF7rjWUS0OGdsGpgKOaKPRXzl7mCBgVlIAlDpVv60X0mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ds63tCNSo411S3JbHn3iAxLp/ZHYlZAd9tDVI9s2rGk=;
 b=n+tFyA0IbVWVZfN6aVt7v+XDf4GZWBEq/CXuvEZSb/7b9btbu16phTw6Gi1HHmlbE5KR0ieRZ/OpyqEofFWLpX67zLboy5zp5g4GubS3lvWMLcTYacXIGZPefr/1bhtbSsGKY53dABPutQgkojjv/TyFUGKvYUxsw8AYRMYwB4jG7R6DpY7rQ+SsWa0/Sy6lhBANyTb5w3bibX4k1D3M6/rHjPry0Iero8FBeKJV/kaaxS+K9biYUcl7Zk6peBqKRTcwDTtTpajd+L4TeXzQvlO2Yh+k5NA4iCvsxKp9G8UXXsxG2ZTjVFEFb7eDlHPk+sBCR0eNEItXTh/K9e9JBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ds63tCNSo411S3JbHn3iAxLp/ZHYlZAd9tDVI9s2rGk=;
 b=5nj2B7xpj29vDyNNeLdYKpXryV9Xa+JoJciJP9/4FLke7nQgjq1hI2o48J7l3BRIbHJlWPQJwdKnZnA7P5Jz2DG818mjsdM0hkhfIe0cnLXGeEyJDwOe2D4xs37dD4jgyFeegYi2CAxtWAyJ+Fb/q6q1uUeQOYJxlEg7nikTXSc=
Received: from CH2PR08CA0024.namprd08.prod.outlook.com (2603:10b6:610:5a::34)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 16:41:51 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::15) by CH2PR08CA0024.outlook.office365.com
 (2603:10b6:610:5a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 16:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 16:41:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 11:41:47 -0500
Received: from [10.254.92.142] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 10 Sep 2026 11:41:47 -0500
Message-ID: <1e734f27-e7fe-4e1b-9987-795d930e9237@amd.com>
Date: Thu, 10 Sep 2026 12:41:46 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] drm/amdgpu: dm: Convert to atomic_create_state
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 <amd-gfx@lists.freedesktop.org>
References: <20260904-drm-no-more-crtc-reset-v3-0-27d9891512ce@kernel.org>
 <20260904-drm-no-more-crtc-reset-v3-7-27d9891512ce@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260904-drm-no-more-crtc-reset-v3-7-27d9891512ce@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e64eee-5494-439f-994d-08df0f5a69c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|36860700016|1800799024|376014|23010399003|4143699003|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: wMPVEjO/hU/Gc8ZUuOCsTh9AMbgGK+aLwnq50FCNGkahaVJTOmxrtZsx+aR/T2jDwzmBm5Cnix1RhZ3q533M3Zm4xcUHK8Ak2lz9I7slMckzQRAp92EXfNTy1raV4mPGYeEFEVcEN4w3gRv5Mk0GHqO/Tn5lOuiG0rVsM4heFdC34T+czzB8PNg+t5C5jFBvfPH1k4iDZUG7LW0LYj7Ab8XWdHy0mAc9zM3nmH3Qt5m89RxM7fkUqK2U+DGCO3eofYz26l7U3MCinY0iWH+KT5OvAMIp6v/YweqHDk3qBePp2uRNikJnhiyaAhhQCSs2xiSWQZJBuy59wEiVxX2BC4sopD4YCPPNAE9qFOFI1ASfX/3e6cgJ8cN3hoYZkmj4ViaGojPDpRTWAH/xIdW3+sY0axg46X0tiJAxBCwfMiCyBkd99QlK+Ng1nOlUH9o2QrPm+6g1+NbH7jJfujCaCbaQ4jdIZaZFH4ml9x2E6v10X1aZqKOKWm+MfJjltuB3mU17u4T6pWd8mFqt9Oj+IPfUKgbO4MqI40J6OH6+ZfmYC7exLs1FzXZX3ML1fxYU+E2xoKLXlXpvtEH6TazFzW6i6mO61b1UtLRLGvL5E0QtpawgLjG4ODk+NI5XapozaztWqRj1EuqNqDszt6K61mamgjctNEscGV3RXAB0lPuL+bmn7Uf/aCGrPMqqIQLBXm5bYIEVPpWPSw7oF5/+8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bVc1vEmmmHCG/cWFYJgq/wwYqDpwW2pOkYNZhh+tVsQbCz7BGDcM90xLRKjI/JwtwatRL2o/LoMowTNw64qOhJMDi4T9ePtUG8BkiQAPBUYyR+eFUds0vZqnG28kYq/VnSlcpi1ro2lkaOIT4NuuvCBT+58yqN38pPWziP9mu/St4u5/S+Iyj5rzYuuHHSwwcWGO3le9G7jnrSlty5la29PmsYf4pOA+zVVBD8ct0V2RCxOXrSFXkeUJ0hCQaOb15NPPYHFgtiAiGknkh2p4/OSb/5Tt9fWQazvrA69oO9jqEDfMPgJO+m5BsH3cBmaD15o/buQq33ldba/bgDWrGE6Bh0ny0BcM9wm+fMIZXZ52NCPt7x77uRm0gzQNF42U3Fj/qI6MA9BPCg16EcXtvE3FBlpq2H7K+8RONj+mocbv9zoJfelf3xvTSSeBZsAy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:41:50.5139 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e64eee-5494-439f-994d-08df0f5a69c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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



On 2026-09-04 05:07, Maxime Ripard wrote:
> The amdgpu display manager crtc implementation provides a custom reset
> hook. However, this hook only allocates the state, initializes it with
> __drm_atomic_helper_crtc_reset(), and frees the previous state. It
> does not perform any hardware reset.
> 
> Since this is exactly what the atomic_create_state hook is meant to
> do, minus the old state cleanup which the caller handles, convert the
> implementation to use atomic_create_state with
> __drm_atomic_helper_crtc_state_init() instead.
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 31 +++++++++++++++-------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h |  2 +-
>  .../display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c  | 23 ++++++++--------
>  3 files changed, 33 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 62eac6e65334..53910056da20 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -473,24 +473,23 @@ static void amdgpu_dm_crtc_destroy(struct drm_crtc *crtc)
>  
>  	drm_crtc_cleanup(crtc);
>  	kfree(crtc);
>  }
>  
> -STATIC_IFN_KUNIT void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc)
> +STATIC_IFN_KUNIT struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *crtc)
>  {
>  	struct dm_crtc_state *state;
>  
>  	state = kzalloc_obj(*state);
>  	if (!state)
> -		return;
> +		return ERR_PTR(-ENOMEM);
>  
> -	if (crtc->state)
> -		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
> +	__drm_atomic_helper_crtc_state_init(&state->base, crtc);
>  
> -	__drm_atomic_helper_crtc_reset(crtc, &state->base);
> +	return &state->base;
>  }
> -EXPORT_IF_KUNIT(amdgpu_dm_crtc_reset_state);
> +EXPORT_IF_KUNIT(amdgpu_dm_crtc_create_state);
>  
>  #ifdef CONFIG_DEBUG_FS
>  static int amdgpu_dm_crtc_late_register(struct drm_crtc *crtc)
>  {
>  	crtc_debugfs_init(crtc);
> @@ -563,11 +562,11 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc *crtc,
>  }
>  #endif
>  
>  /* Implemented only the options currently available for the driver */
>  static const struct drm_crtc_funcs amdgpu_dm_crtc_funcs = {
> -	.reset = amdgpu_dm_crtc_reset_state,
> +	.atomic_create_state = amdgpu_dm_crtc_create_state,
>  	.destroy = amdgpu_dm_crtc_destroy,
>  	.set_config = drm_atomic_helper_set_config,
>  	.page_flip = drm_atomic_helper_page_flip,
>  	.atomic_duplicate_state = amdgpu_dm_crtc_duplicate_state,
>  	.atomic_destroy_state = amdgpu_dm_crtc_destroy_state,
> @@ -779,13 +778,22 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>  
>  	amdgpu_dm_ism_init(&acrtc->ism, &default_ism_config);
>  
>  	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
>  
> -	/* Create (reset) the plane state */
> -	if (acrtc->base.funcs->reset)
> -		acrtc->base.funcs->reset(&acrtc->base);
> +	/* Create the plane state */

Looks like an existing typo, could you s/plane state/crtc state/ along with
this change?

Reviewed-by: Leo Li <sunpeng.li@amd.com>

Thanks!
- Leo

> +	if (acrtc->base.funcs->atomic_create_state) {
> +		struct drm_crtc_state *crtc_state;
> +
> +		crtc_state = acrtc->base.funcs->atomic_create_state(&acrtc->base);
> +		if (IS_ERR(crtc_state)) {
> +			res = PTR_ERR(crtc_state);
> +			goto error_ism_fini;
> +		}
> +
> +		acrtc->base.state = crtc_state;
> +	}
>  
>  	acrtc->max_cursor_width = dm->adev->dm.dc->caps.max_cursor_size;
>  	acrtc->max_cursor_height = dm->adev->dm.dc->caps.max_cursor_size;
>  
>  	acrtc->crtc_id = crtc_index;
> @@ -813,10 +821,13 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>  #ifdef AMD_PRIVATE_COLOR
>  	dm_crtc_additional_color_mgmt(&acrtc->base);
>  #endif
>  	return 0;
>  
> +error_ism_fini:
> +	amdgpu_dm_ism_fini(&acrtc->ism);
> +	drm_crtc_cleanup(&acrtc->base);
>  fail:
>  	kfree(acrtc);
>  	kfree(cursor_plane);
>  	return res;
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
> index 93c6d0d8d7fd..ad516aeb9798 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.h
> @@ -47,11 +47,11 @@ bool amdgpu_dm_crtc_helper_mode_fixup(struct drm_crtc *crtc,
>  				      const struct drm_display_mode *mode,
>  				      struct drm_display_mode *adjusted_mode);
>  void amdgpu_dm_crtc_destroy_state(struct drm_crtc *crtc,
>  				  struct drm_crtc_state *state);
>  struct drm_crtc_state *amdgpu_dm_crtc_duplicate_state(struct drm_crtc *crtc);
> -void amdgpu_dm_crtc_reset_state(struct drm_crtc *crtc);
> +struct drm_crtc_state *amdgpu_dm_crtc_create_state(struct drm_crtc *crtc);
>  int amdgpu_dm_crtc_count_crtc_active_planes(struct drm_crtc_state *new_crtc_state);
>  void amdgpu_dm_crtc_update_crtc_active_planes(struct drm_crtc *crtc,
>  					      struct drm_crtc_state *new_crtc_state);
>  void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work);
>  void amdgpu_dm_idle_worker(struct work_struct *work);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
> index 4dacddd23878..20ae31d2bf6a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crtc_test.c
> @@ -1402,35 +1402,34 @@ static void dm_test_crtc_duplicate_state_copies_fields(struct kunit *test)
>  	KUNIT_EXPECT_TRUE(test, dm_dup->mpo_requested);
>  
>  	amdgpu_dm_crtc_destroy_state(crtc, dup);
>  }
>  
> -/* Tests for amdgpu_dm_crtc_reset_state() */
> +/* Tests for amdgpu_dm_crtc_create_state() */
>  
>  /**
> - * dm_test_crtc_reset_state_allocates_state - Test reset installs a fresh state
> + * dm_test_crtc_create_state_allocates_state - Test create_state allocates a fresh state
>   * @test: The KUnit test context
>   *
> - * Resetting a CRTC with no existing state must allocate and install a new
> - * drm_crtc_state.
> + * Creating state for a CRTC must allocate a new drm_crtc_state.
>   */
> -static void dm_test_crtc_reset_state_allocates_state(struct kunit *test)
> +static void dm_test_crtc_create_state_allocates_state(struct kunit *test)
>  {
>  	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
> +	struct drm_crtc_state *crtc_state;
>  	struct drm_crtc *crtc;
>  
>  	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
>  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc);
>  	crtc->dev = &adev->ddev;
>  	crtc->state = NULL;
>  
> -	amdgpu_dm_crtc_reset_state(crtc);
> +	crtc_state = amdgpu_dm_crtc_create_state(crtc);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, crtc_state);
>  
> -	KUNIT_EXPECT_NOT_NULL(test, crtc->state);
> -
> -	if (crtc->state)
> -		amdgpu_dm_crtc_destroy_state(crtc, crtc->state);
> +	if (!IS_ERR(crtc_state))
> +		amdgpu_dm_crtc_destroy_state(crtc, crtc_state);
>  }
>  
>  /* Tests for amdgpu_dm_crtc_destroy_state() */
>  
>  /**
> @@ -1905,12 +1904,12 @@ static struct kunit_case amdgpu_dm_crtc_tests[] = {
>  	/* amdgpu_dm_crtc_count_crtc_active_planes */
>  	KUNIT_CASE(dm_test_count_crtc_active_planes_none),
>  	KUNIT_CASE(dm_test_count_crtc_active_planes_mixed),
>  	/* amdgpu_dm_crtc_duplicate_state */
>  	KUNIT_CASE(dm_test_crtc_duplicate_state_copies_fields),
> -	/* amdgpu_dm_crtc_reset_state */
> -	KUNIT_CASE(dm_test_crtc_reset_state_allocates_state),
> +	/* amdgpu_dm_crtc_create_state */
> +	KUNIT_CASE(dm_test_crtc_create_state_allocates_state),
>  	/* amdgpu_dm_crtc_destroy_state */
>  	KUNIT_CASE(dm_test_crtc_destroy_state_no_stream),
>  	KUNIT_CASE(dm_test_crtc_destroy_state_releases_stream),
>  	/* amdgpu_dm_crtc_handle_vblank */
>  	KUNIT_CASE(dm_test_crtc_handle_vblank_no_event),
> 

