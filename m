Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3522CD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 18:31:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 533B410E47E;
	Tue,  5 May 2026 18:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ifRVwDsy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90D8E10E47E;
 Tue,  5 May 2026 18:31:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 152DF60252;
 Tue,  5 May 2026 18:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE749C2BCC7;
 Tue,  5 May 2026 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778005888;
 bh=gYYIfVxyMYOTKL0flzFUkw7hx9P8PavzUHkURiUEO8Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ifRVwDsyRoZVKILIJJQtiSzCOIG/huwg24KWgaEY9zOUldSqp1ZFOwn2TjOeOC5TR
 sN4u+TdhZW2cq7WFwv7TnKGhLJZRpIBXDViAsi2pJJbmOyGxr2Vjtcv9MwwbeW7roZ
 u03YO9Mm6O1Wb/HJdRTv8qAuqWtHuWsJT3eA9FLiVFk6vtFIVp+oeOYRZLvXsd/9OY
 PhLAJf83emwuCe2PMQIHvRMIv4PMf82WBegMwgrRK6+Hc5T9HcJWXXHkJ3n7SK47E3
 vVKbCbtw51CbRJU1H33WOlIeJibmbsSjvusQIDDt6zQqAJJPyBOjFcMku0AitxAx+G
 pZ6+61KQFbibA==
Message-ID: <91481d36-db46-490d-8613-a46eaf462a9e@kernel.org>
Date: Tue, 5 May 2026 13:31:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] drm/amd/display: add DMU timeout recovery support
Content-Language: en-US
To: Hamza Mahfooz <someguy@effective-light.com>,
 dri-devel@lists.freedesktop.org
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Hung <alex.hung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Tom Chung <chiahsuan.chung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Takashi Iwai <tiwai@suse.de>, Colin Ian King <colin.i.king@gmail.com>,
 Charlene Liu <charlene.liu@amd.com>, Kees Cook <kees@kernel.org>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260505182105.420525-1-someguy@effective-light.com>
 <20260505182105.420525-2-someguy@effective-light.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260505182105.420525-2-someguy@effective-light.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 5/5/26 13:20, Hamza Mahfooz wrote:
> DMU already has robust hung state tracking, but timeout recovery
> was never hooked up, so do so now.
> 
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 13 ++++++++-----
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h   |  1 +
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c   | 12 ++++++++++--
>   3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e96a12ff2d31..763da9a9032d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1246,7 +1246,7 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
>   	}
>   }
>   
> -static int dm_dmub_hw_init(struct amdgpu_device *adev)
> +int amdgpu_dm_dmub_hw_init(struct amdgpu_device *adev)
>   {
>   	const struct dmcub_firmware_header_v1_0 *hdr;
>   	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
> @@ -1315,7 +1315,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>   	/* if adev->firmware.load_type == AMDGPU_FW_LOAD_PSP,
>   	 * amdgpu_ucode_init_single_fw will load dmub firmware
>   	 * fw_inst_const part to cw0; otherwise, the firmware back door load
> -	 * will be done by dm_dmub_hw_init
> +	 * will be done by amdgpu_dm_dmub_hw_init().
>   	 */
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
>   		memcpy(fb_info->fb[DMUB_WINDOW_0_INST_CONST].cpu_addr, fw_inst_const,
> @@ -1457,7 +1457,7 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
>   			drm_warn(adev_to_drm(adev), "Wait for DMUB auto-load failed: %d\n", status);
>   	} else {
>   		/* Perform the full hardware initialization. */
> -		r = dm_dmub_hw_init(adev);
> +		r = amdgpu_dm_dmub_hw_init(adev);
>   		if (r)
>   			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>   	}
> @@ -2041,6 +2041,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		goto error;
>   	}
>   
> +	adev->dm.dc->debug.enable_dmu_recovery =
> +		amdgpu_device_should_recover_gpu(adev);
> +
>   	if (amdgpu_dc_debug_mask & DC_DISABLE_PIPE_SPLIT) {
>   		adev->dm.dc->debug.force_single_disp_pipe_split = false;
>   		adev->dm.dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
> @@ -2090,7 +2093,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
>   		drm_info(adev_to_drm(adev), "DP-HDMI FRL PCON supported\n");
>   
> -	r = dm_dmub_hw_init(adev);
> +	r = amdgpu_dm_dmub_hw_init(adev);
>   	if (r) {
>   		drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>   		goto error;
> @@ -3604,7 +3607,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
>   		 */
>   		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
>   
> -		r = dm_dmub_hw_init(adev);
> +		r = amdgpu_dm_dmub_hw_init(adev);
>   		if (r) {
>   			drm_err(adev_to_drm(adev), "DMUB interface failed to initialize: status=%d\n", r);
>   			return r;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 74a8fe1a1999..dc808ee83c2a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1086,6 +1086,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
>   #define MAX_COLOR_LEGACY_LUT_ENTRIES 256
>   
>   void amdgpu_dm_init_color_mod(void);
> +int amdgpu_dm_dmub_hw_init(struct amdgpu_device *adev);
>   int amdgpu_dm_create_color_properties(struct amdgpu_device *adev);
>   int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state);
>   int amdgpu_dm_update_crtc_color_mgmt(struct dm_crtc_state *crtc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index 3b8ae7798a93..8f10117483e2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -33,6 +33,7 @@
>   #include <drm/drm_atomic.h>
>   #include <drm/drm_probe_helper.h>
>   #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>   #include <drm/drm_edid.h>
>   #include <drm/drm_fixed.h>
>   
> @@ -1165,8 +1166,15 @@ void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
>   
>   void dm_helpers_dmu_timeout(struct dc_context *ctx)
>   {
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
>   }
>   
>   void dm_helpers_smu_timeout(struct dc_context *ctx, unsigned int msg_id, unsigned int param, unsigned int timeout_us)

