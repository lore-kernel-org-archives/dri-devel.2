Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98652C55184
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 00:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCAB010EC30;
	Wed,  5 Aug 2026 00:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UzfErMoK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B3F10E112
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 00:36:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9BC34600B1;
 Wed,  5 Aug 2026 00:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 324B51F000E9;
 Wed,  5 Aug 2026 00:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785890175;
 bh=7eQ5n/iGpSnvTqj4pTR3mrzSee7O5vh1QLpKl6Bg9h0=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=UzfErMoKx40e2blQeHBXSCWHrkWf3gT/4gPA6Ln90TDRy5NKPRSQqcxXUzzw04hr1
 /myqb631zNn+dnijLZJGJP7BXHOJRqfLk0BCpDe+D+MlAMgBLbMpWg60+7zU+IXZjD
 m7dumXj0+13Nwgae6uSZnM9GBZyMv7oR4I7MgXoQZXs/9BcYQE2HFIMIRXztOMk14n
 uBt7WqVLibUdRfcy+HYtqV+4qTdryt6kXeRL0NtcMz/Miq0eRRwAgNG4xB0DmBDpAQ
 oIfxDBLy/5rBqs6/Khh1sV2dcLO4uG5P8iBrVoW7iMzXLP39yjo2aEuZNHroM/xuO6
 kWF3YyRd/ibyA==
Date: Tue, 04 Aug 2026 19:36:14 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-fbdev@vger.kernel.org, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 dri-devel@lists.freedesktop.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Helge Deller <deller@gmx.de>
To: Max Pedraza <maximpedraza@gmail.com>
In-Reply-To: <20260804225617.264861-2-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260804225617.264861-2-maximpedraza@gmail.com>
Message-Id: <178589017450.2494424.9339926059212534643.robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: display: add a device tree
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


On Wed, 05 Aug 2026 00:56:12 +0200, Max Pedraza wrote:
> Embedded products frequently need a product specific boot logo. Today the
> only way to get one is to replace one of the logo_*_clut224.ppm files in
> the kernel source tree, which bakes the image into the kernel image: a
> change of branding, or a second product sharing the same board support,
> requires a separate kernel build.
> 
> Add a binding for a "linux,boot-logo-clut224" node, which carries the logo
> in the same paletted format the built-in CLUT224 logos already use, plus a
> few optional properties describing where on the screen it is drawn.
> 
> The palette size is derived from the length of the "clut" property rather
> than spelled out separately, and "data" holds plain palette indices; the
> 32 entry offset the frame buffer layer reserves for the console is an
> implementation detail and is applied by the kernel, not by the binding.
> 
> Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
> ---
>  .../display/linux,boot-logo-clut224.yaml      | 131 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/linux,boot-logo-clut224.example.dtb: /: 'compatible' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
Documentation/devicetree/bindings/display/linux,boot-logo-clut224.example.dtb: /: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/root-node.yaml
Documentation/devicetree/bindings/display/linux,boot-logo-clut224.example.dtb: chosen: 'logo' does not match any of the regexes: '^framebuffer', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/chosen.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260804225617.264861-2-maximpedraza@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

