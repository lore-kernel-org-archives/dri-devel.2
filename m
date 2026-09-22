Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB94C982FF
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB91F10E61F;
	Tue, 22 Sep 2026 08:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n79EOzb1";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB3A510E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:42 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cfbdac7a1so1756535e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064101; x=1790668901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k8SSEreitnBFuEXQj3F3dce2S1yQFmhptrw7zyYrACU=;
 b=n79EOzb1AM8H1XuePdxE0FCaSNQNnnDFcIRc4jF7mX3gDFUOZ5TqeI1Eh0F7bJXQcS
 68CHNStCnvMsA1g2FeZ6XhgyXu9pn38UQcK4Q/5D3LwGTRl5r85Csa6KsA0Mewln09rs
 kSeaeT1I5IWKfhezjmCDGWr2ja2xkMam3bRU4Ah93T3B6VKUODJu8oCVPm0BxD+GGTfI
 6qUp3MsSXBzdqCLzO1enHXpfVQ1IL/0CJ5hDrnmp+rGDtgOwxhPVPPg0coSEpGZL6w7e
 uU/oLcdek9XAHO77XU6vXxSIsae2XI9KII68Yp13aDobr+a8uv5vVUHLQ+2Qq/cfI8ye
 xPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064101; x=1790668901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k8SSEreitnBFuEXQj3F3dce2S1yQFmhptrw7zyYrACU=;
 b=pymbZhAxzr5ln6Fd9bJxmcyEbIjkKR7DgJ7FbGz8RX9l/9HQfBXqUnQLOFdgCGe72j
 XVMtDIA8UaCmPtJrTNBrAbX5RZTmgqVFw6TaX6+CXzFxdwgyb9fbrGj4wykh3jHgknmA
 6no+CnrFlZzo36YySXTZKJ4yD1Vg8tiqe7j4OXpon9arPblnk0Dp0B7cLbFisUHBVOOZ
 pOB7AaGSiqP1AFQIQlqLjudlm4y0T7KVgN76fNkLqLJerLWLQf7W3cczRBwpmN+JYl1N
 gvdqlHhTOWzZT2M2a6RLdSA74KRVMzsyo+qSSAKsXMeUFB7pti7Wx6cJKEzt5KEuc+og
 09Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwWnra3zk8evqB/5n/aFQdKWD5gb90zuaAClehfERvbdMWBv5EngDNg4rbnl7oXHRSEwysbdGTeKNk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lsuo1cbze91jzrgC68+8AXEp8+Lg7fEqfFXTAD+f3z+Blj7tTt
 +Zd0hE6E1qvnvSIc5SgioxAJaZFUKmJFyIA+xQhdfZEo8+EUUSqjfXOL
X-Gm-Gg: AYBFou2KB0IFPQG3NRLAHOaiIvjRceTUonyczcQc3yoF66cIJURBRZ8nkcIxCcuujTR
 jy2PmYMgMm2V1jRCTXCBSO7HxCwU+or047KBIeIJ7f9GSfgHcUG1gzQxSx6v49OuvN9F4yRzF8a
 0YwMMZ5UjT6tfal4qJiKeLuYjsHIYPyY45YaK6rHPuCDb/kRwP/6mh4wNqjJpKNDl5GsxSMFDNW
 X6aUo0UUdqsYG8VE53Y/YGh5gGezSozGPMLd29dH6aVu1qJcJeLwqkr/vw/l4p8YOF9Pb19O88E
 k/2dCirkd3wEm/+wlXMHPkoXbu00ZIETC8gsUE00Z0gnBsYnY0tvqfe+50dfhTN+wPt0iVFB2Xd
 G+BG4BOPhX34U2aaQ8viLMBZ7rKVrRQbJA5OXDBb4XZ/Ra4HWksg3MV1noBlWeRqFU7px2eyayJ
 s6+GE6Or18S+39z6/HhPyfwglVULiHideW+nCyVYm+4Gm+P5O7ZGlgTqFtsPgx4AxAO74U+SIRV
 QciJ5SiJ+bo+mcKBur2ELACo3amfpeYUF4hKICK/w4BZIs5Lcw8eO6jvYfMDxM+AOPT3Qr46wWm
 RnI=
X-Received: by 2002:a05:600c:6992:b0:49b:9241:7ff0 with SMTP id
 5b1f17b1804b1-49fc7b7a756mr226941795e9.0.1790064100738; 
 Tue, 22 Sep 2026 01:01:40 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:40 -0700 (PDT)
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
Subject: [PATCH v2 11/11] arm64: dts: rockchip: rk3588: add passive cooling to
 the NPU thermal zone
Date: Tue, 22 Sep 2026 10:01:14 +0200
Message-ID: <20260922080114.44662-12-royalnet026@gmail.com>
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

The NPU zone has had only a critical trip at 115 degrees, which is a
shutdown and not a cooling policy. Now that the NPU can be throttled by
capping its clock, give the zone a passive trip and a cooling map, in the
same shape and at the same temperatures as the GPU zone right above it:
85 degrees with 2 degrees of hysteresis, and a 100 ms passive polling
delay.

The #cooling-cells property goes on rknn_core_0, the first of the three
core nodes, as the one node that stands for the shared clock as a cooling
device. The other two cores have no clock of their own and cannot be
throttled independently of it.

The cooling map is inert until the driver registers a cooling device:
thermal_of_should_bind() only resolves a map entry once a matching cdev
appears, so this patch on its own changes nothing but the trip point. On a
board that leaves the NPU disabled the passive trip has no cooling device
to act on and only changes the polling rate above 85 degrees, as the GPU
zone's trip already does on a board without the GPU.

The thermal path itself has not been exercised on the board this was
written on. Reaching 85 degrees on an NPU workload with the fan curve here
has not been possible, so what is verified is that the zone parses and
binds, not that throttling engages at temperature.

Assisted-by: LLM checkpatch dtbs_check
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v2: commit message only: wording for the shared table, and a sentence
on boards that leave the NPU disabled. The diff is unchanged.

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

