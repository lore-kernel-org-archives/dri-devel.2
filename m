Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5B5F99C7D
	for <dri-devel@archiver.kernel.org>; Sat, 18 Apr 2026 10:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE1DD10E323;
	Sat, 18 Apr 2026 10:20:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jSTnOyW9";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C7E10E0B9
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 10:20:00 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2a8720818aeso2430945ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Apr 2026 03:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776507599; x=1777112399; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xqAYAaB98xsAiWaW3K7BAxJ1Wdz7VTsIiYzGAY8PX4g=;
 b=jSTnOyW9TrgTP62xLY4ZysYU4FqrgdT192/bYldjjJJMdf21j6vDquVIy1u7YuP3Vx
 NfqJoMka/kYzjPOqqiy0JyOXzcop0QQ8S1CfutwMZOcrbX3lqyMbWa+5WglK4lRPlAvp
 M2tFr0HV8zvMAe7uw1+a9tQtp+7OVXjBzvwN5DbilKhz9RfZIAQ0IMvbH0CiOJ3DrJ9Y
 oHwybX9BvYjh+21PEu16+kylOprY1iJnqer93sWjVIYswloqZQeXvqMjhGjRx4pw1TvU
 MaaZWq0GlFklut41SJGH6fz8GUf0N2EcegxboThLVE5h5gDKTgZsB1yhAE0VhjLORUHp
 m43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776507600; x=1777112400;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqAYAaB98xsAiWaW3K7BAxJ1Wdz7VTsIiYzGAY8PX4g=;
 b=hmPISiTSt0xUXXVvpolhqlhuySgS9L82OJ/hP/sA64lMyyJMpv4U6FdvfPDmIJcqHT
 JBnzM5vS1dQYoO2RRWRCyll55zlbzuI+BBKdzgXcPER4dInG/vnSkcmqoU6u3HLdGKqE
 LgohXMuoviVOJQT/hHPvHcSI5/Iih+m6eZVMe9rn31zaUqBe1SlGcykfT6I6fHdUW8zy
 Va4SoHPa8D3ouuNqUFWuBjtTTTaOMI6DCgYDaRfrtwM1C/5bs90/DSO0wvq0OI+pdMpb
 LrDGPCGIou40Iobdk/9LUsVIWHRxnr0lPIifpTS/u4rDWB20LFvYHdbzEuBI5CVncji4
 aG0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WMA7MB1GBhucCvjOJnJO18QFiscELzFSPsKGMASO1766AevUdxIEpsVpRbu5vdubh4M9wcKQ9ZGQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTPh8ekyEAZ5WyTN22rBKwfZj7DWWv3TooAGhW1Oz/MgxRSSe1
 rIEVnhif4VVBE8JJ9Wfm4tlnzaU93/nuXlsA5mTBWcyHJ76xr7lmwjy8
X-Gm-Gg: AeBDiesAITfQOCCu722jGjS5E1+YP0E4DT3hZGH4eAzh+SvfLbsDzJurTFrr5z1c7Ie
 E4Mp0Kys8Rw94GOoOQp6wuEDQ7HbjN70J4WzUfn6L7HJRByJBNfaZRk0dJ9TdkYnK/vHKpU3506
 XiGO015K4pdyuWs0NrztX0aO+Ya5NAGhuAh3wtM5osad2HG3F8uMjHtE9hA/BEZJ9ED1JlIX3eI
 ropQxkgAjDtnCHTZvoL/yMk38Kt6M1WWlo0r9Py7IpQkYc/bfg9vsmygDhSlXeAH6+ODcO3RQlW
 4PCjipeTU7xzs7W+M8s9R7oxK6H6c91XwtO/qx9FvVCrrcZDsiJGO2d5LN+glLLVi4Y/Yn5qJUF
 3UwZIe5TbKw109z+PWSNEtRs9PdBwY9YqiPl8m5wOyvbZ0aLDc18Je5RHIDiwve+KeVTV/QGPa0
 Od6dwbmkanDTiamuCTH8RkUFYiqxg7YGAIG2KSES+M9tv4Ye7DgP2k8ZRatikveg==
X-Received: by 2002:a17:903:907:b0:2b2:eb6b:72f2 with SMTP id
 d9443c01a7336-2b5f9fff1e5mr33840955ad.7.1776507599529; 
 Sat, 18 Apr 2026 03:19:59 -0700 (PDT)
Received: from fedora.izzigo.tv (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff39csm46674525ad.4.2026.04.18.03.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 03:19:58 -0700 (PDT)
From: Frank Zhang <rmxpzlb@gmail.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: detlev.casanova@collabora.com, cristian.ciocaltea@collabora.com,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when
 PHY is down
Date: Sat, 18 Apr 2026 18:19:36 +0800
Message-ID: <20260418101936.7731-1-rmxpzlb@gmail.com>
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
atomic_disable(), which sets tmds_char_rate to 0 and disable the PHY.

In this case, dw_hdmi_qp_audio_disable() will call
drm_atomic_helper_connector_hdmi_clear_audio_infoframe() directly,
accessing registers without checking tmds_char_rate.

Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside the
if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().

Fixes: fd0141d1a8a2 ("drm/bridge: synopsys: Add audio support for dw-hdmi-qp")
Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>

---
Changes in v2:
- Move drm_atomic_helper_connector_hdmi_clear_audio_infoframe() inside
  the if (hdmi->tmds_char_rate) of dw_hdmi_qp_audio_disable().
- Link to v1: https://lore.kernel.org/all/20260416093150.13853-1-rmxpzlb@gmail.com/

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index d649a1cf07f5..7760527484c8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -526,10 +526,10 @@ static void dw_hdmi_qp_audio_disable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
 
-	drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
-
-	if (hdmi->tmds_char_rate)
+	if (hdmi->tmds_char_rate) {
+		drm_atomic_helper_connector_hdmi_clear_audio_infoframe(connector);
 		dw_hdmi_qp_audio_disable_regs(hdmi);
+	}
 }
 
 static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
-- 
2.53.0

