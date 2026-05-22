Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5950CD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E360310F59F;
	Fri, 22 May 2026 13:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wib7yppu";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE94910F587
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:20:43 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so11671265e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779456042; x=1780060842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=og4Ss48qjWaYlmsfdFxPi0Imv8+Y+Dj/6CNrwGbe4NU=;
 b=Wib7yppudrtGtqqYdv2t5ZpWe1CRjG8pnnAhw9XnyP0IYT9Aa4Bdxu31EQSdcwQfHj
 tQFVDbk62J6eBxv/FPvw51XZEdfehsbPDWTViL3uBjSttNvSWYBRk1/r24+pHcHlfBNw
 vvDPPfCOW7yDe3p3XokW7nJ9TEYtdrUSwJo7kvo8TXwfFKIrh2Vo/ABuA8jp/PBnDY5Y
 o5wQRSTW2W3+3B9/iG1LDTLRNMF9SRPB2o+88F3oozQnxrvh2bRTBnnLTQ9h4nvxX6bQ
 ZutkoD5rHyIiAnC5b9J8Jjs/QzWR2K6OdCvB5iV+x2pJj4dXTJ5j7j1zkF3HWwM1CS60
 yTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779456042; x=1780060842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=og4Ss48qjWaYlmsfdFxPi0Imv8+Y+Dj/6CNrwGbe4NU=;
 b=NbP0fae9VE/YFST283nnNSgICgmEH1BFGDIrJjTtbg/Io0FT14gibld5W0/5xLz3We
 UAaUZHyihC0h6vPXliM9QKgA4/Z5fN58ht0+Q7pzpxt0yWEM4s0/HitsrfEWv5LU1mSr
 jmbGNJnXeUbUJQuWgjj6Mj6E+88z5HLPmlfulTBO8RgtO6PLs+xtkRR5WYYZXQ+MzAVQ
 BjE4A3Gr9+IjKzfYGUwRpGa3j78jsgvtiW+mEGwVXFzQIu2m5jtrQ+K0gaHrIc6ZsBfT
 UWthLdQue14y/j/hBr8bDkbRtER10L0cnZErjUyoOkHzNgUGrfbgbk/pid6NLRJm8njO
 yDhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DxVN4sN9wVFR44lojHhC9XRfwoDcJne0NBpYHeuzwnDtTgTa2CGPkIM/PJsjsQJ9Sljvur8uIB30=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0KlvkGcKP0Ub2LnrlUTMlAxqjo2thdKOyRyMLtuWprsbosCQ3
 R9u1GsgS0++uRoNnWFS2aKv8dBC0ULFUHfN7r9+//JYyiff0bJ7QFccx
X-Gm-Gg: Acq92OGur5dxAi/Ju8CXQHXpLlOhBBmWpxiyK/oUEIWUhidqaqNDjbnZ8R74rbDWYAY
 IyGM7mkRiQ7bf8yVhO+ry23GgW+o9f1y1vjhgGqF/cMghXdplEUoPP+sY1yZu4wVs78yoPJGX2z
 88jntV+dFTmhqFIwnNkYLCWXcQGGSlVteY5DDuoHGq7BVOL4NKUWWejDw8wrqs3jYLCzcpolhEf
 MDzyu34iC8LxistP4TZHSYF1YQaRW2y4nGEctu97YzUdJyvvEGky9JQkWbZhanf0dVbsXN+5RrT
 ijqfB4heEqu9vVm7f2QK2J9sgWgvW4EmOJFkfEY0vwfLDe5fuVRnXOQDT2H/PXfABAvwUkQD+BA
 qx2XfRIgWoFuFSzrKxsya2Ktw13WHubl37x0eHS1ETACTOQmy1Df47r8va+6P9ERnSdk1agnQKw
 CNZ+MjkOTm+GtY0mgv7ZillHCwkdpiCtybN2qIdEFcXA==
X-Received: by 2002:a05:600d:8445:20b0:48a:89d9:a419 with SMTP id
 5b1f17b1804b1-490424ad4c3mr37503325e9.11.1779456042100; 
 Fri, 22 May 2026 06:20:42 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0cd5sm52220755e9.10.2026.05.22.06.20.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:20:41 -0700 (PDT)
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
Subject: [PATCH v2 04/11] dt-bindings: display: panel-lvds: Add Riverdi
 RVT70HSLNWCA0 and RVT101HVLNWC00
Date: Fri, 22 May 2026 14:20:17 +0100
Message-ID: <20260522132014.226721-17-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522132014.226721-13-ivitro@gmail.com>
References: <20260522132014.226721-13-ivitro@gmail.com>
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

