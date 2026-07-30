Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C2C55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 466E110F0A1;
	Thu, 30 Jul 2026 21:26:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fqm8GlX+";
	dkim-atps=neutral
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com
 [209.85.221.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F81E10F0A1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 21:26:19 +0000 (UTC)
Received: by mail-vk1-f175.google.com with SMTP id
 71dfb90a1353d-5bf5370d38fso151621e0c.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785446778; x=1786051578;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nVUsZTb0HSqncNHOimlTe7rgZv4de8OPUhZ7toKOfVY=;
 b=Fqm8GlX+5e2FBwhWegNDyPgdREs1wOCvaqofA/BGQcDHr7spUGMCf8D0cbwdR7SEnz
 gUOqrMLuLhGfbFNeFksNWr3x04346OSLdBDilj/yAZwJlSA9xRW6qofr4IHIMUACf1W2
 x6TKHs/P+IIfHVTrbZ7mbJB8pph7Pm4KJg9gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785446778; x=1786051578;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nVUsZTb0HSqncNHOimlTe7rgZv4de8OPUhZ7toKOfVY=;
 b=ZH3pkCGUWX1/1oF+lFDvVJ/Imt7JCz5dUSGoLW29nd67cgAla8VqX9NK/BsFb3lwFk
 aZ20agwYs+kN31Jqov0y9rX3QUS00oGXHYrsYxPp1yvwEvCYHTWRGZerS/FcwEZU+q5E
 K4s7atSJK4XChBi7YjNql447qAoxCD6lHHyv6KLlDUEkZwZo8A/FrjXX35An/jQrnbKS
 IvtsFfrtb2VEbN9COd0h+74WKkLvHHClqMeBU57IhVadV9CckXLubY2mUoZZDl9g2io2
 JVMgq5AZReijQt1KOJ0bqkqWVkDBFOrgurGJPROcyQDV4dC7GX2hpr/9E/1P9n9r0DHo
 dOxw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+ypn7hWMqsx60U+H6J86sXT4tAuO9y9UhZi7qV1ktqqNA5Z2AbZr+XKouCl6T1IdjSFwfkSbY97U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQjB0OB8CjES1sRzrQE3MQXbAK93OZgcqGE9Sltxi0n7TV5QRv
 LbTExOYX0h4BpitzA3G8PN/Ejo0B9FGYAe8G0P4I6ngEaFIxM4XH3ie0mrLufd4pnwnJrrTLDZY
 ulL8=
X-Gm-Gg: AR+sD11kW0XvtfbePpnzrl5Da4Z1bNKgRiqbKVjZ5fDEOW6zSSTV8E9+ZyoBbHL7PiY
 U6IRMkBGLukJwE7LBOWC5x/Kq5C17zK3SMwWnWyIhe9P6OolELMEGnl+CLw4Jb9TKiMUm/UikLv
 EOmaoFz9eCpbjkQoakb89UXtZkIENfKTWp/piSs6WvhB5V/Il+nKEFShBLH5/+Mox0Zq3Oha3xZ
 rF7r2O07V9Aog3vD1RELuRgJqlEEafqyDSC+eDs0urwYKwKo7lTANEDXOu5AkzNiGeWqFbPv6Wa
 Mf1Ignluv7Ctw+y47yr5cGYiYtDNvd5H/EmKY40HRmcJ2xMufoEeVmfEBuzrh/RHhyH4+g0yhyL
 lc4r73tW1QCpjCAzOBwC6JaHSBaC9E8qEz0mE7Ty+wN2PT4QSgrbm3+lXq6g7hv7bUDrWXdhfq3
 STA5TBB5ayE4dCFB17BSFwscLf2J3OUdoqC8kra3J1UzghdHZ0MmwD3AtCN2Al/nWuIjFNgLgmx
 sLdBoaE/96yaHF4hOJCCRglvFE=
X-Received: by 2002:a05:6122:d27:b0:5bc:42be:f758 with SMTP id
 71dfb90a1353d-5c365fe14dfmr1339519e0c.3.1785446778369; 
 Thu, 30 Jul 2026 14:26:18 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c3664e2e99sm2607285e0c.2.2026.07.30.14.26.16
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 14:26:16 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id
 a1e0cc1a2514c-966eabad303so48385241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpW1BU6++oGcPoqPexkSReUE/J321pbndJaSEv4TTxGf1UscDLtupUDFtnT2R+yN1WsH8FiWGg4Fbk=@lists.freedesktop.org
X-Received: by 2002:a05:6102:2c15:b0:726:f965:722b with SMTP id
 ada2fe7eead31-7574fa3b953mr1452748137.21.1785446774907; Thu, 30 Jul 2026
 14:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260723103509.2-ps8640-v2-pengpeng@iscas.ac.cn>
 <c1cfe79fabe97b3d1603a4fa064a18afb7d6810b@intel.com>
 <CAD=FV=Wo-ps+aStGn5vCvb08tKx-rKDeu-r0bRVABL8zgg4Lhw@mail.gmail.com>
 <b962d68e6640787a539690edf022b338a9b47bbe@intel.com>
In-Reply-To: <b962d68e6640787a539690edf022b338a9b47bbe@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 30 Jul 2026 14:26:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vi7+-_7yhTsOs6y0XEPR3cRmFB6bwkFMOrtvfgsuCMuQ@mail.gmail.com>
X-Gm-Features: AUfX_mwB63TjPPhCa73ENbo1uICmFxAPfkxA-tO9HUDpwl3ZzG3WOs1XdX1U_ds
Message-ID: <CAD=FV=Vi7+-_7yhTsOs6y0XEPR3cRmFB6bwkFMOrtvfgsuCMuQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ps8640: propagate AUX transfer register
 errors
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Hi,

On Thu, Jul 30, 2026 at 1:38=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Wed, 29 Jul 2026, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Mon, Jul 27, 2026 at 4:40=E2=80=AFAM Jani Nikula <jani.nikula@linux.=
intel.com> wrote:
> >>
> >> On Thu, 23 Jul 2026, Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:
> >> > ps8640_aux_transfer_msg() programs the AUX address registers, starts=
 the
> >> > AUX transfer, waits for SWAUX_SEND to clear, and reads the AUX statu=
s
> >> > register. Several of those regmap operations have return values, but=
 the
> >> > function only checks a stale ret after the status read.
> >> >
> >> > Propagate failures from the address write, transfer start, completio=
n
> >> > poll, and status read. This avoids returning a transfer length when =
the
> >> > bridge register transaction or AUX completion wait failed.
> >> >
> >> > Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX=
 channel")
> >> > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> >> > ---
> >> > Changes since v1: https://lore.kernel.org/all/20260623060635.16064-1=
-pengpeng@iscas.ac.cn/
> >> > - include the AUX address and length in the address-write diagnostic
> >> > - describe poll failures without assuming that every error is a time=
out
> >> > - add the Fixes tag suggested by Doug
> >> > - rebase onto the current drm-misc-next tree
> >> >
> >> >  drivers/gpu/drm/bridge/parade-ps8640.c | 27 +++++++++++++++++++++--=
----
> >> >  1 file changed, 21 insertions(+), 6 deletions(-)
> >> >
> >> > diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/dr=
m/bridge/parade-ps8640.c
> >> > index 96332721cb69..56b48f8feab6 100644
> >> > --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> >> > +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> >> > @@ -257,8 +257,14 @@ static ssize_t ps8640_aux_transfer_msg(struct d=
rm_dp_aux *aux,
> >> >       addr_len[PAGE0_SWAUX_LENGTH - base] =3D (len =3D=3D 0) ? SWAUX=
_NO_PAYLOAD :
> >> >                                             ((len - 1) & SWAUX_LENGT=
H_MASK);
> >> >
> >> > -     regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> >> > -                       ARRAY_SIZE(addr_len));
> >> > +     ret =3D regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> >> > +                             ARRAY_SIZE(addr_len));
> >> > +     if (ret) {
> >> > +             DRM_DEV_ERROR(dev,
> >>
> >> DRM_DEV_ERROR() is deprecated in favour of drm_err() or dev_err().
> >
> > Good point. I'm inclined to land this anyway, though, since this is
> > nominally a bugfix and it matches the error printing in the rest of
> > the function. Any objections? It would be a nice future cleanup to fix
> > the error printing in this driver overall to use the non-deprecated
> > functions...
>
> Up to you.

OK, pushed to drm-misc-fixes.

[1/1] drm/bridge: ps8640: propagate AUX transfer register errors
      commit: 20697ecb299cd77b4cf8b28f655e56606b0472d8

It would be great if someone wanted to update the error prints. :-)

-Doug
