Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F68DCD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A505611A9E4;
	Fri,  5 Jun 2026 16:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="72fCQW7T";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B3911A9E4
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 16:57:45 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-bec3ffb95dbso352295566b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 09:57:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780678664; cv=none;
 d=google.com; s=arc-20240605;
 b=HdTtl2hZyWhMR0GKnQBcG3hrfD7kfdEmBIUC0SyrBUzq7wjo+IrZ4uF9OZQjxEvA0y
 D33pNSHivL+39025tFbGUitJk+WNU9yEUXxbPf61PZtL8fVQRFgdMk4HTcLwlLi12JVs
 pzAUZpifF4LYi1kD14iWmNSf7epggsJKUGHt/2y9et4drfeovflToMKDLTZXPbFWP8Zv
 Zqd5OCoAFuQIF5VNiFBlQUNS4C/uoDATshxIZs6vU3lCPPo9yliyQacdlkcB7CIYKuXp
 6hxlH9ItbzczjU62qahHmGnoh2w2Yfg0N/XcajSRl8EMMR3td6mvy2Mb5zLtCSEjogWY
 maCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t9Q2reB/yZPpZ8/eSn50xdc+8VSCDBGfUYlb4VIhsU0=;
 fh=zAS/Pl1pDQ4dcjNenRCM9fiNn1yZMeZO9SXh7UDvlms=;
 b=Ky2iKRRkqDeWX9xpohw+GDg4gkt3J2n8U3j7HaY9RIrRo9uMHrn7Qq1iRGZQB9Jv21
 TOCHYlLUzq1usialKQXUtuzoQatBDy9vxyALLB4QdS44RIuaIOkDbOsCYKZ+EmKlT+oH
 LuNCZQ3pqbxfFr1AUHPSJvxpmTWXHtlDLhYPcJLe0FqtgSVZaxZ5+iG0XUk5XGINd4P8
 KnpfuJHP86jhUU8yREL2N+a+hWXKS4nuyF9vNaQXzEXs8K1U0eIlHYPexQVYZFl7eIQJ
 qQ6esG/bHBK5rPc3gQtBZ7Ukp5xE+whoD/U/nDilIIHtIVPH33K54W45dQu+TVrIDb4l
 P42g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780678664; x=1781283464; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9Q2reB/yZPpZ8/eSn50xdc+8VSCDBGfUYlb4VIhsU0=;
 b=72fCQW7TTCixc+CK9z81fePEcmeJ8KNerAM7x4tExLilzTGXdlu1pABxO//jqUlFkp
 P0FggQxPFxPF8hBItvw3ZOop7pyVCufwcHU2nfnj2jRegnMRpe+LUgtWvFPthhRKKYLW
 GhyVq/WJR0rje9U6wEXwjSuFkNo/rQpkDai0YDvSJbYz6dhfskgQ8mB1QTx8wGu8HNMH
 LamJL5c/DFnccOYCX7/iUyb5VcK5DVHT6vL2QzccsS4HalkvzEp5/zYlgIQn1ZiFrdK+
 iJVdipmudM1gQWcu8jUmFSv9rgEDAilCInQG3+OLfCuEeixUfoKxWQVj1zjj36zYV5Qd
 sThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780678664; x=1781283464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9Q2reB/yZPpZ8/eSn50xdc+8VSCDBGfUYlb4VIhsU0=;
 b=U8A4Bgl3ECGfxAthHAVhvcwhA6axD9KPbAPnBf//jKDjlPNMjto/r4DN5sLYwW7I8h
 xuvIIMHd3n5SQWDxykvUvpm2Ycl3q8k603tkFtseTVYvOhJoEGlfjUJpxQ4EFIt23v2N
 xxUB1Q7tUCcnIKWFLK7nVoyIw6OKpqNZM2nsyu4vCT/dWXjFKtkpbYYOA9FNUvnYIuDh
 BzHq9ojADDyykMuB5wTXjUG3J65L6/AyiC8YnS+ifYcA//8CeZj2QBD0e5AX1vsOdoUt
 t8YgP6JOwoFVp5UNZ7+ih3Sr21yRq3ZuI4/ijDW8gnZxQJTa5hB3i4BMlc4d+c0by3mP
 +wXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+caf6t/LYwLlABqiOHgYL071N9Xzs1z4orqxEuqPlg2IeRJ5cIqS8tezDQW5CE+u6USpyjbNuZW9M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcRlF/BqFdf7RaHb2lYu4A3qaFMXb9urdcisEdp2Yr2jjaXRt2
 rpUtWbHW7N0+62R+COfVaXkaHyuq8QYyzQCwYLiQeRNH8tNbxbMnRzzlBMZ02POrJuOv1oVJCc8
 2kAl5Bb+KXQkDbfGmcWfKIW4ZmPz6rConHeMEbsaLWg==
