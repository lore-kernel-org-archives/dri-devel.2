Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38A1C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DFE10E133;
	Mon, 20 Jul 2026 19:30:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LkAANUjV";
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A796F10E133
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 19:30:47 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-5bfaa014978so3247302e0c.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1784575846; x=1785180646;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yFCh53IHThQmZZQdNvtWGoGHYe1GYSqGsLP0bCwERtI=;
 b=LkAANUjVq4Fiy+T/mqd/+f7FgiKbwDYclNfWDidYXrxir5rMU+3ztpkinx0ndhJ0l7
 p+raGHsVkwtUKvaSh7y5/fdZWmIOW8OF+VplC14x4vHO/vcEVkvT4I5acXNokzxMcYSG
 2/PCeB7TDPtPGgyHDdfHkb7/aP9hbIUgXcGR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784575846; x=1785180646;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yFCh53IHThQmZZQdNvtWGoGHYe1GYSqGsLP0bCwERtI=;
 b=eh8+ZqHwyyAY9FrctMbkoU3Ggw5ke2DD5XmSBgtd5tQpJWj0cLjoEk1emD+t5JXUVz
 tPIarFez2d2ktkG4sRvIFMzgUHUkBfn3tPVjB/QyYJeMNrMBN0NF1fWUADrR/NppiRX1
 aGmNfAKXrtWSDCGy7I4KeFWg+xDQhvO1KNXgWbi2zjjrsqz3Pio0u3m9hefRsNaC4dxo
 tBQxnlMyuU621+Y6eF/4uy+cN03EmA8pWC/jMNZ8BF0/1zZumGGJ10gWEiM0wGllJ69p
 Bl7EIwsdxKSuxY2hce9FJFucgvZRG7hzBvDR1beBVvqOSXaLrO97MJy+Qrofx5qhZC2u
 nFvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqINHbgEe2mBUUuMDEVLhzhWTK8HV6BySGyrI1VD8Mu9UH694L9/ifGtMgFoQjp2pePT4i/sJYVuhE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLSfNQ5Lppj010oUUuYbkuiN9Y9tSOQkurbfSSkclhsLpuqfsA
 ZgsJB/vszWDKWUl4uWTZOfL0Pwfy8uFEUeftBo2ekR4m+IjabS+mCuzXSt5JP/v813qRxOEJmPD
 +sTI=
X-Gm-Gg: AfdE7cmfFpF7Ktvg0IJqSMfyYNjOQOlmlEkBO/hrif/Qh31FMGfe/eagfAW8o30Qru5
 GIUEuxQujh8h41Nvy7TITM/97r07m0HitoIv+c/vFVL+0ZhlFQFOVRHLS+WsiSaH7mCmMmWpT5r
 3j1bnLEw2F1aHQUnD+u2GB49OTZefyjv22QgNrSAUjzNJVLBmLP2hyNl9hxc9QY1QMR5SoLyzZD
 SypL9Rmi3sOsaieX73cURGs892uIuvdJIZwmLfa47xqIH+6hRF2J9rXJlT7X1mo+NXEAhpcHSTT
 w7P/jRfbBHNZPtOF00hVL0FXxq5bS+17h+clvNgfw/r1ybcVByfBmRo4ryL4Gtd/ZTbPF00FLd7
 sgos1QC8kjCGND+YcqZPgAfsat5cPakXSi6k8cO+U+yw667DUIQNmHM0ZT8wqPbzixD3KED0pwv
 HMUG/5efeanta6yl94a99h7QRVQ3cb0hr2ZEqzsH/Y
X-Received: by 2002:a05:6123:a1:b0:573:a779:62cf with SMTP id
 71dfb90a1353d-5c1b67d08a0mr3045865e0c.7.1784575846212; 
 Mon, 20 Jul 2026 12:30:46 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com.
 [209.85.222.49]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c1e6c71300sm11493964e0c.0.2026.07.20.12.30.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 12:30:46 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id
 a1e0cc1a2514c-9690c99c917so2708013241.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 12:30:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqHqFo8Ydmi5p3fIP9MkVcoEc8lGHEeKIi/kSLJLYXXyZa9oxUih5iELkfX/QmZG9OiyEaVNSCO9d8=@lists.freedesktop.org
