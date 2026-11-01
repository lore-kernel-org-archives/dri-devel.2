Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E52606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=rinAXkiP;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=g8rOTzW4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC5BC10EBE2;
	Mon,  2 Nov 2026 08:04:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="rinAXkiP";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="g8rOTzW4";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C536D10EAE8
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575931; bh=pLNL6UVi3gVPSInf8873bIa
 sTzMDMT2bPa2FgvtzUyc=; b=rinAXkiPvxxC+rWlHQ75Cqh82+XYoB55wDCBAvWWe5t3rq2T4C
 w17b1bkAAqmPtxu3ey3Thv07nJCUoHwokOCw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575931; bh=pLNL6UVi3gVPSInf8873bIa
 sTzMDMT2bPa2FgvtzUyc=; b=g8rOTzW4yC/jPD9tg0nwpMZzInKNuZGpKdExOqio7GQntuqO4S
 PsykdxGHFQWh6DcBt5s0u8jq3DPFATbJfUCTJV4C1/c+1DEgH/5OnfvBitJp7TBIozzjbbspwNB
 +4ewv2+sSl8fJzRwps3TAgWcuAcxtY4C1jrrcWQyGa+FORRHpR/C9skUxBHEOd1Q0fUMcsU1fpi
 /U5WkBsQk/ymS4Jxb0YLleotTFkDnk9TWjcuqK/JNDgqzNsiggenQZu+JOB1IvoGuLiuol+094i
 e/MIPQMe6y7DAewnZu+QDMqWP24WyKXZ8d6YzCHyVp03Fq+uhmGpzm1t+4U34+U1yTg==;
From: erebion <erebion@erebion.eu>
Date: Mon, 02 Nov 2026 00:32:07 +0100
Subject: [PATCH v3 03/12] arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem
 node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pdx213-upstream-3-v3-3-cdc3be96d257@erebion.eu>
References: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
In-Reply-To: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 erebion <erebion@erebion.eu>, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=1171;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=ZX4tBF6GETRfducu02RnlxWwnjhMVMVY9sJUqJ3rc50=;
 b=m2wigLiw5j3mS1sQe1sdmoJuNvnRlC7Svc1vp2xjrPHz0IPyqhKcLvEp288EsasAH5MR/T5Ev
 lZf2VRMLeZuCJhbhoVlcUNJuw7+rOqjK/UuDXgqmLyLBMdXoXZ5pox6
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds the qcom,rmtfs-mem node required for the modem

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 9295b2e6f179f..1e89c9798edf8 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -4,6 +4,7 @@
  */
 /dts-v1/;
 
+#include <dt-bindings/firmware/qcom,scm.h>
 #include <dt-bindings/leds/common.h>
 #include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
@@ -63,6 +64,17 @@ touch_en_vreg: regulator-touch-en {
 
 		vin-supply = <&pm6350_l6>;
 	};
+
+	reserved-memory {
+		memory@fe901000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xfe901000 0x0 0x280000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
+		};
+	};
 };
 
 &apps_rsc {

-- 
2.53.0

