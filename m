Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E8DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 13:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2DF10E0F6;
	Tue, 30 Jun 2026 13:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NCBNwFz6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B1D10E0F6;
 Tue, 30 Jun 2026 13:14:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3063B406A2;
 Tue, 30 Jun 2026 13:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C833C1F00A3D;
 Tue, 30 Jun 2026 13:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782825257;
 bh=EpQlFhGR0CXES6vDl7EpLBL9hnoH9HcaRhfoMbB9B10=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NCBNwFz6c2fKdVb19gwyDiO9PnlyXriYS81lNIf/qzXncSC47QfhPwHZOFO8CLSJY
 pR+5wIDr90lzxdE8glY97eAUFPM+0txQC5S3r4SSz1Gfz8MG9zJMDBh131aUMh/uAg
 SMmLQvKLH4T+FL5HJyt+/yv7n4sp+6zL8jfhRP8J6IP+1H2Gh7bjV/lg+zW/AEHkal
 ocCX2GPXkjOZFqcVQZdjb/dnZFXvwNKt/CW1SeQEYizmUZzjgW1/TlZ87anAQ71iZt
 sidRDyuNNArshmfU1BX5VtNY36BLF6+Brm3ifl4o7/Du2ep5qRsN4Wzqm4ZNXWtNNB
 iZbewdUkrcr0g==
Date: Tue, 30 Jun 2026 08:14:16 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Sireesh Kodali <sireeshkodali@protonmail.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Wesley Cheng <quic_wcheng@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Michael Turquette <mturquette@baylibre.com>,
 freedreno@lists.freedesktop.org, Linus Walleij <linusw@kernel.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, linux-gpio@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Imran Shaik <quic_imrashai@quicinc.com>, linux-phy@lists.infradead.org,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luo Jie <quic_luoj@quicinc.com>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>,
 Bjorn Andersson <andersson@kernel.org>,
 Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Magnus Damm <magnus.damm@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Brian Masney <bmasney@redhat.com>, linux-serial@vger.kernel.org,
 linux-mmc@vger.kernel.org, Sean Paul <sean@poorly.run>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 linux-i2c@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Hans Verkuil <hverkuil@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Andy Gross <agross@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Tomasz Figa <tomasz.figa@gmail.com>, Shin Son <shin.son@samsung.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robert Marko <robimarko@gmail.com>, linux-leds@vger.kernel.org,
 Lee Jones <lee@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Srinivas Kandagatla <srini@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Barnabas Czeman <barnabas.czeman@mainlining.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anusha Rao <quic_anusha@quicinc.com>, linux-sound@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>,
 linux-pm@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Stephan Gerhold <stephan@gerhold.net>, linux-clk@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Pavel Machek <pavel@kernel.org>, David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Sunyeal Hong <sunyeal.hong@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 Sebastian Reichel <sre@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, linux-usb@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Alina Yu <alina_yu@richtek.com>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Adam Skladowski <a_skl39@protonmail.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Javier Martinez Canillas <javier@dowhile0.org>,
 Jonathan Marek <jonathan@marek.ca>, linux-renesas-soc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
 linux-media@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>,
 Chanho Park <chanho61.park@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: Drop incorrect usage of double '::'
Message-ID: <178282525553.2727643.3907229896177636220.robh@kernel.org>
References: <20260623054842.21831-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260623054842.21831-4-krzysztof.kozlowski@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260623054842.21831-4-krzysztof.kozlowski@oss.qualcomm.com>
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


On Tue, 23 Jun 2026 07:48:44 +0200, Krzysztof Kozlowski wrote:
> There is no use of double colon '::' in YAML. OTOH, the literal style
> block, e.g. using '|' treats all characters as content [1] therefore
> single use of ':' in descriptions is perfectly fine, whenever '|' is
> used.
> 
> Cleanup existing code, so the confusing style won't be re-used in new
> contributions.
> 
> Link: https://yaml.org/spec/1.2.2/#literal-style [1]
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Acked-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be> # renesas
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> 
> ---
> 
> Intention for this patch is to go via Rob's tree.
> 
> Changes in v2:
> 1. Add tags (partial Reviews as Acks, as that's the meaning of Ack)
> 2. Do not replace ::= in mux.
> ---
>  .../devicetree/bindings/arm/qcom-soc.yaml     |  4 ++--
>  .../devicetree/bindings/arm/qcom.yaml         |  4 ++--
>  .../bindings/arm/samsung/samsung-soc.yaml     |  4 ++--
>  .../display/msm/dsi-controller-main.yaml      | 20 +++++++++----------
>  .../display/samsung/samsung,fimd.yaml         |  4 ++--
>  .../bindings/i2c/samsung,s3c2410-i2c.yaml     |  2 +-
>  .../interconnect/qcom,msm8998-bwmon.yaml      |  2 +-
>  .../interconnect/samsung,exynos-bus.yaml      | 14 ++++++-------
>  .../bindings/leds/qcom,pm8058-led.yaml        |  4 ++--
>  .../bindings/leds/skyworks,aat1290.yaml       |  6 +++---
>  .../bindings/media/cec/cec-gpio.yaml          |  2 +-
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |  2 +-
>  .../bindings/phy/samsung,mipi-video-phy.yaml  |  4 ++--
>  .../bindings/phy/samsung,usb2-phy.yaml        |  2 +-
>  .../bindings/phy/samsung,usb3-drd-phy.yaml    |  2 +-
>  .../bindings/pinctrl/samsung,pinctrl.yaml     |  2 +-
>  .../bindings/power/renesas,rcar-sysc.yaml     |  2 +-
>  .../bindings/power/reset/restart-handler.yaml |  8 ++++----
>  .../bindings/regulator/maxim,max77802.yaml    |  4 ++--
>  .../bindings/regulator/richtek,rtq2208.yaml   |  2 +-
>  .../bindings/serial/qcom,msm-uartdm.yaml      |  2 +-
>  .../devicetree/bindings/slimbus/slimbus.yaml  |  4 ++--
>  .../bindings/soc/qcom/qcom,apr-services.yaml  |  2 +-
>  .../bindings/soc/qcom/qcom,rpmh-rsc.yaml      |  8 ++++----
>  .../bindings/soc/qcom/qcom,wcnss.yaml         |  2 +-
>  .../bindings/soc/renesas/renesas-soc.yaml     |  4 ++--
>  .../bindings/sound/qcom,q6asm-dais.yaml       |  2 +-
>  .../thermal/samsung,exynos-thermal.yaml       |  4 ++--
>  .../devicetree/bindings/usb/qcom,dwc3.yaml    | 12 +++++------
>  .../bindings/usb/qcom,snps-dwc3.yaml          | 12 +++++------
>  30 files changed, 73 insertions(+), 73 deletions(-)
> 

Applied, thanks!

