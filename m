Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089BEC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 06:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CC110E070;
	Tue,  8 Sep 2026 06:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkGHIN+z";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B4BA10E070
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 06:27:36 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d6ff2f2c4eso4355825ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 23:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788848856; x=1789453656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Do+tyJs/In1J8gFUGP4c/jQC48P3JQhaviUTpiPjDi0=;
 b=hkGHIN+zYtrFXyWdbAHz05afzqJnrLQJt7QPrf1qfxQ3OTe8L3vZJyj/NgYYjzKnJi
 qaPT96/YymRZ7CmDUK3SgcUmNOp3MZYuX2RnEE1q6F+qS2wz5OOMzX4UafMCoBC0GP5Y
 zRrPdM4oabrEzxwzjfb+ASi+t++r4iwIajTczFGknjpNYISKz7T9yB0MYHN+7nTGEM5H
 OFKvidX5TsvEdO3+ioR/RQ4mrDkm1CzNm/h4zBrWZ9SLEjbdk7v1Y54PCZ+4o6UT0AvA
 oBnzge/3kDzOEckAfBkUcweL7pUBLui1miFRRwj9m/I1FdhYeUCgdEfhTCjkTCYI5kia
 APSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788848856; x=1789453656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Do+tyJs/In1J8gFUGP4c/jQC48P3JQhaviUTpiPjDi0=;
 b=TorOBRAngZygEeEWrBAICjdUs7Vt7ypfGNXjJzPiZzy4oxWSBQZzAZ7m35HHUKgbmb
 dqQ2yZ2Njk+YrJVbUhhX3peswytDt76cw+ZOy9Q/VaqTAekv8U8N+vZJZ3Jw+DDcNx9Y
 NXKGKTfxB5Qu5VktO5sYZWK0Q+KnR3XKjbPQqrvztkWiTiooQBk/POUbX5YfmRDPNiRu
 /FUaifi/kyFrdFi/4/LNOUSY3k8/GeSVfNkOh+tOPDDnI8sToo0lHeGQgFWyfJ5d9gEc
 IkvsQUvMPZ04jyg80yKcCup7t2Ma/AW8VYgqTK6dof6reu4Jw3WxER/Ey29h0rg913a0
 YFiw==
X-Gm-Message-State: AFuF++n3i+Zl0g86LRXaF4TP7sdANcrAUz2PB0YE5gVAzG1joP9YWKWA
 psDK8W/eVG7y8ZXKwuAftdDwBwSjG4E3MhHPMFGjYlAW7EBTWFKRG+KC
X-Gm-Gg: AYBFou0Ro9AuPUksfh6GusQIsLGjhr7QFXrCR1BvoMqgEaA5HtYY5LpOMYk1bgdhZlQ
 lWdbo7QiruxltCL6fWGPB9hEk5CrSLb74FLp/45GwOSBZLTvjdUjsVcpp5E9buyPmSx5PeJQBZc
 bB1mjX2dvSr5ixy9nuZY1Pgpz/RMiZWLyCPGCOMOLA385i6HLZG6cf6jYsw7/SoYBdKpRz6wxOz
 zddQncrKGr995+1pRGQZTZltDpUzZu1D9fiWquJwONBfaNo0gpylVMsqr7QAj6QCPaXw7JeiZou
 KsO/LdVtKBaygJ1mej6Xr7V8LyKWT5FcFhjL2FxWHEAtj4EGdu0+Rt8gx3NVMNpgEvuNzH/y2hc
 CSFJdbXHxqrrMNnegj4f8RcpYmLbuqK+u9r2Nwgnr0i2HHPdlAcj/TLXhBFKOvBe+HG/HmobT/e
 qMRi+vbXKCjt7kntvPHAl5+vowusrvWJU6ey3qnHj0HyIgw6AUyLeqVsMbFhvvFbveG3bzMWkfS
 /0=
X-Received: by 2002:a17:902:ced2:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2db2779b54fmr189996155ad.3.1788848853049; 
 Mon, 07 Sep 2026 23:27:33 -0700 (PDT)
Received: from fedora (45.62.127.193.16clouds.com. [45.62.127.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1497fbf8sm54701565ad.43.2026.09.07.23.27.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 23:27:32 -0700 (PDT)
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
Subject: [PATCH] drm/bridge: dw-hdmi-qp: Guard clear_audio_infoframe when PHY
 is down
Date: Tue,  8 Sep 2026 14:27:08 +0800
Message-ID: <20260908062708.39437-1-rmxpzlb@gmail.com>
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

