Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A43DCD6E6D
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19F611A0CC;
	Thu,  4 Jun 2026 13:53:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jd7bzQN3";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7804D11A0D1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:04 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45efa80e0afso629960f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581183; x=1781185983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WLUAaZps1w8Jl8h4U5vkB2L5GVDJaAP0Yeaa4HLYIr8=;
 b=Jd7bzQN3Ha7omjWeH5LFXztv3oVWklOWJCJaHywdw6x5QGBBNv/2oOCCRCEXJR/9hB
 2qAQ5UvMDNZRTMThYPcgEavuMnmB9I2USEVmi8gyeYddmeG6qPJ7EBDJtaNwQU4PLOUF
 gHRmDr2rt8opnvwW4l24bLsyp+v42xJH8pp6KXr7THO5qbUG8du0cuDJgZSNKPtGSRRu
 ICgpzAC1hDr9o798w0aoq94w+7C2fZNtZ4H+BwafsvCohwydFC6Xo5ijtHT8xhrhenHg
 vgUWkz390T87serPusrs6Lw9rE7zkoYZKCwGnsSArf67RkHYx+3E+2SCoq6hQP1VIzU/
 anZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581183; x=1781185983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WLUAaZps1w8Jl8h4U5vkB2L5GVDJaAP0Yeaa4HLYIr8=;
 b=aZD0JWiWCsJX2uyKUvwCnAzMguKNLqtzBYBSZ+kyPEr45A7L7G0kTJ1sLJWw0glcyG
 bxz6zqFk/WsfTsiIlQeCVuo0vIVlE/SoIyWJo3nMXlEV3j8FZjZum+lM48d7WNHk3XVO
 fvihtvygnUfntSd4lLXv4LlD07WdgCIHlFGSrmrIW91UyL4ciXyFYMMnHefbDocTli9V
 fLK33IYIr1Y5Ft+w0DNcaoCaiVbqLfPrpGIB05NZPk4nPgmFL9zSWRLFXG7WpdNOW2a4
 tpvS4neLtdotDw2h5CL72ElIZspKHAat8mrIMY8PFLiAHfbQqkHvhwLljU5mI28ET9gp
 bh5A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gjEz4B88qmk7wPyMFDvni+yT6cHFI32DALVEa26iBdPk8BFRscfS+DfEOlA2r8zwTmp1JmM8cU1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxxJJpaAiTum8Sgfmnx2foUJd/vnl+imvMNPSDpQYQKQ/9kRng/
 vJGyocrT9WmbXHbvdtocin/Y3wTsOG0gCnIPQYm0DV2odxn/8yaXLsq6
X-Gm-Gg: Acq92OHnRHFvTR6LYmdsEH9Nc+81R9bSBtXu9jajwlIXnr6OU438mno8Kpq5oSXrntp
 5VbjmTAGBbYU88pP5jU3d4x7S+vJvvGgxLAzONaaJVyYxR5YyDGx1mCgvJnPsvwtp2Ik3ir8tj8
 wb9jo+1D0tPyhH4mcPv1V/kRqjnRZGCdaXK1Tj4+oDVNWEhDMWjmcpX02D4z26EggfJZcVbCJiK
 gJaZ7qs9h+MXh1jFqOxw9nZJ/q0Cv7wk2zUIqiukOD+tEIOWta/J+Jx9zwhxba3WG0ALQpsvDLl
 2F2aaxx2Yq/+dXNPKfXa6rjxWDCPlqAWza80IoawTk79Smf7CKwJeTzrRkDxKfEi9kldeOufTIU
 j08E7zaCc+hq6kMTNbzDXKt7CbIPco9wUFB33xAv/bwo6U187iP4LUKOCSjJPNQ8GFuVRAjvu4n
 D48TDGhqPa5X7cYFhIUlNFtnUYfsgL+X+22IFe5KyfUo7IH/R5N9ijp8gUmsaqrok=
X-Received: by 2002:a05:6000:982:b0:460:2d57:fcf2 with SMTP id
 ffacd0b85a97d-4602d58034emr3094425f8f.10.1780581182959; 
 Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:53:02 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 7/9] dt-bindings: npu: rockchip,
 rk3588-rknn-core: Add RK3568
Date: Thu,  4 Jun 2026 13:52:53 +0000
Message-Id: <20260604135255.62682-8-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260604135255.62682-1-midgy971@gmail.com>
References: <20260604135255.62682-1-midgy971@gmail.com>
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

The RK3568 carries a single core of the same NVDLA-derived NPU IP as the
RK3588.  Add its compatible.

On RK3568 the NPU NOC bus-idle and power gating are controlled through the
system PMU rather than a dedicated register block, so add a rockchip,pmu
phandle to that syscon.  The RK3568 NPU has no dedicated SRAM rail, so
sram-supply is required only on RK3588.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd1..af9936b32e9fe 100644
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
+      Phandle to the PMU syscon.  On RK3568 the NPU's NOC bus-idle and
+      power gating are controlled through the PMU; this points to that
+      syscon so those registers can be reached.
+
   power-domains:
     maxItems: 1
 
@@ -75,7 +83,15 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3588-rknn-core
+then:
+  required:
+    - sram-supply
 
 additionalProperties: false
 
-- 
2.39.5

