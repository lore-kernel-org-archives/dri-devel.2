Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0FF606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=F/1X/NFu;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=TO6qucVG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E10D310EBC5;
	Mon,  2 Nov 2026 08:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="F/1X/NFu";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="TO6qucVG";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E83B10E032
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575931; bh=A3HrRK4FvbWtY7EL2njqxBf
 Md8XMbZtTC9D8yv8diuw=; b=F/1X/NFuycUrE89JwGnDEUfCn71c2S3BJ6wzD8h9w8ExF0oukp
 s/EgLg63VZ5Qi2kXnOGDONZYyDXymmcuV8AA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575931; bh=A3HrRK4FvbWtY7EL2njqxBf
 Md8XMbZtTC9D8yv8diuw=; b=TO6qucVG/CTpHAO2Nvo6m3GDO6cNdG5I+pILqvGfeoqOHon4sl
 MCESROwyS0Zd2+SA6kn9DggXbR9wKqb51EmyWwS4j+hOoLeoAG5CuKXMEAssLqkfFrMujbCnRds
 PvU3ZJbOkLQ4GULpf59kh1K71YgqaJkDhw38DME4WSkbUUc7aXKTOhoqw5T9yvjSEK21hhuzrgl
 gJJk+VdHfrm4RTyM6LH2iBNOBUVr/L99lUPOr4leMPs7kV+X4d09cOgV9riKSbAhFY6b74ARBRs
 OCWimeiegV0V3M3MerCJjqtpnzd7KprdT7hfTNyJXGtAbXuHzmhW7xQlOQlEuPZaPRg==;
From: erebion <erebion@erebion.eu>
Date: Mon, 02 Nov 2026 00:32:06 +0100
Subject: [PATCH v3 02/12] arm64: dts: qcom: sm6350-lena: rename
 touch-en-regulator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pdx213-upstream-3-v3-2-cdc3be96d257@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=1159;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=mWMUpJaqurQNInIdHEEH2VFWKS03NCWRKZqnMFtZxOI=;
 b=eOTlD5j8uKA+goKG7TzsmPU2Hj2451Yciedozlbdb4QiKxaxCxrFq1EZY1ca19dk6LWicJYYU
 KYngx+CWr0MByLKGZ6iKKZpDkxnZOMs+NKzV717uRIvah2bEMDfajly
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

rename touch-en-regulator -> regulator-touch-en, to
keep any future fixed-regulator sorted together

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 6942a117d41cf..9295b2e6f179f 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -46,7 +46,16 @@ key-volume-down {
 		};
 	};
 
-	touch_en_vreg: touch-en-regulator {
+	lcdb_dummy: regulator-lcdb-dummy {
+		compatible = "regulator-fixed";
+		regulator-name = "lcdb_dummy";
+		regulator-min-microvolt = <5500000>;
+		regulator-max-microvolt = <5500000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	touch_en_vreg: regulator-touch-en {
 		compatible = "regulator-fixed";
 		regulator-name = "touch_en_vreg";
 		gpio = <&tlmm 10 GPIO_ACTIVE_HIGH>;

-- 
2.53.0

