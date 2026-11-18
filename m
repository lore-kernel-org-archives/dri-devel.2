Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82367606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b4H3Yr/m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451E310FCD3;
	Wed, 18 Nov 2026 13:47:17 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0D1F10FB7E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:07:25 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so9151855e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795003644; x=1795608444; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vs9tJb/h6LJRO+aSwhkp7pdT6zxOETm4VTGXKNC7Dbs=;
 b=b4H3Yr/mpUD4D4wscN/55bQ0G88UoBC5LHyqEsDHKmPJCvDHgTU+D+nFulVJQ5okH6
 OcbKInEpcSgaRsPhwG5AVfkj80nZPx61B40XuBOH3gGtLOJ42D3D0ZmZ1p49dM9GB4AS
 prCZY3fQaKJbLRAy5Tpkou9ejTs+ItpivLG1EiqCSMpO3evwI4LGU/bkJhRAoyl5AErT
 n1TEC7PZ6vJAN/nQbMzjN6TFPo/wiI0zW/GAY84RCy6frp/eMVvp6LGXX9oZaiRYha72
 F2VZkQMKin9lpekwV/ykTYiSn+bQ3pCRsfdKhzrZ7boIDYLkHv9Jme7cpF85bAp8AUIW
 nLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003644; x=1795608444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vs9tJb/h6LJRO+aSwhkp7pdT6zxOETm4VTGXKNC7Dbs=;
 b=mFtbbq7AaPn2yQ0vrCjQEyM+yiUykkZVGirTnm+BsYVgbFxvkqdAeWfk32hM3oWBfh
 lN3LVuwM70r0jIUEwEeSctuhGWSSDWvflzQyiapU1nPjR8dcJrz+Tq0PBZi5OhSF0vOp
 M0TY21jirHqKv9KmKx84x2FTi6oAHIwRVvz9w34SuUmBHPQnGsO1UOqmcoJNMOfWG8iu
 X6Cn22U1azVqzVhIjXn8gNcqJlHUgeIDq9Z93DALuhSNsPY/pSiXP8l2vQIlh5MuPqPf
 rQsqS+toO5xKvLtaQfAafbIJ9NfiE4P+paDYMtFL2OIxE4AWWKdyvOvRZpHFTgJx3Zyc
 xY/Q==
X-Forwarded-Encrypted: i=1;
 AL+hErGfmjc4TYADZgg+P7Ujsl+ie5/6NoCb78wgv78OGnKD8IExkYvURwM8iJlXu4Dadzk3LxCU3rrIe8s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/lmKVoOjq2Jw5eWbB+2al3VE1n8DnfLdxvrBS+hxnq4VVrtYua
 c3IzWkhZleQRILRKWs7P2E++3QM3gaBZCke3wt0ta+GFdptlsuIBdGfQ
X-Gm-Gg: AYBFou06LhiwjCmEuFakZOlZ8X+mLB2klhhck9mt+MDaRtZR/7iwqG2yfaPUtV5TiT0
 vW9UiNFPmgtKwolzNckVtBEx4jrLKsCsC0fo1gMnypiFmmGrh5FeZdqxzNfRL1IdnmX8/2Q9sJp
 JbpcZ7EzA/cZyvjpyDuIGUWwlUKf0MfWNgcRFmjEfYXYp3aYyyTBGcYzQ1wmQkPDzA0BM0QY0UB
 IP5fswRprfZ/uK0hm0ldZPz+N72GSis/BahPulLT0mdFzhK09yoG/rmzUl5gvqJz8OOmciXC3fn
 084RFNrLeK+UQqpDAfanIJDV+DYnUm0p57SCxiRLL5Ioo1soC2+R1obBwy8CUr3Fptu4z0a7fsh
 ZJvXcva9OZ8DDcG7dxY2QJLuW30eKDGGr5XQ8nYBbey2XKZrx2qVnww7Z/gzM+kYMNXO45V6mgH
 qMm0puQQcVs3zr0sfLCWXVs1fEM023YxLF82jr7HKivWot02WfYTW0dgjrco+4KCM/lw1U0Glmu
 AcRuijxKkgeikDwAupVeirHl15zCDbAv4pmusjsRc1pZG5Np3RVA/TNPWab3o7XIWmcns7Svz0s
 mT2TkbRMOU9F/2TfA+NZaSlngcdRJ3nKB0T3BrtVfPZ/d2ghv3tEL8nb0imCreSTaJ4UBS5j694
 =
X-Received: by 2002:a05:600c:1911:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4bb7d57bc33mr43616545e9.0.1795003644117; 
 Wed, 18 Nov 2026 04:07:24 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c37fsm4382583f8f.18.2026.11.18.04.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:07:23 -0800 (PST)
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
 Ivon Argel <ivonargel13@gmail.com>, Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v2 07/10] arm64: dts: qcom: sm8250-lg-timelm: enable SW43103
 panel
Date: Wed, 18 Nov 2026 13:07:11 +0100
Message-Id: <20261118120714.31505-8-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261118120714.31505-1-rofikcoga@gmail.com>
References: <20261118120714.31505-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
 arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
index 1b2b67486fee7..d307a52cd0e62 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-lg-timelm.dts
@@ -8,6 +8,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/phy/phy.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sm8250.dtsi"
 #include "pm8150.dtsi"
@@ -460,6 +461,42 @@ zap-shader {
 	};
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
 	google_assist_state: google-assist-state {
 		pins = "gpio1";
-- 
2.39.5

