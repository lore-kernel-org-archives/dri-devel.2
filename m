Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7173606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rYRvQAsX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 412BC10E22C;
	Mon,  9 Nov 2026 07:40:26 +0000 (UTC)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E9410E82C
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 07:40:20 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc4aa0246b7so143368a12.3
 for <dri-devel@lists.freedesktop.org>; Sun, 08 Nov 2026 23:40:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794210020; cv=none;
 d=google.com; s=arc-20260327;
 b=oUPBR05VFgZ30SV/Cq9lIKWvIMu8J8XNzkdsuE0/zLxvuYA/1YsXB/R0XyIhF9Y7hw
 02Fu4Un/3cF2hrcydGIlHu6ybz86L/WytkEv+ra5hp+hevIoCGzf67ThZmwNv1qh9Mq3
 LO9Jul+DSuAa0groHav9GfarTuyXz3e8yC0gWz9lu8dhntg8CzVTJf+KjOTvlyWpXbB+
 24dwwvfZJVgohkfK8/b14sWBJWCMpMYg8dkV+iqTQ2QYKc7yyJfDru/A6+3l0TTt63AF
 r6Q2FDzXSOgU6QXI9jFuA4HrPq2yR2zq3JrUe125pEyDodCTeFX7+24swNko5vezswYk
 JKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
 fh=0laE4jyY+HgwKQ49NJGBthAZD8E3ErychYN42xhtNL4=;
 b=kIrhkZUUOFQBv1cys3eTlJrMHLs2lcgcNjxWPiTulg9HKWDQxoIAKXwXNc1AfqdQ2S
 M0xH+g8IJhK/7tR6xL/CRJ9iN9qEHwk/Veuo5UZTmBUGEUG9CYMyL7usaGkQXzUT0Um7
 GyR1qNfIQeUlRhczAExCqkOwvAdFLSOwjNzt2hz+ooCyDP/N5Ia4o+x36j+2YgEsRFZe
 WJNygsbWAm8aJWjJxd5dnjy1MUIOdunAMB9K3NGEVXPeRd+1nvjK0VAjx7K9vZ/kBe9k
 awe5QLg3mMguAhq52Zj1WPqUqb57+EuWjUyjS7gskC8gCcYAjDR1jbVMgBSek6cxRZll
 dUbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794210020; x=1794814820; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
 b=rYRvQAsX3l1bLdkhY7gPxROtYet0oQaZs7wFjXDd+lXiYGbhxYoah3xMcDwGMBOvPb
 KUISD8BhfTn77ryx5c18Aequ6fS9zBeIuLdIEBs8Iyv2FtsCED9gdUreZQAOVG48dMO4
 hU/JHXOSzg5CQOPWrTl63AMwwnJLoE8Da3ue7ZEcXqUV2HBWJ/KHintSxu7x9yEQbPFk
 5OJjTRvGJHpjOOuRLKwrGw2bznOOO5h8mLHwmWydrgeaApxN5kSNk1dBP3gdoQIPdS9m
 bgys8F3LOJ5O8fR9u7eqP+n2xEVgJt5KRBiAU6X//QQL5gJy6ldONw94a3N5BgRHbAp4
 Zu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794210020; x=1794814820;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qbtFVfAV0d//avrt7X6KHwZhQyPReObvw80fRr8okBY=;
 b=n4XyJYabyiwT8sstNn7gJ2G70lVtCgvdmMk9UYUO2zSwHWD013XArVNWTNNMM85l2a
 iSS5jUvoKrGk8qLSCWpdOq1I00oBojUmXJ7miaEn1LKYvotQtcNgWmI2K7HRpT9Lo2vL
 AI2ZswNTS8q/ZDgjNAh9PxVZZLewN7nDg3MnZRTzPVCx0ZnH2UlYdLMDsZr+MHexjJBl
 +KA5yVVBsFKJaIQ2P0mTDJmu78VlZthIbbgDC4/Ux+ioCwyXjfUS5yj/ZpR8ENJ3oRhH
 evP3KZMVeSQ8JHjT3slUy5iVN4wbdDnidDkMEQx++J0Kzp1f7sxkHzCc8dg7Yvd4nSq2
 qq9g==
