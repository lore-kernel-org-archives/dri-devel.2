Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0212BC43602
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:14:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5379D10E116;
	Tue, 30 Jun 2026 13:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D+NR4PWB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8608E10E0F6;
 Tue, 30 Jun 2026 13:14:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DD7241883;
 Tue, 30 Jun 2026 13:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A928F1F000E9;
 Tue, 30 Jun 2026 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782825242;
 bh=3VuQxWyNENL8ziwIh4+vVmGpesCoHqcx8KGFgDaDinE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=D+NR4PWBy6W6iM/Ff9MJncwYZfKq30z/VF5MnSG8JFLGmwT0FzFrXQ6aqWQn6tpWz
 chHpLPggi5lTbCoTpu69t94kXbZr+54B8Qro/1rU8YF3QIJBK4COjPZil73sSsG/rd
 CiVe+KSnk9WsTojsa9gNlK1n26D3/mnvCqbZMD5cX6k9unq4jh7CGsXJojiyasmvDq
 7w0D/ZsVBTMrSr6IcdOr8M0V26GjKqIDvDX2FrobXBhsyL6Jjt3N6f1qpqH6gdqybZ
 eLCJc7XBSLae7AfshSoISbnWfGD+cmyyDGkCoKB0jaQPJzFZxNYKlq0Y2hgnslfXEp
 2ae+MO2588wVg==
Date: Tue, 30 Jun 2026 08:14:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Lee Jones <lee@kernel.org>, Sean Paul <sean@poorly.run>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Vinod Koul <vkoul@kernel.org>,
 Adam Skladowski <a_skl39@protonmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, linux-gpio@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org,
 Anusha Rao <quic_anusha@quicinc.com>, linux-mmc@vger.kernel.org,
 Jonathan Marek <jonathan@marek.ca>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Taniya Das <quic_tdas@quicinc.com>, linux-clk@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Zhang Rui <rui.zhang@intel.com>, Srinivas Kandagatla <srini@kernel.org>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sunyeal Hong <sunyeal.hong@samsung.com>, freedreno@lists.freedesktop.org,
 Stephan Gerhold <stephan@gerhold.net>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Simona Vetter <simona@ffwll.ch>, Andi Shyti <andi.shyti@kernel.org>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
 linux-i2c@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Sebastian Reichel <sre@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>,
 Robert Marko <robimarko@gmail.com>, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, Pavel Machek <pavel@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-arm-msm@vger.kernel.org,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 dri-devel@lists.freedesktop.org, Jiri Slaby <jirislaby@kernel.org>,
 linux-phy@lists.infradead.org, Shin Son <shin.son@samsung.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Tomasz Figa <tomasz.figa@gmail.com>, Magnus Damm <magnus.damm@gmail.com>,
 linux-renesas-soc@vger.kernel.org,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Georgi Djakov <djakov@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 devicetree@vger.kernel.org, Luo Jie <quic_luoj@quicinc.com>,
 linux-serial@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Andy Gross <agross@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-leds@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-media@vger.kernel.org,
 Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulfh@kernel.org>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>, Inki Dae <inki.dae@samsung.com>,
 linux-arm-kernel@lists.infradead.org,
 Sireesh Kodali <sireeshkodali@protonmail.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 linux-pm@vger.kernel.org, Alina Yu <alina_yu@richtek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Drop incorrect usage of
 double '::'
Message-ID: <178282524123.2726988.10975134253725315687.robh@kernel.org>
References: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
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


On Tue, 23 Jun 2026 07:48:43 +0200, Krzysztof Kozlowski wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
> 
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
> 
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
> I split the patches to avoid bounces from mailing list due to email size.
> 
> This can go via clock tree (no dependencies)... or both could go via
> Rob's tree.
> 
> Changes in v2:
> 1. Add tags (partial Reviews as Acks, as that's the meaning of Ack)
> ---
>  .../devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml       | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-apq8064.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-apq8084.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-ipq6018.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-ipq8064.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-mdm9607.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-mdm9615.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8660.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8909.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8916.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8953.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-msm8974.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,gcc-sdm660.yaml          | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,gpucc.yaml     | 2 +-
>  .../devicetree/bindings/clock/qcom,ipq5018-gcc.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,ipq9574-gcc.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,qca8k-nsscc.yaml         | 2 +-
>  .../devicetree/bindings/clock/qcom,qcm2290-gpucc.yaml       | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,rpmcc.yaml     | 2 +-
>  .../devicetree/bindings/clock/qcom,sc7280-lpasscorecc.yaml  | 2 +-
>  .../devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml    | 2 +-
>  .../devicetree/bindings/clock/qcom,sm6115-lpasscc.yaml      | 2 +-
>  .../devicetree/bindings/clock/qcom,sm8350-videocc.yaml      | 2 +-
>  Documentation/devicetree/bindings/clock/qcom,videocc.yaml   | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos5260-clock.yaml | 6 +++---
>  .../devicetree/bindings/clock/samsung,exynos5410-clock.yaml | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos5433-clock.yaml | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos7-clock.yaml    | 2 +-
>  .../devicetree/bindings/clock/samsung,exynos850-clock.yaml  | 2 +-
>  .../bindings/clock/samsung,exynosautov9-clock.yaml          | 2 +-
>  .../bindings/clock/samsung,exynosautov920-clock.yaml        | 2 +-
>  .../devicetree/bindings/clock/samsung,s5pv210-clock.yaml    | 2 +-
>  32 files changed, 34 insertions(+), 34 deletions(-)
> 

Applied, thanks!

