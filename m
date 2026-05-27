Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8213CD5BDE
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 08:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1909D10E1B6;
	Wed, 27 May 2026 08:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="o/lI9tTW";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DED2210E1B6
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 08:58:10 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-83ef1d17904so11305958b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779872290; x=1780477090; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lrfrbodGc66CPIYMUM+CDwbTfB72a0J41QMlQIGWspU=;
 b=o/lI9tTW8mArbIe5Mxaj88gRDfNq+uE/3j5FoFeyCOeEjvPUrc554LYz2tt1UHZEKI
 diomUDRf7O7vIG76ys2kPWvRCvyWnhjXHVBJXQ+3TvE17q8LERz14o4VUi9mEz2Q/HJs
 SZdveQuEQM/U/T+pMGtAfROhiBFL7ECXD4TkXBfCcj/XoZzDO88IeElwIRgmZNZtaE1B
 Xm7fqpT1IDc+/bpuP7nfwlmnH8mWH7v/Ykalq798XKOBrMLE6YXGAunOfhLS0BwjtZVe
 eW7kFUNcSVyHGyQ8AJ3VQBM0WViR7gaJ8e35bS2vMkfSoOyUscwwn/WB16YSsG2YbdM1
 6Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779872290; x=1780477090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lrfrbodGc66CPIYMUM+CDwbTfB72a0J41QMlQIGWspU=;
 b=Qvb/Wf7ZHoeaCV+f4EGFFnhYldkizabxaYhPwo4HxKR38jQ+au3PerhsoSEglj6Lvr
 0wDWxFlYFbW/2In9KdnV9WFGeGs2HnPUUlaCpxbxtXtTnWDP67Ms9tFFRrTnbHIcJbtL
 OkZD9IaNF5EILBuAVsM65DGqxy+BM2wvFPRaUhyvAKvTGj8/1pNLrIEA6fXDujlFz62V
 i/GnuJLfbtnb0ufJqfzFUZEVr0a0ToQXFdIVPFO7BqU2qjAkaun2IztGY6akEZOAV9WM
 Gche6V21kAx9km4eSQ5qOhMpfDfLQ8ijSYErK2MDa4VvcEf8eO9neyXroEV6VMfY2Ebz
 wfzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9kANtQvtynsGWzGophCaCn0+l0Z+PcI1C/rDfGGu1lGNZIPFSdSQRCz02YtM0M9K9rCBLaN+JWO/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbcenVWvrsCXsp+fH02FcSQJx6GX1AIrKusbGzdIJWD0WAorG8
 TXuNpp62Rk4gMKmAof6XLCoz3og7Y3TzKHtP0mYgCfPk5MIxrrRiiwIF
X-Gm-Gg: Acq92OHR1PfdB8mnOWeuYdiO/Fd7gmbhP5oJ00THBmD0iK0uo9Un/ztz6c1MkhuRKJt
 HKNf/mWFhd11JmOvx+XSUHcak+zcelRIU8OFxSBl37rBJextJZpTZ232+ld8h29BcFcOfyxBAPN
 f6crvD1zmIeG9/OBV4R9S2PyO6eecw4HjUeg0shfLjBk2jWq4hFxuGpiSUe0Ii7S6LbK5l2iVKF
 zChCsj+3R4PFzfJKsnjz8goDYE+icnQOa9RFtXsvjx7EEAp+uwSEvXaML3oM4NUpVCBNQQIDE1V
 GZneuSgBSj5Zfiy8hgnXcwlOwnnzxa6iHFPSrWlJPV1YmRuajykjyl33hwiGPiD0NmfSYPuL457
 u02KVAGGSUb5jC2ZGzMvzci75MR698GeLKPPHh9XpiB9wm1vtlrd6GdkhFsyXxyPDNKGVwnVJZ8
 AJOooO+5XlxORBQqBJoCukUp79S04wwLbEEabvYqYfDcbe7p6k
X-Received: by 2002:a05:6a00:a204:b0:838:1ece:9716 with SMTP id
 d2e1a72fcca58-8415f1984fbmr20853825b3a.22.1779872290414; 
 Wed, 27 May 2026 01:58:10 -0700 (PDT)
Received: from test-HP-Desktop-Pro-G3.. ([103.218.174.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-841d70b855csm1651909b3a.38.2026.05.27.01.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 01:58:10 -0700 (PDT)
From: Sudarshan Shetty <tessolveupstream@gmail.com>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, alexander.stein@ew.tq-group.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Sudarshan Shetty <tessolveupstream@gmail.com>
Subject: [PATCH v4 1/2] drm: bridge: ti-sn65dsi83: Remove NO_HFP and NO_HBP
 mode flags for LVDS stability
Date: Wed, 27 May 2026 14:27:35 +0530
Message-Id: <20260527085736.920390-2-tessolveupstream@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527085736.920390-1-tessolveupstream@gmail.com>
References: <20260527085736.920390-1-tessolveupstream@gmail.com>
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

The current DSI mode configuration disables horizontal front porch
(HFP) and back porch (HBP) transmission using
MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.

However, the SN65DSI83/84 bridge relies on receiving full horizontal
timing information over DSI in order to correctly reconstruct the
LVDS output timings. When HFP and HBP are not transmitted, the bridge
cannot recreate the required timing parameters, resulting in unstable
or missing display output on some panels.

The SN65DSI84 datasheet also describes transmission of complete
horizontal timing information as part of the DSI video stream.

Remove MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP
so that HFP and HBP timing information is transmitted to the bridge.

Reference:
SN65DSI84 Datasheet, Section 7.4.7 (page 20):
https://www.ti.com/lit/ds/symlink/sn65dsi84.pdf?ts=1776924088430&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FSN65DSI84

Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 42b451432bbb..c03ff1ea9df8 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -977,7 +977,6 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
 			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
-- 
2.34.1

