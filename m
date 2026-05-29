Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B0ACD6E52
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 13:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9246210FF67;
	Fri, 29 May 2026 13:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HbuDu6gi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD85910E187;
 Fri, 29 May 2026 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780062404; x=1811598404;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=KahDASigffRrYNY2fcECjx0aBmuc/lCu2aotDwcoHh0=;
 b=HbuDu6giLhsMv81S3KduuJ8PaUmhDnSLGs5o8bwTEmSp2mvexP1eHtkG
 bb+VKubLGkJwqTT6x+gsJ+5wCDOz8OOWKYNWAD1Q50yLAU8RHheXFh7DP
 F6meR/bL6IPsIGDYMctJmmHBho0suluDtXM+nhO5LEByIhiw1dM5fDE/y
 EwBfV+x2KIfkWpgos7WtZp7T7vQ8nRy2LzXvWICpec9z6DMhaC2RVc17i
 YxSNjNWPyeBTCIDbaGkkCKZ/lCTFkjHYR6QPyCbPh1FOSqqBHqzTo3OX7
 UySvqSLRpeJIxXdO8ufIuzhE2UWQ15HDmCIP+tbt/+DfW5PZ8iI5y46n/ g==;
X-CSE-ConnectionGUID: skarcxdbQO6zDQ5oLLPuTQ==
X-CSE-MsgGUID: rOuONZ80QGCZ/i2y5oFyyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84800477"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84800477"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 06:46:43 -0700
X-CSE-ConnectionGUID: qs/w7OeFSaKMoNNE015oFw==
X-CSE-MsgGUID: 0cI2WQZgQ0qk3t7kkDhJUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="247950446"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.147])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 06:46:36 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Alex Hung <alex.hung@amd.com>, Melissa Wen <mwen@igalia.com>,
 airlied@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 simona@ffwll.ch, tzimmermann@suse.de
Cc: Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>, Xaver Hugl
 <xaver.hugl@kde.org>, Pekka Paalanen <pekka.paalanen@collabora.com>, Louis
 Chauvet <louis.chauvet@bootlin.com>, Matthew Schwartz
 <matthew.schwartz@linux.dev>, John Harrison <John.Harrison@Igalia.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry
 Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/atomic: only add states of active or transient
 active colorops
In-Reply-To: <e8aaf4da-8fb6-4d6a-95d6-563ac0562b49@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260526142940.504911-1-mwen@igalia.com>
 <20260526142940.504911-2-mwen@igalia.com>
 <e8aaf4da-8fb6-4d6a-95d6-563ac0562b49@amd.com>
Date: Fri, 29 May 2026 16:46:32 +0300
Message-ID: <4452e675c4853faf665b520a8932a960946206bb@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, 26 May 2026, Alex Hung <alex.hung@amd.com> wrote:
> On 5/26/26 08:17, Melissa Wen wrote:
>> Only consider affected colorop states those that are part of an active
>> color pipeline or a pipeline that is about to be activated or
>> deactivated in the same atomic commit, i.e., colorop is in the chain of
>> old/new plane color pipeline property. To cover color_pipeline
>> deactivation, remove the condition for plane_state->color_pipeline.
>> 
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   drivers/gpu/drm/drm_atomic.c | 67 +++++++++++++++++++++++++++++++-----
>>   1 file changed, 58 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
>> index 170de30c28ae..4fb3a23e862a 100644
>> --- a/drivers/gpu/drm/drm_atomic.c
>> +++ b/drivers/gpu/drm/drm_atomic.c
>> @@ -812,6 +812,59 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
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
>> +	for (colorop = new_plane_state->color_pipeline;
>> +	     colorop;
>> +	     colorop = colorop->next) {
>
> This for-loop is used 5 times in this patchset. How about a macro in 
> drm_colorop.h?
>
> #define drm_for_each_colorop_in_pipeline(colorop, pipeline) \
>      for ((colorop) = (pipeline); (colorop); (colorop) = (colorop)->next)

Is there a reason struct drm_colorop reinvents lists and doesn't have
struct list_head node?

BR,
Jani.

>
>> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
>> +		if (IS_ERR(colorop_state))
>> +			return PTR_ERR(colorop_state);
>> +	}
>> +
>> +	/* Same color pipeline as new; no point walking old. */
>> +	if (new_plane_state->color_pipeline == old_plane_state->color_pipeline)
>> +		return 0;
>> +
>> +	for (colorop = old_plane_state->color_pipeline;
>> +	     colorop;
>> +	     colorop = colorop->next) {
>> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
>> +		if (IS_ERR(colorop_state))
>> +			return PTR_ERR(colorop_state);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static void drm_atomic_colorop_print_state(struct drm_printer *p,
>>   					   const struct drm_colorop_state *state)
>>   {
>> @@ -1591,11 +1644,9 @@ drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
>>   		if (IS_ERR(plane_state))
>>   			return PTR_ERR(plane_state);
>>   
>> -		if (plane_state->color_pipeline) {
>> -			ret = drm_atomic_add_affected_colorops(state, plane);
>> -			if (ret)
>> -				return ret;
>> -		}
>> +		ret = drm_atomic_add_pipeline_colorops(state, plane);
>> +		if (ret)
>> +			return ret;
>>   	}
>>   	return 0;
>>   }
>> @@ -1607,10 +1658,8 @@ EXPORT_SYMBOL(drm_atomic_add_affected_planes);
>>    * @plane: DRM plane
>>    *
>>    * This function walks the current configuration and adds all colorops
>> - * currently used by @plane to the atomic configuration @state. This is useful
>> - * when an atomic commit also needs to check all currently enabled colorop on
>> - * @plane, e.g. when changing the mode. It's also useful when re-enabling a plane
>> - * to avoid special code to force-enable all colorops.
>> + * currently used by @plane to the atomic configuration @state. It's useful
>> + * when re-enabling a plane to avoid special code to force-enable all colorops.
>>    *
>>    * Since acquiring a colorop state will always also acquire the w/w mutex of the
>>    * current plane for that colorop (if there is any) adding all the colorop states for
>

-- 
Jani Nikula, Intel
