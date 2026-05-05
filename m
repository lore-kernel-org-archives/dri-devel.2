Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D1FCD3441
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 16:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AD210E449;
	Tue,  5 May 2026 16:12:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iHUcXtkd";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E3910E449;
 Tue,  5 May 2026 16:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNY/WqigPQR1PBfqZqb9uBHduNl+a/5Ct6Ne14xeBciknu/RG5XU4Gm8GcbbZanBrCLaXh3VbFGLB8PgqmUuqQmc9Y3abmpP6UsflZmkVrDLKnzc6EqcTcACLdlt5yHtl/Ot+UWQtFjj0HKx1G+cbA41IgWUpubNQ7SANZo6gs82bFrzYGgPLun2qNdRzjeuOT9ltmcJdknBOdsvlLwRjXdSkGuzvo7KtzkQ0O28K26pqk4OCOy2sKufiiIdKONVGZ78Uo4kzoWSHmwpoI6BgcGlcF49O30eFu10xXIQXhLmYQDZnzw8MnlsikHWYjwNsTG8zWnqZR59dgljKvmsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HM7HEB/dbZbiaWn7Um1BlYCV6qQz2oQrMa9tC/SeV+0=;
 b=ZyFlcPKpHKEhE5aQwzYH+HwquymisELPZnEPicJCw1s3Y2dGwH2k+2eYRITgrYM4vlCk0bIVXgFKrom4eITFTmgAAjkDYYLlrxwG3ILb0M1/kUKF85Tc8McSJfSzRSR7N+P2spXlEYfCZwAF+exkJDYdv13/DRbH7lG9pF8rYXip0IJ5/pljMkjG8IA5RI5mM9ZgGgsXFFJDebE+R1dRono5t3d9CtRef+Z7woDZyeKt9rYzwo0xMtVdUwIWodINbO1dhXi3DmZygEwlkA+Xb62IfDuMwELGHAJ4dDqJ4mIG5emEv+7/6QyOXR5fKb1e+f6eWfr9SdTw/nF8H1finw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=effective-light.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HM7HEB/dbZbiaWn7Um1BlYCV6qQz2oQrMa9tC/SeV+0=;
 b=iHUcXtkdezolSyaqsftKM9knt7JlZbkfij2Jd47Tojtq3wotH6vXleE301MruNvKuE6/H3Vzuv509oZ7Vy43O8PmEuM5YQcheQpMvzfIm+wwdMlVYh866dB/u+470jjmvvhA04f+1G3CsS2UIg1lhWakxTNxeU9QBHcOSnUJe7I=
Received: from PH7P220CA0119.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::6)
 by MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 16:11:49 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::cf) by PH7P220CA0119.outlook.office365.com
 (2603:10b6:510:32d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Tue,
 5 May 2026 16:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Tue, 5 May 2026 16:11:48 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 11:10:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 09:02:18 -0700
Received: from [10.254.92.56] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 5 May 2026 11:02:16 -0500
Message-ID: <d2ee9fb2-4b62-4ee3-9395-4a9f7c4e53bd@amd.com>
Date: Tue, 5 May 2026 12:02:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] drm/amd/display: add DMU timeout recovery support
To: Hamza Mahfooz <someguy@effective-light.com>,
 <dri-devel@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Hung <alex.hung@amd.com>, Ray Wu
 <ray.wu@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, =?UTF-8?Q?Timur_Krist=C3=B3f?=
 <timur.kristof@gmail.com>, "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>, Yussuf Khalil
 <dev@pp3345.net>, Tom Chung <chiahsuan.chung@amd.com>, Colin Ian King
 <colin.i.king@gmail.com>, Charlene Liu <charlene.liu@amd.com>,
 <amd-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20260501203552.749080-1-someguy@effective-light.com>
 <20260501203552.749080-2-someguy@effective-light.com>