X-Received: by 2002:a05:6102:370b:b0:745:6b55:30c8 with SMTP id
 ada2fe7eead31-7475379582cmr3833492137.27.1784575844901; Mon, 20 Jul 2026
 12:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
 <9fa3a8e372b7211c06ec885617051f5006227e3a.1784545092.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <9fa3a8e372b7211c06ec885617051f5006227e3a.1784545092.git.u.kleine-koenig@baylibre.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 20 Jul 2026 12:30:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U-=q=Sa2tDt_+eW3c9uDPD7LrpSgANVyznS+Q4MXZGbQ@mail.gmail.com>
X-Gm-Features: AUfX_mwoq-CX2bR3FnZtkbugcCSR9SUWa3FCxOaB9rn-vNIZiJeojiIST_SCarc
Message-ID: <CAD=FV=U-=q=Sa2tDt_+eW3c9uDPD7LrpSgANVyznS+Q4MXZGbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm/bridge: Use named initializers for arrays of
 i2c_device_data
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jagan Teki <jagan@amarulasolutions.com>, Liu Ying <victor.liu@nxp.com>, 
 Francesco Dolcini <francesco@dolcini.it>,
 Peter Senna Tschudin <peter.senna@gmail.com>, 
 Ian Ray <ian.ray@gehealthcare.com>, Martyn Welch <martyn.welch@collabora.co.uk>,
 Russell King <linux@armlinux.org.uk>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@intel.com>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, Xin Ji <xji@analogixsemi.com>, 
 Marco Crivellari <marco.crivellari@suse.com>, Arnd Bergmann <arnd@arndb.de>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
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

On Mon, Jul 20, 2026 at 4:26=E2=80=AFAM Uwe Kleine-K=C3=B6nig (The Capable =
Hub)
<u.kleine-koenig@baylibre.com> wrote:
>
> While being less compact, using named initializers allows to more easily
> see which members of the structs are assigned which value without having
> to lookup the declaration of the struct. And it's also more robust
> against changes to the struct definition.
>
> The mentioned robustness is relevant for a planned change to struct
> i2c_device_id that replaces .driver_data by an anonymous union.
>
> While touching all these arrays, unify usage of whitespace in the list
> terminator and drop trailing commas there.
>
> This patch doesn't modify the compiled arrays, only their representation
> in source form benefits. The former was confirmed with x86 and arm64
> builds.
>
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c           | 10 +++++-----
>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c     |  2 +-
>  drivers/gpu/drm/bridge/analogix/anx7625.c              |  4 ++--
>  drivers/gpu/drm/bridge/chipone-icn6211.c               |  4 ++--
>  drivers/gpu/drm/bridge/chrontel-ch7033.c               |  2 +-
>  drivers/gpu/drm/bridge/ite-it6263.c                    |  2 +-
>  drivers/gpu/drm/bridge/ite-it6505.c                    |  2 +-
>  drivers/gpu/drm/bridge/lontium-lt8713sx.c              |  2 +-
>  drivers/gpu/drm/bridge/lontium-lt8912b.c               |  4 ++--
>  drivers/gpu/drm/bridge/lontium-lt9211.c                |  4 ++--
>  drivers/gpu/drm/bridge/lontium-lt9611.c                |  4 ++--
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c             |  2 +-
>  .../gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  8 ++++----
>  drivers/gpu/drm/bridge/nxp-ptn3460.c                   |  4 ++--
>  drivers/gpu/drm/bridge/parade-ps8622.c                 |  8 ++++----
>  drivers/gpu/drm/bridge/sii902x.c                       |  2 +-
>  drivers/gpu/drm/bridge/sii9234.c                       |  2 +-
>  drivers/gpu/drm/bridge/sil-sii8620.c                   |  2 +-
>  drivers/gpu/drm/bridge/tc358767.c                      |  2 +-
>  drivers/gpu/drm/bridge/tc358768.c                      |  4 ++--
>  drivers/gpu/drm/bridge/tc358775.c                      |  4 ++--
>  drivers/gpu/drm/bridge/tda998x_drv.c                   |  2 +-
>  drivers/gpu/drm/bridge/ti-dlpc3433.c                   |  2 +-
>  drivers/gpu/drm/bridge/ti-sn65dsi83.c                  |  6 +++---
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c                  |  4 ++--
>  drivers/gpu/drm/bridge/ti-tfp410.c                     |  2 +-
>  26 files changed, 47 insertions(+), 47 deletions(-)

Acked-by: Douglas Anderson <dianders@chromium.org> # ti-sn65dsi86.c
