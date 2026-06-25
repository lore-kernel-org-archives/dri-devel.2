Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3FBCDE00C
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4196110E2C0;
	Thu, 25 Jun 2026 22:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="JFG0xNPI";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D300E10E2C0;
 Thu, 25 Jun 2026 22:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+xpz/3mR0vc8MZUDX2dWK/x9YYE2W9Z6zuZ1hivI4Fc=; b=JFG0xNPILkwiYY54VdZjej0/2a
 1BMr8ZXZRKZm9affvQYSmBPwPFO8tXABfgq3zhwGCeQuwjQzrGq+T5hE2t2h98lQTZktpHkIstRJA
 zDDb/2I5WmbLIBxP07TG1H4z+JLGVJftpQ/eCTTq1h7G9m3tVek3jgQfhCK6DnXZBgKrQAUL7nB2X
 ML6Y3gGiUzto0asaKS04xyIWx6ayC+BUIBc9LvQmB3qLCMINJOitdiO4W9gHoM/qW9dD8OcXNyLp8
 EgbiFbDVNGdVMZlPifMTeM6KyVm2u62mSxvqwIVHiW6yiL06YOSLUSMy5bqeieGuFmEkfXeuA3qew
 PaE/YFUQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=[192.168.1.133]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wcsZ4-005FfL-9L; Fri, 26 Jun 2026 00:28:54 +0200
Message-ID: <140cad50-d1fc-416e-ba84-453e1a2000c4@Igalia.com>
Date: Thu, 25 Jun 2026 15:28:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] drm/atomic: only add states of active or transient
 active colorops
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260609121230.1358786-1-mwen@igalia.com>
 <20260609121230.1358786-2-mwen@igalia.com>
Content-Language: en-GB
From: John Harrison <John.Harrison@Igalia.com>
In-Reply-To: <20260609121230.1358786-2-mwen@igalia.com>
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

On 6/9/26 13:51, Melissa Wen wrote:
> Only consider affected colorop states those that are part of an active
> color pipeline or a pipeline that is about to be activated or
> deactivated in the same atomic commit, i.e., colorop is in the chain of
> old/new plane color pipeline property. To cover color_pipeline
> deactivation, remove the condition for plane_state->color_pipeline.
>
> Signed-off-by: Melissa Wen <mwen@igalia.com>
> ---
>
> v2: define a macro to walk in the color pipeline (Alex H.)
> ---
>   drivers/gpu/drm/drm_atomic.c | 65 +++++++++++++++++++++++++++++++-----
>   include/drm/drm_colorop.h    |  3 ++
>   2 files changed, 59 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3af1b9cc9a06..464562861408 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -892,6 +892,57 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
>   	return 0;
>   }
>   
> +/*
> + * This function walks old and new plane state color pipelines and adds all
> + * colorops in use by @plane to the atomic configuration @state. This is useful
> + * when an atomic commit needs to check all currently enabled or about to be
> + * enabled colorop on @plane, e.g. when changing the mode. This also avoids
> + * including colorop states that are not part of the atomic state.
> + *
> + * Returns:
> + * 0 on success or can fail with -EDEADLK or -ENOMEM. When the error is EDEADLK
> + * then the w/w mutex code has detected a deadlock and the entire atomic
> + * sequence must be restarted. All other errors are fatal.
> + */
> +static int
> +drm_atomic_add_pipeline_colorops(struct drm_atomic_commit *state,
> +				 struct drm_plane *plane)
> +{
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *colorop_state;
> +	struct drm_plane_state *new_plane_state, *old_plane_state;
> +
> +	new_plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	old_plane_state = drm_atomic_get_old_plane_state(state, plane);
> +
> +	if (WARN_ON(!new_plane_state || !old_plane_state))
> +		return -EINVAL;
> +
> +	drm_dbg_atomic(plane->dev,
> +		       "Adding old+new pipeline colorops for [PLANE:%d:%s]\n",
> +		       plane->base.id, plane->name);
> +
> +	drm_for_each_colorop_in_pipeline(colorop,
> +					 new_plane_state->color_pipeline) {
> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +	}
> +
> +	/* Same color pipeline as new; no point walking old. */
> +	if (new_plane_state->color_pipeline == old_plane_state->color_pipeline)
> +		return 0;
> +
> +	drm_for_each_colorop_in_pipeline(colorop,
> +					 old_plane_state->color_pipeline) {
> +		colorop_state = drm_atomic_get_colorop_state(state, colorop);
> +		if (IS_ERR(colorop_state))
> +			return PTR_ERR(colorop_state);
> +	}
> +
> +	return 0;
> +}
> +
>   static void drm_atomic_colorop_print_state(struct drm_printer *p,
>   					   const struct drm_colorop_state *state)
>   {
> @@ -1671,11 +1722,9 @@ drm_atomic_add_affected_planes(struct drm_atomic_commit *state,
>   		if (IS_ERR(plane_state))
>   			return PTR_ERR(plane_state);
>   
> -		if (plane_state->color_pipeline) {
> -			ret = drm_atomic_add_affected_colorops(state, plane);
> -			if (ret)
> -				return ret;
> -		}
> +		ret = drm_atomic_add_pipeline_colorops(state, plane);
> +		if (ret)
> +			return ret;
>   	}
>   	return 0;
>   }
> @@ -1687,10 +1736,8 @@ EXPORT_SYMBOL(drm_atomic_add_affected_planes);
>    * @plane: DRM plane
>    *
>    * This function walks the current configuration and adds all colorops
> - * currently used by @plane to the atomic configuration @state. This is useful
> - * when an atomic commit also needs to check all currently enabled colorop on
> - * @plane, e.g. when changing the mode. It's also useful when re-enabling a plane
> - * to avoid special code to force-enable all colorops.
> + * currently used by @plane to the atomic configuration @state. It's useful
> + * when re-enabling a plane to avoid special code to force-enable all colorops.
>    *
>    * Since acquiring a colorop state will always also acquire the w/w mutex of the
>    * current plane for that colorop (if there is any) adding all the colorop states for
Unfortunately, it is not clear from the context diff but this update is 
for drm_atomic_add_affected_colorops(). That function is now only used 
by drm_atomic_helper_duplicate_state(). So, potentially it could be move to
drm_atomic_helper.c and made a static local helper. Alternatively, 
should the _duplicate_state() function also be updated to only copy the 
states of colorops in active pipelines as well? It already only does the 
state add call if there is a pipeline, it just doesn't filter according 
to the pipeline. Seems like it should? In which case, this blanket add 
code can be removed entirely.

John.

> diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
> index b4b9e4f558ab..006278e21d49 100644
> --- a/include/drm/drm_colorop.h
> +++ b/include/drm/drm_colorop.h
> @@ -459,6 +459,9 @@ static inline unsigned int drm_colorop_index(const struct drm_colorop *colorop)
>   #define drm_for_each_colorop(colorop, dev) \
>   	list_for_each_entry(colorop, &(dev)->mode_config.colorop_list, head)
>   
> +#define drm_for_each_colorop_in_pipeline(colorop, pipeline) \
> +	for ((colorop) = (pipeline); (colorop); (colorop) = (colorop)->next)
> +
>   /**
>    * drm_get_colorop_type_name - return a string for colorop type
>    * @type: colorop type to compute name of

