Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38E0CD6E79
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E62311A8D5;
	Fri,  5 Jun 2026 14:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UQNqVaav";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 831E811A8D5
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:21:07 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id E7151251C;
 Fri,  5 Jun 2026 16:20:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780669241;
 bh=KwlPjdSXxyfRfkpf0GZtTn6a6j74lQSAtrXyA/TaW5c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UQNqVaavfYKYRrz4uSft13TGckfPooyd1l31lp7oGyH+hqFy5uB1f15h/EqMf+ZBN
 TrybU279oYRfxS7zQpS5B8w9XLiONDwBmfi4Q28dcWHtlvX8GvMC/p4mAj08jd4i97
 717Pd4FnuYugKtJfks3pdQGHYzDTAjNN49c6NW1I=
Date: Fri, 5 Jun 2026 17:21:04 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 03/76] drm/atomic-state-helper: Drop memset from
 __drm_atomic_helper_bridge_state_init()
Message-ID: <20260605142104.GC84912@killaraus.ideasonboard.com>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-3-875d828d31bc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-3-875d828d31bc@kernel.org>
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

On Sat, May 30, 2026 at 03:59:08PM +0200, Maxime Ripard wrote:
> __drm_atomic_helper_bridge_state_init() is always called on a freshly
> kzalloc-ed state, so the memset is redundant.
> 
> Drop it and document the expectation that the state is already zeroed.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 8f04eae7a754..f0688f2d83fe 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -889,18 +889,19 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
>   * __drm_atomic_helper_bridge_state_init() - Initialize a bridge state to its
>   *					default
>   * @state: bridge state to initialize
>   * @bridge: the bridge this state refers to
>   *
> + * @state is assumed to be zeroed.
> + *
>   * Initializes the bridge state to default values. This is meant to be called
>   * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
>   * the bridge state.
>   */
>  void __drm_atomic_helper_bridge_state_init(struct drm_bridge_state *state,
>  					   struct drm_bridge *bridge)
>  {
> -	memset(state, 0, sizeof(*state));
>  	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
>  	state->bridge = bridge;
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);

-- 
Regards,

Laurent Pinchart
