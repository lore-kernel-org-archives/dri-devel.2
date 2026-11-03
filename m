Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266A606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LLb7A2Tx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98DA910E169;
	Tue,  3 Nov 2026 18:59:13 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A70310E169
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 18:59:08 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3645f0f3fcdso7522371eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 10:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793732347; x=1794337147; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J7X+N3b/Iozr8Iw7Q9vLqcq+wqZH/CWnHiKVeMbKEmo=;
 b=LLb7A2TxJojoPn026clDSOCXAzdtjdOGTo+oSytXqKuGjtWU6zMOVPrgxY9S6U+U7h
 ggHpjAlMB9Gt0pSAg7o/MllL2d8SzkuTHS/Yz+Owt6Hmz+U4gGpQlRYT1M8IrnDf1ry0
 MS0qavWX6gG8OeEMtOs/Vz0TnDLjXd0MIAE6BYyMDndjciZ2vKvh6wx5AzqbHuesd2Xp
 E+Envi7CkWQKeuUFxdwG9fgYTGKNSHIMo7+B1KNJFv1zA+1bLKlFsyHmUh69+eHw8bHL
 Ya1rks+jd55B7btjv3zkninkK56CeAnRNuUPkCdtgKfCtaK15u3+9nbRKQnMNxM49j6C
 DDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793732347; x=1794337147;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J7X+N3b/Iozr8Iw7Q9vLqcq+wqZH/CWnHiKVeMbKEmo=;
 b=02iRLlq1elpxhwkJBXjdUidywdiI9EPDsqplofV7yWqWyjYnRripD+nh0qN61LejOR
 AboASsTwS+biHApjW40WJk+CIjAHqPetk0Ym2q2BH6g4vrSWEpMxORJA0FDDzV2X7JZc
 x8g8j2yV+2RNJjPQlh4VQyl2YfFGbyO5y0swucCMHfjnvJHzre/epbqPhbg4VtQcnVR2
 gGuM/FTXYJfc8bGxHLz0HnETRF9sf93yfsZbfekTmfjxVjSqNQFr2iV8GZ2GktHQqHkC
 RPA36NMfU7Yhw5FLsIYPODorx7yFV2OJ710ZeQpPGm+zsrdqJR0Y8gqGGZICCCu3arqJ
 N2Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy1IgG2ovOHrQRo1ywsH7q/jAga8UkzeesdryirdgQl2l96CAaca1R4uY5NdRi39278cn2LRVj6edc=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Oav0wNCEHWCKD1jOz2n3eT4gM6VNFbHt86hMiruWAheT8SSo8
 uCWI9lQgNrVSIjbm1nInwF80cV9h/zxDSyfuhgsNH56GDqUuO0QlvpqF
X-Gm-Gg: AYBFou2lH0w5yofzVN/iemE3LERe/soFni0LyVOvdOGI1GwLzlMk3nMuJcvN+puqFaw
 UY87QxOcThmmcJvz7N/JknZ3YNfp8n/w0oDAS8LhBghcHOjk2NhoXLpU+Iy3jD1N9IXSoHH882E
 C++BJdzVezV4jhgxRG8VZeW0Lm96LLVhFxiN9TYLx7OE+tezcl5XAedA4LQXvdFOq5nvgqG7aK/
 ZO3VLlIJEQQJMmV9k3MKlf09iclfEgZDbJpcD7t2lE0LKHe92N0sJkS2ewuG2PBKDottrXhbG5M
 bQpriL+jgVUUUQIzU7lwVbpr7ux7Prfid57IH6/UWpzZ5GArUjkwCY6AhclS9YXY0YzGWlYqPWz
 oIYzGEhT6Q8Sl2nIwmrJNhC+F5Sn+Hl1+rKeDHHuQTVUHM3tj9Zn5vKxjA8ah2BkLamzVNizc4T
 Mw7vKaxzakebkcmLpt8U61mOum3hqCuePhD5DEfQTMBXLgtI6dtajORg4FmnYdDnjV5bgWZPCDQ
 ZT6NN8UbY6wi/R/8owrI2cr+1YmBv727WsqPWTRqOj4pwRFCNuBbuhd/0y9uo/GtheIGyzSIMP6
 Piu+zONOL+3sSzS5uutaPt5/ut21M2pLMP+8qXC9gWoOJXw/e9zVcGib8IpLbyk5oq52
X-Received: by 2002:a05:7300:7b81:b0:351:7ec1:a92c with SMTP id
 5a478bee46e88-36a42431768mr30787340eec.28.1793732346941; 
 Tue, 03 Nov 2026 10:59:06 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca39b3b7esm49159eec.28.2026.11.03.10.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:59:06 -0800 (PST)
Date: Tue, 3 Nov 2026 10:58:59 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, 
 Ulf Hansson <ulfh@kernel.org>, Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, 
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
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-gpio@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sound@vger.kernel.org,
 linux-input@vger.kernel.org, 
 linux-tegra@vger.kernel.org, mfd@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
Message-ID: <auou2CBiiR6zA0G0@google.com>
References: <20261102135330.2493332-1-robh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
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

On Mon, Nov 02, 2026 at 07:53:22AM -0600, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../bindings/display/xylon,logicvc-display.yaml      |  2 +-
>  .../devicetree/bindings/dpll/dpll-device.yaml        |  2 +-
>  .../bindings/embedded-controller/google,cros-ec.yaml |  4 ++--
>  .../intel,ixp4xx-network-processing-engine.yaml      |  2 +-
>  Documentation/devicetree/bindings/gpio/gpio-mxs.yaml |  4 ++--
>  .../devicetree/bindings/hwmon/maxim,max31790.yaml    |  2 +-
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml    |  2 +-
>  .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml         |  6 +++---
>  .../bindings/input/touchscreen/cypress,tt21000.yaml  |  2 +-

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com> # for input

Thanks.

-- 
Dmitry
