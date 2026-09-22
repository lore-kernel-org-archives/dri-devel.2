Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55446C98308
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C9410E918;
	Tue, 22 Sep 2026 08:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YK46PFug";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB6610E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:36 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49fbca514f8so2712755e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064095; x=1790668895; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C/lMPPdyVDY8UDcv/G9hmnqUs4LxNskElZuOnfztMlQ=;
 b=YK46PFug3HFjaUDXJUue+pJ0BesUku4nvuXDJHVkqotbO6R2jAnY/97OCuzWDWTBz+
 SE2c2yK++eWMkkCRvTW4GfHwLp8XiFgHuf6SxBTNb4zldIZv169/LIXfb1UGocqejSKJ
 JFIJJmwE39g9jJcy8icOOOY8t+LlxCAUGqhJOCL2lExUNpAfPvtfuVNM+G+IUoE2R649
 MlMRYzeCIH0zxy/Vy1a9Sq+Ngr8lPIPegk5cHLJEBFiex29gvpksUZKPVS8sCrYAKLmp
 LShn8J+U69aIWioCrllp8Hdopeftw+Cq/P/DEBusMpAstPccro0CA050wYXuw0X28qRz
 viHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064095; x=1790668895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C/lMPPdyVDY8UDcv/G9hmnqUs4LxNskElZuOnfztMlQ=;
 b=Ef64k1zJ4drYmneR5l8sMIqNl0Vh1HgP31AIRRDnIYByToCPv6EhdA+w/gP9APYpDe
 K+OxVOnSt4bpN7CClT01nzU2K/20gRkdrjV1KTRd0Fvw95IxpkE1Osy2PyZcjjr5IPK3
 BhE4iZNoSYa41BzVPjJVlU/l12SPyv7eVX0f/DFgIz7+fRdtYW+veaFxPbEyuqCNgLap
 WkjsBWEt3Y4vfgN1xuMvL4XHySgpjzYZAtIO1q9Usg1fm30kr84iityFmdy597VEXXZD
 UkEOrehl0RDHhKZxSeVd5qrOZo1A6nWM93V8UjfVQHW6ntksL2qLcBGyI2rSBmovCYfM
 hKTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw63v10qtQ40i5nMO2Ln/+Kuyz5hUbpmNAmzz8bGqEZtpoK+YQfa12LnGNiVoapZi6m/7OeL0OIGtY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m0kUYOCQsgAL/nFPIkp3vwjcgPAtF1V3+DHHUDyktI3kw5nOXS
 ofiP0RLbZya4Rw/JjBxdbEBKhEjjnXWqVZkdmJZzIi9BNn7VdWvZQ9UB
X-Gm-Gg: AYBFou3nTLj/N+u6XIhzGDfUnDGDwCbvuwH4tulSgEkJMBCpj7npIvFUxeok0Fsp2g4
 qkX7SyinJZh3PCEnFDEObovWaMASReLmoyyCW5z1hHt7RHX6iT/pISIOFWJTeiNYkcXV6Po2e57
 HMzEIsNGNKa0sbbQ87UuuFoeAwxYCYcWgmJPo3EWMVZfjta/TZx4W6NExO1qjRCjRSFRmbgkm+9
 gBBq89AXCCZT5cstXjyM6dlmP7tXSjp+OxbPVZUCB+BdRMuxBNwpzXcFJycAYNxbMzkZBneXoaf
 DwiwpLXuilS9aXGQFp/hEbThuKPdYRZx6TmVJJtYzX0B6cT89fUiqK/v6/vPpBDM59RNm9jjFRd
 ZGuesZmRVJsKBiR+vHQOw3RcYJv6zcPdNZ2tY2Jj51NctpGCbe/nwDTStelMDtQ9xTf12aYWqEz
 4WuVLjv0gjeD9sc3KB5IDrrxQDl7x1ue6vo73AXUqfpilAhk54/O3zax3Pg0Vp5RoXi/kkRZfrs
 ODwSsprG7/7O+Jyte+ZAYiABSQML+Z3KoZ37J7qmBXhORerZ+iIjBLMiIKtNuOClf1x1YBDU3o+
 hu3c2BrwrlBTbQ==
X-Received: by 2002:a05:600c:354e:b0:49e:479b:c13b with SMTP id
 5b1f17b1804b1-49fc7dff668mr165633455e9.1.1790064095154; 
 Tue, 22 Sep 2026 01:01:35 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:34 -0700 (PDT)
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
Subject: [PATCH v2 07/11] arm64: dts: rockchip: rk3588: add an OPP table for
 the NPU
