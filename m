Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA6EF99C63
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 00:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2ECA10EAE5;
	Sat, 18 Apr 2026 00:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YJZ5fNIR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3C810EAE5
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 00:39:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6840F60052;
 Sat, 18 Apr 2026 00:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADC6C19425;
 Sat, 18 Apr 2026 00:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776472770;
 bh=b372NDYq44UfFAC/z9eXlIkHcS6zAx5W1MVX5qnMiz0=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=YJZ5fNIRUVbFQ+U1e9W8Ny09u7NrW0y/Rx0HQPIXjW5RXz7a7IQCbWE6Jcn08VwZV
 elrrU+4oZwBCxBff51WVi8SYHd23IY2mSAGkZIVJrqsogMbX96v6aQ4gzTt2sTqsFn
 eOHvvRRHL6wpYtpu63esRqoxDGX8m+DEn17LtcdDTRHNpwSVdRwZRIkx3JNpqS9dP7
 00ifdYHQTGyTA3NDw2vrk6JP6DGU7rPBTd1z53F1D4ChBho4w7k4uHrgE44tS7RATw
 DsWRAEjyU4HfEJrFP/+iSFvn3i4zVjsoPyIEddlKOFrLBnKs/MWlTOhCBgz12kNUCO
 9eYkmbBPFx0DQ==
Date: Fri, 17 Apr 2026 19:39:27 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org, Jessica Zhang <jesszhan0024@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Simona Vetter <simona@ffwll.ch>,
 linux-gpio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maxime Ripard <mripard@kernel.org>, Jagan Teki <jagan@edgeble.ai>, 
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
 Jie Gan <jie.gan@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Ondrej Jirman <megi@xff.cz>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Liam Girdwood <lgirdwood@gmail.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260418-waveshare-dsi-touch-v4-3-b249f3e702bd@oss.qualcomm.com>
References: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
 <20260418-waveshare-dsi-touch-v4-3-b249f3e702bd@oss.qualcomm.com>
Message-Id: <177647276773.3416847.5121391765535033685.robh@kernel.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: gpio: describe Waveshare GPIO
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


On Sat, 18 Apr 2026 02:16:22 +0300, Dmitry Baryshkov wrote:
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
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 100 +++++++++++++++++++++
>  1 file changed, 100 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.example.dtb: panel@0 (waveshare,8.0-dsi-touch-a): compatible:0: 'waveshare,8.0-dsi-touch-a' is not one of ['anbernic,rg-ds-display-bottom', 'anbernic,rg-ds-display-top', 'chongzhou,cz101b4001', 'kingdisplay,kd101ne3-40ti', 'melfas,lmfbx101117480', 'radxa,display-10hd-ad001', 'radxa,display-8hd-ad002', 'taiguanck,xti05101-01a']
	from schema $id: http://devicetree.org/schemas/display/panel/jadard,jd9365da-h3.yaml
Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.example.dtb: /example-0/dsi/panel@0: failed to match any schema with compatible: ['waveshare,8.0-dsi-touch-a', 'jadard,jd9365da-h3']

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260418-waveshare-dsi-touch-v4-3-b249f3e702bd@oss.qualcomm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

