Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6105C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JxcYmwp2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8AE10E658;
	Wed, 28 Oct 2026 16:41:54 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88EE510E658
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:41:48 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5bfc3292d90so953488e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1793205706; x=1793810506;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8aqqOJYr4Hmv6RgN8CmHQlYy+DEU2NSLFnHtd0L0hA4=;
 b=JxcYmwp2tDqGxkwBGSSB+NHH8xeJk6qPVd7lGhEeYWINsEDFc4rI5nI2e6WgaeNAjW
 wQ14SKrr81XXiJIA+e6SSsn+PQCRMeH8pz9oQEbDFY1G35cZU3jC0AUrZWLQQCgAZHnn
 FulOXZJHUqhJF5i4ExKBgTwcK3wS+a9mogsJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205706; x=1793810506;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8aqqOJYr4Hmv6RgN8CmHQlYy+DEU2NSLFnHtd0L0hA4=;
 b=DM040SGbQ6GjA4iggvV9h2plOGLM9S0hjYfFgz2j0e2r9HjHVkXhH13JpfpLpZFLPB
 afhn9jhpDLkUEylvvED9TwUbiNsdEaeerTbueZwIYGVT8QX44P5Bfk/MukmVffa2XG39
 CU3NImS9emB6T/tRtDsEGUnWy318GoU+79AZ4peIOkEO/JoNGzgwGYLYMm03MwJ931xM
 Z1rJVWOksPFIiB/Ivvj6XSvDInOdXPReV3xoE7lTpbHgwRD3CVk9hRdR79PI4p3G04M1
 UKsBcZck/Rp/fgpHGGjEytaeI52Fh/sH7pFxLl3C0b6W4/lHiWJXnOeGxvnYIt8zlEOJ
 qNAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBysnOMwOo2oKIyFgR3Om5/iemp81rb0lcbPA4x6Y27QrBaswpF8vY5haRYv8bbDvXxcMmnYDDz9Ogc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKjMPdDrGc56oDAJEubAwLreNqlHEgxSQBP73ewf85fx+RbsAHU
 uHTWP5JNVKDO2UtB9UdpxqQ2xJKYUinL1LFO24ync3C94twndWEvSPzHXsoqVGuURO06enVXWBr
 vEVrVh63R
X-Gm-Gg: AYBFou1J13tLBSEFoX8QlHE3iF80T5/bzSZytXJwhD0OWTMmLSzS5boM+GzaTwA1HEK
 OQ4E3YxsetiPs9c2y+Uk26zI66wTQnnoInfZqgvz8o7jQNeC/TTSeJgdPSC4MJwUJXnybye4dUj
 fxaYjlytOfrXrfNM6rY4b06m2EqP5x00KrluK1EKwn7DfNgNGgtZjuoc6I0FdEKfZl9/xYoOcpN
 wQGVNmHXNWhNwh71Cd2HoGMzWrCsy77ifrgUsCAeO9Cbr4UPWWwVkBiro7+JWojfkdHOJPZAM85
 35g9vaqhlURkgmOiOvv6X9bxbMGY2vHGf2R29bQ8jNb+QJRI95s8zTy5fTRZn9qXbMgq/iIt3kA
 r8XP5AQXrQuGgvh/SSv37l8kt9SwvsXVU9kTVPlAMyFJuqIgwirifz8Gz9LlVSCMtECV0eRUDhG
 zq85bMDU/h9LKnrURL8sB5GyE82iRXD1ohhuPEu1FMzYmTY11IEnj+cd7ufWIWXoWipSEBjoUOm
 FjnxfuMBdH4ZfahtGdp5L/+7pRGLjdjXDvFcOwXx51ZGDZuJt27QBZFsbU4I/5CwPBdP/UXXL8t
 5390QZie3n8UjGIFfEHGFZfbSJEO7DP24OWPJPLRMeivrlROBwfCrIsGTst3QRSvIruP6I+StrT
 o1VORPK2VtI5nIQ==
X-Received: by 2002:a05:6512:1327:b0:5bc:ebbc:c80d with SMTP id
 2adb3069b0e04-5bfcad2b4d1mr1146010e87.4.1793205706164; 
 Wed, 28 Oct 2026 09:41:46 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com.
 [209.85.167.44]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac70a2b576sm31758451fa.31.2026.10.28.09.41.45
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 09:41:46 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5bfc3292d90so953477e87.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:41:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBz+Puulx1+fwpadaCt9f5jXhh2/Ratl0U1KI+55cFu3TRnQnuspjG9ZZOuqABpDADL/O6swOY8lJkY=@lists.freedesktop.org
X-Received: by 2002:a5d:5f07:0:b0:48b:9d2:1a6a with SMTP id
 ffacd0b85a97d-48e5d45a3c2mr6625980f8f.1.1793205267445; Wed, 28 Oct 2026
 09:34:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <20261027-drm-misc-next-manta-auxbus-v1-3-3a45c3cf531d@a-marquet.fr>
In-Reply-To: <20261027-drm-misc-next-manta-auxbus-v1-3-3a45c3cf531d@a-marquet.fr>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 28 Oct 2026 09:34:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XmfYM8diBOh3UidN7xEuB3n+n9oAm_zhopfFLERC2QpQ@mail.gmail.com>
X-Gm-Features: AclHuK_LwyJo9CN0zxlkO30oKOFraZ6PCLD3VchvtC_WbqyDogSG-WeDzg__Frs
Message-ID: <CAD=FV=XmfYM8diBOh3UidN7xEuB3n+n9oAm_zhopfFLERC2QpQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/panel_edp: Add SEC LTL101DL02-002 panel
To: tb@a-marquet.fr
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
 Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Jessica Zhang <jesszhan0024@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 Lukas Timmermann <linux@timmermann.space>, Henrik Grimler <henrik@grimler.se>, 
 Hendrik Noack <hendrik-noack@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, Oct 27, 2026 at 5:01=E2=80=AFAM Alexandre Marquet via B4 Relay
<devnull+tb.a-marquet.fr@kernel.org> wrote:
>
> From: Alexandre Marquet <tb@a-marquet.fr>
>
> Add an entry for the eDP SEC LTL101DL02-002 panel used in
> google-manta.
>
> Raw EDID dump:
>
> 00 ff ff ff ff ff ff 00 4c a3 0f 9c 00 00 00 00
> 05 0e 01 03 80 21 19 78 0a 87 fe 98 57 51 8c 27
> 21 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 14 69 00 a0 a0 40 2e 60 30 20
> 36 00 1e d6 10 00 00 19 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9e
>
> Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 2 ++
>  1 file changed, 2 insertions(+)

nit: subject doesn't quite fit the pattern of recent commits (_ vs -).


> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 94bc54c3833a..c92985363093 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2198,6 +2198,8 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('L', 'G', 'D', 0x0778, &delay_200_500_e200_d200, =
"134WT1"),
>         EDP_PANEL_ENTRY('L', 'G', 'D', 0x07fe, &delay_200_500_e200_d200, =
"LP116WHA-SPB1"),
>
> +       EDP_PANEL_ENTRY('S', 'E', 'C', 0x9c0f, &delay_200_500_e50, "LTL10=
1DL02-002"),
> +

It would also be good to note in the commit message where you got the
timings from. Datasheet? Downstream code? Guessing?

I had my AI agent take a look for itself. It found evidence suggesting
the enable delay should be 97ms, not 50ms. The other ones seem to be
OK.

-Doug
