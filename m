Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1783CCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4884310E284;
	Mon, 18 May 2026 19:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0XVCWhMF";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD2210E336
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1779133675;
 bh=mc7nblQbAWFFELQ9xDqrj2Jacy9OF+Rdr+ldOYLP6HQ=;
 b=0XVCWhMFCDjOpV7kzJNDepiBQLXiVOIZOMOLOqKw6QcLcXv1GqMjpx08l49d1DVo314GYCKCz
 XOWr8A+165fbuAndy5rbPM/1ZXtFfRHXbtmf3bfBsiNEwf313cRvG+RC/oAj5AMaD3XmjZxSETN
 nsJpATE9SRwMguPiQrNXMnN71DdkD03I15Yzo6nKMmsDgmJP39XiNWe8hSPwMaGupCvuKT4Q1dR
 z4lvbxcDn2mScB8Utu7Ha/lDUaJcB0B2RB/BoOy7XXIH1ZRIB81OKqs3MUAJEwynXbTSWNcyLY2
 UtAfuS4O0czjMwGNkm4DO7lwP34SKVqJDrJg7YvVojMA==
X-Forward-Email-ID: 6a0b6ce8b74b0ebd362eee05
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
 linux-rockchip@lists.infradead.org
Subject: [PATCH 00/13] drm/meson: dw-hdmi: Misc cleanup and use CEC notifier
 helpers
Date: Mon, 18 May 2026 19:47:28 +0000
Message-ID: <20260518194744.2483580-1-jonas@kwiboo.se>
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

This series include misc cleanup of the meson-dw-hdmi driver, changes to
use the bridge CEC notifier op and to use the dw-hdmi delayed work for
HPD event handling.

Patch 1 ensure connector status is based on HPD bit
Patch 2 protect from a possible NULL pointer dereference during bind()
Patch 4 reduce number of hotplug uevents and hpd_notify() calls
Patch 6 changes to use bridge connector CEC notifier
Patch 3,5,7-10 cleanup code for consistency
Patch 11-12 changes to use dw-hdmi HPD delayed work at HPD event
Patch 13 changes to use suspend_late/resume_early/resume_noirq pm ops

This series depends on improvements made in the series "drm: bridge:
dw_hdmi: Misc enable/disable, CEC and EDID cleanup" [1].

[1] https://patchwork.freedesktop.org/series/134727/

This series is part of a multi series effort to:
- drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID cleanup [v7]
- drm/meson: hdmi: Misc cleanup and use CEC notifier helpers [v1]
- drm/bridge: dw-hdmi: Improve input/output bus format handling
- drm/bridge: dw-hdmi: Convert to a HDMI bridge and use of bridge connector
- drm/bridge: dw-hdmi: Add and use tmds_char_rate_valid() plat data ops
- phy: rockchip: inno-hdmi: Change TMDS rate handling to configure() ops [v4]
- drm/rockchip: dw_hdmi: Misc cleanup and propagate bus format [v2]
- drm/rockchip: dw_hdmi: Enable YCbCr and Deep Color modes
Link to snapshot: https://github.com/Kwiboo/linux-rockchip/commits/next-20260518-rk-hdmi-v5/

Jonas Karlman (13):
  drm/meson: dw-hdmi: Report connector status based on HPD bit
  drm/meson: dw-hdmi: Protect from possible NULL pointer dereference
  drm/meson: dw-hdmi: Call dw_hdmi_remove() consistently
  drm/meson: dw-hdmi: Drop call to drm_bridge_hpd_notify()
  drm/meson: encoder_hdmi: Use CEC phys addr from display_info
  drm/meson: encoder_hdmi: Use bridge connector CEC notifier
  drm/meson: encoder_hdmi: Report ycbcr_420_allowed from encoder
  drm/meson: dw-hdmi: Use local dev variable consistently in bind()
  drm/meson: dw-hdmi: Use devm_clk_get_enabled() helper
  drm/meson: dw-hdmi: Use dev_err_probe() to report errors
  drm/bridge: dw-hdmi: Export dw_hdmi_schedule_hpd_work() helper
  drm/meson: dw-hdmi: Use dw_hdmi_schedule_hpd_work() helper
  drm/meson: dw-hdmi: Use suspend_late/resume_early/resume_noirq pm ops

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c  |  11 +-
 drivers/gpu/drm/meson/Kconfig              |   1 +
 drivers/gpu/drm/meson/meson_dw_hdmi.c      | 169 +++++++++------------
 drivers/gpu/drm/meson/meson_dw_hdmi.h      |   3 +
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 107 +++----------
 include/drm/bridge/dw_hdmi.h               |   2 +
 6 files changed, 106 insertions(+), 187 deletions(-)

-- 
2.54.0

