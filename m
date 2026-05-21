Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B48ACD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 09:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D313510F27F;
	Thu, 21 May 2026 09:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="IXk/f9h6";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D9010F27F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 09:51:13 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso54077135e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1779357071; x=1779961871; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v4gQkUqn8G/2ZssvYAdUOdDkCHargD2hgrC4y5JhqUg=;
 b=IXk/f9h6amLa0nbAf2J1LTMwOEmnP5yAC0z8UturrbuR+1zhk6UXWX/1FLRGL8+Ooa
 UVOo5CsqPUiAY+5OZhLAguuhGZ7WQx180W99QkXheKsCzsLhOjW4xAvoxQk+hAmAuZ7e
 6dm1jAPG1a6uQP3Tx1d1z0bGu4iNdkPfaVQvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779357071; x=1779961871;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4gQkUqn8G/2ZssvYAdUOdDkCHargD2hgrC4y5JhqUg=;
 b=lVDtk2Dw5fNXcHcwK+6xaWZTmYulR2ekcJkqOVZpU/VzaYb+mgur6f7kJqPzYJk17X
 RfK7E1HaI87i3qfn5AWPMedGr9U2yV1Ipqb4GYKiGdCLGpWSwFrk/6ly+dJF9pS6CjB4
 Nj8tqNfXQZzOx27R6ZvEbDo49rzC57WemCnU7EegUK/9ul7Ou/xA2/A2J+7cZmo20FSv
 V3KkVFKpC4oecXEgqO6TpCUuIQbAppGbeD4I1k7b8/uZGKj6StNX4KP8QSpozkXIYjZb
 xaFnpEjzcM8J2U9FQ5ODabr3bXbGnTZ6UKFZcQTdg37XZR0dNHZZKtmAXfmR8I8NmJda
 SOHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ85aZwWB3vsd1sQZMJG+mvJPBXZnWr5tUCMd1unEN4rMu1Q5T7zULqvwoZAyM0sH6FXYOen8+cBh7Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyodE6mE0vOkWaaWF1ebnsZhM7YVbQ1NabDR/hVCkFWb9RPUuZ
 nYEKdc27Dp8bhsD4/fgxQDqROz+cCY2Y60ysE6lBJDxBfWVWcBzVexEsb3i2PRb36Wg=
X-Gm-Gg: Acq92OFqhJiiIfn0c6vZMaHZYEEUcOA0MRiKSKjso8HNJaYg9xPjiHzAzMQOnSmJcoT
 xZPxzHYAm7KiI11ShFqscqQ7MrTYMpjbnfJ0QBfQCXyvWyAu65yZb4bHQSXS4p90rnBeiMLzpQg
 yJ6HhrPbyOLERhFzoBeo56xnIVF7afygIgFRUr3QmzLcVh0t6um+1sweCPmLg/R+9OZoPHJgeBH
 1kVKQkXj06B8rWMEo79iFUfDzqmiRwV2WssYVaU9vH1cKCPshANJjJedzzyB6qZt9a3W4YqBiM7
 jSTgOvLwIlj0Cfw0dOQv9nx01dpviSW1M9wy6lXLU7Gt+fWDORwgAoQj04NqYV8Sm/I0zHaXm5N
 JsFG9koL6T8TYgScPYLf3cyOCXHixELIM3zXB8ZltRAsf4XDDho8f5aPrwbC+IMd0gbsVWbovxH
 icGSZbPlMG6iI2KZ3Ia0uADfrB6e2EfBg+TTNbEm0OaLVAPA==
X-Received: by 2002:a05:600c:621a:b0:48d:50a:6ef4 with SMTP id
 5b1f17b1804b1-490360ae7e3mr22354105e9.11.1779357071435; 
 Thu, 21 May 2026 02:51:11 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d8e24bsm51584595e9.10.2026.05.21.02.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 02:51:10 -0700 (PDT)
Date: Thu, 21 May 2026 11:51:08 +0200
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
Subject: Re: [PATCH v2 01/28] drm/atomic: Fix unused but set warning in state
 iterator macros
Message-ID: <ag7VjBeFQ1Q7tTr9@phenom.ffwll.local>
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
 <20260423-drm-state-readout-v2-1-8549f87cb978@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-drm-state-readout-v2-1-8549f87cb978@kernel.org>
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

On Thu, Apr 23, 2026 at 12:18:14PM +0200, Maxime Ripard wrote:
> A number of state iterator macros trigger a compiler warning if an
> iterator parameter isn't used in the code block.
> 
> Add a similar workaround than in most other macros.

