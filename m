Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15E0C79F85
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 15:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9C410E610;
	Sat,  5 Sep 2026 15:04:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qz4BI8zf";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC82610E42F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 21:33:37 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51c2a449c57so19632381cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 14:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788557617; x=1789162417; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vu/pZRzi+PHRIHNfr1m3RJJ4wr9M9/chVTLqWsd29z8=;
 b=qz4BI8zfAptjsW5viW9a7QfiMh6bBkTKbjwaThNWVbNGaMJcD4f1uSk70w3mzz7Mqf
 rg97NPNPlagw5w9MSQxQaEbfUathoMtA++wO9nzqVMrZ4kFTLbvseN2+vAh/YbUTI2su
 /wCcIk74hkbgFgcG2CTXv1df9eoq6/itAHQB9jDRwT2IENRXv3P4x3RMBepMeWfs/FHQ
 xye88l4/PAp15r0Rqc9qrKcXZQIrmjO1N9R+NsT67XrZM3/uB4zHKhKa4KQ+5WPHnXYO
 hc30FGLIVPLdXMJcArS3lkBsxJZkePT56XGInVSC+AtdbK5uHPQcN9Fy91BYp5jqfUnN
 OqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788557617; x=1789162417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vu/pZRzi+PHRIHNfr1m3RJJ4wr9M9/chVTLqWsd29z8=;
 b=CicFrKmrER5KbRUE2wNtbqYcnTbfHMd16UDUAesw5VnYujfIvAwy0WHvN7MwDf1pea
 eUFsohspJcivG7LRn/QjSrrNPlEGziBH5OZPB3j+SUgry7hcDBMP+0Rvcfo8ZOQbsr7x
 70PG9S3oUO+/CkZq5OHzuC8QOYNTNBpJO/UjWiQB7mqy2l1k7Wnfgth0Zw0FXHTCyxew
 OYtnEP0UOzsTNLMKrYyTuMj+mih+od1MCvMjM/lI3S/ehFNrc55yfas/QBtof661Nne+
 Um0tS3f12puidcjghfrbvAFu+wevksUtJXRCjtzIpGtOKysmVLHh7t63S1oY6n9D/4vC
 QeMQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx8VYbtI/OA4MAjg8aWSL65jGxhBfcJEq5hMZ/cZFJ15U+F0dFR9O/eH3CECOpMDHhWXQfT49dkGE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lHqpSbpkqKT6L8zgqIxYXJRwfeKsTFvf2MJnzPvVMH2ReR+jVU
 u2EKRhvPzGmYsw4PmqYWufpK74op+gPIkzX049gWIs1E7esNZ6LQyVA=
X-Gm-Gg: AYBFou2ra85BlLsEss5p9fB0Z5/WFHvvc7jf/popSIWujwCF8Hg7gZXKgF3E3WWxybE
 OnQVTgTXFSgOjIEuFZ6fjeSfFDWow7H7HB2TRE53BG6gePui4Qn3cN3n/zOhuKXIpb1RhzeOlBp
 zwM6i3esutbtMhGnzF2LXIsg6QzpIIKP/iZ7efFr2ebjdcgCRlnChoS8xltXjXQDVvXfAnuJfBQ
 /2sGidZXcFQW+2jnXvuylOc+JzpFWgV0MKpwnSCE2jBARsIGCeM/6DWGItqurvCvuRVbg3Wd+ar
 her51B2OCHyMrXOUr8TOKJRY+Dkgrt8LnsdUqrBRMljIURe/aVoG0SG9Qzp+yKOxBCrcK07eFVF
 WZpSH7hDo1OeYXGj45ZqlJBE9npddeq35XVE74CUlfrt8sxN+i33R4BrHSLK3XerFTHFfuw6jdn
 FU6yFtaJhlD0E59UTf4UGtkAIyCDLGmbAK+T+wHcVW8+ApHDBMAFUEpPWUFeY7Ykt6RKTcUg9wc
 SVOlUIpbJZT7dc=
X-Received: by 2002:a05:622a:4a89:b0:52d:8743:bc83 with SMTP id
 d75a77b69052e-530549f8265mr111105391cf.34.1788557616511; 
 Fri, 04 Sep 2026 14:33:36 -0700 (PDT)
Received: from X570.phub.net.cable.rogers.com
 ([2607:fea8:744f:d200:9441:f2ae:56aa:8a81])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53054227a0esm29646561cf.29.2026.09.04.14.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 14:33:36 -0700 (PDT)
From: Barzin Lotfabadi <barzin221@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: allwinner: orangepi-zero3: enable HDMI output
Date: Fri,  4 Sep 2026 17:33:29 -0400
Message-ID: <20260904213329.3910099-3-barzin221@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904213329.3910099-1-barzin221@gmail.com>
References: <20260904213329.3910099-1-barzin221@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 05 Sep 2026 15:04:13 +0000
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

The Orange Pi Zero 3 exposes the H618 HDMI transmitter on a micro-HDMI
connector.  Add the connector node, wire it to the HDMI transmitter's
output port, and enable the display pipeline.

Tested on an Orange Pi Zero 3 (H618, 4GB): the sink's EDID is read
correctly and the board drives a 1920x1080@60Hz desktop.


Signed-off-by: Barzin Lotfabadi <barzin221@gmail.com>
---
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
index c51d4d912..444773e4a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts
@@ -11,6 +11,17 @@
 / {
 	model = "OrangePi Zero3";
 	compatible = "xunlong,orangepi-zero3", "allwinner,sun50i-h618";
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "d";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
 };
 
 &cpu0 {
@@ -103,3 +114,17 @@ &pio {
 	vcc-ph-supply = <&reg_dldo1>;
 	vcc-pi-supply = <&reg_dldo1>;
 };
+
+&de {
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};

-- 
2.51.0

