Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A4DF43844
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:30:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BA710E70A;
	Wed, 15 Apr 2026 15:30:07 +0000 (UTC)
X-Greylist: delayed 1549 seconds by postgrey-1.36 at gabe;
 Wed, 15 Apr 2026 15:30:07 UTC
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13E9010E70A
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:30:07 +0000 (UTC)
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.99) (envelope-from <daniel@makrotopia.org>)
 id 1wD1ms-000000002Nq-3tYX; Wed, 15 Apr 2026 15:04:19 +0000
Date: Wed, 15 Apr 2026 16:04:16 +0100
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
Subject: [PATCH 2/2] drm/mediatek: hdmi: report jack plugged state from
 bridge enable/disable
Message-ID: <c4d62fc2244fb72207855c5a366ff10fad419f2d.1776265222.git.daniel@makrotopia.org>
References: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3e22cbae528c9a38d854a586d1736b860998d41.1776265222.git.daniel@makrotopia.org>
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

Notify hdmi-codec of the current sink plugged state from
mtk_hdmi_bridge_atomic_enable() and mtk_hdmi_bridge_atomic_disable()
via mtk_hdmi_update_plugged_status(). This matches the pattern used
by dw-hdmi, which invokes handle_plugged_change() from the bridge
enable and disable paths so that ASoC jack state stays in sync with
the actual sink presence across atomic commit cycles, and not only
on CEC HPD transitions.

Userspace audio daemons (e.g. pipewire) rely on the jack state to
route streams, restore per-sink volume levels, and recover the last
used device after a reconnect. Without this, those transitions are
missed whenever the sink change is driven by a mode set rather than
by a bare HPD event.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 9050d7785f109..565bb72c9b63a 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1013,6 +1013,8 @@ static void mtk_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 	hdmi->curr_conn = NULL;
 
 	hdmi->enabled = false;
+
+	mtk_hdmi_update_plugged_status(hdmi);
 }
 
 static void mtk_hdmi_bridge_atomic_post_disable(struct drm_bridge *bridge,
@@ -1082,6 +1084,8 @@ static void mtk_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 	mtk_hdmi_clk_enable_audio(hdmi);
 
 	hdmi->enabled = true;
+
+	mtk_hdmi_update_plugged_status(hdmi);
 }
 
 static const struct drm_bridge_funcs mtk_hdmi_bridge_funcs = {
-- 
2.53.0