Content-Language: en-US
From: Leo Li <sunpeng.li@amd.com>
In-Reply-To: <20260501203552.749080-2-someguy@effective-light.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2811176b-e39c-417f-c6d0-08deaac1030e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|42112799006|36860700016|1800799024|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: HU3joIxRP4VMDPM2Lh8pi2Pyc6LwyD+RRJrNHlg79R0O2KKZpk4mr3tuCkY4cwfkFN4pzm9w2Ok4qd8wc/+QtJ2IXDs0y1grJOufMslE1NgO0UW5dzAD98HD9N7kVt8IntWhBHwpl11crAbz77nVDA4xkY9dGI+VJmNrToRn6J8AfvEbdWnbdNKze+sSdMZdiWzsGmf0Gj4r7np7PEyZaam47PdcftZF/w0fH7/aQnFaNxsLOycqpPfxARUkjWCB/IuhQbiV2MMIJEKMJTgSvAJrur1Hqj7uzRuumEdtQn6/UzXS83qvbAJjIMjxrSxHwFZwz0slrRVD9hCbWFf9rQ7YTdYLsxvQusUn4WC0lbXbjM/FAOvS2n9d0v2YMD7/h4jU3nPFaGbfzBx9OTtFAsR6iGU78g877cS32cxkOZKViZ73f7n8clJU8zaYWFr0ZFCpVGLmvdZfHwgVq+Rx8U/u2XCWPF6ZiADhDsiWnynrrPDIpoUkNX3y2b/zte25JyJbIxixw0Eo9IZdnynJsWwx34zRuEo30ufRcaXHeoLyGcRFKQ3Xn5R2P7tJ8YFuG9QVacfsuqTlMN2P+EYEevIoj+wvwPZGxy+L8MQVmvymHno2mZW+tp5/a8Bmgv1Nn3XeeoOzXQZb26/NLcm52JEz3UyC0+b/tslLd/u3QI7T2xoHJWqG2QCA1EsuYkVk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(42112799006)(36860700016)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R5qGu6aUY3bOK2NYB1PiyKxafg+XPBOOCDqz7kJT10AxQISI7E3nITggVKQFq+PCtgb27qFkiMETUF0KS4a4cjgi4F4lvuopG1cvV+maZUXCtRuErb3P0ZdxN9Ygj8gl2YhO+lLgLhIE17hoKZ2TwmbW5v47VhLPBU5usx1k8oIFgMuI6I1d6d/O3WlwYHSPpVN5/fLzKWMC2KXSXdbuZicjvJ/3dGoXbQ++cC8gK1dg/CWFtG6iG/1RQLNTnhrz6Hgd426oKIWU0Z3GxY5qF/gKGGZsZAK8/v4H0gAUmBAZ+qjJ3w7a0n8/FiFyxlHVMAWFUC2mRHTSbrkq4jeJOToI/JiCrzndRDRiQ2c5twjOaDppBLImu33dKOmo7mwWcHeIOeovY22iyfUxPOi+5Y3gSiHTPqgAAJL1qqOHMKrOVQQ/G+DlTgMH4UTaLPtV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 16:11:48.9015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2811176b-e39c-417f-c6d0-08deaac1030e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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



On 2026-05-01 16:35, Hamza Mahfooz wrote:
> DMU already has robust hung state tracking, but timeout recovery
> was never hooked up, so do so now.
> 
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

