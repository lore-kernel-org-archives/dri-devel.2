Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7E606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qvaGOTUI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D83E710E7ED;
	Thu, 29 Oct 2026 08:29:34 +0000 (UTC)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A344E10E7D0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:28 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029082927euoutp02aa03f372b544dfc2aaace975283d181e~i8s3ESBw82650126501euoutp02K
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20261029082927euoutp02aa03f372b544dfc2aaace975283d181e~i8s3ESBw82650126501euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793262567;
 bh=UK+T1fUrffefWQeeypNT3V5Xlc8CqTGPzUVGW2Qr1Bw=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=qvaGOTUIZnX5CO/DlLrEbFU2ZPcOTW3HfwPalpaWMkSUEDnwRXtbW0uSetDAS+kJo
 4oCJKXE6baZePb7Goxfgwa26zu5ugszNEOZ3chUuhvFFDWfufcIvhlH0/PmuboJIf4
 cqSURW/KVicS4+qYavd4nIG5CI0pGHPlMbvIdzLQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261029082926eucas1p1d72f8c3eacdad4b2659d50037784a936~i8s2gTNIg0466204662eucas1p1R;
 Thu, 29 Oct 2026 08:29:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029082925eusmtip152f2de6fc696f5bab67a247ac0d81d4e~i8s1UCGH50120401204eusmtip1x;
 Thu, 29 Oct 2026 08:29:25 +0000 (GMT)
Message-ID: <c451af42-2e79-43fd-b66e-08a2b01283c6@samsung.com>
Date: Thu, 29 Oct 2026 09:29:24 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v5 00/18] Add HPD support for Rockchip Analogix DP
To: Damon Ding <damon.ding@rock-chips.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jingoo Han <jingoohan1@gmail.com>, Inki Dae
 <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin
 Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Sandy Huang
 <hjc@rock-chips.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027132810.1746118-1-damon.ding@rock-chips.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261029082926eucas1p1d72f8c3eacdad4b2659d50037784a936
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027133735eucas1p217fbce1514e5d83c14e64d8d0b1ae867
X-EPHeader: CA
X-CMS-RootMailID: 20261027133735eucas1p217fbce1514e5d83c14e64d8d0b1ae867
References: <CGME20261027133735eucas1p217fbce1514e5d83c14e64d8d0b1ae867@eucas1p2.samsung.com>
 <20261027132810.1746118-1-damon.ding@rock-chips.com>
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

