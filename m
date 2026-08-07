Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCF5C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4322010F531;
	Fri,  7 Aug 2026 15:48:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="alu2Y8UX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D2FA10F531
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:48:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F420A4321D;
 Fri,  7 Aug 2026 15:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BFE1F00A3A;
 Fri,  7 Aug 2026 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786117712;
 bh=H04/3ngqBE/+iJRmtpyMb1Ysksmf+cWa/9RDiP4M7Mk=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=alu2Y8UXGdBpSX+hvGcEkoA+ZSZqnRQa0CVlbP9IrD2TY/xpyU4gEEwFJ+eN1wBA9
 75HtxYfLaP/TUtV6g4oQztV6HYOy5f9+dOQTrzHGk5316YYDah7sr2m8NwrZ5uJz1w
 Fi84jtkHGP34sCvO3+ChvP0veVFIC0YAeBPlirmTIUT+JfBLwsVWBk8/lnQZo5zoWt
 KNeg6sjNU90F5TaDuCEpkSVYBkCG1I85ZXQhCdx3LDDBBN+WpLJLvdGynyJeEQ5Z9f
 M1s0LPPS2HmNRmCi9KHc0moleEVMN76k5N365Odm5AEIafx2mEL1/fb+xLZm8d+Smv
 YvyR7xobSX8wg==
Date: Fri, 07 Aug 2026 10:48:32 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Jori Koolstra <jkoolstra@xs4all.nl>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Brigham Campbell <me@brighamcampbell.com>, 
 linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
In-Reply-To: <cf9b02d618db4eca88e2d32b4bf779011fcd550d.1786110720.git.nico.antinori.7@gmail.com>
References: <cover.1786110720.git.nico.antinori.7@gmail.com>
 <cf9b02d618db4eca88e2d32b4bf779011fcd550d.1786110720.git.nico.antinori.7@gmail.com>
Message-Id: <178611771198.882916.15330377894023589629.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: display: add Chipwealth CH1115 OLED
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


On Fri, 07 Aug 2026 11:19:50 -0300, Nicolás Antinori wrote:
> Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.
> 
> Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
> ---
>  .../bindings/display/chipwealth,ch1115.yaml   | 73 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/chipwealth,ch1115.example.dtb: display@3c (chipwealth,ch1115): 'contrast', 'first-page' do not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/display/chipwealth,ch1115.yaml
Documentation/devicetree/bindings/display/chipwealth,ch1115.example.dtb: display@3c (chipwealth,ch1115): contrast: b'\x00\x00\x00\x7f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml
Documentation/devicetree/bindings/display/chipwealth,ch1115.example.dtb: display@3c (chipwealth,ch1115): first-page: b'\x00\x00\x00\x01' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/cf9b02d618db4eca88e2d32b4bf779011fcd550d.1786110720.git.nico.antinori.7@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

