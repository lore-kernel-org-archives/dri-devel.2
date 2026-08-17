Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7998FC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D700110E74A;
	Mon, 17 Aug 2026 11:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="de7gymRD";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRokXfjs";
	dkim-atps=neutral
Received: from flow-a6-smtp.messagingengine.com
 (flow-a6-smtp.messagingengine.com [103.168.172.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B4D10E74A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:37:19 +0000 (UTC)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailflow.phl.internal (Postfix) with ESMTP id 3962E13802DB;
 Mon, 17 Aug 2026 07:37:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Mon, 17 Aug 2026 07:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786966639; x=
 1786970239; bh=lby+YKGYne2e+SBq5qvdcTNcFHIm7YId3vHFaeK2h7M=; b=d
 e7gymRDYMlScGDp70tPUdRljlwGLJ6KiviJ706mafNmY5tDOb1UMeLtvKLajAQ9V
 66XW4rYlTgrRgwe/EEK0wSFyJkKsQ8FoE6Fklhehyl0sLeRhfM5TIzzoXgnLRB1y
 yzXp9UirBPICmE0rBRtCHq2OGDjsalFyLFkGtME7yyw/UKeCQYIonChaIFV9U0vq
 em8kZbZLQx+YmNMdcCh/cq5Z8rxla512LM9UeWpGVAnwaTGLo3OwisbK7j/cC+lX
 D9jkQEIDxm6Oj2nJlZ1TqyDqO4LX57cIXi6t/XGEyeulbXl9VTY1i2FVu/yvU1Uu
 SY2Fnz78EHTDtN+EvMk5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786966639; x=1786970239; bh=l
 by+YKGYne2e+SBq5qvdcTNcFHIm7YId3vHFaeK2h7M=; b=gRokXfjsfS5YWjP7E
 q+CczumhAHukEMKU46qeOY66AOUWPLN+lQbkhhu68wV7GQsoS8Im1LSjjzMNzN/1
 1gACSbyLJPFOrDSQIje41Wh03dOAdCMDQVTSuk3vC+cgN0eOemHeuHc8af9ACCok
 Pvy1R1boPmKyZJGNT2HcBTC40ARNPS5U7IBYU/fJNmmjfBFoY+2e9FsXOmMd9OkX
 QD1YTTSw6scAybIR9f9ZJ634Sr4xRMbk0zexguECRpthYA4Ys4MdOiLDw2VYk0aA
 /F+zl/Ja3s9Ke8M188cyeF/CzbDu+hQtj4tJ54NeL5iNwZ1CrXRS7Q7NDfSh9SKa
 MarDg==
X-ME-Sender: <xms:bvKCaqSj7r1gmOZMlbjS9OezXOmQFbTx6w1JF4ZpYRNRxrQl7co8WA>
 <xme:bvKCar4zc7F4XLQEr-EFv8A3Mv6ylN2XOwaOaZzPgUyISxSQRq0jspWC4KiN7Osou
 _M7ka1d0FkeAGVWhg02-H0TaxY4T1Or26Nla_9Ox4dTbhPQUXBuQVmG>
X-ME-Received: <xmr:bvKCajoI_K05dC4KrskmYlQzXI0n6INT_D8-7KCeoUZNMGcsEZhcyYYW7KKqhEKcSvJ9s32zVw>
X-ME-Proxy-Cause: dmFkZTEbo03Dt9gKvRTGBg3KEH1DqaPY/H6zCcSZZeM1zR7Pq9k+21FPEdaywskSvmMkcc
 cHQ2RFBjtPcxhgy/KmNB50Y6FMXUqKJIWg52JZWhqYAF445T2t3cJnwt16b6flTr+Tm5aw
 Oq/F9cwAChEJdajME7GraNUQPPLDINvFa3LSSEkNznYz3dK5thur6LAy+M+kg2y6wZWD8F
 hVtQBPknZHWJriktC5PREMWeO0aUUNzqIcRLR7sfqAfsUY9FxPi1wp6mQNE+eG1pwEmW5F
 9jX9PSrR0OLTHeZuYHwePCiONOa0ACIpucN0J6DuEHfShdx4/NDN52R4lkIf3tcUt4ZXrL
 6rfKdgVQeMYuR3Gl/+q/46EfE66ZeaHT5zSqx9wraLED0QIpU7JOnMLSGlJYGP3JIkaEDu
 wB+m1w9JVm6ZAMGFpfDuRXJrAusoNAcHg60g+mBgz3+5IEsn7eqJCuYaUMemYrEe/pnT28
 KSblYDq51kwH+MEjuvSYL5CZy7KWfYn5c+R+wj6S0kheCpuTPu2l2+HuF1P57cDQVjwuau
 ibWerofQ9eA+WhbmviRIyM1G2RpBLIOz+aFClJUE9p4UDJz9Y5823d0f0Yp3LnhKz02q1D
 OOhGnBB11TBTYpaTzQM+a3en+THow3qDwPnX++nnLzn0DpurOPrpjC0l83pg
X-ME-Proxy: <xmx:bvKCavU3iPiJmAr-E-iruMq5A12h_uGZGtZWQ6eylTVb4w2USIv9Rw>
 <xmx:bvKCajqiID08tmSbGqR9oGtSDF_2f2oaA_-jQhRLAmnRqZSDj-ZbDA>
 <xmx:bvKCamskjIvQSw7QPkLvd3X_iVEkSmt71H0EVROaKIthtRj1QyWM3Q>
 <xmx:bvKCapQAdLRaZl7sNOXP7bmnRH4OZqb7Lq4Qc5pOSni0KHQsy8C4lA>
 <xmx:b_KCasZXnas407wd-J8bX7dLWy64HhiHO2ku2QUq7a7MI_olUhLSAnns>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:37:11 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v8 06/12] dt-bindings: iommu: rockchip: describe the RK3576
 NPU MMU
Date: Mon, 17 Aug 2026 23:35:57 +1200
Message-ID: <20260817113603.1436067-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
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

The RK3576 NPU MMUs are rk3568-iommu compatible but take five clocks
where every other Rockchip MMU takes two, the extra three being the
compute clock and the two convolution buffer clocks.

Give them a compatible of their own and pin both sides with an allOf, so
that an rk3568-iommu cannot carry five clocks and an NPU MMU cannot
carry two. Describing the extra clocks as belonging to one SoC without
saying so in the schema, which is what a comment on a description does,
leaves both of those spellings valid.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 .../bindings/iommu/rockchip,iommu.yaml        | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
index 6ce41d11f..83d7e7c8e 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.yaml
@@ -26,6 +26,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3576-iommu
+              - rockchip,rk3576-npu-iommu
               - rockchip,rk3588-iommu
           - const: rockchip,rk3568-iommu
 
@@ -42,14 +43,22 @@ properties:
     minItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: Core clock
       - description: Interface clock
+      - description: Compute clock
+      - description: Convolution buffer core clock
+      - description: Convolution buffer interface clock
 
   clock-names:
+    minItems: 2
     items:
       - const: aclk
       - const: iface
+      - const: npu
+      - const: aclk_cbuf
+      - const: hclk_cbuf
 
   "#iommu-cells":
     const: 0
@@ -72,6 +81,25 @@ required:
   - clock-names
   - "#iommu-cells"
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3576-npu-iommu
+    then:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          minItems: 5
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

