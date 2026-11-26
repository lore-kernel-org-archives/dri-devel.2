Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3018606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=koSN8y0s
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6D5C10EA38;
	Thu, 26 Nov 2026 13:47:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD8F410E306
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 13:45:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A2BC404E2;
 Thu, 26 Nov 2026 13:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCAE1F000C0;
 Thu, 26 Nov 2026 13:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795700744;
 bh=GYvtdup1iOkPumPiryt8h5FINLGh7OImHJxS3+ykLCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=koSN8y0syq7Wbizj4EKfZl0lNS5/5tam0qAcLbQazXBmEOYDd+qaWxGQgDrvLBV11
 JIqxxfJNONL5KB29nOOVHE7IHVe6iQ7j2AfalIscuFJo+djeF7MWXHeVME4icg09mu
 6n7kgQZJrDBqX5Q/Zv1L+1BQ3a6H3gmyLNUF2Tiidth995lj8kOXHri+9BucFaBI4B
 801Da7BOytZULKDQ39GT4HWj9C02xL4Y7m5t1B06I2E4j/Bd3kK/BQkqgboSr5B0ok
 zus0d0PatCHGAepdZpTLsFVfe/gpjzXIEPB0HP9B+O3FiOxeho4C8ygSneBWdq/Avn
 3p/HMGXABp9lQ==
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
Subject: [PATCH v2 01/10] dt-bindings: display: panel: novatek,
 nt36672e: Describe the reset GPIO as active low
Date: Thu, 26 Nov 2026 15:44:59 +0200
Message-ID: <20261126134508.320700-2-vz@kernel.org>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RESET_N pin of Novatec NT36672E panels is an active low signal, and
panel-common.yaml expects active low reset GPIOs to be described as such,
however the example in the binding describes the reset GPIO as active
high, which does not match the panel hardware, but matches the inverted
reset signal polarity overlooked in the panel device driver.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 .../devicetree/bindings/display/panel/novatek,nt36672e.yaml     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
index bb10d62ac2e4..dabee16bee22 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36672e.yaml
@@ -47,7 +47,7 @@ examples:
             compatible = "novatek,nt36672e";
             reg = <0>;
 
-            reset-gpios = <&tlmm 44 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&tlmm 44 GPIO_ACTIVE_LOW>;
 
             vddi-supply = <&vreg_l8c_1p8>;
             avdd-supply = <&disp_avdd>;
-- 
2.51.0

