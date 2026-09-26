Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48D9CA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B3410E8C1;
	Mon, 28 Sep 2026 08:43:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=erebion.eu header.i=@erebion.eu header.b="tHmjixd1";
	dkim=pass (2048-bit key; secure) header.d=erebion.eu header.i=@erebion.eu header.b="uIDHJeqV";
	dkim-atps=neutral
Received: from erebion.eu (erebion.eu [142.132.183.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4D410E009
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=ed25519-sha256; s=202508e; d=erebion.eu;
 c=relaxed/relaxed; r=y; 
 h=To:Message-Id:Date:Subject:From; t=1790431254; bh=28CwxnSliVSpNHVTu/q9xzT
 V56sbtRybuqgB3xHeeOE=; b=tHmjixd1gLaywcTqwyeblHEH06tOCAFMEMfoxaaaaTsPs9NpMO
 WqH960bh5aQ2xCL5KM6vgXhKhhgkxsI1AkCw==;
DKIM-Signature: v=1; a=rsa-sha256; s=202508r; d=erebion.eu; c=relaxed/relaxed;
 r=y; 
 h=To:Message-Id:Date:Subject:From; t=1790431254; bh=28CwxnSliVSpNHVTu/q9xzT
 V56sbtRybuqgB3xHeeOE=; b=uIDHJeqVuovotUwGmrTdd+3he6QCLaB3imrD0DG40GDwV1tNl3
 68NA40pXo8IkfIMnh2HfbBvbi9/vmeLJ31Os46B2+9uBLh/WbQr7vpOVLkYHjOjQxGN3WTKTmIJ
 BaAPdaty5jGN/oZ5iM1uncRDYF7cmp+go31LUXzVRXvT29DPns9dgOCSiKTzoykiQe2CgSGEtBJ
 DMXEN6aoxDWJ+ZcY3bZ/30cj+is7l/fnOY9iqgqyguJo/c0Anhb7rJamwuFd+NzPexCUnn3N5bA
 ife63bmOwCgAfsBQ0I1HRxJ/AXXV/0It+w3gQn88Cr0sRhUYIJFIkCIkIIQybFUjbEg==;
From: erebion <erebion@erebion.eu>
Subject: [PATCH v2 0/8] Enable more nodes for the Xperia 10 III
Date: Sat, 26 Sep 2026 16:00:49 +0200
Message-Id: <20260926-pdx213-upstream-3-v2-0-b4612e3eb536@erebion.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Pyw6CMBBFf4XM2iFtkefK/zAsaBmkJgi2hWAI/
 24pLl3ezH2c2cCS0WShijYwtGirx5cX4hKB6pvXg1C3XoNgImOFKHFqV8ETnCfrDDUDJtgyWbA
 uv5YyleBzk6FOr6HzXp/azvJJyh1FP4eh9+zH3GkD2VhCNQ6DdlW05HGCRnE40r22bjSfALjwY
 A4spcj+sCwcGXJ/VbyQqeLtzS9J/1NMM9T7vn8BWNP7e/EAAAA=
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
 erebion <erebion@erebion.eu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790431254; l=1202;
 i=erebion@erebion.eu; s=20260607; h=from:subject:message-id;
 bh=67Ax9GT3XJZ/oPQ+TlKH+nxeny2DDTnLBR4v2OpX5Y0=;
 b=K/WuS0fhCgVgGk4henN3rUzofMfwh0d4avHMOmttKC0eXftIwl28mCpkoJsqrv0sjcqgxqKld
 8gH9XwR1XI2BuRUL7m3hTTtkJutY4sxt5ObHABbeUwGdVMLWhCcY0w0
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

Enable some more nodes for the Xperia 10 III.

Signed-off-by: erebion <erebion@erebion.eu>
---
Changes in v2:
- Remove panel_reset_pin that shouldn't be part of this patch series
- Remove incorrect reg from mpss
- Fix conflicting bias pinctrl, as pinctrl nodes from sm6350.dtsi already contain a bias-* property
- Fix incorrect unit name in &pmk8350_vadc
- Link to v1: https://patch.msgid.link/20260926-pdx213-upstream-3-v1-0-1609c18b5c1d@erebion.eu

---
erebion (8):
      arm64: dts: qcom: sm6350-lena: Add flash LED
      arm64: dts: qcom: sm6350-lena: Add qcom,rmtfs-mem node
      arm64: dts: qcom: sm6350-lena: Enable ADSP, CDSP & MPSS
      arm64: dts: qcom: sm6350-lena: Enable IPA
      arm64: dts: qcom: sm6350-lena: Enable Bluetooth
      arm64: dts: qcom: sm6350-lena: Enable wifi
      arm64: dts: qcom: sm6350-lena: Enable PM7250B
      arm64: dts: qcom: sm6350-lena: Enable PMK8350

 .../dts/qcom/sm6350-sony-xperia-lena-pdx213.dts    | 253 +++++++++++++++++++++
 1 file changed, 253 insertions(+)
---
base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
change-id: 20260829-pdx213-upstream-3-d0b80f749b5b

Best regards,
--  
erebion <erebion@erebion.eu>

