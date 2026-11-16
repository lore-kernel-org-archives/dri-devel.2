Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAB606A339
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=IlLamek9;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=lUWsVRte
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E68310EE51;
	Tue, 17 Nov 2026 08:08:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="IlLamek9";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="lUWsVRte";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD13A10EC12
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869438; bh=4xD30dmOEDObdpX44+YP/xF
 1IPjXhgbvg/zotJpsoE8=; b=IlLamek9/lAYn4CpOFndyEXoRJmXQb318CKphmizU9+WPTGNbO
 xs8BxeMKoNiI8+2HG+PhLLnJDFekw9MbT2BQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794869438; bh=4xD30dmOEDObdpX44+YP/xF
 1IPjXhgbvg/zotJpsoE8=; b=lUWsVRteXsowyhMDOfNWCyPyw2104Xklst5BYcAYcfKYq7nfZO
 kuuZKZ6Xca3S1leF0YQyrTFe9uH/PKimIF1sRSl6CZpNiaeNZsHT08ejBAyrjSffaZFC0sBRkCw
 TSVJOAybJdBMo+4QCtHHKQ9UpXmbQQM1vdBGXlbKmsod2asr+DSdBiYoYn+yunuPR0oxz0Kjk9p
 a405xZazGth3+38s5bg6ibc0DW9vTBpbL7mTOUPDoxhDfBbFEhcApuXbFFzGymk6O69O0blPeG/
 f4fTpSL0gR8C/Tf4CFwWE+bG5oBoeY9Q/b/aX1opCO2XR3s3DpYO3exZV7RMkNhCH5w==;
From: erebion <erebion@erebion.eu>
Date: Mon, 16 Nov 2026 23:50:40 +0100
Subject: [PATCH v5 10/12] arm64: dts: qcom: sm6350-lena: Add PMK8350 thermals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-pdx213-upstream-3-v5-10-7318a19806eb@erebion.eu>
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
 phone-devel@vger.kernel.org, erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794869432; l=986;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=0JpiTi0xlhB2fuE37TCd6PDdbjp9yt0CI/NdiN5N/Cg=;
 b=A9HYm7NTN6P3pp2yK1nWgMvg+gxkftE8XMqNGXI27ZOpkMSCkOx3PKRFfH3UFs59uN7lN+MIv
 Fgru9r3jycCAh3Pmnp7MdN2BVLP+AHVyT0C7WX3siGEurMg7q1EXYrK
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

Configure the thermals for the xo-thermal thermistor connected to
PMK8350.

The trip points can really only be considered as placeholders, more
configuration with cooling etc. can be added later.

Signed-off-by: erebion <erebion@erebion.eu>
---
 arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 0bb714eed13f4..b86fe11fd5296 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -105,6 +105,18 @@ active-config0 {
 				};
 			};
 		};
+
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
 	};
 };
 

-- 
2.53.0