X-Forwarded-Encrypted: i=1;
 AL+hErGKULmdzjVxABcYX5Lc7NxyppPo2WjYfoR416ut0ga9kifvIl81+nAMVryBnGI9ANX90Ws6etWJ+Ns=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9u1hqMMyDZZ5wcBrUE5N9tUQ2BFfRI+YRmdQeZUyVzFJrNtLbb
 PFzZ8bOAbvHlaaE2tjZVQdsVJR7pe5X7WjTpwCCoaoY7GxJWoUUmKnTWY1WzJBfI9veLNTfg5DU
 CLeEsjR7mG667TfY3z4hWUkmq9GcFNnM=
X-Gm-Gg: AYBFou2vU9KUeGj9tKe1IKJlv1xGDUb0IXGB077gq+V5vsLmirxSTyBnx5QF/fm1riv
 /SUUOuXDANCQQm14v6rRQJetP7cnM6EGNF/xATa3u2D6CaHXGXHfs8VinQB5GWqjpo3oGusKx8d
 P+u3I+Se5sdwQbvk2xYycHkeeBs6mAaWWxipLULy4RUZJXiSAUOEhOZKooTtoFneeoNvq8oh4cD
 Q0lNE2ZS4zAKF6zbhY/ZOynGb4ZsjeckoUPpfbGRQGfkhnXxPfU4lp5rRqlmGUai40ikN5yxFxy
 TsAc7BKt+XXeXTTnS51HVi8/hUl9pTdEJJWO34tQ4yZ7y22kGELpvDgTofgQ+jc+nPg6YMQjfFM
 PZi6HZX+efoCKyJ+MsDV3uOr2WSYOapAdzb4=
X-Received: by 2002:a17:90b:384c:b0:3ad:a270:a623 with SMTP id
 98e67ed59e1d1-3b12d107e44mr3364118a91.4.1794210019701; Sun, 08 Nov 2026
 23:40:19 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
 <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
In-Reply-To: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Mon, 9 Nov 2026 15:39:42 +0800
X-Gm-Features: AclHuK_dnPMk52UN3-2_wspDGRy5a6s-cwmnh8paY6ZY-G54Qz5KZ0bygsAWCVc
Message-ID: <CAAfSe-shr1+0YpxEvf+4k+DyGe3==PUiD72CwjE+RC4gX-ShiQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Ivan Vecera <ivecera@redhat.com>, Benson Leung <bleung@chromium.org>, 
 Guenter Roeck <groeck@chromium.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Shawn Guo <shawnguo@kernel.org>, 
 Chanh Nguyen <chanh@os.amperecomputing.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>, 
 Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>, 
 Scott Branden <scott.branden@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 chrome-platform@lists.linux.dev, linux-gpio@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 10:39, Chunyan Zhang
<chunyan.zhang@linux.spacemit.com> wrote:
>
> On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
> >
> > Unit-addresses by default (and most commonly) are hexadecimal. There's =
a
> > number of cases using decimal patterns. Fix all of them, limiting the
> > pattern to match the 'reg' limits if there are any.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> [snip]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yam=
l b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > index afa551f6185f..222d70baef1e 100644
> > --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> > @@ -47,7 +47,7 @@ properties:
> >      const: 0
> >
> >  patternProperties:
> > -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> > +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":
>
> Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Following up on Andy's note about this:

Please disregard my Reviewed-by. Even though I did look at some of
the other hunks, given that I'm not familiar with the other hardware,
I don't feel comfortable giving a whole-patch Reviewed-by out of
caution. And since I'm no longer the SPRD maintainer, an Acked-by
wouldn't be appropriate either. So withdrawing is the best option =E2=80=94
sorry for the inconvenience.

Thanks,
Chunyan