On 27.10.2026 14:27, Damon Ding wrote:
> This series improves the HPD (Hotplug Detect) interrupt handling in
> the Analogix DP driver to enable reliable native HPD pin detection on
> Rockchip platforms, and introduces platform-specific HPD detection
> schemes with fine-grained interrupt control.
>
> On Rockchip platforms, the Analogix DP native HPD pin IRQ requires the
> DP controller to remain powered, clocked and initialized to generate
> plug/unplug interrupts. The previous driver enabled/disabled IRQ during
> bridge enable/disable, which left no HPD detection when the display
> pipeline was inactive. Additionally, the interrupt mute/unmute/clear
> routines operated on all HPD interrupt bits unconditionally, lacking
> the granularity needed for per-event control.
>
> The series reorganizes IRQ and pm_runtime management into bind/unbind,
> adds IRQF_ONESHOT to eliminate read-modify-write races on interrupt
> mask registers between hardirq and threaded handlers, converts the
> interrupt type detection to a bitmask-based scheme for fine-grained
> mute/unmute/clear operations, and configures Rockchip platforms to use
> the HOTPLUG_CHG interrupt with a 2ms HPD deglitch setting for better
> stability.
>
> Furthermore, the next bridge is now resolved into bridge->next_bridge
> instead of the platform data field, the forced connected-status logic
> is restricted to panel endpoints based on the bridge chain, and HPD
> events from downstream bridges (e.g. display-connector with hpd-gpios)
> are handled through the .hpd_notify callback.
>
> Tested on RK3576 with both native HPD pin and GPIO HPD configurations.
>
> Native HPD pin mode:
>
>   &edp {
>       status = "okay";
>       pinctrl-names = "default";
>       pinctrl-0 = <&edp_txm0_pins>;
>   };
>
> GPIO HPD mode:
>
>   &edp {
>       status = "okay";
>       pinctrl-names = "default";
>       pinctrl-0 = <&edp0_hpd>;
>       hpd-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>   };
>
>   &pinctrl {
>       edp {
>           edp0_hpd: edp0-hpd {
>               rockchip,pins = <4 RK_PC1 0 &pcfg_pull_none>;
>           };
>       };
>   };
>
> Display-connector mode (DP connector without HPD GPIO):
>
>   &edp_out_conn {
>       remote-endpoint = <&dp_con_in>;
>   };
>
>   dp-con {
>       compatible = "dp-connector";
>       label = "DP OUT";
>       type = "full-size";
>
>       port {
>           dp_con_in: endpoint {
>               remote-endpoint = <&edp_out_conn>;
>           };
>       };
>   };
>
> Display-connector mode (DP connector with HPD GPIO):
>
>   dp-con {
>       compatible = "dp-connector";
>       label = "DP OUT";
>       type = "full-size";
>       pinctrl-0 = <&edp0_hpd>;
>       pinctrl-names = "default";
>       hpd-gpios = <&gpio4 RK_PC1 GPIO_ACTIVE_HIGH>;
>
>       port {
>           dp_con_in: endpoint {
>               remote-endpoint = <&edp_out_conn>;
>           };
>       };
>   };
>
> All four configurations detect cable plug/unplug events correctly.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Snow, Peach-Pit and Peach-Pi Chromebooks still work fine with this patchset.


