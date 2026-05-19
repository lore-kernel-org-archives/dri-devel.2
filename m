Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65165CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 13:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2AE210ED16;
	Tue, 19 May 2026 13:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RYSIwX7N";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B039710ED16
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779198217; x=1810734217;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=exV8hygySw1KI0J7oiVeWZSbjE1gtP4/UQEEL14ddOw=;
 b=RYSIwX7NvfJJViTs73HlGYV/rZmrolReajSUCgpSQRgVFoVyaqZC1fQK
 iHPzmgtY6A6xddxctD7dj6iQkQXh+kvmRpgrGZWSjrucZy6LBSsCOHriC
 qfjm87brnhWPJSfQyv/lV0z5zZIbzOYJgqyc08F7vwiKOm4pzpj+4XpMo
 O2j/nxZsTS+JG6cc6deRjV1b8ml4NGephfSw3vU98tnQDlQSXCtdE6hyc
 8LpmohmQxF0swbWP/YvXuVvqcmDZ7ZbVFdr1G8OnBPG+Jp8bUcMud0gms
 PyUFPJ2281hYMmsd4DWiCaQA0/OqhJkISBkBcBuuw/WchUblmTglBkEnQ A==;
X-CSE-ConnectionGUID: 1tursTYoRyW5/NeAQ9VKRQ==
X-CSE-MsgGUID: 31wz3ZEyR0+ZVj3wFOAx7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80127272"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="80127272"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 06:43:35 -0700
X-CSE-ConnectionGUID: JZZhgaONSbu9Kph92VzKig==
X-CSE-MsgGUID: Yw2KK65NR8eVdiGAgLaHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="263555729"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa001.fm.intel.com with ESMTP; 19 May 2026 06:43:27 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
 id 7C24995; Tue, 19 May 2026 15:43:26 +0200 (CEST)
Date: Tue, 19 May 2026 16:43:14 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Peter Chen <hzpeterchen@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Yubing Zhang <yubing.zhang@rock-chips.com>,
 Frank Wang <frank.wang@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Amit Sunil Dhamne <amitsd@google.com>,
 Dragan Simic <dsimic@manjaro.org>, Johan Jonker <jbx6244@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Hugh Cole-Baker <sigmaris@gmail.com>, linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: Re: [PATCH v15 0/9] Add Type-C DP support for RK3399 EVB IND board
Message-ID: <agxo8ic94e81nQRx@kuha>
References: <20260304094152.92-1-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304094152.92-1-kernel@airkyi.com>
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

On Wed, Mar 04, 2026 at 05:41:43PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> This series focuses on adding Type-C DP support for USBDP PHY and DP
> driver. The USBDP PHY and DP will perceive the changes in cable status
> based on the USB PD and Type-C state machines provided by TCPM. Before
> this, the USBDP PHY and DP controller of RK3399 sensed cable state
> changes through extcon, and devices such as the RK3399 Gru-Chromebook
> rely on them. This series should not break them.

What's the status with this series?
Are these inteded to go via the DRM tree?

thanks,

