Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62F6FF8877
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B14510EF0A;
	Wed, 29 Apr 2026 10:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="ChapYdah";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1951310E32B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 15:17:47 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-ba9ad0fbc3aso1127306266b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1777389465; x=1777994265; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tfcGL+vcMS+UjBvp0G25Bttx2znw1uqS/N2RTCBWA44=;
 b=ChapYdahDdGHPPg+Qjl64DKRFpFjbDXe6u7+bYbUzscENrTodmoEY8n1ujnHvl+8or
 oIgeMrBc3hhsD/K5rW7Vhua3uUO6sIBHcS2Y6yhgORUMVQaAM4PHaGliWrpKyYSLNOKD
 XDeYPXeHHa4OH6sHyIwB4KsvgQXlnD1tU+XwGhtAT7+xJHf9RtlcQ3uAWLCVnKBW6DE+
 KmTLE+vDS0XjxhOJ0uWQ3MBc2VTBxYN+wPpGuhyuS12XrAXjvRrGztX6UJoNId36/Ir8
 LRE4yXPBNIeypDdPm4SYuePzKBmLs7hoPPocuosyrW08aJfGXqNjBVsM6BmifZ3GOpQv
 NBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777389465; x=1777994265;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfcGL+vcMS+UjBvp0G25Bttx2znw1uqS/N2RTCBWA44=;
 b=ohgCyxdF92L2H6l8RfWgxdSc6wjI7gbYy8tHP4v1THUkni3qP4XHhLiSr4fGCj5a6b
 0YXQ0325FKjylcj0EBIVpMUwLEeWfwlcECLPTctj9VXvlqVOodYtkgb58TaNzFt36pD8
 H8LDQpH58MKmlyxTcrv1aLsMzpn8fas0r2yo0DoBKxIU7DvpceX3pjfvEnEOt3i5Zteq
 LAjfJk7MFYfxW48bvEv10ffhc1Ng5FETc7A920TjqfGYxZat3DszSJgfXe7mRPTjBO4r
 UzVEP8ox45QGI7pGVdvHJVZyZ3BvNcgzcw8fy3dulPzP5TCTAgVSzP/N7SGArmckkTSb
 jwOQ==
X-Gm-Message-State: AOJu0Yyo8T8jFiXm9zQ1s1o7Z8IPs6JPWZQMnSiJYAf/Gf7TjoOJu9sk
 OvkrGq0Y3n94hml6lJAY7BUGBWDMIs9YSkd6QWszQxIrQnvpMW6283HUhFt0cK76ysM=
X-Gm-Gg: AeBDiet+7bwkyqPSn7IJPQeAGnJHgvO92GZQxlW3i9/Lb5nxdMAL5jyxQ4i15aX3pDN
 +fk0jMT44U2qrWx1zdnhUcmfk9CposgH4wFCgV7/lHFKJrA7gS/rDlZwHTLnUeDYwSBOvI3Kp9v
 3IBSAZECq4WUU0RGX1IABLB4yLOyjH94BGbDrHvQFCTKuIAISO3HU1oUVk7Exh90fQQDUEBrvC5
 fqBnuZfZ0fgsWQqCj3SGSo3QK+PRFrOaIKzzFxTzzHOgH67ZZfz3FGSL/XeFrKt3rr3S3DdyvCR
 5gaopaQml/e8a8TWkTSYDhTAxZdSbv0Xeq2W2Th1BOP+y5cnVOZk9fUeVs20onQ5XrOZE4DNauo
 VYFQWPSnUh95+Q9msoIhx9jSI6cYt6+EDoQs7sevyKbM9qcCyjpURk+smfYqWpBf6pVpELU4cMt
 95mEtv/hAXVcZuZGd4oV3k5OR9/W0FhAvO17yh4CDtb53AdGDo9DuKZ5maR59vKJT6/XUD2XCOV
 nMyb3rrE69G2M1Bntz1uqeicOlyjA==
X-Received: by 2002:a17:907:789:b0:ba5:20b1:c13b with SMTP id
 a640c23a62f3a-bb80443cbedmr221886666b.28.1777389465261; 
 Tue, 28 Apr 2026 08:17:45 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bb80c0828d0sm115205366b.56.2026.04.28.08.17.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 08:17:44 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Subject: [PATCH v2 0/2] drm/panel: Add support for TSD TST070WSBE-196C 8"
 MIPI-DSI panel
Date: Tue, 28 Apr 2026 16:17:23 +0100
Message-Id: <20260428-imdt-dsi-display-v2-0-cf7294b5d7d6@imd-tec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIPP8GkC/2WNyw6CMBBFf4V07Zh2NKVx5X8YFn2MMkaEtJVIC
 P9uwbhyeZJzz51FosiUxKmaRaSRE/fPArirhG/t80bAobBAiVoe8QDchQwhMQROw8NOgMY5bdF
 qZYwosyHSld9b8tJ8Ob3cnXxeO6vRcsp9nLbPUa3eL1//50cFEpzDWptACqU7FwUy+b3vO9Esy
 /IBaiEJdMQAAAA=
X-Change-ID: 20260423-imdt-dsi-display-28bb6a2a6188
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

This series adds support for the TSD TST070WSBE-196C, a 7" 1024x600                                                                   
MIPI-DSI TFT LCD panel module based on the Fitipower EK79007AD                                                                        
controller. The panel is connected over a 4-lane MIPI-DSI video-mode                                                                  
interface and uses the RGB888 pixel format.                                                                                           
                                                                                                                                        
The driver is a simple non-configurable panel: the EK79007AD comes up                                                                 
with usable defaults after the power/reset sequence, so no                                                                 
DCS init sequence is required. It supports a single power supply, a                                                                   
reset GPIO and the standard backlight framework.

Note that in patch 2, link [2] has the incorrect DTSI name 
(TST070WSBE-165C.dtsi instead of TST070WSBE-196C.dtsi) even though 
its for the same panel as this patchset.
   
Patch 1 adds the dt-binding for the panel.                                                                                            
Patch 2 adds the panel driver, Kconfig/Makefile entries and a                                                                       
MAINTAINERS entry.                                                                                                                    
                                                                                                                                      

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
Changes in v2:
- As suggested by Dmitry, rework patch 1 and 2 so that the 
  panel-simple driver is modified instead of creating a new custom 
  driver for the panel since the panel doesn't require programming 
  via DSI.
- The panel controller (EK79007AD) supports 
  MIPI_DSI_MODE_VIDEO_BURST and
  MIPI_DSI_MODE_VIDEO_SYNC_PULSE. These have been added to the
  panel-desc flags.
- Rework patch 1 and 2 to rename the panel vendor as 
  Team Source Display instead of using the shortened version (TSD).
- Within the timing table, the pixel clock is now given 
  as an explict value instead of a calculated value
  to be similar to the other panels defined in simple-panel.
- Link to v1: https://patch.msgid.link/20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com

To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
William Bright (2):
      dt-bindings: panel-simple-dsi: Add Team Source Display TST070WSNE-196C
      drm/panel: simple: Add Team Source Display TST070WSBE-196C panel

 .../bindings/display/panel/panel-simple-dsi.yaml   |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 36 ++++++++++++++++++++++
 2 files changed, 38 insertions(+)
---
base-commit: f6c73e7156b54d8b9ddf1a27f4e93d3a1e49a73e
change-id: 20260423-imdt-dsi-display-28bb6a2a6188

Best regards,
--  
William Bright <william.bright@imd-tec.com>

