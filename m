Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60012C982E6
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 11:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBAA10E789;
	Sun, 20 Sep 2026 11:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OcNfXkf+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E932010E590
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 11:05:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E4214393D;
 Sun, 20 Sep 2026 11:05:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AA50C32781;
 Sun, 20 Sep 2026 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789902348;
 bh=ThMQZcrTMWa0ogaV1Qct0jNAN5IDyeEU7rqtoXL/Ubg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=OcNfXkf+GbvkFxjQLsa5zIlFt/M7tZdc5k/eqcCi0r6Q1IKDlBNnwvxEQBklPgy7X
 azuWzIEEJ5OxH6LlNFOef/AvU0zvCRzQku6bjWty51834QfUyBuUrpfJqpJn3rGrtG
 j5rJ463JTZYrGmxXCk3Av534gbFwjE1FOzdXzLcPla3h+dVyh7SZcaR4nihDg6clsM
 PD70VFdUvjgqaeNml8Cn1OT/WFE1DmF2c1YLENkxCoRjz273wY1T7102S4gMAnEGnL
 viafF+258VbYGhJeW88PpFNo4LQOJ+VwUcJhjg20OPB/KuQ547j7maIhMorJTt67Pl
 2J3SEPe4kfULA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id EBB1EC982EA;
 Sun, 20 Sep 2026 11:05:47 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 20 Sep 2026 13:05:52 +0200
Subject: [PATCH 09/11] arm64: dts: qcom: sdm845-samsung-starqltechn: Update
 panel compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-crosshatch-panel-v1-9-de6e9512da96@ixit.cz>
References: <20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz>
In-Reply-To: <20260920-crosshatch-panel-v1-0-de6e9512da96@ixit.cz>
To: Dzmitry Sankouski <dsankouski@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=gD6nkoSnDiNJkxHIjVVHLnofq6KAf2AqCTBkFII2rPQ=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqr74JwlQmjFqAsGWal5v23kD/PhGDmYR1ObhHz
 KNGrYzYcPWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaq++CQAKCRBgAj/E00kg
 cqIkEADCiaJShndUiVkH4oh4dPrx/iqJqm2FRpy8aTsPjThQf2Kkyw6Eqt7F1BGQVkpYQKivgoJ
 U4cS8b+mmha6qx4iljN3vO/MEMrhGwzLTJlevIL5r8y8N7UrlvdVpsRTRHoq3itB6Ap4Fj4Gcfk
 C4dZmU6dSYQCbeHj9uC89sTjuVx54nyjG2KN3Mysv/eDdDpKIE/FXDBMyqdIRz45P0sqYEVE5ni
 E6aG52evUeSPUGmJ1vAjPqPLM1Y6WuLgXhXmj6xzaYzoEIXSE0UWr3g/NEYEJf+4xbPy3QVlPCg
 BEm1ZlHXXOUtSd1Z9zDxxyQ7yZ6cZJz6uymUK7qB7vCk0UMd+HgKSC8mbPJahHwG64C5+n35g5P
 msfME/5i5O4ZeYIn7WkpsNngylt1+mhmKhcbdfkKEUNLTsf1u7YdCCDJysPuXyxgU2rHZ+PRUaM
 /Jiiqq9xzZeo0ecAVqXTKGHinWuWGkhIakEaW8rZrH0K3ySZqtT2EXcx+Jqfg9kL9IdMex6eEuw
 Kjmaig54aoJYUxiCnT4ox7itMe16hR3Jzn/BZfATVjnIIE6m15ZF58tmpY/Vs0K4ZWs+fSbr9on
 nh/6OEGGsXD+9toNZrITu516xv30SnmsXQ+OfVBs0cNkYfJTrER2seatjrs4dP193+m45jWea9Q
 3ldQzG9YBajs7dw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
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
Reply-To: david@ixit.cz
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: David Heidelberg <david@ixit.cz>

Original compatible describing only the DDIC used, but omit describing
the panel used (Samsung AMB577PX01), which we have no way to detect.

New compatible allows without breaking ABI fixing the inverted reset.

Assisted-by: LLM
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
index bd59f1dcd96dc..c156ed3733b4e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-samsung-starqltechn.dts
@@ -262,23 +262,23 @@ &mdss {
 	status = "okay";
 };
 
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l26a_1p2>;
 	status = "okay";
 
 	panel@0 {
-		compatible = "samsung,s6e3ha8";
+		compatible = "samsung,s6e3ha8-amb577px01";
 		reg = <0>;
 		vci-supply = <&s2dos05_ldo4>;
 		vddr-supply = <&s2dos05_buck>;
 		vdd3-supply = <&s2dos05_ldo1>;
 		te-gpios = <&tlmm 10 GPIO_ACTIVE_HIGH>;
-		reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
 		pinctrl-0 = <&dsi_default &dsi_te>;
 		pinctrl-1 = <&dsi_suspend &dsi_te>;
 		pinctrl-names = "default", "suspend";
 
 		port {
 			panel_in: endpoint {
 				remote-endpoint = <&mdss_dsi0_out>;
 			};

-- 
2.55.0


