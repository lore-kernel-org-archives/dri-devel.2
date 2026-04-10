Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8404CE99056
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 08:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D449510E8F1;
	Fri, 10 Apr 2026 08:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NQOBsmSS";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A9A310E8F1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 08:49:22 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 140B31BA;
 Fri, 10 Apr 2026 10:47:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1775810871;
 bh=B3bCH4eK4SDGWzConbdIJjKqB8zZIxiB9xzyJNvcFcA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=NQOBsmSS8xwW0SLfudmHx5STnd8i9hkUKcWla62wl+DjHn+//J3/6qly8HUbd5Ju1
 DpbyBdw26kR7dHAkY2iHvZSJyMmKSu3JOy7UctzEoUVZEaG9RMPZEpsMnv5vFnZ3Ze
 qQOI30uxAcnf4UoEz8FVig2ZN+rya2+cJ+7B7PSY=
Message-ID: <386241e0-3d1b-43cc-8bc0-b6d35a97ba89@ideasonboard.com>
Date: Fri, 10 Apr 2026 11:49:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xlnx/zynqmp-dpsub: Fix dependencies for COMPILE_TEST
To: Chen-Yu Tsai <wenst@chromium.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260408081430.1712335-1-wenst@chromium.org>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260408081430.1712335-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi,

On 08/04/2026 11:14, Chen-Yu Tsai wrote:
> The zynqmp-dpsub driver does not have build time dependencies on the PHY
> or DMA drivers. These are runtime hardware restrictions.
> 
> Group the two dependencies with ARCH_ZYNQMP so that the driver can be
> compile tested without them.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> IMO the two driver dependencies could be removed altogether, but that
> would be up to the driver and platform maintainers.
> ---
>   drivers/gpu/drm/xlnx/Kconfig | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
> index cfabf5e2a0bb..4c6729459f40 100644
> --- a/drivers/gpu/drm/xlnx/Kconfig
> +++ b/drivers/gpu/drm/xlnx/Kconfig
> @@ -1,10 +1,8 @@
>   config DRM_ZYNQMP_DPSUB
>   	tristate "ZynqMP DisplayPort Controller Driver"
> -	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on (ARCH_ZYNQMP && PHY_XILINX_ZYNQMP && XILINX_ZYNQMP_DPDMA) || COMPILE_TEST
>   	depends on COMMON_CLK && DRM && OF
>   	depends on DMADEVICES
> -	depends on PHY_XILINX_ZYNQMP
> -	depends on XILINX_ZYNQMP_DPDMA
>   	select DMA_ENGINE
>   	select DRM_CLIENT_SELECTION
>   	select DRM_DISPLAY_DP_HELPER

I think the above looks more difficult to understand than the current 
version. We should perhaps rather drop the dependencies. But if we go 
that way, then... we can also drop DMADEVICES, DMA_ENGINE, GENERIC_PHY 
at least.

What problem does this solve? Why are these two dependencies bad for 
compile testing, but the other dependencies/selects are ok?

I personally don't mind hard runtime dependencies expressed in the 
Kconfig, as searching for the correct dependency-drivers when your 
driver doesn't probe is always a PITA.

  Tomi

