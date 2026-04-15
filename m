Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EC5F43844
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E948010E70F;
	Wed, 15 Apr 2026 15:30:10 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6FA10E70F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:30:08 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wD1mk-000000002Nj-3q51; Wed, 15 Apr 2026 15:04:11 +0000
Date: Wed, 15 Apr 2026 16:04:08 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Junzhi Zhao <junzhi.zhao@mediatek.com>,
 Jie Qiu <jie.qiu@mediatek.com>, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] drm/mediatek: hdmi: pulse audio clocks on bridge enable
Message-ID: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The CLK_MM_HDMI_AUDIO and CLK_MM_HDMI_SPDIF mmsys gates feed the
HDMI TX internal audio measurement block which derives CTS values
for the ACR packets embedded in the TMDS stream. These clocks are
enabled once at driver probe time and then left untouched across
bridge atomic_enable / atomic_disable cycles.

On every observed stale-state event -- a blank/unblank cycle, or
a cold boot with the monitor off followed by a later hotplug --
the measurement block remains armed against the previous state
and fails to latch a valid CTS on the subsequent bridge enable.
Video recovers cleanly but the audio data islands never regain
lock and the HDMI sink sees no audio, even though the ASoC stack,
the AFE, and the HDMI TX audio packetizer are all programmed
correctly.

Debugging the issue of audio no longer working after vblank it was
found that an unbind+bind of the mediatek-drm-hdmi platform driver
recovers audio in all such scenarios without disturbing video.
The only audio-relevant side effect of that rebind is an off->on edge
on CLK_MM_HDMI_AUDIO / CLK_MM_HDMI_SPDIF via the probe path. Pulsing
those two clocks directly at the end of mtk_hdmi_bridge_atomic_enable
reproduces that recovery on every enable and doesn't hurt on the
first enable after boot.

Fixes: 8f83f26891e1 ("drm/mediatek: Add HDMI support")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 1ea2598547800..9050d7785f109 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1065,6 +1065,22 @@ static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 	phy_power_on(hdmi->phy);
 	mtk_hdmi_send_infoframe(hdmi, &hdmi->mode);
 
+	/*
+	 * Pulse the HDMI TX audio clocks off/on on every bridge enable.
+	 * The CLK_MM_HDMI_AUDIO and CLK_MM_HDMI_SPDIF mmsys gates feed
+	 * the HDMI TX internal audio measurement block that derives CTS
+	 * for the ACR packets embedded in the TMDS stream. Without an
+	 * off->on edge at bridge enable the block can stay armed against
+	 * stale state from a previous enable (e.g. after blank/unblank,
+	 * or after a monitor that was off at boot is plugged in later)
+	 * and fails to latch a valid CTS, leaving the audio path silent
+	 * even though video recovers. The pulse is what an unbind+bind
+	 * of the HDMI platform driver effectively does, and it recovers
+	 * audio in all observed stale-state scenarios.
+	 */
+	mtk_hdmi_clk_disable_audio(hdmi);
+	mtk_hdmi_clk_enable_audio(hdmi);
+
 	hdmi->enabled = true;
 }
 
-- 
2.53.0
