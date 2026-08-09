Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0DAC5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 20:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F007710E034;
	Sun,  9 Aug 2026 20:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W2+hdrxF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E07CF10E034
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 20:57:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40DF441690;
 Sun,  9 Aug 2026 20:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D361F000E9;
 Sun,  9 Aug 2026 20:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786309025;
 bh=pLkF0NLj/A2HQEEfAGqywzigLmQcK/vmjIC7mVIkzLU=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=W2+hdrxFZpt/F+NpzQmltXR2BqtphG4Dncu82E2b1GGtO+lodA9D7+NQFryuMccr8
 yXZYeNKBYWSWRRtzR1HqC4aRekSzkdl5rULOuBS8qOjrZ+zVb0wmTyXRLWHBn7JPaf
 tzQ/+hUO4Wm2CkNWiz/bat58nFDm6SgZbEbc8OQ4mue0lmxRgpfuSDviDk7hNJHPPm
 Z0vUnB+st4s71/ZMT7AK9xR3grfqrZwZtyQKrr5V/Rf85kCtcVgRwcc3ERIPYpPLsp
 vZ3kzsjhRM+IFIhhJWjYHLT9mL3OsKISwz6mPX7/iLyQlSc8zhiJO+lZBtqm+R7MCG
 hEFgNjNBwavwA==
Date: Sun, 09 Aug 2026 15:57:04 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-kernel@vger.kernel.org, Haylen Chu <heylenay@4d2.org>, 
 devicetree@vger.kernel.org, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, 
 David Airlie <airlied@gmail.com>, Guodong Xu <docular.xu@gmail.com>, 
 linux-clk@vger.kernel.org, Yixun Lan <dlan@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org, 
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-phy@lists.infradead.org, Maxime Ripard <mripard@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Vinod Koul <vkoul@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, spacemit@lists.linux.dev, 
 Yao Zi <me@ziyao.cc>, Brian Masney <bmasney@redhat.com>, 
 dri-devel@lists.freedesktop.org, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>
To: Cody Kang <codykang.hk@gmail.com>
In-Reply-To: <20260809-k3-display-v2-4-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-4-327d7910bf71@gmail.com>
Message-Id: <178630902417.4734.745604981187853023.robh@kernel.org>
Subject: Re: [PATCH v2 04/17] dt-bindings: soc: spacemit: allow eDP/DP PHY
 PLL pixel clocks on K3 APMU
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


On Sun, 09 Aug 2026 21:14:13 +0800, Cody Kang wrote:
> The APMU's eDP pixel-clock muxes select the DP PHY PLLs as parents, so the
> K3 syscon takes two clock inputs the other variants do not have.
> 
> Gate them behind the K3 compatible instead of widening the shared clock
> list, so a non-K3 syscon cannot silently accept clocks it has no mux for.
> 
> Signed-off-by: Cody Kang <codykang.hk@gmail.com>
> 
> ---
> v2:
> - drop the redundant minItems: 4; four is already the minimum
>   (Rob Herring)
> ---
>  .../bindings/soc/spacemit/spacemit,k1-syscon.yaml   | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.example.dtb: display0: fsl,pcr: b'\xf0\xc8\x80\x80' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260809-k3-display-v2-4-327d7910bf71@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