> ====
> 1. DisplayPort HPD status notify
> 
> Before v7, I implemented a variety of DP HPD status notify. However,
> they all had various problems and it was difficult to become a generic
> solution.
> 
> Under the guidance of Heikki and Dmitry, a decoupled notification
> method between the TypeC and DRM subsystems was introduced in v7.
> First, a notification is sent when TypeC registers a new altmode.
> Then, a generic DP AUX HPD bridge is implemented on the DRM side.
> 
> During v7-v10, we added a new notifier in typec to notify the altmode
> device register event. With the help of Greg and Heikki, we implemented
> the reuse of notifiers for the type bus itself in patch1 of v11.
> 
> The USB subsystem related parts have already been merged into the
> usb-next branch in v13 [0][1]. Therefore, this series no longer includes
> these patches starting from v14. Thanks to Greg and Heikki!
> 
> [0]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=67ab45426215c7fdccb65aecd4cac15bbe4dfcbb
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=4dee13db29de6dd869af9b3827e1ff569644e838
> 
> That makes it redundant for each Type-C controller driver to implement
> a similar DP AUX HPD bridge in embedded scenarios.
> 
> ====
> 2. Altmode switching and orientation switching for USBDP PHY
> 
> For USB Type-C interfaces, an external Type-C controller chip assists
> by detecting cable attachment, determining plug orientation, and
> reporting USB PD message. The USB/DP combo PHY supports software
> configurable pin mapping and DisplayPort lane assignment. Based on
> these message, the combo PHY can perform both altmode switching and
> orientation switching via software.
> 
> The RK3399 EVB IND board has a Type-C interface DisplayPort. It use
> fusb302 chip as Type-C controller. The connection diagram is shown below:
> 
> fusb302 chip +---> USB2.0 PHY ----> DWC3 USB controller
>              |
>              +---> USB/DP PHY0 +--> CDN-DP controller
>                                |
>                                +--> DWC3 USB controller
> 
> ====
> 3. Multiple bridge model for RK3399 CDN-DP
> 
> The RK3399 has two USB/DP combo PHY and one CDN-DP controller. And
> the CDN-DP can be switched to output to one of the PHYs.
> 
> USB/DP PHY0 ---+
>                | <----> CDN-DP controller
> USB/DP PHY1 ---+
> 
> In previous versions, if both PHY ports were connected to DP,
> the CDN-DP driver would select the first PHY port for output.
> 
> On Dmitry's suggestion, we introduced a multi-bridge model to support
> flexible selection of the output PHY port. For each PHY port, a
> separate encoder and bridge are registered.
> 
> The change is based on the DRM AUX HPD bridge, rather than the
> extcon approach. This requires the DT to correctly describe the
> connections between the first bridge in bridge chain and DP
> controller. And Once the first bridge is obtained, we can get the
> last bridge corresponding to the USB-C connector, and then set the
> DRM connector's fwnode to the corresponding one to enable HPD
> notification.
> 
> ====
> Patch1 add generic USB Type-C DP HPD bridge (Dmitry, Heikki).
> Patch2 add new API drm_aux_bridge_register_from_node() (Neil) .
> Patch3 add new Type-C mode switch for RK3399 USBDP phy binding (Krzysztof).
> Patch4 add typec_mux and typec_switch for RK3399 USBDP PHY.
> Patch5 add DRM AUX bridge support for RK3399 USBDP PHY (Neil).
> Patch6 drops CDN-DP's extcon dependency when Type-C is present (Dmitry).
> Patch7 add multiple bridges to support PHY port selection (Dmitry, Luca).
> Patch8 add missing dp_out port for RK3399 CDN-DP.
> Patch9 add Type-C DP support for RK3399 EVB IND board (Diederik, Peter).
> 
> Changes in v15:
> - Link to V14: https://lore.kernel.org/all/20260119073100.143-1-kernel@airkyi.com/
> - Improve clarity by inlining drm_bridge_get() in assignment (Luca).
> 
> Changes in v14:
> - Link to V13: https://lore.kernel.org/all/20251208015500.94-1-kernel@airkyi.com/
> - Drop the patches for the USB Type-C subsusytem part, as they have
>   already been merged into usb-next.
> 
> Changes in v13:
> - Link to V12: https://lore.kernel.org/all/20251204063109.104-1-kernel@airkyi.com/
> - Only register drm dp hpd bridge for typec port altmode device.
> 
> Changes in v12:
> - Link to V11: https://lore.kernel.org/all/20251128020405.90-1-kernel@airkyi.com/
> - Add missing Signed-off-by line.
> 
> Changes in v11:
> - Link to V10: https://lore.kernel.org/all/20251120022343.250-1-kernel@airkyi.com/
> - Switch to using typec bus notifiers.
> 
> Changes in v10:
> - Link to V9: https://lore.kernel.org/all/20251111105040.94-1-kernel@airkyi.com/
> - Notify TYPEC_ALTMODE_UNREGISTERED when altmode removed. 
> - Add drm_aux_bridge_register_from_node().
> - Fix refcount usage of drm_bridge.
> 
> Changes in v9:
> - Link to V8: https://lore.kernel.org/all/20251029071435.88-1-kernel@airkyi.com/
> - Remove the exposed DRM_AUX_HPD_BRIDGE option, and select
> DRM_AUX_HPD_TYPEC_BRIDGE when it is available.
> - Add usb role switch for Type-C.
> - Remove USB2 PHY in Type-C connection.
> - ...
> 
> Changes in v8:
> - Link to V7: https://lore.kernel.org/all/20251023033009.90-1-kernel@airkyi.com/
> - Export all typec device types for identification.
> - Merge generic DP HPD bridge into one module.
> - Fix coding style.
> 
> Changes in v7:
> - Link to V6: https://lore.kernel.org/all/20251016022741.91-1-kernel@airkyi.com/
> - Add notifier functions for Type-C core.
> - Add generic USB Type-C DP HPD bridge.
> 
> Changes in v6:
> - Link to V5: https://lore.kernel.org/all/20251011033233.97-1-kernel@airkyi.com/
> - Fix depend in Kconfig.
> - Check DP svid in tcphy_typec_mux_set().
> - Remove mode setting in tcphy_orien_sw_set().
> - Rename some variable names.
> - Attach the DP bridge to the next bridge.
> 
> Changes in v5:
> - Link to V4: https://lore.kernel.org/all/20250922012039.323-1-kernel@airkyi.com/
> - Remove the calls related to `drm_aux_hpd_bridge_notify()`.
> - Place the helper functions in the same compilation unit.
> - Add more comments about parent device.
> - Add DRM AUX bridge support for RK3399 USBDP PHY
> - By parsing the HPD bridge chain, set the connector's of_node to the
> of_node corresponding to the USB-C connector.
> - Return EDID cache when other port is already enabled.
> 
> Changes in v4:
> - Link to V3: https://lore.kernel.org/all/20250729090032.97-1-kernel@airkyi.com/
> - Add default HPD device for DisplayPort altmode.
> - Introduce multiple bridges for CDN-DP.
> - ...
> 
> Changes in v3:
> - Link to V2: https://lore.kernel.org/all/20250718062619.99-1-kernel@airkyi.com/
> - Add more descriptions to clarify the role of the PHY in switching.
> - Fix wrong vdo value.
> - Fix port node in usb-c-connector.
> 
> Changes in v2:
> - Link to V1: https://lore.kernel.org/all/20250715112456.101-1-kernel@airkyi.com/
> - Reuse dp-port/usb3-port in rk3399-typec-phy binding.
> - Fix compile error when CONFIG_TYPEC is not enabled.
> - Notify DP HPD state by USB/DP PHY.
> - Ignore duplicate HPD events.
> - Add endpoint to link DP PHY and DP controller.
> - Fix devicetree coding style.
> 
> Chaoyi Chen (9):
>   drm/bridge: Implement generic USB Type-C DP HPD bridge
>   drm/bridge: aux: Add drm_aux_bridge_register_from_node()
>   dt-bindings: phy: rockchip: rk3399-typec-phy: Support mode-switch
>   phy: rockchip: phy-rockchip-typec: Add typec_mux/typec_switch support
>   phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
>   drm/rockchip: cdn-dp: Support handle lane info without extcon
>   drm/rockchip: cdn-dp: Add multiple bridges to support PHY port
>     selection
>   arm64: dts: rockchip: Add missing dp_out port for RK3399 CDN-DP
>   arm64: dts: rockchip: rk3399-evb-ind: Add support for DisplayPort
> 
>  .../phy/rockchip,rk3399-typec-phy.yaml        |   6 +
>  arch/arm64/boot/dts/rockchip/rk3399-base.dtsi |  10 +-
>  .../boot/dts/rockchip/rk3399-evb-ind.dts      | 147 +++++++
>  drivers/gpu/drm/bridge/Kconfig                |  10 +
>  drivers/gpu/drm/bridge/Makefile               |   1 +
>  drivers/gpu/drm/bridge/aux-bridge.c           |  24 +-
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  |  49 +++
>  drivers/gpu/drm/rockchip/Kconfig              |   1 +
>  drivers/gpu/drm/rockchip/cdn-dp-core.c        | 349 +++++++++++++---
>  drivers/gpu/drm/rockchip/cdn-dp-core.h        |  18 +-
>  drivers/phy/rockchip/Kconfig                  |   3 +
>  drivers/phy/rockchip/phy-rockchip-typec.c     | 373 +++++++++++++++++-
>  include/drm/bridge/aux-bridge.h               |   6 +
>  13 files changed, 913 insertions(+), 84 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
> 
> -- 
> 2.51.1

-- 
heikki
