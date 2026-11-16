Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56203606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=f1155HqW;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=Q/wcllCy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87CA110F128;
	Tue, 17 Nov 2026 08:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="f1155HqW";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="Q/wcllCy";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA1910E559
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869436; bh=2H3USPqsNDDSigy5x7XvWEz
 9VqPRsXwpNxxJiPmmYi0=; b=f1155HqWXoHfX6ibHV1NloiZoL1sMJS3ccWUBPmwkqSUiXEaKa
 jQLpNz3FAQVKHdi1UMfOhqxAEeIscxu0MRAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869436; bh=2H3USPqsNDDSigy5x7XvWEz
 9VqPRsXwpNxxJiPmmYi0=; b=Q/wcllCywLrE8vvHTi3DL6rMsa7xMogJVbnSNR7afxzHgAyzXn
 5yDzFM7XWQRZcZb44pmZktjXLB3AeIZLdFayezym6Qc+3nD+8FnPlwh8z/QGZJz+l7qx3MbC5Ss
 VRGteSqVMM7jodIpjO0QgdEQkiH6flpZzs9RkGCA1p9aQQfvrWcrcV+DsCcef9kOozrG9dSVmYh
 90fSse4301isEkktKJte06qY744oxJEfw8izt42U90bcWxUYw/vcC//0Xx/SB3Tpi9MrASA9OaT
 VJxPuVtQsuR9uNfIs+rEUymKZIKiWERsUja2EDJNuYFG3t7xHwlVgB2hszsFkJK6M7A==;
From: erebion <erebion@erebion.eu>
Date: Mon, 16 Nov 2026 23:50:36 +0100
Subject: [PATCH v5 06/12] arm64: dts: qcom: sm6350-lena: Enable wifi
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pdx213-upstream-3-v5-6-7318a19806eb@erebion.eu>
References: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
In-Reply-To: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
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
 phone-devel@vger.kernel.org, erebion <erebion@erebion.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794869432; l=969;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=rV3iaKjdfvCIrScoNBQZmYrZdzhOToTM5Ry31HH74sI=;
 b=VQAmkbbbweZTPL8KdXg7GhIiHPaJfbg/igvB1Pc+025m39i0GvMDCxuh7xqgK7oyUgIcODeqD
 dCTl8aAW3qzBUuqaHT9uTNM2tXjkv/N3+7lY0tBv2u1PqzDZCLWq2wU
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Tue, 17 Nov 2026 08:07:18 +0000
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

Configure regulators and enable it for the Xperia 10 III

Reviewed-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 12bf5420530d3..9d880f6baa531 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -541,3 +541,13 @@ &usb_1_qmpphy {
 
 	status = "okay";
 };
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm6350_l4>;
+	vdd-1.8-xo-supply = <&pm6350_l7>;
+	vdd-1.3-rfa-supply = <&pm6150l_l2>;
+	vdd-3.3-ch0-supply = <&pm6150l_l10>;
+	vdd-3.3-ch1-supply = <&pm6150l_l11>;
+
+	status = "okay";
+};

-- 
2.53.0

