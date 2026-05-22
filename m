Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2322DCD5BB8
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0DD10F641;
	Fri, 22 May 2026 14:41:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nBHwHw+h";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 836A210E168
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:07:42 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-36974217d4eso4418405a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779430062; x=1780034862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FtlQB08OaLofyAigz7tBTikvmBp8Je7frCtpNBxUmSE=;
 b=nBHwHw+hJv+vzGdYEALxdVc+xnFKRrBTrgRiBNK4Bnhp2CSoOSeOzPut/KUD1Hqd2O
 p6ENrb/xcbLuV4S/p1/SFPASWrfp6a32djRAVqaztKWPAEEc4NoBqrdi6YphtTCFcSoV
 9X5SuY57ebwihuVnvfDeJP7V2IqDq3BZHYfAEpz6hrVIWP7fwONJCFEsynFXrWqwnSex
 raibiyK81XYMgWjbh/0jZTj/wNVfzcd2he9GDoL5T3bsFG1NqnXPEKaYk3t986LIiyCb
 JPCnr1Wekd5SxMmdkRI8PVVeCzc3hZI725U5gEhOiw4W2SD78ukprofE6qa2nJP827Fy
 4s1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430062; x=1780034862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FtlQB08OaLofyAigz7tBTikvmBp8Je7frCtpNBxUmSE=;
 b=lQLckxr0sQfnyMy7MjrTBPkWkgMl9pAx3UVl9DMkFqM/lqNc90QonUhY9dFO2WA2+7
 kcWevk1tGnu9bup6M39EPVGEoi9dim9LpvHSeAUTcQA8pP2FnszVaLmnlWBbZB1nMG3a
 BN4vWT34Vt4O7n7JEcDo24d8hUQbdyrDBRRzi6Zlv8/OcmEvpK1Q24cPxm0tdljtVcqz
 nQrGkZer5zXcTl6JMoc/F7MKdXG9f7EY045WYVMiZcHfEJ5GHJQ0TKyIpfHjFgy1Pfzd
 XNURVshEVBQKCIF0VbkxVSqWqgfSTUE/yt0mX98LsSGcoFIUqtYdn2PPo6yczaBMF4jW
 YCeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/T5gOIjEpBBDTneb/Q5RmGTvw+Ov2T2cGZFvnp1pFH+pdweolJ+q+2Ezj5bsGQGjLdUJkzf1o9Pzw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCdpbGoFIV+nZWbyGb4zKi1aKRjaGdVK4OgURIRpyVK7Nm/AAJ
 hhPO3d/DoDjx+5xeZPtC0US9Q1yUpBKo9civrZoXXN5tZy20lWA4c3L/
X-Gm-Gg: Acq92OE83JXnuarPB5cLWm0M/SP+ipxYlUw3IoKzGrmnKuJNCcfin0Y2kyzlbsPd/oc
 kGTmLz52wUD8IedQuzwOlWQtkF0UvWwjMJe2g6wGAp77TpVC4igyzyho/SqcD7PAmuFgnj2FFq5
 KreVOl5pVr9YXevk4/nglUPHVKM05gIL4XqZT38xbJOCwdGEGb5DfUCwBWK5VpPb+IYL53sHVYU
 tnKNZy7oGP+fsfe53WY0QSHsmihBteCZ7aSnevJZtiBdkXMzCzBY3NCiY9+d/+caJHjW0KOKLts
 0oDP/dY6PpfJQpi4S4fpsqiY82xpkdhrZ8mE1z5vh5cg07HwBto2u6w80MyXdQg7pb9xNfe+8dB
 TWPkyw2rpC1MOMLVd7BKQRX3Z9l7Mz3PEdKcBX9Bea97XsbI5svUdteG9z6/crqp7dMYIU6UmRU
 qQUg7K5n057gaJJcUN5P+ywl5qbneM8bk3UuWERP5f60Dih1+H3yzO4GI=
X-Received: by 2002:a17:90b:3dcd:b0:35f:bfdd:f5a1 with SMTP id
 98e67ed59e1d1-36a677fd1ebmr1992255a91.13.1779430061997; 
 Thu, 21 May 2026 23:07:41 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm428572a91.3.2026.05.21.23.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:07:41 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Graham O'Connor <graham.oconnor@gmail.com>
Subject: [PATCH 5/6] arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Enable GPU
 and display pipeline
Date: Fri, 22 May 2026 18:06:44 +1200
Message-ID: <20260522060645.4399-6-graham.oconnor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522060645.4399-1-graham.oconnor@gmail.com>
References: <20260522060645.4399-1-graham.oconnor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 14:41:04 +0000
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

Enable the GPU clock controller (gpucc), GMU, display clock controller
(dispcc), and MDSS display subsystem.

Add DisplayPort HPD pinctrl state for GPIO47 and wire up the DP output
pipeline through the RA620 DP-to-HDMI bridge. The RA620 is a passive
hardware bridge requiring no driver - it converts DP to HDMI
autonomously. Add the dp-connector and hdmi-connector nodes to complete
the display graph.

Disable DSI, DSI PHY, eDP, and eDP PHY as these interfaces are not
present on the Radxa Dragon Q6A hardware.

Tested on Radxa Dragon Q6A (QCS6490) with RA620 DP-to-HDMI bridge
connected to an HDMI monitor.

Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
---
 .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index 4003837ad..e8ad6e666 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -1113,3 +1113,88 @@ &pcie1 {
 &eud {
 	status = "disabled";
 };
+
+&gpucc {
+	status = "okay";
+};
+
+&gmu {
+	status = "okay";
+};
+
+&dispcc {
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&tlmm {
+	dp_hot_plug_det: dp-hot-plug-det-state {
+		pins = "gpio47";
+		function = "dp_hot";
+		bias-disable;
+	};
+};
+
+/ {
+	hdmi-bridge {
+		compatible = "dp-connector";
+		label = "hdmi";
+		type = "full-size";
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_hot_plug_det>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+				hdmi_bridge_in: endpoint {
+					remote-endpoint = <&usb_dp_qmpphy_out_dp>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+				hdmi_bridge_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_bridge_out>;
+			};
+		};
+	};
+};
+
+&mdss_dp {
+	status = "okay";
+};
+
+&mdss_dp_out {
+	data-lanes = <0 1>;
+};
+
+&mdss_dsi {
+	status = "disabled";
+};
+
+&mdss_dsi_phy {
+	status = "disabled";
+};
+
+&mdss_edp {
+	status = "disabled";
+};
+
+&mdss_edp_phy {
+	status = "disabled";
+};
-- 
2.53.0

