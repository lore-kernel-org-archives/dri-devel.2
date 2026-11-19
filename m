Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF46606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JnMyN21F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A98D11264D;
	Thu, 19 Nov 2026 16:54:47 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C33C112639
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:54:32 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so27599215e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795107271; x=1795712071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tqAZ8i8YHyd8H+59b7YVQzKbswaS0aGE8O0OFJI4g/c=;
 b=JnMyN21FdjvxB+vGso2jc49UfgpMAMn0KHl9uFK+uIyUUZmGAX4pQ/jRNywCpLJqkU
 HOkpJOuO9m9MH9HDBzz/zPhT54HrvvKFQp8WjQhuymWhC0bhccLPHdzL6+BliwVJrHN2
 /LAaHJ5fGRTUDQFlJUDUGt+r/2bm4L0Am29kH4hpr0MzUYXgSmUUk6Vjs7UPfYbE5PSR
 44bI7+mA6mhdxFIK3+THyGt1yYvRmSp1or1yJZBGA32oBXaGk8Jq0peo++5uYnzvoEbq
 fHID2jkm0RGwtWe/XqkkF/vmYU8b+q1BqmNt8AyMYRpiRWb08nh72ShpCidu5ZyG+dAU
 B1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795107271; x=1795712071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tqAZ8i8YHyd8H+59b7YVQzKbswaS0aGE8O0OFJI4g/c=;
 b=YNnMwCs7Y2MGsR/55R3zN6bt3Le3s1bRaF01Cs1vWXdv3ACBmPAmbfszn68rkbQSge
 RFvFpiuUhMLAxaYyNSgdqvBnpyGN6qJ8+gqqVfzBM/IUI7VYjl3rpYAWUbqyDYm0yOW4
 sL36zKUHGyd/lI7mCFivjFwwLgstO052CJehHuT7u0JvU/CDRcPd6v30f7nyg8y5GJzw
 No2G1shcOiYFa9kCgxXwZ0Mb0xG0ISdZKJCyBnBoCp7qeX9pWzHYrGYq/w+oRJYPVPtG
 oAlWrsv7/1XqmEq+62P2LsgCzlSCHXm0bOccyNubv1Rkn/vxoFt4AP0XAcaMThT3Zrww
 GbMg==
X-Forwarded-Encrypted: i=1;
 AL+hErGg7BbVKDBTyV01W9VfIHD7WMVUXYoFUTiQ0vNlKMpFkPfciK24nA+zTsh/c9czDYjyZVLqLLNt45c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ie+AkedB8r4zzBn8U6oypxKhA5BwsvHTQALI0jSxXAfjGIAU1
 OdN9F194jtM3r9wZitmEVVprudM/acfcFIpWsv4yRQHTJ9m2dL850ZlE
X-Gm-Gg: AYBFou2OfBQcmbKUPrIosYBzV53/+lIcr+HRDJzc/EcWNR54j/DINbbaAqgFWYNnxKV
 u9Z3D7fmU1Zt8iJ6swEibAdNU31pJIKKf5cknLTM5wgtJ9FCrYcUB6hUvnamtjdWMT9lQkTUEdl
 oWJPG50K3B3wxU742rW7LuDDhrmMJufeF60FSlEjNRIX4tml27NlED5qPnBMEXtIPw31YC0E2oG
 dLkJG3ZhCrQs/xxSwgivsbjFudtdxbBMCHm5AZ7nGUdyQQWY0JZaGfTmys3sc7b+pH/D2H+RyTF
 MDjVw51UU/yOiMvpzd7G7UwI1g4q54JGJshXRqFOJJWv8Um7Kk+6+UpEjhhv/pq5+isRDXMtY5I
 rCjKjXfT8Zc3N9A2hN8+QDVv+7JIq3BiI8RRrFYSXk/fndf4HfJBHI42jqY1qpzgB0gyNbedDz7
 7MuslnrDKiXqmiQf7ckqDqIvKw9o0m2LLcSgUi725p9xhZPL56EQlLcxh8u9cEmgsrbZI6e0G3W
 WygnPlobry6x5/DbSP4HOo3Ry8wsHY1Ot2f6wzWddo9xnMHmNnV81/Um8gcewrqpBiRFEodWJPQ
 3gN/0e0M2qF/2btvgAkkU2Vx/Dpn0g457aC6XQFFKAaTlZ6hjcQ2TnVliKsTWNTBWk93b9gaRyQ
 =
X-Received: by 2002:a05:600c:8184:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4bb8881e969mr1657545e9.28.1795107270775; 
 Thu, 19 Nov 2026 08:54:30 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm9894555e9.0.2026.11.19.08.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:54:30 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Ivon Argel <ivonargel13@gmail.com>, Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v3 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103
 panel
Date: Thu, 19 Nov 2026 17:54:17 +0100
Message-Id: <20261119165420.24466-8-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261119165420.24466-1-rofikcoga@gmail.com>
References: <20261119165420.24466-1-rofikcoga@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable MDSS, DSI0, and its PHY. Attach the SW43103 panel with its power
rails, enable and reset GPIOs, and four-lane DSI link.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 00e3fa560e95e..59d6c1518a469 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -461,6 +461,42 @@ &gpu_zap_shader {
 	firmware-name = "qcom/sm8250/LG/timelm/a650_zap.mbn";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l9a_1p2>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "lg,sw43103";
+		reg = <0>;
+
+		vddi-supply = <&vreg_l14a_1p8>;
+		vpnl-supply = <&vreg_l11c_3p0>;
+
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&pm8150l_gpios 4 GPIO_ACTIVE_HIGH>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	status = "okay";
+};
+
 &pm8150_gpios {
 	google_assist_state: google-assist-state {
 		pins = "gpio1";
-- 
2.39.5

