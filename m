Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9FAC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 11:13:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F29E10EEFD;
	Wed,  1 Jul 2026 11:13:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HIk+5ig0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A83E10EEE6
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 11:13:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A90Af753610; Wed, 1 Jul 2026 11:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=dhzeSQip8Gjy3p4Lm10/yF
 WnFdFOU+tDXO7CBNq76zo=; b=HIk+5ig0YwzADAhR534s27zEFn4sJ9cZi4PGSd
 apIQt5FUhsgBddBDm+EdZSucB0lxraGbpsG9wZtjI7xxPlfzRISjcuiL9L92aLNd
 ptraL8U0PdVYSxl5+NWOd7/kXWgg+Jky1WeDvd2eI9YL3lENPgb/b0xJhTyhmitL
 t5XCTSW36tpYXftPbPidtN9SAv4RPd1FpRBsz06uKqp7+0ZuKUyJq4u/fVPCY75/
 A1RGCVWXqYK/dqYoniZb0Ay1MgXyq1Rrq9A+h3B2EKnLCapc+arjcUl1EU3dFn06
 7pa+8ZrCD3FeR7aVZDL++mLmmVoXV+BvTTGRjyfC5FUj4S8A==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4rsy2cfy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 11:12:55 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 661BCqWs031719; 
 Wed, 1 Jul 2026 11:12:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4f27kk0333-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 11:12:52 +0000 (GMT)
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 661BCpMM031702;
 Wed, 1 Jul 2026 11:12:51 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-arpisain-hyd.qualcomm.com
 [10.147.248.17])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 661BCp6b031697
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 11:12:51 +0000 (GMT)
Received: from hu-arpisain-hyd.qualcomm.com (localhost [127.0.0.1])
 by hu-devc-hyd-u22-c.qualcomm.com (Postfix) with ESMTP id ACE7F631;
 Wed,  1 Jul 2026 16:42:50 +0530 (+0530)
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Subject: [PATCH v4 0/2] drm/panel: add support for Ilitek ILI7807S DSI panels
Date: Wed, 01 Jul 2026 16:42:48 +0530
Message-Id: <20260701-ili7807s-v4-0-c7d76d4780a5@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADD2RGoC/22NzQ6DIBCEX8VwLgYXf3vqezQ9AGIlUbBgiY3x3
 Qs2TT30ssnszDezIietkg6dkxVZ6ZVTRgeRnxIkeqbvEqs2aAQESlJmBVaDqmpSOTwxLQcUcpw
 5ibllWvQxqeUy408caPQnKzu17BvXW9C9crOxr33SQ/x+2+tfuwdMMKcdERlpeEbgYpxLH082C
 DOOaTgodnl64CE/8DTwbdvRihTAoG7+8Nu2vQHd6jbfAAEAAA==
X-Change-ID: 20260615-ili7807s-panel
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: arpit.saini@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ayushi.makhija@oss.qualcomm.com,
 rajeevny@qti.qualcomm.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782904370; l=2350;
 i=arpit.saini@oss.qualcomm.com; h=from:subject:message-id;
 bh=5FrAyB/XyQAjH/KpqVQfvZUYk852wAlTGT371rCbJQI=;
 b=Vw776Mt+81eIsITAPIuu8eyNmb6W+801G9ZBsK/83NwgtP10Dmam/l0d+5IajvikzwMywfKE7
 Y7gKplkrA/qBfOwn2yq9M0EdxlxwXljhk54B69Fk6MLcCQAHvBMv8Iv
