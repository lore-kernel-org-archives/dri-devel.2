Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF50606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 08:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2FB910E928;
	Wed,  4 Nov 2026 08:58:35 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.36 at gabe;
 Wed, 04 Nov 2026 01:59:56 UTC
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by gabe.freedesktop.org (Postfix) with ESMTP id 602ED10E1F0
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 01:59:56 +0000 (UTC)
X-CSE-ConnectionGUID: f9sY6K76SNmyuqXh2AHvxA==
X-CSE-MsgGUID: eqxYOLpbRY+hlrpxrvhbIQ==
Received: from unknown (HELO kinkan3-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 04 Nov 2026 10:52:46 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
 by kinkan3-ex.css.socionext.com (Postfix) with ESMTP id F118120695C1;
 Wed,  4 Nov 2026 10:52:45 +0900 (JST)
Received: from iyokan3.css.socionext.com ([172.31.9.53]) by m-FILTER with
 ESMTP; Wed, 4 Nov 2026 10:52:45 +0900
Received: from [10.212.247.157] (unknown [10.212.247.157])
 by iyokan3.css.socionext.com (Postfix) with ESMTP id AF32110FA4D;
 Wed,  4 Nov 2026 10:52:43 +0900 (JST)
Message-ID: <9593dc64-5629-4262-857b-a6a570b03230@socionext.com>
Date: Wed, 4 Nov 2026 10:52:45 +0900
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: Use hex unit address patterns
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Ivan Vecera <ivecera@redhat.com>,
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Lee Jones <lee@kernel.org>,
 Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>,
 Hans Ulli Kroll <ulli.kroll@googlemail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Orson Zhai <orsonzhai@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Shawn Guo <shawnguo@kernel.org>, Chanh Nguyen
 <chanh@os.amperecomputing.com>, Alistair Francis <alistair@alistair23.me>,
 Julius Werner <jwerner@chromium.org>, Paul Cercueil <paul@crapouillou.net>,
 Dmitry Osipenko <digetx@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, Ray Jui <ray.jui@broadcom.com>,
 Scott Branden <scott.branden@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-gpio@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-sound@vger.kernel.org, linux-input@vger.kernel.org,
 linux-tegra@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org
References: <20261102135330.2493332-1-robh@kernel.org>
Content-Language: en-US
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 04 Nov 2026 08:58:01 +0000
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/02 22:53, Rob Herring (Arm) wrote:
> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

(snip)

>   .../bindings/phy/socionext,uniphier-usb2-phy.yaml    |  2 +-

Acked-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Thank you,
  
---
Best Regards
Kunihiko Hayashi
