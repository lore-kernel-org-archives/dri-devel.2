Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D573CCD5BB4
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3646B10F5D2;
	Fri, 22 May 2026 16:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jaxagjOG";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C63A10F5FD
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:11:48 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso76041485e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779466307; x=1780071107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=og4Ss48qjWaYlmsfdFxPi0Imv8+Y+Dj/6CNrwGbe4NU=;
 b=jaxagjOGAYM/iaDM2qQc0YvWyaSF66XovFQm3n4UjGJ6jwoXAhZ+yM1iBZjiGSXgR1
 T/KCnMtHZotK1jqvXsD0cmGKCdDqG12iAKQhFzasdh0868y3+Fus7wLnBUZ5/Vm+2Nh9
 I8aM8jR/L6DWwt744V9celpEV5SvFX4+YVqWhSsZmuG1hJ21AcaZiwAatFMCkOYYHFSr
 zfnrFPdXa2rVrrlQ8c5B31pMvAbAZqTXVLpKezUHvs7kZHkbBmd8J5syyNbBsSpLgs5F
 ukeb4tgTE2+gbq20Vzjr90HejVvf7Os5borPlfo4pop/XNek1sXTvYhIZRTC3K6UmgQs
 2MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466307; x=1780071107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=og4Ss48qjWaYlmsfdFxPi0Imv8+Y+Dj/6CNrwGbe4NU=;
 b=HyBNZ1havqN4akDy4i2Hwr2C1o/MCsES7SfG3nE84e3SnPyAHMRG0MhNWcS/zYeJRe
 vEwczIupLPSLEqMD6CWQqgmbGS319Tz9N6H6G7AXcIzdhNypyra7HMZP9D0tky6P8cbJ
 ivleUy2yVTpYIhQiR8UFCfLZynGkmyyx2Ab1oBqXN11/dhEW2/YABUpNy4X+ZHU/TRVJ
 /R6dwAWYsshvKWYCaUNjO2eprwN8Jx8PTGcHVSW4Km39CuhMAiviElMfTQ+lzccnQzfK
 Bf6b3oE9w0igUvCQ6vobe8DyWKkgBW4GVUD50xWF+RE/Y4FTBFJeXHi8hgj4b3op18a0
 xTxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ioedEqMQkp81phtKb5YcZ3A8H3oBxUfuuj4t9pjP50iVU0AuhWbxPFLLfG8kyd38FbNUxAjdLYnE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzxvSvaScIyW61R6SRO+KEfEuBTYQLDwcZ+sB8hPLWbhJog5Pcs
 i9svMfyF3vTvANr8H8731WhYUanO270xBc1dXO85iuXUS4AhtzlsMzZ1
X-Gm-Gg: Acq92OHc9keU8HivlNnkqHRSthWvK03hD07mwA97KJ5xdDiUelxaefsoPZusaXESy5y
 2rB5A2mfTXFPLEeuUjGC7MYCQEGJDL/0Pe5s28LNoMnC8KHaTMkNIvB40sgAcMyLH2A1FPG3AZA
 CJvM9gtImWrFB1IAI+GYoTaV8vBzTPgAtru29bD2vaUJR0DjFgiossBCwl6Cht/x4TFZhwjEczb
 pGOr5ngmb7+x5fztWTZyOXoWniBSwJnFFuc9VCvEDw594l9bEcJrC/BgtNfgaIMOSFiY78KR798
 ejGzovRabGbOFtfSHj4fthP5d1hVr2iRPf8jlKKMIV1l8FdfBKSeDlUtXpZRRkBvDaZehCODM3b
 tj+/H5MnBdOCmKVn9cYI/nirIY6d9NgyWdvqhy7p3JVVHeBBmpdqwDLYYOdzrSQe06fR+Ee17OL
 Z6n6Zwq/wjh6OTddNnJ/sZ7gfkf33kUr4O45EYordWQw==
X-Received: by 2002:a05:600c:c83:b0:48f:d612:3c4a with SMTP id
 5b1f17b1804b1-49042488b81mr59056955e9.1.1779466306479; 
 Fri, 22 May 2026 09:11:46 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm51042755e9.11.2026.05.22.09.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:11:46 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 04/11] dt-bindings: display: panel-lvds: Add Riverdi
 RVT70HSLNWCA0 and RVT101HVLNWC00
Date: Fri, 22 May 2026 17:11:08 +0100
Message-ID: <20260522161105.277519-17-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
References: <20260522161105.277519-13-ivitro@gmail.com>
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

From: Vitor Soares <vitor.soares@toradex.com>

The Riverdi RVT70HSLNWCA0 is a 7.0" WSVGA (1024x600) IPS TFT LCD LVDS
panel used in the Riverdi RVT70HSDNWCA0 display module.

The Riverdi RVT101HVLNWC00 is a 10.1" WXGA (1280x800) IPS TFT LCD LVDS
panel used in the Riverdi RVT101HVDNWC00 display module.

Link: https://download.riverdi.com/RVT70HSLNWCA0/DS_RVT70HSLNWCA0_Rev.1.4.pdf
Link: https://download.riverdi.com/RVT101HVLNWC00/DS_RVT101HVLNWC00_Rev.1.4.pdf
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 .../devicetree/bindings/display/panel/panel-lvds.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index b31c67babaa8..b89f86bc0683 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,10 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # Riverdi RVT101HVLNWC00 10.1" WXGA (1280x800) TFT LCD LVDS panel
+          - riverdi,rvt101hvlnwc00
+          # Riverdi RVT70HSLNWCA0 7.0" WSVGA (1024x600) TFT LCD LVDS panel
+          - riverdi,rvt70hslnwca0
           # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
           - samsung,ltn070nl01
           # Samsung LTN101AL03 10.1" WXGA (800x1280) TFT LCD LVDS panel
-- 
2.54.0

