Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25D2CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 10:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2286610E58E;
	Tue, 12 May 2026 10:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N/KzhUOF";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF8C10EA05
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 10:32:20 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8368a5d79d3so372573b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 03:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778581940; x=1779186740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhehjUWhhndTO+aLTrKXJGjjblaTc3IzZAO9VvBbULE=;
 b=N/KzhUOFPUAOMG3YogdiP8wgdva2ztAQryuG0lDlpKjChcUeRXtHIs6+5/1fAMSpQK
 5oam1f6wtLTn9aOGUCgFYitjORfWywaYsktPAOv/J5WjQi4cL2sZsjcxXO9UFowtJVt3
 l3zOtDGsOKrFftqR8aFAsxUpIvCJndnjO7bUMR/F22ntkbkKuVS+H/9C5X6qYc/h1FWz
 DOdnSvZR2HUGFUkaT4W7u3A1jeHix9HjWaILZhG0wDTQ2dra+SgjLxZRxiOEVlN5b5eI
 4jKkc6bk256WJYraEL6FtYFoVUOm7ZmRkjMhOskxz+ICzWzsNewb/MX6OSpejgBrUYoo
 Rmww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778581940; x=1779186740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OhehjUWhhndTO+aLTrKXJGjjblaTc3IzZAO9VvBbULE=;
 b=BXJMOfwlRKuWIkI1Di4qOkxDRxM40Zxoe6XzolbxijnQWXp/CZf15KVF3YHF8ePjog
 7z0z8MS4EvUnKGPnAuQ/dq5SOZCgV8cGsONFanGYhw1IGvSLV7iBPp5fgjySHQKmYiEn
 Y9qSE49VHkxgpd4txOavCbBygEhINZnqd2SqnJu5suhI9p1QbEc1sKhav2lKoJflUcrY
 vvGbmzQkCKjZE9rxaMitn47nCJOud1z8XMU5ZzdgMiMN1NEpZN1uHnwLv0Qtsqq4EiMP
 pnrx+7D+WkPFWeaG4ojVWwcGOiRGezKPgQe/v36jNb+hpnofyYhNcA7swtQSOgsm4wKj
 8BXw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F2+l1F2qY4UfDJ2jcPBDLaJlZ3Rc7kUuyXGbSW9KP4bHSXODSlzVTMGV2oZKgDqYGLJkuVCceeos=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOef9UhD1/6W53xvNAutWK+iNRc4zmQo3a6HY9Uw4rWto1Xh8G
 zQy/6anzRFgPZm+mJfoU0MXRboRojIZAlGeHhwMyTy3+LRJnKlfswqYe
X-Gm-Gg: Acq92OE5HywM2g6b1wXYtdBTWArNrqmM4gDyYOSyVaVIvuDQZlyh+kXbW4+LSz7Fg98
 S2L0qNoK352wHtjaqojuc+RPqkptCDfAin7HTLY0LQ1biJVaWwva1z81Oht38rrvkY5DWsMkIvn
 6yA62i309CdlRZbWEgRvqz4SGvud0RE1/L/o5802hmZRD52yZJDEuZ8z1x7QVoCEQzQjJAvVn0L
 22H9ySMcRyXhK8Gwnmo4mitU6IcXCHwaD7szTJvEG+Y8bZtsBY65FPPOwgGM1HvEgVMxdXswazz
 7wcW6c3k2YTbQ1vz9i9dD2gPm5Jdu8SM8r13VFUhy8cMY5xvqtMdYwGnYfwm7qTOuhzKxnvm/pl
 6t8NHSivit52/p3SzApQcvIuBv0r+bLOixqjCOqaZAy+YAFUUB3n9u34zf0SaEyBCgMGR9cCDmV
 3SlQG9m7yOiD4OiwYSt2AhIqNw6sT40LUPWkm+Sa4amfPflv4Aaz0=
X-Received: by 2002:a05:6a00:4088:b0:835:36f2:7332 with SMTP id
 d2e1a72fcca58-83a5aaf7775mr15856894b3a.2.1778581939943; 
 Tue, 12 May 2026 03:32:19 -0700 (PDT)
Received: from fedora.izzigo.tv (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c8462sm23025473b3a.38.2026.05.12.03.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 03:32:19 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: detlev.casanova@collabora.com, cristian.ciocaltea@collabora.com,
 daniels@collabora.com, dmitry.baryshkov@oss.qualcomm.com, heiko@sntech.de,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v4] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when
 PHY is down
Date: Tue, 12 May 2026 18:31:53 +0800
Message-ID: <20260512103153.8861-1-rmxpzlb@gmail.com>
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

Add a tmds_char_rate guard in dw_hdmi_qp_bridge_clear_audio_infoframe().
Decouple write_audio_infoframe from clear_audio_infoframe to avoid the
redundant check in the write path.
Add PKTSCHED_AMD_TX_EN to the clear mask to keep the enable/disable
balance.

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
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index d649a1cf07f5..1c18f8650fcd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -886,11 +886,11 @@ static int dw_hdmi_qp_bridge_clear_audio_infoframe(struct drm_bridge *bridge)
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_mod(hdmi, 0,
-		       PKTSCHED_ACR_TX_EN |
-		       PKTSCHED_AUDS_TX_EN |
-		       PKTSCHED_AUDI_TX_EN,
-		       PKTSCHED_PKT_EN);
+	if (hdmi->tmds_char_rate)
+		dw_hdmi_qp_mod(hdmi, 0,
+			       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
+			       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
+			       PKTSCHED_PKT_EN);
 
 	return 0;
 }
@@ -989,7 +989,10 @@ static int dw_hdmi_qp_bridge_write_audio_infoframe(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = bridge->driver_private;
 
-	dw_hdmi_qp_bridge_clear_audio_infoframe(bridge);
+	dw_hdmi_qp_mod(hdmi, 0,
+		       PKTSCHED_ACR_TX_EN | PKTSCHED_AMD_TX_EN |
+		       PKTSCHED_AUDS_TX_EN | PKTSCHED_AUDI_TX_EN,
+		       PKTSCHED_PKT_EN);
 
 	/*
 	 * AUDI_CONTENTS0: { RSV, HB2, HB1, RSV }
-- 
2.54.0

