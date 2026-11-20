Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C2606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qmp2OuDx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFE210E914;
	Fri, 20 Nov 2026 15:55:30 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EBC3112AE5
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 15:55:01 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso727480f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795190099; x=1795794899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
 b=Qmp2OuDxx3lVI1g9lHCt6biP0YAgFFAunpoWpx3RIsD7c3yTcPN0d9gxjj5K9depjt
 69mokDmK1Qakq+mlHRweP42NzJDpUVPxPgs8ppxFKozr/v5acCd/WWehp0Dn21sE9mhR
 8MM3nIbeUP1aUd54hybhJ3YZeZr/F1wCqM9VS87nUsM/RwDB0HiAZwa6cPBtIrv3DtKy
 m5+Dr0xhLv8hHGe6lMMweoBgjJZW8oNsgnCQD2+MoHMqPkbzBicJ6u9jGnEeaPwHSGiR
 +s7LszEQRW/x6y9pA+468dlF/9+21PW8IQL2TEsakTZSvPXw76qytb8xdHSxiyv1vSjb
 DeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795190099; x=1795794899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Pt1Ey6vqlrKjY9t+x5QDUocIGkE3O17FTDnJ0augaVA=;
 b=TirkP6ITHt9uRAeO2NUEE8mbsS5ZCd0BmzWMtVcGaph6nrm3k26J1s4JLm5TSU0gKR
 CvjWNn3ZyL9tZpW/V1xntQIDtyeOoDkhgzSDfTpg2Gp4/t7SthAAqWflq+bB8r11jDYt
 ZxcYg8GezvzC8v6udHxwv3O5h/vS5TGq66qwKzrn+WufMtr4tVQMbI9Z9cgLBVdkR8zr
 Sxue4Ic+2GFBd4CLgfPN9hCkBhnnr8M0B8gI9jeBqVF/Opa++AzOSCULoecmgZ8xuiCw
 GdqVJpxvvNwKvfERPW5ORPZrU9VaCEDpgrNiHU6K8GLjqD0+og17BjoIMqDNNcjBvSo4
 TcbQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHFhYVJSJ/bduTc4oOAoIt2T/nGjSd8NLHy/k2lyZZNNrkMzFHDY+RoqfvmLlENsvAH3jFrXPJ4u9s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/+NGIMzL+hDUrRbE8I+aUxsPgU+eY2P3Sq6vsB8THdI3stuwK/
 zDbLBqFsw5Y2Df4iqdofKbeD7Z7+CysrIrrTdWwy6kO+aJmlgqkluW9Y
X-Gm-Gg: AYBFou1M8e3O367e2DNZioGTs10PT6JeH7H8E+7Vb5NGYKXEUwHPM2PqA2qBkEX8ulR
 FBkBqfSCBiXapBXnWdoQjyyNf2k9yMqI1NxcupgUaQ0MXmhbRIeZLgf5lzl8cxdjrSDlUMkfkD5
 3X/naCVTRaRqCNls/giYEkfqMN5Tey3LV1YyEQj/nHbogkoPyQZfDEnkxvIfml5vNtvj5xISE35
 BwvKe+U9xKHF23DVrAwAgJcyXzM7C1oJEYgAGmBEUkne8Nu/gsytIJc2a09dK6u2vIq0TKfXB7N
 E+t94kwFJSl6E9RKTeUydrFA5DwFMFvqfOFtAqjDRXoxyrie2TahlgAca67xgugK5TPYFrKj1/J
 i8Ax74hNWckbR1DSPcCWPN3vhUm6b+DmA6hmYzcQjDa8MHdxywPQdoVQq1pYCPa0HQRqPZs2bmo
 xK5k8AAcCeo9v2iW7BDEWm0Pn1ZmheqrdPSsSF+auPCGQViFz1aw25oVuVbJIudumkrn8AJOl9+
 LAStp1/sQQrG2mtJcC6i1DRXsn6OttEcYsjHtN5fSXazb99cnMIdtMTsNb1gIigv00DLDqxK8tS
 BQDPSugqBwbvAycwqEyekWQ4CZazm2RVhelzMYnEovPQivmYTgRg3iCZ+epFLvNBhpwetTfmRlw
 =
X-Received: by 2002:a05:600c:638f:b0:4bb:6752:8400 with SMTP id
 5b1f17b1804b1-4bb8881a2bbmr71997325e9.17.1795190099296; 
 Fri, 20 Nov 2026 07:54:59 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm83982635e9.9.2026.11.20.07.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:54:59 -0800 (PST)
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
Subject: [PATCH v5 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103
 panel
Date: Fri, 20 Nov 2026 16:54:46 +0100
Message-Id: <20261120155450.7719-8-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120155450.7719-1-rofikcoga@gmail.com>
References: <20261120155450.7719-1-rofikcoga@gmail.com>
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

