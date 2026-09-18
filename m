Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A252C88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 04:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3ED010F158;
	Fri, 18 Sep 2026 04:16:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aQ5Ox6a7";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D6310F16D
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 04:16:29 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-66e4ab201ebso284580d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789704989; cv=none;
 d=google.com; s=arc-20260327;
 b=c5c9zF0vnSllDZs3mx//7BMYCvt7Cd0NTP7m9YzusK1KbJm7JVxZBHr0P4ZLkUS5eT
 69m6D0mqCxrgAdcyHPctjtXmw9eAVvGZ3VgRj9qTvJKeeltF32IYgn+G15YPeYrfrk3W
 NTevq/ZRMbXb6ukBl3E7SdBr72HOY6f4nAvPuKNXv4f3DgdFjrF7KA9r26bOdqOw+xL6
 pP0YTbEUedKX21lwWkecbteniSlJNrQ5B4nGX5vsbHLd48FSWCo0KcDNhslj/dKKmwy1
 zNTa9ujfCtyFdd8wtLWrDbu5b7bpYoKF+/xNt/Ht+RIFugoxtjUBioflnfcXVnkcU0CQ
 7xaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=g5DKEYyvWEAWVKejXJm1cVbz3X+KIz29ykH7P6jopns=;
 fh=KglN0OgQRdroXILKUTXVmk9oydYD7lAy7NQiBaVUxss=;
 b=V4UkelZ0uJzYWmiSQYrmARfNgCHdCV+PqimopRnqFIXFuFNZ2H8fRRq24q5QvVLllN
 gMxeDLfvBfbItq6t/ctm9NtBZDXVm7fMrOy7TYyF4s76H7kurnXv4ZGTlGLyk3N1Erti
 cWLYuo5vIiPQJc4vTY2ZyWMtYqN5rXzI4vspx9HBWPXF10bRBlOc1IQ3520ZnfLkRYFB
 /kHBylNyZ4ZHkIXHrFTYHrE53HVgRzbb4LyQM0XZJrF9mgD369v5bTHMCMNCBP6x13XU
 CSEFu98eDgDy5m6GB+Uiu/9sAYAZmlt2IxOTfx0VFWm+Kf1xKpiz/vu6u/WExx9Giqy8
 +MRw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789704989; x=1790309789;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g5DKEYyvWEAWVKejXJm1cVbz3X+KIz29ykH7P6jopns=;
 b=aQ5Ox6a7ajz2SYnKVOVqN3IGEoiAqdGK/HZtyQlplgdXltndDrXDrt9bUOAlKDGtRe
 ex53dQSkUKKn+TSy+j/tLg0usQCE2nc/7fN/+r5tuOhsJ1GJmIXrew9MCwpmOpg6tUUh
 Kai9vFx7kJ2C/CxZNrj2dsjDkdP+i9Af8WncY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789704989; x=1790309789;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g5DKEYyvWEAWVKejXJm1cVbz3X+KIz29ykH7P6jopns=;
 b=nJeHANpz6ZycSL5mrM6z+5mpM2QaBqIVnLYasBsRc4JQL5GclwxFr6w56O+BhdjN0P
 fhry9utdb0vKpG7BlmYCK86U5f4oZ96PN8mH6siQ9gMB9xHKVcMV0XKxlwza2QpIPax0
 OGum18rY1YMxZbqcdKqX/1YtzIthHU4b6Gi0V9/nodnpL1ul5A/w6XdRPeWJrPTXWLG1
 iq0Nu8TS90hwQhWU1UCI7wtyMjF1koX65hqPRmxyLa9fi1rwHnnFZYuzFZ+qx+KWDTGr
 +dzDnQOcnJI496bRs9eKEL6+Avdk8Sj3gvLoKG2kzPAJlvjtlSZlrJRFzJyiW5NIU/9U
 gHFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBypagoHpTIHmgvKXS1zWDCuv08H5cVynTkqHC1uhL+ry1BFbgnswlEw+wf4rCbQy1+8h2fm5zwrN0E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nKCQvUb2JRhMqL/NEG509BR093Vb7di/DcRFCJWQOL6dYNXmcn
 5Qqnq1Wt0aoJXM93TcEq0s7QOuIZSE/ZrxkxbayRa1n/SLZkeFYPzZXjyI+quMyL6Gr1fCCZf/S
 7CxCjBcXGkeJMuWKgQZ4NVd39ctNop+EycoLcAK+y
