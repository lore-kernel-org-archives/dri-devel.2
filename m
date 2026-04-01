Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C2D35160
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7727E10EAB7;
	Wed,  1 Apr 2026 08:52:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hIgzQyC3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28A9210EA53
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:52:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 150036012B;
 Wed,  1 Apr 2026 08:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7BCC2BCB0;
 Wed,  1 Apr 2026 08:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775033523;
 bh=PJKB1yFEIsW0Wsg2SCBlQHgXyOwUjo42GLl8UW6TOXo=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=hIgzQyC30yKnEaCEdhL1iEiB3/IS5OtP4cR3lgJUJwdI7+Qd+8SDvI+FlKATEjM4Y
 oAQ7eOlRg3WhmlVYAKWV2vdOTTwzpnuI/FRGz3WhqB7qPKHe9faBYCaYxvn1Q10npd
 JrEL9KeiR8nJZ5Ubs1bXKjdsLVG8cpp7zdSgw6TQfSlQT2ropcTY59pajWhA0CkxE6
 udemyB1Y50kTnTSYGqbBeAV3OuZaD3N0qu1SlRmQoYg+Zlsnkwt9h4myXM50I0bVWS
 L1bhPHiR3qRPmxW+UXwSN1sPuMwH7LVGOGe1cFW6v5qm22bCiEcBSzjb54SXmS31XL
 LClYXeaSVIRbQ==
Date: Wed, 01 Apr 2026 03:52:02 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
 Jagan Teki <jagan@edgeble.ai>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Ondrej Jirman <megi@xff.cz>, Bartosz Golaszewski <brgl@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-18-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
 <20260401-waveshare-dsi-touch-v1-18-5e9119b5a014@oss.qualcomm.com>
Message-Id: <177503352038.3337366.3471011938955097586.robh@kernel.org>
Subject: Re: [PATCH 18/19] dt-bindings: gpio: describe Waveshare GPIO
 controller
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


On Wed, 01 Apr 2026 10:26:37 +0300, Dmitry Baryshkov wrote:
> The Waveshare DSI TOUCH family of panels has separate on-board GPIO
> controller, which controls power supplies to the panel and the touch
> screen and provides reset pins for both the panel and the touchscreen.
> Also it provides a simple PWM controller for panel backlight.
> 
> Add bindings for these GPIO controllers. As overall integration might be
> not very obvious (and it differs significantly from the bindings used by
> the original drivers), provide complete example with the on-board
> regulators and the DSI panel.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.example.dtb: dsi_panel@0 (waveshare,8.0-dsi-touch-a): 'iovcc-supply', 'reset-gpio' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/panel/jadard,jd9365da-h3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.example.dtb: dsi_panel@0 (waveshare,8.0-dsi-touch-a): 'vccio-supply' is a required property
	from schema $id: http://devicetree.org/schemas/display/panel/jadard,jd9365da-h3.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.example.dtb: dsi_panel@0 (waveshare,8.0-dsi-touch-a): 'reset-gpios' is a required property
	from schema $id: http://devicetree.org/schemas/display/panel/jadard,jd9365da-h3.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260401-waveshare-dsi-touch-v1-18-5e9119b5a014@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