> Damon Ding (18):
>   drm/bridge: Select VIDEOMODE_HELPERS for DRM_OF_DISPLAY_MODE_BRIDGE
>   drm/bridge: analogix_dp: Use bridge->next_bridge instead of plat_data
>     field
>   drm/bridge: analogix_dp: Restrict forced connected status to panel
>     endpoints
>   drm/bridge: analogix_dp: Return bitmask from
>     analogix_dp_get_irq_type()
>   drm/bridge: analogix_dp: Check all negative return values for
>     &analogix_dp_device.irq
>   drm/bridge: analogix_dp: Add IRQF_ONESHOT and simplify IRQ handling
>   drm/bridge: analogix_dp: Extend clear_hotplug_interrupts to accept IRQ
>     bitmask
>   drm/bridge: analogix_dp: Extend mute/unmute HPD interrupts to accept
>     irq bitmask
>   drm/bridge: analogix_dp: Simplify analogix_dp_config_interrupt()
>   drm/bridge: analogix_dp: Use platform-specific HPD detection scheme
>   drm/bridge: analogix_dp: Skip native HPD interrupt ops for GPIO HPD
>   drm/rockchip: analogix_dp: Unbind bridge when connector init fails
>   drm/exynos: exynos_dp: Unbind bridge when connector init fails
>   drm/bridge: analogix_dp: Move IRQ enable/disable to bind/unbind
>   drm/bridge: analogix_dp: Manage pm runtime and IRQ for native HPD pin
>     detection
>   drm/bridge: analogix_dp: Declare DRM_BRIDGE_OP_HPD for hotplug
>     reporting
>   drm/bridge: analogix_dp: Handle HPD notification from downstream
>     bridge
>   MAINTAINERS: Add entry for Analogix DP controller bridge
>
>  MAINTAINERS                                   |  11 +
>  drivers/gpu/drm/bridge/Kconfig                |   1 +
>  drivers/gpu/drm/bridge/analogix/Kconfig       |   1 +
>  .../drm/bridge/analogix/analogix_dp_core.c    | 221 +++++++++++++-----
>  .../drm/bridge/analogix/analogix_dp_core.h    |  15 +-
>  .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 153 +++++++-----
>  drivers/gpu/drm/exynos/Kconfig                |   1 -
>  drivers/gpu/drm/exynos/exynos_dp.c            |  16 +-
>  .../gpu/drm/rockchip/analogix_dp-rockchip.c   |   1 +
>  include/drm/bridge/analogix_dp.h              |   1 -
>  10 files changed, 291 insertions(+), 130 deletions(-)
>
> ---
>
> Changes in v2:
> - Split IRQ enable/disable logic, handle native HPD pin and
>   GPIO/force-HPD modes separately to avoid unbalanced enable_irq()
>   calls. (Sashiko)
> - Add separate patch for IRQF_ONESHOT to resolve interrupt mask issues
>   triggered by interrupt preemption. (Sashiko)
> - Update commit messages to align with newly added IRQF_ONESHOT related
>   commit.
> - Move ANALOGIX_DP_HPD_DEGLITCH_L/ANALOGIX_DP_HPD_DEGLITCH_H configs to
>   analogix_dp_reset().
> - Add new patch to restrict the forced connected-status shortcut to
>   panel endpoints only, allowing DP connector bridges to rely on HPD
>   detection. (Reported by Heiko Stuebner)
> - Add new patch to handle HPD notification from downstream bridges
>   (e.g., display-connector with hpd-gpios).
>
> Changes in v3:
> - Reorder the series: convert the IRQ handling to a bitmask and add
>   IRQF_ONESHOT before moving IRQ enable/disable to bind/unbind.
> - Add new patch to check all negative return values for
>   &analogix_dp_device.irq and propagate the actual error code. (Sashiko)
> - Rename macro HPD_IRQ to HPD_IRQ_ALL to avoid confusion with the
>   DP specification IRQ_HPD, extract the irq_type-to-register bit
>   mapping into a shared helper, and drop the unused
>   COMMON_INT_4_HPD_IRQ macro.
> - Simplify commit messages across the series.
> - Add new patch to use bridge->next_bridge instead of the plat_data
>   field, resolving the next bridge in
>   analogix_dp_aux_done_probing(). (Suggested by Heiko Stuebner)
> - Report panel endpoints as always connected from
>   analogix_dp_get_plug_in_status() via force_connected_mode, computed
>   from the bridge chain at attach time.
> - Determine the hpd notify mode from DRM_BRIDGE_OP_HPD on downstream
>   bridges that lack DRM_BRIDGE_OP_DETECT.
> - Add a MAINTAINERS entry for the Analogix DP controller bridge.
>
> Changes in v4:
> - Add Tested-by tag from Heiko.
> - Rebase onto latest tree, picking up the two related patch series [0][1].
>
> [0] https://lore.kernel.org/all/20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com/
> [1] https://lore.kernel.org/all/20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com/
>
> Changes in v5:
> - Add four new patches:
>   - Select VIDEOMODE_HELPERS for DRM_OF_DISPLAY_MODE_BRIDGE to fix
>     the undefined references for non-Exynos users.
>   - Unbind the bridge when drm_bridge_connector_init() fails on the
>     Rockchip and Exynos platforms.
>   - Declare DRM_BRIDGE_OP_HPD on the Analogix DP bridge and report
>     the hotplug events via drm_bridge_hpd_notify().
> - Move the next_bridge resolving patch and the forced connected
>   status restriction to the front of the series.
> - Use a pure threaded IRQ handler and hold runtime PM references in
>   the IRQ thread and the detect paths. (Sashiko)
> - Limit the runtime PM holding to the RK3576/RK3588 platforms and
>   exclude the boards with a fixed panel. (Sashiko)
> - Fix the display timings leak in analogix_dp_aux_done_probing().
>   (Sashiko)
> - Change the type of &analogix_dp_device.irq to int to fix the dead
>   dp->irq < 0 check. (Sashiko)
> - Rebase onto the latest drm-misc-next.
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

