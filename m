Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B487C9831E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A4D10E8FE;
	Fri, 25 Sep 2026 01:46:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZT/KAD6T";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3CF10E8FE
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 01:46:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 62BAD6022F;
 Fri, 25 Sep 2026 01:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D961F1F000FF;
 Fri, 25 Sep 2026 01:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790300805;
 bh=Dv7ldBQs2vS6hx4A+y25eTUYn6GTJkY1rmTTCx3PB2k=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=ZT/KAD6TZi6hgh6jDeeCACURr/l6mz8Unq9JYRBN+5oI8t4AfthXvQmIK1XCaJ7rs
 5BeX16QhG7mKinbhyt4f3Jec8pefKzSYkoRPTNav22HsXKoBqUymrkrL48bR8yC/fN
 dzDfDjP8ubFJL0V/NGwP1s76ViYQvKuFCVsw09XkHCXCcb2VUnKjEhtpriAp1pHy3/
 ZhK1Y1GPt2eXFxYgWpcmWRq1Xsq97Kjf9riXjV0fjseTsforFyzCdYBiuyYULnFisi
 hspK1Ug9TttGVOshz90XVCVCNW5WDIgQ7wHhtFpk5LWl+2velpEXFDFCUM2HnBV5js
 gEAnG0fHHk6mQ==
Date: Thu, 24 Sep 2026 20:46:43 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org, 
 conor+dt@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
 simona@ffwll.ch, neil.armstrong@linaro.org, mripard@kernel.org, 
 airlied@gmail.com, linux-kernel@vger.kernel.org, andersson@kernel.org, 
 devicetree@vger.kernel.org, krzk+dt@kernel.org
To: Adam Azuddin <azuddinadam@gmail.com>
In-Reply-To: <20260924145400.1385815-2-azuddinadam@gmail.com>
References: <20260924145400.1385815-1-azuddinadam@gmail.com>
 <20260924145400.1385815-2-azuddinadam@gmail.com>
Message-Id: <179030076558.2825461.17126015976122357972.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
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


On Thu, 24 Sep 2026 22:53:55 +0800, Adam Azuddin wrote:
> The RA8875 is an SPI-connected TFT display controller by RAiO
> Technology Inc. It supports display resolutions of up to 800x480.
> 
> Assisted-by: LLM
> Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
> ---
>  .../bindings/display/panel/raio,ra8875.yaml   | 78 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Lexical error: Documentation/devicetree/bindings/display/panel/raio,ra8875.example.dts:27.41-56 Unexpected 'GPIO_ACTIVE_LOW'
FATAL ERROR: Syntax error parsing input tree
make[2]: *** [scripts/Makefile.dtbs:140: Documentation/devicetree/bindings/display/panel/raio,ra8875.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/linux-dt-review/Makefile:1714: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260924145400.1385815-2-azuddinadam@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

