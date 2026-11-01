Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C7C606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=IBxImPXn;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=H+gTZhPy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E929510EBCD;
	Mon,  2 Nov 2026 08:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="IBxImPXn";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="H+gTZhPy";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89A8510EAEA
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575935; bh=rtgj7uGXBAQ57urpWsYPPYB
 FpOSCUOJzGYz9yM6xn20=; b=IBxImPXn2uj/ftkS+UNxRZC+63C/hdfWHHqQdmpyDUprIkJFwR
 ED4e9C4cyHvcr5t6GZaNqVXMJicDJqBYeCBQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1793575935; bh=rtgj7uGXBAQ57urpWsYPPYB
 FpOSCUOJzGYz9yM6xn20=; b=H+gTZhPyfLCi/aYh/gX3Wqybld1Qd+49q9klccRKR568ImdGvK
 YQZAhfGI1ux2RlM4Vzhr7xj2uQhUJd3PyJFTBfZ0LwHKmvAeXzXdMt4NsonAkIaQJWgZvIT6sRY
 SS+FtPm20JZDtIB12vU85N9vR7bp8zYha9A/CklQ+AEJWLu7t1i5zVhY40cL3RgZjL1rSpk4nS6
 R3EnzC9rF78goNGpaPBVZ4ltKRVgFOpOg4u4iC8uzhDEbZDJi/Bn6a3G5tWqfgKaK8iAeMBOu3B
 YR2egQB8eA25ZKdQjTFkBSeMWW7KHJVebSUJN1tRKKs8N+Q/TytVXBRtfhQjAwV1lkQ==;
From: erebion <erebion@erebion.eu>
Date: Mon, 02 Nov 2026 00:32:14 +0100
Subject: [PATCH v3 10/12] arm64: dts: qcom: sm6350-lena: Add PM7250B thermals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-pdx213-upstream-3-v3-10-cdc3be96d257@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=1262;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=u2GwnDmDYcipGyAPUW3uEIoJsCI2qcfaYNBM+JyG38k=;
 b=IBOrQXl5+6tEX3D0k3A8HJObNyiP5YSvLWxOECvaGd6z6aJ+0Eoth+PPOS/xMiKkQ5of5rZ0q
 aBeyMowiTs3CSU3wvr/VwdCCMjFNvdxUrLFkapoqf/e1lKuC+PToj+3
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

Configure the thermals for the chg-skin-thermal and conn-therm thermistors connected to
PM7250B.

The trip points can really only be considered as placeholders, more
configuration with cooling etc. can be added later.

Signed-off-by: erebion <erebion@erebion.eu>
---
 .../boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 6d5aa2fce4c0f..4e9707712a651 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -91,8 +91,8 @@ memory@fe901000 {
 	};
 
 	thermal-zones {
-		xo-thermal {
-			thermal-sensors = <&pmk8350_adc_tm 0>;
+		chg-skin-thermal {
+			thermal-sensors = <&pm7250b_adc_tm 0>;
 
 			trips {
 				active-config0 {
@@ -102,6 +102,19 @@ active-config0 {
 				};
 			};
 		};
+
+		conn-thermal {
+			thermal-sensors = <&pm7250b_adc_tm 1>;
+
+			trips {
+				active-config0 {
+					temperature = <125000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+
 	};
 };
 

-- 
2.53.0

