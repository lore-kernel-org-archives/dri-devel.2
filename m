Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA14CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 10:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C1910E11D;
	Thu, 14 May 2026 10:03:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hjRggEcJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A945310E11D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:03:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BD4E760121;
 Thu, 14 May 2026 10:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E16C2BCB3;
 Thu, 14 May 2026 10:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778753005;
 bh=eU1EYUyxKUydlQNJ+xAxAssRfVy3MHIEswP/6qw7geQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hjRggEcJoBqqvzhAfk8uDlGzbN+fWIEB6v9ayYO/nj6a0TGULZA//piez8JarOJjL
 QGd2G0jTgrkp7UCh1FI/NYiYPknn4sfrluQi+c3KkHMOII6jtwkFtgkEgdIa7UlHwv
 i9XrOj+t1VihC1qq2MaMankZACs8/fK97sDtFI4zWQ05VYwXIwDFkcLCXe2vqzi9Ua
 dXawt8bbnTX9W1PD2nE/Nzo7OumP3goQJk8WbroACgRKDEOKywszgPwg4LKVJOkQ3W
 HxcafGHjgtPVJWLEgJSqgirVk5PtxP26mGLuR4a5pLZ81urqyPvZ7PzDvz0JTOTWKI
 KzBB/NcWSHdkg==
Date: Thu, 14 May 2026 12:03:23 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, 
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com, 
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, 
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/10] dt-bindings: display: rockchip: analogix-dp:
 Fix hclk as third clock for RK3588
Message-ID: <20260514-elegant-agate-pug-449ec2@quoll>
References: <20260513074414.2053435-1-damon.ding@rock-chips.com>
 <20260513074414.2053435-2-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513074414.2053435-2-damon.ding@rock-chips.com>
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

On Wed, May 13, 2026 at 03:44:05PM +0800, Damon Ding wrote:
> RK3588 eDP controller requires HCLK_VO1 (video output bus clock)
> to access the VO1 GRF registers and enable the video datapath.

To access GRF? Then it is the same clock input.

AGAIN (reiterated soooo many times by me): you describe here clock
input, NOT OUTPUT.

> 
> Previously, the clock was enabled implicitly via the 'rockchip,vo-grf'
> phandle reference, which allowed the eDP to work without explicitly
> managing the hclk_vo1 clock. However, this is not safe or explicit.
> 
> Enforce the correct third clock name on a per-compatible basis to
> standardize clock requirements per SoC. This makes the clock
> dependency clear and removes reliance on implicit clock enablement
> from GRF phandle.
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
> ---
>  .../rockchip/rockchip,analogix-dp.yaml        | 37 +++++++++++++++++--
>  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
> index d99b23b88cc5..8001c1facf98 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,analogix-dp.yaml
> @@ -23,10 +23,7 @@ properties:
>  
>    clock-names:
>      minItems: 2
> -    items:
> -      - const: dp
> -      - const: pclk
> -      - const: grf

What is 'grf' clock in such case?

Best regards,
Krzysztof

