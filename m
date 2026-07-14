Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73F8C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 08:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8273A10F209;
	Thu, 16 Jul 2026 08:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tDQwRfer";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D2210E0CC
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 20:29:21 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493b7cd27c6so3439545e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784060960; x=1784665760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S9VYavqel088B9xNr5QJlq+pbjgeAsubCPGEUg3TC48=;
 b=tDQwRferATZIi+5VxJhXKQ6X2+PlEpRNHakWfsKeuG1Apgu8+gxMrvlx98BQhZU/yq
 NvSevTdoOqBNydkz+dx6bAShdVJ+FMPx3W0e0PS5GKJUe1BDxoI5GDoe5fGLSEKtlQUw
 2PH74aRoq+fFTm7KIdbSjWy//UTCmbgafDfkmJXb7kH3AtOf1j2M8uch8uWE3SH2DV2O
 uLZ8+ptLLyiGn26BYeL1wxCBze/QJZX7EntMhmWw9G88u17aaY8USSrhZoh1QiUId+9P
 HzabsHOPfXOWwk3wY/q4Jc9lz/Ncr9y/u8Mqylit1gjeKQ4HmJI3HRICpwhy0MpUX4kB
 MqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784060960; x=1784665760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S9VYavqel088B9xNr5QJlq+pbjgeAsubCPGEUg3TC48=;
 b=S8u+LqVktGNYRQqOCoxfPzMP7TKMYLxQMcKd+LZQ9US50I54yrzTRmU+eBjPRuMTla
 C3wAIH8lm0Ly5H+kxEfXoI2VcUCuwAXwTqa/ZnVHRBET3U0nk4ai5yvA1AjbMveOGfLY
 6RS1ZxKXMzjgd83I2bsEYQ2sn+2WSr1xGmArrz3kUUP5bMgPGHezKWzCBNCB5bjBYOd8
 zFxLlFFgpqKtqnOhoVJ+JrcrbKZlIbRk92KKODT+0TXltoxApbG9Y5wW4R4T+WqwF2qs
 iypgcxpQprsCPAYOWhkUaGLtH01LvWEHkUXHYrce1ppntIpej798ieELToKNiU/pdkZo
 4Pgw==
X-Gm-Message-State: AOJu0YwH44AQ0HJ1UAKZEOFV63rzNycc2co9tPCwAuswYk23bF7hF6Dp
 ZxJueaP1AFAb5903ExUc3JGJvss3nkr21P9hbdWQSgxfMXfcxvv13LSk
X-Gm-Gg: AfdE7cnHAQFzecG/iFg5ZHGTZd61nUOg98WLHuO/GVI9Y2/nME8jaMbWJhAyy9skfEa
 iRp0BJBlYdFI2C7mDmoDdtY7KJDZVJx8vQTKLw6jcBNZpaagqdaUUdk31kW8FvmkZbapTTnO6Ip
 QoIZAh7Uxlw2zWdwwkzsUDt6MqjbCZdw63iAwQpbMmn4xQs32c2OycFpHyp5aXsLFDx+Ekn4aJ4
 8i5WK/OxH1m7j2VRmj5zvvcspMmhF43xtLvhzh54UzeF3tcm6DJd++NAOWs7Cn1A9mGSWMEONbL
 VH7Lap8bNgG1YAgzFchp5iLGBB81/abrI0fLFYijgmkKMi67Up9KPWKVThNq+QSwXPvzo1TwPEE
 dlqQ7niYhb7tWCgBvksYvWVeYOa7hw1yb8NtrKzxGztKP1max7jV7GgG2THI0ec7XDL521UBBRc
 eIVjva2/ZTNqIvOTH1Ub93GWS+Yr4WwgZq5b5RvWp9zPmKjvhITI/sdMXB98PUStVFhfDmxjTKv
 KtQIe81hSUCH4gnvKEP0a5354wSvXbJ
X-Received: by 2002:a05:600c:c055:b0:490:b2f9:d9a4 with SMTP id
 5b1f17b1804b1-493f87dbb37mr64625065e9.1.1784060959738; 
 Tue, 14 Jul 2026 13:29:19 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B9381005FD9FCFE1353AFE2.dsl.pool.telekom.hu.
 [2001:4c4e:1b93:8100:5fd9:fcfe:1353:afe2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32c65asm98332125e9.14.2026.07.14.13.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 13:29:19 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH] drm/rockchip: dw_hdmi_qp: attach the HDMI Colorspace
 connector property
Date: Tue, 14 Jul 2026 22:28:50 +0200
Message-ID: <20260714202850.40999-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 08:19:15 +0000
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

The HDMI connector framework already consumes conn_state->colorspace
when generating the AVI infoframe (drm_hdmi_avi_infoframe_colorimetry()
in drm_hdmi_state_helper.c), and drmm_connector_hdmi_init() attaches
HDR_OUTPUT_METADATA and max bpc for this connector. The Colorspace
property itself, however, is never created, so userspace has no way to
request BT.2020 colorimetry and wide-gamut/HDR output stays effectively
unavailable on RK3588 even though the rest of the plumbing is in place.

Compositors gate HDR on this: KWin (Plasma 6.x) requires the Colorspace
property alongside HDR_OUTPUT_METADATA and max bpc before it reports an
output as HDR/wide-gamut capable, so the HDR toggle never appears.

Create and attach the standard HDMI colorspace property right after the
bridge connector is initialised. Passing 0 selects the full HDMI
colorspace set defined by the DRM core.

Tested on an Orange Pi 5 Plus (RK3588) with Plasma 6.6 on the Collabora
rockchip-v7.0 tree, which carries the same gap: with the property
attached, kscreen-doctor reports both HDMI outputs as HDR and
wide-color-gamut capable, KWin exposes the HDR toggle, the property
switches to BT2020_RGB at 10 bpc when enabled (verified with modetest),
and browsers report an HDR display so streaming services serve native
smpte2084/bt2020 content.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -603,6 +603,20 @@
 		return dev_err_probe(hdmi->dev, PTR_ERR(connector),
 				     "Failed to init bridge connector\n");
 
+	/*
+	 * Attach the HDMI Colorspace property. The HDMI connector framework
+	 * already consumes conn_state->colorspace for the AVI infoframe
+	 * (drm_hdmi_avi_infoframe_colorimetry()), and HDR_OUTPUT_METADATA and
+	 * max bpc are attached by drmm_connector_hdmi_init(), but without the
+	 * Colorspace property userspace cannot request BT.2020 signalling,
+	 * which keeps wide-gamut/HDR output unavailable. Passing 0 selects
+	 * the full HDMI colorspace set defined by the core.
+	 */
+	ret = drm_mode_create_hdmi_colorspace_property(connector, 0);
+	if (ret)
+		return ret;
+	drm_connector_attach_colorspace_property(connector);
+
 	return 0;
 }
 
