Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D1606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=GXcc1N4B;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=HlR5iYu2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F38112562;
	Fri, 13 Nov 2026 13:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="GXcc1N4B";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="HlR5iYu2";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BDB410E706
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Date:Subject:From; t=1794533093; bh=htH3B+ATk3eIVVdnJU5zHhE
 GsQGg5W7iIPjjlogmzXg=; b=GXcc1N4BFFkb4xriVVmaGW/3s1o7MVpZPCTQ0yxTF4BiQUhaaB
 E/1NvZNVIsrLmE0o19olpiIvvN1xV1GT3zAA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Date:Subject:From; t=1794533093; bh=htH3B+ATk3eIVVdnJU5zHhE
 GsQGg5W7iIPjjlogmzXg=; b=HlR5iYu2GVwebBW7XNLoWCEpy9POhsH+zJZmaspRU3gjhL5EiV
 gS3/f1kTrUewEK8+ZNdB2kva28Ej56nSSwnEaamJ5W2RhC3Zcm4v5tW8bZHK78N3wGTGpxFvOoV
 ZQjao50lScZHN+FSbWFlSZMaykjWklhr4Iw8xLQaXz0T55KV+z3xEedEo7xAGxIJUcTIXBLGkOY
 /sHAimq1qVVoJzuIfGj54v8zxyH7GmPBrBwQ0P1OUvC2B7tzrIus4sPLNGHTFBd8vwtWwOuePcg
 Xuf2R71uB5oFZ5esY6WAwJE7ZYUcK2gGrjwdy8w7ivp5qyhW/bPoEeyTvbpM/wVzMlw==;
From: erebion <erebion@erebion.eu>
Subject: [PATCH v4 00/12] Enable more nodes for the Xperia 10 III
Date: Fri, 13 Nov 2026 02:24:44 +0100
Message-Id: <20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XPwW7DIAwG4FeJOI8Km4QkPe09ph1icFcmpcmAR
 K2qvHspnSZNq7TjL+zPP1cROXiOYl9dReDVRz+dcqhfKmGPw+mDpXc5C1RoVIe9nN0ZQctljin
 wMEotnaJOHdq6p4ZE3psDH/y5mG/vjxwX+mSb7tD3ROCvJR9LjzFBQ2Rpp3H0aV+t7U7LYEHct
 48+pilcSsEVynDp0qN50mUFqSTkVwsdNRbca75E+U87Xgq34r8EZoJqA8iaqdHmD6F/CACFzwi
 dCeusJu6Nw6b9RWzbdgMpfmJndwEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794533093; l=3869;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=3Pa5pf9Jvc8z2x7z55gyE6mseTXvtO+1rGpJyBjOJeg=;
 b=JIPzX0dqmqsEg3mlQ6AJWvaO+tnG49BV6g44WuUm75GBDLTRDHQhtrNsBpjSdCuRnKGVUvZeR
 gjR8CRwvMELCiZ2s5SWP7F6wbeiqyTH2JkUMontvOEmWdWu2TCOwkE1
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

Enable some more nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
Changes in v4:
- &pm6150l_flash: fix extra zero for led-max-microamp value accidentally added in v3 (this was setting the max value 10x to high), remove Lua's Reviewed-by
- rename touch-en-regulator patch: fix rebase mishap and remove a regulator that's not part of this patch series, remove Konrad's Reviewed-by
- IPA: remove redundant properties that are now set in sm6350-lena board DTS, remove Luca's Reviewed-by
- fix pm7250b thermals after a rebase mishap
- pm8350: disable PON, as pm6350 already has it enabled, remove Konrad's Reviewed-by
- rear_cam_sensor: fix gpio to use correct one
- remove includes that aren't actually used
- re-order alphabetically: &pm6150l_adc before &pm6150l_gpios
- remove a superfluous tab at the closing brace of rear-cam-flash-therm@2
- enable remaining i2c busses: fix rebase mishap
- fix firmware paths to use upper-case "Sony" instead of lower-case "sony" for consistency with other DTs, reset Luca's Reviewed-by
- remove rear_cam_sensor, as it does not work and I haven't found the issue, will submit later when I get it actually working
- Link to v3: https://patch.msgid.link/20261102-pdx213-upstream-3-v3-0-cdc3be96d257@erebion.eu

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
      arm64: dts: qcom: sm6350-lena: Add PM7250B thermals
      arm64: dts: qcom: sm6350-lena: Add PMK8350 thermals
      arm64: dts: qcom: sm6350-lena: Add PM6150L thermals
      arm64: dts: qcom: sm6350-lena: enable remaining i2c busses

 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 457 ++++++++++++++++++++-
 1 file changed, 456 insertions(+), 1 deletion(-)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260829-pdx213-upstream-3-d0b80f749b5b

Best regards,
--  
erebion <erebion@erebion.eu>

