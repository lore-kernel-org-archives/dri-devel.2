Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B59C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A5B10E841;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="l3Q70ArE";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="e+V1PtBO";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2895E10E0B7
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790418023; bh=JxoQujokhDjxYRx90uleySb
 KEhTWBdlUCQMRA2cRPiA=; b=l3Q70ArEv0u+CbHawQ7nIhkj7g6kCd9hUwC5/C2kt6gAMrlaWn
 xs3oNq2Y+O5MlEsBKSGn2ryUOgJxdLcCcTCA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1790418023; bh=JxoQujokhDjxYRx90uleySb
 KEhTWBdlUCQMRA2cRPiA=; b=e+V1PtBOFpr4SM3yt3bhfndhmNK0/e2Ra1ysN9D/1OSdLDI+mo
 GeoJlASN5jLOwZ7APXFlUzJ+kc1U571bmktXQ+vmdgcxSLas0PRgLZ8ieVDWQ+5dloqh/p2NON7
 bdbt8Ndpeg+LmLOuGmnD64vOZPgSXtvheP56JKmZ2ttVkR6ZZIsptOGT7xZ4nU6Cz+TTp3j5jce
 JPUF0ul1ODyGijKRwpbw3d2sVe72mUehPzTy9EwcmoTkLOs4qGun3y05yNwWRPItABydQxgaMd7
 gLPdLDPgyw7oevYfbtB77g72ADH3nREvET9cagS7koOnL1oNN9+9yUYNjCCB+nlZmHQ==;
From: erebion <erebion@erebion.eu>
Date: Sat, 26 Sep 2026 12:20:21 +0200
Subject: [PATCH 4/8] arm64: dts: qcom: sm6350-lena: Enable IPA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-pdx213-upstream-3-v1-4-1609c18b5c1d@erebion.eu>
References: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
In-Reply-To: <20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu>
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
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790418021; l=816;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=xIZsSV15xgWwCEFN7ifKseHdX/FBRAwBsnSP4sTalbw=;
 b=LhSfNon9HmmD9uU9aLcz4umicJyctIgk8Wc/IRc0ORonWM4NS4WeYrQGwnxE6lg0u/fNLP/XA
 6t/Wha2k/QZAhjPCSKkxGz2+tpkiCkEUVVo1OgeRY5QSmh3txLGKgwK
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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

Enable the IPA node for the Xperia 10 III which makes mobile data work.

Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 79854151a84ac..146c7c5c45ea2 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -333,6 +333,12 @@ touchscreen@48 {
 	};
 };
 
+&ipa {
+	firmware-name = "qcom/sm6350/sony/pdx213/ipa_fws.mbn";
+
+	status = "okay";
+};
+
 &mpss {
 	firmware-name = "qcom/sm6350/sony/pdx213/modem.mbn";
 	reg = <0x0 0x04080000 0x0 0x100>;

-- 
2.53.0

