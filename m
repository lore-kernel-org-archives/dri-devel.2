Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6A24CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:17:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA5F510EC12;
	Tue, 23 Jun 2026 17:17:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K1Flua+Q";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C2310EC12
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 17:17:26 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-5bbc6c99c3aso56186e0c.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782235045; x=1782839845;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gWB3K6b1geNp8ArdIp/eX59S1nNvutg2JL06lrs85Ho=;
 b=K1Flua+QbwO37z1oQrE+0YlCa62zvTCQ4YqZD88pynt95NPNDUIi79t9IoqCU3lRUA
 izpKAUTDtr2L4v7KV/z5qFvCZFkkZnC9kQGjMr8fN0yN87bOcR48FLxiXSi8Jp7MnCUx
 rH2/0SO91xX7zYKzvSXqHXuDDEy6UHlPiK3Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782235045; x=1782839845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gWB3K6b1geNp8ArdIp/eX59S1nNvutg2JL06lrs85Ho=;
 b=jRAGHAE5AGLpTNMXTeYfLigfjw0Ufx5X2+8kjQIKUzycoZPUwH0CxFb19GmHGVR35u
 jM03Yb1Pm+jdzH0gQhMZuz6wm5tVIwkQ7+rRRKd2UwTZt9oUkUTdMRNoimPuIsmWI/as
 Ja65v5gB5JXuy9bffGxDIt8rL3I88cag2Q7aQvgzPazlr/Abki2xCkHne7a3IsF/JOoS
 W1sK17AfctnqVKH8jiZCbXAoj6uGcAnPipQOphXM8nJTqHMtYHiBMBGvqhJhWDsDAzd8
 AuEjC8SxTMv8SJ4i5HZBq161bIg+3GJAJbdTvub/kYLc3ZSLilWnl8QMldpHV5238zNl
 Bunw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NFAb/y2/68huFLMLvAyVNmZizrWU96hAxRW4rjWQrgEkO+ovq4zA2MJCmDFVMTIQH8pDhJQQp+NQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxLf3lo3LW/FuG6Hy7SSCT7xAtp0aIr6mp8qKuBQbg6w9CZ9n6g
 S0DgDoz50UfBy/q195kNf20lM35/Cql6hXfZMHfp0VGQLDa9XtAzJWm+E/ObSFLQ+ysezolb5mB
 xrnc=
X-Gm-Gg: AfdE7cmjTCUigJqjwI3wh3YmqR8I7xD7p1l0xvddS4Bimw3D16fX1jwOBbVWik5yW67
 clmvuzwTtXHTMQ4VTOJI0D3vsW4u94b91VgnhnX2ZUouft+bvuh+/VQKJnJJwel6AREqXf71m1Z
 xPGXpG6zUXRO1td3ktdw1bVbHL4P9P7aChgtwHIJugzX4RL9+AmyzQzh2hxPWBpXcOfcKE3iI6V
 ZpTLlO37TqGfif+L2LYHooL4fm15gAv5i3gqDvPdEBvTFS6Ttq85IFGzAH1xni0chewZPz4ktd7
 AdYgIoZk0xwGLkAhgJnzfJ/qKESu0XrrcXsG2MEuirL2aS/a5Fw2mRPhH7crKLhARcYfY8f96i2
 m3B0ZrU+QowPq1ylCOvxHg8WqhhEwT8iio+viuR9HIKnOr+FwM+df+sbdE+pz7cHJVxdXeCe5tv
 HIlSWDudWhg1pLl0cdoUWZPBq4po2W4hOL3e/IUpXSX9vu1f1w7ps=
X-Received: by 2002:a05:6102:dc9:b0:6cd:84ba:6f51 with SMTP id
 ada2fe7eead31-72ff5f83bfcmr2436188137.19.1782235044741; 
 Tue, 23 Jun 2026 10:17:24 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-9670bf154bcsm8888643241.0.2026.06.23.10.17.22
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:17:24 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-72669a71c40so64500137.3
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 10:17:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8MHbd5FS3n2Dlnn02EQnqwWbh19zpdxfP1TnlTt42vzTCcP6g4k/+gFkGjWazbkU12XU5inkvhwBI=@lists.freedesktop.org
X-Received: by 2002:a05:6102:3e2a:b0:631:4c79:b1d2 with SMTP id
 ada2fe7eead31-72ff688ec3amr2188156137.25.1782235041459; Tue, 23 Jun 2026
 10:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260623060635.16064-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260623060635.16064-1-pengpeng@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Jun 2026 10:17:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vx=q_TzxGo3j+fKVRi9p4ih0kMmUY0MM6GfL+2-a7vHA@mail.gmail.com>
