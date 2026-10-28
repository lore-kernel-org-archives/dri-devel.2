Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF16606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W2HHLBXt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC6210FD13;
	Wed, 28 Oct 2026 14:57:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5E2810FD13
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:57:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 29DE9602C2
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:57:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3F71F031ED
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 14:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793199455;
 bh=mIGs1095/pi5A3phf200bT5vD03Lp1U81y8sX9m5/iA=;
 h=From:In-Reply-To:References:Date:Subject:To:Cc;
 b=W2HHLBXt6yBVAcplFhzpJ6jtmHOuCp53by4m98jBMIziA5t6rtB1YlnGlq/AWRlr1
 FQCh8fULMVw/6c1o5lmtjYYX1FdF3w72Vhh92y18FIUEBg0iAf6b+hQSp3YxO7o3w2
 NQLLEEEfBL2s7t9h24eEfYn4v1g4zC2nlqA6M7EuEQI6Z/6RdZsFX+guKD90fItizi
 a5xwC9YeA2FjWj8rfFo0XC4Al+7AXrBxYs7rFrO7GZB83wfNqD7ZuWZjpWyVfYaV++
 N/jtBDuxvPA74FBRxmYZeLCP5ayrbJBci8gmbYKVr5V6NwlSuhUqDS5ZcWnGUFJWgu
 d4cwa2zYelD2A==
Received: by mail-lj1-f178.google.com with SMTP id
 38308e7fff4ca-3a98fc80925so12202521fa.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 07:57:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBxwCqx21UjkEasNXlFgQgudBRhtoEKbckMGodHvYlNpZQ3E1o80Dp4KeGSvdvf5YkZdiKh39vTwBls=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKOB07m6kzcT8I7S9PqeF4B/wBYcigWro3BMVkKgGl94MwCOfBi
 +xXloOHofkw2AhGX1/bgk2hmIGXYQT592nsDs+OTjHvy8S1rF72uEg1CJ/tws6nZQmVgFxWl1au
 a85pR3AMtDTkyG9i9sWCo8I+w0+HJaS0wDytsyxBdQw==
X-Received: by 2002:a05:651c:1543:b0:3a9:d756:bfdd with SMTP id
 38308e7fff4ca-3ac9cf1d2cdmr6179361fa.7.1793199454407; Wed, 28 Oct 2026
 07:57:34 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 07:57:32 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 07:57:32 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028120216.2657397-1-robh@kernel.org>
Date: Wed, 28 Oct 2026 07:57:32 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md2xhYPdUEQ2SeqiGq9uG1qcc9Hi77T4k3ta_wmd56BhQ@mail.gmail.com>
X-Gm-Features: AclHuK-L3iqt92WsRHLJE8OI5aNBBhyNCiN5RHrPr_WcVOO_RomVfpU-3_RxU7E
Message-ID: <CAMRc=Md2xhYPdUEQ2SeqiGq9uG1qcc9Hi77T4k3ta_wmd56BhQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 freedreno@lists.freedesktop.org, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, Bjorn Andersson <andersson@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
 Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Yinbo Zhu <zhuyinbo@loongson.cn>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Eric Anholt <eric@anholt.net>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>, 
 Aakarsh Jain <aakarsh.jain@samsung.com>
Content-Type: text/plain; charset="UTF-8"
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 13:02:12 +0100, "Rob Herring (Arm)" <robh@kernel.org> said:
> Property names within if/then schemas currently go unchecked whether
> they have a type defined or match what's in the top-level schema. Adding
> a check finds a number of instances of typos. The typos result in the
> schema having no effect on constraints.
>
> With this, fix the mediatek,vcodec-encoder 'clocks' count constraint
> exposed by the name correction.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/qcom,kpss-gcc.yaml     |  2 +-
>  .../bindings/display/brcm,bcm2711-hdmi.yaml          |  2 +-
>  .../bindings/display/msm/dp-controller.yaml          |  2 +-
>  .../devicetree/bindings/display/msm/hdmi.yaml        |  4 ++--
>  Documentation/devicetree/bindings/dma/fsl,edma.yaml  |  2 +-
>  .../devicetree/bindings/gpio/loongson,ls-gpio.yaml   |  2 +-

For GPIO:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
