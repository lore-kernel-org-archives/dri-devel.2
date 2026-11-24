Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AD606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=bxYhUHzb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEA8A10F44F;
	Tue, 24 Nov 2026 10:22:55 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4813B10F44F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:22:49 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-67da62357acso5686313d50.0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 02:22:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795515768; cv=none;
 d=google.com; s=arc-20260327;
 b=FwFVraKuGMioq8t5zvY9oB5JH4O4e24h5EZJ1jR4VCgGww3A+yASkRUYlRvwzaD0y/
 rLzJ1Yd23slPZDQrZBxWNl2VuCg7jM2NeUMXdQ1EccoAQOMEH7/QFbqNtxMmXmgCGBfd
 I/+vG3Z0ROaXXy69jx9Mn4T8z9ejgW9Jf8XDSGqXwomiCUDjAA2U+ErSJo+G383LmLuo
 dcqX7DMY16RnfNblHmglnLZhP7apNfk2TDMg+/giHX6F5QWtbD7nzkR8zpl8YIczxkzC
 fN7cESfH/+0nEZa3w0g0IBnjaDrEQ+yfPe1iTEZVip0PT5T2SRJlLlnsUy4Ul6tyNzcg
 i6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ejx0Vx6mlT/oh5f9iEeflN8sMqKcxSOCTfvOWvcm4hc=;
 fh=TteBAPju/SRfdoYuICvo1FCNqhHuK1Nj7pYOR2qHXGs=;
 b=I3SlCjPN2LNEX1eiUy/oxD/B9bDIJrArP/yAV/KF1ojt1KDkS6vTTG24mpHHCDCVcZ
 Qbzmuxk3Lx/doNHVslSAM8ApLfykYfEObMUkCQJzAAG626DHmA2MNXKQldL6tQlQnCN4
 OceEDd2qmQsWKpiDIMO/uC/wOqf3avqwIuSKhwhzH4QDOia1/Kvt6nzYKfTOcgoVa1ZG
 +zBxAHxKbZrEzwGfG+PAIEp2SV/AAcpJwcdHXxmIory+Cx6JULaqrIIfRUHeUHakwV5V
 07AIKKTlBrsQYgrf3fIjrzUFcqqjlvJUYkQWaoEhVEgod/MXQ8coc+f5Gj4a4ngZ467p
 grSw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795515768; x=1796120568;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ejx0Vx6mlT/oh5f9iEeflN8sMqKcxSOCTfvOWvcm4hc=;
 b=bxYhUHzbO4EeBkDa78CNjKOKXbjqF1+/M+7TAe2n2Q6MhfZBdypSbiaafDZFs84saB
 cgsDC6JLuVciagjNnl4uWpJqhyemB2ZFKBYsU3Qoz2wx9aJa+tumrWPKqKwauw0eNtgs
 BOXAbJnJKVFMaqyt05SaohkXrDO1TzO2TtMHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795515768; x=1796120568;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ejx0Vx6mlT/oh5f9iEeflN8sMqKcxSOCTfvOWvcm4hc=;
 b=nlfHH0XhtkhBm4Yzk5st+JxcpIjjtq7LlFw75KcGutXR5/BdSZahXTv7wE58hGGCqo
 J5QHh4Vf+eBArz1O9MNQSSuppBNjiULz1R5EH1dKCacYXbW+CPswvNlmHAp0nNytIzxk
 R4/HQRf01k9fXxXXBL9piE8Ghc4+Y3boGIG3oO8Oft2Grrx9R4Rd9SAxTnK0oVMV/E65
 EpfM/si6HxyBMRXG+IlQdzGzZfyP3W9BIujspu6ncwXBMbDtEk14aMxBzpUhZpYuur3N
 +vvQjOsLzJbhYioQXaGOW8SD/1XugCgg2u+ZoDBxmd2Az6NMGvVB9hdIRNYYMdYDSkUA
 1oDg==
