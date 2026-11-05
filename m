Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9791606A32C
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412 header.b=BYCzEXmX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FEA112C89;
	Fri,  6 Nov 2026 09:20:37 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C817B10E920
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 02:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1793846707;
 bh=8nHg2KK9YdUFsDyCN5OyhUk3RMp8EQBW/fDZ8x8OirA=;
 h=MIME-Version:From:Date:Message-ID:Subject:To;
 b=BYCzEXmX5Z8Vdz0cCGq1QzbKv6jTnOzU+R9ERQ3Qh9P/rxARiFjBUVBAXXJsVJF3w
 31LJP47ev07di2U+QdQTgY00rRidJD9btQezNDcDHckRT6az98VSP5j4m4drtJ2zi8
 Lzfq6TTYMMZUrnZzMzrwguWDUdKEhjQ0qSBCxXMY=
X-QQ-mid: esmtpsz16t1793846385t1322bbc7
X-QQ-Originating-IP: WMfYFQZWEAkLcuN5QMW6aC19/cu4twncQ1JEd6CTEKA=
Received: from mail-pg1-f174.google.com ( [209.85.215.174])
 by bizesmtp.qq.com (ESMTP) with SMTP id 0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 10:39:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3204086409100175402
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cc758830601so981627a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 18:39:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBwzGP1zjrZ0xjj2ozWSGheJ7WTmtjLmqF92fgXtYh3JcRZhUE2plcqhbCJrFnMpzYy1sVJEhtT6ZXk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+BdJ0eIkSmq5LoY27y0HJDKngC9qrAlfnIINf07j92LULYWw7M
 yEUGZq7G5cJYY3zd+Zwukpx8xfB4tkWuxXmC2A9GcLvmVAzdc8Zh3Boj4fIu29c3k7akZj+CZKt
 V7s6qGMw99d7NNwcVvCyqHu8mwBkG/Pk=
X-Received: by 2002:a17:90b:562d:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3ae8982c1ffmr16206466a91.45.1793846382617; Wed, 04 Nov 2026
 18:39:42 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Chunyan Zhang <chunyan.zhang@linux.spacemit.com>
Date: Thu, 5 Nov 2026 10:39:06 +0800
X-Gmail-Original-Message-ID: <872B2B4EAE847E62+CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
X-Gm-Features: AclHuK-lEE7dv-iC1Lsio6aPGOufL5hgelB1hFojisk2-zoMsjC0hhsp9HraOXA
Message-ID: <CAAfSe-uD=s0RpuqQ_h+_fErcEC+G=N_LA6e=p_sXJ=iG7jMc3Q@mail.gmail.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MGiMXVMajPCi1YnGyO75/V8gfjMb8SSSJQFpJm7Wf/4lBEfesFR+dN50
 4iqH5xOpwbOVjuTEhyQ9JpV1//bs7N8AqwVTLM/seUiFJkR3LILGgUgL94tPgJJhluTrkqB
 t5PjxZDjXOqMXO9/XPAzk6rACpgLj7wdYSCRJZdvY63L6DcD9PLZw7bQIAtZKb3XXfruxmg
 B8KdIPHHpsev4KGNOisaCGBmII8jrfoeoY/B7cEAWXw4UO35NAr47GKor/1Mwvq3aLUezpO
 jYNbRaGoN/R0DtfOdk39ZFhExdRlT3SAgWsAMPshzoHJTgkPbSYNM2oR0kxzzIZ6eKYsHW6
 b6EjdsvYsIot/G7JjcPxSkhRZr1OYekI6/sN2msPLae9FTNqg1G9WgCSGvrQ4Gu4rKWKmDo
 /Im3PWUZgncdwtlhr4a1YMzgbewmdRv46kM0KqCV5SDBO22aXLEM/CIhhthHeF4bbKgJmgq
 vOZcwJoaPiM+LfAU/B3VDjhtrXmNd0EU3StyvH+OgbM+sqJVx83tV2k+h64GQA/tMoHFMyZ
 tP7/t2HU/Xf8TIiO1+TIHFD3NFo39BWEIPK7u0abvxO8NQU6fOP3L4QdPuLH9LMquecTOdq
 +hUp4w0on0Hr5Z93B8MQ4e8ivq9rwgc2vWELijjIFY+EeZMHAMMD9tCstasKvgRTqWCynUC
 0S2cD6aoDrUjLujCW3XbTb0wp+v7Q9emMO61mNNDW0k/TlayRl2JJSXeNiGURq40FrMBtCL
 bMJwCWCZjQz4fmTpxhE/xijQNgxTP/aC2sq1YWjkmz48HeCntIc3CLYI2sjKm+pNMVbIpJn
 /kCPGRIGkbqYLNDY1MD3VGeJ+WfJTr54qLw705tGH1CmzsrmihTijPdqN2fEc1KH06Epk9O
 Cb+DZ9vutq53Udft0V+HnhXMvgb+xQUIz/9WKAoKzyrxRl1KOdAYEaDeCJvz5zfBWa0ayFw
 8KNxgAVthVpepLVlRhrSYO28VW2j1p++BSJYsm1e5Rbteka+GgQTmXD4Y8h31sfpXgxa3A4
 4TLcyBroJA19GWJn+d+Ws2t0cpArb5MJsZxnwRnw==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2 Nov 2026 at 21:53, Rob Herring (Arm) <robh@kernel.org> wrote:
>
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

[snip]

> diff --git a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> index afa551f6185f..222d70baef1e 100644
> --- a/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/sprd-thermal.yaml
> @@ -47,7 +47,7 @@ properties:
>      const: 0
>
>  patternProperties:
> -  "^([a-z]*-)?sensor(-section)?@[0-9]+$":
> +  "^([a-z]*-)?sensor(-section)?@[0-9a-f]+$":

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan
