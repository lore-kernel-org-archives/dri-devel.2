Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10A606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gf2va6XA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C045B10EAD9;
	Wed, 18 Nov 2026 08:23:08 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5B1510F6A0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:59 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so38103865e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919198; x=1795523998; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qFNx2PFwju3GpZX8sb85V+O1VlouegAUrn4ULDGVae0=;
 b=Gf2va6XAOH0+tOtXVFgIHiAc6zjIbu17rM+69bWlnD+lv/08fMJMvltC2D+zJ/eKIm
 UJSprd/dlbKOYam6DkbscDZK1UBRPrzUjiOVplESAx4JnmcYhfFsKqfXJCIKdSNj6p2m
 AaReqsssqgbZD/KJwWtRJCOpPOXqN4P8fkZBgo48O53aGaqSGcv0H//UPS8gWPA31+Jc
 FLZIuO/kvkOVkQg3vI7P+ZW40SiPMoW9a1QWaiakVynWP2eShnJ9K1/veckhEyMdaBdB
 TT9g2PihHsUkrZU+6J8GW3M3H2VWlzpmQDxQ1ozRonW1YNEv4X46SijP62GKPlUXXH9/
 dPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919198; x=1795523998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qFNx2PFwju3GpZX8sb85V+O1VlouegAUrn4ULDGVae0=;
 b=yM4ntO5LZ4FZ1CrxbCKuu0G10qn4fGSX9cCV1HOZXmnIvquzLt17hwNsPPzLmUi09P
 VDq+R6Z28F7u0QDBpnVFFmjE/wQhBgdPbrA/BtURxXYxTbr4d81J0UZzfZ6IC7Jo5Co4
 MmV14eVEt6bVW00o1J5/5U95TGmgcsSeYy33q5d7OQxV6MYuguX9Ta4gGvsvWtH/BoU5
 iJ5E/OSG05Z+972Gy7Q+hxA5QpJQXYtO4cES1ewgM4bYpXtAxQfQ/PzBqdZvo0h5XCeo
 +NEX30rwJ8msDw6SfPISW0BDmSUgpG7HZJCGekhleVhc2FqjAiqYEjiI7Pf2Y/BijEii
 zTtw==
X-Forwarded-Encrypted: i=1;
 AL+hErGE9YWFWh9pRzd7m/zxmCH9idC9cJRryDCNIBMqnlTg28HMEzLYYFsE3gRbsFCIXHHMUxds6WY0PlE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/QLVp3i7xltMo7ZU2g1FrdlHn46LzUr1BfmbXitkasvQKp/H64
 Mxa98WiqskvhDbQcMAmX6UA2UdmnMGxPjL4zcExbYng//471RBOLsQBB
X-Gm-Gg: AYBFou36f1WoDtkTNLi9kBAXJQX1PtA4+RQV1oCCo3sA94eRYRr/HF/oXiCeernvomK
 BgrlkRU3CX4vobXBVvIE8X+evqln8anJOknFvCac5C9/r7GsG7R+Hqt7SoK6STYjbvViOahi676
 a9eremxUKmxq2YMDlBUokupLmNF8GAXKWdA2wf+YqfEknCkRqBLY8jS5HJP2wq0GGOybqjuiaUD
 bc6MrVBqdcNA0xDUjcw6gQlTWCN1utHV0FNAtgguN6qKyzbLlMYgDo3kmgq7vyWEnifbVeNsPsR
 KZlivP2JgnVKtbQ3aT1oNvyQuX1QRqIpn2UcSJ+/FR1QywLgul91yhqpZfP2OoE/aZInXh6yoUx
 3jiVsmDI+3nuexuxfCkjhYiTmOoe0JBc7LNzQBpmcHyvH/0kk9b54vvx5jK/DAJQ0xdX9k+sSZV
 KjTOjXB7LYfpb/lvKS3VEzLRq2qMXK3mpkNnG2DxqdRylzLjf1qpYoCRkwEq2sI47V5PDRrTKDB
 ABI+v1cqrNQo07185r+sdCcBiloUHYwhwlRKNzA4Ds6VegpIJJP5gh+toPRiuxGJhkJWLjotnf9
 PGYo63mkokI6x6KxbhHRVLvI+Ch29zBRah493RZYf29krQre4YD/BjZISTNW881PbfkGdQ==
X-Received: by 2002:a05:600c:354a:b0:4a2:18d4:f9e0 with SMTP id
 5b1f17b1804b1-4bb55abaedcmr286510265e9.25.1794919198290; 
 Tue, 17 Nov 2026 04:39:58 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:57 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 09/11] arm64: dts: qcom: sm8250-lge-timelm: add SW42902
 touchscreen
Date: Tue, 17 Nov 2026 13:39:44 +0100
Message-Id: <20261117123946.668557-10-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe the SW42902 on GENI I2C13 with its interrupt, reset,
power-enable GPIOs, pinctrl, and native 1080x2460 touch area.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index fca48472f5dfe..a094aa81ad225 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -596,3 +596,39 @@ &mdss_dsi0_phy {
 	phy-type = <PHY_TYPE_DPHY>;
 	status = "okay";
 };
+
+&i2c13 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@28 {
+		compatible = "lg,sw42902";
+		reg = <0x28>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_reset_default &touch_irq_default>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+		reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+		vcl-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+		vdd-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
+		touchscreen-size-x = <1080>;
+		touchscreen-size-y = <2460>;
+	};
+};
+
+&tlmm {
+	touch_reset_default: touch-reset-default-state {
+		pins = "gpio38";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	touch_irq_default: touch-irq-default-state {
+		pins = "gpio39";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
-- 
2.39.5

