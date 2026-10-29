Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83235606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=FIGBN9fR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E97D010E04B;
	Thu, 29 Oct 2026 08:27:59 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFAB310E04B
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:27:53 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029082752euoutp0147f2fdd4226030da927ee4a66bb0b28a~i8reo7p_01892518925euoutp01c
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:27:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029082752euoutp0147f2fdd4226030da927ee4a66bb0b28a~i8reo7p_01892518925euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793262472;
 bh=gtkThhp7HAR2Inex6AHRIVWwfpvzSe5F6c2HI/CDFLI=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=FIGBN9fReDJodzfMzBXaOENYqA6b4tTsue6GFNMj62QZ5y3M+Nw4b3DLcC0qOklA2
 IZcAIk+OEP4qtBJ4ZqoEKPvu5V8q1vWtmxRYj63v60IHrWc8EWtrQFjuh209vGUaE2
 mbLDKIybckrKXXv1l/Uex5TI7ki9ZhULmmnTFtd0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029082751eucas1p2453c151aaaaf4dc156fecaa44b339ef2~i8reQdPDF1008610086eucas1p2d;
 Thu, 29 Oct 2026 08:27:51 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029082750eusmtip168d8b64350b4dc54d7804c97473cdeee~i8rdAMflV3276632766eusmtip1K;
 Thu, 29 Oct 2026 08:27:50 +0000 (GMT)
Message-ID: <fa68308d-07f5-4a62-9e18-a306a5751e43@samsung.com>
Date: Thu, 29 Oct 2026 09:27:49 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 1/3] drm/bridge: analogix_dp: deassert DP_PHY_PD on
 power-on for exynos
To: tb@a-marquet.fr, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jingoo Han <jingoohan1@gmail.com>, Inki Dae
 <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin
 Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Douglas Anderson <dianders@chromium.org>, Jessica
 Zhang <jesszhan0024@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 Lukas Timmermann <linux@timmermann.space>, Henrik Grimler
 <henrik@grimler.se>, Hendrik Noack <hendrik-noack@gmx.de>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027-drm-misc-next-manta-auxbus-v1-1-3a45c3cf531d@a-marquet.fr>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261029082751eucas1p2453c151aaaaf4dc156fecaa44b339ef2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027120921eucas1p2af4aec7a911cbb07018a91fcf82a8c32
X-EPHeader: CA
X-CMS-RootMailID: 20261027120921eucas1p2af4aec7a911cbb07018a91fcf82a8c32
References: <20261027-drm-misc-next-manta-auxbus-v1-0-3a45c3cf531d@a-marquet.fr>
 <CGME20261027120921eucas1p2af4aec7a911cbb07018a91fcf82a8c32@eucas1p2.samsung.com>
 <20261027-drm-misc-next-manta-auxbus-v1-1-3a45c3cf531d@a-marquet.fr>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 27.10.2026 13:01, Alexandre Marquet via B4 Relay wrote:
> From: Alexandre Marquet <tb@a-marquet.fr>
>
> On exynos platforms at least, calling
> analogix_dp_set_analog_power_down() to power on (with enable=false) CH0
> to CH3 or the AUX bus currently produces no effect, unless the function
> is first called to power on everything (by setting block to POWER_ALL or
> ANALOG_TOTAL). The reason for this is that DP_PHY_PD being asserted
> (which is its default state) renders every other register bit
> ineffective.
>
> This is particularly an issue for AUX bus initialization, that tends to
> happen before anything else (e.g., to request EDID), and thus, before
> anything has any chance to request a power on of the whole analog
> section of the chip.
>
> This commit allows analogix_dp_set_analog_power_down() to power on any
> block, by deasserting DP_PHY_PD if needed.
>
> Signed-off-by: Alexandre Marquet <tb@a-marquet.fr>

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Snow, Peach-Pit and Peach-Pi Chromebooks work fine with this change.

> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> index c1344a3f013a..9f634d4e4793 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_reg.c
> @@ -256,6 +256,19 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>  	if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
>  		phy_pd_addr = ANALOGIX_DP_PD;
>  
> +	reg = readl(dp->reg_base + phy_pd_addr);
> +
> +	if (dp->plat_data && (dp->plat_data->dev_type == EXYNOS_DP)) {
> +		/* On exynos, register AUX_PD and CH[0-3]_PD have no effect if
> +		 * DP_PHY_PD is asserted. So, when powering any of them up, we
> +		 * need to deassert DP_PHY_PD first.
> +		 */
> +		if (!enable && (reg & DP_PHY_PD)) {
> +			reg &= ~DP_PHY_PD;
> +			reg |= AUX_PD | CH0_PD | CH1_PD | CH2_PD | CH3_PD;
> +		}
> +	}
> +
>  	switch (block) {
>  	case AUX_BLOCK:
>  		if (dp->plat_data && analogix_dp_is_rockchip(dp->plat_data->dev_type))
> @@ -263,7 +276,6 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>  		else
>  			mask = AUX_PD;
>  
> -		reg = readl(dp->reg_base + phy_pd_addr);
>  		if (enable)
>  			reg |= mask;
>  		else
> @@ -272,7 +284,6 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>  		break;
>  	case CH0_BLOCK:
>  		mask = CH0_PD;
> -		reg = readl(dp->reg_base + phy_pd_addr);
>  
>  		if (enable)
>  			reg |= mask;
> @@ -282,7 +293,6 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>  		break;
>  	case CH1_BLOCK:
>  		mask = CH1_PD;
> -		reg = readl(dp->reg_base + phy_pd_addr);
>  
>  		if (enable)
>  			reg |= mask;
> @@ -292,7 +302,6 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>  		break;
>  	case CH2_BLOCK:
>  		mask = CH2_PD;
> -		reg = readl(dp->reg_base + phy_pd_addr);
>  
>  		if (enable)
>  			reg |= mask;
> @@ -302,7 +311,6 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>  		break;
>  	case CH3_BLOCK:
>  		mask = CH3_PD;
> -		reg = readl(dp->reg_base + phy_pd_addr);
>  
>  		if (enable)
>  			reg |= mask;
> @@ -321,7 +329,6 @@ void analogix_dp_set_analog_power_down(struct analogix_dp_device *dp,
>  		else
>  			mask = DP_PHY_PD;
>  
> -		reg = readl(dp->reg_base + phy_pd_addr);
>  		if (enable)
>  			reg |= mask;
>  		else
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

