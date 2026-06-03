Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51524CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B256010FEC2;
	Wed,  3 Jun 2026 14:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="WRF7PCpk";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A033A10FEC2
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:07:35 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 61A4EC63444;
 Wed,  3 Jun 2026 14:07:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 67C675FA0A;
 Wed,  3 Jun 2026 14:07:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 3A75510888CC6; 
 Wed,  3 Jun 2026 16:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1780495652; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ik2T+0+o5s9J8PjbGT6aVn8r+fv+tJoHBg1et4/YKbI=;
 b=WRF7PCpkr8zx9V3Wm53BcFpau/V78eOB9P+bxPEy8rNIPPXAME4jJyfrFxeRCZcj7eIoq7
 BlIl1UApqwg1jOJX8OA/iLVl8OSSv0oPJ2Ay7azMlAV/bMrxOL4trVN7DILq5bFgFyf436
 7gpcyH5ZNzZdU4GTIAHUHSNdpojcg/XjJD2A8YbnEBqjoxtIS7pf7R6BAm/9b/deQFsiBu
 FaQiq6PDS3l09ChXix0+C16RUpcpt3ohEQozR+JCKOpVtF0eNLZiwGT3pzsvUTEXb4nrOJ
 Pr3HotNGJxS6OWwrYivzrLO6ZZC2duhOA5ISTWWae6jV433Kiq3NfSS6vhpWzw==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 01/76] drm/atomic-state-helper: Rename
 __drm_atomic_helper_bridge_reset()
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-1-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
 <20260530-drm-no-more-bridge-reset-v1-1-875d828d31bc@kernel.org>
Date: Wed, 03 Jun 2026 16:07:19 +0200
Message-Id: <178049563992.8577.9812076326630979567.b4-review@b4>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

On Sat, 30 May 2026 15:59:06 +0200, Maxime Ripard <mripard@kernel.org> wrote:

Hi Maxime,

>
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index cc70508d4fdb..bcd0240d55b4 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -821,14 +821,14 @@ EXPORT_SYMBOL(drm_atomic_helper_bridge_destroy_state);
>   * by the bridge &drm_bridge_funcs.atomic_reset hook for bridges that subclass
>   * the bridge state.
>   */
> -void __drm_atomic_helper_bridge_reset(struct drm_bridge *bridge,
> +void __drm_atomic_helper_bridge_state_init(struct drm_bridge *bridge,
>  				      struct drm_bridge_state *state)
>  {
>  	memset(state, 0, sizeof(*state));
>  	__drm_atomic_helper_private_obj_create_state(&bridge->base, &state->base);
>  	state->bridge = bridge;
>  }
> -EXPORT_SYMBOL(__drm_atomic_helper_bridge_reset);
> +EXPORT_SYMBOL(__drm_atomic_helper_bridge_state_init);

__drm_atomic_helper_bridge_reset() is called in
drm_atomic_helper_bridge_reset() too, but not converted until patch
2. It would be good to move it here.

Otherwise LGTM.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

