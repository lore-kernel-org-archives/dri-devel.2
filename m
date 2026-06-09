Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7631CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:59:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF35310E51B;
	Tue,  9 Jun 2026 14:59:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=ffwll.ch header.i=@ffwll.ch header.b="Vyr4L5fE";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54CCE10E545
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 14:59:31 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so47140455e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1781017170; x=1781621970; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=tUdHUMUik9TEHOW4E8Paa+t240ejFjgq+HfjWasiBuI=;
 b=Vyr4L5fEZiYBpT/XoErwl6mfPtQ6hDUZxaocGvhHZzAwBJEx5EllTCzsg6ppffmnQM
 j8uCHd9OxVjZgisJf4fc6730gexbSze6fI5gTjQq7Qb26qImHxl+dVEu71+DIWP0XVFR
 5H6wxIhsc7lsCYbwnIWJNOIA7zHrsOeg81300=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017170; x=1781621970;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tUdHUMUik9TEHOW4E8Paa+t240ejFjgq+HfjWasiBuI=;
 b=njPrjWjFH8E5KYPJ3FEV0vmZekDPRmh4auZM8leb+ta8eUUwVN9C1y7Jfypn6c2QAz
 mZ4l1bMBuox4qrnvi5HUIW6PerSx7FCAzjX0cg4KXXEbMITjrlgSVnA/xDaD+JUjzomB
 i/vsMC4KFUNKEOuD/hafHBw0UZZk94GSCIYSmCjx7IiYb2tWbJm3izdYCXn5eMxYo52H
 lGm/QopLuu/+lKwXD6jk5V260Uxw968LITF5lQHWY8r9pFa1nWxag1xMXpdqIJ+jqDYu
 oo4yAiR0TGdniCYSl8xC6K83UMtmmhuUjmk+tC9ZrapjX6f3HfH41Q1LP+x8gPVswF5m
 rZZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/R0QSE8L1/9zj/rfOlYFpHgR3VzgDYUMuNZPUvQSydpcff73aA/WdvYOw5xPhnDSzJBEOHu8IJEg8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypXUhKc17JlKVoQHqmlYI6MouiKIMHrtJB9wuwDL0vcqpd//j+
 AZJHdIWetOz5tIm6fqzQUP+aXF+m7ySHW+0JYSSrRUrR6LJcHTftpIfwXYRhl++OjGs=
X-Gm-Gg: Acq92OGQt2ut/P8AURZMQVfle6ItG55s4XEb42j3N62FpfnDJ1zrWU5C1Es71GYHA3P
 SEdeCpUMmWISE4zd40fVBVONFW2/cVS8pMHS+rtj5NSesSYK/BSrPpDA/4iukevMFcPucFyWmYU
 AbsQe7D2EQSKRyyQpbQtQ83jDJzTs/jc6Za2+g8KsPPRA5AeRXf2+1bxip7fXjyQFACH5cpRU9d
 kb2A0hgIri4Ufp691lh+R8P/VCjZ97v8fkL1TNij1S/T53jYx5/XTclT+qnIpW3yfS3U3VFFMP+
 er4sm0KplF+s7igfNsgpX1e+LC91WtbEEpRIH1I/++5SkTSVGMnQ2Vtn7tCKsObyfWmcqTzoLPV
 skQaNiu0KKCskOqQWBOElXb55X33PFhb6mO7XMb00MN8jnFkLI16MP0pkoPRHYyLWKA0ID5Jawm
 8XT7dwj2pFyjTHY1aavkd0Oc53K68rjz98YaFHAXE2qvYzHw==
X-Received: by 2002:a05:600c:8208:b0:490:ad1e:1846 with SMTP id
 5b1f17b1804b1-490c2cf6718mr248198135e9.9.1781017169549; 
 Tue, 09 Jun 2026 07:59:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3b5b82sm518278635e9.1.2026.06.09.07.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:59:28 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:59:27 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: Maxime Ripard <mripard@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
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
Subject: Re: [PATCH v2 11/28] drm/atomic_sro: Create kernel parameter to
 force or disable readout
Message-ID: <aigqT02UoGI9SJtn@phenom.ffwll.local>
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
 <20260423-drm-state-readout-v2-11-8549f87cb978@kernel.org>
 <ag7jmuHUd7qqzXBu@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag7jmuHUd7qqzXBu@phenom.ffwll.local>
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