X-Forwarded-Encrypted: i=1;
 AL+hErGimJiSUsLf94J2KsyhMPchkVKC9Ee1jNulSkkF2xcVPR0Re0xy5SO0G+0FpRH0Ig60H/60EwPoy94=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Kj/BhW/PhHsJ7+ulKhd9hQ1Pg8ersMhBvFA+6FsNL+RkxDig/
 P6lnUxGW0O69HQ9czz4koopx+TyTP03Vi3Xse76F1yC+q4BlcglT1XSaQhrYO0mr7DJAXGdZmzQ
 vwEjG/i5cKoG2LQyLFTzIVz0kJT85UjKd+YL9JG77
X-Gm-Gg: AZFdTZd4AEvaF9uy0F1gKRtEOmm8mG9dIh7Ao3XoJ7e9RVlB2/uGwfGWTTN8TXDKKCc
 9m58rr2wTr4dJDfgpk+F0ihrnC7Rc1yVvBNXtmkrmSsEHQWSOECp2ewcTkyCl+8Z589sJthfdvW
 Ilw6S1w7Wai9htgDDuJ926j7k09yxwyuxIcPhUm6UvK4QWzzs8Ek41vCKoYTU0/Md6zCwM9DeYN
 3siQCNtJl1M0WtNRGm5A1sqRX5TlyCkhjQ29603RiX6mnNRCSFYwSskLNvMVp9yuzY6podOMjlT
 Izg8p5GUyjoULeRG0MLLM79tGHA+TX55+qr3XnQti2g2LPVMcZKkBibMHCKrPTUN/gFgG1Lp282
 /vT0tFRLCL6EiVKrDBTuBGdkRsLtM6NFytRCvjRThL7f5JXlFHfYC4mS7aB3jAFLRYxY=
X-Received: by 2002:a05:690c:6e8c:b0:8a8:7e5a:dc2f with SMTP id
 00721157ae682-8b5204440fdmr67264947b3.12.1795515768163; Tue, 24 Nov 2026
 02:22:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124074041.115251-1-wenst@chromium.org>
 <20261124074041.115251-3-wenst@chromium.org>
 <19cd5949-05dc-4107-bd2b-d8ad1e2332eb@suse.de>
