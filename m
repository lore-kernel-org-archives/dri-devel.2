Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB49DC5321C
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:17:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44BB910E2F6;
	Mon, 27 Jul 2026 07:17:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NmTZB8Tt";
	dkim-atps=neutral
Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E521D10F4C9
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 03:17:44 +0000 (UTC)
Received: by mail-pz2-f1.google.com with SMTP id
 41be03b00d2f7-ca7a25cd87dso1015072a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 20:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784949464; x=1785554264; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+s3XIzGgmCw98QusnVJUh5PtZQnQQOXqs7KUawjh9Mc=;
 b=NmTZB8TtVvxUP6hMiPKJ3cjcyB2hLLrqy+dMybAWlC1IKCONavirvadEU4E8D+MDDS
 fMnVN/quX8FAZ7OSmPArEKVfptVoKb6d6y0WUhAFji1STGEjaPjXJszohzGhGImBqZ4k
 AeHMtuSA38N5cR/2JgoEijY5NIuYywRRbBhN55X/mZXaLA2HTmxBuWFFH6oepQ10zxw9
 Ig69D1F4xBUyU8ennHeSZXZv0IzVGjQ+8hZqOIjzp8yqMkpqCvXkbVZq0uO3Nm1jtXw2
 ul85xhirAKLMm2F463DKjpyDV+c2tq/hQ6TYsPcgAZRZLWjBUHOoxVCp9yc6vTgU2up3
 vAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784949464; x=1785554264;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+s3XIzGgmCw98QusnVJUh5PtZQnQQOXqs7KUawjh9Mc=;
 b=oNqn2g7DhEREOFbwCcTFjk6cks+6GNDOH9LIb+XW2j824ExWkIrzIVRJd+o82hpDA8
 CCErWKcMDSdsEvSVaApSegneSuEPmxqrfKgP7vTXqR0oNGY9ZHHQ81nzMguo9YuByLe/
 QcoNQWk47EnyVIYYC/sjcMAx8BlhCLE6KCalvyh8iXIJ6p3DmKFFPOUNnmrOnscm2dh0
 3DKXkIBfqmJdfSc2mkLc1axuwQKxrzEujv2lnQK/3UxfnHUB0FdMvhIcmqYKfVyjo+6x
 Y4XUbSHJZXVeQ3lfTattpdq4Mk4tN3IF0OaAIaQSt/d/x3Ps7smu4Io79jKcPzBbW1md
 pbPg==
X-Gm-Message-State: AOJu0YyG2aFKviClQKuMkhaIRXOOfLbVMppInYNH0AALuhBTFaugDxJt
 4PPDBuQrr5buF5KWze1xfJ/0rKS7sScsDdMIOZMrvbvbLTw4jDcne9yQ
X-Gm-Gg: AR+sD10jblm7Sk4USqJ35odu/HqkvZfmsBK9alDmtMVWI6L0PYdEqRpiMGxyuMR/4a8
 zC9KtgKcXpQMy0hEJHdT702Z/Cz3XUj9mcgM1zWlRSCeudxNIWbeTT/lgSrAH6qs6b8+ageyplk
 c79MjQTdVQe2ET+wKGmV6vDyufUuoZu2WdVv0QQNUWAnA+zZubRuCUcHKS1hPYk/RKEOIUXHSti
 8fff+croSFIOsm1Sami4dNYogtDdmrIcT8TPXayTYUjgSw1rUB6vomSPxim8Q3RWFPsrEMWQ5Xc
 PNs8gjPDPFIKRXhbRWXxV7H9eG+86sIGWHMVu5s/1QydBKuRS4IGSFtGMkykFM96t9aMuc3PCbz
 wgmtDogI/YLYMbJBJGN0iN0y9RdzCXkxiHup07OFoGShJjyfKW2AS9cM=
X-Received: by 2002:a05:6a00:9288:b0:848:2f77:e2da with SMTP id
 d2e1a72fcca58-84e595d33e9mr653832b3a.67.1784949464300; 
 Fri, 24 Jul 2026 20:17:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:17:43 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:36 -0400
Subject: [PATCH 04/17] dt-bindings: soc: spacemit: allow eDP/DP PHY PLL
 pixel clocks on K3 APMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-4-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

The APMU's eDP pixel-clock muxes select the DP PHY PLLs as parents, so the
K3 syscon takes two clock inputs the other variants do not have.

Gate them behind the K3 compatible instead of widening the shared clock
list, so a non-K3 syscon cannot silently accept clocks it has no mux for.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 .../bindings/soc/spacemit/spacemit,k1-syscon.yaml  | 30 +++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
index d3a7c93c3c54..b8fc6632a392 100644
--- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
+++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
@@ -31,14 +31,18 @@ properties:
     maxItems: 1
 
   clocks:
-    maxItems: 4
+    minItems: 4
+    maxItems: 6
 
   clock-names:
+    minItems: 4
     items:
       - const: osc
       - const: vctcxo_1m
       - const: vctcxo_3m
       - const: vctcxo_24m
+      - const: edp0_pll_pxclk
+      - const: edp1_pll_pxclk
 
   "#clock-cells":
     const: 1
@@ -95,6 +99,30 @@ allOf:
         - clocks
         - clock-names
         - "#clock-cells"
+  # Only the K3 APMU exposes the two eDP/DP PHY PLL pixel clocks as extra
+  # inputs (parents of its eDP pixel-clock muxes); every other variant has
+  # the four base oscillator inputs only.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: spacemit,k3-syscon-apmu
+    then:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 6
+        clock-names:
+          minItems: 4
+          maxItems: 6
+    else:
+      properties:
+        clocks:
+          minItems: 4
+          maxItems: 4
+        clock-names:
+          minItems: 4
+          maxItems: 4
 
 additionalProperties: false
 

-- 
2.43.0

