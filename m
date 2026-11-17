Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9EB606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QQprugyh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3813C10E38B;
	Wed, 18 Nov 2026 08:23:12 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE1910F6BB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:58 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso29230805e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919197; x=1795523997; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/HMGwwhGC6wtM16fz47LMMhy0kaE1LvMkOQV7+Ogndc=;
 b=QQprugyhfyet2qrZ9yASS6ljiboyYr6hv5HNmDncE5ZQDA9S2pDHvIIZ72yFGHGm7S
 l63HJnhd1dWX/xrRhApOL0jGCR9QTYdYGSalpV99GDdMaAcxVK8nff9Dka+MxrmsJhCQ
 BIHBjKI/ALsiqwebQO4Ay1K/p3ZK4/je0LYFie7NM1q/dk0WPjjEywJrxCVFyOb/uyXF
 nSCE9JAW16xqIkh6GfBCArvPoJtpgm6wmc11ySoHiDEPBQDRii/50DaWCcsJHXDsDiLW
 6QkO894vri939MTq6BkmUCgpd/G5sowVl1wF1rX+USgbyxJ4XUFnzKcmAQd7Qjuum/Bp
 LR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919197; x=1795523997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/HMGwwhGC6wtM16fz47LMMhy0kaE1LvMkOQV7+Ogndc=;
 b=quLO32ctYpKSTBpjlTgrsVFi9BKNIusZHXckS4Lp++WEjLo09tFHI/XDKCFr3zcBFo
 T84CQtFYbuMN46TN4rA66fK0cCdw5s33DtU8CkNDNLNkjQiH/rxfSY0YMvCYE+xSVkht
 WgksTof1RJYxWgKozpWUqswNXCj009hJoRiJhxKZXL2zbOurVsf9ePUf9D1tkTlj9r4w
 UmKI3h6ukzVAIfM9B25ULBhsveUSXv51TjomCQG2pg0aDem8LZBkn5UX94bDeFTSDh3u
 tlrrWTC7UDz2546xWIPT4SAWA/jWpffzjstCiNZ1a2nqFDMNWoJaIfGl0FQjGhKZ/jul
 xDow==
X-Forwarded-Encrypted: i=1;
 AL+hErFAeaDnzUXNxIRfJaC5qZu+UXzw/YZB7RRYWy5cCdm5peqS9eyOCLyx9J7BSZ9gn2hTHEGeuVdqHww=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9oezmKgfoRX254/UsiFU24aSYxT+Z0hfSKBpWlfBPnmL/r9oMs
 JAYihb609jVBfO5jaaGcrBuV/nQoxgUvYFaY59rFWOL2+K0ZsUBeyo38
X-Gm-Gg: AYBFou1xOEfg2amUIwTtrhWvM+X/WzED51QG//mXSbDeEkq9j+LyofzXMpZCsrIOSEv
 +gRimVUyGZugNcS5kXQ+dI6EBZVKdMhy+3/pXETJq50G8cmBz2VT6as3Q1w2esaw6jhg4J2WIO7
 rqDolgUFGtKTm/qa9Uio4KS0U41JbMRfh/05o2Tbop8qdObzRnoBVFQWXpVRYSZr1IIilYJEmq2
 Eg3dIB6K3/OaDF56vnr2ly/QH8q4avDBJTsN1yDnMQwziBUrRBDPObD+6Kb8FlHL0vys9q9X+vU
 fOsbILPtF7yU2AhsHFvxQVWRgmsX0wCzxaZC3n9DpJz71URvE8uhDpEMsrrdMvbE7RSi0TD5m/B
 v1m+7bAFJVoaBuAhj4csMIowfVbK12vuSs7oOfrKtoYqiyTP0AZhn0yvzYqCd5+FRrdQTaGQQzE
 4vrrGaQaTxikp4WWf0Qvgyt5Ppq1GULR4eDukNfrsZ811H3M6nNdCXmyEE3Cdbs6cdX/Gc2cMSQ
 GoDbDb4+qsJ9aVEjn2Z5YJdybrSWKEnsjGo67LeoFvx5W4uFw8KdZDCEBs//sWby3KSb4J8yNL6
 aQh/NR0YQX7XyruA9SmaUtXWo6MHCqGyr8cyuiN8hcAcvxverwWsS+l4LNPoWqchqJN3hw==
X-Received: by 2002:a05:600c:670b:b0:4bb:7987:fbbc with SMTP id
 5b1f17b1804b1-4bb7987fdc3mr32412055e9.1.1794919197198; 
 Tue, 17 Nov 2026 04:39:57 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:56 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 08/11] arm64: dts: qcom: sm8250-lge-timelm: enable SW43103
 panel
Date: Tue, 17 Nov 2026 13:39:43 +0100
Message-Id: <20261117123946.668557-9-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

Enable DISPCC, MDSS, DSI0, and its PHY. Attach the SW43103 panel with
its power rails, reset GPIO, and four-lane DSI link.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
index ecbff27976fc2..fca48472f5dfe 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -557,3 +557,42 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l9a_1p2>;
 	vdda-pll-supply = <&vreg_l18a_0p9>;
 };
+
+&dispcc {
+	status = "okay";
+};
+
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
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+
+		port {
+			panel_in_0: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in_0>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	phy-type = <PHY_TYPE_DPHY>;
+	status = "okay";
+};
-- 
2.39.5

