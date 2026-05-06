Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D02ACD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 08:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D0910E86A;
	Wed,  6 May 2026 08:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="LYKE8t8o";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17CB710E86A
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 08:02:28 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90CDE55;
 Wed,  6 May 2026 10:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778054544;
 bh=h8EAQpbcLRoOTItUBLxq/JKC4M0puvCg2tyekByJdNk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=LYKE8t8o0xKJqqpNHwNCH3okt2c70g4P/C8mGJD50UQjSBAI0yhkYE8mIKgnJZuf9
 /X3BuKFbYk6tSwNsvWuTRhZ2GUVyAc7EW9lGfwJUlj4ZgaraMm8o0PE0cOb1dvOwkP
 +31Otd1mWN+oB+RyCzEZQ+p3NumCrG0PasZNuDYA=
Message-ID: <b67cc003-9944-4dbe-91ec-c7335dcf5c03@ideasonboard.com>
Date: Wed, 6 May 2026 11:02:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/xlnx/zynqmp-dpsub: Fix dependencies for
 COMPILE_TEST
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
References: <20260505094716.1784225-1-wenst@chromium.org>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20260505094716.1784225-1-wenst@chromium.org>
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

On 05/05/2026 12:47, Chen-Yu Tsai wrote:
> The zynqmp-dpsub driver does not have build time dependencies on the PHY
> or DMA drivers. These are runtime hardware restrictions.
> 
> Make the two dependencies optional if COMPILE_TEST.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
> Changes since v1:
> - Keep each dependency on a separate line
> 
> IMO the two driver dependencies could be removed altogether, but that
> would be up to the driver and platform maintainers.
> ---
>   drivers/gpu/drm/xlnx/Kconfig | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/Kconfig b/drivers/gpu/drm/xlnx/Kconfig
> index cfabf5e2a0bb..58c19e5a7e8f 100644
> --- a/drivers/gpu/drm/xlnx/Kconfig
> +++ b/drivers/gpu/drm/xlnx/Kconfig
> @@ -3,8 +3,8 @@ config DRM_ZYNQMP_DPSUB
>   	depends on ARCH_ZYNQMP || COMPILE_TEST
>   	depends on COMMON_CLK && DRM && OF
>   	depends on DMADEVICES
> -	depends on PHY_XILINX_ZYNQMP
> -	depends on XILINX_ZYNQMP_DPDMA
> +	depends on PHY_XILINX_ZYNQMP || COMPILE_TEST
> +	depends on XILINX_ZYNQMP_DPDMA || COMPILE_TEST
>   	select DMA_ENGINE
>   	select DRM_CLIENT_SELECTION
>   	select DRM_DISPLAY_DP_HELPER

Thanks, pushed to drm-misc.

  Tomi

