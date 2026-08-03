Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CAFC55182
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 17:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D02510E5F8;
	Mon,  3 Aug 2026 17:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NfGftYnB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E55C10E5F8
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:11:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9FB2A412D1
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:11:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4951F00ADB
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785777074;
 bh=FUo1LO52BYWcoiJd1dWpDlLgNt48xObBzCM2IkzYHyY=;
 h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc;
 b=NfGftYnBfCQtA4iYivRTo6vxQG6mxmsK57/zIQ4cXNsMMGJJcKE6+iXd8OIBRG2JU
 zURXcsGGpsRSmGIHsTSzoed9DilauVTCNRrKpiW6AtPEN5/QrQeJJGEjSFCFOZHxvs
 VCZcKwG2fJwkvnjPy6PrktY0J+5BuG8ek44duC9ZbdWTv3wgetM/JDOmt2ddwp8mde
 ngxktLJ117g8ktHUsZrFvng0s8r5K6R+PivfWE1hMZAy7r8rgeBIquOc79AKr8V0l1
 QgMLkkkCnavtufeNnHO6djpj8e7C9AMRD7pHNBIuhbJNXTGJlwugsn3KZX2LeaL3Qh
 RcQJNHDWugB4w==
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-39faa67fab8so4404951fa.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 10:11:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqwkngQY0f74Zotsv04FCAd1nrxJ2V9pm/MuXP38mq7DmY0IfEmcnAYypdNFFAaptCUZfUpT2mXNus=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDNsg51GRbdxN0IX2hCH0jkNbvIdNc2lqfUNwXU2mc3K3kszWJ
 lHt3C42UxhpLOm3m6uHvgDfu0WDZEIL3sAA+tSvcJcIrhuER8caeDJJQLeb1dV7VAX1uXroPvHA
 sMld2+2TazSGaqdOd5NJLCxaUmRiKUjs=
X-Received: by 2002:a05:651c:1993:b0:39b:2757:c1d3 with SMTP id
 38308e7fff4ca-39f86123ea9mr23096581fa.9.1785777072773; Mon, 03 Aug 2026
 10:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785772659.git.jernej.skrabec@gmail.com>
 <aec9060209473b8176eb43bc7c63c20b21306adf.1785772659.git.jernej.skrabec@gmail.com>
In-Reply-To: <aec9060209473b8176eb43bc7c63c20b21306adf.1785772659.git.jernej.skrabec@gmail.com>
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Aug 2026 01:10:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v66dgpoMwpackOsKGb7JFUMP-1Vc667xFE54j5odCdpv+w@mail.gmail.com>
X-Gm-Features: AUfX_myw6C25eVU1rBodfF_fAck2j4rXU1pTMBlvs-af7cQRwy-_-acRDgCMMzA
Message-ID: <CAGb2v66dgpoMwpackOsKGb7JFUMP-1Vc667xFE54j5odCdpv+w@mail.gmail.com>
Subject: Re: [PATCH 12/13] drm/sun4i: hdmi-phy: Fix H6 8-bit MPLL config at
 594 MHz
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
> The 8-bit entry of the last MPLL row (594 MHz) doesn't lock reliably on
> H6. 4K@60 RGB/YUV444, which is the mode that reaches this entry, doesn't
> come up.
>
> Align the value with the vendor driver. Other entries are left alone,
> they are used by lower pixel clocks which work fine.
>
> Tested with 4K@60 on a LG TV.
>
> Fixes: 0fb4b858b102 ("drm/sun4i: Add support for H6 HDMI PHY")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Chen-Yu Tsai <wens@kernel.org>

> ---
>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun=
4i/sun8i_hdmi_phy.c
> index 4fa69c463dc4..489ea94693ff 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
> @@ -91,7 +91,7 @@ static const struct dw_hdmi_mpll_config sun50i_h6_mpll_=
cfg[] =3D {
>                 },
>         },  {
>                 594000000, {
> -                       { 0x1a40, 0x0003 },
> +                       { 0x1a7c, 0x0003 },
>                         { 0x3b4c, 0x0003 },
>                         { 0x5a64, 0x0003 },
>                 },
> --
> 2.43.0
>