On Thu, May 21, 2026 at 12:51:06PM +0200, Simona Vetter wrote:
> On Thu, Apr 23, 2026 at 12:18:24PM +0200, Maxime Ripard wrote:
> > The hardware state readout is useful, but might need to be disabled
> > in case of bugs, or its checks relaxed during development when not
> > all hooks are implemented yet.
> > 
> > Add a module parameter to control the readout behavior: it can be
> > disabled entirely, or the checks for missing compare or readout hooks
> > can be skipped independently.
> > 
> > Suggested-by: Simona Vetter <simona@ffwll.ch>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_sro.c | 36 ++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_atomic_sro.h     |  2 ++
> >  2 files changed, 38 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_sro.c b/drivers/gpu/drm/drm_atomic_sro.c
> > index 177b97d451f5..a46f06e75c4e 100644
> > --- a/drivers/gpu/drm/drm_atomic_sro.c
> > +++ b/drivers/gpu/drm/drm_atomic_sro.c
> > @@ -11,10 +11,46 @@
> >  #include <linux/module.h>
> >  
> >  #include "drm_internal.h"
> >  #include "drm_crtc_internal.h"
> >  
> > +enum drm_atomic_readout_status {
> > +	DRM_ATOMIC_READOUT_DISABLED = 0,
> > +	DRM_ATOMIC_READOUT_ENABLED,
> > +	DRM_ATOMIC_READOUT_SKIP_MISSING_COMPARE,
> > +	DRM_ATOMIC_READOUT_SKIP_MISSING_READOUT,
> > +};
> > +
> > +static unsigned int atomic_readout = DRM_ATOMIC_READOUT_ENABLED;
> > +module_param_unsafe(atomic_readout, uint, 0);
> 
> Default is actually 0 here. I agree with the docs that it should be 1,
> since drivers have an explicit opt-in through setting the main entry point
> in drm_mode_config_funcs.
> 
> I was also pondering whether we should have a compare-only mode, but the
> issue is that once you build a driver on readout being a thing, that could
> blow up. So I think that should be left as a per-driver tunable.
> 
> That's also why this must be a unsafe debug option, it might actually
> break the driver.

Maxime pointed out that this makes non sense because the default is
already enabled, and yes I got confused. So strike that, but maybe think
whether 0600 as permissions makes more sense, because that's the bit that
confused me.

Either way, this hunk here also looks good as-is.
-Sima

> 
> > +MODULE_PARM_DESC(atomic_readout,
> > +		 "Enable Hardware State Readout (0 = disabled, 1 = enabled, 2 = ignore missing compares, 3 = ignore missing readouts and compares, default = 1)");
> > +
> > +/**
> > + * drm_atomic_sro_device_can_readout - check if a device supports hardware state readout
> > + * @dev: DRM device to check
> > + *
> > + * Verifies that the device is an atomic driver, that readout is
> > + * enabled, and that all KMS objects implement the relevant hooks.
> > + *
> > + * RETURNS:
> > + *
> > + * True if the device supports full hardware state readout, false
> > + * otherwise.
> > + */
> > +bool drm_atomic_sro_device_can_readout(struct drm_device *dev)
> > +{
> > +	if (!drm_core_check_feature(dev, DRIVER_ATOMIC))
> 
> I think this should be drm_drv_uses_atomic_modeset() since it's an
> internal check, not an uapi check.
> 
> With the two issues addressed:
> 
> Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
> 
> > +		return false;
> > +
> > +	if (atomic_readout == DRM_ATOMIC_READOUT_DISABLED)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +EXPORT_SYMBOL(drm_atomic_sro_device_can_readout);
> > +
> >  struct __drm_atomic_sro_plane {
> >  	struct drm_plane *ptr;
> >  	struct drm_plane_state *state;
> >  };
> >  
> > diff --git a/include/drm/drm_atomic_sro.h b/include/drm/drm_atomic_sro.h
> > index 5a9333a05796..6e5262384c71 100644
> > --- a/include/drm/drm_atomic_sro.h
> > +++ b/include/drm/drm_atomic_sro.h
> > @@ -13,10 +13,12 @@ struct drm_plane;
> >  struct drm_plane_state;
> >  struct drm_printer;
> >  struct drm_private_obj;
> >  struct drm_private_state;
> >  
> > +bool drm_atomic_sro_device_can_readout(struct drm_device *dev);
> > +
> >  struct drm_atomic_sro_state *drm_atomic_sro_state_alloc(struct drm_device *dev);
> >  void drm_atomic_sro_state_free(struct drm_atomic_sro_state *state);
> >  void drm_atomic_sro_state_print(const struct drm_atomic_sro_state *state,
> >  				struct drm_printer *p);
> >  
> > 
> > -- 
> > 2.53.0
> > 
> 
> -- 
> Simona Vetter
> Software Engineer
> http://blog.ffwll.ch

-- 
Simona Vetter
Software Engineer
http://blog.ffwll.ch
