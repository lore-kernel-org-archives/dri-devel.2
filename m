Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C9EF9934F
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D004A10EFA6;
	Thu, 23 Apr 2026 08:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OweLFKKB";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D297E10EFA6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:15:32 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-35448ca4689so1144037a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 01:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776932132; x=1777536932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hAlmZfpdk3Iz3porN4R6dSq4Ld5esbkgYHoF3QfFzLg=;
 b=OweLFKKBNQJ8iZRbltb6dPiAkNtH/MfIMBDuR9lcmEezOjke+p1WGQ/ZJUQPyq4K5q
 xIjIx+RkJEJBCCdE2kggPX6/xtwTE1n7bEBqzz4icNPUi5BdowYl2DHEeBpER98jZkLw
 GSEKvyy/9zG1Do//2l1B7jgH31smHeOAfbcACzz/sxMAPlqRXxFTI95O8SG8HOP39Sna
 6ZdSPuS55PDOemf9zhkpn4XQU0Ng+SejCoNzKoMKOY9bcINnHwCSdUGSRFgPQ01Z2XKx
 S9atAa/ssPrp1wJBGL+K+W2KFvwnMQ1Je4eLj2yczfvPNK4U117Tqsnx9t/gvuKLDVqn
 go1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776932132; x=1777536932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hAlmZfpdk3Iz3porN4R6dSq4Ld5esbkgYHoF3QfFzLg=;
 b=oDG26F2c+Glex276VOSxsVgRuhd+fWnBwsZgDKeaooV2o6Zql7SEubEVhvNBs4ZdrC
 RiGzUNnmCInJc0bdTC6SKRaJTydJWCHuR11eOJvP6u18OJI9LDVjNMXPAMTFv9+SpxS7
 QbZiwLiUXU06M25Hk3O54WFwhRv/DL3Ay2ZvTHmWSzLyZ5OIeO2j2TAXcJqdbMzqlS4q
 N3r8n5OSLzGdFIPnXK7JTrhPFP2D4o7YLrBsGPvdEBM5zM2Jouf/8GZopwk36QePh4Wf
 yE68BbLd7i6rSn1GDucZrxLgJ/qOAgGdKn43fO1CyBUScZxg09sblb6O8RootycDkZQq
 uJrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VtYnZYPJg8fvrjqaDFdXtLsvJJrOuvAM7AplOyn0xfi9LCTA1SuEY6Bd3CNSsEXqlRkrzDIhlF/I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzl8DejCx5u8mm0WjgjeHigignF0OFR2PpC5uLh++Vt6uikN9l0
 cS7jbOdyZCGi/DT+qkDfEnOj443IdF9b5Gczl1YQuQopSmtdS9Z0Imqg
X-Gm-Gg: AeBDieuO5Q3dSM7A2X9M5bUJz2dwQygp/dtKH+iIeV6BHeUsaKzSlty4bK8JL5ooWIg
 r89MaRKx+l923vIzYpSe5vMQRFwCrdNzRQhjDt1kFZ5wCHwqpBDfwsyO7KyDK5MUQiLRyU2JHT3
 pjplatL5HYfgfU8PrAftft5/XCOYweMW65swyYE6cFQpEAagOulEMcx6aagxn4djO2J9T4zBL4e
 itfNSKn2d0SZtkqh15XravPRLRHfP14UpwCgQrKg+k8HlZHXo+4ONnainJrl6JjFfbkPF8caA86
 sYduZRQJSlpUuFh5eP8LSSi4z1DiNQO/rUUOfiX6sEdwG3NGxta9ThDvRqqtxlDPAPXCvtpEor7
 +Ilfl15mpdwLq0NJ3/cmuZEXWeK4iLNacD/GPEQP7kJXsxUgjED4buva2azDhiDKH/BfdwEUJYY
 nqCCdH+tW/+jgmxE98buUOC9FgQN3qRt8j57DxdDZm+gqayEwR2gBC8Wn7KbxuNQ==
X-Received: by 2002:a17:90a:ec87:b0:362:bc7c:55cf with SMTP id
 98e67ed59e1d1-362bc7c5d34mr5499791a91.8.1776932132310; 
 Thu, 23 Apr 2026 01:15:32 -0700 (PDT)
Received: from fedora.izzigo.tv (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361418c3944sm24091557a91.8.2026.04.23.01.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 01:15:31 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: detlev.casanova@collabora.com, cristian.ciocaltea@collabora.com,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when
 PHY is down
Date: Thu, 23 Apr 2026 16:15:14 +0800
Message-ID: <20260423081514.15444-1-rmxpzlb@gmail.com>
X-Mailer: git-send-email 2.53.0
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
CPU: 7 UID: 1000 PID: 2637 Comm: pipewire ... 6.19.10-300.fc44.aarch64
Call trace:
 ...
 regmap_update_bits_base+0x5c/0x90
 dw_hdmi_qp_bridge_clear_infoframe+0xb0/0x120 [dw_hdmi_qp]
 drm_bridge_connector_clear_infoframe+0x28/0x48 [drm_display_helper]
 ...
 dw_hdmi_qp_audio_disable+0x24/0xb8 [dw_hdmi_qp]
 drm_bridge_connector_audio_shutdown+0x30/0x60 [drm_display_helper]
 drm_connector_hdmi_audio_shutdown+0x24/0x38 [drm_display_helper]
 hdmi_codec_shutdown+0x60/0x90 [snd_soc_hdmi_codec]
 ...
 snd_pcm_release_substream.part.0+0x44/0xd8 [snd_pcm]
 snd_pcm_release+0x60/0xe8 [snd_pcm]
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
2.53.0

