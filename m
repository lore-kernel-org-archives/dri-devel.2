Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B751B606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=erebion.eu header.i=@erebion.eu header.a=ed25519-sha256 header.s=202508e header.b=Sm77vU/r;
	dkim=pass (2048-bit key) header.d=erebion.eu header.i=@erebion.eu header.a=rsa-sha256 header.s=202508r header.b=NoaC/YnX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE6110EFC8;
	Tue, 17 Nov 2026 08:09:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="Sm77vU/r";
	dkim=temperror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="NoaC/YnX";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BF5A10EAB5
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 22:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Date:Subject:From; t=1794869432; bh=FRTZ0UZ+O5UMbm2peSSpDUx
 iOixTmh4Ad8SIaAVLsT8=; b=Sm77vU/r7NfX+5HnVXq1nuqVkjmtScptK3wHFoEULPZxXDB0Cc
 n6RVdeMggm29fJWwtFCPz70nN8goey/qhaBA==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Date:Subject:From; t=1794869432; bh=FRTZ0UZ+O5UMbm2peSSpDUx
 iOixTmh4Ad8SIaAVLsT8=; b=NoaC/YnX38nou3GqsnFmEyfLDFVgDaZ8p4gkesAUrSctYCi7a4
 cDn0WmO1qnSKYJNOELvtlcEC4AKFHv32ZA9znHVuEbaeHFIvCURWmxWQNMeSSokOEWPaIYE8k4U
 CmLi6cQdKUGZfx/L28icGGIsB3MsE7M9zaUlArehzdrMHvKqBhB/SWmIVvTvEaUI2IPVqKONY8u
 8UxwCc7A0m71j/XOjqS4Qf3BLZs83iLABmuqc6wvMJZmCOfyJTCL2WFvL/cJIGGv129HKV4FwZv
 1Lq8i+r19TvUnhHjM+ZhYCaucZJ8RQzk74b7VRfLUYMGMsNHtttVLfQI45rnGTtoZfw==;
From: erebion <erebion@erebion.eu>
Subject: [PATCH v5 00/12] Enable more nodes for the Xperia 10 III
Date: Mon, 16 Nov 2026 23:50:30 +0100
Message-Id: <20261116-pdx213-upstream-3-v5-0-7318a19806eb@erebion.eu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XP3U7DMAwF4FeZck2m2Gn6syveA3FRJx4LUteSt
 NXQ1HfH6xACrRKXVo4/n1xV5hQ5q8PuqhLPMcf+LIN72il/as9vrGOQWaHB0tTY6CFcEKyehjw
 mbjttdTBUm2NVNORIyd6Q+Bgvq/nyep/zRO/sxxv0nUj8Mcmx8R5T1GbWvu+6OB52c7W3OnlQt
 +1TzGOfPteCM6zhtUuD5UaXGbTRIK8eanIewrNcIvnTnqeVm/FfAoWgogRky+Rs+UDYHwLA4BZ
 hhfDBW+KmDOiqB6L4RcjuBlEIUZAB70xbI/g/xLIsX2e5Rbi6AQAA
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
 phone-devel@vger.kernel.org, erebion <erebion@erebion.eu>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794869432; l=4197;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=B6kkZUwaP6FohDG2oMa6B64oG+I7IHAtHRL6P3bj/+E=;
 b=WlJVwIV1K2qaE4D/gTcTEsiShpIVngO8dbB221L0mtm2FAyaXH+5OLZhYs25r1UuoMO2wlZ0T
 OoxHBlLfH7DBn+3RR0miXE8Jzxo9L4uNNIrfr2LV1qYcmbwJds88RrS
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

Enable some more nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
Changes in v5:
- sort some nodes alphabetically
- fix firmware paths to use codename "lena" instead of "pdx213" for consistency with other device trees
- PM6150L thermals: fix commit message after removing RFC_CAM_THERM in v4
- Link to v4: https://patch.msgid.link/20261113-pdx213-upstream-3-v4-0-4b01c50a821c@erebion.eu

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

