Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE4C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E6A10E15C;
	Thu, 24 Sep 2026 11:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="g0MhdNKx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51B7710E15C
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:49:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BCA6601DE;
 Thu, 24 Sep 2026 11:49:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1A1F000FF;
 Thu, 24 Sep 2026 11:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790250554;
 bh=rku4KQA7zizHse97lsB6C+F4NuVJGArqTXbgqqfInPc=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=g0MhdNKxQe8UYpGX4/RnEi6/0aLObAe5EkrCEiBvgjgHp6H+oAVv+Zaf7WgA+IDNv
 yEz5kwGRWPnfapxq8h6fqm3rsffc92kdVfAeJVrYI+j7Y3KAB8vZyutd4vSB9fscl7
 0ZDbc+g95lEJ8cId5H6t5LeMRYxMKmWAaztcM3htNcG9Y1Rz7h51kBirTc9gfRaiiq
 yLlDb1njHf4MYIPMcbU5a/XzKRAIO/G7FpT7D1v4i7RIMAJlrgJumHKOlDHOasSASE
 iI9S/t4hRFwQUElAO3DWbd8yjMZcgbBGOZX2PjY4fKJZWQip8VRTLpXKbVru0kOICI
 NZs4HwRqPqi0A==
Date: Thu, 24 Sep 2026 06:49:12 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 linux-kernel@vger.kernel.org, Helge Deller <deller@gmx.de>, 
 devicetree@vger.kernel.org
To: Max Pedraza <maximpedraza@gmail.com>
In-Reply-To: <20260923201035.51007-3-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
 <20260923201035.51007-3-maximpedraza@gmail.com>
Message-Id: <179025038211.3068273.9854294306608483193.robh@kernel.org>
Subject: Re: [PATCH v3 2/7] dt-bindings: display: add a device tree
 supplied boot logo
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


On Wed, 23 Sep 2026 22:10:30 +0200, Max Pedraza wrote:
> Embedded products frequently need a product specific boot logo. Today that
> means pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which
> bakes it into the kernel image: a change of branding, or a second product
> sharing the same board support package, requires a separate kernel build,
> and requalifying that kernel for what is a cosmetic change.
> 
> Add a binding for a "boot-logo-clut224" node, which carries the logo
> in the same paletted format the built-in CLUT224 logos already use, plus a
> few optional properties describing where on the screen it is drawn.
> 
> The node lives under /chosen because a logo is configuration handed over by
> firmware rather than a description of the hardware. Open Firmware, which
> the device tree descends from, carried a boot logo in the same spirit as
> the oem-logo variable under /options, and simple-framebuffer nodes live
> under /chosen today for the same reason.
> 
> The palette size is derived from the length of the "clut" property rather
> than spelled out separately, and "data" holds plain palette indices; the
> 32 entry offset the frame buffer layer reserves for the console is an
> implementation detail and is applied by the kernel, not by the binding.
> 
> "logo-position" takes -1 on an axis to mean centre on that axis rather than
> carrying a separate boolean for it. A boolean can only centre both axes or
> neither, and next to explicit coordinates it would have to override them
> silently when a device tree gave both.
> 
> A rotation turns the logo, not the screen. "logo-position" and
> "logo-offset" are screen pixels whatever "logo-rotation" says, and a
> quarter turn only changes how much room the logo takes up. Placing the
> logo in a frame that turns with it would make the same pair of
> coordinates mean different places on the same panel, decided by a
> property that is meant to describe the image.
> 
> Every coordinate is bounded. The kernel clamps them anyway, since it cannot
> trust a device tree, but a value that cannot possibly be meant is worth
> catching in dtbs_check rather than on the panel.
> 
> Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
> ---
>  .../bindings/display/boot-logo-clut224.yaml   | 135 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 136 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/boot-logo-clut224.example.dtb: chosen: 'logo' does not match any of the regexes: '^framebuffer', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/chosen.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260923201035.51007-3-maximpedraza@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

