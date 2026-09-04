Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D733FC79F87
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3211710F916;
	Fri,  4 Sep 2026 13:09:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GjErf8mm";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBE210E358
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:27 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-499db1740e4so337115e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527366; x=1789132166; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkYtc8Zy+X1nQtQQfmPXyE49NKh145BAfNH3nX3cWHM=;
 b=GjErf8mmONsLhP8/D1pS2jHoYYTTBqE4w3DWaEu7y2iR+0QzQn51okKZcCHp93vM9Y
 gSTvz9l8jG9Po8H0YQlojd8hx6DRaULmI6856KuOrD2qdM2tsOStSq0nDTlxoQ9rXcmo
 TupgH2dGDYOsla34Y5bGAIwHAh08/vD5nVHWYvn6yyWLE+qbv6B6wso7TPFSmEBpP5v0
 Z3gRlXKEFXO15SN9L47MZsMISAmwnbqymNTq1mOdOIGUmBGDjlk5Dp0GQ2WLjZIH3rwZ
 zlEty4v1128LblfgrHjoACi4FVqM35rZLx5Zf41wIE6pyuEJhAdXi+1QtMVo4W1c6Aie
 UMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527366; x=1789132166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WkYtc8Zy+X1nQtQQfmPXyE49NKh145BAfNH3nX3cWHM=;
 b=bKzwB9icYgVcxBFQQxEN4bpW4rHhMTgy5Dku15esMHOwIWNYoZ/3TRAQGN+A9V3nKC
 UFpIjvZm8aPT+aSke0SF7Dk0DZDPISJrk8DA8k9z5/IjUohSTMEJKTopBhrVhwpB8uMA
 oSn0tycIsu3tmmS9GAmJd5uFHJ8oM1MnBnzdGb3wUVg39kkdezxQPKNGgMw9Cc4kU4Yy
 JQ8LvtUoVDPRWiTYYtKHcbA9TW/7WEH2sXVBi79+w5gG+puCDEEXe/p+CX1v90cn1bpw
 85gc1GNCtwEv49wa+bxywJ2EgwKqbOGHHMwXjS1rWk8+gqIIIvKaJfaXNpDyKwdSDM4W
 X0Zg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQGrAbAMpPrKB92+7KY9XbZ+0mphpPlaa5HspNuEx20OYjGW8Lsbxm5RFRuLTzrnMP7NSd/DYBqDo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++myMNgcVmdXrvhzDLjMxOBSO3/RtNjarasKoepUrY0Ku+80BrjK
 CXej11uBj5XjVyIkRg3ztMiCVtv4gSq/2TEkGZ0lVyzD85H4Bc84H/TI
X-Gm-Gg: AYBFou0ZaODATqDJH8aptIBVSNTCuwhiSFiAdX4o8q4rQnJ+q/XSCl9Ng74ktbWQDvm
 7Nxm2s7pdDsVodfBdmtFa17GZ8xaXBjkkfXGoC5DEyD1eswi/hiFyp7AmHadqoXY4TNsi/HO9K5
 sR7nWBx19Is3SmZYPY09X55Kl0igPkMJde/aSAe1NDhz5/ITDhwnB0ADQOpbYzgBRc6soNsob/+
 hPwAVNvi9ByNL4KV8td5ZA3jTe2BPXPYnZ4xJG83sAl9Tsc5qlWE3Wpj9MAXmGT82sgaN9wQVAy
 cJwL+2fqrIRrYP0s/vYDZlpQR5HD3LHMKXm8kUuoZpFkva+bo8D065i6uqkNAx+Txe3njuNZmxn
 ANvLzLG4pXF8daaazu230exeswLHNxxCRt7VPezfZxfhA8ZCsBssjPS52rSI5f11ZPRPMhFYX/z
 1BfGow13YHyIdWNN0BY6BBihotaxnMpbpIRemwFTFPuVwIrwrm1BtWSNBV5M4lFvNbOFaNB7mb/
 tB43gXRr664p2k772LUU3Xw+drCwB0c69DqPFbwQWhiwyRwyfBTDxXOqqmnaqis7vSkP3K3KnXd
 nnleTqf8o/QVzVE=
X-Received: by 2002:a05:600c:34c5:b0:499:cef6:104c with SMTP id
 5b1f17b1804b1-49cf823c012mr41127815e9.1.1788527365941; 
 Fri, 04 Sep 2026 06:09:25 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:25 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 2/7] dt-bindings: npu: rockchip: allow DVFS and thermal
 properties
Date: Fri,  4 Sep 2026 15:08:53 +0200
Message-ID: <20260904130858.27803-3-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904130858.27803-1-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
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

The three NPU cores on the RK3588 are fed by a single clock and a single
supply, and the firmware accepts a fixed set of rates for that clock.
Describing those rates as an operating-points-v2 table is what lets a
driver scale the NPU instead of leaving it at whatever rate the bootloader
set, so allow the property on the core node.

Throttling the NPU from a thermal zone needs the same node to be usable as
a cooling device, so allow #cooling-cells too.

Both properties belong on the core that carries the shared clock, not on
all three: the cores have no clock of their own and cannot be scaled or
throttled independently. Naming one representative node for a shared
frequency domain is the established shape, as in "Cpufreq cooling device
on CPU0" in
Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml.

The schema cannot enforce that placement, because all three cores share a
compatible string and a node name pattern, so which core carries them
stays a devicetree convention. That is the same situation as for CPU
cooling, where cpus.yaml does not restrict #cooling-cells to cpu@0 either.

The example gains #cooling-cells; the operating-points-v2 property is
exercised by the RK3588 devicetree later in this series.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM checkpatch dt_binding_check
---
 .../bindings/npu/rockchip,rk3588-rknn-core.yaml        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd1..595aacfbf8608 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -42,6 +42,13 @@ properties:
       - const: npu
       - const: pclk
 
+  "#cooling-cells":
+    description:
+      Present on the core that drives the shared NPU clock, which is the one
+      the operating-points-v2 table below is attached to. The other cores
+      cannot be throttled independently of it.
+    const: 2
+
   interrupts:
     maxItems: 1
 
@@ -50,6 +57,8 @@ properties:
 
   npu-supply: true
 
+  operating-points-v2: true
+
   power-domains:
     maxItems: 1
 
@@ -100,6 +109,7 @@ examples:
         clocks = <&cru ACLK_NPU0>, <&cru HCLK_NPU0>,
                  <&scmi_clk SCMI_CLK_NPU>, <&cru PCLK_NPU_ROOT>;
         clock-names = "aclk", "hclk", "npu", "pclk";
+        #cooling-cells = <2>;
         interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH 0>;
         iommus = <&rknn_mmu_0>;
         npu-supply = <&vdd_npu_s0>;
-- 
2.43.0

