Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B2FC54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E6010E687;
	Thu, 30 Jul 2026 09:52:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="AbWeVh0o";
	dkim-atps=neutral
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com
 [91.218.175.189])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C4E710E687
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:52:13 +0000 (UTC)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
 s=key1; t=1785405128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/CmSwuO/xupe6Pcb1zBeEMRLQgCWuK+nk+HP+mUfoDk=;
 b=AbWeVh0oLNvyriTyELmYKHT3dK1LkGtmZoW9MzlVwDzNJQ3whYVgR2MqtgCaxn5VQrWTuS
 iU6RRA7OukPMmmiXJZuPB0Q+CUccFBJZRsgkfUdsMSpgadJxwZMmmpMJI1EzHIFuP8y71n
 JSNt4Gq561I86BldRp5B+n2fYeIKN92ZnUdsHlNCRWvyDKE16zeB1aw2+9Un5w5vn+9WDk
 LAP+HhCozgc1v8xuVSAcSUKeAZNdI3lAAgMi1ncE+PdgJXkp/OV+t0ZxOaStGIruHHRJY4
 ZDMJmdxbcL20v1n75pEwuvODPbq1J1RoR4tz4G8vuXnCaCzaTnjuK49snJUicA==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Jul 2026 11:52:00 +0200
Message-Id: <DKBTALC5PUJ3.2KU1C4MRVBQNT@cknow-tech.com>
Subject: Re: [PATCH v9 00/61] Add HDMI 2.0 support to DW HDMI QP TX
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Chen-Yu Tsai"
 <wens@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Dave Stevenson"
 <dave.stevenson@raspberrypi.com>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>, "Raspberry Pi Kernel Maintenance"
 <kernel-list@raspberrypi.com>, "Sandy Huang" <hjc@rock-chips.com>,
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "Andy Yan"
 <andy.yan@rock-chips.com>, "Algea Cao" <algea.cao@rock-chips.com>, "Daniel
 Stone" <daniels@collabora.com>, "Liu Ying" <victor.liu@nxp.com>, "Phong LE"
 <ple@baylibre.com>
Cc: <kernel@collabora.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
 "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Maud Spierings"
 <maud_spierings@hotmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>,
 "Sashiko" <sashiko-bot@kernel.org>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
X-Migadu-Flow: FLOW_OUT
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

Hi Cristian,

On Thu Jul 23, 2026 at 3:34 AM CEST, Cristian Ciocaltea wrote:
> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) on the Synopsys DW HDMI QP
> TX controller, as found in Rockchip RK3576 & RK3588 SoCs, by adding SCDC
> management for high TMDS clock ratio and scrambling.  Since SCDC state
> is lost on sink disconnects, the bridge driver needs to trigger a CRTC
> reset during connector detection.

I tested the v1 series when it consisted of a 'bit' less patches, so I
figured I'd test it again with v9.
I first ran ``modetest`` with a 7.2-rc5 kernel without this patch set:

```sh
diederik@nanopc-t6-lts:~$ uname -a
Linux nanopc-t6-lts 7.2-rc5-arm64-cknow #1 SMP PREEMPT Debian 7.2~rc5-1 (20=
26-07-27) aarch64 GNU/Linux
diederik@nanopc-t6-lts:~$ modetest | grep -A 14 modes
id      encoder status          name            size (mm)       modes   enc=
oders
86      85      connected       HDMI-A-1        1600x900                37 =
     85
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 4096x2160 30.00 4096 4184 4272 4400 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #1 4096x2160 29.97 4096 4184 4272 4400 2160 2168 2178 2250 296703 flags: =
phsync, pvsync; type: driver
  #2 4096x2160 25.00 4096 5064 5152 5280 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #3 4096x2160 24.00 4096 5116 5204 5500 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #4 4096x2160 23.98 4096 5116 5204 5500 2160 2168 2178 2250 296703 flags: =
phsync, pvsync; type: driver
  #5 3840x2160 30.00 3840 4016 4104 4400 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #6 3840x2160 29.97 3840 4016 4104 4400 2160 2168 2178 2250 296703 flags: =
phsync, pvsync; type: driver
  #7 3840x2160 25.00 3840 4896 4984 5280 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #8 3840x2160 24.00 3840 5116 5204 5500 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #9 3840x2160 23.98 3840 5116 5204 5500 2160 2168 2178 2250 296703 flags: =
phsync, pvsync; type: driver
  #10 2560x1440 59.95 2560 2608 2640 2720 1440 1443 1448 1481 241500 flags:=
 phsync, pvsync; type: driver
  #11 1920x1080 120.00 1920 2008 2052 2200 1080 1084 1089 1125 297000 flags=
: phsync, pvsync; type: driver
  #12 1920x1080 119.88 1920 2008 2052 2200 1080 1084 1089 1125 296703 flags=
: phsync, pvsync; type: driver
```

