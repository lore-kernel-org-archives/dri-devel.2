Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF259CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29B5E10E81C;
	Mon,  1 Jun 2026 15:01:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OApv5F6K";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1DBE10E81C
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:01:20 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-9638f7e9896so2526556241.1
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:01:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780326079; cv=none;
 d=google.com; s=arc-20240605;
 b=A7cunsGtP/+0VOvHt7CoQYDNbpomiYIpIMWQI6hC0xNTDgyc3x8/+Ldcfzy11USlYg
 vBKSEuAdCPwjRxxteoOw2z2NNsT5V1xBUP2sn7L2QnVlGZGY0oTUUJH7JY8nugtg2yj2
 sDZBDyPJ2GLqpY8YSAsNdgC6Fn3meDD19ZLhPQdbO5umgp9JqH2rDx5cjYDC84mHFtHb
 A9xGTU7iVSlvbcwgMur0rtPngYRZ3wvBb8DzSPLz1gpmfFiir0oyLWno724M6dLC+IWe
 48paoHK/UEqPIdhnCZfrSUuue0sQyz4MkP2L+GsrLzffM08KWIyQ/Wj6RqsYPuI6o36V
 /mGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nwk2UuCGq5tLt9Wm80zVPiskYyAlj51G22B+3bC+jcE=;
 fh=LUAMYVMq5h9JdPcW4ngpo6TwfbyonPFXZ0AJsYnbhJw=;
 b=ZDRH+fI2IdgQuSoCqFb0f6leJhS7Qeh6qV6cy/IcKQ4i1s3Y7qGMEIy0XSgS7E2zuS
 zg9HjqupD5Zyi7kZ6UQjNvRW6T7EhiOWnhr35nbGNUSHnalRW/di6nq0KCULp2fWdmin
 /xHEQ5xoWwcMh/5UlZVNP/7NoYFlkRPxpTy/Ea+gQDQvKv2hA5/rwzdkO1AoBS1odKZi
 sKqwJN1//gktfWA1pdTpAZ9iQNzP5EXQrPKSLZ9970Vve2A79Cu7n56O2XnQVnwzARfO
 tTg2X+BJXh9EgtyBrze8Zo9PjV9ePw+722hjJdw0wjB9B9e78kdAUyTjF370LPbkupNV
 XZoQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780326079; x=1780930879; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwk2UuCGq5tLt9Wm80zVPiskYyAlj51G22B+3bC+jcE=;
 b=OApv5F6Kdy7KjYqidbWp5xfil7wCBvNjmf4p0SQStiRBgSAxniCOdXJiK73/J1yvt9
 VLh/EhZBsZD9EFjfMR/ErGQQUgxWExNJBiDseppbERkqBgiDNm7/CuzD7OCdY+kKAiFy
 EJjJfJI0l76XwCC/sTz+AqMwtM15+RV6zsAWYFtBKKm1veL/LirUtyzye/yemgfXfMb/
 AAH1J7GQTTpb1BP2HvOhCUrjTQemAXpjzmGo0I4R8UzIOhH3yhZgf1h/ZaWuZBTRtSLZ
 dVTYJL12v+EOBf8rmNz0ckeoevdHzEQ164AqgaQ8TEV+Dopp58jnvoPCtQFpo8S6IWCf
 n7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780326079; x=1780930879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nwk2UuCGq5tLt9Wm80zVPiskYyAlj51G22B+3bC+jcE=;
 b=opXcVWfvptOBi4Ponr2AvbUw0wC/waQObI97bYAgImeN2qfAegvb6AgHKcv6p9z4Nl
 M3IqEV0xiD03U2ricKjP/zNtyXf3It4eZnkFDqL+ArEMzyTQC0684wvTF0ci3xf+1h9w
 qlAKWMjLtOhO91umcUW1oARFkwAX+KNfyRdNome9agkT3rIQ/Z8i2FQOWx7KAkKBjyjY
 reLpsQD4DFUiP7a0RNpl/NRT3GDdwlswSEhHfH+r4rjrZ4vW/ZZlRk4yCLi2TUFNNmSB
 jRH3QKWlB8G+GNkWKtqLAkfzZa5Wk+a8CRFHoq8Kzee9+Qt1dimSgMM4UaQCFlb5EekW
 q1nA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8P0+dXVGhikQpZgVktolvljHCUW5KgeGGNIGWHnCWhwwnibxq8xrUHsBmxHLiinrof1XvqfAytJKs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwQkeCMzq59aAjCNcmGtc9U/EV9+Z2gL2tPKATx5Mp3btvR0bI
 WB0EaXFG14SQg+tBFUlSULtF7A4BjtaG0m9duvsBBbTF78lkdOMgftMu0p1lSFRoaQtQw4lKsuO
 eBL4opejNtRpt2nANiVll1QmOklnYD40=
