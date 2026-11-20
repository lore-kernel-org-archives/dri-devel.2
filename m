Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A8606A326
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aOGibmss
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1060A10F06A;
	Fri, 20 Nov 2026 07:35:10 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E1810E241
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:34:09 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb61185057so3958835e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795160048; x=1795764848; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
 b=aOGibmssHmGA3SOazvEBWAVriK+VaP45cqjePe3ZQs9XUezEFQntOWbGDvLHpNkzJ5
 J8XpTWS5ql3/nStd0azHecXt0pLh5ayKEz7/A+SmQwKb/2h1fIbjK4Udf8hQviqmmqh8
 yYalF0phRSMLyoCqTAG1crIl6Byf1enPv/DB9Aawc0uHhEuAnukgPBdeuF/YBLoeyAq9
 kyPrMrgrkvdI82qzg9szk0nM/DzSVR1ucsiw+kO+hxV/bd/Xb6C0m3TB4N2ULUMOsz9v
 Dw4LzIF2eUuuYlDfYe3JV16iXbeD4MPSLFfwjWei8vHWqnwzzTt3v1IqR+Q3/tlnNNSu
 irzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160048; x=1795764848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
 b=R7P101y4qes7n9Z1ZqwrN5oEJyZPwC2CmV5J2Xm3W0Kw/pwifLWgL9KaV0sEnwLc5V
 UgRMB4NsTHrDzEWblzwlmGBgL2rbUU64WTMnWzimXWFHHtZ+GyZOkgKlqDAoeBJJhXzf
 R1JB35fxx9JqoUDQCFY9YfrpdxtC64mPP1Ys0W1lScO9dbr7sA+mHHEpnFpABTQ02qnK
 n28NesL7DWLqjRYl8C81fkBsmjYn+26cy/l6MSFEWwXP8ROrYNMPcWfy2Z51bOOO7A7f
 QXRzEaW0CU2heIJDyVdPW7w5Il9HsNhzLA1eS66/c4X6yYA2+t43Dcgpc0C96dhAc3Sr
 Yy7g==
X-Forwarded-Encrypted: i=1;
 AL+hErGVuOrnrAVZijIWaWc5TcUsMUMPJjVJKsIkGlD6SkiVHs2yQ7Lc7jsUuba5PW5/ho9ltL65IIUbNeU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9sRWO+pQSgX1FiOLmUeAHxkB4nNGuFpybBsJ3x6t2n8p0jWTe2
 s5N8RktCS0SCX06BuvHvHpmAtn00maWJD8mWYjSrUj45SCRixH33iz2F
X-Gm-Gg: AYBFou2tYV7gqKYD6xJxIhc3BdlCtj24FzRRIWW412cIWhNtS6RN5/EcJqRGNyyoy7I
 Fh/qzIWGvkv7fJNqlSQvvd+IfQr8YriXYCPC4uRAyKDAgg7mt6G/RjG40McqDrIUNf17ifbo0hF
 n5+gR+e8V3VoaA9QCj3b6cnd4MRMTGHEkBSpMQyvegFHozmAwPnTwY5Xa0jDSMS1IGx+0ZWb/Im
 NkmZCDp6DLaM49uasIA9dkC6kiUNVMPiUR4Dvh9kioIX5FofJVbez7GmLsG+OKgIlDfIB1mDNuI
 FHfwEtXgBXwzDxHt3U8xlZ/F6zUviPHi91TVHY2YEG2xYNP9CthvyIN7UCBGlDPgV+yUxqhhlE3
 pMie+KCH9b5H4EfdqWJBHHsEHVpWMgEfc8Ds96fbAjE7P9XVBSHninrS7ARFqFOFsKh9b+BvjtE
 rn14UgBpitcHj43JoaYs9Z0ZDhdBU2+BhDNOM7217joFIRpFLLFdQO7ny0saujRElN17AyHuPuj
 nJGqyqZxAgj3hKFvAQzvoMpWS6zNKTJDYqlKxiXJzd8J0shib0SKPx29d7enHoiPmBqcrjKhpCR
 nx/t3sFzlpO9/ikbj+SslvAHLvQ0RiqGQuaK0seueTJ3PT9ZDU86d4DvwS2v24VG2z4UTl++Vaw
 =
X-Received: by 2002:a05:600c:3b99:b0:4a1:777b:8a12 with SMTP id
 5b1f17b1804b1-4bb8880b984mr52971675e9.14.1795160048060; 
 Thu, 19 Nov 2026 23:34:08 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:34:07 -0800 (PST)
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
Subject: [PATCH v4 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103
 panel
Date: Fri, 20 Nov 2026 08:33:55 +0100
Message-Id: <20261120073358.10267-8-rofikcoga@gmail.com>
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

Enable MDSS, DSI0, and its PHY. Attach the SW43103 panel with its power
rails, enable and reset GPIOs, and four-lane DSI link.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 20aaf70355158..709cf9674e2d4 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -461,6 +461,42 @@ &gpu_zap_shader {
 	firmware-name = "qcom/sm8250/LG/timelm/a650_zap.mbn";
 };
 
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
+
+		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&pm8150l_gpios 4 GPIO_ACTIVE_HIGH>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel_in>;
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dsi0_phy {
+	vdds-supply = <&vreg_l5a_0p88>;
+	status = "okay";
+};
+
 &pm8150_gpios {
 	assist_state: assist-state {
 		pins = "gpio1";
-- 
2.39.5

