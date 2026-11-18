Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD16606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QpFqGe9R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46ABB10FCD2;
	Wed, 18 Nov 2026 13:47:16 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2426810FB79
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:29 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so6790665e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003647; x=1795608447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3RiYetiebufQr59c1XKeWhbsUwEqVSkodNc50lBB/z4=;
 b=QpFqGe9R8zDhX1JSNcXA13Vren7h+L7+39xvspzb1Nx+OMJGX2a189s5ac3LdNJ4TG
 NIhARnS2BHUs716x8v26Ao8r/68cefM72j8d4Fs2Z3CxpKeZsYALZQ36hXnCLjUBa0ns
 +S+OWxQxrxAlNrVns5HVO+hrU2XzUjkrLpiP+o2I5CPJi38TsN7mWmGVXghGzJvpPXZr
 dfwtqq2HGfKi0Pt69FN+OoJ/mWqk9cjtj3oqyX32X+O6Rgm7Gw0t5Gz8atpNtzN/zkas
 OlhtAn8FjBCSl2vuxx1Pf2+b6o75GhZ1jmYmPoh2nUeZYNgr63tTQewuHg6ey0na1Z7b
 fuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003647; x=1795608447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3RiYetiebufQr59c1XKeWhbsUwEqVSkodNc50lBB/z4=;
 b=gMJbejNLl4LV3R9GFA+41DmMdSj8QaX5PwYmLWhK7Ind+Jp5oeYzvnJrxGA7VpswD8
 Omqo43ZpWvUf/KKyH9gTMsUzXvC1XwQLG9VqeG4Zsh/sElP5v4Xn0ak4Ut3QU7pvKj6g
 ILlQDD+VG4GXWwp2wRBHw0wqa9xOmfHbwQYnVp1tvU3EQuDTyUPbJuqwC0yYqohwzqZ3
 4VR5RG81GTVEfjZQg5OPibl6hlA+54W7C+Fx8MmnfECx59/LlBVzDeOaBnnYPMQEb61s
 LSpd0VqFUcJbtBudzMEzNysL3ADezjiItyhiQVjC8MuCVnCmoej4B3/QLO5cGkA932qC
 eHdA==
X-Forwarded-Encrypted: i=1;
 AL+hErG7ZWaO2Gcz02cegVI0GiuItX/tI/I5uMHqXq+S6iwd2rZq7mXJk8MiL1N2W0m+UE1wkNs43NMPNQE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+gfwSXABTScpaPKxStmOyP3FNR1b4AUnUrTRIyLT7EholJj41k
 AXWfr9HXWfzPb3dahn2+X5aIkHIR/hyySkgh+Jp0eqzbS4jBXN9SkCBI
X-Gm-Gg: AYBFou2vkAs0YO3bGhkuikwU1n+zPWB4Ib/aQ/hEoqLmsFiucg4nk7PmwfBY8+wG+ew
 jf3uN30vcJEHC6wv0PJ2nnUexiead4ghaslRdX/GxwFFBDq3w4gDZlz7FrmWYlHJO7Z/Hn2/iCW
 wAy5XT4VsMiUObB1AY3F6zwE4XDOAGB5OptZKvCSFDAx+9VGRy6bPAoQsgEZZ7jqVdDhTwcHaS6
 244/fMRJ8deUv3JXo0jclxOpD5G5VscTMF6AKofGzdsn3z3HFZ3+UfqXQ8D1vqP5EfJcQXEcEu6
 UQJYJfhQdOoRbkvJhm0VKy6BqiGYof6AWaPdPx0HSixb96U6qPd1/BsfPnqKzqFCQItK7YHb01z
 FhOqrqpMPIvVbhZpGa8VU9MC2/9z+ca8jXJLSsgssOkmAHBRbrODnUOioGbSGFIn4rDGNSnFWMz
 FDtMm4IVU/6K08hJNFt0FXG6kRFKfrdYuRyhezKgX6InqfynlBT/96bDhyw4jOyHfIauOBCRp7g
 HVwCFp+HLp2u5F1oDin7u4ltgtSJLx5FwbeO7ejxhNDxe2tG02Gmezw9T+HZxFN72T2ypijzQRV
 a8dN8Fe8KJs+0o5sk1XBMdH9FsqdZynGHOuK8AVW4bTvmgzZLDjsYc9lG3HL8pNWK/TKKqFNPN0
 =
X-Received: by 2002:a05:600c:474c:b0:4bb:6a2d:b426 with SMTP id
 5b1f17b1804b1-4bb7d5d40fdmr43108495e9.1.1795003647402; 
 Wed, 18 Nov 2026 04:07:27 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:27 -0800 (PST)
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
Subject: [PATCH v2 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390
 Bluetooth
Date: Wed, 18 Nov 2026 13:07:14 +0100
Message-Id: <20261118120714.31505-11-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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

Describe the QCA6390 power sequencer with properly voltaged supplies
and enable Bluetooth HCI on GENI UART6.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 12ca5ea921fff..3356099696a5e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -67,6 +67,67 @@ key-assistant {
 		};
 	};
 
+	qca6390-pmu {
+		compatible = "qcom,qca6390-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_en_state>, <&wlan_en_state>;
+
+		vddaon-supply = <&vreg_s6a_0p95>;
+		vddpmu-supply = <&vreg_s6a_0p95>;
+		vddrfa0p95-supply = <&vreg_s6a_0p95>;
+		vddrfa1p3-supply = <&vreg_s8c_1p35>;
+		vddrfa1p9-supply = <&vreg_s5a_1p9>;
+		vddpcie1p3-supply = <&vreg_s8c_1p35>;
+		vddpcie1p9-supply = <&vreg_s5a_1p9>;
+		vddio-supply = <&vreg_s4a_1p8>;
+
+		wlan-enable-gpios = <&tlmm 20 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 21 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
+
 	reserved-memory {
 		res_xbl_uefi_log_region: memory@80880000 {
 			reg = <0x0 0x80880000 0x0 0x14000>;
@@ -639,6 +700,14 @@ &sdhc_2 {
 &tlmm {
 	gpio-reserved-ranges = <40 4>, <52 4>;
 
+	bt_en_state: bt-enable-state {
+		pins = "gpio21";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		output-low;
+	};
+
 	sdc2_default_state: sdc2-default-state {
 		clk-pins {
 			pins = "sdc2_clk";
@@ -692,6 +761,29 @@ ts_int_default: ts-int-default-state {
 		drive-strength = <8>;
 		bias-pull-up;
 	};
+
+	wlan_en_state: wlan-enable-state {
+		pins = "gpio20";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		output-low;
+	};
+};
+
+&uart6 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,qca6390-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+	};
 };
 
 &uart12 {
-- 
2.39.5

