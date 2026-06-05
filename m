Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB15CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A69D511A964;
	Fri,  5 Jun 2026 15:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U6LdHDS1";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAB5011A964
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 15:59:11 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5176096116fso21699061cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 08:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780675151; cv=none;
 d=google.com; s=arc-20240605;
 b=HGerqoY/WuYKsg9SrnzA6NJwG91Ys7nyFxNlocJQh18j2TiGtak57sZ3v/z39ASrLS
 mW1KZ5gPUsVWsA7LpR3952N5lkuJ/qbDgt5Cu0QYCHkYZKlnAK/ZbLHklSidr6vEIIui
 yabC5ba5kQlJagCBgbnSj+4fW5je7SyQ42GBWYl5SX78qOlS+t+zh6mBQVYvtx73xgnO
 FzZg+QH6blwF+DvWuex5nw2Ya0ZQKBGs568H4j30taREa9mttVqFzGla0JCPO6p4cRak
 +C1Iz47V3bDgQLfSSB8cYzFjLSgGQfWKk9gb80+tqWxe9epi+HPEFiG00lhgS+b5Ph8q
 tUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9ksbjEziQ/klkTRNLQdAgetuDlG0vybDd4/Easyb/oE=;
 fh=AtYcPZFd7Q4BKSBc5vxSDvPn8Fl6A0EYpPQiHLjsVTw=;
 b=f9vKhdw046Z5UMPyF6e6cZu4F9ljnnUqmYcUuZVIsQQFF9qGRga2A2XiGrtiutBGOE
 0gDhfLGIJZ46bfA7/py+wwJiENoNRV5gSbd/0wSxFJn629fxBChxntuf3Ov1dv3pfmdZ
 hRhWdgZ3Aaz5vZ8YW23ax0MwM+2YBwLkLyBBrmuie1m2Hh7BSoi/Xdzf9Kd7rfVNkCi3
 eEiIl+qjYCEL1iS8AmjK5416hqM4VWlioRvjLpiDP2sfo7VNh64NIe0oEvFIbRgOYo8x
 bBtGVg9m1LJr662FNjAZPQorcR/VkqnOjWRrpUhiI/FTOjMwqKzqhNfgnQUf6JDGantP
 qxSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780675151; x=1781279951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ksbjEziQ/klkTRNLQdAgetuDlG0vybDd4/Easyb/oE=;
 b=U6LdHDS10FgAv31SyFlCF33jzvn5owI/99phSZKKy4D9I+X31p6jc9dQMRTvhb+U/1
 NhEe+YCYMGJOGbPrf9cOSUC5EeCbeD80kWuC6IOZ3U8YO/g/IDj/Rr5TxTqqf4VcpABg
 V101kj7/ND2R31yhLO041OxJmPRvvc5D7JYZi9ggHaz3o91yEE5+hCeFsHVfV9Fdjhoz
 W3purUWREk2Fd64wwSnazXUtMVqK04IPi7poH/7wTPADUFQPprCieD6LwHCRwSdd5LUw
 aH2J1jus5lNuYL/cHn4hc4p/m3EHlc6MRAqU9V6FY7DBYLWi3Kd2VYK09gQtFgFDm+Mo
 hs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780675151; x=1781279951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ksbjEziQ/klkTRNLQdAgetuDlG0vybDd4/Easyb/oE=;
 b=MRGlf2QloGtNa8WgO/PPdDX4DlpUFBg8P+4TArT4TbbrRxHMomnjvsVVJ3esckcHAm
 bOtYzm7oLXZbf/aqgTdWHPUosUGh1XAXYm9bwnmsGTt8ZSn5ziGmrA4vmxEL1CZgTlyj
 SJHhYpjzGwBk7g4WsHS0AThjsd6EZ7B3Kt11Ia5eufHedCd6UpSqwbfcIYi+aZm5n55O
 6F74tJOJCLRi0kGaKb0D+kv/hkdSCFTbe38/VyJBRmrHk0iSLjn+0zrEZSZLy95l4XYV
 1q0rWqrfAEL6G0fPII1XKRxCLtXJ9JIoc+WGpcO5+opySOPlPZWw95E/zNXpmiWt30Sg
 vQWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Yc3/5vECiWwfXfxhjKeSxr7LYLiDr+7NJC6HqR2j686guGzvQQ+9rDWT3lns4TwbBUCkrkrWGqV8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzlGB2Dm8dUZRy2hdLZTJ6w01ZikJbLb/NuoNUlgkPIVAiNygsd
 EAyxMbB77s1CuVvuJTtxwm8ehTgC6ORtG1LQFYzZfeG90hOZVE0FuY+o/IarJpji+fMt2g9qgBV
 zqMzL60QiB6eTsHXa7Ni7+/oZlqVu2JY=
X-Gm-Gg: Acq92OGhurHzVPR0b0sdCEz3pjAMBLLDqc2ve6UbcIAPQeEhkdMNy96TiNI2+p0BTjZ
 W6OS4uGNq2UHWSG2cM2ph+B88fhUCgXX78NqzWNk7jd0sefFEZ0f4fZD0TG9FN6C947edbr+swa
 6PrFNQBUIBb1ilZWZKx5wxv1yYx3WOmgqbFVSlwa3KKvfyIXw1p5Opk8UOmDBV3cYK9LnbzJxtM
 k40u08wgRrJPIq63E/nRPLfR5632SmbgysvC1bbQ6mye3/zoSKYqSQiDaiqA/c7MJ2CvyVmsh3i
 FTZUETE6427DdogB
X-Received: by 2002:ac8:7d16:0:b0:517:89d0:b8a9 with SMTP id
 d75a77b69052e-51795a872cbmr62478381cf.9.1780675150571; Fri, 05 Jun 2026
 08:59:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-vop2-clk-rate-check-v2-1-b207cfc427d7@collabora.com>
