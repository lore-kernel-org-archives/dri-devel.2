Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABAC606A327
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=ZkWlqeoe;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=DZdRLL+f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 063EA10EBED;
	Mon,  2 Nov 2026 08:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="ZkWlqeoe";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="DZdRLL+f";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546BC10E4A0
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575935; bh=nnBDFfVscNSIMWRGuukkAP3
 sB4Yng2JMTdu5t/euvJ8=; b=ZkWlqeoeYOUN6cTHBwsaUVwqumbXfRRWpgyFfifj7UMKfP2J/2
 nx2VP9FFUyhQFIwQKP/eeIVYjWg9dhVJIjBA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575935; bh=nnBDFfVscNSIMWRGuukkAP3
 sB4Yng2JMTdu5t/euvJ8=; b=DZdRLL+fHij1RD8G4B0/919PHvplINAtKnleTp4pjD1/FOv446
 epPuJgQ+xPShEHvMjojIRpFuV97JC66fJao3hQ8nccZnQnx/Je+fTYXR71mShgbPjgwyTRTQIso
 debIo7fTvby17nVAUEjZElEE5tmjhX7wSMtm3cDKwgSxB5+7FO/perSFD5dIQdjZTqO0XbNEKAk
 91CbO02KIZYvrvA96G9hVWg1B2r0PM32Uk/YKT/aWI7jvBXqdwJxaf8bx5ZgO225bYF4Igin6jL
 ssy4VSKIaMr+SSf7gmFiS14xFkivtcYf24J0A1Qeh3nizfy7KZ2YPfocI70OjEuJWsA==;
From: erebion <erebion@erebion.eu>
Date: Mon, 02 Nov 2026 00:32:13 +0100
Subject: [PATCH v3 09/12] arm64: dts: qcom: sm6350-lena: Add PMK8350 thermals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pdx213-upstream-3-v3-9-cdc3be96d257@erebion.eu>
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
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=1046;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=jKbReSlDndZO287vvL8FQ7RDc20bEUG6zhPvlLfoMOg=;
 b=B76EndlOSFxzN9N3fVPNeVVReXwdX00QqnqK9DRZ9ETycgU19YWLSwgOCUJxcIhHyJnEzRN3E
 1CxZlO3Ffv/CuZKM00lp4jEBVoy7C9q2a/cAA6xSYrer/J8g8Zj37Ap
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

Configure the thermals for the xo-thermal thermistor connected to
PMK8350.

The trip points can really only be considered as placeholders, more
configuration with cooling etc. can be added later.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 246a290e44f77..6d5aa2fce4c0f 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -89,6 +89,20 @@ memory@fe901000 {
 			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 	};
+
+	thermal-zones {
+		xo-thermal {
+			thermal-sensors = <&pmk8350_adc_tm 0>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
 };
 
 &adsp {

-- 
2.53.0

