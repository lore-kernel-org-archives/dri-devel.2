Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA92CD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 11:13:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FF5010E215;
	Mon, 25 May 2026 11:13:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MwGjr4Ae";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1BC710E215
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 11:13:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83B9043EF2;
 Mon, 25 May 2026 11:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B321F000E9;
 Mon, 25 May 2026 11:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779707627;
 bh=NXobWrGdt7/K85JfkhbiE1Xx6KirCAh53EJ7f9blg18=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=MwGjr4Ae3OPcbzZnE8QRWERBbD6DYQu8iwXRrVD5GSs3vkDaTTz7KBGzwdO/LgoBC
 +i4+Ax7paoavAuTFOW6nKtToXREgoQUeWie3rTnB+xTpntqNuce0VO8t0gSGYT1XA4
 PFFV01ZTwMnbZw3rv8x32LDiJTQUyJ264oKnyTHgj95MOtbObrFdOYOZdb4Iptgz8R
 WjH716z9j8wUz+aFOGsESfBvdCxMZrFKA9bCQPNbfz0cI2MXvte3/7ZXLhBj8Mg/UB
 k6gtNJoOkMqcv6Kdx3xYmikEnwVTEO/fho/Ja1wPW3HCOCUsmXJSc/38hoQ3ZOwejS
 uKXdidvqYPhzA==
Date: Mon, 25 May 2026 06:13:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: airlied@gmail.com, tzimmermann@suse.de, 
 Conor Dooley <conor.dooley@microchip.com>, rfoss@kernel.org, 
 cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, 
 heiko@sntech.de, dianders@chromium.org, sebastian.reichel@collabora.com, 
 simona@ffwll.ch, dmitry.baryshkov@oss.qualcomm.com, jonas@kwiboo.se, 
 Laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org, 
 maarten.lankhorst@linux.intel.com, m.szyprowski@samsung.com, 
 linux-rockchip@lists.infradead.org, andrzej.hajda@intel.com, 
 mripard@kernel.org, devicetree@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, nicolas.frattaroli@collabora.com, 
 hjc@rock-chips.com, andy.yan@rock-chips.com, linux-kernel@vger.kernel.org, 
 jernej.skrabec@gmail.com, krzk+dt@kernel.org
To: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260525082033.117569-3-damon.ding@rock-chips.com>
References: <20260525082033.117569-1-damon.ding@rock-chips.com>
 <20260525082033.117569-3-damon.ding@rock-chips.com>
Message-Id: <177970762578.3598344.16093942078468322022.robh@kernel.org>
Subject: Re: [PATCH v7 02/10] dt-bindings: display: rockchip: analogix-dp:
 Add per-clock descriptions
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


On Mon, 25 May 2026 16:20:25 +0800, Damon Ding wrote:
> Supplement dedicated description for each clock in the clocks
> property, clarifying the function of each clock input for the
> Analogix DP controller binding.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ---
> 
> Changes in v4:
> - Modify the commit msg.
> 
> Changes in v5:
> - Add Acked-by tag.
> ---
>  .../bindings/display/rockchip/rockchip,analogix-dp.yaml      | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml:33:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260525082033.117569-3-damon.ding@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

