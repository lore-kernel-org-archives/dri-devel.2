Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439AEC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:31:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9883E10E2DB;
	Thu,  2 Jul 2026 15:31:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="cvm1LCN7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF2F10E0D8
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783006305;
 bh=Xkb+/mKuO1FEluXDb53rbD4MmvYJ3E7jzptvbsHL/pQ=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
 b=cvm1LCN7RuPw3sJrteqJx3uGAWr6BhN2gttVW/sftjQ4oiBobOuexhzVh4drzhMyC
 sak2w+1IziYBSEsvudn0MMaKORc9Hql1TbzMMW9O9nZ3U2ECyUj+P6ZjWg0XN7gX3N
 otaMlSV06slH5L8HdKMkgZnzmxEbCJYyIuKgtuw8geVVATc0MxpUmVSKbTgN3kGWvB
 mB95T6Grbv3SYUBmUSei+ayV6vSDorGyvAV0I4LTHGPZhkUWk3ykFimlpImNQmYVM+
 28IUkrhUvDardCFp6tEnxiguChLEaAkhGuKM0fzV3T+e+oR+1siNhFGfII+SmMJc8a
 VcugSiSx4XJVQ==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3449B17E0180;
 Thu,  2 Jul 2026 17:31:44 +0200 (CEST)
Message-ID: <27c0c573-dd0e-49fb-ba40-3a314a8783b3@collabora.com>
Date: Thu, 2 Jul 2026 18:31:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/39] Add HDMI 2.0 support to DW HDMI QP TX
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
Content-Language: en-US
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

I've just realized I missed updating the part of the cover letter that 
describes the patch structure. Please find the corrected content below.

Regards,
Cristian

On 7/2/26 5:46 PM, Cristian Ciocaltea wrote:
> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) on the Synopsys DW HDMI QP
> TX controller, as found in Rockchip RK3576 & RK3588 SoCs, by adding SCDC
> management for high TMDS clock ratio and scrambling.
Since SCDC state is lost on sink disconnects, the bridge driver needs to
trigger a CRTC reset during connector detection.  To support this, the
series first introduces the HDMI version enum and the caps-based HDMI
connector init helper (patches 1-3), then builds the connector and
bridge scrambling infrastructure on top of it - the connector scrambler
support, the scdc-helper additions (connector-prefixed debug macro and
SCDC version helper), and the HDMI scrambling management helpers
including SCDC source-version advertisement (patches 4-8).

It then wires this up through the hdmi-state-helper and bridge connector
layers: fallback TMDS rate validation, hotplug SCDC state sync and the
scrambling requirement (patches 9-11), a bridge cleanup and the new
source-side scrambling bridge ops (patches 12-13), the switch to a
cached-status, atomic-aware .detect_ctx() connector helper (patches
14-15), and finally hooking up the HDMI 2.0 scrambler callbacks (patch
16).

The SCDC scrambling feature itself is implemented in the DW HDMI QP
bridge driver, alongside i2c error-message rate limiting,
.enable_hpd()/.disable_hpd() PHY ops and a dw_hdmi_qp_hpd_notify()
helper (patches 17-20).

Patches 21-28 cover the Rockchip platform driver and HPD handling: minor
cleanups (newlines in dev_err_probe(), consistent local dev variable,
dropping an unnecessary include), deferring HPD IRQ enable until after
connector setup, masking the RK3576 HPD IRQ in io_init, implementing the
.{enable|disable}_hpd() PHY ops, switching HPD reports to
dw_hdmi_qp_hpd_notify() to restrict events to the affected connector,
and dropping the now-unused .setup_hpd() PHY op.

Patches 29-31 convert vc4 HDMI to the common infrastructure as a proof
of reuse: adopting the shared TMDS char rate constants, switching to
drm_hdmi_mode_needs_scrambling(), and replacing the driver-local
scrambling implementation with the common SCDC scrambling helpers.

Patches 32-39 add KUnit tests: HDMI caps-based init coverage and
source-side scrambler validation for the connector, conversion of
hdmi_state_helper to drmm_connector_hdmi_init_with_caps() with
max_tmds_char_rate fallback tests, a new 4K@60Hz 600MHz TMDS EDID,
source-side scrambling decision coverage, and conformity fixes for the
existing 1080p+4K YUV420 200MHz and 4K RGB/YUV 340MHz test EDID blobs.

