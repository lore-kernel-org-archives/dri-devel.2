Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C98CD8CA8
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:37:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3855610E1E7;
	Tue,  9 Jun 2026 11:37:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TPaRYscY";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C34E10E1E7
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Lmp2HnWVKAURLFKsayS01Kz9typFlwbfQDlo/cqzcHk=; b=TPaRYscYxuluP+kbRYNUNX93ua
 Oun9NDZdjW3e83tVBRJXP0PdUq16udMKTgLxqMutWhmNzjFgSJ3TdqCLSZwZhC2r6LCd/1UJE5aml
 te4UeU7ZZBvoIQAedU1jC94YQ890zxVFfG2xTTVN85VsSr4gSf0CXdX1wX8BdfhjpDH80t4xi2Sez
 1BOmzLqdn2zv7Y3n64f+d+F4oHPPvWlo5d0CKUXP866A0ykYSCAStPd54V19CuyXT3Y+q/zsgHQTt
 NoinERFEd74Oy5llp3JL5idVDbgTHGUlCcKeDbT/tbVyv1zj+vG4HcJm0L9Mm85OyfADgObTatRnW
 EY2j+Ubg==;
Received: from [79.117.146.159] (helo=[192.168.1.135])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wWulQ-00EudE-AN; Tue, 09 Jun 2026 13:37:00 +0200
Message-ID: <466cd4cc-c6ee-4538-8e71-94ace16f537e@igalia.com>
Date: Tue, 9 Jun 2026 13:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/atomic: only add states of active or transient
 active colorops
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
References: <20260604180457.1110110-2-mwen@igalia.com>
 <20260604182415.3E0601F00893@smtp.kernel.org>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260604182415.3E0601F00893@smtp.kernel.org>
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



On 04/06/2026 20:24, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [High] Adding old pipeline colorops to the atomic state on deactivation causes the AMD driver to incorrectly detect a deactivated pipeline as active.
It's actually pre-existent, the patch here is just adding another path 
to trigger a latent problem:
dm_plane_color_pipeline_active() doesn't check if the colorop is part of 
an active plane color pipeline, so, if the userspace changes 
COLOR_PIPELINE from A to Bypass but leaves colorops in A with BYPASS = 
true, the helper still considers this colorop active, even though it's 
not part of an active color pipeline.
>
> Pre-existing issues:
> - [High] Modifying a COLOROP property via the ATOMIC IOCTL fails to pull the associated plane into the atomic state, causing the update to be silently ignored by the driver.
It's fixed by another series that track individual colorop changes: 
https://lore.kernel.org/dri-devel/20260602215743.914265-1-mwen@igalia.com/
> - [High] Changing the COLOR_PIPELINE plane property does not pull the affected colorops into the atomic state unless a CRTC modeset is concurrently triggered.
This is covered by: 
https://lore.kernel.org/dri-devel/20260602215743.914265-1-mwen@igalia.com/
There is a gap in AMD display driver that can be solved by this series 
and a change in the way they detect affected colorops.

I'll send a series covering all this points, but in summary they are all 
pre-existent.

