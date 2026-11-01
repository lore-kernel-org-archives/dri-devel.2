Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A644B606A334
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=WY7kLVpJ;
	dkim=pass (2048-bit key, unprotected) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=y4DgZdkE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D56410EBE7;
	Mon,  2 Nov 2026 08:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="WY7kLVpJ";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="y4DgZdkE";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB4810EAE3
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 23:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Date:Subject:From; t=1793575929; bh=YdLfVBIXcpx+KBVxrVKXny4
 2OGdUGd1/NYnn2qwiQSg=; b=WY7kLVpJI87L8zbyD5cwQ3uVWsbeHAru9mHA9v6hYTnQ/iWemC
 99nhCD92rHirmuO720QPerwAsT9NdUn6HRAw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Date:Subject:From; t=1793575929; bh=YdLfVBIXcpx+KBVxrVKXny4
 2OGdUGd1/NYnn2qwiQSg=; b=y4DgZdkEa+lsYZMa1xTESGZgvEKEszef1ZizsI/y3rTvUFEswo
 fvRTkctMlCc2gG3k9fBY6RmaiX1KeuIS/FPFj7DK4i5mHYyTW3CT1XMN5XzBZ0GK6BwH9mTu9/B
 Tnit4YJhQk4UIM5L2KaKCiSOG1Gn4q9aJhwwWwsuxUJ/a22Rpsus+NtvbOvQ20SponKdhG569RS
 u+uUWBUCMb2ldtN4oEn5U+Al+PipA4TVA+MQn1oWjGPG5DgJrGpi6v+RNonVAjWdJ9ceDhtaMuf
 b3w0Ue+bB0G+78rMhN9F5KDKPL1ohlB9zsgCAC58rnGKsI6rA06dxbaiWsGTEI9gZPA==;
From: erebion <erebion@erebion.eu>
Subject: [PATCH v3 00/12] Enable more nodes for the Xperia 10 III
Date: Mon, 02 Nov 2026 00:32:04 +0100
Message-Id: <20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WPzQrCMBCEX6Xk7Ep+7O/J9xAP3XS1EWprkoaK9
 N2N0YsgeBx25pvZB3NkDTnWZA9mKRhnxmsUapMx3bfXM4HpomaSy4JXsoapW6RQME/OW2oHUNB
 xrPip3NWYI4u5ydLJLIl5OL61m/FC2r9AH4el2xzL/NvGsHUEehwG45sslFsFVgv2SvfG+dHe0
 8AgkjltqWXxY0sQwEHEqxYV5lp0+9iE8actzQkX5F+EjAjcFUKSIsxV8YVY1/UJ3qanujQBAAA
 =
X-Change-ID: 20260829-pdx213-upstream-3-d0b80f749b5b
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
 erebion <erebion@erebion.eu>, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793575929; l=2677;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=ePTep/1Ur/gvnFD3B6+t8eCjbWBC3v8rbA04R3CFNgU=;
 b=Dg7TYuEPt+vWb7VWR7A5OlUj/jZzTD1rGuKxe3JzcAUSrEViPam8lCEBmhyf8eeTFNVUORHvZ
 PCO+xCTWwAxA1UCmYTlhXdOrjQW0hUE01miUeWv7PpLSWd5rs2QmBmv
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

Enable some more nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
Changes in v3:
- re-order some properties, generic properties first, then qcom,*
- &pm6150l_flash: fix led-max-microamp value
- rename touch-en-regulator to regulator-touch-en (to keep any future fixed-regulator sorted together as well)
- Bluetooth: remove incorrect property that does not exist
- Bluetooth, &qup_uart1_cts: do not overwrite a bias-disable with bias-bus-hold as it is not necessary
- &pm7250b_vbus: fix regulator-max-microamp value
- Remove comment from reserved-memory as suggested by Konrad Dybcio
- Squashed the patch enabling IPA into the one enabling ADSP, CDSP & MPSS, as suggested by Luca Weiss (therefore not adding the Reviewed-by from Konrad Dybcio)
- Configure thermals for PMK8350, PM7250B, PM650L as used in pdx213
- Enable remaining i2c busses
- Link to v2: https://patch.msgid.link/20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu

Changes in v2:
- Remove panel_reset_pin that shouldn't be part of this patch series
- Remove incorrect reg from mpss
- Fix conflicting bias pinctrl, as pinctrl nodes from sm6350.dtsi already contain a bias-* property
- Fix incorrect unit name in &pmk8350_vadc
- Link to v1: https://patch.msgid.link/20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu

To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
erebion (12):
      arm64: dts: qcom: sm6350-lena: Add flash LED
      arm64: dts: qcom: sm6350-lena: rename touch-en-regulator
      arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem node
      arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP, IPA & MPSS
      arm64: dts: qcom: sm6350-lena: Enable Bluetooth
      arm64: dts: qcom: sm6350-lena: Enable wifi
      arm64: dts: qcom: sm6350-lena: Enable PM7250B
      arm64: dts: qcom: sm6350-lena: Enable PMK8350
      arm64: dts: qcom: sm6350-lena: Add PMK8350 thermals
      arm64: dts: qcom: sm6350-lena: Add PM7250B thermals
      arm64: dts: qcom: sm6350-lena: Add PM6150L thermals
      arm64: dts: qcom: sm6350-lena: enable remaining i2c busses

 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 503 ++++++++++++++++++++-
 1 file changed, 502 insertions(+), 1 deletion(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260829-pdx213-upstream-3-d0b80f749b5b

Best regards,
--  
erebion <erebion@erebion.eu>