X-Gm-Gg: Acq92OEF6hR/2lu6h1LbUZePMTsa96+cWieaWiRZ5V6RQBFe6Zvw3riCz9TUxblZkPp
 wZURHOIfSYVT8qGQs7+3S7t6JsZXU1nnh36e/8XH5m6Pf3k+PXQ3I2jn6MFk+mdfa20wL8AfqRv
 vCr7SkOYQP0Oejvu0JH3wfk3KDCGyqMuH1CfEAvxDwZwPbxMxdgn6BKENFaAwZMaJV0WHp8F7bb
 KkNEe2DAi6FCh1hrQjM4U+zYheRFwFGW6mPZzmKfAaJ+NK8S7iYH6Mr8BoTHekiCmAwdah/6vcN
 BTWjIpIhU1Y3FORKIReByC+xSlhhR8SvIx+ZWJV/CJFCzoenMpA=
X-Received: by 2002:a17:907:6eac:b0:bee:e2a2:bdbf with SMTP id
 a640c23a62f3a-bf37234cfe1mr246835966b.29.1780678663320; Fri, 05 Jun 2026
 09:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-vop2-clk-rate-check-v2-1-b207cfc427d7@collabora.com>
 <CABjd4Yw_HYpjhrgmonB9FmWV00q=r3yvqnFE4TXEHpM1ZgWOhA@mail.gmail.com>
In-Reply-To: <CABjd4Yw_HYpjhrgmonB9FmWV00q=r3yvqnFE4TXEHpM1ZgWOhA@mail.gmail.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Fri, 5 Jun 2026 20:57:33 +0400
X-Gm-Features: AVVi8CeLjRpF5Sxm7pNUsioQchN9UZhAfu68dWtF3YAmYUc88EGpBg5CfEN24ZY
Message-ID: <CAKTNdwE-qYFiNpn1b9Zy=vjf0QO3JXF_ofp=b5x1-n9Q2WaMCg@mail.gmail.com>
Subject: Re: [PATCH RFC v2] drm/rockchip: vop2: Add clock rate mode check
To: Alexey Charkov <alchark@gmail.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com
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