and then again with a recent drm-next + this patch set added:

```sh
diederik@nanopc-t6-lts:~$ uname -a
Linux nanopc-t6-lts 7.2-rc5+unreleased-arm64-cknow #1 SMP PREEMPT Debian 7.=
2~rc5-2 (2026-07-28) aarch64 GNU/Linux
diederik@nanopc-t6-lts:~$ modetest | grep -A 20 modes
id      encoder status          name            size (mm)       modes   enc=
oders
86      85      connected       HDMI-A-1        1600x900                43 =
     85
  modes:
        index name refresh (Hz) hdisp hss hse htot vdisp vss vse vtot
  #0 3840x2160 60.00 3840 4016 4104 4400 2160 2168 2178 2250 594000 flags: =
phsync, pvsync; type: preferred, driver
  #1 4096x2160 60.00 4096 4184 4272 4400 2160 2168 2178 2250 594000 flags: =
phsync, pvsync; type: driver
  #2 4096x2160 59.94 4096 4184 4272 4400 2160 2168 2178 2250 593407 flags: =
phsync, pvsync; type: driver
  #3 4096x2160 50.00 4096 5064 5152 5280 2160 2168 2178 2250 594000 flags: =
phsync, pvsync; type: driver
  #4 4096x2160 30.00 4096 4184 4272 4400 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #5 4096x2160 29.97 4096 4184 4272 4400 2160 2168 2178 2250 296703 flags: =
phsync, pvsync; type: driver
  #6 4096x2160 25.00 4096 5064 5152 5280 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #7 4096x2160 24.00 4096 5116 5204 5500 2160 2168 2178 2250 297000 flags: =
phsync, pvsync; type: driver
  #8 4096x2160 23.98 4096 5116 5204 5500 2160 2168 2178 2250 296703 flags: =
phsync, pvsync; type: driver
  #9 3840x2160 59.94 3840 4016 4104 4400 2160 2168 2178 2250 593407 flags: =
phsync, pvsync; type: driver
  #10 3840x2160 50.00 3840 4896 4984 5280 2160 2168 2178 2250 594000 flags:=
 phsync, pvsync; type: driver
  #11 3840x2160 30.00 3840 4016 4104 4400 2160 2168 2178 2250 297000 flags:=
 phsync, pvsync; type: driver
  #12 3840x2160 29.97 3840 4016 4104 4400 2160 2168 2178 2250 296703 flags:=
 phsync, pvsync; type: driver
  #13 3840x2160 25.00 3840 4896 4984 5280 2160 2168 2178 2250 297000 flags:=
 phsync, pvsync; type: driver
  #14 3840x2160 24.00 3840 5116 5204 5500 2160 2168 2178 2250 297000 flags:=
 phsync, pvsync; type: driver
  #15 3840x2160 23.98 3840 5116 5204 5500 2160 2168 2178 2250 296703 flags:=
 phsync, pvsync; type: driver
  #16 2560x1440 59.95 2560 2608 2640 2720 1440 1443 1448 1481 241500 flags:=
 phsync, pvsync; type: driver
  #17 1920x1080 120.00 1920 2008 2052 2200 1080 1084 1089 1125 297000 flags=
: phsync, pvsync; type: driver
  #18 1920x1080 119.88 1920 2008 2052 2200 1080 1084 1089 1125 296703 flags=
: phsync, pvsync; type: driver
```

