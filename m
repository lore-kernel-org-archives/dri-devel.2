Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB5606A333
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f/4cLrJ4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1900E10E731;
	Wed, 28 Oct 2026 23:47:19 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A665310E709;
 Wed, 28 Oct 2026 23:47:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D1A443E76;
 Wed, 28 Oct 2026 23:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF611F01825;
 Wed, 28 Oct 2026 23:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793231232;
 bh=neOivWsfnHbQR3N6AKh/3PoW3tIDMGi3k5qezfAAwY4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=f/4cLrJ4TGztgvmr14VBy6t7mBV8AM+uDlLfYVyShzm7APQvQBIiI0EDLgRGe0v7z
 LrPP1CYrALPm5Q04g1ErXIwYEqxpncy7n/vcasP5VS7fxapXxWQMRvQ3eLtXYsxC4u
 pO80RH6CgwyVic6xTA3E8YyB/WqO22L05DI08uL25eIqchvragaWR3rowAwilUDAAt
 Xh6oVb4uczfsq1lW3toZ9+v63X4qnWgC+a2EdGz7QxrKclbDs6hRlAucgG9mlmv1zz
 0pRXR0bqvqejkSM04r2n2wZ9K5nHoWUM+gUptsMAuOcN5EfgGaQV+XNpzRAcoIe2zH
 rDwATDPNl5e/Q==
Date: Wed, 28 Oct 2026 23:46:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet
 <jbrunet+clk@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Frank Li <Frank.Li@nxp.com>, Vinod Koul
 <vkoul@kernel.org>, Yinbo Zhu <zhuyinbo@loongson.cn>, Linus Walleij
 <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Tiffany Lin
 <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
 Yunfei Dong <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5?=
 =?UTF-8?B?xYRza2k=?= <kwilczynski@kernel.org>, Manivannan Sadhasivam
 <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Matthias Brugger
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Eric Anholt <eric@anholt.net>, Kuogee Hsieh
 <quic_khsieh@quicinc.com>, Peng Fan <peng.fan@nxp.com>, Aakarsh Jain
 <aakarsh.jain@samsung.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, freedreno@lists.freedesktop.org,
 imx@lists.linux.dev, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: Fix property name typos in if/then schemas
Message-ID: <20261028234652.0d075035@jic23-hlaptop>
In-Reply-To: <20261028120216.2657397-1-robh@kernel.org>
References: <20261028120216.2657397-1-robh@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 07:02:12 -0500
"Rob Herring (Arm)" <robh@kernel.org> wrote:

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
>  .../bindings/iio/adc/amlogic,meson-saradc.yaml       |  2 +-

For IIO

Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

>  .../bindings/media/mediatek,vcodec-encoder.yaml      | 12 ++++--------
>  .../devicetree/bindings/media/samsung,s5p-mfc.yaml   |  2 +-
>  .../devicetree/bindings/pci/mediatek-pcie.yaml       | 12 ++++++------
>  10 files changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> index 88b7672123a0..ed347096df46 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,kpss-gcc.yaml
> @@ -62,7 +62,7 @@ then:
>      - '#clock-cells'
>  else:
>    properties:
> -    clock: false
> +    clocks: false
>      clock-names: false
>      '#clock-cells': false
>  
> diff --git a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> index c1cefd547391..fd4d598f6ff8 100644
> --- a/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/brcm,bcm2711-hdmi.yaml
> @@ -145,7 +145,7 @@ allOf:
>              - description: CEC stuck at low interrupt
>              - description: Hotplug connected interrupt
>              - description: Hotplug removed interrupt
> -        interrupts-names:
> +        interrupt-names:
>            items:
>              - const: cec-tx
>              - const: cec-rx
> diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> index 094a6383bb77..f72d1b354007 100644
> --- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
> @@ -304,7 +304,7 @@ allOf:
>          clocks:
>            minItems: 6
>            maxItems: 6
> -        clocks-names:
> +        clock-names:
>            minItems: 6
>            maxItems: 6
>  
> diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> index dfec6c3480f3..02d27ccad024 100644
> --- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
> @@ -113,7 +113,7 @@ allOf:
>              - const: core
>              - const: master_iface
>              - const: slave_iface
> -        core-vcc-supplies: false
> +        core-vcc-supply: false
>  
>    - if:
>        properties:
> @@ -136,7 +136,7 @@ allOf:
>              - const: core
>              - const: alt_iface
>              - const: extp
> -        hdmi-mux-supplies: false
> +        hdmi-mux-supply: false
>  
>    - if:
>        properties:
> diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> index f609038e35ae..0260d177c7d0 100644
> --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> @@ -172,7 +172,7 @@ allOf:
>              const: fsl,imx7ulp-edma
>      then:
>        properties:
> -        clock:
> +        clocks:
>            minItems: 2
>            maxItems: 2
>          clock-names:
> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> index 69852444df23..07c8b233c6bd 100644
> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
> @@ -80,7 +80,7 @@ allOf:
>          - resets
>      else:
>        properties:
> -        "#interrupts-cells": false
> +        "#interrupt-cells": false
>          interrupt-controller: false
>          resets: false
>  
> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> index 70ab4e140e71..535213ba0c5e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
> @@ -92,7 +92,7 @@ allOf:
>      else:
>        properties:
>          nvmem-cells: false
> -        mvmem-cel-names: false
> +        nvmem-cell-names: false
>          clocks:
>            minItems: 4
>          clock-names:
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index 4505e66876a2..52f471a070d5 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -110,19 +110,15 @@ allOf:
>  
>      then:
>        properties:
> -        clock:
> -          items:
> -            minItems: 1
> -            maxItems: 1
> +        clocks:
> +          maxItems: 1
>          clock-names:
>            items:
>              - const: venc_lt_sel
>      else:
>        properties:
> -        clock:
> -          items:
> -            minItems: 1
> -            maxItems: 1
> +        clocks:
> +          maxItems: 1
>          clock-names:
>            items:
>              - const: venc_sel
> diff --git a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> index b46cc780703c..4488d5ca9b9c 100644
> --- a/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> +++ b/Documentation/devicetree/bindings/media/samsung,s5p-mfc.yaml
> @@ -174,7 +174,7 @@ allOf:
>              - const: mfc
>          iommus:
>            maxItems: 2
> -        iommus-names: false
> +        iommu-names: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> index c009a7a52bc6..7c40361f95ec 100644
> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie.yaml
> @@ -127,7 +127,7 @@ allOf:
>          phy-names:
>            const: pcie-phy1
>  
> -        power-domain: false
> +        power-domains: false
>  
>        required:
>          - resets
> @@ -150,7 +150,7 @@ allOf:
>            minItems: 2
>            maxItems: 2
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -171,7 +171,7 @@ allOf:
>          clocks:
>            minItems: 6
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -193,7 +193,7 @@ allOf:
>          clocks:
>            minItems: 6
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -215,7 +215,7 @@ allOf:
>          clock-names:
>            maxItems: 1
>  
> -        reset: false
> +        resets: false
>  
>          reset-names: false
>  
> @@ -223,7 +223,7 @@ allOf:
>  
>          phy-names: false
>  
> -        power-domain: false
> +        power-domains: false
>  
>          mediatek,pbus-csr: false
>  

