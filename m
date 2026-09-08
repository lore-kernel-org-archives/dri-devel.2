Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C12C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F74910E095;
	Tue,  8 Sep 2026 07:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="blL82ncD";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0968310E03E
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:02:52 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d6ff3936easo693995ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788850971; x=1789455771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NELnY7rhvN2fX0w+mwkpJWMxqnyiES6ZAAlSHyGONzo=;
 b=blL82ncD7+OZW6ylfNcuUhfzLey9T42ac6hIOb8C7TJ53Cw3ep44iiOl9o1Bih1u+z
 q0klpiArlgPnRC6+2QcyUQjfD8NNb4OfH9flRhURvSX54S28Zde3RVuSvO659lDX0bt2
 Shp0fJ4obY1Xkqgu9PNFZYG9+hTJRcsGRZ2lCGzTN9cKXWzPN88jXs3M4a1CBj0038ES
 jFU2bm3ZHvBcDENcRXjiy3Vap/G5H4AGoPr3JOTMVn7A/Ts0rmSZaK6JykUd0OoSPt+w
 8HBrHLpF317pbpJLw4u/1TCPtqGS/IvqyI7sM8vXJym3WjYOgSsIAjeTAwalWsGK2Z/b
 1FLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788850971; x=1789455771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NELnY7rhvN2fX0w+mwkpJWMxqnyiES6ZAAlSHyGONzo=;
 b=A64FoqjlL9lrpETj8YSHjV4xWs9cSbuXnKUp4UwBgDoGtkb9f3DtpCgoMUPlDbjxSG
 1mGLG/JmcNHgtPKRvMQt7CrwD/5uSM0fj17kiHZWRHnLxxmlDwIh+uVtTPeiulwc1rgc
 nTOl8prqzTVuCbz3qXoiWB20HX0P5s8i1+Fal0JYGQ2fY5qs2+pYJkJLyPsVuQwQvdGa
 sgJjSEx6XMXwVaB4QUZ1amMlIx4tEw/Q+rlpIl/AYPuxLB4zXC9iKiuTm0ZHZCzkbS1b
 VFYccDHN+KUKE9GAEeZHGKH3Aw66IDXB7dupNNcVrsYQPyafqVC6K5QCflD+dRJPnCBh
 0o8Q==
X-Gm-Message-State: AFuF++nFarBFrDginpzuEm1jA3AqMiZ8UtUAl4AGmsFgtT5mja+Evxsz
 GpgjceJrFiX0zeAI8N7i23hAq+4HPzP8h20W0ngqNTjVnNxMIixl9usQ
X-Gm-Gg: AYBFou0GnPohyMTcV45KzcSl7YO15CwaI0n8TG0dPEHc32Pkg+vUILyRvCyLwc/z0OD
 WDx+KxYSHwQp7B92ELHpxTpl1x1oDtnBjo+OtsyYYX4VrD0tMD+voNzZa5aoTmT6q4EpLbSzxv/
 6qbbH60NqVH7dbLhgIvODOOK/v+7+cCwDGEdxSNoilVWEVVdz+q5t6gce0A+dEs+qBelC+9i1LU
 IBEJMOmsIRr3ZKKuE0Z8QRCqSlH1h77o13HL2AiR/mSGQUpRWCsbT9aaFtpS8cpFQtMin4CWx8l
 GFsriDLjUaaY18rBNRRqHC5WLuxil4A1HfmiCk029b24BBKCv3XwTZOJmZeKLySI/tWgzqtV+WN
 uCbF1ulwSTGoDE2sHPvZyYHj/bcVE0owWzx4ngPhP4QlFSZbnhMHs6sVouigFvPtvIrMxGkg8qX
 oJK95DmfPcq3+JH3MFqXBbcNOhMKYF8bNSKCcrnWarDIGLeExuwwdCWuh66+/NiTsT9/gS+7Gef
 NCm52TXefeYjQ==
X-Received: by 2002:a17:903:38cc:b0:2c7:ef84:c58e with SMTP id
 d9443c01a7336-2db276b8656mr203032685ad.1.1788850971418; 
 Tue, 08 Sep 2026 00:02:51 -0700 (PDT)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1483ea94sm54981615ad.9.2026.09.08.00.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:02:50 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: royalnet026@gmail.com, Laurent.pinchart@ideasonboard.com,
 airlied@gmail.com, andrzej.hajda@intel.com, luca.ceresoli@bootlin.com,
 cristian.ciocaltea@collabora.com, daniels@collabora.com,
 detlev.casanova@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 heiko@sntech.de, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, rfoss@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, sebastian.reichel@collabora.com,
 macromorgan@hotmail.com
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when
 PHY is down
Date: Tue,  8 Sep 2026 15:02:20 +0800
Message-ID: <20260908070220.41574-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The following panic was observed during system reboot:

Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 6 UID: 1000 PID: 2348 Comm: pipewire ... 7.0.5+ #4 PREEMPT(full)
Call trace:
 ...
 regmap_update_bits_base+0x70/0xa8
 dw_hdmi_qp_bridge_clear_audio_infoframe+0x3c/0x58 [dw_hdmi_qp]
 drm_bridge_connector_clear_audio_infoframe+0x2c/0x48 [drm_display_helper]
 ...
 dw_hdmi_qp_audio_disable+0x28/0xa8 [dw_hdmi_qp]
 drm_bridge_connector_audio_shutdown+0x38/0x68 [drm_display_helper]
 drm_connector_hdmi_audio_shutdown+0x28/0x40 [drm_display_helper]
 hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
 ...
 snd_pcm_release_substream+0xcc/0x120 [snd_pcm]
 snd_pcm_release+0x4c/0xc0 [snd_pcm]
 ...

The root cause is pipewire tries to close the HDMI audio device after
atomic_disable(), which sets tmds_char_rate to 0 and disables the PHY.

In this case, dw_hdmi_qp_audio_disable() will call
dw_hdmi_qp_bridge_clear_audio_infoframe(), accessing register without
checking tmds_char_rate.

Guard the register access in drm_display_helper callback function with
tmds_char_rate check.

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

---
Changes in v2:
- Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
  the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
- Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/

Changes in v3:
- Add a tmds_char_rate guard in clear_audio_infoframe path.
- Decouple write_audio_infoframe from clear_audio_infoframe.
- Balance the PKTSCHED_AMD_TX_EN bit enable/disable.
- Link to v2: https://lore.kernel.org/all/20260418101936.7731-1-rmxpzlb@gmail.com/

Changes in v4:
- Update panic stack on 7.0.5
- Link to v3: https://lore.kernel.org/all/20260423081514.15444-1-rmxpzlb@gmail.com/

Changes in v5:
- Reuse the origin dw_hdmi_qp_bridge_clear_audio_infoframe and add
  tmds_char_rate guard in new callback function.
- Link to v4: https://lore.kernel.org/all/20260512103153.8861-1-rmxpzlb@gmail.com/
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index 1c214a8e6dc2..8729783d4eb6 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -880,7 +880,7 @@ static int dw_hdmi_qp_bridge_clear_spd_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
-static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+static int __dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
@@ -893,6 +893,16 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 	return 0;
 }
 
+static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
+{
+	struct dw_hdmi_qp *hdmi = bridge->driver_private;
+
+	if (hdmi->tmds_char_rate > 0)
+		return __dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+
+	return 0;
+}
+
 static void dw_hdmi_qp_write_pkt(struct dw_hdmi_qp *hdmi, const u8 *buffer,
 				 size_t start, size_t len, unsigned int reg)
 {
@@ -987,7 +997,7 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+	__dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
 
 	/*
 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
-- 
2.55.0