I also unplugged and replugged the HDMI cable several times, both on the
NanoPC-T6 LTS side as well as my 4K HDMI 2.0 capable TV and the display
came back every time in the same 'mode'.

I then repeated the same test procedure with a Rock 5B and the results
were identical :-)

So feel free to add/update to the Rockchip related patches

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Roc=
k 5B

Cheers,
  Diederik

> To support this at the DRM infrastructure level, the series first
> introduces the HDMI version enum, then prepares for changing the
> signature of drmm_connector_hdmi_init(), i.e. dropping the vendor,
> product, supported_formats and max_bpc arguments, which are being moved
> into struct drm_connector_hdmi_funcs, by temporarily renaming the helper
> to drmm_connector_hdmi_ini2().  This lets the new signature be
> introduced under the original name while callers are converted
> incrementally.  Note the transitional name matches the original's length
> so continuation-line arguments stay aligned to the opening parenthesis,
> keeping the diff to the identifier itself and avoiding re-alignment
> churn.
>
> Appending more HDMI-specific arguments to the init function would not
> scale well, hence the hdmi_funcs struct is extended with new fields:
> supported_hdmi_ver, supported_tmds_char_rate.  These are used to
> infer and/or limit the maximum TMDS character rate permitted for the
> connector.
>
> Patches 5-10 build the connector and bridge scrambling infrastructure on
> top: the connector scrambler callbacks/flags, the scdc-helper
> additions (connector-prefixed debug macro and SCDC version helper), and
> the HDMI scrambling management helpers including SCDC source-version
> advertisement.
>
> Patches 11-18 wires this up through the hdmi-state-helper and bridge
> connector layers: source TMDS rate validation, hotplug SCDC state sync
> and the scrambling requirement, new source-side scrambling bridge ops,
> the switch to a cached-status, atomic-aware .detect_ctx() connector
> helper, and finally hooking up the HDMI 2.0 scrambler callbacks.
>
> The SCDC scrambling feature itself is implemented in the DW HDMI QP
> bridge driver, alongside i2c error-message rate limiting,
> .enable_hpd()/.disable_hpd() PHY ops and a dw_hdmi_qp_hpd_notify()
> helper (patches 19-23).
>
> Patches 24-32 cover the Rockchip platform driver and HPD handling: minor
> cleanups (newlines in dev_err_probe(), consistent local dev variable,
> dropping unnecessary include/define), avoiding spurious HDP IRQ wakeups,
> masking the RK3576 HPD IRQ in io_init, implementing the
> .{enable|disable}_hpd() PHY ops, switching HPD reports to
> dw_hdmi_qp_hpd_notify() to restrict events to the affected connector,
> and dropping the now-unused .setup_hpd() PHY op.
>
> Patches 34-39 convert VC4 HDMI to the common infrastructure as a proof
> of reuse: adopting the shared TMDS char rate constants, switching to
> drm_hdmi_mode_needs_scrambling(), proper -EDEADLK handling, and
> replacing the driver-local scrambling implementation with the common
> SCDC scrambling helpers.
>
> Patches 40-47 advertise supported version for all HDMI
> connectors/bridges, except the MediaTek HDMI driver (for now), as it
> requires non-trivial changes: there's a core library shared between two
> drivers, one being HDMI 2.0 compliant.
>
> Patches 48-57 add KUnit tests: HDMI caps-based init coverage and
> source-side scrambler validation for the connector, conversion of
> hdmi_state_helper to the new drmm_connector_hdmi_init() with
> max_tmds_char_rate validation, a new 4K@60Hz 600MHz TMDS EDID,
> source-side scrambling decision coverage, and conformity fixes for the
> existing 1080p+4K YUV420 200MHz and 4K RGB/YUV 340MHz test EDID blobs.
>
> Eventually patches 58-61 remove the now unused
> drmm_connector_hdmi_ini2() helper and drop redundant hdmi fields from
> connector structs: vendor, product, supported_formats and max_bpc.
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
> [1] https://lore.kernel.org/all/ea15cce1-b393-43f6-8d58-3d6f90f0c0cd@sams=
ung.com/
> [2] https://lore.kernel.org/all/20260619204832.586079-1-dan@reactivated.n=
et/
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
> Changes in v9:
> - Collected A-b, R-b, T-b tags from Dmitry, Maxime, Maud
> - Dropped misleading "HDMI_VERSION_UNKNOWN means legacy/default
>   behaviour" from drm_connector_hdmi_caps.supported_hdmi_ver
>   documentation
> - Warned in drm_bridge_add() if an HDMI bridge leaves supported_hdmi_ver
>   unset
> - Added max_tmds_char_rate to drm_bridge struct and wire it through
>   drm_bridge_connector_init() along with supported_hdmi_ver
> - Got rid of connector's scrambler_supported flag and, instead, relied
>   on checking the presence of scrambler callbacks via a new
>   drm_connector_hdmi_scrambler_supported() helper (Dmitry)
> - Dropped HDMI connector scdc_cb callback and introduced
>   scdc_work_initialized flag to perform lazy initialization and guard
>   the teardown paths against touching an uninitialized work item
> - Unconditionally checked connector->hdmi.max_tmds_char_rate in
>   "drm/display: hdmi-state-helper: Add fallback TMDS rate validation"
>   and performed s/fallback/source/ in commit subject & description
>   (Maxime)
> - Added a TODO comment for checking
>   drm_display_info.hdmi.scdc.scrambling.low_rates in "drm/display:
>   hdmi-state-helper: Set HDMI scrambling requirement" patch (Maxime)
> - Moved the prototype changes from "drm/display: hdmi-state-helper: Sync
>   SCDC state on hotplug" into a dedicated "drm/display:
>   hdmi-state-helper: Pass acquire ctx to hotplug helpers" patch; also
>   switched ctx and status args ordering, for consistency with
>   detect_ctx() signature (Maxime)
> - Ensured HDMI connector's SCDC delayed work is explicitly canceled
>   during connector cleanup (Sashiko)
> - Fixed a potential NULL pointer dereference in
>   drm_connector_hdmi_enable_scrambling() and
>   drm_connector_hdmi_sync_scdc() helpers caused by forcing an EDID
>   advertising SCDC on a connector that physically lacks an I2C DDC bus
>   (Sashiko)
> - dw-hdmi-qp
>   * Fixed a potential NULL pointer dereference in
>     dw_hdmi_qp_hpd_notify() helper by using a local variable to cache
>     the connector pointer (Sashiko)
>   * Ensured hdmi->phy.ops->disable() is not skipped in
>     dw_hdmi_qp_bridge_atomic_disable() by accessing the connector via
>     drm_atomic_get_old_connector_for_encoder() instead of
>     hdmi->curr_conn (Sashiko)
>   * Mitigated a potential use-after-free reported by Sashiko caused when
>     HPD interrupt fires after the DRM device is torn down; reworked
>     "Defer HPD IRQ enable until after connector setup" into:
>     * Factor out HPD interrupt mask/unmask helpers
>     * Control the HPD IRQ line via the bridge HPD ops
>   * Added new patch addressing another Sashiko finding: drm/rockchip:
>     dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups
>   * Added new patch: drm/bridge: dw-hdmi-qp: Remove unused workqueue
>     include and define
>   * Dropped .hdmi_tmds_char_rate_valid() usage from the
>     bridge/synopsys/dw-hdmi-qp.c scrambling support patch, while
>     advertising HDMI 1.4 capability for no-hpd configurations
> - VC4
>   * Passed ctx instead of NULL when calling
>     drm_atomic_helper_connector_hdmi_hotplug() from
>     vc4_hdmi_handle_hotplug() in the helper preparatory patch
>   * Aligned with the expected detect_ctx() semantics in a dedicated
>     "drm/vc4: hdmi: Propagate -EDEADLK to the top level" rather than
>     bundled in the conversion patch
>   * Optimized diff around drm_dev_enter() in the conversion patch
>     (Maxime)
>   * Simplified vc4_hdmi_connector_clock_valid() logic by deferring max
>     clock validation to HDMI helpers (new patch)
> - Migrated to a funcs-based HDMI connector init API - new patches:
>   * drm/display: hdmi: Rename drmm_connector_hdmi_init() to *_ini2()
>   * drm/display: bridge_connector: Convert to drmm_connector_hdmi_init()
>   * drm/vc4: hdmi: Convert to drmm_connector_hdmi_init()
>   * drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure
>   * drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()
>   * drm/tests: connector: Convert to drmm_connector_hdmi_init()
>   * drm/tests: hdmi_state_helper: Convert to drmm_connector_hdmi_init()
>   * drm/bridge: adv7511: Advertise HDMI 1.2 capabilities
>   * drm/bridge: inno-hdmi: Advertise HDMI 1.2 capabilities
>   * drm/bridge: ite-it6263: Drop redundant .mode_valid hook
>   * drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities
>   * drm/bridge: ite-it66121: Advertise HDMI 1.2 capabilities
>   * drm/bridge: lontium-lt9611: Advertise HDMI 1.4 capabilities
>   * drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities
>   * drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()
>   * drm/connector: Remove drmm_connector_hdmi_ini2()
>   * drm/connector: Drop redundant hdmi vendor/product fields
>   * drm/connector: Drop redundant hdmi supported_formats field
>   * drm/connector: Drop redundant max_bpc field
> - KUnit
>   * Adapted hdmi_state_helper scrambler tests and reworked a couple of
>     max_tmds_char_rate tests according to the latest DRM core changes
>   * Fixed a regression in the HDMI caps-based init coverage
>   * Fix a couple of bisectability issues, also implied partial commit
>     reorder
>   * Set supported HDMI version for the test bridges (new patch)
> - Rebased series onto latest drm-misc-next and removed "drm/rockchip:
>   dw_hdmi_qp: Drop unnecessary #include" patch, since a similar change
>   as been already applied
> - Link to v8: https://patch.msgid.link/20260702-dw-hdmi-qp-scramb-v8-0-d7=
9890d00b6a@collabora.com
>
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
> - Link to v7: https://patch.msgid.link/20260602-dw-hdmi-qp-scramb-v7-0-44=
5eb54ee1ed@collabora.com
>
> Changes in v7:
> - Split the scrambler_needed flag computation from the SCDC scrambling
>   helpers into a standalone hdmi_state_helper patch for clarity (new
>   patch 6)
> - Added vc4 HDMI conversion to common TMDS char rate constants and SCDC
>   scrambling helpers as a proof of reuse (new patches 24-25)
> - Added KUnit tests for connector scrambler_supported/callback
>   consistency validation (new patch 26)
> - Added 4K@60Hz 600MHz TMDS test EDID for high-rate scrambling coverage
>   (new patch 27)
> - Added KUnit tests for hdmi_state_helper scrambler_needed flag:
>   low-rate, high-rate, and source-no-support cases (new patch 28)
> - Fixed EDID conformity issues (edid-decode v1.33.0 failures) in the
>   existing 1080p+4K YUV420 200MHz and 4K RGB/YUV 340MHz test EDIDs
>   without changing the capabilities used by existing tests (new patches
>   29-30)
> - Rebased onto latest drm-misc-next
> - Link to v6: https://patch.msgid.link/20260520-dw-hdmi-qp-scramb-v6-0-24=
b74603b782@collabora.com
>
> Changes in v6:
> - Collected R-b & A-b tags from Dmitry and Heiko
> - Restructured the series from 10 into 22 patches, splitting the SCDC
>   scrambling helpers, connector infrastructure, bridge operations,
>   bridge_connector plumbing, dw-hdmi-qp implementation, and Rockchip
>   platform changes into distinct commits
> - Added drm_scdc_dbg() macro to simplify debug messages (new patch)
> - Added drm_scdc_start/stop/sync_status() helpers for full scrambling
>   lifecycle management (reworked from v5 patch 5)
> - Added drm_atomic_helper_connector_hdmi_hotplug_ctx() to propagate
>   modeset acquire context for SCDC sync on hotplug (new patch)
> - Added connector scrambler callbacks and SCDC work/flag infrastructure
>   as a separate patch (split from v5 patch 5)
> - Added DRM_BRIDGE_OP_HDMI_SCRAMBLER bridge operation with
>   hdmi_scrambler_enable/disable callbacks (new patch)
> - Implemented bridge_connector scrambler interface wiring (new patch)
> - Added .enable_hpd()/.disable_hpd() PHY ops for dw-hdmi-qp bridge and
>   Rockchip platform drivers, replacing the obsolete .setup_hpd() op
> - Added dw_hdmi_qp_hpd_notify() helper for targeted connector-only HPD
>   notification (split from v5 patch 10)
> - Dropped drm_fb_helper_hotplug_event() unused variable (new cleanup)
> - Dropped unused drm_simple_kms_helper.h include (new cleanup)
> - Masked RK3576 HPD IRQ in io_init() for consistency with RK3588
> - Rebased onto latest drm-misc-next
> - Link to v5: https://patch.msgid.link/20260426-dw-hdmi-qp-scramb-v5-0-d7=
78e70c317b@collabora.com
>
> Changes in v5:
> - Added new patches: 1/10, 3/10, 6/10, 7/10, 8/10
> - Removed redundant no-op error check in drm_bridge_helper_reset_crtc()
>   (patch 1)
> - Removed the EDEADLK retry loop from the bridge .detect_ctx() callback,
>   as that's already handled in the drm_bridge_detect_ctx() helper or by
>   the caller when ctx is provided (patch 2)
> - Refactored drm_bridge_detect() to delegate to drm_bridge_detect_ctx()
>   and added a WARN_ON for unexpected negative return values (patch 2)
> - Split the bridge-connector .detect_ctx() switch into a preparatory
>   patch to use cached connector status in .get_modes() (patch 3)
> - Improved error handling in SCDC scrambling setup: roll back high TMDS
>   clock ratio on scrambling failure, reset scramb_enabled flag on
>   set_scramb failure, and add SCDC version read/write error checks
>   (patch 5)
> - Annotated scramb_enabled with READ_ONCE/WRITE_ONCE for cross-context
>   access between modeset paths and the scrambling work item (patch 5)
> - Renamed SCDC_MIN_SOURCE_VERSION to SCDC_MAX_SOURCE_VERSION (patch 5)
> - Rate limited i2c error messages (patch 6)
> - Added missing newlines in dev_err_probe() messages (patch 7)
> - Replaced indirect device pointer accesses with local dev variable in
>   bind() (patch 8)
> - Split the HPD connector restriction (formerly patch 4/4): register HPD
>   IRQ after connector setup first (patch 9), then restrict HPD event to
>   the affected connector (patch 10); also collected R-b from Heiko
> - Rebased onto latest drm-misc-next
> - Link to v4: https://lore.kernel.org/r/20260303-dw-hdmi-qp-scramb-v4-0-3=
17d3b8bd219@collabora.com
>
> Changes in v4:
> - Fixed conflicts while rebasing onto latest drm-misc-next
> - Link to v3: https://lore.kernel.org/r/20260119-dw-hdmi-qp-scramb-v3-0-b=
d8611730fc1@collabora.com
>
> Changes in v3:
> - Used drm_bridge_helper_reset_crtc() helper to reset the display
>   pipeline and got rid of some boilerplate code (Maxime)
> - Rebased onto latest drm-misc-next
> - Link to v2: https://lore.kernel.org/r/20260113-dw-hdmi-qp-scramb-v2-0-a=
e7b2c58d24d@collabora.com
>
> Changes in v2:
> - Collected Tested-by tags from Diederik and Maud
> - Rebased onto latest drm-misc-next
> - Ensured the recently introduced 'no-hpd' support for dealing with
>   unconnected/repurposed/broken HPD pin is limited to HDMI 1.4 rates
> - Link to v1: https://lore.kernel.org/r/20251203-dw-hdmi-qp-scramb-v1-0-8=
36fe7401a69@collabora.com
>
> ---
> Cristian Ciocaltea (61):
>       video/hdmi: Introduce HDMI version enum
>       drm/display: hdmi: Rename drmm_connector_hdmi_init() to *_ini2()
>       drm/connector: Add drmm_connector_hdmi_init() with new signature
>       drm/display: bridge_connector: Convert to drmm_connector_hdmi_init(=
)
>       drm/connector: Add HDMI 2.0 scrambler infrastructure
>       drm/display: scdc-helper: Add macro for connector-prefixed debug me=
ssages
>       drm/display: scdc-helper: Add helper to set SCDC version informatio=
n
>       drm/display: hdmi: Add HDMI 2.0 scrambling management helpers
>       drm/display: hdmi: Advertise SCDC source version when scrambling
>       drm/bridge: Remove redundant error check in drm_bridge_helper_reset=
_crtc()
>       drm/bridge: Add bridge ops for source-side HDMI 2.0 scrambling
>       drm/display: bridge_connector: Use cached connector status in .get_=
modes()
>       drm/display: bridge_connector: Switch to .detect_ctx() connector he=
lper
>       drm/display: bridge_connector: Wire up HDMI 2.0 scrambler callbacks
>       drm/display: hdmi-state-helper: Add source TMDS rate validation
>       drm/display: hdmi-state-helper: Pass acquire ctx to hotplug helpers
>       drm/display: hdmi-state-helper: Sync SCDC state on hotplug
>       drm/display: hdmi-state-helper: Set HDMI scrambling requirement
>       drm/bridge: dw-hdmi-qp: Rate limit i2c read error messages
>       drm/bridge: dw-hdmi-qp: Provide .{enable,disable}_hpd() PHY ops
>       drm/bridge: dw-hdmi-qp: Remove unused workqueue include and define
>       drm/bridge: dw-hdmi-qp: Add HDMI 2.0 scrambling support
>       drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper
>       drm/rockchip: dw_hdmi_qp: Fix NULL deref in PM ops on incomplete bi=
nd
>       drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() m=
essages
>       drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bi=
nd()
>       drm/rockchip: dw_hdmi_qp: Avoid spurious HPD IRQ thread wakeups
>       drm/rockchip: dw_hdmi_qp: Mask RK3576 HPD IRQ in io_init
>       drm/rockchip: dw_hdmi_qp: Implement .{enable,disable}_hpd() PHY ops
>       drm/rockchip: dw_hdmi_qp: Factor out HPD interrupt (un)mask helpers
>       drm/rockchip: dw_hdmi_qp: Control the HPD IRQ line via the bridge H=
PD ops
>       drm/rockchip: dw_hdmi_qp: Use dw_hdmi_qp_hpd_notify() for HPD repor=
ts
>       drm/bridge: dw-hdmi-qp: Drop unused .setup_hpd() phy op
>       drm/vc4: hdmi: Use common TMDS char rate constants
>       drm/vc4: hdmi: Switch to drm_hdmi_mode_needs_scrambling()
>       drm/vc4: hdmi: Propagate -EDEADLK to the top level
>       drm/vc4: hdmi: Convert to drmm_connector_hdmi_init()
>       drm/vc4: hdmi: Convert to common HDMI 2.0 scrambling infrastructure
>       drm/vc4: hdmi: Defer pixel clock validation to HDMI helpers
>       drm/bridge: adv7511: Advertise HDMI 1.2 capabilities
>       drm/bridge: inno-hdmi: Advertise HDMI 1.2 capabilities
>       drm/bridge: ite-it6263: Drop redundant .mode_valid hook
>       drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities
>       drm/bridge: ite-it66121: Advertise HDMI 1.2 capabilities
>       drm/bridge: lontium-lt9611: Advertise HDMI 1.4 capabilities
>       drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4 capabilities
>       drm/sun4i: hdmi: Convert to drmm_connector_hdmi_init()
>       drm/tests: edid: Add 4K@60Hz EDID with 600MHz TMDS
>       drm/tests: edid: Fix conformity for 1080p+4K YUV420 200MHz EDID
>       drm/tests: edid: Fix conformity for 4K RGB/YUV 340MHz EDID
>       drm/tests: bridge: Set supported HDMI version
>       drm/tests: connector: Convert to drmm_connector_hdmi_init()
>       drm/tests: connector: Add HDMI max_tmds_char_rate init coverage
>       drm/tests: connector: Add HDMI source-side scrambler coverage
>       drm/tests: hdmi_state_helper: Convert to drmm_connector_hdmi_init()
>       drm/tests: hdmi_state_helper: Add connector-provided max_tmds_char_=
rate coverage
>       drm/tests: hdmi_state_helper: Cover source-side scrambling decision
>       drm/connector: Remove drmm_connector_hdmi_ini2()
>       drm/connector: Drop redundant hdmi vendor/product fields
>       drm/connector: Drop redundant hdmi supported_formats field
>       drm/connector: Drop redundant max_bpc field
>
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c       |  22 +-
>  drivers/gpu/drm/bridge/inno-hdmi.c                 |   1 +
>  drivers/gpu/drm/bridge/ite-it6263.c                |  33 +-
>  drivers/gpu/drm/bridge/ite-it66121.c               |  13 +-
>  drivers/gpu/drm/bridge/lontium-lt9611.c            |  16 +-
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       | 124 ++++-
>  drivers/gpu/drm/display/drm_bridge_connector.c     | 158 ++++--
>  drivers/gpu/drm/display/drm_hdmi_helper.c          | 288 ++++++++++
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  73 ++-
>  drivers/gpu/drm/display/drm_scdc_helper.c          |  70 ++-
>  drivers/gpu/drm/drm_bridge.c                       |   6 +-
>  drivers/gpu/drm/drm_bridge_helper.c                |   2 -
>  drivers/gpu/drm/drm_connector.c                    |  90 +++-
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     | 191 ++++---
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c             |   2 +
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  14 +-
>  drivers/gpu/drm/tests/drm_bridge_test.c            |   2 +
>  drivers/gpu/drm/tests/drm_connector_test.c         | 517 ++++++++++++---=
---
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 595 +++++++++++++++=
------
>  drivers/gpu/drm/tests/drm_kunit_edid.c             | 251 +++++++--
>  drivers/gpu/drm/tests/drm_kunit_edid.h             |   1 +
>  drivers/gpu/drm/vc4/vc4_hdmi.c                     | 355 +++---------
>  drivers/gpu/drm/vc4/vc4_hdmi.h                     |  30 +-
>  include/drm/bridge/dw_hdmi_qp.h                    |   4 +-
>  include/drm/display/drm_hdmi_helper.h              |  15 +
>  include/drm/display/drm_hdmi_state_helper.h        |   6 +-
>  include/drm/display/drm_scdc_helper.h              |   2 +
>  include/drm/drm_bridge.h                           |  49 ++
>  include/drm/drm_connector.h                        | 161 +++++-
>  include/linux/hdmi.h                               |  12 +
>  30 files changed, 2109 insertions(+), 994 deletions(-)
> ---
> base-commit: 9c99e09777509d9bd8cabb0c1132c981b4e668e2
> change-id: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

