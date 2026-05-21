Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E7ACD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B870110E169;
	Thu, 21 May 2026 09:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="esr1WOE0";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FE910F21B
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:49:23 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso493895e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1779356962; x=1779961762; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ReaflicG9jxrT121Yp+YbEeNKaO7PwpYEUsDZm4g/qo=;
 b=esr1WOE0wxcw7Pge9+kQk5p+U582TYO+KpKWvRiPH4WqddkPLurs2IBENVuf5OKv7J
 bKIj0iN1PF0B18UF3b7wungaxXRKYN4xV/mC75lXtAcenRCLuFSc4h9dVJ9KSvqZV94a
 TABzUWokhfZ54DbEOsXEGgK+vQhlNrVaM5moU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779356962; x=1779961762;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReaflicG9jxrT121Yp+YbEeNKaO7PwpYEUsDZm4g/qo=;
 b=DJS3C2tZe/h12eoVRjZWrAK1tZBpxe5+cH68a1/Bm21Wy1jdTheb/VZlP3c08dFV9x
 No7bXmJZZWlqUHC2Lhi2bqpMccK1hqiWJCUbuACMtWQvLgcoRRecYCdPI7cMN1KbDMIp
 VTc1xK/ipabE02GtrO/mHPXu+UuV6jbUH+AhcbQQ+JL1y9/rLjJX5sxXvGS/fQeXaP/0
 XfXSSXd3DTQA21uv5RxzytgjMS7i0s4bV7t3GhFTiuzKSzHyQCSIlZrzqpxSBd0Trf1L
 9XkNPT0JQ7oGM0H5t8mDWIQvPnCT8e6RcGx8hiuNjow2QWby6W8ocInNTyTo9KGjIioz
 RJKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GqpciG3CH5mg92BEdm6r2XN6PJnTdtbLlI3pm1ZlppT9MUWwTPrw0Tz7SIYNg+DtkBFQwNyoDWYw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxmjq33IRnry4nSPTCi5BNRroGjhz9az8Vul9W+Cv/6Yrw3sQLs
 uxz1npkMi2gGl+cSVqaMHyLecYHt+H5+ZgpNJbRXuHLOj8lBKPzOT0yNIFAE+q2ZZmU=
X-Gm-Gg: Acq92OHsFurpUZEpurTy5CEZL4ECCJJE4cwUuAzbSwPJ+heu9S40lOuAZ+zNK10j+Fj
 ZjLHe9JSaYPUpgSSR+v9/3Svb8CACext1+ZXhVJ+LxTwYBsvKNDb+F0o+Sroczh8+Vksb5egELy
 HFAWVxyJF1xepGIGjpop8N5+yczM1j4tsF9Y6aNFOmODa7ZVv/fxENRsXZQXRbe/aT9eMVxtoFz
 J4EpDU1oZ0FZF2rKGbjiQ7WyxfeiRIhraWNSrQ1EP5k1S/JStnwEBHVt1KfGxezGsYOANJuq977
 B/9w2HCuJPMpwnZotkGZb8y0DGtkNRp6IXuDcR+o0ko5z47UJWjMLzfAKAkL7At+bjG2PA33Lfo
 Ss6thXiqWOByA3lRiC4NKjLuRwycfvR9iO73qZzPaBpqy51t7SZSnKf/Ijpw6sOizxLfP1AOMpW
 BwwglDaWi51C7twR/D2tJqkXPSVYQdHWZ+QLEsFadT6IFgJg==
X-Received: by 2002:a05:600c:4fc7:b0:48a:66a8:9981 with SMTP id
 5b1f17b1804b1-490360ddce0mr26992815e9.27.1779356961554; 
 Thu, 21 May 2026 02:49:21 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c9a5108sm14370715e9.6.2026.05.21.02.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 02:49:20 -0700 (PDT)
Date: Thu, 21 May 2026 11:49:18 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/28] drm/atomic_helper: Skip over NULL private_obj
 pointers
Message-ID: <ag7VHtOMfRTJWmn8@phenom.ffwll.local>
Mail-Followup-To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jyri Sarha <jyri.sarha@iki.fi>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
 <20260423-drm-state-readout-v2-2-8549f87cb978@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-drm-state-readout-v2-2-8549f87cb978@kernel.org>
X-Operating-System: Linux phenom 6.19.10+deb14-amd64 
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

On Thu, Apr 23, 2026 at 12:18:15PM +0200, Maxime Ripard wrote:
> Just like for connectors, drm_atomic_state contains an array of

Maybe s/connectors/all other objects/ because for a moment I've pondered
whether we do this because connectors are special as dynamically
created/refcounted kms objects. Unlike planes/crtcs and private objects.

With that also Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>

Cheers, Sima

> drm_private_state, with the number of states found in num_private_objs.
> 
> If we are to clean up a state by hand for some reason before calling
> drm_atomic_state_put(), chances are that the pointer to the affected
> drm_private_obj and drm_private_states would have been cleared to avoid
> any use-after-free.
> 
> However, since it's just an array, as we progress and free the items, we
> can't update num_private_objs as we go since we would reduce the array
> size, preventing us to remove the final elements.
> 
> And if the caller was to forget to update num_private_objs after it
> iterated over the whole array, we're left with a (valid) array with a
> non-zero number of NULL elements.
> 
> If we were to call drm_atomic_state_put() at this point, chances are
> that drm_atomic_state_default_clear() would be called and it would
> iterate over all those empty NULL items.
> 
> However, unlike what is found for connectors, crtcs and planes, we don't
> test that our pointers are non-NULL before dereferencing them, leading
> to a NULL pointer dereference.
> 
> Such callers should obviously be fixed, but there's no reason to not do
> such a simple check, if only to be consistent.
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/drm_atomic.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 3bd52602fe30..84bc91886b4c 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -334,10 +334,13 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
>  	}
>  
>  	for (i = 0; i < state->num_private_objs; i++) {
>  		struct drm_private_obj *obj = state->private_objs[i].ptr;
>  
> +		if (!obj)
> +			continue;
> +
>  		obj->funcs->atomic_destroy_state(obj,
>  						 state->private_objs[i].state_to_destroy);
>  		state->private_objs[i].ptr = NULL;
>  		state->private_objs[i].state_to_destroy = NULL;
>  		state->private_objs[i].old_state = NULL;
> 
> -- 
> 2.53.0
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
