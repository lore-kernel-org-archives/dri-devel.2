Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7103BFF4927
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 01:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44CC10E2EC;
	Mon, 30 Mar 2026 01:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="r47FcybM";
	dkim-atps=neutral
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.74.132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF4910E2EC
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 01:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1774834462;
 bh=sfiAM2xTM874MiG/dhh6ShU4/XvUVAmXi/VOTC6gjTA=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=r47FcybMsUdzUS2n1obC5iPMspWHmlN9+YLleegl2RqVE7Lef6K463mJbd4tNXDgb
 dIVUqyHpCkosydQRqmUhtmwcp3+JQyNY5BbQb9qb1y4BHlRdDQfmAIfnZUtQ83rQlz
 HpSn6Dw5iAcPLdcd0IRBTYaqsTPn0H51oXfQLvK0=
X-QQ-mid: zesmtpsz9t1774834460t11607d84
X-QQ-Originating-IP: nTZ358fNU9KEol2P7krw/Em4+kZ+xSnWIUvoRY+oi8E=
Received: from [172.16.12.51] ( [58.22.7.114]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 30 Mar 2026 09:34:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7524343022994647576
Message-ID: <FE1BFB774BE13241+54b8a8ce-5a8c-495d-a53f-65a2440924fb@airkyi.com>
Date: Mon, 30 Mar 2026 09:34:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Synopsys DisplayPort Controller improvements for
 Rockchip platforms
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Damon Ding <damon.ding@rock-chips.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 kernel@collabora.com
References: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
Content-Language: en-US
From: Chaoyi Chen <kernel@airkyi.com>
In-Reply-To: <20260326-synopsys-dw-dp-improvements-v1-0-501849162290@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MjqaYNLY8QZGzozxPa2e4UjsmSFPMWH9daKuUnGcIpjj7/i+hyxjp0G9
 CMBCaI/U8ineNaDjYX6lqVAGcejW5rfS6pI18d+1mz62wILtrVzzc2foG46GailYsNq3JYz
 XRkUkg967jlqFOrlhnylB7wrgkDqy7cH6yiE66+vtTsgHuH6H1itqPOiQHt03RMMF9Mh43h
 W/uGdE4DLLOGhga+PIkjFRs8TJ302/pJimdYT+jCvns8TnYtq3G5MAAtbfhQzCZk15iQX5X
 IAxzxp4U/iuXOI2a8fBbyV9V3PVl/n2SOeADfDq8PiSEreZPsArbXU1KTbJskt6PcJ3nz1q
 4paoxTTelb4MVzVYbaEHmbNrmUT1TTv/GgZXxi2qYjnWSPp1a7yAtqFGG+f3odNYlmvAYoe
 kmMzypik4f3j54R73hawMytelbilLn4jUIVI3nnzTL5VlS2BoWlG2K6uz1OXcsiR/4vzbuO
 hdv9158lrOybqRq46Sf79c2e3CIpc9piLNdcakFRAQeQgcHEqMMa1DRKjE4/sGaYy5av//E
 TtvkcfG2DZvhoHXEuPxKiJAfjAZnyqz5dbGZXhprGwokNmVwmBsXrKhGGTREavOZARRpv1g
 kk81hjWRDQfrDoPnFFLFx2fQ/qj/lMKtgutXXDnwV1kMqLNPQ7nYC5sKXVrjQQWAfnnxxoo
 TZf60moYzpRXSiKeYpIQ/9E4I/uxCiUmFrWBeCzDVb2M+FBsWWDlkYdkVeBa3cbbkIBuj8E
 SJF0m+M3kG+DZ59Ax2lbb455wQpXrjKib8dQlWfYWjZw6BErP1tdKGfoUKyUGLfUZ4HTOlL
 WYsYe2p3GBK+8+X8JC0NWh8Lx0Jjd0qU9n0togB8R0IeSmlHsuM6yqY+X4/CJn7iqo7YRgO
 BU+VnzoqBIQ1u4PzHM7F/B/fiA78PUh41y0O+hKSU3ORGT2aKIe5EpVDfZ69HEkWxpjXPvm
 turVEQZ/QU1cEAzLYufkjgsP44rJqEgDzbtDR/8UVUij2AVJ3bWWZAoh9qW+8UxotTp6dCv
 LUDbox7Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
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

Hello Sebastian, 

On 3/27/2026 1:31 AM, Sebastian Reichel wrote:
> This patch series updates the Synopsys Designware DisplayPort bridge
> together with the only existing user: The Rockchip RK3576/RK3588:
> 
>  1. follow-up bridges (PHY, USB-C connector)
>     this is needed to get USB-C DP AltMode working; I've followed the
>     Qualcomm driver as reference
> 
>  2. runtime PM
>     the initial driver has been upstreamed without RPM; add it to
>     avoid wasting power when nothing is plugged
> 
>  3. audio
>     the initial driver has been upstreamed without audio support;
>     this adds all missing bits for audio with single stream transport
> 
> The series is based on drm-misc-next with Cristian's cleanup series
> applied as I expect that to land first:
> 
> https://lore.kernel.org/linux-rockchip/20260310-drm-rk-fixes-v2-0-645ecfb43f49@collabora.com/
> 
> To properly make use of the bridge code the following USBDP PHY series
> is also needed:
> 
> https://lore.kernel.org/linux-rockchip/20260313-rockchip-usbdp-cleanup-v3-0-3e8fe89a35b5@collabora.com/
> 
> There are two parts, which possibly need some discussion:
> 
>  1. I added a dedicated bridge callback for out-of-band hotplug events,
>     which is separate from the hotplug_notify. I have a feeling, that
>     there might be a better solution, but haven't found it.
> 

Could you explain what an out-of-band hotplug event is?

Can't the drivers/usb/typec/altmodes/displayport.c respond to these
hot-plug events? Thank you.


>  2. The DT binding for audio support - explicitly marked as RFC - works
>     perfectly fine, but is not ready for MST. I don't intend to
>     implement that right now, but the binding should obviously take it
>     into consideration to avoid breaking it in the future. I've put
>     some points for discussion into the relevant patch.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
> Sebastian Reichel (10):
>       drm/bridge: synopsys: dw-dp: Simplify driver data setting
>       drm/bridge: synopsys: dw-dp: Support MEDIA_BUS_FMT_FIXED
>       drm/bridge: synopsys: dw-dp: Add follow-up bridge support
>       drm/bridge: Add out-of-band HPD notify handler
>       drm/bridge: synopsys: dw-dp: Support software triggered OOB HPD
>       drm/rockchip: dw_dp: Implement out-of-band HPD handling
>       drm/bridge: synopsys: dw-dp: Add Runtime PM support
>       drm/rockchip: dw_dp: Add runtime PM support
>       [RFC] dt-bindings: display: rockchip: dw-dp: fix sound DAI cells
>       drm/bridge: synopsys: dw-dp: Add audio support
> 
>  .../bindings/display/rockchip/rockchip,dw-dp.yaml  |   5 +-
>  drivers/gpu/drm/bridge/synopsys/dw-dp.c            | 284 ++++++++++++++++++++-
>  drivers/gpu/drm/display/drm_bridge_connector.c     |   6 +
>  drivers/gpu/drm/rockchip/dw_dp-rockchip.c          | 167 +++++++++++-
>  include/drm/bridge/dw_dp.h                         |   6 +
>  include/drm/drm_bridge.h                           |  14 +
>  6 files changed, 469 insertions(+), 13 deletions(-)
> ---
> base-commit: 0660ee19141e5e90b422b7daa0d8518a8d0d898b
> change-id: 20260325-synopsys-dw-dp-improvements-7da2e98df1dd
> 
> Best regards,

-- 
Best, 
Chaoyi

