Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08480F53D69
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 15:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFB410E325;
	Mon, 16 Mar 2026 15:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DuT2/HE1";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3FF510E325
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 15:53:54 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id F03F7C6C;
 Mon, 16 Mar 2026 16:52:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1773676362;
 bh=nefS1Nl7jufl9v5V3tpA0vWdgfXt0Ga9N7ObiJRukwA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DuT2/HE1oA3ZPWNkOLEzbOjAdkEBfKhiD/G9bhfG29Q3BUkYdcUY3mhGHntLcQtIZ
 Z1keo5lWUrVYla5+PYfj1cpYtCTtLjNBJAOAd/ILnVGnnQ5W6MQIedzI8aG9CtrSrF
 XScpokjZiEinPXmWcIS01TrK84YbNwEepP54LnHM=
Date: Mon, 16 Mar 2026 17:53:52 +0200
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
Subject: Re: [PATCH 03/14] drm/mode-config: Mention drm_mode_config_reset()
 culprits
Message-ID: <20260316155352.GF31616@killaraus.ideasonboard.com>
References: <20260310-drm-mode-config-init-v1-0-de7397c8e1cf@kernel.org>
 <20260310-drm-mode-config-init-v1-3-de7397c8e1cf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310-drm-mode-config-init-v1-3-de7397c8e1cf@kernel.org>
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

On Tue, Mar 10, 2026 at 05:06:55PM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has the expectation that drm_private_states are
> not reset.

I initially misinterpreted that. I don't think it's an "expectation".
The function simply does not reset the private objects states. If you
want to keep "expectation", you can write

drm_mode_config_reset() has the expectation that drm_private_states do
not need to be reset.

> This is especially significant for the DP MST and tunneling code that
> expect to be preserved across a suspend/resume cycle, where
> drm_mode_config_reset() is also used.
> 
> Let's document this expectation.
> 
> Link: https://lore.kernel.org/dri-devel/aOaQLx-7EpsHRwkH@ideak-desk/
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_mode_config.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
> index 84ae8a23a36786705fea7c0eafd7f20813b7c8f9..54c27376f9894ef5eee378bb5b1e5fc7049de922 100644
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c
> @@ -187,10 +187,14 @@ int drm_mode_getresources(struct drm_device *dev, void *data,
>   * @dev: drm device
>   *
>   * This functions calls all the crtc's, encoder's and connector's ->reset
>   * callback. Drivers can use this in e.g. their driver load or resume code to
>   * reset hardware and software state.
> + *
> + * It's worth noting that @drm_private_obj structures are expected to be

s/It's worth noting/Note/

> + * stable across suspend/resume cycles, and @drm_mode_config_reset()
> + * will not affect these structures.

s/will/does/

With this addressed,

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>   */
>  void drm_mode_config_reset(struct drm_device *dev)
>  {
>  	struct drm_crtc *crtc;
>  	struct drm_colorop *colorop;
> 

-- 
Regards,

Laurent Pinchart