I'm not on top of macro-fu, so not leaning out the window and dropping an
r-b here. But sounds reasonable.

Acked-by: Simona Vetter <simona.vetter@ffwll.ch>

> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_atomic.h | 64 +++++++++++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index f03cd199aee7..b9e7281cfc97 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -946,13 +946,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	for ((__i) = 0;								\
>  	     (__i) < (__state)->num_connector;					\
>  	     (__i)++)								\
>  		for_each_if ((__state)->connectors[__i].ptr &&			\
>  			     ((connector) = (__state)->connectors[__i].ptr,	\
> -			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
> -			     (old_connector_state) = (__state)->connectors[__i].old_state,	\
> -			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
> +			      (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
> +			      (old_connector_state) = (__state)->connectors[__i].old_state,	\
> +			      (void)(old_connector_state) /* Only to avoid unused-but-set-variable warning */, \
> +			      (new_connector_state) = (__state)->connectors[__i].new_state,	\
> +			      (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_old_connector_in_state - iterate over all connectors in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @connector: &struct drm_connector iteration cursor
> @@ -968,12 +970,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	for ((__i) = 0;								\
>  	     (__i) < (__state)->num_connector;					\
>  	     (__i)++)								\
>  		for_each_if ((__state)->connectors[__i].ptr &&			\
>  			     ((connector) = (__state)->connectors[__i].ptr,	\
> -			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
> -			     (old_connector_state) = (__state)->connectors[__i].old_state, 1))
> +			      (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
> +			      (old_connector_state) = (__state)->connectors[__i].old_state, \
> +			      (void)(old_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_new_connector_in_state - iterate over all connectors in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @connector: &struct drm_connector iteration cursor
> @@ -989,13 +992,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	for ((__i) = 0;								\
>  	     (__i) < (__state)->num_connector;					\
>  	     (__i)++)								\
>  		for_each_if ((__state)->connectors[__i].ptr &&			\
>  			     ((connector) = (__state)->connectors[__i].ptr,	\
> -			     (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
> -			     (new_connector_state) = (__state)->connectors[__i].new_state, \
> -			     (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
> +			      (void)(connector) /* Only to avoid unused-but-set-variable warning */, \
> +			      (new_connector_state) = (__state)->connectors[__i].new_state, \
> +			      (void)(new_connector_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @crtc: &struct drm_crtc iteration cursor
> @@ -1012,14 +1015,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i) < (__state)->dev->mode_config.num_crtc;		\
>  	     (__i)++)							\
>  		for_each_if ((__state)->crtcs[__i].ptr &&		\
>  			     ((crtc) = (__state)->crtcs[__i].ptr,	\
>  			      (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
> -			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
> -			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
> -			     (new_crtc_state) = (__state)->crtcs[__i].new_state, \
> -			     (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
> +			      (old_crtc_state) = (__state)->crtcs[__i].old_state, \
> +			      (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, \
> +			      (new_crtc_state) = (__state)->crtcs[__i].new_state, \
> +			      (void)(new_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_old_crtc_in_state - iterate over all CRTCs in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @crtc: &struct drm_crtc iteration cursor
> @@ -1035,11 +1038,12 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i) < (__state)->dev->mode_config.num_crtc;		\
>  	     (__i)++)							\
>  		for_each_if ((__state)->crtcs[__i].ptr &&		\
>  			     ((crtc) = (__state)->crtcs[__i].ptr,	\
>  			     (void)(crtc) /* Only to avoid unused-but-set-variable warning */, \
> -			     (old_crtc_state) = (__state)->crtcs[__i].old_state, 1))
> +			     (old_crtc_state) = (__state)->crtcs[__i].old_state, \
> +			     (void)(old_crtc_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_new_crtc_in_state - iterate over all CRTCs in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @crtc: &struct drm_crtc iteration cursor
> @@ -1120,12 +1124,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	     (__i) < (__state)->dev->mode_config.num_total_plane;	\
>  	     (__i)++)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
>  			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
> -			      (old_plane_state) = (__state)->planes[__i].old_state,\
> -			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
> +			      (old_plane_state) = (__state)->planes[__i].old_state, \
> +			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, \
> +			      (new_plane_state) = (__state)->planes[__i].new_state, \
> +			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_oldnew_plane_in_state_reverse - iterate over all planes in an atomic
>   * update in reverse order
>   * @__state: &struct drm_atomic_state pointer
> @@ -1142,12 +1148,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	for ((__i) = ((__state)->dev->mode_config.num_total_plane - 1);	\
>  	     (__i) >= 0;						\
>  	     (__i)--)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
> -			      (old_plane_state) = (__state)->planes[__i].old_state,\
> -			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
> +			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
> +			      (old_plane_state) = (__state)->planes[__i].old_state, \
> +			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, \
> +			      (new_plane_state) = (__state)->planes[__i].new_state, \
> +			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_new_plane_in_state_reverse - other than only tracking new state,
>   * it's the same as for_each_oldnew_plane_in_state_reverse
>   * @__state: &struct drm_atomic_state pointer
> @@ -1159,11 +1168,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	for ((__i) = ((__state)->dev->mode_config.num_total_plane - 1);	\
>  	     (__i) >= 0;						\
>  	     (__i)--)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
> -			      (new_plane_state) = (__state)->planes[__i].new_state, 1))
> +			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
> +			      (new_plane_state) = (__state)->planes[__i].new_state, \
> +			      (void)(new_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
>  
>  /**
>   * for_each_old_plane_in_state - iterate over all planes in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @plane: &struct drm_plane iteration cursor
> @@ -1178,11 +1189,14 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  	for ((__i) = 0;							\
>  	     (__i) < (__state)->dev->mode_config.num_total_plane;	\
>  	     (__i)++)							\
>  		for_each_if ((__state)->planes[__i].ptr &&		\
>  			     ((plane) = (__state)->planes[__i].ptr,	\
> -			      (old_plane_state) = (__state)->planes[__i].old_state, 1))
> +			      (void)(plane) /* Only to avoid unused-but-set-variable warning */, \
> +			      (old_plane_state) = (__state)->planes[__i].old_state, \
> +			      (void)(old_plane_state) /* Only to avoid unused-but-set-variable warning */, 1))
> +
>  /**
>   * for_each_new_plane_in_state - iterate over all planes in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @plane: &struct drm_plane iteration cursor
>   * @new_plane_state: &struct drm_plane_state iteration cursor for the new state
> @@ -1216,12 +1230,15 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   */
>  #define for_each_oldnew_private_obj_in_state(__state, obj, old_obj_state, new_obj_state, __i) \
>  	for ((__i) = 0; \
>  	     (__i) < (__state)->num_private_objs && \
>  		     ((obj) = (__state)->private_objs[__i].ptr, \
> +		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
>  		      (old_obj_state) = (__state)->private_objs[__i].old_state,	\
> -		      (new_obj_state) = (__state)->private_objs[__i].new_state, 1); \
> +		      (void)(old_obj_state) /* Only to avoid unused-but-set-variable warning */, \
> +		      (new_obj_state) = (__state)->private_objs[__i].new_state, \
> +		      (void)(new_obj_state) /* Only to avoid unused-but-set-variable warning */, 1); \
>  	     (__i)++)
>  
>  /**
>   * for_each_old_private_obj_in_state - iterate over all private objects in an atomic update
>   * @__state: &struct drm_atomic_state pointer
> @@ -1235,11 +1252,13 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>   */
>  #define for_each_old_private_obj_in_state(__state, obj, old_obj_state, __i) \
>  	for ((__i) = 0; \
>  	     (__i) < (__state)->num_private_objs && \
>  		     ((obj) = (__state)->private_objs[__i].ptr, \
> -		      (old_obj_state) = (__state)->private_objs[__i].old_state, 1); \
> +		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
> +		      (old_obj_state) = (__state)->private_objs[__i].old_state, \
> +		      (void)(old_obj_state) /* Only to avoid unused-but-set-variable warning */, 1); \
>  	     (__i)++)
>  
>  /**
>   * for_each_new_private_obj_in_state - iterate over all private objects in an atomic update
>   * @__state: &struct drm_atomic_state pointer
> @@ -1254,11 +1273,12 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  #define for_each_new_private_obj_in_state(__state, obj, new_obj_state, __i) \
>  	for ((__i) = 0; \
>  	     (__i) < (__state)->num_private_objs && \
>  		     ((obj) = (__state)->private_objs[__i].ptr, \
>  		      (void)(obj) /* Only to avoid unused-but-set-variable warning */, \
> -		      (new_obj_state) = (__state)->private_objs[__i].new_state, 1); \
> +		      (new_obj_state) = (__state)->private_objs[__i].new_state, \
> +		      (void)(new_obj_state) /* Only to avoid unused-but-set-variable warning */, 1); \
>  	     (__i)++)
>  
>  /**
>   * drm_atomic_crtc_needs_modeset - compute combined modeset need
>   * @state: &drm_crtc_state for the CRTC
> 
> -- 
> 2.53.0
> 

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
