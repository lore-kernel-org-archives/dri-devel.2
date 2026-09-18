Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABC3C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98D310E11F;
	Fri, 18 Sep 2026 20:51:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fdcp6bEs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD9210E11F
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 20:51:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B81956053B;
 Fri, 18 Sep 2026 20:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57618C2BCB8;
 Fri, 18 Sep 2026 20:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1789764700;
 bh=QCIJObhinfLLP3u8ve1yUqV6GMr/mmcL9F5ebTD8qqo=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=fdcp6bEs+hbnE3DeTTyKxZf0XWRDOIAYoM8Nv6qphc/EvBFO+jB2U5g9uNCiXdEPL
 u4ax7UL0CxKHY8LwJjrpuhB3dqXVEGIWV1WBvTLnzwPL04df53rJObOmeWBqsg08AO
 GyA+bWNEN3jevDpW2bT33c5EUZguC5nNNTtD4FGxiZQb9RGnCbEQSmr6kqeQrtFfQb
 5/5Y/sVF8WS6kpuPS4/zovcekmi1P01pIkkRXWIYLBVnBUrm/uExTHApFjgz5C+Asb
 zQ3IL9ZdWZOZYPZq1sSPdcumWRZ5UZ1ZTdefxluRa3EzgrZErJuFtRVftYVqzl25ko
 6x85mtEx/ViAA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 40A8FC982D8;
 Fri, 18 Sep 2026 20:51:40 +0000 (UTC)
From: Avalon Vargas via B4 Relay
 <devnull+avalon.vargas.centeno.est.una.ac.cr@kernel.org>
Date: Fri, 18 Sep 2026 14:51:36 -0600
Subject: [PATCH] arm64: dts: qcom: Fix backlight control on Dell Inspiron 7441
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-dell7441-backlight-v1-1-f7646ae30cae@est.una.ac.cr>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CIBBFr9LMWiKQRqtXMS4GmMIoUgNoTJreX
 dDl+/nvrVAoMxU4DytkenPhJTVQuwFswORJsGsMWuqDPKlJOIrxOI5KGLT3yD5UIaVWGmfpUE3
 QxGemmT+/6OX65/IyN7K1l/rDYCFhMiYb+rRk9pz2DyyVMmzbF4efdZOWAAAA
X-Change-ID: 20260918-dell7441-backlight-00212af0da18
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Laurentiu Tudor <laurentiu.tudor1@dell.com>
Cc: Rafael Dettogni Guariento <rafael.guariento@ufms.br>, 
 Val Packett <val@packett.cool>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Avalon Vargas <avalon.vargas.centeno@est.una.ac.cr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789764699; l=3410;
 i=avalon.vargas.centeno@est.una.ac.cr; s=avalon-una-20260914;
 h=from:subject:message-id;
 bh=u1ZQbSAfwqgtkK6O3ck7wrXaPpGTJgsfRfeZp/Dum9o=;
 b=NSvKR5ItR/Oz/hETmop6P86/UAhimlz7RdxF5dxrGq3/54atF0ntlj1lafEpn/GUPJJTR4ioM
 bovpfN74o6jDNqbjWke+hZ3L72DSQWyc4iXOt/A/6wv9tmLOCaSP5FF
X-Developer-Key: i=avalon.vargas.centeno@est.una.ac.cr; a=ed25519;
 pk=I7FZ301yhA9Jl2LReBEqv+9LUrd5zi397CIT2gTB6RE=
X-Endpoint-Received: by B4 Relay for
 avalon.vargas.centeno@est.una.ac.cr/avalon-una-20260914 with auth_id=1032
X-Original-From: Avalon Vargas <avalon.vargas.centeno@est.una.ac.cr>
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
Reply-To: avalon.vargas.centeno@est.una.ac.cr
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Avalon Vargas <avalon.vargas.centeno@est.una.ac.cr>

The AUO B140QAX01.H panel on tested Dell Inspiron 14 Plus 7441 units
advertises PWM brightness control but not AUX brightness setting.
Without a backlight described in the device tree, the panel falls back
to the AUX helper, which registers a backlight with max_brightness=0.
Brightness adjustment is consequently unavailable.

Enable PMK8550 PWM channel 0, route it through GPIO5, and connect a PWM
backlight to the panel. Provide an interpolated brightness table with
101 levels and a default level of 80.

Fixes: e7733b42111c ("arm64: dts: qcom: Add support for Dell Inspiron 7441 / Latitude 7455")
Reported-by: Rafael Dettogni Guariento <rafael.guariento@ufms.br>
Tested-by: Rafael Dettogni Guariento <rafael.guariento@ufms.br>
Signed-off-by: Avalon Vargas <avalon.vargas.centeno@est.una.ac.cr>
---
Equivalent configurations have been tested on two Dell Inspiron 7441
units. Rafael tested this patch's resulting nodes on his stock DTB,
verified the live interpolated table, and confirmed brightness control,
Fn keys, no low-brightness flicker, and successful suspend/resume.
His Tested-by was supplied by direct email.

The 4266537 ns PWM period is borrowed from the upstream ThinkPad T14s
LCD configuration. It works on both tested units but has not been
measured from Dell firmware. Feedback on that choice is welcome.

Validation: strict checkpatch has only the missing public report URL
warning for Reported-by (the report was direct email). GCC/dtc DTB build
and dt-validate against this tree's bindings pass, with the same dtc
warnings as the unchanged base. The kernel dtbs_check target was not run.

This is scoped to the 7441. The earlier report of working AUX control
on a 7445 with the same panel model remains to be compared for platform,
EDID and DPCD differences.
---
 .../qcom/x1e80100-dell-inspiron-14-plus-7441.dts   | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
index 75e10d97c..98632cccd 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-inspiron-14-plus-7441.dts
@@ -10,6 +10,19 @@
 / {
 	model = "Dell Inspiron 14 Plus 7441";
 	compatible = "dell,inspiron-14-plus-7441", "qcom,x1e80100";
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pmk8550_pwm 0 4266537>;
+		power-supply = <&vreg_edp_3p3>;
+
+		brightness-levels = <0 10 20 30 40 50 60 70 80 90 100>;
+		num-interpolated-steps = <10>;
+		default-brightness-level = <80>;
+
+		pinctrl-0 = <&edp_bl_pwm>;
+		pinctrl-names = "default";
+	};
 };
 
 &sound {
@@ -42,6 +55,25 @@ &iris {
 	status = "okay";
 };
 
+&mdss_dp3 {
+	aux-bus {
+		panel {
+			backlight = <&backlight>;
+		};
+	};
+};
+
+&pmk8550_gpios {
+	edp_bl_pwm: edp-bl-pwm-state {
+		pins = "gpio5";
+		function = "func3";
+	};
+};
+
+&pmk8550_pwm {
+	status = "okay";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/x1e80100/dell/inspiron-14-plus-7441/qcadsp8380.mbn",
 			"qcom/x1e80100/dell/inspiron-14-plus-7441/adsp_dtbs.elf";

---
base-commit: 704340f1cd0dcef829eb62f5b48ae95a2ce17bdf
change-id: 20260918-dell7441-backlight-00212af0da18

Best regards,
--  
Avalon Vargas <avalon.vargas.centeno@est.una.ac.cr>


