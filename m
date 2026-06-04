Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE30ECD8C82
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 13:53:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4754111A0DE;
	Thu,  4 Jun 2026 13:53:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f8oDPbao";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D7B11A0CF
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 13:53:06 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso8307495e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 06:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780581184; x=1781185984; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6AgZYnyS4i6ey0fjJps0/Fygo8+mCWzQwi4kSxOwSD0=;
 b=f8oDPbaoiHONzqeBNXsEcCKrAsNkpWRQ/lA4qAqn34VH+feJo90Ln76ePPbIGwSa5D
 la7sV07g3KZAQ9Ws3Lr/mvUCMRZ0dt+ej75z5P/jTFu9NFHtFO9Y7OolSNImwvJHDZ2+
 4S1vhZ6WiPpYLZl44vnFVDm5AQHPUQW8VEpqoWj6QeRBeNJp8wQAe/tdhIBkM+5jr/eC
 wxVLUjWEOFVUF0JRLpLZDIwnfIifz80Lh4VYEUI5gFCqfs3br467TkFfXjGGWmJtk/Jy
 S1Gmye5nMQFDVDkO7l8ityRRjxiqO39V0BzwARMfjMRM4/3+9ANIasugzSiuuXPsJePP
 0ScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780581184; x=1781185984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6AgZYnyS4i6ey0fjJps0/Fygo8+mCWzQwi4kSxOwSD0=;
 b=sf9APcMu2G9tAJyjtzZk3L07pvEvmw02rgdl5PjaWHzrJqUNtTLn88r9pGRz5Ry2z3
 4iIOKB2dWZAibRnKwmk62I7aLusP5uIWD3vNDJqnCqDBQ1tdF+y3TLJkTwz7w5Htn6lu
 qAoDRCIt3qIfkzEfQ13RYzcYik6ka8+ts6oD73VnImj23CFjKvgPbHMJRjIr9V86dy+t
 G9s6+huyL1bKez4t+upOpBXer73meHtKp1lDVEQU3WuXmmbTOnzorGvcLMm8vfn5YOsN
 BfhJepOoqpyJMn3o6wxT+5jNRxjszLkkc58K5vv+wPYZAvXRLxE+jGQK6pzdkDKVsYCG
 Hkxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DP3yyBXvacFlw4uUaT0XhmxfqBAullI39so+UXFcb9JpUzXBkYBDuOs0nXxzfQCXUdyFK2dPrvR4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzigxmfCn6+HjFqgOVj18uEqua9M1kqkZL1TOKScSAeOimU6KdP
 dH7M3xktfH1LfkEjTpvcgijMvAem7RpiPOL74AWobWyromuUqD7hMtDyaMNM28SENpX3Mw==
X-Gm-Gg: Acq92OEjPhBhe0EyhPin1CX0I39uaqdYEn9J8nH3n87MuAtB+mqJ5PdfkB1B7sNB7pc
 RldrzSSB0tBihWDZTxp2+8QVc2kpc34N5JBqbL+Kadamk2kYVG32BKhaQjVM5RfwszeycIMcFFw
 eKoRlb6r1bRZWXoxZ4HQO/5UmAPLB+PXJKoXzOkZ2QnblUrQxnwKl+4Vjv1p5FL9aLDzgnDLRrC
 QTgA4y1YQeB+yoFCGAiEjzmaj47n3JJ/eh6Gs1VoScIYFTYiVG/9HBu8D+sRjblOGXo/svj/YnC
 VscotEcCblXVb54sy85ePqnrMucw0/Fa7rFJl7zH3UiH80Daq51Djctv0dM2t3tL9CFRorU18c0
 oBiisy84++oaZOjJu5aSSa9CVBp9OZo76r91pFkwdrsUTkTBoiBZn5xg+Ts5n1ZwHgy4COuS4Fh
 LlcC46qXdcERLGFbYUsnG+3UcqORM/8L0Xvm/TMCI26h3NroqvRn4TFKpkvHvjcZc=
X-Received: by 2002:a05:600c:5288:b0:490:b473:8f78 with SMTP id
 5b1f17b1804b1-490b5ec3ae6mr133508845e9.17.1780581184471; 
 Thu, 04 Jun 2026 06:53:04 -0700 (PDT)
Received: from compiler-rock3b.tailb81abf.ts.net
 ([2a01:e0a:104a:4d80:be24:11ff:fe12:2776])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f0a43e9sm16661068f8f.0.2026.06.04.06.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 06:53:04 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: tomeu@tomeuvizoso.net, ogabbay@kernel.org, heiko@sntech.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org,
 will@kernel.org
Cc: robin.murphy@arm.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 9/9] arm64: dts: rockchip: rk3568-rock-3b: Enable the
 NPU
Date: Thu,  4 Jun 2026 13:52:55 +0000
Message-Id: <20260604135255.62682-10-midgy971@gmail.com>
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

Enable the NPU and its IOMMU on ROCK 3B.

vdd_npu is marked always-on so the rail is up before genpd de-idles the
NPU NoC at power-on: the PMU de-idle handshake needs the rail powered.
The PVTPLL compute clock is brought up later by the driver.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
index 69001e453732e..7ac780ed313d5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3b.dts
@@ -330,8 +330,10 @@ regulator-state-mem {
 
 			vdd_npu: DCDC_REG4 {
 				regulator-name = "vdd_npu";
+				regulator-always-on;
+				regulator-boot-on;
 				regulator-initial-mode = <0x2>;
-				regulator-min-microvolt = <500000>;
+				regulator-min-microvolt = <825000>;
 				regulator-max-microvolt = <1350000>;
 				regulator-ramp-delay = <6001>;
 
@@ -787,3 +789,13 @@ vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi_in_vp0>;
 	};
 };
+
+&rknn_core_0 {
+	npu-supply = <&vdd_npu>;
+	status = "okay";
+};
+
+&rknn_mmu_0 {
+	status = "okay";
+};
+
-- 
2.39.5

