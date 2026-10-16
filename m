Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADA4CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AB610E295;
	Fri, 16 Oct 2026 16:41:42 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013019.outbound.protection.outlook.com
 [40.93.196.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBF310E295;
 Fri, 16 Oct 2026 16:41:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og/93g6DH6OoV5axKAOwCShrui3IzgJlAXsqGiM03+2JAn1G8MX9vbLsnQ5er37GgETFYm44RAv4nSZFMPz93AnLLJlh7yk2sM7lUTv0A82CyrNGxbdH8CFKQlLKdSRE9EIOFReH9XWxYJPWe6o6srhBsqOYYnGTpvjmRcEfvkoAFEGgMlYQNRr0WhZLve2HiM4z48LrSFmkEYu8kxW8oPyA/T1ofRe3lfogbVIjIgf/+dxfNO++6QB0M1Hl4oB5fLOLjEQwRUxSAQKna95JqYxfovaucfXNGm149SwLwu3WY1SNTJlXIq3DRzOrlR2MS5EyjkRqBysGjmd+a1/V2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deNKdklYKTmrFyD47WeP+uIYKBhzvhnbnMPzXZl08co=;
 b=GCzM6RjaNr6/a86qSoMLfkVe3yQCPYwl1InlEXMErS4gt3K3HSUt27bDJcdouOg7GH8K5VB8wn1O41DiqBigBsOY9+025DGCYIyo/DaBJgs6+rgzmz+9vIBc/5TsxRkjzORmy14FqMsQFZhwMw1Ol0PZtgD6j3MEUm6XFacDNwYORvyG9EITmPdHUHpiCxLzCvwA/rl7G0heQWbQkFBgCJ1dvZngFzemBs/0g0L/Vd/vFMuEFVEGo3vITFFB72rbfouafcdeh+QWXiHP8lZdvCH9Bg4r+KGQ1a07GjnI/GJ3aRpzmSXftYJAIqFnVFsVT2dyXUzzM3loF3pB8ETCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deNKdklYKTmrFyD47WeP+uIYKBhzvhnbnMPzXZl08co=;
 b=MMMIGuzarbG3S70SOKrEScTJ4GdnvcOA58PmcvEbNqdeTCAOLrUnf/gKtk8khpn8CyofEWxqma7c+x+E1WmP/+VoJZrrBlPJtMkxd/rGYDL8ao2MmniEsN9fWEk1Bo0kcvLFPMRSGKwpT7yxTQkbHCtxQY3xvScUw1WIlWwvqoc=
Received: from BY3PR10CA0013.namprd10.prod.outlook.com (2603:10b6:a03:255::18)
 by SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 16:41:30 +0000
Received: from MW2PEPF00014677.namprd04.prod.outlook.com
 (2603:10b6:a03:255:cafe::52) by BY3PR10CA0013.outlook.office365.com
 (2603:10b6:a03:255::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 16:41:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW2PEPF00014677.mail.protection.outlook.com (10.167.249.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 16:41:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 11:41:22 -0500
Received: from [10.254.92.30] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 11:41:21 -0500
Message-ID: <c90274b0-1488-4a76-9234-892c22b2c084@amd.com>
Date: Fri, 16 Oct 2026 12:41:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/75] drm/amdgpu: dm: Switch to
 drm_atomic_helper_connector_create_state
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 <amd-gfx@lists.freedesktop.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-4-586c9c026823@kernel.org>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-4-586c9c026823@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PEPF00014677:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: f007696a-4fbd-4c3b-114a-08df2ba4544a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|42112799006|376014|36860700016|23010399003|22082099003|18002099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: PnP81lq2hnx3DRIQu72mkZWzbtkcwmvULp5HonUtY5+cKUuCP/kkN4srAzzicEf5/QChcEUcyWkIlFJXAJNN+3pTT44kjxtvNdgj/0c6H1dVdrHAdso1DIXU/Qs1BDk3Csq36wUrerD/FWiiPbK+nwre4kQwriIfHsLjAi4qlW1L+Hk/gbZuS4eUsH91hAtmoQItNGrj4f0XuQLPBiKs+XlwmR+jHPw9pipOjTCDsIF5SlYJIKDmPjDZgUKdcc8LGDRlqkgDIR0TvLeX/T5cHRWCiyP1wx83aJ/0/0GqzF33kLJGLtZlcPaQbvSvlMIh0mwP+kgMwVRcItejLBByqc5nbem4Q/wZZBK5awVaalldJyHk/hdwZjvNt5H6KdqyUnYlF/dVGw9iDqSKj5aL4v8ASNxzIppQjmdMMiTEI7Bgjj5Ggrdk1xC7ehKk4EZiXmLJaDAmbPFA5WXaaostLQ0I6xfCSYPKQayL6uNbFzkjL4Ph3UFL8JPoym/QyUEfQ1ScHByiStP2IYIIU6LR2OR7aHNQMOtSANFWfW7PEqx07Kw+LHwJDNJavBkObJSiuI84Hk6OapX/zAQOez56ZAkDjQydmn7jOQBt5McTJQMvYahRtcm18/0stm2jy0qYKwkorPa/yx2jp0GGLhgseMzKIgjyobTRFh4WZKGs7BTycnsVBnDoK/AoBGfaxBMgOjtCKFWZmIKUiBu9M0JDXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(42112799006)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xNQfIWaXGuBHrY24H1Pwr1hCy8w4hCdiNNpcnARNkcQJue1/KCrDMtJVnXmE6hoXremg02x0r0PcNv43gnIsyRJsN9LjXDAJY9jHhcWsLAmMFMHULH48pGY5NVlV1m+jbJBkoc/8dk82AuJwLymeTQnjqO5DPb7uGEBYAJVURQye5nntIQqqHemZvDdAm8CCPrseOMVpEkh1mHgmxLe18GDr3vFx4BWUSFxGffJBTbhKqZIwYehyK8jH0629z1m9J9jaCU11dc/1mVIv++ntfk4IraqKDwtDAWZepG26VWuWVqmEEaXlHxX+p7M1vMobCDkvG5ILd4z8IvgSUXSEHP7D22pKs0Ci8REUewHGBCtrnQken3vW7oDRt+Cxt0hDS9AgOa5zM6j3BQCBS6fmZGsxMMuAa1/j879/betkQRxZsV2Jmd4wSjznDESO2gCV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 16:41:29.7292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f007696a-4fbd-4c3b-114a-08df2ba4544a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2PEPF00014677.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
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



On 2026-10-14 13:26, Maxime Ripard wrote:
> The amdgpu: dm connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Leo Li <sunpeng.li@amd.com>

> ---
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Rodrigo Siqueira <siqueira@igalia.com>
> Cc: amd-gfx@lists.freedesktop.org
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c | 2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c   | 7 ++++---
>  .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c   | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c | 4 ++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c    | 2 +-
>  7 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
> index 040a7a9c0335..9d83b7b1ca80 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_audio_test.c
> @@ -25,11 +25,11 @@
>  #include "amdgpu_dm.h"
>  #include "amdgpu_dm_audio.h"
>  #include "amdgpu_dm_kunit_test_helpers.h"
>  
>  static const struct drm_connector_funcs dm_test_audio_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
>  };
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> index 5221050dec2f..6e9ee3c93943 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_backlight_test.c
> @@ -30,11 +30,11 @@ struct dm_backlight_connector_fixture {
>  	struct amdgpu_dm_connector *aconnector;
>  	struct dc_link *link;
>  };
>  
>  static const struct drm_connector_funcs dm_backlight_test_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  static void setup_test_connector(struct kunit *test,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
> index 29a513dab9cd..e47b4dd210b8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
> @@ -173,11 +173,11 @@ static struct amdgpu_crtc *dm_test_alloc_crc_crtc(struct kunit *test,
>  
>  	return acrtc;
>  }
>  
>  static const struct drm_connector_funcs dm_test_crc_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
>  };
> @@ -652,12 +652,13 @@ static void dm_test_crtc_set_crc_source_dprx_no_connector(struct kunit *test)
>  	KUNIT_ASSERT_EQ(test, drm_connector_init(&adev->ddev, wb_conn,
>  						 &dm_test_crc_connector_funcs,
>  						 DRM_MODE_CONNECTOR_WRITEBACK), 0);
>  	KUNIT_ASSERT_EQ(test, kunit_add_action_or_reset(test,
>  			dm_test_crc_connector_cleanup, wb_conn), 0);
> -	drm_atomic_helper_connector_reset(wb_conn);
> -	KUNIT_ASSERT_NOT_NULL(test, wb_conn->state);
> +
> +	wb_conn->state = drm_atomic_helper_connector_create_state(wb_conn);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, wb_conn->state);
>  	wb_conn->state->crtc = &acrtc->base;
>  	/*
>  	 * __drm_atomic_helper_connector_destroy_state() drops a connector
>  	 * reference when state->crtc is set. Balance it here since the CRTC is
>  	 * assigned directly rather than via drm_atomic_set_crtc_for_connector(),
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
> index 51c3995de76d..a369a3cbd4af 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
> @@ -4104,11 +4104,11 @@ static void dm_test_is_dp_sink_present_queries_link_service(struct kunit *test)
>   * drm_edid_connector_update(), which needs a fully initialised connector so the
>   * EDID property blob is published. dm_kunit_alloc_connector() only fills in the
>   * device pointer, so build a real one here.
>   */
>  static const struct drm_connector_funcs dm_test_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  };
>  
>  static struct amdgpu_dm_connector *dm_test_alloc_real_connector(struct kunit *test,
>  								struct amdgpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
> index dc7d94f75ff4..3265b50abb46 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
> @@ -479,11 +479,11 @@ static void dm_test_destroy_hpd_rx_wq(void *data)
>  			destroy_workqueue(ctx->wq[i].wq);
>  	kfree(ctx->wq);
>  }
>  
>  static const struct drm_connector_funcs dm_test_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
>  };
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
> index 382eafab2d43..10a213c36af4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
> @@ -1160,11 +1160,11 @@ static bool dm_mst_test_dp_get_max_link_enc_cap(const struct dc_link *link,
>  static void dm_mst_test_connector_destroy(struct drm_connector *connector)
>  {
>  }
>  
>  static const struct drm_connector_funcs dm_mst_test_connector_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.destroy = dm_mst_test_connector_destroy,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
> @@ -3698,11 +3698,11 @@ static void dm_mst_test_pre_compute_configs_no_recompute(struct kunit *test)
>  }
>  
>  /* Tests for compute_mst_dsc_configs_for_link */
>  
>  static const struct drm_connector_funcs dm_mst_test_dsc_link_conn_funcs = {
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  static enum dp_link_encoding dm_mst_test_mst_encoding_format(const struct dc_link *link)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> index 03036f906385..e1e7d4c29966 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
> @@ -385,11 +385,11 @@ static void dm_test_wb_atomic_check_invalid_format(struct kunit *test)
>  /* Tests for amdgpu_dm_wb_connector_get_modes using DRM mock */
>  
>  static const struct drm_connector_funcs dm_wb_test_connector_funcs = {
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  };
>  
>  /**
>   * dm_test_wb_get_modes_returns_modes - Verify at least one mode is returned
>   * @test: KUnit test context
> 

