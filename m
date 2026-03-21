Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636CE1094486
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B815510E244;
	Sat, 21 Mar 2026 15:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J3TD85s7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC9110E23C
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 15:23:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A27DA4469E;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BA4BC2BCC9;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774106591;
 bh=T2rJglXqEaThMrUso1MGsNq2k7fvUdqrAGUd+QI2xhk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=J3TD85s7BCCcEvJR2j9NrcDLrVlFSThEX2ufYnXx9BbC1tHVLvhYP/qhtxNFsCqP3
 B9YOlsFvgqEE9qG2IfL3/O59RVaC7nrSBsTXlP9QygSMKVVdPTBfdZyCRfOztQOLp4
 97FGtS4Bm4uPQw9fTN13lpvs53YiuyvInhPUk3D86jPNuMMNrRODovTJv9zxpQQtPf
 rxED5UDh3Cn5vPbZaePdm7mpnhHEIXsH8r1m53UNo9WPHGcUaBU8JwKXXgRAK3flN4
 HxRPlQoDixx2DYHyF+7kenndH1v4oecvzrZu3gy9kRw84rVreg6TpO520scDThzVdt
 nh/0hNqGSFEHQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC9B1094486;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay
 <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 21 Mar 2026 17:23:23 +0100
Subject: [PATCH v3 4/6] arm64: dts: qcom: msm8953-flipkart-rimob: Enable
 WiFi/Bluetooth
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-rimob-new-features-v3-4-d4b8ee867de7@protonmail.com>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
In-Reply-To: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774110230; l=1054;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=m6V8I4T0WqUEJHQUdFENcdM3juf5Ya0wQ/8ytPVjnmI=;
 b=Gs/Bpq7Ng08eKrwYI+h6XMtirKeL0hCvbhxbLree7c6Jg7PK88hRS7r/6ZAf56musOOU7q9xN
 ls/j2vPCN80Cb6MmG8pr6Zy7D/5dRwIV8ScvedtM412YdcDFmXfhQVQ
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
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
Reply-To: cristian_ci@protonmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Configure and enable the WCNSS which provides WiFi and Bluetooth on this
device using the WCN3660B chip.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts b/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
index d07303a37b2c..eab310ffa07b 100644
--- a/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
+++ b/arch/arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts
@@ -327,3 +327,18 @@ &usb3 {
 &usb3_dwc3 {
 	dr_mode = "peripheral";
 };
+
+&wcnss {
+	vddpx-supply = <&pm8953_l5>;
+
+	status = "okay";
+};
+
+&wcnss_iris {
+	compatible = "qcom,wcn3660b";
+
+	vddxo-supply = <&pm8953_l7>;
+	vddrfa-supply = <&pm8953_l19>;
+	vddpa-supply = <&pm8953_l9>;
+	vdddig-supply = <&pm8953_l5>;
+};

-- 
2.53.0


