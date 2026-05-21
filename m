Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DCDCD5BAF
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:01:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1EC810F380;
	Thu, 21 May 2026 15:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cRAULRM0";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B343710F380
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:01:11 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48a7fe4f40bso73657625e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779375670; x=1779980470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gsZ8aDIVQOhkLMcIt92qlAZ0ISFPwApT1fZqqK+Da84=;
 b=cRAULRM08duquc1m4aAc/66u5Whu4mSobFaV2qsyZKJnoQ2ighO2fP8AHeAWsub4ys
 i5RQNa8DdV68VZiwuhCV9mLrIHB+rSBMAuT5pdq8kmxXG42OKsptkmrZvDJAfbBl68AX
 WL5JBTVBgI/Xkics8XnbsInJaaBaW+fRQVMIxrxfawtzWTg195fOSt16Yx+JlHI+SkWf
 yVLCyedT0LlXOo4PCDUU2OwBFVAcSeJrxmeV/MTcraCrLfgMRebr1j5l+pfzxxWA6YvV
 pC5A60fYcEfJhEnRSkZGGqmkXb46mk+5TBfpvxZfT9wevfw0wO4JVh+PVnOcQfseYbaM
 3qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375670; x=1779980470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gsZ8aDIVQOhkLMcIt92qlAZ0ISFPwApT1fZqqK+Da84=;
 b=ewDms2EDcRX/0/9A/0LbOwGrRSBpNqgHesauhTqaclJFBSqh5rXiH2YHjAjt8kvygW
 PoJXV0ME9j39NBCtzlC18UCXAMIOJyKU3rIKa/YlJ0bcGpvppL/zfO13IEp8V4KDP+iF
 mZsqy759L6Nz6dU/FZurL2F8sQOtPo3P+7B1DNMoLAZ2Vg4x5f9z3AchFotArHm9r2j3
 7Zb78sj+MDMQEqLMGgXr70WB57K8o96LEUyenHgjTFapPg4z16elK4Cc1wSraY796rTK
 kNSe1TCmaASLXI5TaugVOH4hOClPHFCdKLz9DpV6YNfKC3VDIYLTwrUwE9rtdm2yLBCe
 Oh5w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GnQQ16cSqsqu4nYRE75Hni/8INTIRtkM5nwmFoCMbRixZBo90BwwvUqgYvq9RQ2J3UeQdTtT1BLI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy85iFDcSFqyK/dXiY2wigCJGcubr6vCpJMZXSLtubm0NpV3cai
 A74fNaIexxxsSvIEs5EfF5K6jGLfa0qXqnjbjT6ZZMPTDNRkgQVSInhd
X-Gm-Gg: Acq92OHqKQNrXwVo4e6Ql69U0aXFPanXi6q5U5fYRI1tFfZHO6MyPquAbcNOEY7F1A4
 AnRusi5nUvmQjIU4eL4uAQZbKD7VG7g01Ht4u431PYdGzFysUfMbg9kjXYkm5+59c73G1lxtQPy
 FSpj8p779egv3e9d/wcn/uzaYaMeaPmmhAsoNe+/amw87ia5voKl40isGkieHlJKtvo+GbGdY6d
 8Namg/bUOrU/GKqOJtgNcje0oIsLqUtstRZqptVcO+cr9nz+aDsA/J6hks/QUXG2vZMW73FMWqv
 TasAj089ZTTEEz62MO6RLDhN7N5EmCB+QpibIxWztvT5LTy03274uKPyo+TVhbMDXhb7eTIeG2j
 pKf1PdpuTs6Q5A8azIoCCXGvUvZcf0IQnR2CEX3OddLSBEKhpDn8rOOtG8Tn5cwnAerIPVoIy1c
 kfw7FU9Ffrf2gFY50UTdVVwaLIball9+LXudw6Gzz1B5jCGr5XWsCI
X-Received: by 2002:a05:600c:8b34:b0:490:3d27:94f4 with SMTP id
 5b1f17b1804b1-4903d2797c3mr26603645e9.7.1779375669985; 
 Thu, 21 May 2026 08:01:09 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903caede9fsm34056745e9.14.2026.05.21.08.01.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:01:09 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 05/15] dt-bindings: display: panel-lvds: Add Riverdi
 RVT70HSLNWCA0 and RVT101HVLNWC00
Date: Thu, 21 May 2026 16:00:41 +0100
Message-ID: <20260521150038.103538-22-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521150038.103538-17-ivitro@gmail.com>
References: <20260521150038.103538-17-ivitro@gmail.com>
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
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 .../devicetree/bindings/display/panel/panel-lvds.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index 9db96dd724b2..7ed0c486870b 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -60,6 +60,10 @@ properties:
           - jenson,bl-jt60050-01a
           # Logic Technologies LT170410-2WHC 10.1" 1280x800 IPS TFT Cap Touch Mod.
           - logictechno,lt170410-2whc
+          # Riverdi RVT101HVLNWC00 10.1" WXGA (1280x800) TFT LCD LVDS panel
+          - riverdi,rvt101hvlnwc00
+          # Riverdi RVT70HSLNWCA0 7.0" WSVGA (1024x600) TFT LCD LVDS panel
+          - riverdi,rvt70hslnwca0
           # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
           - samsung,ltn070nl01
           # Samsung LTN101AL03 10.1" WXGA (800x1280) TFT LCD LVDS panel
-- 
2.54.0