In-Reply-To: <19cd5949-05dc-4107-bd2b-d8ad1e2332eb@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 24 Nov 2026 18:22:37 +0800
X-Gm-Features: Aa3M54pNfcesZWo4EiEVJfs9QKzf9OEio3h9s-Qk4g3wBzB4RP2yK5vRHxNLzEQ
Message-ID: <CAGXv+5HSV7MJ96qTcOp+JaKWtmmYYWAmDROrT18pZ9PztNCJ-g@mail.gmail.com>
Subject: Re: [PATCH RFT v3 2/5] drm/fb-dma-helper: Add
 drm_fb_dma_get_gem_clipped_addr()
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
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 3:57=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 24.11.26 um 08:39 schrieb Chen-Yu Tsai:
> > drm_fb_dma_get_gem_addr() returns the DMA address to the "unclipped"
> > framebuffer. However some display drivers want the "clipped" framebuffe=
r
> > instead, as they are also using the clipped coordinates to program the
> > hardware.
> >
> > Some of these drivers are open-coding drm_fb_dma_get_gem_addr() with
> > the source coordinates replaced, while others have been incorrectly
> > converted to using drm_fb_dma_get_gem_addr(), which would end up
> > causing incorrect parts of the framebuffer to be displayed if it were
> > somehow clipped.
> >
> > Add drm_fb_dma_get_gem_clipped_addr(), a "clipped" version of
> > drm_fb_dma_get_gem_addr() for these drivers to use.
> >
> > Cc: <stable@vger.kernel.org> # dependency for next patch
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - Use new drm_framebuffer_get_block_offset() helper
> > ---
> >   drivers/gpu/drm/drm_fb_dma_helper.c | 37 +++++++++++++++++++++++++---=
-
> >   include/drm/drm_fb_dma_helper.h     |  4 ++++
> >   2 files changed, 37 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_=
fb_dma_helper.c
> > index ab0f37d8a5ff..0aaf4926db4e 100644
> > --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> > @@ -60,15 +60,16 @@ struct drm_gem_dma_object *drm_fb_dma_get_gem_obj(s=
truct drm_framebuffer *fb,
> >   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_obj);
> >
> >   /**
> > - * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for framebuffer, =
for pixel
> > - * formats where values are grouped in blocks this will get you the be=
ginning of
> > - * the block
> > + * drm_fb_dma_get_gem_addr() - Get DMA (bus) address for unclipped fra=
mebuffer,
> > + * for pixel formats where values are grouped in blocks this will get =
you the
> > + * beginning of the block
> >    * @fb: The framebuffer
> >    * @state: Which state of drm plane
> >    * @plane: Which plane
> > - * Return the DMA GEM address for given framebuffer.
> >    *
> >    * This function will usually be called from the PLANE callback funct=
ions.
> > + *
> > + * Return: GEM DMA address for given framebuffer, unclipped.
> >    */
> >   dma_addr_t drm_fb_dma_get_gem_addr(struct drm_framebuffer *fb,
> >                                  struct drm_plane_state *state,
> > @@ -86,6 +87,34 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_frameb=
uffer *fb,
> >   }
> >   EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
> >
> > +/**
> > + * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for clipp=
ed
> > + * framebuffer, for pixel formats where values are grouped in blocks t=
his
> > + * will get you the beginning of the block
> > + * @fb: The framebuffer
> > + * @state: Which state of drm plane
> > + * @plane: Which plane
> > + *
> > + * This function will usually be called from the PLANE callback functi=
ons.
>
> You should mention what clipping means in this context. It's not obvious
> what it's clipping against. Or maybe point to other docs that explain it.

What about:

/**
 * drm_fb_dma_get_gem_clipped_addr() - Get DMA (bus) address for the start
 * of the visible (CRTC-clipped) part of the framebuffer
 * @fb: The framebuffer
 * @state: Which state of drm plane
 * @plane: Which plane
 *
 * A plane may be positioned partially off-screen, in which case it gets
 * clipped to the visible CRTC area by drm_atomic_helper_check_plane_state(=
)
 * (populating the clipped coordinates in &drm_plane_state.src and
 * &drm_plane_state.dst). For example, if a plane extends past the left or
 * top edge of the screen, only its right and/or bottom portion is visible.
 * Drivers whose hardware cannot clip by itself (i.e. accept negative
 * destination coordinates) should use this helper instead of
 * drm_fb_dma_get_gem_addr() so scanout starts from the visible portion of
 * the framebuffer.
 *
 * For pixel formats where values are grouped in blocks, this returns the
 * beginning of the block.
 *
 * This function will usually be called from the PLANE callback functions.
 *
 * Return: GEM DMA address for the visible part of the framebuffer.
 */

> > + *
> > + * Return: GEM DMA address for given framebuffer, clipped.
> > + */
> > +dma_addr_t drm_fb_dma_get_gem_clipped_addr(struct drm_framebuffer *fb,
> > +                                        struct drm_plane_state *state,
> > +                                        unsigned int plane)
> > +{
> > +     struct drm_gem_dma_object *obj;
> > +
> > +     obj =3D drm_fb_dma_get_gem_obj(fb, plane);
> > +     if (!obj)
> > +             return 0;
> > +
> > +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, plane=
,
> > +                                                             state->sr=
c.x1 >> 16,
> > +                                                             state->sr=
c.y1 >> 16);
>
> I had to look several times to spot the difference to the regular

I suppose I should add a comment to make the difference more visible:

    /* Use clipped source coordinates state->src.[xy]1 instead ->src_[xy] *=
/

> helper. In any case
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

If the changes above are acceptable to you I'll send out a new version
with your tag kept.


Thanks
ChenYu
