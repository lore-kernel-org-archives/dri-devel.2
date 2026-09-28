Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690E1CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 20:43:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA53810E9AF;
	Mon, 28 Sep 2026 20:43:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V9yTpaR3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2D010E99D
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:43:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6B38A4390B;
 Mon, 28 Sep 2026 20:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155151F000FF;
 Mon, 28 Sep 2026 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790628192;
 bh=ySK103NdmXThiEDTZ/VGv2U3ZqCbXnaKRgtixyhWCVU=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=V9yTpaR355fDUEtRGbAbCHYCkgs8W6ffIstAbBudBRSSbpPmO9RUjPPGvxgiGmnOr
 xd8fxTqEao2zof0FOaNDB2Y2pc+TQ6ETvq6GgCch1vr3C7D8M4lXuUaM4TAeSDSH5p
 hFtVqjNIkhEnZA93FIUdeyc7ipHBNEPZlemnik/aS4jlaBbHUDhzuKMwpi2GsUV14J
 QVXdxj+pEGE+HjfLhLbzNAtDkUVFBdySk7Fq+bTvZvnWjokebUYYDcD+3Q6R44ldrh
 DbIjWYKRfM4aOiYKVwJwThPh6fL1+zAenlTDvgj7Qi6UHgJ9koDsghVdlyg1zykoey
 Ha5HJghAyVQMw==
Date: Mon, 28 Sep 2026 15:43:10 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-rpi-kernel@lists.infradead.org, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Jessica Zhang <jesszhan0024@gmail.com>, 
 Albert Esteve <aesteve@redhat.com>, linux-arm-kernel@lists.infradead.org, 
 Jonas Karlman <jonas@kwiboo.se>, Bill Wendling <morbo@google.com>, 
 David Airlie <airlied@gmail.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 devicetree@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, llvm@lists.linux.dev, 
 Justin Stitt <justinstitt@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
 <20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org>
Message-Id: <179062735517.517724.11732368847046080988.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: display: Add panel-mipi-dsi-bpf
 generic panel binding
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


On Mon, 28 Sep 2026 18:22:01 +0200, Maxime Ripard wrote:
> Most MIPI-DSI panel drivers follow an identical pattern: acquire
> regulators and GPIOs, perform a reset pulse with specific timing,
> send a vendor-supplied sequence of DSI commands, then enable the
> display. The only truly panel-specific part is the init sequence
> and power-on/off timing.
> 
> The panel-mipi-dsi-bpf driver replaces per-panel kernel modules
> with a single generic driver whose panel-specific behavior is
> provided by BPF programs loaded from userspace at runtime,
> following the HID-BPF model. This enables new panel support
> without kernel patches.
> 
> Panel DT nodes use a two-entry compatible with the panel-specific
> string first and "panel-mipi-dsi-bpf" as fallback. The generic
> driver matches on the fallback, while the first compatible is used
> to identify which BPF program to load.
> 
> Six normalized optional regulator supplies cover ~95% of existing
> MIPI-DSI panels: vcc (IC core), iovcc (I/O interface), avdd/avee
> (positive/negative analog), and elvdd/elvss (OLED EL driver).
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  .../bindings/display/panel/panel-mipi-dsi-bpf.yaml | 184 +++++++++++++++++++++
>  1 file changed, 184 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.example.dtb: panel@0 (elida,kd35t133): 'dsi-lanes', 'height-mm', 'mode-lpm', 'mode-video', 'mode-video-burst', 'panel-timing', 'vcc-supply', 'width-mm' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/panel/elida,kd35t133.yaml
Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.example.dtb: panel@0 (elida,kd35t133): compatible: ['elida,kd35t133', 'panel-mipi-dsi-bpf'] is too long
	from schema $id: http://devicetree.org/schemas/display/panel/elida,kd35t133.yaml
Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.example.dtb: panel@0 (elida,kd35t133): 'vdd-supply' is a required property
	from schema $id: http://devicetree.org/schemas/display/panel/elida,kd35t133.yaml
Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.example.dtb: panel@0 (boe,bf060y8m-aj0): 'dsi-lanes', 'iovcc-supply', 'mode-video', 'panel-timing' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/panel/boe,bf060y8m-aj0.yaml
Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.example.dtb: panel@0 (boe,bf060y8m-aj0): compatible: ['boe,bf060y8m-aj0', 'panel-mipi-dsi-bpf'] is too long
	from schema $id: http://devicetree.org/schemas/display/panel/boe,bf060y8m-aj0.yaml
Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.example.dtb: panel@0 (boe,bf060y8m-aj0): 'vci-supply' is a required property
	from schema $id: http://devicetree.org/schemas/display/panel/boe,bf060y8m-aj0.yaml
Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bpf.example.dtb: panel@0 (boe,bf060y8m-aj0): 'vddio-supply' is a required property
	from schema $id: http://devicetree.org/schemas/display/panel/boe,bf060y8m-aj0.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260928-drm-mipi-dsi-panel-ebpf-v1-1-5244926aace4@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

