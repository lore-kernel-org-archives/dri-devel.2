Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C42C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AE810E63E;
	Tue, 22 Sep 2026 08:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Je304Rnk";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1F2310E635
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:36 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843178b1c8so405664f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064095; x=1790668895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gRVzD7/e6IROrFrMTSU32rtgAKkxa5C4zngEyHP7gSA=;
 b=Je304RnkalQi3nuB6/hBnbucLM4T18VC08d760pe7Us6D6X4jE8AuXLBm0qERSKcNd
 OZ8mEnyV4+ZxV3MrKfpzjrjh33ql+i1WOMz3EEqpoIG1zetwTU9B9jAmd2cFehqyfe1R
 +rz2beaBpr1NQy8tXLKtJsUlQEXXF23GJCVLzeq+5lfxqExzftjaWNC2xGu4dIK9AtXm
 iaaTy0OVlXoS0rV1mijwAQHqDZF0ZqNftl0NdHWJgMtOufOtHXc7P3ZEsaJ+8ExOHFVv
 KchE1scCs8JlVWywis1T5De7vVO9vp0dbCI/Ecekq/436D39ORr4Si1UKXK8VvN3aq1I
 Tf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064095; x=1790668895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gRVzD7/e6IROrFrMTSU32rtgAKkxa5C4zngEyHP7gSA=;
 b=qMA86KJL3gZySpbfySrYKiB+K2kipFVTQ5ECm0DuOpiCytvjC4KfG7KGIJCNhyOWZV
 PlK9qS/Tmh5N9vlH+0yZBir9IHK4cIydE/GZhiepC1wLuScfaHkruMOCPlm2F1MK/JtT
 l5aPbYADjhDHvyGAVU8mRcj6zkMdB52nx87zQJRokhHLEsmLcemMM0NXrv3aam5aZTft
 Dj60GytzTg8oR/8weYcSo+TYidmkilCcA8Z/lpZ1JjbTsTxlU7eNYUwyoWmEQqQSm77x
 n2CeOAMUrub/nw+JZLHpwuAXtpPurf1ybcGvvjmJGRfXZaSHLz5+gocnguRT3msXvImX
 M32Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIngBoLhorWHn2ov0idBvQhXNpgL2pGQWH0PRVrSjLddFn11EZvzJK38QoJamaBJKVZGesopTeHN0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8BxR0An0PtZ6LqkAM793f5KU2dl38et5uRvx+9WXbnr36IH68
 ttGv92t3ul4uMqgfE3RfXqI9j0MlvKMJmyIZDoSFjui3BecaBVIdhKHN
X-Gm-Gg: AYBFou0cLkogROQ/YtEKdqRbIl9Z1xxnTd7uSAUPds/i+Q1RZs0zs5nJfdsf2Qvtji1
 iCY9KTfDJnYNSbPfuZ5DgD3akK0HU/uPCiuYgPSAauOGd+PSa5X8/Y5TB8nYlrD8eC4f1ImwDqM
 zd8WF0knp5xIHcqgTx2WAMIrHUWGsFCGN6iCJdV3U/VBHCnSixhTjyRrysAecLa6fUIDkYSbQLx
 kcQQNQ2ld1DP9zt0Z1sywwHE7U+bNU4K7QFpGWScWbaqKR7bs03xi43iYCtigwzJudO3HX6iRuQ
 09lW8UaZCZY7ho0Rsq07gXCxjUCAguj50J031r4InSkwrVli14cVB8ONR4LiKYacZjm1bB2TgVS
 7KbxqImGjefMo9sfht3oeomV1MJE73jUCgyvP4Ts2WDsSP/+QIvKDbCq+m1pDSripty6rmy+XOx
 OFi2mKvqbJ3ntKR3NZt/aH1SuDrBP8JpMDWJuYIa0vHsPi5xPCaDfz6k7JoMf7ujOvDxy2XMD1X
 i/SCHQhx3L00F+NdNoordAQKpFmSFXdy10PsvBkDRVk35XIwdINL0SzmvQV3y9Ei4EWCXMX16k3
 /Bw=
X-Received: by 2002:a05:600c:609b:b0:49c:f9b8:bae0 with SMTP id
 5b1f17b1804b1-49fc7f2bdc8mr199260285e9.2.1790064093776; 
 Tue, 22 Sep 2026 01:01:33 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:33 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 06/11] dt-bindings: npu: rockchip: allow DVFS and thermal
 properties
Date: Tue, 22 Sep 2026 10:01:09 +0200
Message-ID: <20260922080114.44662-7-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
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

Throttling the NPU from a thermal zone needs a core node to be usable as
a cooling device, so allow #cooling-cells too.

The OPP table belongs on every core, with opp-shared: the cores have no
clock of their own, and one shared table for one shared clock is the same
shape a CPU cluster uses. #cooling-cells goes on one core only, the one a
thermal zone's cooling map names, because the cores cannot be throttled
independently. Naming one representative node for a shared frequency
domain is the established shape, as in "Cpufreq cooling device on CPU0"
in Documentation/devicetree/bindings/thermal/thermal-cooling-devices.yaml.

The schema cannot enforce which core carries #cooling-cells, because all
three cores share a compatible string and a node name pattern, so that
stays a devicetree convention. That is the same situation as for CPU
cooling, where cpus.yaml does not restrict #cooling-cells to cpu@0
either.

The example gains #cooling-cells; the operating-points-v2 property is
exercised by the RK3588 devicetree later in this series.

Assisted-by: LLM checkpatch dt_binding_check
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v2: the text on where the properties go is rewritten for opp-shared on
all three cores, following Nicolas Dufresne's review of v1 3/7. The
only change to the schema file is the wording of the #cooling-cells
description; the constraints and the example are unchanged. Conor, your
Ack is kept on that basis; please say if it no longer holds.

 .../bindings/npu/rockchip,rk3588-rknn-core.yaml        | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a4903cd1..beba1896156f5 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -42,6 +42,13 @@ properties:
       - const: npu
       - const: pclk
 
+  "#cooling-cells":
+    description:
+      Present on one core only, the first, which stands for the shared NPU
+      clock as a cooling device. The other cores have no clock of their own
+      and cannot be throttled independently of it.
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

