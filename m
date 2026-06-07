Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6335DCD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EBED10EA77;
	Sun,  7 Jun 2026 14:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DuG/LZ+l";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D912E10EA0C
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 11:57:36 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-69e66e11386so969437eaf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 04:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780833456; cv=none;
 d=google.com; s=arc-20240605;
 b=ZE9bWHEG/d6FkyN1WupLoLOnNQXpLta0JVlErxgly/xtRoyc2N4YLkOvRntKeCSn8d
 tAv25dhDReqzRqWY1i82wr8pSV6NAUjU/3HZ5KZoCEH0Oy8UUtHuBShKv7tTX+7hPLm3
 dFoP3dTs21LEVvPE4t4PmSXcmJb0tqm3mpixk1hfxr+6hGQXTCqZaVUdq2oOwH5NAvrV
 8iF12z+uo5HlRaCuos3nDnad5wcmGciW9gQmGvF9VCZCDCHqgjGQ9WNdsuono7jGVP50
 BtX9W7Y1D7x26E6/FuFPYCPXWAYfAICIIuxAyPXS5zkXEVB8sM95UL9Zt59NhjQl7ScA
 eiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j9h3BEv4ybPahVYDpfjJtvwrAcdt2dlCFy6zwAbCCRw=;
 fh=tEQikCMtzb8EqFf8qpcq5i/AiVL2LMFTjUOKFJd39Y8=;
 b=YPKQyRprL333r26c7mb5mBxei2WCP5EZKj13qbLlsro9Oe0CZRfhQXAeooq31Qca6M
 oaNJf6v+aQ9hMk22gkhi3/XdERTrgwvGNiqwy6M3L7NboAFhYAcbfSKYAyM9WFJIJvAr
 jrGxGQ4ZGGPZx8vC2gTqhUSkJf623CRIirFzeCWfzqd8/UMLliVFFBeBFcLvCMtzk1zw
 Wbn5yaQyFxvDF5nFLPf09VT5F+U5QgmWQ1dRx6vn/yCEINpdSdqDYxw+oIgZZu/i7FJd
 4MwNijc/WkIgpzRXtu3zTsTrgyX8AEWLHAF9gQBWpsGBpXx2fwNLGHCh+A5uVos/VCl2
 4FyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780833456; x=1781438256; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9h3BEv4ybPahVYDpfjJtvwrAcdt2dlCFy6zwAbCCRw=;
 b=DuG/LZ+l/4BoBagRQ8WrFEzSyeecghQjKj8zeinK6Dvc2sGxGtCCJnMB1jR5sVMgAJ
 SLywwn1uSZ89mkuALKIqUsTGPRuHJueI6ZmXeC+EGJJGiyyUXNKgt2dn3PUpCPGW0noh
 CntoTXhZKYL9kWc9zNmcNtetNXXtSMJXbF62SztJ9XjXkQjqmkz93TmCQfjWtX+GpUzG
 pgxIyeuRGb463V0M3Z0CCWgUFQSJGzzO3h3xOM+pbHZ03G4eGZLyMp6UgX/MDL2d1EiU
 op9xJfgHS6jSFHHVLk++S6a+z5rOyUo01WcKvsdNtfZgUYd4WC+xPq3siKPbnSOxMGbN
 2M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780833456; x=1781438256;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j9h3BEv4ybPahVYDpfjJtvwrAcdt2dlCFy6zwAbCCRw=;
 b=ZgBoKsR7gdSGc7zBSmAiR9hKSDpmXcATgtl3xMTZHmYkj0PVc8LtEW7fSAMlEt7MKu
 JonEk0t6T6ICsF44OJ/Ca5Epds+Ug0M5qij55aS6MBCt2eERZ/tFtGBn/K7Z3CSQtB+U
 ZiShXInRuPaVQcdWQ81DfAKNlhBYOBt+fFjSNSdeDeVlORozNS0YKpwKaQk7LYjfq2mN
 2C8QzJXYqmJHuEY186V62D7gzoDVJMFwDNhQZWlTNeA4V8tgxxNiZX1iHdjW06XNg4t7
 7FD+LVookNTr/VM+1KKtIGxAzhQDMyLAf1neA4NulV2zFdbC61Ah9lY3kLJLNHa4jc1+
 RV7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1ncg5gdoYpxXDnelThxIAaAUnFN5a+huU4O5gkyrAPoSu49MaQFAyUG34lEwZbFT69hL7t+AvuDs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2eOI6+0ZS+1+7k+yLuImCwHQ5mJWAyRH583p9mF28t5Xs0dgw
 H/2+Py4hrHCcn7Ny98AaPztnuSGVumOjqHdrF9OnAysUKp4F0SnrRTk1fJSyZNXEtBlykpn0V+f
 xph8fL+WDDgtkPI84nMk0UC+Vx+B9OjI=
X-Gm-Gg: Acq92OHxFj4JdB3cPdxH6dBYaIx2yAjkeG2g4gYp+zmPG68rvalf0gTiQQsJnRc2Z9W
 EaJAkPmYXFVEvKMVgl3tBEW6Wm1WTEqvTrQQggxzb3WCOyFc3xZaM6/wmd6xEMQoDDtyi4Mz6cm
 sxvyBroS1Gn9nZvNMGTfmHqkxsBONYT5h9mSZSwoNxQeVdANkAv+u9qTUE2ta9B2V0iJUbuaQBA
 kKnVTu1J3JlitnbEJYjASFf3LMXCcliHb/kz7wqGRuO1hREZmwTCwiGCopvy5Rnl/1mPYHf2aNO
 1YoE1i9z+qBB4m/o+vw=
