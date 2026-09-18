Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2508FC982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9E710E28D;
	Fri, 18 Sep 2026 07:07:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QaLmFPpA";
	dkim-atps=neutral
Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com
 [74.125.224.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59D7610E28D
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:07:04 +0000 (UTC)
Received: by mail-yx2-f12.google.com with SMTP id
 956f58d0204a3-670fee39d73so435278d50.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 00:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789715223; cv=none;
 d=google.com; s=arc-20260327;
 b=KoUXANeMb7cZwAgL4pi6X/ctKpWLc0gEQugGDRKs3adB3PEgIzXeGtOTrOdn6bz5m4
 1AiyUfdGWwUjLb7ykqaC09CQ3YW4GX+UFL1vYegZCeU3YqiXfuQh7WLVK4whrzKpR47A
 jgsL4cl9sARaRJvY6MWvGE+SJ2LrNLiMkzNp6Skwl81dkyRchXBuPuUhXbj6TL6IzHOW
 Zz/q/3CnZ9x/OLTWaG0+KV8k1Wlz7AQR8hncbbuqbBfQCyXnT1IrN/tdqgrvTQmKX1V6
 ieSJa/j84oQLtLz5q/iDYtoHWh2yNhq1oc0jPVYYY0zLrXCIqj8FvWDX0KKAqLDuqH8U
 m9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZVTLUeibsWBPZCdD+qqGVF/fmQVK7DA4WjMhu8zs7u0=;
 fh=0K2xxu1RDHokpKC51ZQZX2p8BUU4mX/INSYTUoq2zYc=;
 b=IlER9ZQKg2Cd+XBbykCndaT9FA9PGskdEvXKQGC82TItSciWTmTghLO/2EbRfXfX4j
 D1fNNpFVH7KliPmGLKs/DJuGEsD2bSllj8P1oQT5z6hXTFfZ9CRk0oYguTB18u8dIDtS
 TNWddD9J7LLHUxyXtkQNub3d9GC50Pptuy7xgGPzo/CQi+2RDrIN67n0S3Fx9DMBAQVt
 Bbb38+FkSr8nbTAHoKKnElMF9+WmqQxaO+SpmsViu8KOErUclbGBk7H1alNIyVx5HlWt
 OrP6cd/NlzPTAzZKkVilB/9qBqLgfE8UcuvKjDFZtz64tIdZ6mpcbeqP79Y1MReV2xlv
 RY9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789715223; x=1790320023;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZVTLUeibsWBPZCdD+qqGVF/fmQVK7DA4WjMhu8zs7u0=;
 b=QaLmFPpAz+jgVeGE/uWyKK1gKxZ3c90Q3g1tozuxdQ+8vWlFI75V0kG3KgwA38wPtg
 wmu/47Y7UrV+h97x5mHx1PToviDidZakMdDngMJ5Td+ZykiwlAYRKHAwrKxxny5bu8mC
 ahG2UMtMqfLfM+tYYm0XpTAeB0bvwcIN0Oahc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789715223; x=1790320023;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZVTLUeibsWBPZCdD+qqGVF/fmQVK7DA4WjMhu8zs7u0=;
 b=R5nZswRskOC/FU6oEnlbeJ5TdprsLcuN/AOgpLh7WTUb+FJmQP15Jdsz6oSGTLru+N
 3dOZLrn+K8gaBu21HYKYODvybdyMiVEHX4MwkpKrnCG5Bnu6PaMkKd9y7h1FrxvKJn9H
 0gibCRYXUjNxFDmqWy1JS81gG4Qk3H7FYt18ODupuWqSnujk9jxLCqHW4Zxm3gQns6jQ
 bxBqIqkOscvS1js+GYU8qTijpVTW7E9naDu7lMDvL25f24+6DDgM5vWKzvJSm4IWEYq9
 oo8tNcd/RDsWrXLN0GMHVGYDnvKpLi5xN+HGW9x8GwrJofqV32SjP7cKh0/M2RcpLdxv
 /WCw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJt4BzNq+6f3s10YyNTUGsbasSFplxwToAmeBH+aP+n1ipzeVriloTtAkxKQCrn88r9eMRxC1sQwY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lxHzkqE3E91BRb2PqKvyqIRwW4pp8Nmm4in2im9ZOqTaHSIA+e
 jolNEyPU959yGmeVbmQ8sQkGHq7qDDdnJ89ap2uIDOPuFg8/YCvmciDSXcFUEV0ttBco+hX+OpU
 2R74HiefUPhearL8LQPqmo3B5e6Em8iumWDrQjVUp
X-Gm-Gg: AYBFou2q5jjrKoKZ9g+KTxiBSxjuIpWfwHd8cUsJ3PL/n6p0l0o66aUyYRozP8OFEla
 iBezNbdAzFN6G+neAKyLyMqDMbh1uwrvXv40WUHe3TuINWMZ0r8wIaK+kREMRM3B9RGWtZLcbky
 +xjBS9DjSymVQuX89lrpkgZQyaa1VQcRoQS6tUHK+QtEji6ls6P7fB6gsu85ixUUuvZPAquExg6
 p6mySTozE8avxd39tncDxpQFpaTw7A+RjrFY5qVw/HzMI+udDzdiEbaGBn+EUvkFtuMbW+F1fdS
 oWXFH7i9CKocC+iAwygkkRsO3zt1hpm7R/O3KySUVP40K96Gcss28Qc/TDdoDeguy5s51mQLK8Y
 0IEF9pjxjZA==
X-Received: by 2002:a05:690e:c4d:b0:671:7b0:e5ce with SMTP id
 956f58d0204a3-6717fdf1073mr497902d50.75.1789715223118; Fri, 18 Sep 2026
 00:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260916033327.3054126-1-wenst@chromium.org>
 <20260916033327.3054126-2-wenst@chromium.org>
 <f6ace486-70d8-4e81-89cb-e9d55ad9ac8b@suse.de>
 <CAGXv+5ErgWVNtnRiW+QA7+Mzh=W_Y+HGL_iRa1fOaXCYSoAwMA@mail.gmail.com>
 <f7fa4c4c-bc59-4822-94bb-6e9d68f8f0ca@suse.de>
In-Reply-To: <f7fa4c4c-bc59-4822-94bb-6e9d68f8f0ca@suse.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 18 Sep 2026 15:06:51 +0800
X-Gm-Features: AcwNN1VLg__gblp0p9qUFHinFpHutsjL-_8trTnXduaSEQp1OhTN0-X1tjhNQaU
Message-ID: <CAGXv+5GNjKxzHuBn28PbRtbFA1yuJ7h02xDpght4add3emuKJg@mail.gmail.com>
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

On Fri, Sep 18, 2026 at 2:41=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 18.09.26 um 06:16 schrieb Chen-Yu Tsai:
> > On Thu, Sep 17, 2026 at 11:20=E2=80=AFPM Thomas Zimmermann <tzimmermann=
@suse.de> wrote:
> >> Hi
> >>
> >> Am 16.09.26 um 05:33 schrieb Chen-Yu Tsai:
> >>> Currently drm_fb_dma_get_gem_addr() calculates the offset into the
> >>> framebuffer memory for the framebuffer's unclipped source coordinates=
,
> >>> adds that to the framebuffer's backing storage, and returns the resul=
t.
> >>>
> >>> We are about to add a variant that uses the clipped source coordinate=
s,
> >>> so there is already some reuse of code. However, calculating the data
> >>> offset for a given pixel is not specific to the DMA FB helpers. The
> >>> offset is only related to the framebuffer.
> >>>
> >>> Split out the offset calculation into a new framebuffer helper so tha=
t
> >>> non-DMA users can also reuse the same code.
> >>>
> >>> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> >>> Cc: <stable@vger.kernel.org> # dependency for next patch
> >>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >>> ---
> >>> Changes since v1:
> >>> - New patch
> >>> ---
> >>>    drivers/gpu/drm/drm_fb_dma_helper.c | 28 ++----------------
> >>>    drivers/gpu/drm/drm_framebuffer.c   | 45 +++++++++++++++++++++++++=
++++
> >>>    include/drm/drm_framebuffer.h       |  3 ++
> >>>    3 files changed, 51 insertions(+), 25 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/dr=
m_fb_dma_helper.c
> >>> index fd71969d2fb1..ab0f37d8a5ff 100644
> >>> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> >>> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> >>> @@ -75,36 +75,14 @@ dma_addr_t drm_fb_dma_get_gem_addr(struct drm_fra=
mebuffer *fb,
> >>>                                   unsigned int plane)
> >>>    {
> >>>        struct drm_gem_dma_object *obj;
> >>> -     dma_addr_t dma_addr;
> >>> -     u8 h_div =3D 1, v_div =3D 1;
> >>> -     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> >>> -     u32 block_h =3D drm_format_info_block_height(fb->format, plane)=
;
> >>> -     u32 block_size =3D fb->format->char_per_block[plane];
> >>> -     u32 sample_x;
> >>> -     u32 sample_y;
> >>> -     u32 block_start_y;
> >>> -     u32 num_hblocks;
> >>>
> >>>        obj =3D drm_fb_dma_get_gem_obj(fb, plane);
> >>>        if (!obj)
> >>>                return 0;
> >>>
> >>> -     dma_addr =3D obj->dma_addr + fb->offsets[plane];
> >>> -
> >>> -     if (plane > 0) {
> >>> -             h_div =3D fb->format->hsub;
> >>> -             v_div =3D fb->format->vsub;
> >>> -     }
> >>> -
> >>> -     sample_x =3D (state->src_x >> 16) / h_div;
> >>> -     sample_y =3D (state->src_y >> 16) / v_div;
> >>> -     block_start_y =3D (sample_y / block_h) * block_h;
> >>> -     num_hblocks =3D sample_x / block_w;
> >>> -
> >>> -     dma_addr +=3D fb->pitches[plane] * block_start_y;
> >>> -     dma_addr +=3D block_size * num_hblocks;
> >>> -
> >>> -     return dma_addr;
> >>> +     return obj->dma_addr + drm_framebuffer_get_block_offset(fb, pla=
ne,
> >>> +                                                             state->=
src_x >> 16,
> >>> +                                                             state->=
src_y >> 16);
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(drm_fb_dma_get_gem_addr);
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_framebuffer.c b/drivers/gpu/drm/drm_=
framebuffer.c
> >>> index d32aceb6ca9b..9e1231162047 100644
> >>> --- a/drivers/gpu/drm/drm_framebuffer.c
> >>> +++ b/drivers/gpu/drm/drm_framebuffer.c
> >>> @@ -1208,6 +1208,51 @@ void drm_framebuffer_print_info(struct drm_pri=
nter *p, unsigned int indent,
> >>>        }
> >>>    }
> >>>
> >>> +/**
> >>> + * drm_framebuffer_get_block_offset() - Get offset to start of pixel=
 block for
> >>> + * the given framebuffer and coordinates.
> >>> + * @fb: The framebuffer
> >>> + * @plane: Which plane
> >>> + * @x: x coordinate for pixel
> >>> + * @y: y coordinate for pixel
> >>> + *
> >>> + * This function will usually be called from the PLANE callback func=
tions,
> >>> + * or from one of the helpers that calculates the framebuffer's DMA =
address.
> >>> + *
> >>> + * Return: offset from start of framebuffer to start of pixel block
> >>> + */
> >>> +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, uns=
igned int plane,
> >>> +                                  unsigned int x, unsigned int y)
> >> Better use u64 as return type.
> > To avoid overflow? Not sure who would use crazy large framebuffers, but
> > doesn't hurt to play it safe.
>
> I'd be worried about a malicious user space that tries to access OOB.
>
> Apart from that, we use u64 for other framebuffer-related sizes like
> pitch calculations or dma addresses. Using u64 here would keep that
> consistent.

