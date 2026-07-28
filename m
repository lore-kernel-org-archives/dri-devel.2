Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC16C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 16:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 414CE10E95C;
	Tue, 28 Jul 2026 16:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=robert.mader@collabora.com header.b="PSj+DAms";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E9810E95C;
 Tue, 28 Jul 2026 16:03:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785254582; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Byuc/icstFRxEGCpFFN+FqnTae6dXKewYi3gAxDcbHu7SyMPUDk3XIZa93hHyzl4+K2x+TtFnpzkWQDRbA+zzpf3vrES3q/Tghf6r6SiJAsXww060ENuNRTfWEf+roI8Gvam1Ki/lkg9ds3v94tl7Ot2zubmjSYDk/bXFqlev6A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785254582;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=/AeaeoddqIEzo8okowFkcxIZ2EkPYyK9azOsPwMBhNI=; 
 b=WGAq6yyBcUtpwyrPW3N0P0adRZPGlI4UUqhOfZRfSzzkoUeft+T1JwJmOgY33lmptCsRMKcfnvL5g3rzepg1YCO8unZMhJcTzkkWkOQxMbPy63AO+FlSYG2DHkdMRyehNL1bKYvVDwzR4uzKAN6gL89NrlUOBiX8neqZuXqpY4k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=robert.mader@collabora.com;
 dmarc=pass header.from=<robert.mader@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785254582; 
 s=zohomail; d=collabora.com; i=robert.mader@collabora.com;
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=/AeaeoddqIEzo8okowFkcxIZ2EkPYyK9azOsPwMBhNI=;
 b=PSj+DAms3VnH6dW3017dv7aI/T6609C1AfZQSN3y/tQjb4Phl5jq2p47yTdgpNtw
 lJNYYNqAYJZXqheJKvirN2dfoIlyIvht2ojUk3Z5ovBDshN9Q0frsR4gpVFITyeWr7b
 wU8g/TMCZh5kBPxvja2I9UhV4trwJVQSRPhK0FH8=
Received: by mx.zohomail.com with SMTPS id 1785254580381915.3907101853333;
 Tue, 28 Jul 2026 09:03:00 -0700 (PDT)
Message-ID: <c3a6cd6e-a510-424a-b2ea-108e3bc9242d@collabora.com>
Date: Tue, 28 Jul 2026 18:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] drm/amd/display: Check actual state during
 commit_tail
To: Harry Wentland <harry.wentland@amd.com>, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-10-harry.wentland@amd.com>
Content-Language: en-US, de-DE
From: Robert Mader <robert.mader@collabora.com>
In-Reply-To: <20260722134607.136293-10-harry.wentland@amd.com>
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

Tested-by: Robert Mader <robert.mader@collabora.com>

On 22.07.26 15:46, Harry Wentland wrote:
> Previously we checked the plane_state->state's plane_color_pipeline
> client config when determining whether fill_plane_color_attributes
> should run, i.e., whether we had a plane color pipeline and should
> use that code for handling fixed matrix properties, or whether we
> should look at legacy plane encoding and range.
>
> The problem is that we also call this during commit_tail, during
> which plane_state doesn't have the state backpointer. This meant
> that during commit_tail we'd look at the legacy plane COLOR_RANGE
> and COLOR_ENCODING values and overwrite what we pulled from the
> fixed matrix colorop in atomic_check previously.
>
> Instead pass the drm_atomic_state in explicitly and check that.
>
> Assisted-by:Claude:claude-sonnet-4.5
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 67b825cbb88f..b7d815997753 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2984,7 +2984,8 @@ STATIC_IFN_KUNIT bool modereset_required(struct drm_crtc_state *crtc_state)
>   EXPORT_IF_KUNIT(modereset_required);
>   
>   STATIC_IFN_KUNIT int
> -fill_plane_color_attributes(const struct drm_plane_state *plane_state,
> +fill_plane_color_attributes(struct drm_atomic_commit *state,
> +			    const struct drm_plane_state *plane_state,
>   			    const enum surface_pixel_format format,
>   			    enum dc_color_space *color_space)
>   {
> @@ -2993,7 +2994,7 @@ fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>   	*color_space = COLOR_SPACE_SRGB;
>   
>   	/* Ignore properties when DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE is set */
> -	if (plane_state->state && plane_state->state->plane_color_pipeline)
> +	if (state && state->plane_color_pipeline)
>   		return 0;
>   
>   	/* DRM color properties only affect non-RGB formats. */
> @@ -3034,6 +3035,7 @@ EXPORT_IF_KUNIT(fill_plane_color_attributes);
>   
>   static int
>   fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
> +			    struct drm_atomic_commit *state,
>   			    const struct drm_plane_state *plane_state,
>   			    const u64 tiling_flags,
>   			    struct dc_plane_info *plane_info,
> @@ -3127,7 +3129,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
>   
>   	plane_info->layer_index = plane_state->normalized_zpos;
>   
> -	ret = fill_plane_color_attributes(plane_state, plane_info->format,
> +	ret = fill_plane_color_attributes(state, plane_state, plane_info->format,
>   					  &plane_info->color_space);
>   	if (ret)
>   		return ret;
> @@ -3168,7 +3170,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
>   	dc_plane_state->clip_rect = scaling_info.clip_rect;
>   	dc_plane_state->scaling_quality = scaling_info.scaling_quality;
>   
> -	ret = fill_dc_plane_info_and_addr(adev, plane_state,
> +	ret = fill_dc_plane_info_and_addr(adev, plane_state->state, plane_state,
>   					  afb->tiling_flags,
>   					  &plane_info,
>   					  &dc_plane_state->address,
> @@ -4226,7 +4228,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
>   		}
>   
>   		fill_dc_plane_info_and_addr(
> -			dm->adev, new_plane_state,
> +			dm->adev, state, new_plane_state,
>   			afb->tiling_flags,
>   			&bundle->plane_infos[planes_count],
>   			&bundle->flip_addrs[planes_count].address,

-- 
Robert Mader
Consultant Software Developer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

