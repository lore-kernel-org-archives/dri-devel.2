Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B56C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 03:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1758E10E11C;
	Wed, 15 Jul 2026 03:25:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="a9nFnHOA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2546510E11B;
 Wed, 15 Jul 2026 03:25:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D7DB600BB;
 Wed, 15 Jul 2026 03:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731DB1F000E9;
 Wed, 15 Jul 2026 03:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784085900;
 bh=jxiltSPYUvPydryUh4Z+BA9e7i6Gd73pT+TO6aqS/jc=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=a9nFnHOAWAL/IfU/rO/iwkNtCVDlL/kYUGawZyf7RsGv1A7Xe4QGsvHGtlpCfEYy2
 XQOWuYRpmy/hlUe9pDDiKJvl3cKKm8Kc3fwOcbUNjeawi8PvWfNGSrTbiNlmG+71Ft
 wz9+UEJCklZoO0SHoVREaJNdMd2SyqxvT6nL6YlBq7koXgoYzEOvbaJJzQHdAvXXcV
 2tzumr5fA0Uvn2bIwlHp9AZlK9oFiMFOyl1e5bX9TFsUFLH/kR6VTBFCpwm1www3uW
 ojFgTLvPsFHtC+6FWkYG9Qg/4DrcGUsWVHZwt35iiC1DAmeZoJ0SDZ7TkTErTgF2c6
 YKxW68ozYN37w==
Message-ID: <a72d0fca-b938-4e6a-b994-6c84d315a6ed@kernel.org>
Date: Tue, 14 Jul 2026 22:24:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix writeback completion timing
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>
References: <20260711033159.3096477-1-alex.hung@amd.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, mwen@igalia.com, tzimmermann@suse.de, ray.wu@amd.com,
 jpeisach@ubuntu.com, cristian.ciocaltea@collabora.com,
 timur.kristof@gmail.com, ivan.lipski@amd.com, chen-yu.chen@amd.com,
 srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260711033159.3096477-1-alex.hung@amd.com>
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



On 7/10/26 22:31, Alex Hung wrote:
> [WHY]
> The out fence was signalled on the first vblank after arming, before the
> DMA finished copying, and the old code worked around this with an
> mdelay() in the IRQ handler.
> 
> [HOW]
> Hold a vblank reference while writeback is pending and signal the out
> fence on the second vblank instead of using mdelay(). Add
> amdgpu_dm_crtc_complete_writeback() to finish and clean up writeback
> from both the IRQ and teardown paths.
> 
> This can be verified by running IGT's kms_writeback 20 times without
> timeout errors.
> 
> Assisted-by: Copilot:Claude-Opus-4.8
> Signed-off-by: Alex Hung <alex.hung@amd.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  1 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 33 ++++++++++---------
>   3 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> index 8069fc41cc7f..7c784277396a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> @@ -509,6 +509,7 @@ struct amdgpu_crtc {
>   	struct drm_pending_vblank_event *event;
> 
>   	bool wb_pending;
> +	bool wb_frame_done;
>   	bool wb_enabled;
>   	struct drm_writeback_connector *wb_conn;
>   };
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index d67dcaa3fa8f..0f5453649200 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4521,6 +4521,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
>   	spin_lock_irqsave(&acrtc->wb_conn->job_lock, flags);
>   	pending = acrtc->wb_pending;
>   	acrtc->wb_pending = false;
> +	acrtc->wb_frame_done = false;
>   	spin_unlock_irqrestore(&acrtc->wb_conn->job_lock, flags);
> 
>   	if (!pending)
> @@ -4988,6 +4989,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
>   	 * cannot run its matching vblank_put before this get.
>   	 */
>   	WARN_ON(drm_crtc_vblank_get(&acrtc->base));
> +	acrtc->wb_frame_done = false;
>   	acrtc->wb_pending = true;
>   }
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> index c5467f34c51f..4de7fb264cb2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -1974,23 +1974,26 @@ static void dm_crtc_high_irq(void *interrupt_params)
>   		return;
> 
>   	if (acrtc->wb_conn && acrtc->wb_pending) {
> -		struct dc_stream_state *stream = acrtc->dm_irq_params.stream;
> -		unsigned int v_total, refresh_hz;
> -
> -		v_total = stream->adjust.v_total_max ?
> -			  stream->adjust.v_total_max : stream->timing.v_total;
> -		refresh_hz = div_u64((uint64_t) stream->timing.pix_clk_100hz *
> -			     100LL, (v_total * stream->timing.h_total));
> -		mdelay(1000 / refresh_hz);
> -
> -		/*
> -		 * Completion (signalling the out fence and releasing the vblank
> -		 * reference taken in dm_set_writeback()) is handled by the shared
> -		 * helper, which is also used by the teardown path.
> -		 */
> -		if (amdgpu_dm_crtc_complete_writeback(acrtc))
> +		if (acrtc->wb_frame_done) {
> +			/*
> +			 * Second vblank: the DMA for the captured frame has
> +			 * had a full frame period to flush to memory. Signal
> +			 * the out fence now.
> +			 */
> +			amdgpu_dm_crtc_complete_writeback(acrtc);
> +		} else {
> +			/*
> +			 * First vblank after arming: the frame has been
> +			 * scanned out and the DMA is finishing. Disable
> +			 * writeback immediately to prevent the hardware from
> +			 * starting a new capture that would overwrite the
> +			 * buffer. Signal completion on the next vblank to
> +			 * ensure the DMA is fully flushed to memory.
> +			 */
>   			dc_stream_fc_disable_writeback(adev->dm.dc,
>   						       acrtc->dm_irq_params.stream, 0);
> +			acrtc->wb_frame_done = true;
> +		}
>   	}
> 
>   	vrr_active = amdgpu_dm_crtc_vrr_active_irq(acrtc);
> --
> 2.43.0
> 

