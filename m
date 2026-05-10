Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F8DCD37B5
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 18:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B2110E228;
	Sun, 10 May 2026 18:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MwWskJBA";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1274710E13B
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1778437915;
 bh=LWC2Dyj1Ts06tYFJbPdEZrK3i8UqPILa8yBO4xt6oB4=;
 b=MwWskJBAIczJicajBTtTcQ0ulmNvXwnNjEH3T0Perj/B0n9BF7WX0ANZlGFobDFfZJW/Lmq4e
 sXU0C2JrNMWpv3ccLOnkSUCujRyguLu0lpX0z10CARoMQxd1eKrgj81Vk9DJWQ5ZOMBhqP5KjWF
 +W+2UrbNR6uOquDMfR64Avv5Ckgb9BKCXwk37ZVObazPghR11bhYwX8ROU3Xt3V2DIGqNOs1f+c
 6kS7kLEJ5evz6W38hpq+icJmS8+yOp7LGgrV2dRIeCssvCXQwFTwHDC4Mw88sQnpc6HbHkVUEo8
 hiUUr6u1c39vFOn3GBc3k+VmNQyiszq38Aerd68hCFdw==
X-Forward-Email-ID: 6a00cef861db3ab145b0f20b
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.8.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 00/10] drm/rockchip: dw_hdmi: Misc cleanup and propagate bus
 format
Date: Sun, 10 May 2026 18:31:01 +0000
Message-ID: <20260510183114.1248840-1-jonas@kwiboo.se>
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

This series include misc cleanup of the dwhdmi-rockchip driver and
prepares for future support of YCbCr output and Deep Color modes.

Patch 1-7 cleanup and changes to use drmres helpers for the encoder.
Patch 8 prepare for use of a display-connector bridge for RK3568/RK3566.
Patch 9-10 prepares for future support of YCbCr and Deep Color modes.

This series depends on the patch "drm/rockchip: dw_hdmi: avoid direct
dereference of phy->dev.of_node" [1] from the series "Split Generic PHY
consumer and provider API" [2].

[1] https://lore.kernel.org/linux-phy/20260505100523.1922388-16-vladimir.oltean@nxp.com/
[2] https://lore.kernel.org/linux-phy/20260505100523.1922388-1-vladimir.oltean@nxp.com/

This series is part of a multi series effort to:
- phy: rockchip: inno-hdmi: Change TMDS rate handling to configure() ops [v2]
- drm/rockchip: dw_hdmi: Misc cleanup and propagate bus format [v1]
- drm: bridge: dw_hdmi: Misc enable/disable, CEC and EDID cleanup [v5]
- drm/bridge: dw-hdmi: Improve input/output bus format handling
- drm/bridge: dw-hdmi: Convert to a HDMI bridge and use of bridge connector
- drm/bridge: dw-hdmi: Add and use tmds_char_rate_valid() plat data ops
- drm/meson: hdmi: Misc cleanup and use CEC notifier helpers
- drm/rockchip: dw_hdmi: Enable YCbCr and Deep Color modes
Link to snapshot: https://github.com/Kwiboo/linux-rockchip/commits/next-20260508-rk-hdmi-v3/

Jonas Karlman (10):
  drm/rockchip: dw_hdmi: Use of_device_get_match_data() to get match
    data
  drm/rockchip: dw_hdmi: Use local dev variable consistently in bind()
  drm/rockchip: dw_hdmi: Use drmres helpers for encoder resources
  drm/rockchip: dw_hdmi: Inline resource lookup into bind()
  drm/rockchip: dw_hdmi: Hold a reference to the dw-hdmi bridge
  drm/rockchip: dw_hdmi: Remove empty encoder helper funcs
  drm/rockchip: dw_hdmi: Clean up whitespace
  drm/rockchip: dw_hdmi: Set output_port for RK3568/RK3566
  drm/rockchip: dw_hdmi: Configure HDMI PHY in atomic_mode_set()
  drm/rockchip: dw_hdmi: Propagate bus format to display driver

 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 220 ++++++++++++--------
 1 file changed, 129 insertions(+), 91 deletions(-)

-- 
2.54.0

