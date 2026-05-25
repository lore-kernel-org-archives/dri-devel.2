Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3704CD5BD0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 11:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9EB10E0EF;
	Mon, 25 May 2026 11:43:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CqBPsuQV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FE210E2A0
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 11:43:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD5E843C36;
 Mon, 25 May 2026 11:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837751F000E9;
 Mon, 25 May 2026 11:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779709438;
 bh=OV8llzBqjiqPgHPyVfyHyKR+rTQay3cResWTmqgsBoU=;
 h=Date:From:Cc:To:In-Reply-To:References:Subject;
 b=CqBPsuQVdqmZNO4qG+nPYLi2uJ7iBJZ7t7JLzZJjZGabsvNGC1Vx64MBqJ30p278P
 Dt8VKhmS2wGvt5ZXtswAy1fAkrzcY/AAlqqK4QL49xXFLdjqNSjijQc6A4HLLkbVgt
 bDtcaPniiG0C40p9to1lxR6X3cGTNyCmgWrm8pdqCcMS6i+RjVg/9Ra7BRjyAr4FU7
 bYdsf6UKQUvxWzxrCkJchsQTfKRJ7eHXj+o68ePl/43aOPuYT7aS6lJjhMAyHqgm9Y
 PlnmVFMCO89sU83O19+vspcTKDm6x+d/GX+G0/CifqQxrgw2ncwfVA15a0M5fOqUb/
 1C02oIxjQp8ag==
Date: Mon, 25 May 2026 06:43:58 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: krzk+dt@kernel.org, m.szyprowski@samsung.com, 
 maarten.lankhorst@linux.intel.com, cristian.ciocaltea@collabora.com, 
 linux-arm-kernel@lists.infradead.org, mripard@kernel.org, 
 conor+dt@kernel.org, nicolas.frattaroli@collabora.com, 
 luca.ceresoli@bootlin.com, Laurent.pinchart@ideasonboard.com, 
 neil.armstrong@linaro.org, simona@ffwll.ch, rfoss@kernel.org, 
 jonas@kwiboo.se, dianders@chromium.org, tzimmermann@suse.de, 
 hjc@rock-chips.com, andrzej.hajda@intel.com, devicetree@vger.kernel.org, 
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jernej.skrabec@gmail.com, andy.yan@rock-chips.com, airlied@gmail.com, 
 heiko@sntech.de, linux-rockchip@lists.infradead.org
To: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <20260525082033.117569-2-damon.ding@rock-chips.com>
References: <20260525082033.117569-1-damon.ding@rock-chips.com>
 <20260525082033.117569-2-damon.ding@rock-chips.com>
Message-Id: <177970943805.3630512.11044367202921728726.robh@kernel.org>
Subject: Re: [PATCH v7 01/10] dt-bindings: display: rockchip: analogix-dp:
 Fix hclk as third clock for RK3588
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


On Mon, 25 May 2026 16:20:24 +0800, Damon Ding wrote:
> RK3588 eDP controller requires HCLK_VO1 to access the VO1 GRF
> registers and enable the video datapath.
> 
> Previously, the clock was enabled implicitly via the 'rockchip,vo-grf'
> phandle reference, which allowed the eDP to work without explicitly
> managing the hclk_vo1 clock. However, this is not safe or explicit.
> 
> To make the clock dependency explicit, enforce per-SoC clock-names
> requirements:
>  - RK3288: 2 clocks (dp, pclk)
>  - RK3399: 3 clocks (dp, pclk, grf)
>  - RK3588: 3 clocks (dp, pclk, hclk)
> 
> Do not reuse the 'grf' clock name for RK3588 because it represents
> a different clock with distinct control logic:
> - The 'grf' clock is only for GRF register access and is toggled
>   dynamically during register access.
> - The 'hclk' clock controls both GRF access and video datapath
>   gating, and must remain enabled during probe.
> 
> Fixes: f855146263b1 ("dt-bindings: display: rockchip: analogix-dp: Add support for RK3588")
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> 
> ---
> 
> Changes in v4:
> - Modify the commit msg.
> 
> Changes in v5:
> - Enforce the correct third clock name on a per-compatible basis.
> - Modify the commit msg simultaneously.
> 
> Changes in v6:
> - Expand more detail commit msg about using hclk instead of grf clock.
> 
> Changes in v7:
> - List all valid clock names at the top level, and constrain the clock
>   count for each platform with minItems/maxItems in allOf.
> ---
>  .../rockchip/rockchip,analogix-dp.yaml        | 34 ++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml:30:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260525082033.117569-2-damon.ding@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

