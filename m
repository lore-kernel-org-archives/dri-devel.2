Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B26BC61DD7
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E49F010F373;
	Fri, 28 Aug 2026 12:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="p3R1HTjC";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9DE10F373
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 12:10:48 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso6060355e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 05:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787919047; x=1788523847;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l/wCsFq/Zorgy/BqKS/v6a3TdSdfv1vfVKndsRYo1PM=;
 b=p3R1HTjCd1DPlqbT13DsmdWDoDHgLPleaJ5mGE9MPKVfoKmdVaA0IjpgST1a7XbECI
 2oRAvNmIQFNcC2vkIS2dTtQWC46piHSHjorBfDBX2AZiFd6l754IWMr5hyRTgqK94OM+
 x7UZL1uTx+M91CgacFlzkMdvs3lrgQYGx2DJ5tv5MXbM2Ed6V/Yxz9jOqUFtY80FXr9G
 9m3WK7Bz2LM1WH4divbGTfahDaDVk0rLXFM/lR/xrW4iiWbsd4M26DVo9berHbTFAe4W
 vRQbose/ddozIIXcEy09kTM/HNh9V95OagWhrCqoBAMC47Rs6+z1B/jz7vZtB+I7Xufz
 zXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787919047; x=1788523847;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l/wCsFq/Zorgy/BqKS/v6a3TdSdfv1vfVKndsRYo1PM=;
 b=QzhAWxebNI49saq8/gkHPozTJdXL72fVg49bNOuTWyyJ2G0SxCuMkmgMzwmnF0hIgO
 AeH9UXsjpkkXJizb4qjS3f2T6P1X37tZVQxDldb7eUNJgjZsFzFjWwMDQ3GEzgXozmGg
 NSnlDfVceX4es7iC81CEoU5rr882mIVFbK0ZbitIgLtecn9z0JYkTqZXDhXC4MwWMa2A
 csk8NMQAhVNaG4iOxMON+LLg4OEVb0O5fSw7tbgYwJFHqWtEDxnWaeiF8AbBcBs6NJ0G
 LSsa9x+O0GGjyeija03hominvMlCXTODFwwe1nODn/lfaydhthgQrDIKJMqjhTqXsSlz
 VCrA==
X-Gm-Message-State: AFuF++kzPnd+xGCxkrmeQfqJeNgR1JmajRZO38RFuidcT6tbOCNgC/Y3
 aXsU7uhaWMtaQ4fufN+WWcx7K5kmieKRMJwHbqX6IAUEYn/vq0vFG47km4twK5usSUs=
X-Gm-Gg: AR+sD13wfZSxIoacfg+JrUBOZsYgQ15f8fU8NwQU+mG4cTRxYk+CoWCog2ibZpgIrIv
 IW8N2TFZp1+0GI+WTReO6sRf25wbR6q0T9/4oOw/zFIpq3K2i6fCmyyWDq2JlQ8S/LT0m0UTQXr
 pcz1Yog27urkV3T9Co/JTaUtmblSb/jkZJYbf0NB9Gc9B9w+N06T8BqBDy3NmGSuKuRviQ2vKbC
 ICcBI1Iqk7WPKMh2MzjweweWbjiXlMAW5vwC4JPpq34eaic2qAsQlV3biYLHawpcPCUEvPuSimG
 Jo2QWWiXtV91MiCVKOba2M0o2jXqLHlGLORVCmBYkh9qr0T2t1Tr4bqEO/11KaDiObfx8WFsSqp
 /Uy9pmyYFDWL8XpSyFlduzxNSVyqEQbe/7+QH2rNVtyKo/+zuOLcTHF82c88DYn/vspj/jGJBcD
 kkSV52PTO2hOD0HR2Vw6e6aaipCTSPFD3PJfyPqnIXNbUQCRUiWiKTne1nu0d+ZMwh2FLNrZP8v
 DQ84HaJ3A+bH8cUNPO7n7u1IxBXslyUGHecbQD/GZjOoeQQ5DqYFQEZW0H/vAzWFe1afQHp0LON
 xUKbS4I2aJZFGT54+26qWPjJwnDv4qy/b6tqvAYJxWf6ZA==
X-Received: by 2002:a05:600c:4453:b0:499:8777:ccba with SMTP id
 5b1f17b1804b1-49b91c486abmr84183025e9.12.1787919046770; 
 Fri, 28 Aug 2026 05:10:46 -0700 (PDT)
Received: from [192.168.1.100]
 (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net.
 [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b494228bfsm125368175e9.2.2026.08.28.05.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:10:46 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 28 Aug 2026 14:10:47 +0200
Subject: [PATCH] drm/mediatek: mtk_hdmi_v2: fix VID_DOWNSAMPLE_CONFIG
 register offset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-mtk-hdmi-v2-fix-register-offset-v1-1-118ad5d7ebe3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNUQrCMBCE4auUfXahjaDRq4gPMZm0q7SV3ViE0
 rsb9fGD4Z+VDCowOjcrKRYxmaeKbtdQHMLUgyVVk2vdofXO81gePKRReHGc5c2KXqxAec7ZUNg
 fTyHHvY8hdVQrT0Wd/R4u17/tdbsjlm+Wtu0D+/pwJoMAAAA=
X-Change-ID: 20260828-mtk-hdmi-v2-fix-register-offset-879afc38cad1
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, 
 CK Hu <ck.hu@mediatek.com>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tommy Chen <tommyyl.chen@mediatek.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

According to the datasheet, VID_DOWNSAMPLE_CONFIG is at offset 0x8f0;
0x8d0 is the VID_CSC_COEFF_0 register.

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h b/drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
index 521b35c7e14d..bf3ebf5492d1 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_regs_v2.h
@@ -173,7 +173,7 @@
 #define  TPI_AUDIO_LOOKUP_EN		BIT(2)
 
 /* Video downsampling configuration */
-#define VID_DOWNSAMPLE_CONFIG		0x8d0
+#define VID_DOWNSAMPLE_CONFIG		0x8f0
 #define  C444_C422_CONFIG_ENABLE	BIT(0)
 #define  C422_C420_CONFIG_ENABLE	BIT(4)
 #define  C422_C420_CONFIG_BYPASS	BIT(5)

---
base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
change-id: 20260828-mtk-hdmi-v2-fix-register-offset-879afc38cad1

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

