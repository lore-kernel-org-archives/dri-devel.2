Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48122606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=FXt5kdIY;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=hdWWgIRb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C388112549;
	Fri, 13 Nov 2026 13:43:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="FXt5kdIY";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="hdWWgIRb";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA8BA10E6F8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533098; bh=toaiJ6xRzRwCiqQcoMYQQ4K
 lPimfwK+TpP/19ypXGuo=; b=FXt5kdIYy+F/bIlV0oHXP4dINEBX/+AHX40sj11zx1tz4sHlTG
 5PG+Qf1VRp4HU/X0HCbWkIoZOSmylDRrGyAg==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Subject:Date:From; t=1794533098; bh=toaiJ6xRzRwCiqQcoMYQQ4K
 lPimfwK+TpP/19ypXGuo=; b=hdWWgIRbEee09411QaXuwrtze4JPWYOVcETQNraOeU6HkcXn3C
 x6fVoRvqvxCpCdCI9ZrBbASSE4HcYpFgMTtHdp9c125S+QvHhxwg9KjL62Q+Sl8GJRHTKVubK5G
 x0LRIsKLNyRJCxI38zGkec/F3q75R5rCJUqsDjz97AFQPnyla7IcJnVYFLNqk0XL8ssMItfMt98
 BqKQWsiMQEZ86iHL9v1m3QEQc+sjPV1XrviOVX5OyUsb0krFI5N4OWNn2O+AkVg0ZSwmYEZsH4H
 nWTbnhvTiQkoKabXn2QRkyXdCR8zS6kEvoODlezd3jjlTv43Dzu6JaUvRZt8wy4lymg==;
From: erebion <erebion@erebion.eu>
Date: Fri, 13 Nov 2026 02:24:53 +0100
Subject: [PATCH v4 09/12] arm64: dts: qcom: sm6350-lena: Add PM7250B thermals
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-pdx213-upstream-3-v4-9-4b01c50a821c@erebion.eu>
References: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
In-Reply-To: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=1287;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=XZdwyvJDFwgUmhYR8i66OVWnfBf8i7F33o8/IDxYXnc=;
 b=2Xkqf5lBGGdZAa8J+gBkJi9kikAS7DWnEnk9RCkDSIKjXAirg3yRnianu+8oyVAqw9pO5j2l6
 ZsHWsYmlJyBAP2I80Gsb9J66x0NJFKu5wgdOHwRXGgju1vvpPmN1vDM
X-Developer-Key: i=erebion@erebion.eu; a=ed25519;
 pk=rOCVlR8khmBtCFe4ZlDcbCbIcORxdaNzPDkoIiHM7xc=
X-Mailman-Approved-At: Fri, 13 Nov 2026 13:43:28 +0000
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
 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
index 361ed8ec96c81..d37f5090dbfa7 100644
--- a/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
+++ b/arch/arm64/boot/dts/qcom/sm6350-sony-xperia-lena-pdx213.dts
@@ -80,6 +80,32 @@ memory@fe901000 {
 			qcom,vmid = <QCOM_SCM_VMID_MSS_MSA>;
 		};
 	};
+
+	thermal-zones {
+		chg-skin-thermal {
+			thermal-sensors = <&pm7250b_adc_tm 0>;
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
+	};
 };
 
 &adsp {

-- 
2.53.0