X-Gm-Gg: AYBFou2cRxn5+6BpxoYN7c6hGeeSPB41+VUcDkc6wgBPxGCjgHVL2kZEcp7MrwLE1pr
 1oUkK+8tTMXIE4nrPypjHbe6x7NIR1e1LUVqAzJfodQTk3Wqe7O7jmE23Lqc2vMyOHR/o1m4aZd
 vJeRVZ3JjDvIfCgnHFUViS6fXEi0Hc2rCD/Q3GoUsXmcKfz8MzMyfvV5a6YhhVuhao+9KfJ3RC6
 FQi2Db3bXXmrFvkm8xk3NAX8FTlLhLIt93+hHjODJXRvRKLUGcUl/IOnysCm1uh1n1xmbyITBFf
 vgB+svFmMPujoyCvFCNT5udiNQ1uNJq89xh7AmXs+JcCrfPW6vRUBjsysSyj6Fa3nmaswAcvYuu
 DrVlidpESTA==
X-Received: by 2002:a05:690e:809:10b0:671:3141:3832 with SMTP id
 956f58d0204a3-6717fc76ff0mr285169d50.4.1789704988719; Thu, 17 Sep 2026
 21:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260916033327.3054126-1-wenst@chromium.org>
 <20260916033327.3054126-2-wenst@chromium.org>
 <f6ace486-70d8-4e81-89cb-e9d55ad9ac8b@suse.de>
In-Reply-To: <f6ace486-70d8-4e81-89cb-e9d55ad9ac8b@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 18 Sep 2026 12:16:17 +0800
X-Gm-Features: AcwNN1UR3eVFLoBD9oF0TIdnuDNIVRYA94Woweb8vmhnl_ZgpInsWYdL86x54Xk
Message-ID: <CAGXv+5ErgWVNtnRiW+QA7+Mzh=W_Y+HGL_iRa1fOaXCYSoAwMA@mail.gmail.com>
Subject: Re: [PATCH RFT v2 1/5] drm: Split framebuffer pixel offset
 calculation from drm_fb_dma_get_gem_addr()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Liu Ying <victor.liu@nxp.com>,
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-sunxi@lists.linux.dev, 
 imx@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 17, 2026 at 11:20=E2=80=AFPM Thomas Zimmermann <tzimmermann@sus=
e.de> wrote:
>
> Hi
>
> Am 16.09.26 um 05:33 schrieb Chen-Yu Tsai:
> > Currently drm_fb_dma_get_gem_addr() calculates the offset into the
> > framebuffer memory for the framebuffer's unclipped source coordinates,
> > adds that to the framebuffer's backing storage, and returns the result.
> >
> > We are about to add a variant that uses the clipped source coordinates,
> > so there is already some reuse of code. However, calculating the data
> > offset for a given pixel is not specific to the DMA FB helpers. The
> > offset is only related to the framebuffer.
> >
> > Split out the offset calculation into a new framebuffer helper so that
> > non-DMA users can also reuse the same code.
> >
> > Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: <stable@vger.kernel.org> # dependency for next patch
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - New patch
> > ---
> >   drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
> >   drivers/gpu/drm/drm_framebuffer.c   | 45 ++++++++++++++++++++++++++++=
+
> >   include/drm/drm_framebuffer.h       |  3 ++
> >   3 files changed, 51 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_=
fb_dma_helper.c
> > index fd71969d2fb1..ab0f37d8a5ff 100644
> > --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> > @@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_frame=
buffer *fb,
> >                                  unsigned int plane)
> >   {
> >       struct drm_gem_dma_object *obj;
> > -     dma_addr_t dma_addr;
> > -     u8 h_div =3D 1, v_div =3D 1;
> > -     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> > -     u32 block_h =3D drm_format_info_block_height(fb->format, plane);
> > -     u32 block_size =3D fb->format->char_per_block[plane];
> > -     u32 sample_x;
> > -     u32 sample_y;
> > -     u32 block_start_y;
> > -     u32 num_hblocks;
> >
> >       obj =3D drm_fb_dma_get_gem_obj(fb, plane);
> >       if (!obj)
> >               return 0;
> >
> > -     dma_addr =3D obj->dma_addr + fb->offsets[plane];
> > -
> > -     if (plane > 0) {
> > -             h_div =3D fb->format->hsub;
> > -             v_div =3D fb->format->vsub;
> > -     }
> > -
> > -     sample_x =3D (state->src_x >> 16) / h_div;
> > -     sample_y =3D (state->src_y >> 16) / v_div;
> > -     block_start_y =3D (sample_y / block_h) * block_h;
> > -     num_hblocks =3D sample_x / block_w;
> > -
> > -     dma_addr +=3D fb->pitches[plane] * block_start_y;
> > -     dma_addr +=3D block_size * num_hblocks;
> > -
> > -     return dma_addr;
> > +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane=
,
> > +                                                             state->sr=
c_x >> 16,
> > +                                                             state->sr=
c_y >> 16);
> >   }
> >   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
> >
> > diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_fr=
amebuffer.c
> > index d32aceb6ca9b..9e1231162047 100644
> > --- a/drivers/gpu/drm/drm_framebuffer.c
> > +++ b/drivers/gpu/drm/drm_framebuffer.c
> > @@ -1208,6 +1208,51 @@ void drm_framebuffer_print_info(struct drm_print=
er *p, unsigned int indent,
> >       }
> >   }
> >
> > +/**
> > + * drm_framebuffer_get_block_offset() - Get offset to start of pixel b=
lock for
> > + * the given framebuffer and coordinates.
> > + * @fb: The framebuffer
> > + * @plane: Which plane
> > + * @x: x coordinate for pixel
> > + * @y: y coordinate for pixel
> > + *
> > + * This function will usually be called from the PLANE callback functi=
ons,
> > + * or from one of the helpers that calculates the framebuffer's DMA ad=
dress.
> > + *
> > + * Return: offset from start of framebuffer to start of pixel block
> > + */
> > +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsig=
ned int plane,
> > +                                  unsigned int x, unsigned int y)
>
> Better use u64 as return type.

