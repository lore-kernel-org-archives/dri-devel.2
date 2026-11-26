Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42897606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NKQjsXEt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 580C610E9AD;
	Thu, 26 Nov 2026 13:46:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BC510E9AD
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:46:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26A8663365;
 Thu, 26 Nov 2026 13:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61E21F000D1;
 Thu, 26 Nov 2026 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700781;
 bh=5pFjIV7o9HsajqxA771v2mYVU2R06JQWgxnrI1jbZX8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NKQjsXEtM0n7iVwbbs4Qpg7fUooGGDCuAIsqBZw/ujAUTHqIv7JGoUrzWnwg26Lbq
 gj6D/ypPLMxHSVTlaKa8Zrtd4dC8ECIdS5HKH9ZdWswP1PDayZIvWQD2BO7Z4X6QjZ
 oQBSxmC5BnIN1kpws0mh1RGh7FifLr+bEHnkpbYoW/23YL9viffHOksrI5t0HJRkJ9
 nQFQBK+BSkfXQv9bXAvdTgUZNOHtPQSBiHUYt4nhWSnM+AVRHseTUMe97akstAgW98
 uRPtsyPCp6hMAYS3t0bjwyGl/MfnsG5ZkbgnKuRPtOwuIqq1Ke000s50q6gz/UQx+Y
 IASaaC//GSkBQ==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 09/10] arm64: dts: qcom: qcm6490-idp: Fix the panel reset
 GPIO polarity
Date: Thu, 26 Nov 2026 15:45:07 +0200
Message-ID: <20261126134508.320700-10-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261126134508.320700-1-vz@kernel.org>
References: <20261126134508.320700-1-vz@kernel.org>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RESET_N pin of the NT36672E panel is an active low signal, however
the panel reset GPIO is described as active high to match the inverted
reset signal polarity, which was assumed by the panel driver.

Now the polarity of the panel reset GPIO is enforced by the gpiolib-of
quirk, so describe the panel reset GPIO as active low to match hardware.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
index cb90a83351c3..ca5c868be495 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
@@ -652,7 +652,7 @@ panel@0 {
 		compatible = "novatek,nt36672e";
 		reg = <0>;
 
-		reset-gpios = <&tlmm 44 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 44 GPIO_ACTIVE_LOW>;
 
 		vddi-supply = <&vreg_l8c_1p62>;
 		avdd-supply = <&lcd_disp_bias>;
-- 
2.51.0

