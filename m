Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D30FCD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 11:13:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E4510E254;
	Mon, 25 May 2026 11:13:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DOzzvhQS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 608C510E253
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 11:13:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EDCC43B7E;
 Mon, 25 May 2026 11:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB331F00A3A;
 Mon, 25 May 2026 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779707628;
 bh=gzBDFr43Boq9Lj7lrwvex2le7up+8Wg9eGEwYQ+PjtU=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=DOzzvhQSiS34iWE7nXECeeQpcxWWsGg/C9aX/BghWrz+rvSMthodByxXcIe2gTPn1
 frRj9aAbz9cFPG+jTgToU6avpbHx5CJrJf2YC6R4DMwn28O+lXO3eAucd2tyFiPTae
 zMAQZxXfUzM1gt4rvwfBKhgk5zcbHC9vxFX/eL3Kx0MSplvx+mOvzndibbwCnWYr8m
 81deYGQtF89WAPPHMTAzCz2VrFYfom70TOUbauHvXMQR4Kjq2uXrt4Zid/Cat4knP/
 /NTqdujID3PpecLSePgSx/DyFTN66aS601brDxoDcIYE0JaGgrv8e7wU0rC3WeEBAh
 Bnix/jWsap93w==
Date: Mon, 25 May 2026 06:13:47 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: mripard@kernel.org, luca.ceresoli@bootlin.com, tzimmermann@suse.de, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 krzk+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com, conor+dt@kernel.org, 
 cristian.ciocaltea@collabora.com, Laurent.pinchart@ideasonboard.com, 
 rfoss@kernel.org, sebastian.reichel@collabora.com, 
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 andy.yan@rock-chips.com, andrzej.hajda@intel.com, jernej.skrabec@gmail.com, 
 simona@ffwll.ch, devicetree@vger.kernel.org, 
 nicolas.frattaroli@collabora.com, m.szyprowski@samsung.com, 
 Conor Dooley <conor.dooley@microchip.com>, hjc@rock-chips.com, 
 airlied@gmail.com, maarten.lankhorst@linux.intel.com, jonas@kwiboo.se, 
 dianders@chromium.org, heiko@sntech.de, neil.armstrong@linaro.org
To: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260525082033.117569-7-damon.ding@rock-chips.com>
References: <20260525082033.117569-1-damon.ding@rock-chips.com>
 <20260525082033.117569-7-damon.ding@rock-chips.com>
Message-Id: <177970762670.3598384.1698792096821270137.robh@kernel.org>
Subject: Re: [PATCH v7 06/10] dt-bindings: display: rockchip: analogix-dp:
 Add support for RK3576
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


On Mon, 25 May 2026 16:20:29 +0800, Damon Ding wrote:
> RK3576 integrates an eDP TX controller compatible with the existing
> RK3588 hardware design, reuse the same binding configuration directly.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - Split out a separate patch to add the "hclk" clock reference.
> 
> Chanegs in v4:
> - Modify the commit msg.
> 
> Changes in v5:
> - Add Acked-by tag.
> ---
>  .../bindings/display/rockchip/rockchip,analogix-dp.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml:34:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260525082033.117569-7-damon.ding@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

