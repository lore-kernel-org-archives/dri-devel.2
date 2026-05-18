Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CF0CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 18:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C955110E99F;
	Mon, 18 May 2026 18:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="NvdKMoaW";
	dkim-atps=neutral
X-Greylist: delayed 632 seconds by postgrey-1.36 at gabe;
 Mon, 18 May 2026 18:12:52 UTC
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C9C10E994
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 18:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1779127967;
 bh=ucKXF6VzM30bPjxSkBsneInrw/BjvpOQxwAaTEJvKFc=;
 b=NvdKMoaWvkybl0PvuqMF+U4wbgNQWxnUM5CS1entxpZbB+c8tCA7Nd/jRnXF1VQSYgm0hLGxp
 AOv2YEMUWrmA9yc3jE/+jYfKVcHHSvhBrpmbWWd0sN/sd6KoLkk/VFtjui6uxcqa9SG3ln01gRM
 Fr7eG6h3by6dYO5ox2SFBv2G9RfPqe/IwkiECC2cuPR9nIyVvklgCfi74QCw7qHNTSbl2grRQZ3
 5CTPQMtplWtZpG94QsQ1p9e9irxS+06BiCGfsz6htv4lWVCAcAjbY0Sn/NfnSPCgoeGwHdWlzgn
 GeIr/uk8dEZ5IkDt3hD5cARGqQlDoXMjkiWYabnuAykg==
X-Forward-Email-ID: 6a0b5424b84dbc72d2274d94
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Liu Ying <victor.liu@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>,
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@kernel.org>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-sunxi@lists.linux.dev, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v7 00/23] drm: bridge: dw_hdmi: Misc enable/disable,
 CEC and EDID cleanup
Date: Mon, 18 May 2026 18:01:36 +0000
Message-ID: <20260518180206.2480119-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is a revival of an old dw-hdmi series and is the first series part
of a new effort to upstream old LibreELEC HDMI 2.0 patches for Rockchip
RK33xx devices.

This series ensure poweron/poweroff and CEC phys addr invalidation is
happening during normal DRM funcs, ensures EDID and CEC phys addr is
updated in detect() similar to how the bridge connector works with a
HDMI bridge attached, and also changes to debounce hotplug processing
to prevent a full disable/enable cycle during a HPD low voltage pulse.

After this series HPD, EDID and CEC handling should work very similar
regardless is the dw-hdmi connector or the bridge connector is used.
It should also help ensure a smoother transition when dw-hdmi is fully
converted into a HDMI bridge in a future series.

These changes have mainly been tested on Rockchip RK3328, RK3399 and
RK3568 devices using both the dw-hdmi connector and also using a basic
convert to use a bridge connector. The changes has also been tested on
Amlogic S905X, S905Y2 and A311D devices that uses the bridge connector.

Testing with a Rock Pi 4 (RK3399) using a Reaspberry Pi Monitor with
Linux kms client console using drm.debug=0xe should log something like
following:

 Power cycle monitor using the power button:
  [CONNECTOR:68:HDMI-A-1] CEA VCDB 0x4a
  [CONNECTOR:68:HDMI-A-1] HDMI: DVI dual 0, max TMDS clock 0 kHz
  [CONNECTOR:68:HDMI-A-1] ELD monitor RPI MON156
  [CONNECTOR:68:HDMI-A-1] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
  [CONNECTOR:68:HDMI-A-1] ELD size 36, SAD count 1
  [CONNECTOR:68:HDMI-A-1] Same epoch counter 10

 Cable unplugged:
  [CONNECTOR:68:HDMI-A-1] EDID changed, epoch counter 11
  [CONNECTOR:68:HDMI-A-1] status updated from connected to disconnected
  [CONNECTOR:68:HDMI-A-1] Changed epoch counter 10 => 12
  [CONNECTOR:68:HDMI-A-1] generating connector hotplug event
  [CONNECTOR:68:HDMI-A-1] Sent hotplug event

 Cable connected:
  [CONNECTOR:68:HDMI-A-1] CEA VCDB 0x4a
  [CONNECTOR:68:HDMI-A-1] HDMI: DVI dual 0, max TMDS clock 0 kHz
  [CONNECTOR:68:HDMI-A-1] ELD monitor RPI MON156
  [CONNECTOR:68:HDMI-A-1] HDMI: latency present 0 0, video latency 0 0, audio latency 0 0
  [CONNECTOR:68:HDMI-A-1] ELD size 36, SAD count 1
  [CONNECTOR:68:HDMI-A-1] status updated from disconnected to connected
  [CONNECTOR:68:HDMI-A-1] Changed epoch counter 12 => 13
  [CONNECTOR:68:HDMI-A-1] generating connector hotplug event
  [CONNECTOR:68:HDMI-A-1] Sent hotplug event

This series has evolved into an initial part of a larger multi series
effort to:
- drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID cleanup [v7]
- drm/bridge: dw-hdmi: Improve input/output bus format handling
- drm/bridge: dw-hdmi: Convert to a HDMI bridge and use of bridge connector
- drm/bridge: dw-hdmi: Add and use tmds_char_rate_valid() plat data ops
- drm/meson: hdmi: Misc cleanup and use CEC notifier helpers [v1]
- phy: rockchip: inno-hdmi: Change TMDS rate handling to configure() ops [v4]
- drm/rockchip: dw_hdmi: Misc cleanup and propagate bus format [v2]
- drm/rockchip: dw_hdmi: Enable YCbCr and Deep Color modes
Link to snapshot: https://github.com/Kwiboo/linux-rockchip/commits/next-20260518-rk-hdmi-v5/

