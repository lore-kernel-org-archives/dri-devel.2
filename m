Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B59F53D69
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2BE610E5A7;
	Mon, 16 Mar 2026 15:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RRri84rO";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F70E10E5A7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:49:16 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 966C4E79;
 Mon, 16 Mar 2026 16:48:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773676083;
 bh=Hw+oGwfBxzHamlpIgBz5N8Zz/wAJ6ScBwV/dkIz8LbE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RRri84rOI+wq9W+fc6r1rH5vcrj5tapaHOrx0QAUPB8PmHbPmkHxXgamePxscG1PW
 aIeGdwhVx3dJYOLAnq+vv/rOJRTtd3EV8m0FJl3LapG6Zise86js9nP857ZrYqyR0a
 8+s/7curAP1/KOf69pSvICYlKitd7vCNcS7IROm8=
Date: Mon, 16 Mar 2026 17:49:13 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14] drm/atomic: Drop drm_private_state.obj assignment
 from create_state
Message-ID: <20260316154913.GE31616@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-2-de7397c8e1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-drm-mode-config-init-v1-2-de7397c8e1cf@kernel.org>
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

On Tue, Mar 10, 2026 at 05:06:54PM +0100, Maxime Ripard wrote:
> The initial intent of the atomic_create_state helper was to simply
> allocate a proper drm_private_state and returning it, without any side
> effect.
> 
> However, the __drm_atomic_helper_private_obj_create_state() introduces a
> side effect by setting the drm_private_obj.state to the newly allocated
> state.
> 
> This assignment defeats the purpose, but is also redundant since
> the only caller, drm_atomic_private_obj_init(), will also set this
> pointer to the newly allocated state.

__drm_atomic_helper_bridge_reset() is called in many places. Most of
them are .atomic_create_state() handlers, called from
drm_atomic_private_obj_init() only. The only exception is
__drm_atomic_helper_bridge_reset(). Are you sure this patch won't cause
any negative side effect there ? The commit message should explain why.

> 
> Let's drop the assignment in __drm_atomic_helper_private_obj_create_state().
> 
> Fixes: e7be39ed1716 ("drm/atomic-helper: Add private_obj atomic_create_state helper")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index bd6faa09f83b498b1417869493f31d876cd13914..323abc9926e084ad595768c06d5c5ee28c22c014 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -728,12 +728,10 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
>  void __drm_atomic_helper_private_obj_create_state(struct drm_private_obj *obj,
>  						  struct drm_private_state *state)
>  {
>  	if (state)
>  		state->obj = obj;
> -
> -	obj->state = state;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_private_obj_create_state);
>  
>  /**
>   * __drm_atomic_helper_private_obj_duplicate_state - copy atomic private state
> 

-- 
Regards,

Laurent Pinchart