X-Gm-Features: AVVi8CevlxagFZJVWfgh0KgxFIVikHQ6m8HZkd_z5i_GTnsJTl42lC591DKf1r4
Message-ID: <CAD=FV=Vx=q_TzxGo3j+fKVRi9p4ih0kMmUY0MM6GfL+2-a7vHA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: propagate AUX transfer register errors
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
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

On Mon, Jun 22, 2026 at 11:06=E2=80=AFPM Pengpeng Hou <pengpeng@iscas.ac.cn=
> wrote:
>
> ps8640_aux_transfer_msg() programs the AUX address registers, starts the
> AUX transfer, waits for SWAUX_SEND to clear, and reads the AUX status
> register. Several of those regmap operations have return values, but the
> function only checks a stale ret after the status read.
>
> Propagate failures from the address write, transfer start, completion
> poll, and status read. This avoids returning a transfer length when the
> bridge register transaction or AUX completion wait failed.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

I think we want this, right?

Fixes: 13afcdd7277e ("drm/bridge: parade-ps8640: Add support for AUX channe=
l")


> ---
>  drivers/gpu/drm/bridge/parade-ps8640.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bri=
dge/parade-ps8640.c
> index b93514023baa..bf5a36e76c56 100644
> --- a/drivers/gpu/drm/bridge/parade-ps8640.c
> +++ b/drivers/gpu/drm/bridge/parade-ps8640.c
> @@ -257,8 +257,12 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_dp=
_aux *aux,
>         addr_len[PAGE0_SWAUX_LENGTH - base] =3D (len =3D=3D 0) ? SWAUX_NO=
_PAYLOAD :
>                                               ((len - 1) & SWAUX_LENGTH_M=
ASK);
>
> -       regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> -                         ARRAY_SIZE(addr_len));
> +       ret =3D regmap_bulk_write(map, PAGE0_SWAUX_ADDR_7_0, addr_len,
> +                               ARRAY_SIZE(addr_len));
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "failed to write AUX address: %d\n", r=
et);
> +               return ret;
> +       }

nit: Include "msg->address" and "len" in the error message?


>         if (len && (request =3D=3D DP_AUX_NATIVE_WRITE ||
>                     request =3D=3D DP_AUX_I2C_WRITE)) {
> @@ -274,13 +278,21 @@ static ssize_t ps8640_aux_transfer_msg(struct drm_d=
p_aux *aux,
>                 }
>         }
>
> -       regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> +       ret =3D regmap_write(map, PAGE0_SWAUX_CTRL, SWAUX_SEND);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "failed to start AUX transfer: %d\n", =
ret);
> +               return ret;
> +       }
>
>         /* Zero delay loop because i2c transactions are slow already */
> -       regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
> -                                !(data & SWAUX_SEND), 0, 50 * 1000);
> +       ret =3D regmap_read_poll_timeout(map, PAGE0_SWAUX_CTRL, data,
> +                                      !(data & SWAUX_SEND), 0, 50 * 1000=
);
> +       if (ret) {
> +               DRM_DEV_ERROR(dev, "AUX transfer timed out: %d\n", ret);

nit: not all failures here will be a timeout. Can you adjust the error mess=
age?


> +               return ret;
> +       }
>
> -       regmap_read(map, PAGE0_SWAUX_STATUS, &data);
> +       ret =3D regmap_read(map, PAGE0_SWAUX_STATUS, &data);
>         if (ret) {
>                 DRM_DEV_ERROR(dev, "failed to read PAGE0_SWAUX_STATUS: %d=
\n",
>                               ret);

The one above is super weird since we clearly meant to set "ret" given
the error message. Not sure how we missed that originally. Oh well.

In any case, the change looks good to me, though it'd be nice if you
could spin with slightly different error messages.

Thanks!

-Doug