X-Developer-Key: i=arpit.saini@oss.qualcomm.com; a=ed25519;
 pk=OGOh7FGwrnkILHNlcTTABbBMQxxo319duzbTg0YPDAc=
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: 0KsCgq6Q0jIC-7MS-sl1QVrn-dH6buMN
X-Authority-Analysis: v=2.4 cv=fLgJG5ae c=1 sm=1 tr=0 ts=6a44f638 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7NJfoTriyfkdjGHd6h8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExOCBTYWx0ZWRfXyLv+0xsG2nii
 3VWzuht3SOjImwW4aD/R3fElfmbsMJPUcUw1ZGgPmSH0Rz6iK2vhbsb2mT3Brsg2L9N+8zbZ/Sx
 qHYopwlN02nVeCjfF8Z0Bmo1ylFW4NHE6hefFrR7YTTZk01DdpHDneRXtx7PGAN/DluBD0Til8f
 oOk1vGZQkXsz5hRfNJdRb8tfPL0G3njFiwEKv8Nr55lE7VwDVx9eBndMsPs6arXkWZzwsWhwHV6
 EbLGz9V8GNMdnYh9veRbR4h54xiHZHEPc/0Fz7eIL5HQLIUsyQXL6WXCdQ/yUI4p2TdNkJcUUES
 QEjLaTtt5MeJQlnEO2337t9sx3R1yZiqYLuuCJ+oWAoJOgxwV46OSSs8UIuvo44MiQwON/OVHdp
 uJlSonFa7i1lMKiu8T+4tzimAOvbz1FLl8rxl56nf3n7/pIb+m1sMHd0Zt3CRemGsUNIAs5TTcv
 MIbMF/D3XmSg7+TXHSg==
X-Proofpoint-ORIG-GUID: 0KsCgq6Q0jIC-7MS-sl1QVrn-dH6buMN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExOCBTYWx0ZWRfX96JmCICWrt5M
 pDt/hvQGZ3omXUwLMALb/qUUu7UKSSP5NcdpKby3CGdy2Y3jA/GQXaUhQFSOH4wB1b+d4noBsUH
 IQPfRSUosgZLehJYakpmpPUcOqdexRA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010118
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

Add DT bindings and a DRM panel driver for panels based on the Ilitek
ILI7807S display controller. The first supported panel is the DLC
DLC0697 1080x1920@60Hz MIPI DSI panel.

Changes in v4:
- Use active-low reset GPIO semantics: define reset-gpios as active-low
  in DT and use hold=1/drop=0 in the driver (Dmitry Baryshkov)
- Replace raw DCS writes with proper helpers: mipi_dsi_dcs_set_tear_on_multi(),
  MIPI_DCS_SET_CABC_MIN_BRIGHTNESS, MIPI_DCS_WRITE_CONTROL_DISPLAY,
  MIPI_DCS_WRITE_POWER_SAVE (Dmitry Baryshkov)
- Use mipi_dsi_dcs_set_display_brightness_multi() with 0x1fff initial
  brightness (Dmitry Baryshkov)
- Move MIPI_DSI_MODE_LPM to probe(), drop toggling in on()/off()
  (Dmitry Baryshkov)
- Express .clock as arithmetic expression for clarity (Dmitry Baryshkov)
- Update panel physical dimensions width_mm/height_mm (Dmitry Baryshkov)
- Link to v3: https://lore.kernel.org/r/20260624-ili7807s-v3-0-ddf37052a289@oss.qualcomm.com

Changes in v3:
- Return devm_mipi_dsi_attach() directly (Neil Armstrong)
- Link to v2: https://lore.kernel.org/all/20260618-ili7807s-v2-0-b3f0c109b102@oss.qualcomm.com/

Changes in v2:
- Drop MAINTAINERS entry (Dmitry Baryshkov)
- Use devm_drm_panel_add() instead of drm_panel_add() to avoid
  manual drm_panel_remove() in the error path (Dmitry Baryshkov)
- Rework backlight: call drm_panel_of_backlight() first and fall back
  to creating a DCS backlight device if panel->backlight is still NULL
  (Dmitry Baryshkov)
- Remove backlight-en-gpios from the binding (Dmitry Baryshkov)
- Fix mode_flags LPM not restored on backlight update error path
- Link to v1 : https://lore.kernel.org/all/20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com/

---
Arpit Saini (2):
      dt-bindings: display: panel: add Ilitek ILI7807S panel controller
      drm/panel: add Ilitek ILI7807S panel driver

 .../bindings/display/panel/ilitek,ili7807s.yaml    |  71 +++++
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-ilitek-ili7807s.c      | 285 +++++++++++++++++++++
 4 files changed, 369 insertions(+)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260615-ili7807s-panel

Best regards,
-- 
Arpit Saini <arpit.saini@oss.qualcomm.com>

