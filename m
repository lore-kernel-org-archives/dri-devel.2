Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808CBC79F8C
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2298010F90E;
	Fri,  4 Sep 2026 13:09:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YuSe0syL";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2171E10E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:37 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-499dd4900dfso962095e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527375; x=1789132175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E/t7wxFBsuNgANZ3txwtSGvXS0Fyj90ixWLfFCZVhFw=;
 b=YuSe0syLNa6Kd8WOWSlt9QnZZzogTeF94wg01sHPu2F6zU6DQSxeg1bgxFaOl5YSxR
 DyuwJP+MmXzdYP0Ox7m4vRULe73rnx1KnNIDnThLzVk04/94MK4xxlZBnYmF5ANEAgJL
 y+wGhUnvffdRQ4bWn2towy464YBPuHQ8drZe6LbF1foKRcy043/qvvqHO7YuVvkMo42r
 DjpO+iXQI7p4PnvOU26voaK4UsNYqY7fVM3LLZuE3IQwYl4J3xhvNgu3ZGCAcOi3y1M3
 rrgetCgYA6aRquTGdVaogsWvtSbzPxYXVsdILjsFCDlxMdjPP4e1FlLRn3Hh1lulu7K1
 3fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527375; x=1789132175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E/t7wxFBsuNgANZ3txwtSGvXS0Fyj90ixWLfFCZVhFw=;
 b=OnfyfrimRACeSJS5FNTcWq4psqome/HOZK7VPjus0hqLOYk3wBNqsqtSh6Dsi28IQ2
 LeC3/BUnfn/WHGOxviiKNuMq8hJNuCtf+HzMNz/h/CfRZnmwKbqASB/HyKaHhSX3PfLb
 1ki7FwwVlsdF7i770I6RRH/X1anHFasjffR0f1tPL/2xMstbcXGJO1JXh6ywRW5Z0OLo
 b6Fm1fHkfIJ91GZBMB+grB7n3MQukvFmzxQyxH+uZXKxeHSDktF69MDhbi+P+WRE3QO0
 MPKF1Pq7xV1xHztktG05aymgTVf292jEXLwmvsGyb5xdLqcUJidWAX0jeFaI6InDhsSl
 Usjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+5n/r7/9UU1l8FnI5EzoFAE7v1E5BbM4N1cDEtVR9gbratIh3NlfhIJUTIJpMeznNTt00TQ7YhXY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nxt6EGTu38Bt3Wvw++9Yb+pcWb6D2Bn+MGQVcVvQUoMWjyJRLc
 QRSR9cQdZLMvlkuEATiPLuSHBTmm7/s1RiqL4VeMxcco+I+q8ABXeQMh
X-Gm-Gg: AYBFou3w4df2ZQbi9MU3Q3F+8Osm0ioMXQVGywcl2fHcnkva4yGbhKz0abzFwv7J9mL
 sfg2v4y9JZ4nM4BvMAyaYTkA1C7wbb8R5gNfmQ5TeNuPfVK1an0zTOBzWV0fOHOHNmhmafH/omL
 R55XNcg56HoSDgGrDRrTrGODF6fNj49HoUj9hV5GYdgw2FFW4BRNNB/ehoKguq7Jew6OthuCkEZ
 EE3ZYKLx2WHo5Hd+LZANvweM9AUuZFgZ+kzQ/mAvP6FqTR63LBZwBkMwXPQjNkdZm95OfAd94uC
 vjiorI5YV+BC3TQyUv0JbWOs4rx5swxnpaPz4r3vV7gICMiNp130HTt4PMf7ZMHoBtKaI5aiHfO
 F8XqYP00YjYj9SAJq1MtOzDmwZf11oEH32RoG8aMgYnNuZNf5wUzHa9AJzarWJsyoZTx497huZz
 46ZMOFGhbK5G36OFQYvJiuSnPyeZbbG51dzq8QYyfhXhay1V4y1V7WTrk/uUggaGso7OJ10xi4m
 OvI/OHTS7V4tw/VofwS8XaQbSrZlGY9Xca3Uh+3Gwz3pBZXuu37V31+akwCQOXUwd8F
X-Received: by 2002:a05:600c:1c24:b0:49b:9241:7ff0 with SMTP id
 5b1f17b1804b1-49cf7f4d9b7mr51876155e9.0.1788527375338; 
 Fri, 04 Sep 2026 06:09:35 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:35 -0700 (PDT)
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
Subject: [PATCH 7/7] arm64: dts: rockchip: rk3588: add passive cooling to the
 NPU thermal zone
Date: Fri,  4 Sep 2026 15:08:58 +0200
Message-ID: <20260904130858.27803-8-royalnet026@gmail.com>
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

The NPU zone has had only a critical trip at 115 degrees, which is a
shutdown and not a cooling policy. Now that the NPU can be throttled by
capping its clock, give the zone a passive trip and a cooling map, in the
same shape and at the same temperatures as the GPU zone right above it:
85 degrees with 2 degrees of hysteresis, and a 100 ms passive polling
delay.

The #cooling-cells property goes on rknn_core_0, the core that carries the
shared clock and the OPP table. The other two cores have no clock of their
own and cannot be throttled independently of it.

The cooling map is inert until the driver registers a cooling device:
thermal_of_should_bind() only resolves a map entry once a matching cdev
appears, so this patch on its own changes nothing but the trip point.

The thermal path itself has not been exercised on the board this was
written on. Reaching 85 degrees on an NPU workload with the fan curve here
has not been possible, so what is verified is that the zone parses and
binds, not that throttling engages at temperature.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM checkpatch dtbs_check
---
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
index 376ad04e07869..c3d22b08f415b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-base.dtsi
@@ -1162,6 +1162,7 @@ rknn_core_0: npu@fdab0000 {
 		clock-names = "aclk", "hclk", "npu", "pclk";
 		assigned-clocks = <&scmi_clk SCMI_CLK_NPU>;
 		assigned-clock-rates = <200000000>;
+		#cooling-cells = <2>;
 		resets = <&cru SRST_A_RKNN0>, <&cru SRST_H_RKNN0>;
 		reset-names = "srst_a", "srst_h";
 		power-domains = <&power RK3588_PD_NPUTOP>;
@@ -3212,17 +3213,31 @@ map0 {
 		};
 
 		npu_thermal: npu-thermal {
-			polling-delay-passive = <0>;
+			polling-delay-passive = <100>;
 			polling-delay = <0>;
 			thermal-sensors = <&tsadc 6>;
 
 			trips {
+				npu_alert: npu-alert {
+					temperature = <85000>;
+					hysteresis = <2000>;
+					type = "passive";
+				};
+
 				npu_crit: npu-crit {
 					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
 			};
+
+			cooling-maps {
+				map0 {
+					trip = <&npu_alert>;
+					cooling-device =
+						<&rknn_core_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
 		};
 	};
 
-- 
2.43.0