In-Reply-To: <20260409-vop2-clk-rate-check-v2-1-b207cfc427d7@collabora.com>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 5 Jun 2026 19:58:59 +0400
X-Gm-Features: AVHnY4Kg55Cpi5Qk79GgU4qugmSkMCPyryYYbHOI9JHnUkY85yTZ0sefHW3lqDA
Message-ID: <CABjd4Yw_HYpjhrgmonB9FmWV00q=r3yvqnFE4TXEHpM1ZgWOhA@mail.gmail.com>
Subject: Re: [PATCH RFC v2] drm/rockchip: vop2: Add clock rate mode check
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
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

On Fri, Apr 10, 2026 at 2:37=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> The display might offer modes, which exceed the maximum clock rate of a
> video output. This usually happens for displays that offer refresh rates
> above 60 Hz. This results in no picture (or a broken one) being displayed
> without manual intervention. Fix this by teaching the driver about the
> maximum achievable clock rates for each video port.
>
> The information about the maximum clock rates for each video channel and
> the tip about multiple pixels being processed per clock were provided by
> Andy Yan and roughly checked against the information available in the
> datasheet (which specifies limits like "2560x1600@60Hz with 10-bit"
> instead of a specific pixel rate).
>
> For the video ports supporting a 600 MHz input clock, there is some
> logic to handle up to 4 pixels in parallel when needed resulting in
> the extra multiplier.
>
> Suggested-by: Andy Yan <andy.yan@rock-chips.com>
> Link: https://lore.kernel.org/linux-rockchip/1528d788.186b.19d08ed974c.Co=
remail.andyshrk@163.com/
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> I've kept the RFC tag, as I'm not sure about the 4x parallel pixel
> processing. IIUIC all of the video ports with a maximum of 600 MHz
> input clock support it, considering they can go to 4K @ 120Hz,
> which is above 1.2GHz while Andy mentioned a max. support clock rate
> of 600 MHz.
> ---
> Changes in v2:
> - Link to v1: https://lore.kernel.org/r/20260217-vop2-clk-rate-check-v1-1=
-989b569119ba@collabora.com
> - based on v7.0-rc7
> - rename max_clock_rate into max_pixel_clock_rate to distinguish from
>   input clock
> - update max clock rates to the numbers provided by Andy Yan with
>   extra 4x multiplier for 4K 120Hz VPs
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c |  3 +++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.h |  1 +
>  drivers/gpu/drm/rockchip/rockchip_vop2_reg.c | 10 ++++++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index a195f5c819a2..35a0edda5375 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1434,6 +1434,9 @@ static enum drm_mode_status vop2_crtc_mode_valid(st=
ruct drm_crtc *crtc,
>         if (mode->hdisplay > vp->data->max_output.width)
>                 return MODE_BAD_HVALUE;
>
> +       if (mode->clock > vp->data->max_pixel_clock_rate / 1000)
> +               return MODE_CLOCK_HIGH;
> +
>         return MODE_OK;
>  }
>
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.h
> index 9124191899ba..fd46913f3346 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.h
> @@ -225,6 +225,7 @@ struct vop2_video_port_data {
>         u16 gamma_lut_len;
>         u16 cubic_lut_len;
>         struct vop_rect max_output;
> +       u32 max_pixel_clock_rate;
>         const u8 pre_scan_max_dly[4];
>         unsigned int offset;
>         /**
> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/d=
rm/rockchip/rockchip_vop2_reg.c
> index f3950e8476a7..6ae3d506c476 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
> @@ -559,18 +559,21 @@ static const struct vop2_video_port_data rk3568_vop=
_video_ports[] =3D {
>                 .gamma_lut_len =3D 1024,
>                 .cubic_lut_len =3D 9 * 9 * 9,
>                 .max_output =3D { 4096, 2304 },
> +               .max_pixel_clock_rate =3D 600000000U,
>                 .pre_scan_max_dly =3D { 69, 53, 53, 42 },
>                 .offset =3D 0xc00,
>         }, {
>                 .id =3D 1,
>                 .gamma_lut_len =3D 1024,
>                 .max_output =3D { 2048, 1536 },
> +               .max_pixel_clock_rate =3D 200000000U,
>                 .pre_scan_max_dly =3D { 40, 40, 40, 40 },
>                 .offset =3D 0xd00,
>         }, {
>                 .id =3D 2,
>                 .gamma_lut_len =3D 1024,
>                 .max_output =3D { 1920, 1080 },
> +               .max_pixel_clock_rate =3D 150000000U,
>                 .pre_scan_max_dly =3D { 40, 40, 40, 40 },
>                 .offset =3D 0xe00,
>         },
> @@ -775,6 +778,7 @@ static const struct vop2_video_port_data rk3576_vop_v=
ideo_ports[] =3D {
>                 .gamma_lut_len =3D 1024,
>                 .cubic_lut_len =3D 9 * 9 * 9, /* 9x9x9 */
>                 .max_output =3D { 4096, 2304 },
> +               .max_pixel_clock_rate =3D 600000000U * 4,

Hi Sebastian,

I've tested it on a bunch of different displays with RK3576 while also
giving VP0 an unlimited PLL to work with (and also expanding its rates
table for each of the displays' EDID preferred pixel clocks), and I'm
pretty sure this should be * 2 here, rather than * 4. That would also
align with ".pixel_rate =3D 2" just below.

In its current form, some of the advanced displays with 240 Hz modes
by default choose modes leading to visual artifacts indicative of
overclocking strain of the graphics pipeline.

The rest look plausible, so with that change please feel free to include:

Tested-by: Alexey Charkov <alchark@flipper.net> # RK3576

Best regards,
Alexey