X-Gm-Gg: Acq92OFjo9WDo++kH4JW6+QgpE91/4TuRqmQRnvemgYpgAbViTsoFvbzw5X5eWLu8ZH
 /zV7IvhB5uRVOuajX1RSViFaIMpj7Sarik/RTAoXeWdgWBilra8GXc5T4WeG9awkhU+ZxrfqT1O
 sIT7iX0wuvvb83sNBf+uWNGBE33lLFq+NR7v17fL7iaNE+oiUk9D0QCgriSvXeojXGnJ7IEqrlJ
 RwEfuyUsnWmzA0+eXT5vMIZwxkIPWCj54DDqzi/7i5ZPnDS0AqzeKF964otm15vW62+LrUycSrq
 KAAYJ+34syDkr+v5Xa10vPZj3Ik1h9ylnkc7aMhMqU41ADLA
X-Received: by 2002:a05:6102:4414:b0:634:420a:ab25 with SMTP id
 ada2fe7eead31-6c635d16c95mr3802351137.9.1780326077816; Mon, 01 Jun 2026
 08:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20260408065112eucas1p129f600747c27e999ec3d42504bc0fd2b@eucas1p1.samsung.com>
 <20260408065055.1353444-1-wenst@chromium.org>
 <d568fde6-8033-45c1-a2e1-13f8112f1193@samsung.com>
 <CAGXv+5HvO3OjBC=u4EZeB6Aza6oSN0KWrvbQgWEnR=jskczvwg@mail.gmail.com>
In-Reply-To: <CAGXv+5HvO3OjBC=u4EZeB6Aza6oSN0KWrvbQgWEnR=jskczvwg@mail.gmail.com>
From: Inki Dae <daeinki@gmail.com>
Date: Tue, 2 Jun 2026 00:00:40 +0900
X-Gm-Features: AVHnY4LiVQgchAwT0M1vmeLVdX-XKywtGIR-vtqCkEB-jmXjcHGzghOfOtlMMIE
Message-ID: <CAAQKjZPgDMvdn8R2dbX10KNQam_PMsm6_FES0WLhx_7pKY4Jdg@mail.gmail.com>
Subject: Re: [PATCH] drm/exynos/fimd: fix register offset type in
 fimd_trigger()
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 DRI mailing list <dri-devel@lists.freedesktop.org>, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
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

2026=EB=85=84 6=EC=9B=94 1=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 1:44, Ch=
en-Yu Tsai <wenst@chromium.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Wed, May 6, 2026 at 2:35=E2=80=AFPM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> >
> > On 08.04.2026 08:50, Chen-Yu Tsai wrote:
> > > Sparse reports:
> > >
> > >     exynos_drm_fimd.c:992:39: warning: incorrect type in initializer =
(different address spaces)
> > >     exynos_drm_fimd.c:992:39:    expected void *timing_base
> > >     exynos_drm_fimd.c:992:39:    got void [noderef] __iomem *
> > >     exynos_drm_fimd.c:1005:33: warning: incorrect type in argument 1 =
(different address spaces)
> > >     exynos_drm_fimd.c:1005:33:    expected void const volatile [noder=
ef] __iomem *addr
> > >     exynos_drm_fimd.c:1005:33:    got void *
> > >     exynos_drm_fimd.c:1007:33: warning: incorrect type in argument 2 =
(different address spaces)
> > >     exynos_drm_fimd.c:1007:33:    expected void volatile [noderef] __=
iomem *addr
> > >     exynos_drm_fimd.c:1007:33:    got void *
> > >
> > > Add "__iomem" to *timing_base to fix its type.
> > >
> > > Fixes: 3854fab24e89 ("drm/exynos: fimd: support LCD I80 interface")
> > > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >
> > Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> Inki, you missed this patch as well.

Thanks for letting me know. I will pick it up.

Thanks,
Inki Dae

>
>
> ChenYu
>
> > > ---
> > > random warning I found while checking for the size_t warning.
> > > ---
> > >  drivers/gpu/drm/exynos/exynos_drm_fimd.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/d=
rm/exynos/exynos_drm_fimd.c
> > > index b6abdc4f2b0a..695d3515d421 100644
> > > --- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> > > +++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
> > > @@ -989,7 +989,7 @@ static void fimd_trigger(struct device *dev)
> > >  {
> > >       struct fimd_context *ctx =3D dev_get_drvdata(dev);
> > >       const struct fimd_driver_data *driver_data =3D ctx->driver_data=
;
> > > -     void *timing_base =3D ctx->regs + driver_data->timing_base;
> > > +     void __iomem *timing_base =3D ctx->regs + driver_data->timing_b=
ase;
> > >       u32 reg;
> > >
> > >        /*
> >
> > Best regards
> > --
> > Marek Szyprowski, PhD
> > Samsung R&D Institute Poland
> >
>
