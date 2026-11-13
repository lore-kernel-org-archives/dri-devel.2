Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2439606A881
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d9ZoCXxM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C270B1126B3;
	Fri, 13 Nov 2026 16:19:30 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27AB1126A1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:19:00 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c4d30639709so216228166b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586739; x=1795191539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQWld2rf0aUSCLxpuKReQRUF3uIzkNsM8ey4gCHu/88=;
 b=d9ZoCXxMNP587bf10n/nqHLfSjNXdMBeeJDJljLUnqgpqQPJvxIpG2LQn1GRixk7/W
 Z4yHAdAxvp1Thpol5RMOf16WmATrefHDQyn7c2IUC89v3j1hDwM6+miw4j7iG7WDaEdp
 DQvLmhsyUb0lJDgeIjUSgW/f4EDejk3wPqwRKz8ON9rmMkDU/V08xjSr8U7zT0S9ylvh
 /0YoTHW6ji0VfBLNCU8aE7Zdw77bW1FDlebDY3yBZEq6euqibNp2K2jCj1i/52BOERf9
 YMzWcMc6dd9sPU7H6QeiwlDjJe9dUqMCEHTCFxC3/Gx+1//eBFBW6ylgc2TvH4bfUB90
 ZQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586739; x=1795191539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mQWld2rf0aUSCLxpuKReQRUF3uIzkNsM8ey4gCHu/88=;
 b=WDMHT7Q9yKHIJ5G4bc5bGCNREnPkIjXAVZNL4XdAjAE6aB+/7KuHRqK/VYjqQk6Z8p
 qbXhNl8IiOTMCefeZZ1jbE9JsElNrSJHpVWwgfZBOwzkmwS8OfrjElXfgll+fkusOM8A
 wq3pnPK0izzE3vsM5yOAnJiaGBFGSJVzdjvt+XQCakfHC5VI8g/qaHQRSjY0oyAvXwFc
 wPa2BQlEnnFZHrLUI/mZsoS9pRyrZQzVzt9WSEoGRGpPi6QChl5Eg8sEelOHqxMCpgMW
 /1PiRX4sQJj2ODF00VB9wEu2VR3+guk9YKsPwlvXEKxTQCShowK9RC2QbA3ZHEQTifxp
 acxQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFCp+m0e5l1FhVLVwMIQEiWr9f2NV136cJwfemoxTFIwgRgV9il8w2OHEP2nSYZOi+pj/eCOTTsuw4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/IlApdXl6BRZHuXx23h+t8MqiOYnrAo35hPkZ9LI4QNHOGq8pi
 XvRV6wAkDR5XpbelSVsmdV+/Ssd3RhFjd7b0SlX68BNiauwx/uBH6hN9
X-Gm-Gg: AYBFou3+LBReHPSVlu3RUHgHd5KhMcAKgvWoL3VJikIu/9CIb0d6PRp7t8pVy02Xbd5
 +hcV7k0QSBlVHVqf9EPGV4Xecg8UkmnZYa2vGAJ08D6S2c6Ni5rfSWJXtQBQxvkmkIHcvg5EFEV
 tcobdKKT5jkChKgiEIlahR/GOIEKTTXJqU5J9Jzzz4GSAfKBetx80k7IRDr7WyEKCpa77vVT0n6
 Q2/fsvyYW4jlabyfRlWEFrj4KuZXgaQE0GdxHQe5PMIfYDDPbBrwRcr1XLOh5h2gdHIYNHTks/w
 QkFeW0aMMxjZzRpIEEbyvUfl1rtFrmuXvKZey8HSVJjEqX14xpUtTJS+rUQQfugEkzn1+cjPj0E
 /dYZpZmgTaPyXX/V5coqDOoVzwrmzvzPVUXefpkD6vUgD98XZ9QwxXQbK4zrcTi68tsFJclfAgG
 QgUNGkflHEov0G4iPrwQnTdgz3a8piYp8g8m/PXlIYUkQmn7bGzDzTkwfIEZkzmFrYFigW1SDpu
 STBZJ1sMhsax2wu03/SnAlFjxn6HFiKO+F2pr8Sbe5piIjNlkYoF8GfVci84bpmBt0hb7N0BHbT
 ER6MstKT35l8y5zBPMBGDQdaqlkQ2G115KFcHDnBalLhlDWt/DfJZkT4HTlYDOgKmKvja1+epDC
 q38ARTULX1A==
X-Received: by 2002:a17:907:9304:b0:c46:9ee4:8f0 with SMTP id
 a640c23a62f3a-c50963d470fmr299547666b.10.1794586738923; 
 Fri, 13 Nov 2026 08:18:58 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:58 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v1 10/10] ARM: tegra: Add CSI node for Tegra114
Date: Fri, 13 Nov 2026 18:18:19 +0200
Message-ID: <20261113161819.36847-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113161819.36847-1-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CSI node to Tegra114 device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 34 +++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index f2766c11ee6c3..61120658f0687 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -53,7 +53,7 @@ host1x@50000000 {
 
 		vi@54080000 {
 			compatible = "nvidia,tegra114-vi";
-			reg = <0x54080000 0x00040000>;
+			reg = <0x54080000 0x00000800>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA114_CLK_VI>;
 			resets = <&tegra_car 20>;
@@ -64,6 +64,38 @@ vi@54080000 {
 			iommus = <&mc TEGRA_SWGROUP_VI>;
 
 			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x0 0x54080000 0x4000>;
+
+			csi@800 {
+				compatible = "nvidia,tegra114-csi";
+				reg = <0x800 0x200>;
+				clocks = <&tegra_car TEGRA114_CLK_CSI>,
+					 <&tegra_car TEGRA114_CLK_CSIA_PAD>,
+					 <&tegra_car TEGRA114_CLK_CSIB_PAD>,
+					 <&tegra_car TEGRA114_CLK_CILAB>,
+					 <&tegra_car TEGRA114_CLK_CILCD>,
+					 <&tegra_car TEGRA114_CLK_CILE>;
+				clock-names = "csi", "csia-pad", "csib-pad",
+					      "cilab", "cilcd", "cile";
+				power-domains = <&pd_venc>;
+
+				assigned-clocks = <&tegra_car TEGRA114_CLK_CILAB>,
+						  <&tegra_car TEGRA114_CLK_CILCD>,
+						  <&tegra_car TEGRA114_CLK_CILE>;
+				assigned-clock-parents = <&tegra_car TEGRA114_CLK_PLL_P>,
+							 <&tegra_car TEGRA114_CLK_PLL_P>,
+							 <&tegra_car TEGRA114_CLK_PLL_P>;
+				assigned-clock-rates = <102000000>, <102000000>, <102000000>;
+
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		epp@540c0000 {
-- 
2.53.0

