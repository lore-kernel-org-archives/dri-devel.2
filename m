Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB2DCD37B2
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 21:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FBC10E00A;
	Sat,  9 May 2026 21:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lhRNa9U6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6FDC10E00A
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 21:25:32 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 29BFF43A64;
 Sat,  9 May 2026 21:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C787DC2BCB2;
 Sat,  9 May 2026 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778361932;
 bh=kqHOrbJyhA/27njgwMH67BMSnrFaEGEAU6ESTHsUOMY=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
 b=lhRNa9U6a6Yx6f+isl46Vmo87cARQlOGnSA39+RCjZwb7G7vS9Jn993kdHdc4C+dI
 CcuXkUOfxsvWT9dghrcgwFTRziEqVSl7qe9l61EG98WgsSA7qe83n7eNHsUfKaNtq2
 qTLnZobTNrv0Q6BJvEKc0RvR9OxD/A2AzDSda1Ey5v7KPDSVvq75WxsjKgU6+nWc/g
 fk1uREqrGrqgKHOhTytbV/yLzkIHWPgpQbDSCS+axh07yu8UqLmD802yxHMlHzl5uO
 MJvEh+390TGDEUn4OvJ/4Ti8noknu+/c1dsw4UYk+2aixCt4Dc5MlauXS2wJgw5mh+
 crXMeft5QpJ9g==
Date: Sat, 09 May 2026 16:25:29 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
To: Aaron Kling <webgeek1234@gmail.com>
In-Reply-To: <20260509-icna35xx-v1-1-688d3d4e10f9@gmail.com>
References: <20260509-icna35xx-v1-0-688d3d4e10f9@gmail.com>
 <20260509-icna35xx-v1-1-688d3d4e10f9@gmail.com>
Message-Id: <177836192983.1140170.1302751195131262657.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: Add Chipone ICNA 35xx
 OLED driver bindings
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


On Sat, 09 May 2026 15:18:57 -0500, Aaron Kling wrote:
> The Chipone ICNA35xx series of DDICs are high refresh, low power
> MIPI-DSI drivers for OLED panels. The icna3512 is used by the Ayn Odin 2
> Portal and the icna3520 is used by the Ayn Thor top panel and the Ayn
> Odin 3.
> 
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  .../bindings/display/panel/chipone,icna35xx.yaml   | 77 ++++++++++++++++++++++
>  1 file changed, 77 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/panel/chipone,icna35xx.yaml:28:13: [warning] wrong indentation: expected 14 but found 12 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260509-icna35xx-v1-1-688d3d4e10f9@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