Date: Tue, 22 Sep 2026 10:01:10 +0200
Message-ID: <20260922080114.44662-8-royalnet026@gmail.com>
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

The NPU compute clock is driven by the firmware, which only accepts one of
the rates in its own PVTPLL table: 300, 400, 500, 600, 700, 800, 900 and
1000 MHz through the PVTPLL, plus 200 MHz off GPLL. Anything else comes
back as SCMI_INVALID_PARAMETERS, and that refusal never reaches the caller:
the clock framework does not look at what the clock's set_rate returns, so
clk_set_rate() reports success and the clock stays where it was. The table
therefore has to name those rates exactly rather than describe a range.

200 MHz is included even though the vendor table stops at 300, because
mainline pins the cores there with assigned-clock-rates, the firmware's
table names 200 MHz exactly, on its GPLL path, and that is the rate the
NPU boots and idles at. Its voltage is the same 700 mV the vendor uses for
300 MHz, so it is conservative.

The voltages are the vendor's, and the upper half of the table matches the
GPU table in this file step for step: 700 MHz at 700 mV, 800 at 750, 900 at
800, 1000 at 850. There is no PVTM or binning here, for the same reason the
GPU table has none: mainline uses conservative worst-case voltages instead
of per-chip nvmem data.

The table is marked opp-shared and referenced from all three cores. They
have one clock and one supply between them and cannot be scaled
independently, and that is what opp-shared describes: one table for one
clock, the way a CPU cluster shares its table.

The full SoC range is described rather than a per-board subset, so that a
board which cannot cool the upper rates drops them in its own .dts with a
/delete-node/ on the OPP it does not want. A board may only delete OPPs
that way, never invent intermediate ones: a rate that is not in the
firmware's table is refused by the firmware, but the kernel never learns
of it, so an invented OPP would be refused while the kernel went on
reporting it as set.

rk3588j.dtsi does not include this file; it carries its own derated tables
for the CPU clusters and the GPU, and it gets no NPU table here. That is
deliberate. The J part is rated lower than the rates in this table and none
of it can be measured on the hardware this was written on, so inventing a
derated NPU table would be guessing. Its NPU node stays disabled, so
nothing binds and the cooling map added later in this series is simply
never resolved.

The same rates and voltages were arrived at independently by Nicolas
Dufresne in a proof of concept that was never posted to the list; his
version differs in that it marks 200 MHz as opp-suspend and drops the
assigned-clock-rates pins.
Link: https://gitlab.collabora.com/nicolas/linux/-/commits/rock5b-npu-poc-4

Assisted-by: LLM checkpatch dtbs_check
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v2:
- opp-shared, and the table referenced from all three cores (Nicolas).
- The opp-suspend paragraph is gone. In the v1 thread I said v2 would
  argue that the driver already puts the device back at its boot rate;
  that is again driver behaviour used as a devicetree argument, which is
  what Nicolas objected to, so I am not making it. Whether opp-suspend
  at 200 MHz describes the hardware is a question for the DT
  maintainers, in the cover letter.
- "give a driver nowhere to return to" is gone for the same reason.
- The paragraph on the table being inert until the driver patch is
  gone (Nicolas).
- New: the firmware's refusal of a rate is not reported back through the
  clock framework. Found by reading clk_change_rate() in drivers/clk/clk.c
  after a test that requested a rate outside the table.

 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi | 54 ++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
index b5d630d2c879f..59ecaef5101da 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi
@@ -151,6 +151,48 @@ opp-1000000000 {
 			opp-microvolt = <850000 850000 850000>;
 		};
 	};
+
+	npu_opp_table: opp-table-npu {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <700000 700000 850000>;
+		};
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <750000 750000 850000>;
+		};
+		opp-900000000 {
+			opp-hz = /bits/ 64 <900000000>;
+			opp-microvolt = <800000 800000 850000>;
+		};
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <850000 850000 850000>;
+		};
+	};
 };
 
 &cpu_b0 {
@@ -188,3 +230,15 @@ &cpu_l3 {
 &gpu {
 	operating-points-v2 = <&gpu_opp_table>;
 };
+
+&rknn_core_0 {
+	operating-points-v2 = <&npu_opp_table>;
+};
+
+&rknn_core_1 {
+	operating-points-v2 = <&npu_opp_table>;
+};
+
+&rknn_core_2 {
+	operating-points-v2 = <&npu_opp_table>;
+};
-- 
2.43.0

