Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B09C5AC82
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 16:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E24C10E440;
	Fri,  7 Aug 2026 16:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GKikgYRI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AF910E43D;
 Fri,  7 Aug 2026 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=qMu5Jepob1wFmejFXAul5F+5vXKDKs6DFRi95JBEbzI=; b=GKikgYRIpBcAETfJPMDxyBWiDF
 JqpBienzHFRAR/ooWI/WZwdVFIiM1LKmcxA6kjRHBLqFBANRUz9Id2zg0px/qYvYI+ickGudpuTjM
 YHqCBWfZ6l94VJ1YnxUB1rmBVRs5WXn/onmZnjIc8uBqGY7Y7CRqB0JBrXdTFXk3SFyVzfZbNnYC4
 4Uhd1RfKl4Y9kYzYFZHwTg7voHDxvwE6KMHe6Is+6aBV2oaRv8EnxXbXNro1lFWOBymvnq8iCuJAb
 xLv16vYGq4sNVcM7ewzp7FsVZHmi/eT/10dSWqzs/q9VM+nrHRDbGXs3mfYVVfrWcuSSXntK19Mv0
 ApGFI5ew==;
Received: from [31.4.128.48] (helo=[192.168.1.126])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wsNP5-00FWCy-OY; Fri, 07 Aug 2026 18:26:39 +0200
Message-ID: <833bafaf-0167-4515-93cd-0828776741d2@igalia.com>
Date: Fri, 7 Aug 2026 18:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL pointer dereference in
 amdgpu_dm_crtc_set_vblank()
To: Samuel Pitoiset <samuel.pitoiset@gmail.com>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org
References: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
Content-Language: en-US
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260807145855.83479-1-samuel.pitoiset@gmail.com>
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



On 07/08/2026 16:58, Samuel Pitoiset wrote:
> amdgpu_dm_crtc_set_vblank() dereferences acrtc_state->stream when
> vblank is enabled/queried from DRM_IOCTL_MODE_CRTC_GET_SEQUENCE before
> a stream is attached to it.
>
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> RIP: amdgpu_dm_crtc_set_vblank+0x6b/0x4d0 [amdgpu]
> Call Trace:
>   drm_vblank_enable
>   drm_vblank_get
>   drm_crtc_get_sequence_ioctl
>   drm_ioctl_kernel
>   drm_ioctl
>
> Reproduced by running VKCTS with WSI tests enabled on RADV.
>
> Guard the enable path on acrtc_state->stream being non-NULL, matching
> the existing checks in this function.
>
> Fixes: 34d66bc7ff10 ("drm/amd/display: Fix Xorg desktop unresponsive on Replay panel")
> Signed-off-by: Samuel Pitoiset <samuel.pitoiset@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 46d85457c77b..62eac6e65334 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -268,7 +268,7 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>   
>   	irq_type = amdgpu_display_crtc_idx_to_irq_type(adev, acrtc->crtc_id);
>   
> -	if (enable) {
> +	if (enable && acrtc_state->stream) {

LGTM.

Reviewed-by: Melissa Wen <mwen@igalia.com>

+AMD display folks for visibility

>   		struct dc *dc = adev->dm.dc;
>   		struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
>   		struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;