X-Received: by 2002:a05:6820:4b10:b0:69e:3e2a:a83f with SMTP id
 006d021491bc7-69e68b1b89dmr5965848eaf.9.1780833455855; Sun, 07 Jun 2026
 04:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260604123224.192543-2-diogompaissilva@gmail.com>
 <5277524.h16uAIiOU7@phil>
In-Reply-To: <5277524.h16uAIiOU7@phil>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 7 Jun 2026 13:57:24 +0200
X-Gm-Features: AVVi8CeS1DNJb0AdX_LRZZVsQf_W_fU1VPXBidKJmKeVdQ9Na8oOOSQePlAqJH8
Message-ID: <CAJpoHp41+mLPWsu0EpCHkNz_z3=+tGqfh0cDKEaCWxwoYOm_Jw@mail.gmail.com>
Subject: Re: [PATCH] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
To: Heiko Stuebner <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 07 Jun 2026 14:39:43 +0000
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

Hey Heiko,

> this description is missing a rationale.
>
> Looking at the drm git history, I guess here you could add a second
> paragraph, with something like:
>
> ----------- 8< -----------
> The helpers have been deprecated for years as they only add an an
> intermediate layer between atomic modesetting and the DRM driver.
> ----------- 8< -----------
>
> Shamelessly stolen from the Todo item ;-)

True. I will add the rationale then.

> Any reason for only changing the DSI driver?
>
> Looking at [0] a number of the Rockchip drivers use the same pattern:
> - drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> - drivers/gpu/drm/rockchip/cdn-dp-core.c
> - drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> - drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> - drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> - drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> - drivers/gpu/drm/rockchip/rk3066_hdmi.c
> - drivers/gpu/drm/rockchip/rockchip_lvds.c
> - drivers/gpu/drm/rockchip/rockchip_rgb.c
>
> You can just do all Rockchip ones - even in one patch I think :-) .

Yes, indeed. I wanted to send a tiny patch to check if all my
configurations were ok, but since it looks like they are, I will add the
other rockchip drivers that have the deprecated functions.

Thanks,
Diogo

On Sun, 7 Jun 2026 at 12:59, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Diego,
>
> Am Donnerstag, 4. Juni 2026, 14:32:25 Mitteleurop=C3=A4ische Sommerzeit s=
chrieb Diogo Silva:
> > Remove the dependency on drm_simple_kms_helper by open-coding the
> > drm_simple_encoder_init call.
>
> this description is missing a rationale.
>
> Looking at the drm git history, I guess here you could add a second
> paragraph, with something like:
>
> ----------- 8< -----------
> The helpers have been deprecated for years as they only add an an
> intermediate layer between atomic modesetting and the DRM driver.
> ----------- 8< -----------
>
> Shamelessly stolen from the Todo item ;-)
>
>
> > Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> > ---
> >  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 9 +++++++--
>
> Any reason for only changing the DSI driver?
>
> Looking at [0] a number of the Rockchip drivers use the same pattern:
> - drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> - drivers/gpu/drm/rockchip/cdn-dp-core.c
> - drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> - drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
> - drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> - drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> - drivers/gpu/drm/rockchip/rk3066_hdmi.c
> - drivers/gpu/drm/rockchip/rockchip_lvds.c
> - drivers/gpu/drm/rockchip/rockchip_rgb.c
>
> You can just do all Rockchip ones - even in one patch I think :-) .
>
>
> Thanks
> Heiko
>
> [0] https://elixir.bootlin.com/linux/v7.1-rc6/A/ident/drm_simple_encoder_=
init
>
>
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/=
gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > index 3547d91b25d3..a09b382d208e 100644
> > --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > @@ -25,7 +25,6 @@
> >  #include <drm/drm_mipi_dsi.h>
> >  #include <drm/drm_of.h>
> >  #include <drm/drm_print.h>
> > -#include <drm/drm_simple_kms_helper.h>
> >
> >  #include "rockchip_drm_drv.h"
> >
> > @@ -825,6 +824,10 @@ static void dw_mipi_dsi_encoder_enable(struct drm_=
encoder *encoder)
> >       clk_disable_unprepare(dsi->grf_clk);
> >  }
> >
> > +static const struct drm_encoder_funcs dw_mipi_dsi_encoder_funcs =3D {
> > +     .destroy =3D drm_encoder_cleanup,
> > +};
> > +
> >  static const struct drm_encoder_helper_funcs
> >  dw_mipi_dsi_encoder_helper_funcs =3D {
> >       .atomic_check =3D dw_mipi_dsi_encoder_atomic_check,
> > @@ -840,7 +843,9 @@ static int rockchip_dsi_drm_create_encoder(struct d=
w_mipi_dsi_rockchip *dsi,
> >       encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm_dev,
> >                                                            dsi->dev->of=
_node);
> >
> > -     ret =3D drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODE=
R_DSI);
> > +     ret =3D drm_encoder_init(drm_dev, encoder,
> > +                             &dw_mipi_dsi_encoder_funcs,
> > +                             DRM_MODE_ENCODER_DSI, NULL);
> >       if (ret) {
> >               DRM_ERROR("Failed to initialize encoder with drm\n");
> >               return ret;
> >
>
>
>
>
