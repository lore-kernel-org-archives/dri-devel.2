Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2966ACD5BB5
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 14:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77E9110E27B;
	Fri, 22 May 2026 14:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bPrn0tIh";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EF110E168
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:07:49 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-36a3dd2e66eso1184709a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779430069; x=1780034869; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFcHoXp5EtCVviQjlRg/5s6sU9USys2y1GAqhGol8hg=;
 b=bPrn0tIhO3EPtfXyqSg5hkprp4YBPC0QMer931vd5vAB5WT7kA0mO4wQkPq8DulbYs
 z9R2BoazoTXLZZkwN3iLDHmDB9fj9MYGvLN5o5Zc5YmaXftRW4woqnDXjQGmVaoTy3Gm
 NRew29ezYDiNyoeDP+xyLSXY5/lxWasegYP2wYWdywZBtpf4tH+mOlUINwlRB9BHMqPG
 gFhLFbNIEfdVXizXdKuYQqnho+w0AghVF6bGIsoGOpaqBGMUQo2/1bcd7BYRujH6Wg24
 5WSgsYQfqVJW5cYZ5N5l5HGfJD8SIOoFPcb1borg/gO+E00/51Pl14g7QkImvUVcVUf+
 CL3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779430069; x=1780034869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JFcHoXp5EtCVviQjlRg/5s6sU9USys2y1GAqhGol8hg=;
 b=gtViPQnmDu9bcpWu2ewZaZe/uthbPGVVhTZRIRWPQQkUWysFWkkeqztsKAxXj9MhBW
 +XNgH/11SM8wHRki2PNscCtfwTwKjAlAYqdDB65FjsbkgNQrqQb7JHQbguU1sDfC0ZO+
 0sIBjUGejdCDyHpa6tOMIaYcfPJa7w59XvpUl5rg33R3q6tvh9AkAozKJYQvdD9FKgRM
 M49oAUTtN9UBoJ2ogEWWneKYDPCvHWryZjtSfF56EnY37sk5u9ILWVw3mVS4mLwbcj9y
 I0I0KfayQf/8No4YFajM69pFefXZsPmtA6bw4nbiG23+Y66+82GvOmZq5T9FfBlxzq03
 PprQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eG4+dCDscNVd2UWFh4lkXduxafkZAaCXEVCGQo9f9XxX+9I9d2u9bo0rCO33vVXLigqeb15Xxx+w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcPxAtIUyOPqY8ne0kYIhZAipyufPrJ00dIHUi2uxvBnwWRNgQ
 qfshmfVXHh/1r6u3BwVB1tncDrb+L7f5r8QHV115BRFO0Td46FCiBRzrsMpfl3H8VKI=
X-Gm-Gg: Acq92OFwq5q64Ev/w6Fb5gx42f12KLzbfv4uwLf2g0FbLOtXOJ5tou70gUvhfLKwucQ
 3cpoHnT51gmlOjh6aDUrXOOxdYKuOyac9Ce5KQqoD8KcDPzhpkISvMQ6mq6NS3nJplxAZCNQrGm
 0s0HIttHbPDIL3Q7xSW+tv0hAcy59ZFx7B/4HC+WlyWAuogZhPueMAzMnkFgagLi2QQHj7KYPHq
 N6ahklcP1w4cmdHs6G8qb3f36ZZZF9NOns7f5r8G43OHyDkT9yTRouC4DjmOIbcbrmS31q93cub
 6QTYP7TH0gi98PfZdvybaSu8y2zSJLHxr89zeXkFHcm5zDY55rWuCzeQDcm6kxJnF4mVfGhepJQ
 I4Aq28ud4eKnUTrzNRRSXz6LiYORtRqO9Rncn3Yf2EeoTrpMomFWSihVScVSUNUvxgKZ/2WhKSj
 jV/OEvc1vT65XcgNRy9s9/pFZImxadfzBhYHhffx/Us5CeUAgjB3YtleQ=
X-Received: by 2002:a17:90b:2246:b0:364:edd2:812 with SMTP id
 98e67ed59e1d1-36a6789ac27mr2255781a91.25.1779430068873; 
 Thu, 21 May 2026 23:07:48 -0700 (PDT)
Received: from radxa (122-58-25-162-adsl.sparkbb.co.nz. [122.58.25.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a7212aa06sm428572a91.3.2026.05.21.23.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 23:07:48 -0700 (PDT)
From: Graham O'Connor <graham.oconnor@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: andersson@kernel.org, konradybcio@kernel.org, robin.clark@oss.qualcomm.com,
 lumag@kernel.org, abhinav.kumar@linux.dev, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Graham O'Connor <graham.oconnor@gmail.com>
Subject: [PATCH 6/6] arm64: dts: qcom: qcs6490-radxa-dragon-q6a: Enable USB3
 SuperSpeed
Date: Fri, 22 May 2026 18:06:45 +1200
Message-ID: <20260522060645.4399-7-graham.oconnor@gmail.com>
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

Enable the USB3-A port by configuring the USB HSPHY with required
regulator supplies and the QMP combo PHY with correct lane assignments
for this fixed USB-A connector.

The QMP combo PHY shares lanes between DisplayPort and USB3 SuperSpeed.
Configure port@0 with two endpoints: endpoint@0 for DP output (lanes
0-1) connected to the HDMI bridge, and endpoint@1 for USB3 SS output
(lanes 2-3). Remove the orientation-switch property as this is a fixed
USB-A connector with no orientation switching.

Add a usb-a-connector node wiring the HS and SS paths to the DWC3
controller and QMP PHY respectively. Set dr_mode to host as this is
a fixed host-only USB-A port.

Tested on Radxa Dragon Q6A (QCS6490) with USB3 SuperSpeed confirmed
via lsusb showing 5000M link speed.

Signed-off-by: Graham O'Connor <graham.oconnor@gmail.com>
---
 .../dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index e8ad6e666..c16c3664e 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -1198,3 +1198,74 @@ &mdss_edp {
 &mdss_edp_phy {
 	status = "disabled";
 };
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l10c_0p88>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	vdda33-supply = <&vreg_l2b_3p072>;
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+	vdda-pll-supply = <&vreg_l1b_0p912>;
+	/delete-property/ orientation-switch;
+	status = "okay";
+
+	ports {
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/delete-node/ endpoint;
+
+			/* DP output - connected to hdmi-bridge */
+			usb_dp_qmpphy_out_dp: endpoint@0 {
+				reg = <0>;
+				data-lanes = <0 1>;
+				remote-endpoint = <&hdmi_bridge_in>;
+			};
+
+			/* USB3 SS output */
+			usb_dp_qmpphy_out_usb: endpoint@1 {
+				reg = <1>;
+				data-lanes = <2 3>;
+				remote-endpoint = <&usb3_con_ss_in>;
+			};
+		};
+	};
+};
+
+/ {
+	usb3_con: connector {
+		compatible = "usb-a-connector";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				usb3_con_hs_in: endpoint {
+					remote-endpoint = <&usb_1_dwc3_hs>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				usb3_con_ss_in: endpoint {
+					remote-endpoint = <&usb_dp_qmpphy_out_usb>;
+				};
+			};
+		};
+	};
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&usb3_con_hs_in>;
+};
+
+&usb_1 {
+	dr_mode = "host";
+	status = "okay";
+};
-- 
2.53.0