Thanks for the patch Hamza, implementing a DMUB reset in dm_helpers_dmu_timeout() sounds like the right approach.
One comment inline.

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++++++++++++++-----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  1 +
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 12 ++++++++--
>  3 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e96a12ff2d31..7be4ebee1cb7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1246,7 +1246,7 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
>  	}
>  }
>  
> -static int dm_dmub_hw_init(struct amdgpu_device *adev)
> +int amdgpu_dm_dmub_hw_init(struct amdgpu_device *adev)
>  {
>  	const struct dmcub_firmware_header_v1_0 *hdr;
>  	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
> @@ -1315,7 +1315,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>  	/* if adev->firmware.load_type == AMDGPU_FW_LOAD_PSP,
>  	 * amdgpu_ucode_init_single_fw will load dmub firmware
>  	 * fw_inst_const part to cw0; otherwise, the firmware back door load
> -	 * will be done by dm_dmub_hw_init
> +	 * will be done by amdgpu_dm_dmub_hw_init().
>  	 */
>  	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>  		memcpy(fb_info->fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
> @@ -1457,7 +1457,7 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
>  			drm_warn(adev_to_drm(adev), "Wait for DMUB auto-load failed: %d\n", status);
>  	} else {
>  		/* Perform the full hardware initialization. */
> -		r = dm_dmub_hw_init(adev);
> +		r = amdgpu_dm_dmub_hw_init(adev);
>  		if (r)
>  			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>  	}
> @@ -2041,6 +2041,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  		goto error;
>  	}
>  
> +	adev->dm.dc->debug.enable_dmu_recovery =
> +		amdgpu_device_should_recover_gpu(adev);
> +
>  	if (amdgpu_dc_debug_mask & DC_DISABLE_PIPE_SPLIT) {
>  		adev->dm.dc->debug.force_single_disp_pipe_split = false;
>  		adev->dm.dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
> @@ -2090,7 +2093,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>  	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
>  		drm_info(adev_to_drm(adev), "DP-HDMI FRL PCON supported\n");
>  
> -	r = dm_dmub_hw_init(adev);
> +	r = amdgpu_dm_dmub_hw_init(adev);
>  	if (r) {
>  		drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>  		goto error;
> @@ -3604,7 +3607,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>  		 */
>  		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
>  
> -		r = dm_dmub_hw_init(adev);
> +		r = amdgpu_dm_dmub_hw_init(adev);
>  		if (r) {
>  			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>  			return r;
> @@ -9623,7 +9626,15 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
>  {
>  
>  	assert_spin_locked(&acrtc->base.dev->event_lock);
> -	WARN_ON(acrtc->event);
> +
> +	/*
> +	 * Compositors will refuse to make forward progress unless we send
> +	 * the previous flip's completion event.
> +	 */
> +	if (WARN_ON(acrtc->event)) {
> +		drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
> +		drm_crtc_vblank_put(&acrtc->base);
> +	}

I would expect this WARN_ON to occur only after the 10s flip_done timeout expires, allowing 'this' commit to progress with the previously armed acrtc->event and ->pflip_status from the previous commit ('this' commit would be gated by drm_atomic_helper_wait_for_dependencies).

In which case, we probably want to apply the same above hunk for the cursor path here and also raise a warning: https://elixir.bootlin.com/linux/v6.19.3/source/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c#L10170

- Leo

>  
>  	acrtc->event = acrtc->base.state->event;
>  
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 74a8fe1a1999..dc808ee83c2a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1086,6 +1086,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
>  #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
>  
>  void amdgpu_dm_init_color_mod(void);
> +int amdgpu_dm_dmub_hw_init(struct amdgpu_device *adev);
>  int amdgpu_dm_create_color_properties(struct amdgpu_device *adev);
>  int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
>  int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 3b8ae7798a93..8f10117483e2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -33,6 +33,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_fixed.h>
>  
> @@ -1165,8 +1166,15 @@ void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
>  
>  void dm_helpers_dmu_timeout(struct dc_context *ctx)
>  {
> -	// TODO:
> -	//amdgpu_device_gpu_recover(dc_context->driver-context, NULL);
> +	struct amdgpu_device *adev = ctx->driver_context;
> +
> +	lockdep_assert_held(&adev->dm.dc_lock);
> +
> +	drm_info(adev_to_drm(adev), "attempting firmware reset\n");
> +	if (amdgpu_dm_dmub_hw_init(adev))
> +		drm_dev_wedged_event(adev_to_drm(adev),
> +				     DRM_WEDGE_RECOVERY_REBIND |
> +				     DRM_WEDGE_RECOVERY_BUS_RESET, NULL);
>  }
>  
>  void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us)

