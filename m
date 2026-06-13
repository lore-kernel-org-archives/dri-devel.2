Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D5CCD98D8
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 06:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D61310ECB5;
	Sat, 13 Jun 2026 06:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jWmqm9hr";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6AF310ECA2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 06:58:40 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b9318997so12259365e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 23:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781333919; x=1781938719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZ66LcteqJ4QI9hjgF9HToSLQnhyQKu6uHIFWcsfYcU=;
 b=jWmqm9hrC0MSAt9RBgm02hIS1fO0FbjeCNvWrBrw8oWj7XjLfXRB/aPr2q/PZZgFS5
 b8kIU/BeRbJD1ECgdl1a/8B7ar4vv9XV4A9xqzUUJyYSbiMRbhIRxFOrtXl10BMeUyHP
 dbIApuMzFUHJErr3s3WeIqpHpxBOm9Nmdt2wC7JsezJiUakAtk6ObsQ/LelUSIzuqRQ8
 +Fm2z9LQeAvCK9fzqITBWKgxkobtyV34HJOeZJ0KurI8a2GPOVScrPc1LnM7xghUdaOj
 LDypLwRN5+Xr9gsdo/CQbIpNA7s14ryXeMOO1OBotuKuqdoindyCyHX/yYRrItHL9xh/
 m6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781333919; x=1781938719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jZ66LcteqJ4QI9hjgF9HToSLQnhyQKu6uHIFWcsfYcU=;
 b=pMaSQO2JsFOHmh/UjGAnFcj4VWb0IkPZIy+CbF6hvmvSxsa/OwIB0zZlM4XVSJSRrS
 sj92ZxQkjIRF5yB1MwP90j5W9ZvOqrqlqyjblm0eyGIua0VGPSblUq6ehefo3ksUyBBx
 1/voNtJ6Tmn/3ThPdFUlpS0Y75Y1ga6aSfCxxm4Pps9eAMESWE+XqEh4gXKwAD9xKY5p
 bRES60LgHcYrSgQiFRuewdXpkgs1+5CXDFPuh0TUxm+O/yqFEurRBzzyUAA8QjWN4RZ4
 7K52hAwOc1wWL1WVy2gC7FOTwOSXESRRUEvCo/VNxHqfPmeseN32sfUZoIOoR+jcH+SC
 kODw==
X-Gm-Message-State: AOJu0YzGEw+p21tN0tG3zBfBnHTnt58x337eAkAi9V9V4BDBIYf+8rx6
 OmNkEll1T5pThsTtgidVFnayJtmwlZirxUKiXLOvsKW2EMx6Pp/eBiXxcAkhVc8SX2c=
X-Gm-Gg: Acq92OHzBi2csXovFCpXgU92W1MfZ7GT4byQ46VR68S4eG+3qTv2quklIS9XarJAoC4
 uJCGjicHkwHY3UxY0ECvrZgmUwcvkibdERAIHu7sfAvlA6hvS9kQYtDu966C+yiuiOBXE2iDgQ1
 oxZQmG0LBK5tL1oDaTnabxiwhHNqZSFUdde/RbZ+tuBP0tV0o6YfarZbdUJ6untj/aYeHzjY5Ki
 OnZNhfW6fFQYTQN9+gZqWJZGx71gPXnYBHOAISUVQ+t7RLSs7kyGEUTrzvciXcBmck8PHbUfyJX
 4SXu1OtxM81DoBXdaNhAvk0zEbEGrcBLNteEzPCoopNgRKfxjCG4x2DMCPBZKL1dAYU8ZXriH5y
 dYHWoURLTtUL+iJ+wLiAY2xejFDxqrizlLUluJIO+jGqBZgPW0fvxL2ylR3VhTwBHOs55zownii
 drlBDjdXVN1ghiShh4YzLAPZ5trQ1xV+yj90p2tew/Pg==
X-Received: by 2002:a05:600c:4ed0:b0:490:5e2a:f924 with SMTP id
 5b1f17b1804b1-4922008485fmr28715325e9.7.1781333919182; 
 Fri, 12 Jun 2026 23:58:39 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:14c0:9448:1c38:77df])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492202e5cbasm42917705e9.2.2026.06.12.23.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 23:58:38 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 ulf.hansson@linaro.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, xxm@rock-chips.com,
 chaoyi.chen@rock-chips.com, finley.xiao@rock-chips.com,
 diederik@cknow-tech.com, jonas@kwiboo.se, Midgy BALON <midgy971@gmail.com>
Subject: [RFC PATCH v4 6/9] dt-bindings: npu: rockchip,
 rk3588-rknn-core: Add RK3568
Date: Sat, 13 Jun 2026 09:01:13 +0200
Message-Id: <20260613070116.438906-7-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260613070116.438906-1-midgy971@gmail.com>
References: <20260613070116.438906-1-midgy971@gmail.com>
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

From: Midgy BALON <midgy971@gmail.com>

The RK3568 carries a single core of the same NVDLA-derived NPU IP as the
RK3588.  Add its compatible.

On RK3568 the NPU NoC bus-idle and power gating are controlled through the
system PMU rather than a dedicated register block, so add a rockchip,pmu
phandle to that syscon.  The RK3568 NPU has no dedicated SRAM rail, so
sram-supply is required only on RK3588.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml        | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd1..e0b948ac47d45 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3568-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -50,6 +51,13 @@ properties:
 
   npu-supply: true
 
+  rockchip,pmu:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the PMU syscon.  On RK3568 the NPU's NoC bus-idle and
+      power gating are controlled through the PMU; this points to that
+      syscon so those registers can be reached.
+
   power-domains:
     maxItems: 1
 
@@ -75,7 +83,24 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3588-rknn-core
+    then:
+      required:
+        - sram-supply
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-rknn-core
+    then:
+      required:
+        - rockchip,pmu
 
 additionalProperties: false
 
-- 
2.39.5

