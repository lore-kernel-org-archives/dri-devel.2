Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954A31093199
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 09:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E679D10EA81;
	Fri, 20 Mar 2026 09:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XxsQxNPg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E78D010E541
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:19:08 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 74D8B4026B;
 Fri, 20 Mar 2026 09:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C66ADC2BC9E;
 Fri, 20 Mar 2026 09:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773998348;
 bh=LaFfclQJNpW8j4z2NNQXpLUkD7/mL0945GUUmdgcNYI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XxsQxNPgDUJHJqSei+eyT3/4wLXRMZEqzks3G36VQLFcfu9JWqwnY0mOg0MTOi1Ro
 0xNBxOt4FxheBLRQZkCyILhWO4riIZOPSIilhvRCJqaqqdY6/5HF3hQPztctn6ucIX
 1OKBg5jQrZDwH3wIHVCRAqYFJbjGKxwstlRNVQJe9i0P6mwq/PHNiGhZVoaXjuAI5d
 muiNrzaa0qk78JgPptsfReDFcKvx/Swv28NN4rw22m1qkBYrrXH64UWHgS8AKL1EqF
 sZayDTa+oC8LyGAjhTAcjJ2yxaJIEWbh77k+fYRJoB/Sn4EYeME3yGNRmV8G2OIOBE
 oEPtO3LUNwjSg==
Date: Fri, 20 Mar 2026 10:19:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 nicolas.frattaroli@collabora.com, alchark@gmail.com,
 cristian.ciocaltea@collabora.com, 
 sebastian.reichel@collabora.com, kever.yang@rock-chips.com,
 heiko.stuebner@cherry.de, 
 tomeu@tomeuvizoso.net, amadeus@jmu.edu.cn, michael.riesch@collabora.com, 
 didi.debian@cknow.org, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, 
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] dt-bindings: display: rockchip: analogix-dp:
 Expand clock-names "hclk" for the third clock
Message-ID: <20260320-amusing-magnetic-harrier-20cc40@quoll>
References: <20260319104031.1986946-1-damon.ding@rock-chips.com>
 <20260319104031.1986946-2-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319104031.1986946-2-damon.ding@rock-chips.com>
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

On Thu, Mar 19, 2026 at 06:40:23PM +0800, Damon Ding wrote:
> The RK3588 eDP controller needs the video datapath clock "hclk" to work
> well. Previously, it works without explicitly adding this clock because
> the 'rockchip,vo-grf = <&vo1_grf>' property implicitly enables HCLK_VO1.
> 
> Fixes: f855146263b1 ("dt-bindings: display: rockchip: analogix-dp: Add support for RK3588")
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  .../bindings/display/rockchip/rockchip,analogix-dp.yaml       | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
> index d99b23b88cc5..d2bc8636b626 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
> @@ -26,7 +26,9 @@ properties:
>      items:
>        - const: dp
>        - const: pclk
> -      - const: grf
> +      - enum:
> +          - grf
> +          - hclk

You just told me it is the same clock, no? I asked that and you
confirmed? Or you replied with an answer not relevant to the question?

If this device takes reference to grf, why does it also take grf clock?
Devices MUST NOT take clocks on behalf of other devices, so please
answer with a list of all clock inputs according to datasheet/manual.

Best regards,
Krzysztof

