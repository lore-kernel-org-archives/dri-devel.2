Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED762CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B587710E5DE;
	Thu,  4 Jun 2026 09:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="rYffpsq4";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D737410E5DE;
 Thu,  4 Jun 2026 09:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vCL6XLGZbPYHzf24wiXSlcfpsWTswMCi57bgSjUSRoI=; b=rYffpsq4l6WVXkaoAtE8QC/tPy
 mgMzDBm8zOGq9jSbOpdypMaNbqm9IABImsNNMuSwhZivi1Tgbu4WuO6+pkPzum4QKUWlbt9DQChIc
 LYQtTItX6l66idKyxmYwQZCK0YA2jgslxD6WGAtDPCnDR0YHQ/GcCAabOQX2CGRwdp2NKOYRJKl5P
 s7H7mAyWp0ycEJ0s4x9d2gmxATrpZG4cH/WPLhSAvS7am4aTOwjDQMdZVKy6CGqE5rox8NTNEl7bj
 CWTFJOSPyJ5IJ+l/+RUbfnahhiiXuOAYetoutMUqBIVbcW+HXNOJPUALTdH9TqiT0tbINEqcWkhGW
 1bw/QwOA==;
Received: from [79.117.146.159] (helo=[192.168.1.135])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wV4ht-00CZqY-Qj; Thu, 04 Jun 2026 11:49:45 +0200
Message-ID: <cb66bacc-f8ff-4cc3-8663-c260fc34c744@igalia.com>
Date: Thu, 4 Jun 2026 11:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix mem_type change detection for async
 flips
To: Matthew Schwartz <matthew.schwartz@linux.dev>, Leo Li
 <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
References: <20260604064424.3154796-1-matthew.schwartz@linux.dev>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260604064424.3154796-1-matthew.schwartz@linux.dev>
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



On 04/06/2026 08:44, Matthew Schwartz wrote:
> [Why]
> amdgpu_dm_crtc_mem_type_changed() fetches the "old" and "new" plane state
> with two drm_atomic_get_plane_state() calls, which both return the new
> state. It compares a state against itself, so it never detects a mem_type
> change and never rejects the async flip.
>
> On DCN 3.0.1, this shows up as intermittent corruption when a single DCC
> plane is scanned out with immediate flips under gamescope and its buffer
> moves between the VRAM carveout and GTT.
>
> [How]
> Use drm_atomic_get_old_plane_state() and drm_atomic_get_new_plane_state()
> to compare the actual old and new states. These return NULL rather than
> an error pointer for a plane that is not part of the commit, so the
> IS_ERR() check becomes a NULL check that skips those planes, such as an
> unmodified cursor still in the CRTC's plane_mask.

Nice catch!

Reviewed-by: Melissa Wen <mwen@igalia.com>

>
> Fixes: 4caacd1671b7a ("drm/amd/display: Do not elevate mem_type change to full update")
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6c1e7e13f0399..711640739179e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12934,13 +12934,11 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
>   	struct drm_plane_state *new_plane_state, *old_plane_state;
>   
>   	drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
> -		new_plane_state = drm_atomic_get_plane_state(state, plane);
> -		old_plane_state = drm_atomic_get_plane_state(state, plane);
> +		new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +		old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>   
> -		if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
> -			drm_err(dev, "Failed to get plane state for plane %s\n", plane->name);
> -			return false;
> -		}
> +		if (!old_plane_state || !new_plane_state)
> +			continue;
>   
>   		if (old_plane_state->fb && new_plane_state->fb &&
>   		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))

