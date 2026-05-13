Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE5CCD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:25:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FA210EFCA;
	Wed, 13 May 2026 17:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EjWh6fMR";
	dkim-atps=neutral
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com
 [209.85.160.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A719210EFC7
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:24:59 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id
 d75a77b69052e-50e5eb0fabaso66268531cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778693098; x=1779297898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZU1btMobI51IRRL4Ho1mz96alwmNtMYLu0zpeinvrcs=;
 b=EjWh6fMR2pO8zxYOlUfrwUk8pg4SXVRQtSz2rve4m+pubhXVZmzKZi58CZl3RHe8xo
 jnhumZPFGb6Hz5UM8c+SVC5hkhOmZU+2KTF0b6EChGs1OeZj/3I8O0bRRGKKqiiqF7TA
 C99Eet7qhgqbyKtIeD5JQuQ64p2f4QGdGxx0xQe8fZ7ayoAwIR1/ezdMiHyNIDIVYJe3
 TSfXl0rPxI+zAWMBxZKjjS7vGIgbz4QOxch7cSIoxZZLlANAnnwcpA7ymxxVWGBLcARp
 Mpv2xjARIVkI2lDhbDI3KY3I8EZNUp/8SeZ5I2PAeyVW2sE1L7RUC6oXafq806/JeGTX
 VqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778693098; x=1779297898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZU1btMobI51IRRL4Ho1mz96alwmNtMYLu0zpeinvrcs=;
 b=Rl4P0PXiNDLP8HyQ+la46GHfPPbeSqQrFDd5mR5+POEn1gnUEWAxxVwinpuunNIlNQ
 Fuim5e1k7LwPw45zIiBKOSylrcRspLKX0Ek9GWDNfND52BZwcZX9Jzs9eEYw07KYaceg
 ySl2BTKMobIK4PRqyMnYT8Ox41znNLCbwBO+7UyQVnU5gqEy/oNtCLtXMnQ0cmLuQdl6
 1s9ajvkxauuQgIbne+s41DlboL19BRxEHwtLZclCMl+ReTeK+rnShWu0xT9HPwfGcHL8
 TYeKFzAlMmLgovQkkRlWPgBQAcN2/eX9Rw1E4tstMXhA6mZBDUAlw/8FDxwVVlL7zCMb
 RAKQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vw1XGSu73yBEG9SwgPz9pUrWTIFFZ6WWrOkhQhk7FVvYS4W1KICYxxLs1CC/no4baypPXfFrtVnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJJvpeFSamFVZeoN61o5o5lLIq1Ef+Z3uz6Y7unyyRDhtnTJ8b
 lc+FKLp+RenVB7x+vT9Hz7+6mrUVS2v2vrbfzJn5j/wE14+LlqI8EhTzITTtbA==
X-Gm-Gg: Acq92OFsLC4LCLwGqXVQhIPFh5CaPe3QuanDhTUtOe3PCds97fysxL0eGH+tcJLPUn0
 10XCfY56YEtEPDbAHOvcz5uNhv1/gLNiqqOIi1ZPk5hur73hISCH40mV5TjwArEFDibJ6f1L2Ab
 BVdpSyGEH+hbg8gTvvkbAcGN+FNBFD8mYe5bUnnHJe5G6329pYilllgmFyQ2oYp216rclrpvcFh
 iM4CPiHYoi0cCVROBsVJhL9rV3Ka45GW2NwtZML305+z3hiiQeMfqZN/b7imB4D06YZNZ2pH6Eo
 E8M7b4DQ+mO9hHpirygYP+z3wIIqp1BiBKgLKOVPWf6CRmN/qilukOeHzdLEB4dBoBY+N4Tj0Y2
 2C2gPTLIKzD4aGH9uG5oQVjHkxCW6b8l1N6rzYXLAXY3iE4FDHST/85TVdMqdcIm3z2gCkXV21F
 P6KvldOJJzV9V6/i0vThzgM7i0zA==
X-Received: by 2002:a05:622a:124f:b0:50f:dd9f:1223 with SMTP id
 d75a77b69052e-5162f5fe405mr58670381cf.44.1778693098486; 
 Wed, 13 May 2026 10:24:58 -0700 (PDT)
Received: from localhost ([142.181.178.53]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148fd8bfe0sm151895461cf.0.2026.05.13.10.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:24:58 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, Yifei Zhan <yifei@zhan.science>,
 Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v4 2/2] arm64: dts: qcom: add support for pixel 3a xl with the
 tianma panel
Date: Wed, 13 May 2026 13:25:49 -0400
Message-ID: <20260513172549.1345-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513172549.1345-1-mailingradian@gmail.com>
References: <20260513172549.1345-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The Pixel 3a XL has variants with either a Samsung Display Controller (SDC)
panel or a Tianma panel. Add the device tree for the variant with the
Tianma panel.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Assisted-by: "Claude Code Review Bot":claude-opus-4-6
---
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../dts/qcom/sdm670-google-bonito-tianma.dts  | 32 +++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 169cc9b9ccd3..d909c527d848 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -303,6 +303,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-fairphone-fp3.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm632-motorola-ocean.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm636-sony-xperia-ganges-mermaid.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm660-xiaomi-lavender.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-bonito-tianma.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm670-google-sargo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c.dtb
 
diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dts b/arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dts
new file mode 100644
index 000000000000..42ddaf53d150
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-bonito-tianma.dts
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Device tree for Google Pixel 3a XL with the Tianma panel.
+ *
+ * Copyright (c) Richard Acayan. All rights reserved.
+ */
+
+/dts-v1/;
+
+#include "sdm670-google-common.dtsi"
+
+/ {
+	model = "Google Pixel 3a XL (with Tianma panel)";
+	compatible = "google,bonito-tianma", "google,bonito", "qcom,sdm670";
+};
+
+&battery {
+	charge-full-design-microamp-hours = <3700000>;
+};
+
+&framebuffer {
+	height = <2160>;
+};
+
+&panel {
+	compatible = "novatek,nt37700f";
+};
+
+&rmi4_f12 {
+	touchscreen-x-mm = <69>;
+	touchscreen-y-mm = <137>;
+};
-- 
2.54.0