On Fri, Jun 5, 2026 at 7:58=E2=80=AFPM Alexey Charkov <alchark@gmail.com> w=
rote:
>
> On Fri, Apr 10, 2026 at 2:37=E2=80=AFAM Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > The display might offer modes, which exceed the maximum clock rate of a
> > video output. This usually happens for displays that offer refresh rate=
s
> > above 60 Hz. This results in no picture (or a broken one) being display=
ed
> > without manual intervention. Fix this by teaching the driver about the
> > maximum achievable clock rates for each video port.
> >
> > The information about the maximum clock rates for each video channel an=
d
> > the tip about multiple pixels being processed per clock were provided b=
y
> > Andy Yan and roughly checked against the information available in the
> > datasheet (which specifies limits like "2560x1600@60Hz with 10-bit"
> > instead of a specific pixel rate).
> >
> > For the video ports supporting a 600 MHz input clock, there is some
> > logic to handle up to 4 pixels in parallel when needed resulting in
> > the extra multiplier.
> >
> > Suggested-by: Andy Yan <andy.yan@rock-chips.com>
> > Link: https://lore.kernel.org/linux-rockchip/1528d788.186b.19d08ed974c.=
Coremail.andyshrk@163.com/
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> > I've kept the RFC tag, as I'm not sure about the 4x parallel pixel
> > processing. IIUIC all of the video ports with a maximum of 600 MHz
> > input clock support it, considering they can go to 4K @ 120Hz,
> > which is above 1.2GHz while Andy mentioned a max. support clock rate
> > of 600 MHz.
> > ---
> > Changes in v2:
> > - Link to v1: https://lore.kernel.org/r/20260217-vop2-clk-rate-check-v1=
-1-989b569119ba@collabora.com
> > - based on v7.0-rc7
> > - rename max_clock_rate into max_pixel_clock_rate to distinguish from
> >   input clock
> > - update max clock rates to the numbers provided by Andy Yan with
> >   extra 4x multiplier for 4K 120Hz VPs
> > ---
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c |  3 +++
> >  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
> >  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 10 ++++++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu=
/drm/rockchip/rockchip_drm_vop2.c
> > index a195f5c819a2..35a0edda5375 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> > @@ -1434,6 +1434,9 @@ static enum drm_mode_status vop2_crtc_mode_valid(=
struct drm_crtc *crtc,
> >         if (mode->hdisplay > vp->data->max_output.width)
> >                 return MODE_BAD_HVALUE;
> >
> > +       if (mode->clock > vp->data->max_pixel_clock_rate / 1000)
> > +               return MODE_CLOCK_HIGH;
> > +
> >         return MODE_OK;
> >  }
> >
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu=
/drm/rockchip/rockchip_drm_vop2.h
> > index 9124191899ba..fd46913f3346 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> > +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> > @@ -225,6 +225,7 @@ struct vop2_video_port_data {
> >         u16 gamma_lut_len;
> >         u16 cubic_lut_len;
> >         struct vop_rect max_output;
> > +       u32 max_pixel_clock_rate;
> >         const u8 pre_scan_max_dly[4];
> >         unsigned int offset;
> >         /**
> > diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu=
/drm/rockchip/rockchip_vop2_reg.c
> > index f3950e8476a7..6ae3d506c476 100644
> > --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> > +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> > @@ -559,18 +559,21 @@ static const struct vop2_video_port_data rk3568_v=
op_video_ports[] =3D {
> >                 .gamma_lut_len =3D 1024,
> >                 .cubic_lut_len =3D 9 * 9 * 9,
> >                 .max_output =3D { 4096, 2304 },
> > +               .max_pixel_clock_rate =3D 600000000U,
> >                 .pre_scan_max_dly =3D { 69, 53, 53, 42 },
> >                 .offset =3D 0xc00,
> >         }, {
> >                 .id =3D 1,
> >                 .gamma_lut_len =3D 1024,
> >                 .max_output =3D { 2048, 1536 },
> > +               .max_pixel_clock_rate =3D 200000000U,
> >                 .pre_scan_max_dly =3D { 40, 40, 40, 40 },
> >                 .offset =3D 0xd00,
> >         }, {
> >                 .id =3D 2,
> >                 .gamma_lut_len =3D 1024,
> >                 .max_output =3D { 1920, 1080 },
> > +               .max_pixel_clock_rate =3D 150000000U,
> >                 .pre_scan_max_dly =3D { 40, 40, 40, 40 },
> >                 .offset =3D 0xe00,
> >         },
> > @@ -775,6 +778,7 @@ static const struct vop2_video_port_data rk3576_vop=
_video_ports[] =3D {
> >                 .gamma_lut_len =3D 1024,
> >                 .cubic_lut_len =3D 9 * 9 * 9, /* 9x9x9 */
> >                 .max_output =3D { 4096, 2304 },
> > +               .max_pixel_clock_rate =3D 600000000U * 4,
>
> Hi Sebastian,
>
> I've tested it on a bunch of different displays with RK3576 while also
> giving VP0 an unlimited PLL to work with (and also expanding its rates
> table for each of the displays' EDID preferred pixel clocks), and I'm
> pretty sure this should be * 2 here, rather than * 4. That would also
> align with ".pixel_rate =3D 2" just below.
>
> In its current form, some of the advanced displays with 240 Hz modes
> by default choose modes leading to visual artifacts indicative of
> overclocking strain of the graphics pipeline.
>
> The rest look plausible, so with that change please feel free to include:
>
> Tested-by: Alexey Charkov <alchark@flipper.net> # RK3576

Sorry, wrong mailbox.

Tested-by: Alexey Charkov <alchark@flipper.net> # RK3576

Best regards,
Alexey
