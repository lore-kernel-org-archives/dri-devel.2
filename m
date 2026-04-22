Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529ABF9EDC9
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44FB10E036;
	Wed, 22 Apr 2026 13:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z67Osh7N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA7DE10E036
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:20:39 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7A59A41826
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D666C2BCAF
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776864039;
 bh=5KP0HfyPYW0J2NmQ5DIgfn3Yf4onw2cQ4Oqkk1x/qtk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Z67Osh7NnCzrAfvRVwJh3SfS8cXvfXaJR2137ozKBFsPKaNnEP20KUcxNsrDqAZ76
 wOWoEhRJrVOIV8HyUZYJGphpDHZHy6/KDtT40o0HsaWvT4pEvkcVbGy2cPy28V77lx
 jM/agiy9BcxxYe0fQj8ejwHk+tc79Pi+SDmJ9g34YsdwVt9UWYtde81/fr8/4Od0Mr
 JIGMZn4mfYYTxzs/iedSnFdHkLDvcsqjMqjOZm3HSW74FcHZWh5HTksHNmesnit0/Y
 2SLI13/cPgk/mfNUB6f+KbKFisoapNuFm1ccDMeLaoafstg94Np3k7mMqLCU21ikEZ
 lgWZnqY7uBC5Q==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-5a2c77c62d7so6056430e87.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 06:20:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ+830zpgbrFgkF7SOBQUJlLpdJIDBxtJEOkamz8uW7QRg4foMJnvi+TexCbQeWR5GjRBQreJYSfr1I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRNvgXvmdpkEW3slCgZRoGt2JqAQAXkhDA2GvOOp4dXNAHbJkM
 fEhnw/oTPa+gGP+tbhtYpc9MruUF9A1hxT2GCrGPtCS5p8nveja4qKxV6blPEMm9yvpH0aR5+y/
 79+/oiTqF+nFazuZjJl0BRbFgyVyUgHQ=
X-Received: by 2002:a05:6512:8005:20b0:5a4:1904:b1fb with SMTP id
 2adb3069b0e04-5a41904b214mr4908355e87.40.1776864037735; Wed, 22 Apr 2026
 06:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
 <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-21-75cdbeac5156@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 22 Apr 2026 15:20:26 +0200
X-Gmail-Original-Message-ID: <CAD++jL=zmd8yto9HuyjC8cmBj1oMgOa7C899yo_toP9Q+QJcDw@mail.gmail.com>
X-Gm-Features: AQROBzBIUxYxh6Fy1Y8k9jeq0K6g4QE275A5ZjWo0tNfC3Tdj4tYrWP4PCpCQTw
Message-ID: <CAD++jL=zmd8yto9HuyjC8cmBj1oMgOa7C899yo_toP9Q+QJcDw@mail.gmail.com>
Subject: Re: [PATCH v2 21/21] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, Jagan Teki <jagan@edgeble.ai>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Riccardo Mereu <r.mereu@arduino.cc>
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

Hi Dmitry,

On Sat, Apr 11, 2026 at 2:11=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:

> The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> controller, which controls power supplies to the panel and the touch
> screen and provides reset pins for both the panel and the touchscreen.
> Also it provides a simple PWM controller for panel backlight. Add
> support for this GPIO controller.
>
> Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
(...)

> +static int waveshare_gpio_get(struct waveshare_gpio *state, unsigned int=
 offset)
> +{
> +       u16 pwr_state;
> +
> +       guard(mutex)(&state->pwr_lock);
> +       pwr_state =3D state->poweron_state & BIT(offset);

Why is this not just flagging the same register as write-only
in the regmap and just re-reading that same register from the
regmap cache?

> +
> +       return !!pwr_state;
> +}

OK so it's write-only.

> +static int waveshare_gpio_set(struct waveshare_gpio *state, unsigned int=
 offset, int value)

This looks like it can be replaced with a few lines of
select GPIO_REGMAP
#include <linux/gpio/regmap.h>
helpers.

Has this not been discussed earlier?

Yours,
Linus Walleij