Melissa
> --
>
> commit c677eb54425763294f2391cd91e9253b70b8e880
> Author: Melissa Wen <mwen@igalia.com>
>
> drm/atomic: only add states of active or transient active colorops
>
> Only consider affected colorop states those that are part of an active
> color pipeline or a pipeline that is about to be activated or
> deactivated in the same atomic commit, i.e., colorop is in the chain of
> old/new plane color pipeline property. To cover color_pipeline
> deactivation, remove the condition for plane_state->color_pipeline.
>
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index 170de30c28ae4..0d36a955c4d43 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
> [ ... ]
>
>> @@ -812,6 +812,57 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>>   	return 0;
>>   }
>>   
>> +/*
>> + * This function walks old and new plane state color pipelines and adds all
>> + * colorops in use by @plane to the atomic configuration @state. This is useful
>> + * when an atomic commit needs to check all currently enabled or about to be
>> + * enabled colorop on @plane, e.g. when changing the mode. This also avoids
>> + * including colorop states that are not part of the atomic state.
>> + *
>> + * Returns:
>> + * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
>> + * then the w/w mutex code has detected a deadlock and the entire atomic
>> + * sequence must be restarted. All other errors are fatal.
>> + */
>> +static int
>> +drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
>> +				 struct drm_plane *plane)
>> +{
>> +	struct drm_colorop *colorop;
>> +	struct drm_colorop_state *colorop_state;
>> +	struct drm_plane_state *new_plane_state, *old_plane_state;
>> +
>> +	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
>> +	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
>> +
>> +	if (WARN_ON(!new_plane_state || !old_plane_state))
>> +		return -EINVAL;
>> +
>> +	drm_dbg_atomic(plane->dev,
>> +		       "Adding old+new pipeline colorops for [PLANE:%d:%s]\n",
>> +		       plane->base.id, plane->name);
>> +
>> +	drm_for_each_colorop_in_pipeline(colorop,
>> +					 new_plane_state->color_pipeline) {
>> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> [Severity: High]
> This is a pre-existing issue, but does modifying a colorop property via the
> atomic ioctl fail to pull the associated plane into the atomic state?
>
> The call to drm_atomic_get_colorop_state() successfully fetches and adds the
> colorop to the state:
>
> drivers/gpu/drm/drm_atomic.c:drm_atomic_get_colorop_state() {
>      ...
>      ret = drm_modeset_lock(&colorop->plane->mutex, state->acquire_ctx);
>      colorop_state = drm_atomic_helper_colorop_duplicate_state(colorop);
>      ...
> }
>
> However, it does not call drm_atomic_get_plane_state() to add the parent plane.
> When the standard driver commit path executes, it iterates only over planes
> present in the state:
>
> drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_commit_planes() {
>      ...
>      for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
>          ...
>          funcs->atomic_update(plane, state);
>      ...
> }
>
> Does this mean the driver's atomic_update hook is skipped, and the hardware is
> not programmed with the new colorop parameters unless userspace also modifies a
> plane property in the same commit?
>
>> +		if (IS_ERR(colorop_state))
>> +			return PTR_ERR(colorop_state);
>> +	}
>> +
>> +	/* Same color pipeline as new; no point walking old. */
>> +	if (new_plane_state->color_pipeline == old_plane_state->color_pipeline)
>> +		return 0;
>> +
>> +	drm_for_each_colorop_in_pipeline(colorop,
>> +					 old_plane_state->color_pipeline) {
>> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> [Severity: High]
> Does adding the old pipeline's colorops to the atomic state during deactivation
> cause issues with active pipeline detection?
>
> When the pipeline is being deactivated, the old colorops' bypass flags are
> untouched and remain false.
>
> In the AMD driver, dm_plane_color_pipeline_active() checks all colorops added
> to the state:
>
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:dm_plane_color_pipeline_active() {
>      ...
>      for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state, new_colorop_state, i) {
>          ...
>          if (!cstate->bypass)
>              return true;
>      }
> }
>
> Will this cause the driver to see the old colorops, incorrectly evaluate the
> deactivated pipeline as active, and attempt to program disabled hardware?
>
>> +		if (IS_ERR(colorop_state))
>> +			return PTR_ERR(colorop_state);
>> +	}
>> +
>> +	return 0;
>> +}
> [ ... ]
>
>> @@ -1591,11 +1642,9 @@ drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
>>   		if (IS_ERR(plane_state))
>>   			return PTR_ERR(plane_state);
>>   
>> -		if (plane_state->color_pipeline) {
>> -			ret = drm_atomic_add_affected_colorops(state, plane);
>> -			if (ret)
>> -				return ret;
>> -		}
>> +		ret = drm_atomic_add_pipeline_colorops(state, plane);
> [Severity: High]
> This is a pre-existing issue, but does changing the color pipeline plane
> property fail to pull the affected colorops into the atomic state if a CRTC
> modeset isn't triggered?
>
> The drm_atomic_add_pipeline_colorops() function is invoked here from
> drm_atomic_add_affected_planes(). However, this is only called when a modeset
> is occurring:
>
> drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_check_modeset() {
>      ...
>      if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
>          continue;
>      ...
>      ret = drm_atomic_add_affected_planes(state, crtc);
> }
>
> If userspace dynamically changes the color pipeline property on a plane as a
> standalone update without triggering a full CRTC modeset, will this bypass
> drm_atomic_add_affected_planes() entirely?
>
> Could this result in the colorops for the newly activated or deactivated
> pipeline never being added to the atomic commit state?
>
>> +		if (ret)
>> +			return ret;
>>   	}
>>   	return 0;
>>   }