Changes in v7:
- Add patch to fix use-after-free when CEC adapter is unregistered
- Only declare CEC notifier support when CEC device register succeeds
- Re-order patches to drop drm_edid_raw() use before exposing more usage
- Change to free irq before mute and clear using IH regs
- Rebased on next-20260518
Link to v6: https://lore.kernel.org/dri-devel/20260516183838.2024991-1-jonas@kwiboo.se/

Changes in v6:
- Update EDID and CEC phys addr in the bridge detect() func
- Add CEC notifier bridge op for the bridge connector
- Change back to disable_delayed_work_sync() in hpd disable ops,
  a possible deadlock is avoided by not using drm_bridge_hpd_notify()
- Drop use of a suspend helper now that hpd disable ops use sync() calls
- Ensure HPD interrupt is masked and IRQ handler is disabled early
  in dw_hdmi_remove() to prevent any irq re-arming of delayed work
- Update a few commit messages and cover letter
- Collect t-b tags
Link to v5: https://lore.kernel.org/dri-devel/20260510124111.1226584-1-jonas@kwiboo.se/

Changes in v5:
- Add patch that holds a bridge ref until connector cleanup, to fix
  a use-after-free issue during connector cleanup
- Add patch that unregister CEC notifier during connector cleanup
- Add patch that adds a common suspend helper
- Add patch that drops call to drm_bridge_hpd_notify()
- Collect r-b tag
- Rebased on next-20260508
Link to v4: https://lore.kernel.org/dri-devel/20260504191059.275928-1-jonas@kwiboo.se/

Changes in v4:
- Change to use generic CEC notifier helpers
- Disable/mask hpd_work until enable_hpd()/hpd_enable()
- Read connector status directly from HW regs in hpd_work
- Continued rework of HDP and RXSENSE interrupt handling
- Collect r-b tags
- Rebased on next-20260430
Link to v3: https://lore.kernel.org/dri-devel/20260403185303.80748-1-jonas@kwiboo.se/

Changes in v3:
- Rework EDID refresh handling to closer match bridge connector
- Use delayed work to debounce HPD processing
- Update commit messages
- Collect r-b tags
- Rebased on next-20260401
Link to v2: https://lore.kernel.org/dri-devel/20240908132823.3308029-1-jonas@kwiboo.se/

Changes in v2:
- Add patch to disable scrambler feature when not supported
- Add patch to only notify connected status on HPD interrupt
- Update commit messages
- Collect r-b tags
- Rebased on next-20240906
Link to v1: https://lore.kernel.org/dri-devel/20240611155108.1436502-1-jonas@kwiboo.se/

Jonas Karlman (23):
  drm: bridge: dw_hdmi: Disable scrambler feature when not supported
  drm: bridge: dw_hdmi: Only notify connected status on HPD interrupt
  drm: bridge: dw_hdmi: Free IRQ before CEC adapter is unregistered
  drm: bridge: dw_hdmi: Hold bridge ref until connector cleanup
  drm: bridge: dw_hdmi: Call poweron/poweroff from atomic enable/disable
  drm: bridge: dw_hdmi: Use passed mode instead of stored previous_mode
  drm: bridge: dw_hdmi: Fold poweron and setup functions
  drm: bridge: dw_hdmi: Remove previous_mode and mode_set
  drm: bridge: dw_hdmi: Unregister CEC notifier during connector cleanup
  drm: bridge: dw_hdmi: Invalidate CEC phys addr from connector detect
  drm: bridge: dw_hdmi: Remove cec_notifier_mutex
  drm: bridge: dw_hdmi: Extract dw_hdmi_connector_status_update()
  drm: bridge: dw_hdmi: Use dw_hdmi_connector_status_update()
  drm: bridge: dw_hdmi: Use display_info is_hdmi and has_audio
  drm: bridge: dw_hdmi: Use generic CEC notifier helpers
  drm: bridge: dw_hdmi: Update EDID and CEC phys addr in bridge detect()
  drm: bridge: dw_hdmi: Declare bridge CEC notifier support
  drm: bridge: dw_hdmi: Drop call to drm_bridge_hpd_notify()
  drm: bridge: dw_hdmi: Use delayed_work to debounce hotplug event
  drm: bridge: dw_hdmi: Rework HDP and RXSENSE interrupt handling
  drm: bridge: dw_hdmi: Remove the empty dw_hdmi_setup_rx_sense()
  drm: bridge: dw_hdmi: Remove the empty dw_hdmi_phy_update_hpd()
  drm: bridge: dw_hdmi: Merge top and bottom half IRQ handlers

 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |   1 -
 drivers/gpu/drm/bridge/synopsys/Kconfig       |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-cec.c |   1 +
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 502 +++++++-----------
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |   3 -
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |   2 -
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c        |   2 -
 include/drm/bridge/dw_hdmi.h                  |   6 -
 8 files changed, 192 insertions(+), 326 deletions(-)

-- 
2.54.0