Indeed. It seemed weird that the helper originally used u32. Maybe it
was carried over from CMA on ARMv7, which predominantly only had
32-bit address space data busses?

>
> >
> >>> +{
> >>> +     u8 h_div =3D 1, v_div =3D 1;
> >>> +     u32 block_w =3D drm_format_info_block_width(fb->format, plane);
> >>> +     u32 block_h =3D drm_format_info_block_height(fb->format, plane)=
;
> >>> +     u32 block_size =3D fb->format->char_per_block[plane];
> >>> +     u32 sample_x;
> >>> +     u32 sample_y;
> >>> +     u32 block_start_y;
> >>> +     u32 num_hblocks;
> >>> +     u32 offset;
> >>> +
> >>> +     offset =3D fb->offsets[plane];
> >>> +
> >>> +     if (plane > 0) {
> >>> +             h_div =3D fb->format->hsub;
> >>> +             v_div =3D fb->format->vsub;
> >>> +     }
> >>> +
> >>> +     sample_x =3D x / h_div;
> >>> +     sample_y =3D y / v_div;
> >>> +     block_start_y =3D (sample_y / block_h) * block_h;
> >>> +     num_hblocks =3D sample_x / block_w;
> >>> +
> >>> +     offset +=3D fb->pitches[plane] * block_start_y;
> >>> +     offset +=3D block_size * num_hblocks;
> >> User space controls the values in fb->offsets and fb->pitches.  I'm no=
t
> >> sure how well they have been validated already at this point. Did you
> >> investigate this?
> > It wouldn't be worse than before, since this changes is purely code mov=
ement.
> >
> > There are minimal sanity checks done by drm_internal_framebuffer_create=
()
> > in framebuffer_check(), such as offset overflow or pitch size too small=
,
> > but that's about it. It would be up to individual drivers to perform mo=
re
> > checks that match their hardware limitations.
>
> Right, makes sense. Looking through the framebuffer validation, a
> buffer-size check could be done in framebuffer_check().  But that's
> another patch series.

That's further covered by drm_gem_fb_init_with_funcs(), which
drm_gem_fb_create*() goes into. I didn't check all the drivers that
implemented their own .fb_create callback though.

- rockchip uses the GEM FB helpers
- MSM reimplements the GEM FB helpers, but does have proper size checks
- nouveau has size checks
- omap has size checks

> >
> > What sort of issues are you thinking about?
>
> Again, I'm thinking of malicious user space that crafts these values to
> force an OOB access.

I think we're covered.


Thanks
ChenYu

> Best regards
> Thomas
>
>
> >
> >
> > ChenYu
> >
> >> Best regards
> >> Thomas
> >>
> >>
> >>> +
> >>> +     return offset;
> >>> +}
> >>> +EXPORT_SYMBOL(drm_framebuffer_get_block_offset);
> >>> +
> >>>    #ifdef CONFIG_DEBUG_FS
> >>>    static int drm_framebuffer_info(struct seq_file *m, void *data)
> >>>    {
> >>> diff --git a/include/drm/drm_framebuffer.h b/include/drm/drm_framebuf=
fer.h
> >>> index 38b24fc8978d..c07aea1cc59f 100644
> >>> --- a/include/drm/drm_framebuffer.h
> >>> +++ b/include/drm/drm_framebuffer.h
> >>> @@ -220,6 +220,9 @@ void drm_framebuffer_remove(struct drm_framebuffe=
r *fb);
> >>>    void drm_framebuffer_cleanup(struct drm_framebuffer *fb);
> >>>    void drm_framebuffer_unregister_private(struct drm_framebuffer *fb=
);
> >>>
> >>> +u32 drm_framebuffer_get_block_offset(struct drm_framebuffer *fb, uns=
igned int plane,
> >>> +                                  unsigned int x, unsigned int y);
> >>> +
> >>>    /**
> >>>     * drm_framebuffer_get - acquire a framebuffer reference
> >>>     * @fb: DRM framebuffer
> >> --
> >> --
> >> Thomas Zimmermann
> >> Graphics Driver Developer
> >> SUSE Software Solutions Germany GmbH
> >> Frankenstr. 146, 90461 N=C3=BCrnberg, Germany, www.suse.com
> >> GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG N=C3=BCrnberg)
> >>
> >>
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
