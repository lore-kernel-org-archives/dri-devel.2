Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752E9606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Gt7zvfO7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38D0810E282;
	Fri, 20 Nov 2026 07:34:49 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E091F10E282
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:34:12 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so4317955e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795160051; x=1795764851; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0qQAv0ke6L7thaRcZoBAW7C/f5nOb8olxJacy9wBEu4=;
 b=Gt7zvfO7gVrJgDB/fRWzwpM3tIn4Gnv9Uv2vLuTuSnDdBVyMZKaGaFOb3dxSUr58w1
 ZHHIv4yyCIQhmV14Mg/T9TBEBVcR0abmYbhyHnYveGsWz9FH0nOGcwUZLeXiNjAqyYHS
 ZDuM5Ry3EhUcu2vuu0pl5sebmw8YIsmIHfOXYnboUbAJ3kXqWys9rPuLnz5yeHRYVHH4
 /daKL+xRIajr41Eiz6BiRehVpO+paZeg51ql4uyzsdA0CO9j1hJ+2/mgprhgzFg53F8E
 QlocZrQbFi7dksrl0v3kPiWm4Vt+XL4gIgHMyparJgpUWQJDZrpr7y2MFjl0fXssJN5T
 wDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160051; x=1795764851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0qQAv0ke6L7thaRcZoBAW7C/f5nOb8olxJacy9wBEu4=;
 b=bQg9ViqPPwN7cQpVlM/e/Nd5b1BrNiy0PgzgLiRWUB8wWbcuvjBfr7Ct+hx3oJH1ie
 VWt9NozltoQolfm/6ngPyebfIjnW1TMejctZ8tFwwDSoWCQUTbRdWGA46U9msjB2DOh4
 JL3fBMPOUbvvf6mVnHBKUWyx8n8wZSxsC+uO884Fw0rN1iA0DEQ1aeILdls8j6CmEXrj
 7VN1uNGOoBBoJbJnHdzjA+29E87Ho88R191Q0UfQLRkKj1kLDUAyDxXNy/ip6cTAEE/X
 zGbDS3hxLJ7kADzjJBnASUMQ3UXRTr+c2dtT5ILKhIsRyHbESxIrJ1bpHqQoHqbJssR2
 kCOg==
X-Forwarded-Encrypted: i=1;
 AL+hErFRZf7zjvCxt3ILe/jTamA9hD2w4n7lN0KVyLwdPHFO6PCdap32aGzfu21DZsXIbVbS0OIo3zH6bvk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/84BsVgb9CyJhfIwm6XT5Uv+dn2k95002Fyo7TVyOyjCpzlEA3
 JHNz1xhVCI+uucpqj+lQd+T9H1LN2hN6EFxHl+F1pK+LRxi+QmWiDo6t
X-Gm-Gg: AYBFou3Kc13T2E1XyQxeW17FzdsKrD6BQx9H45UUZHx1xuKFRj+uitcOxUmpwy4U1s8
 NDuxKEgvIi6PUCV5oxdtJoS65V9/gYe0yFMXS0WtnKxtGR67/Ea9R9J37CSytL7fXAvIGmuNOlD
 81rfUcQjBzi1cOG3p7lEIpFsNFI3NP8ocDoyX2oNsJ+9yj3/sdfcN52EB/W21Y0F7teKLe3+bCa
 714mFUKgDuxFi8bsSBGItlacjitWGaYyfYDP7zfqWlg/Fue1WAd75asu4qLzbTGdAl9lwRyGNlH
 TOl5PyzX4HfJiFzVPyt9fQSkWaQhLy+xabSiYSR/TkbghDDSPDGr3D55AAe59piXC4XcWKg8WkS
 8FhzhP7G81DsWsODRhNKTrn8Ox/8yvoGmL9CzPKs3tEob+kqsXFDHM2R2XZn+inAi5YJkkyEc55
 VRlpcUYwh58GOpXNbDb0kH1ql/6sl/kQ/JhrxRcKSB1eVT9LRuuyPdgNjC753wXRqfLE1p3TsS4
 sLbi8ZWP3APkN6YH6OV2+1JVedzzVMNj2SfvMK//DSkHHqp2LhagESpaaESYZM+C9tsgsBoxu5r
 izG+cTpOTOSQ3JmLBBumUsAODYwo+WsiFJCwsSo1VsgyK398javRlebb6KOHd6PdbdBjhKG328X
 ivk5rZd8gsJeA84tLYsjj
X-Received: by 2002:a05:600d:82d3:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4bb8880f0ebmr49766975e9.9.1795160051109; 
 Thu, 19 Nov 2026 23:34:11 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:34:10 -0800 (PST)
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
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v4 10/10] arm64: dts: qcom: sm8250-lg-timelm: add QCA6390
 Bluetooth
Date: Fri, 20 Nov 2026 08:33:58 +0100
Message-Id: <20261120073358.10267-11-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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

Describe the QCA6390 power sequencer with properly voltaged supplies
and enable Bluetooth HCI on GENI UART6.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 2d8b06c05ecc3..46258f3a8cc72 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -65,6 +65,67 @@ key-assistant {
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
@@ -634,6 +695,14 @@ &sdhc_2 {
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
@@ -667,6 +736,29 @@ ts_int_default: ts-int-default-state {
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

