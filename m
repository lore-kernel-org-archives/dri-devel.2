Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D55CC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:38:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BCC11290F;
	Fri, 16 Oct 2026 16:38:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095A310E349
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792168712; x=1823704712;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XtMSWOoA+SoKl7IrqSUMcjMvGe5hOOD5c54xgBQ/sGU=;
 b=EZ4e1182h4/+ULCfCxNEXtZgxwCKXD8zBrp7cP3kam0UwREAYkptJHp1
 iUKJFUtREcMixD+6xSQNUeIaEMAzwBzFnrpyNla/5eSgc7RaaKYlZbxgI
 ClabLhB1D2fWvFbka/lIlVMxz8kWf96NUFZlpjpH4d6ojv/XHhtQnEt3R
 WAo6FpXar2CUCBjlZN4FdC0KFrlWAF80D9DDzZ7I/1gnWjgy25rFT1BHw
 SiZCU3o7keph3l+Vl+tIlzCsEchUiYS+4znp5zS6T0N9/oEogghN+2cfF
 wQInDMxQ8t2ohlrcH6IqkyVI1XIzVjpPZSpZD6Qeitb+Jdo7ZxEapadfh Q==;
X-CSE-ConnectionGUID: Onu0JeErTty9KZ8ExCLzLg==
X-CSE-MsgGUID: bHzIJsM7SUyKt3gzhA7uQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="975039"
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="975039"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 09:38:31 -0700
X-CSE-ConnectionGUID: yKvntl+WTAuyN6Mr5/3gNg==
X-CSE-MsgGUID: VRsjA3g0TJCi3Q62uTD4RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,162,1787036400"; 
   d="scan'208";a="2411078"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.245.84])
 ([10.245.245.84])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 09:38:28 -0700
Message-ID: <b13cf9ae-61c5-4633-a4e0-e15b702f429d@linux.intel.com>
Date: Fri, 16 Oct 2026 18:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/28] drm/atomic: Fix private obj error handling
To: Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
 <20261015-drm-state-readout-v6-1-6cc02cd10998@kernel.org>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20261015-drm-state-readout-v6-1-6cc02cd10998@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

Hey,

On 10/15/26 17:08, Maxime Ripard wrote:
> drm_atomic_private_obj_init() initializes the modeset lock and adds the
> object to the privobj_list before calling atomic_create_state().
> 
> However, if atomic_create_state() fails, the function returns the error
> directly without removing the object from the list or cleaning up the
> lock. This leaves a dangling entry in privobj_list and a leaked lock.
> 
> Fix this by unwinding both operations in an error path.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
The commit message describes a good reason to add fixes tag?

> ---
>  drivers/gpu/drm/drm_atomic.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 9bb761eda59f..9973becb75ae 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -1027,25 +1027,34 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
>  int drm_atomic_private_obj_init(struct drm_device *dev,
>  				struct drm_private_obj *obj,
>  				const struct drm_private_state_funcs *funcs)
>  {
>  	struct drm_private_state *state;
> +	int ret;
> +
>  	memset(obj, 0, sizeof(*obj));
>  
>  	drm_modeset_lock_init(&obj->lock);
>  
>  	obj->dev = dev;
>  	obj->funcs = funcs;
>  	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
>  
>  	state = obj->funcs->atomic_create_state(obj);
> -	if (IS_ERR(state))
> -		return PTR_ERR(state);
> +	if (IS_ERR(state)) {
> +		ret = PTR_ERR(state);
> +		goto err_list_del;
> +	}
>  
>  	obj->state = state;
>  
>  	return 0;
> +
> +err_list_del:
> +	list_del(&obj->head);
> +	drm_modeset_lock_fini(&obj->lock);
> +	return ret;
>  }
>  EXPORT_SYMBOL(drm_atomic_private_obj_init);
>  
>  /**
>   * drm_atomic_private_obj_fini - finalize private object
> 

