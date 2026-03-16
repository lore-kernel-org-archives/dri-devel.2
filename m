Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0ECF53D69
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B4E10E5B0;
	Mon, 16 Mar 2026 15:55:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gt8hKzOw";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F5D610E528
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:54:57 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id B2542C6C;
 Mon, 16 Mar 2026 16:53:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773676424;
 bh=qJl9aeXpMuXMFSGDN66/VVC0JMyVjc+XX9UPptjkBVE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gt8hKzOwk0waOCTGNhVuP4xt+u6rejx0a6BoWaahRZIK0W9ImmpQrrMCq4lt1nm01
 eOcReA5aRkxJJFb8vUlziqwE71M46jJ46aM2mWC5ymIEl7LLTBe83UouSW9sbzWWpa
 4GpIjmHHJ3gcO29DHzt6jnw24WyqawOYTc2tvzQg=
Date: Mon, 16 Mar 2026 17:54:54 +0200
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
Subject: Re: [PATCH 04/14] drm/atomic-state-helper: Fix
 __drm_atomic_helper_plane_reset() doc typo
Message-ID: <20260316155454.GL31604@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-4-de7397c8e1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-drm-mode-config-init-v1-4-de7397c8e1cf@kernel.org>
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

On Tue, Mar 10, 2026 at 05:06:56PM +0100, Maxime Ripard wrote:
> A typo has slipped through in the __drm_atomic_helper_plane_reset()
> documentation, probably due to copy and paste. It will not assign
> drm_crtc state pointer, but rather the drm_plane's.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index 323abc9926e084ad595768c06d5c5ee28c22c014..a1abf4247c348eca21da348c3893dd843b9ed391 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -302,11 +302,11 @@ EXPORT_SYMBOL(__drm_atomic_helper_plane_state_reset);
>   * __drm_atomic_helper_plane_reset - reset state on plane
>   * @plane: drm plane
>   * @plane_state: plane state to assign
>   *
>   * Initializes the newly allocated @plane_state and assigns it to
> - * the &drm_crtc->state pointer of @plane, usually required when
> + * the &drm_plane->state pointer of @plane, usually required when

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>   * initializing the drivers or when called from the &drm_plane_funcs.reset
>   * hook.
>   *
>   * This is useful for drivers that subclass the plane state.
>   */
> 

-- 
Regards,

Laurent Pinchart