> 
> This has been tested on the following boards:
> 
> * Radxa ROCK 5B (RK3588)
> * Radxa ROCK 4D (RK3576)
> * Raspberry Pi 5 Model B Rev 1.1 (BCM2712 D0)
> 
> Note that commit d87773de9efe1 ("clocksource/drivers/arm_arch_timer:
> Default to EL2 virtual timer when running VHE"), introduced in v7.2-rc1,
> causes Raspberry Pi 5 to hang during boot.  Reverting the commit
> restores normal boot.  This issue has already been reported in [1];
> alternatively, the workaround proposed in [2] can be applied.
> 
> Regards,
> Cristian
> 
> [1] https://lore.kernel.org/all/ea15cce1-b393-43f6-8d58-3d6f90f0c0cd@samsung.com/
> [2] https://lore.kernel.org/all/20260619204832.586079-1-dan@reactivated.net/
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v8:
> - Added an enum hdmi_version under video/hdmi to describe the HDMI
>   specification version a source/sink supports (new patch 1)
> - Introduced HDMI connector capabilities API and reworked the
>   infrastructure patches on top of it: drmm_connector_hdmi_init() now
>   takes a drm_connector_hdmi_caps struct that carries supported_formats,
>   max_bpc, supported_hdmi_ver and max_tmds_char_rate (new patches 2-3)
> - Moved all the new SCDC helpers covering both source and sink to
>   display/drm_hdmi_helper.c
> - Renamed drm_scdc_{start,stop}_scrambling() to
>   drm_connector_hdmi_{enable,disable}_scrambling() and added a
>   connector-state argument so the scrambler_needed flag is checked
>   centrally instead of in every driver
> - Renamed drm_scdc_sync_status() to drm_connector_hdmi_sync_scdc(),
>   aligned its lifecycle with vc4_hdmi_reset_link(), and removed the
>   internal drm_scdc_reset_crtc() helper; it now also gates on CRTC state
>   and an in-flight commit (Maxime)
> - Changed the prototype of drm_atomic_helper_connector_hdmi_hotplug() to
>   take an acquire context and an int return, instead of adding a new
>   _ctx variant (Maxime)
> - Added drm_hdmi_mode_needs_scrambling() to centralise the above-340 MHz
>   decision (new patch 7)
> - Made SCDC source version negotiation optional and moved it to a
>   dedicated patch "drm/display: hdmi: Advertise SCDC source version when
>   scrambling" (new patch 8), backed by a new
>   drm_scdc_set_source_version() helper in "drm/display: scdc-helper: Add
>   helper to set SCDC version information" (new patch 6)
> - Added a fallback TMDS rate validation patch using the connector-level
>   max_tmds_char_rate when the driver provides no .tmds_char_rate_valid()
>   hook (new patch 9)
> - Split scrambler_needed flag handling into its own hdmi-state-helper
>   dedicate change (new patch 11)
> - VC4:
>   * Replaced vc4_hdmi_mode_needs_scrambling() with
>     drm_hdmi_mode_needs_scrambling() (new patch 30)
>   * Restored drm_dev_{enter,exit}() pairing around the converted
>     scrambling paths
>   * Removed now unused output_{bpc,color_format} fields from vc4_hdmi as
>     part of the SCDC conversion
> - KUnit:
>   * Covered the caps-based connector init path: NULL caps, inferred
>     max_tmds_char_rate per supported_hdmi_ver, and override validation
>     (new patch 32)
>   * Switched drm_hdmi_state_helper_test to the caps-based init helper
>     and exposed it through
>     drm_kunit_helper_connector_hdmi_init_with_caps_edid_funcs() (new
>     patch 34)
>   * Added max_tmds_char_rate fallback coverage in
>     drm_hdmi_state_helper_test (new patch 35)
> - Rebased onto latest drm-misc-next and dropped the already applied
>   "drm/fb-helper: Remove unused local variable in hotplug_event()" patch
> - Link to v7: https://patch.msgid.link/20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com

[...]
