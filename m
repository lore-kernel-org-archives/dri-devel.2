Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6403FE9DE5B
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 07:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B154210E753;
	Thu,  9 Apr 2026 07:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aeiDIhYb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D92C10E753
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 07:41:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AB9624458D
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 07:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8C5C2BCB3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 07:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775720498;
 bh=lc8JQ/vWkeejRsiU76ULhKIucAIfpuHv9grmFJL3auY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=aeiDIhYbjGLVo5et9i0z06029dElhtQsqqpGSxDa1v9OZyjsB1oTGh8K6bcFc7kcn
 JLI7awnKYXneMHhvfm2BjANOEthYuG0g1McbanPHizN0r/Ms/LSpTaQRKn0xIBgK6t
 BTxEwOB4pcbylMNXanxPcYLL20CwkViS+pqgEGbqI+rLLh265g55YwC0kCOxG1ByxJ
 IjOiQPHKfXFyv18uw4OPusWcwwj+u7tKtygv4ZtsHsIwrEkyh6/rwDsgQT6YzrcvrO
 NBXAwCoiGpgo0x4/xjxPcSQwI1tcKMz4/lsirKZLQAQrcGN2MnmsMzK2cTruvw6Pct
 c6wbE2piH1biQ==
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-38e0aa4221fso4369981fa.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 00:41:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YyrCh5q53hUvJbybbphv0Fi4dE+8TwDR0FhT739KkGJfV7MuOQf
 1yonWRrlwHpL891yR9/VakMS0MXymHJUPN9c//j9zEz73LfBC2BybmIZ5NbMMOfdRSROUyk5NHb
 XXUiWE28NVpzAm+tz2KV2uC2/gak2uoIgpD7b4jPIrg==
X-Received: by 2002:a05:651c:4192:b0:38d:eb82:d80f with SMTP id
 38308e7fff4ca-38deb82dc50mr48627071fa.0.1775720497068; Thu, 09 Apr 2026
 00:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-19-5e9119b5a014@oss.qualcomm.com>
 <CAMRc=Mcusnm-k76e6jTiwrw5xJL7f-nWBsg4=QpD08cv8pPgMw@mail.gmail.com>
 <l6pezliurpgv2mopw2xl4gfgpki6r3v6ufpsaavj774qnxgept@h3jxxpco23oa>
In-Reply-To: <l6pezliurpgv2mopw2xl4gfgpki6r3v6ufpsaavj774qnxgept@h3jxxpco23oa>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 9 Apr 2026 09:41:23 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdRs3oSYUCc8t1Fz+9f4f3FS8gpzh4OqGLwpzhR09nsPQ@mail.gmail.com>
X-Gm-Features: AQROBzDMHxHCpdplwZHc_f_Epk3_RdAPtZIzTXn5xXroKG8KWM4nBKA4II4kNgA
Message-ID: <CAMRc=MdRs3oSYUCc8t1Fz+9f4f3FS8gpzh4OqGLwpzhR09nsPQ@mail.gmail.com>
Subject: Re: [PATCH 19/19] gpio: add GPIO controller found on Waveshare DSI
 TOUCH panels
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>,
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
 Linus Walleij <linusw@kernel.org>
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

On Thu, Apr 9, 2026 at 3:26=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> >
> > This driver looks like it could be easily converted to use gpio-regmap =
and
> > become much shorter in the process. Could you please take a look at
> > linux/gpio/regmap.h?
>
> I took a glance. It is a nice wrapper, but I think being able to call
> waveshare_gpio_set() internally without extra troubles overweights the
> bonuses of the wrapper. Also, I'd agree if there were extra complexity
> here (e.g. the stride or the in/out handling), but having just the out
> GPIOs doesn't seem to warrant it.
>
> An alternative would be to split away the backlight into a separate
> pwm-backlight device. Then having waveshare_gpio_set() isn't that
> important and thus I could switch to GPIO_REGMAP. But then... We don't
> have real control over the PWM. We are really programming some values,
> with the actual PWM duty cycle calculations being handled internally.
>
> With all that in mind, unless you really insist, I'd prefer to leave
> this part the driver as is.
>

Ok, with the other issues fixed it's good to go then.

Bart
