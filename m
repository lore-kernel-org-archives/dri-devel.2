Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3B4C4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 17:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC66610E093;
	Fri, 17 Jul 2026 17:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iL+w+K2p";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D35A310E093
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 17:04:01 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-9690c99c917so2360210241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784307840; x=1784912640;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=g+QJXY8MXcqCdgqaL6hKXIE3d7JPVGuOOc9OTwhTDnQ=;
 b=iL+w+K2pgAjP/MOielJWcFk7ZS9UalgbwvJ410I7OFlVLD4wuZitwOQF+srXcVnB2M
 XsrVpNZCq9NMPvi+9RNDRQWk4jP6r7CiotxiY21Ee1Zi/3d2tJLEuWNr8neMbEQkuQ+z
 cyuVLPQoxyFbIq0WRUJNtTWe6U5TBo77XZZ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784307840; x=1784912640;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g+QJXY8MXcqCdgqaL6hKXIE3d7JPVGuOOc9OTwhTDnQ=;
 b=OPhEOH4apa1OKjnrSkx+QPaUrg9I6cwx+2dTKlcJTfy7LzQ5RkekeW79Ekt672UJhL
 1+qQmtQ/ZcFmZoU8GYhNL8iEHVy52Pf7p5ze72q3mF0hpdf7Xj45My9KTvLJcuBsLsbo
 8s4RbVr81AJvFaBebfQ/3d9fDQtgLHhHX6CxAG9k4I39WeRPtlO9+M+3JfQp48GpyeGe
 rb/3KWlNn9XHqCeH0EnTe3tBFoQUpsspx1eYfx1ddhRvoS4B9oNwOt5lr9G4ZwTBW1jn
 nI6mKGylTEjyQFCwdWMxTIQWVJ/IK9JJuFDvl1McRfHOKJ+5+/85EvLRNCOcsW0WkhBB
 Un5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQjy8Cxo0UUMCIcQSd0BbV/ZZTwOy3cQ1yM5ZYBUhAfkfSsztFqsi7+/oM1B931l9yzzZaBm+q1aU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2MVmiTxbloqcmtAJzvTkDaC5cQ46mkBJBkpj0eesOEs7roake
 9nlHfvx9Hq2nt1UxgQ4D8yBezXRTsaW/1hODZEKjxTd+E1EZ7WkYxGu7z9MIZqptiFSmTouP0IJ
 kBOM=
X-Gm-Gg: AfdE7clMjBW/L/ArhXiSpve07ZKNI9+EUqzL4KQX8zBRGpGjR+eS8VBy53MuQ8NEkFx
 WiD8P3c8bffq9wBUk+Z0b3hF3U86qLTddJfPSlE4bTcBnsPqCgLo9FQt1Gy4/1W7slUSausGMyA
 HDDPgn8DD/z8d1kkFylLhx/FzZKy1YEzBKxl6sMIfbXn/SWenyxyRypMvrONVDKzO421P0YTt3r
 tcdfzfCnjcy7QBdPKbsP5NAVrXJ9632NJTcXpeQgubgNL6bXRe1y+Lb1in8Z/YcMlVWhiFwGBMN
 0XFu/CAdKniOHXsJ/dyTFoXrg2GIgNe5/Xa9WHwbKjz7q/rqYJhUSGbKyF/fMkconaLwwgn5ZUb
 KIy9n1dSp5+rwFyi2cSAxeY7MoStqHiAM8Xv5MVrGVBs4JySgw/nalOW0mqXGmuWJx+nLlX/+ht
 bsKN5xV2B2/arrY9KQqDyaEaD4bKBpD2S4LZP7vSebpDIJ
X-Received: by 2002:a05:6122:a24:b0:5bd:79be:8f3d with SMTP id
 71dfb90a1353d-5c1b667576cmr630775e0c.4.1784307837095; 
 Fri, 17 Jul 2026 10:03:57 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com.
 [209.85.221.174]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1eefe59ffsm949744e0c.10.2026.07.17.10.03.55
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 10:03:55 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id
 71dfb90a1353d-5bfaa014978so2665157e0c.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:03:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RpizgDFuKrhlRYPDilCpiYL+nPCTNs1FUyAEeh94buPXKk+x5w/FX7A1+wB8cycOz+JTA7Mr7TQsus=@lists.freedesktop.org
X-Received: by 2002:a05:6122:4689:b0:5bd:c52e:5278 with SMTP id
 71dfb90a1353d-5c1b6672a10mr590060e0c.5.1784307834087; Fri, 17 Jul 2026
 10:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260717143119.1815106-1-johan@kernel.org>
 <20260717143119.1815106-2-johan@kernel.org>
In-Reply-To: <20260717143119.1815106-2-johan@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 17 Jul 2026 10:03:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
X-Gm-Features: AUfX_mx8-WoOVhZrSgUBlVvgJVwx2aS4_-6WlhMllLZfKjuDOM4r92VnKp7FzeE
Message-ID: <CAD=FV=X33HQcz3atmFzor2oLJzxzcRBJsnsSu_ewErduSxy0gQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/panel-edp: fix i2c adapter leak on probe
 failure
To: Johan Hovold <johan@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
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

Hi,

On Fri, Jul 17, 2026 at 7:32=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> Make sure to drop the i2c adapter reference on probe failure (e.g.
> probe deferral) and on driver unbind also if a devicetree redundantly
> uses the 'ddc-i2c-bus' property to point to the aux ddc bus.
>
> Fixes: cc5a3fc041f0 ("drm/panel: panel-simple: Stash DP AUX bus; allow us=
ing it for DDC")
> Cc: stable@vger.kernel.org      # 5.15
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Link: https://lore.kernel.org/r/CAD=3DFV=3DVZPhzHU+Pet2m3L+Pqc7mOPfZC-f5p=
0OuNL79wNZPxRg@mail.gmail.com
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index aa27d6cd932e..ac815729aa83 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -831,6 +831,13 @@ static int generic_edp_panel_probe(struct device *de=
v, struct panel_edp *panel)
>         return 0;
>  }
>
> +static void panel_edp_put_adapter(void *_adap)
> +{
> +       struct i2c_adapter *adap =3D _adap;
> +
> +       put_device(&adap->dev);
> +}
> +
>  static int panel_edp_probe(struct device *dev, const struct panel_desc *=
desc,
>                            struct drm_dp_aux *aux)
>  {
> @@ -878,6 +885,11 @@ static int panel_edp_probe(struct device *dev, const=
 struct panel_desc *desc,
>
>                 if (!panel->ddc)
>                         return -EPROBE_DEFER;
> +
> +               err =3D devm_add_action_or_reset(dev, panel_edp_put_adapt=
er,
> +                                              panel->ddc);
> +               if (err)
> +                       return err;

Yeah, devm makes this so much nicer. Thanks for fixing!

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'll plan to apply this, probably to drm-misc-next next week. Unless
someone objects, I won't land it -fixes because it's such a corner
case.

-Doug
