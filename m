Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4E6C55822
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5B110E625;
	Mon,  3 Aug 2026 17:25:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GFTEUWkm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F39210E36D
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:25:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 709F743F71
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:25:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5183B1F00ADF
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785777924;
 bh=f8Wl8glcfw9dwbeP1JywUt3GNYgmfkhCQveycZVpS4Y=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=GFTEUWkmu2NCm4po3VjBMuGvVHYDGUBNmMaXilf0mY7UiI11PCXNoSowwKYofYwuG
 a94uOifcgZdGu4a8vv7o/Cl86Eiyf+4BdVRXzdwratD0+v1CZ8dDIIZmmYPUiHlXCA
 rpXFLEDhUdpVbg9W6F2dyCd7bbnM4dYvkIeSulNt4QJEPd+U92q/2f8fwiRHpaAfU+
 j/NbMgtA5vXrIuVdGBYH4Me0aHnfGqmk6QmNluqfzByvNi42EN8SqYej3sR6iTBE1S
 f6OoD5z62DgI7yTUygaubHXGcNTf9W0u8oYL5TdZiwbfOE6KJZf4rsJeudLtWCVPbm
 KAWasP5FyLHkw==
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-39f927721f2so11794251fa.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 10:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RoEBMangrmhAmXnXJFxb6bktCdw627LqHSp8V//0uVUYHX4Dw2sJe1pmweNCr0wjZMjVRs5xo/Gx7U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8MbfbiiYaEXDrsQCAqy3H4FbhKX/tQtoDIoN8KW/P1wga7QPs
 /08NiRmZ6VJfB4QKRdnGYj7Moy6agPj58vkHcmuJAdxx71SpmC+sF529WIhyhPw2BPG5uwk4M4K
 +lj+ADy9qOeovajulZZRFIALtxFC6HaE=
X-Received: by 2002:a2e:bc23:0:b0:39c:99e9:da37 with SMTP id
 38308e7fff4ca-39f86105917mr20611141fa.1.1785777922694; Mon, 03 Aug 2026
 10:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <3980ea1aeb3f7fe8b4700e36560deeba3d050664.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 01:25:09 +0800
X-Gmail-Original-Message-ID: <CAGb2v66E95PwYhdPC4mkX1htF2VXECiGwUHfzLHV2ydOMiwxrg@mail.gmail.com>
X-Gm-Features: AUfX_my_BxERgV_M62Gj1-mbWsAsqDTo5FE1B6VdIoWAAMqmFyEPjHTvoGE-COI
Message-ID: <CAGb2v66E95PwYhdPC4mkX1htF2VXECiGwUHfzLHV2ydOMiwxrg@mail.gmail.com>
Subject: Re: [PATCH 13/13] drm/sun4i: Align VI buffer addresses for subsampled
 formats
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
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
Reply-To: wens@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Aug 4, 2026 at 12:11=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> This is a partial revert of commit 79ac1c945ab8 ("drm/sun4i: layers:
> Use drm_fb_dma_get_gem_addr() to get display memory").
>
> Chroma must start at the beginning of a subsampling block, for example
> chroma start address for NV12 must be aligned to 2 pixels.
> drm_fb_dma_get_gem_addr() offsets luma by the exact source coordinates
> and chroma by the coordinates divided by the subsampling factor, so for
> odd offsets both planes no longer describe the same pixel, which the
> Display Engine scaler can't handle.
>
> Align source coordinates down for all planes instead. Remaining shift
> of one pixel is already compensated with scaler phase shift in
> sun8i_vi_layer_update_coord().

Well I think this applies to the format in general, and probably should
be fixed in drm_fb_dma_get_gem_addr() instead?

> Fixes: 79ac1c945ab8 ("drm/sun4i: layers: Use drm_fb_dma_get_gem_addr() to=
 get display memory")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun=
4i/sun8i_vi_layer.c
> index 09f668c8af24..ad036cb9d88e 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -197,15 +197,31 @@ static void sun8i_vi_layer_update_buffer(struct sun=
8i_layer *layer,
>         struct drm_plane_state *state =3D plane->state;
>         struct drm_framebuffer *fb =3D state->fb;
>         const struct drm_format_info *format =3D fb->format;
> +       struct drm_gem_dma_object *gem;
> +       u32 dx, dy, src_x, src_y;
>         dma_addr_t dma_addr;
>         u32 ch_base;
>         int i;
>
>         ch_base =3D sun8i_channel_base(layer);
>
> +       /* Adjust x and y to be divisible by subsampling factor */
> +       src_x =3D (state->src.x1 >> 16) & ~(format->hsub - 1);
> +       src_y =3D (state->src.y1 >> 16) & ~(format->vsub - 1);

AFAICT the only difference compared to drm_fb_dma_get_gem_addr()
is the masking here, i.e. round_down().

> +
>         for (i =3D 0; i < format->num_planes; i++) {
> -               /* Get the start of the displayed memory */
> -               dma_addr =3D drm_fb_dma_get_gem_addr(fb, state, i);
> +               gem =3D drm_fb_dma_get_gem_obj(fb, i);
> +               dma_addr =3D gem->dma_addr + fb->offsets[i];
> +
> +               dx =3D src_x;
> +               dy =3D src_y;
> +               if (i > 0) {
> +                       dx /=3D format->hsub;
> +                       dy /=3D format->vsub;
> +               }
> +
> +               dma_addr +=3D dx * format->cpp[i];
> +               dma_addr +=3D dy * fb->pitches[i];


Where as the helper has (or used to have before the blocksize stuff):

    paddr +=3D (format->cpp[plane] * (state->src_x >> 16)) / fb->format->hs=
ub;
    paddr +=3D (fb->pitches[plane] * (state->src_y >> 16)) / fb->format->vs=
ub;

Am I missing something?


ChenYu

>
>                 /* Set the line width */
>                 DRM_DEBUG_DRIVER("Layer %d. line width: %d bytes\n",
> --
> 2.43.0
>