To avoid overflow? Not sure who would use crazy large framebuffers, but
doesn't hurt to play it safe.

> > +{
> > +     u8 h_div =3D 1, v_div =3D 1;
> > +     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> > +     u32 block_h =3D drm_format_info_block_height(fb->format, plane);
> > +     u32 block_size =3D fb->format->char_per_block[plane];
> > +     u32 sample_x;
> > +     u32 sample_y;
> > +     u32 block_start_y;
> > +     u32 num_hblocks;
> > +     u32 offset;
> > +
> > +     offset =3D fb->offsets[plane];
> > +
> > +     if (plane > 0) {
> > +             h_div =3D fb->format->hsub;
> > +             v_div =3D fb->format->vsub;
> > +     }
> > +
> > +     sample_x =3D x / h_div;
> > +     sample_y =3D y / v_div;
> > +     block_start_y =3D (sample_y / block_h) * block_h;
> > +     num_hblocks =3D sample_x / block_w;
> > +
> > +     offset +=3D fb->pitches[plane] * block_start_y;
> > +     offset +=3D block_size * num_hblocks;
>
> User space controls the values in fb->offsets and fb->pitches.  I'm not
> sure how well they have been validated already at this point. Did you
> investigate this?

It wouldn't be worse than before, since this changes is purely code movemen=
t.

There are minimal sanity checks done by drm_internal_framebuffer_create()
in framebuffer_check(), such as offset overflow or pitch size too small,
but that's about it. It would be up to individual drivers to perform more
checks that match their hardware limitations.

What sort of issues are you thinking about?


ChenYu

> Best regards
> Thomas
>
>
> > +
> > +     return offset;
> > +}
> > +EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
> > +
> >   #ifdef CONFIG_DEBUG_FS
> >   static int drm_framebuffer_info(struct seq_file *m, void *data)
> >   {
> > diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuffe=
r.h
> > index 38b24fc8978d..c07aea1cc59f 100644
> > --- a/include/drm/drm_framebuffer.h
> > +++ b/include/drm/drm_framebuffer.h
> > @@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffer =
*fb);
> >   void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
> >   void drm_framebuffer_unregister_private(struct drm_framebuffer *fb);
> >
> > +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, unsig=
ned int plane,
> > +                                  unsigned int x, unsigned int y);
> > +
> >   /**
> >    * drm_framebuffer_get - acquire a framebuffer reference
> >    * @fb: DRM framebuffer
>
> --
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG N=C3=BCrnberg)
>
>
