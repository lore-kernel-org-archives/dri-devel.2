Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D5606A32D
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NN4zXVrv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CB7110E1B5;
	Tue,  3 Nov 2026 21:58:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401EB10E1B5
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:57:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D3CF608FA
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:57:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253581F00A21
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 21:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793743074;
 bh=4H8eU6z2JR3iXPnaXPV2uTwunMPI539+3YmBBPsTqq8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=NN4zXVrv4HX75rNjDW8n2rGhpIdcwT226SOYEzZIJkf4wky///aAUqXsW/LNjWIkB
 +jqhBmbKEGHqpB/RfJ3IOme2x4Uro3Y6FFkYU7Lcb9k3EYVAL1RdZOfZBIO6UiCdmd
 KU9/YPoFAEbimG8yPTj0+ET9beRolcznhTqYs/aM+V+aZskkRu62idx1+KnN4AwSau
 1qKaj1M79st+FVG6mdkANAoRT1WY2ezZ902n3LEXe1SUMJ3M1nio7P61uGsrtysmqO
 t+l8RFDh+9jqGqOg9Z/Kt58ZxPm2v6e40EATAVtiGV3R2E35gTnJzuKbjPNba1LZpc
 +CFP4IuYefF8g==
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5ba3fba0080so5402e87.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 13:57:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AKwUvBztHn6u4YuFXelhW4v9aTkGqam3Gjrju0yG0xeidVNtXxgpJGjL69w3gj/28WyVs4NL8U6lSjXKnR8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9WfUsQ3iL7ht1ar/LzYHj38vN4VxTr/W6bXD8VAx7W+Ij3UcAL
 ZOmCdej7rnhioNK6BlN2EwpzNFuL2MmVt702Di95RRqlRS4GKfDbIkhkG8TKxQm91N4ZTAISmPU
 ActxhRVcfHKb1qiEHfy7SSpylICl1+7g=
X-Received: by 2002:a05:6512:a94:b0:5bf:b246:87a2 with SMTP id
 2adb3069b0e04-5bfd957b610mr4953868e87.10.1793743072116; Tue, 03 Nov 2026
 13:57:52 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102135330.2493332-1-robh@kernel.org>
In-Reply-To: <20261102135330.2493332-1-robh@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 3 Nov 2026 22:57:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLm10TL4FkkyhvyF-CKNREA-mOSjbR5zKUisC_Wx1-nqgg@mail.gmail.com>
X-Gm-Features: AclHuK-xZTzLWXlPWAOCiWHBj5C4K-MSmY2Fnjjj517UPimoWDCn2vjwhrapfPU
Message-ID: <CAD++jLm10TL4FkkyhvyF-CKNREA-mOSjbR5zKUisC_Wx1-nqgg@mail.gmail.com>
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
 Guenter Roeck <groeck@chromium.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
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
 Chunyan Zhang <zhang.lyra@gmail.com>,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Shawn Guo <shawnguo@kernel.org>, Chanh Nguyen <chanh@os.amperecomputing.com>, 
 Alistair Francis <alistair@alistair23.me>, Julius Werner <jwerner@chromium.org>,
 Paul Cercueil <paul@crapouillou.net>, Dmitry Osipenko <digetx@gmail.com>, 
 Florian Fainelli <f.fainelli@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>, 
 Ray Jui <ray.jui@broadcom.com>, Scott Branden <scott.branden@broadcom.com>, 
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 2:53=E2=80=AFPM Rob Herring (Arm) <robh@kernel.org> =
wrote:

> Unit-addresses by default (and most commonly) are hexadecimal. There's a
> number of cases using decimal patterns. Fix all of them, limiting the
> pattern to match the 'reg' limits if there are any.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Acked-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
