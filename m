Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5551FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050F710E8E8;
	Mon, 27 Apr 2026 19:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qi0vwyy6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17F6910E8E8
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 19:02:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DA7A443C5A;
 Mon, 27 Apr 2026 19:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA9C19425;
 Mon, 27 Apr 2026 19:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777316563;
 bh=jTWwfj0zZG7bsq6Opv6LU53fDAa+a75QEi6tnfm6hmo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qi0vwyy6lKqMm8ChV2AS977CuHDGOgXUvJfAPLdcG8y1QT2M1YCJighptIannJWwv
 FdtNpxGVmzFYgMaHvkPxEktcfVxj06I117dTznfVsE+OZiOVBCuNN4G6u1DHdinXmc
 jEcIoM3v04iK9xagvoNGG5t4kYB5tXEr8i6jrKrkDiPJe8Lkt4zvHRevDEgl4KoZZE
 GVwN5W20w5vsmDGXKW11nQHG9zrtKfg5HiL7qZ4i3gnj5FtvGzbpzN86j17dBDroWS
 29gEIm4HVxVbx7OCHPqDP/YfGN9msTKjeiByeqWr6Au2omR2369F9PmzUXEBTBxC4H
 A9EsYBPLn/ejw==
Date: Mon, 27 Apr 2026 14:02:39 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Richard Acayan <mailingradian@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>, 
 Sam Ravnborg <sam@ravnborg.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Yifei Zhan <yifei@zhan.science>
Subject: Re: [PATCH v3 0/5] Support for the Pixel 3a XL with the Tianma panel
Message-ID: <ae-yXomgNWLd8IcE@baldur>
References: <20260310002606.16413-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310002606.16413-1-mailingradian@gmail.com>
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

On Mon, Mar 09, 2026 at 08:26:01PM -0400, Richard Acayan wrote:
> This expands Pixel 3a support to the Pixel 3a XL, starting with one of
> the panel variants. The Pixel 3a XL has two variants with panels from
> Samsung or from Tianma/Novatek.
> 
> This series depends on the IMX355 front camera devicetree patches
> (https://lore.kernel.org/r/20260217002738.133534-1-mailingradian@gmail.com).

Please resubmit the DeviceTree patches once this dependency has been
resolved.

Regards,
Bjorn

> 
> Changes since v2 (https://lore.kernel.org/r/20260217000854.131242-1-mailingradian@gmail.com):
> - add support for regulator (Dmitry's review retained) (3/5)
> - use common set page function (Dmitry's review retained) (3/5)
> - squash new labels into common dtsi patch (review tags dropped) (4/5)
> - specify framebuffer in terms of memory region (4/5)
> - only specify height in XL/non-XL specific devicetrees (4/5, 5/5)
> - remove status in display devices (4/5, 5/5)
> - preserve same touchscreen physical width in sargo (4/5)
> - move entry in Makefile to correct place (5/5)
> - omit copyright year in new file (4/5)
> - correct top-of-file comment about which panel is supported (5/5)
> - explain license identifier change from GPL-2.0 to GPL-2.0-only (4/5)
> - add review tags (1/5, 3/5, 5/5)
> 
> Changes since v1 (https://lore.kernel.org/r/20260210023300.15785-1-mailingradian@gmail.com):
> - use multi functions in disable callback (3/6)
> - add and reformat comments about XL differences (5/6)
> - mention the sdc panel (6/6)
> - explain google,bonito compatible (1/6)
> - remove TODO item in code (3/6)
> - add review and testing tags (2/6, 3/6, 5/6)
> 
> Richard Acayan (5):
>   dt-bindings: arm: qcom: document google,bonito-tianma board
>   dt-bindings: panel-simple-dsi: add nt37700f compatible
>   drm/panel: Add Novatek/Tianma NT37700F panel
>   arm64: dts: qcom: sdm670-google: add common device tree include
>   arm64: dts: qcom: add support for pixel 3a xl with the tianma panel
> 
>  .../devicetree/bindings/arm/qcom.yaml         |   6 +
>  .../display/panel/panel-simple-dsi.yaml       |   2 +
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../dts/qcom/sdm670-google-bonito-tianma.dts  |  32 +
>  ...le-sargo.dts => sdm670-google-common.dtsi} |  22 +-
>  .../boot/dts/qcom/sdm670-google-sargo.dts     | 709 +-----------------
>  drivers/gpu/drm/panel/Kconfig                 |   9 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  .../gpu/drm/panel/panel-novatek-nt37700f.c    | 299 ++++++++
>  9 files changed, 370 insertions(+), 711 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dts
>  copy arch/arm64/boot/dts/qcom/{sdm670-google-sargo.dts => sdm670-google-common.dtsi} (97%)
>  create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt37700f.c
> 
> -- 
> 2.53.0
> 
