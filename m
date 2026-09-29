Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD63CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62CBC10EEA3;
	Tue, 29 Sep 2026 13:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nA3SKqKz";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A8B010EEA3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:12:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCqf0Q1016894; Tue, 29 Sep 2026 13:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ngixdCtZa/UnFUz/HCu2wD
 tyZgGh4uQOy85ome0UScg=; b=nA3SKqKzorjM50aaSoiXR6nkS1LCU1rwSpxhtF
 PF9KJ+g3EQJuCBUqc6EGoX9U5s3qMGwkeanSvXmBkf+1vBcH0P7/l64ameJVhb//
 +ULvjqPDQLNhQg78SN4IIGTEUmNYRFVdxCiiahn12IoYFBuZ9o+yUjXuPMovSmkC
 mrIK5nttWsRXNFRkfv3vhtRM6MaWHM3BoNAMjR4i2GlvQtcECcR6SUSmet7Lzsvj
 cSrBBfA9AplaL4+1d2X+ppfHURsU/uHRM8+HAO9sBIfT90q+aNN2MVv9zLorwHIs
 L3P9O9J6Hb7lI1WsS+Lz/FCYM4+qkkk9zfI7xhJKKAmVArBw==
Received: from apblrppmta01.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxj4m3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 13:12:33 +0000 (GMT)
Received: from pps.filterd (apblrppmta01.qualcomm.com [127.0.0.1])
 by APBLRPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TDCU6b3989974; Tue, 29 Sep 2026 13:12:30 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-arpisain-hyd.qualcomm.com
 [10.147.248.17])
 by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 68TDCUwm3989949
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 29 Sep 2026 13:12:30 +0000 (GMT)
Received: from hu-arpisain-hyd.qualcomm.com (localhost [127.0.0.1])
 by hu-devc-hyd-u22-c.qualcomm.com (Postfix) with ESMTP id 2172461A;
 Tue, 29 Sep 2026 18:42:29 +0530 (+0530)
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Subject: [PATCH 0/2] drm/panel: add WLED supply support
Date: Tue, 29 Sep 2026 18:42:19 +0530
Message-Id: <20260929-wled-supply-series-v1-0-75d0a83b4b00@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADO5u2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyNL3fKc1BTd4tKCgpxKXYhe3VRDgySjZNMUU0MDYyWgxoKi1LTMCrC
 h0bG1tQCRdgSqZAAAAA==
X-Change-ID: 20260929-wled-supply-series-e10b2c5d5103
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Arpit Saini <arpit.saini@oss.qualcomm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 devicetree@vger.kernel.org, rajeevny@qti.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790687549; l=1064;
 i=arpit.saini@oss.qualcomm.com; s=20260929; h=from:subject:message-id;
 bh=zshpyXQs8lkHjLBXBNofXB/G5jJY+iFVjgDe5+VK/EU=;
 b=CbkrFC5ujArOquUsUL+4/+JIA6k8vrNGputTC9WXFL4Jf8mi7S7+ZI/GQd+bgzydtAqMzOk+Y
 ggbQT1ll4lOCzfW5/qPheq7C9ajQosyL9++g7REP7pIe/z0iHR/EcxX
X-Developer-Key: i=arpit.saini@oss.qualcomm.com; a=ed25519;
 pk=hAgg8uNgzV2UIXcMolGFuWsdQLeg5F/siao+So2kbBc=
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfXwC61pYd+K02x
 XO7maCDrOGgYCykmPKJ3cFnEPyMg50d8Ac6341HfO8ZrahLXKCIUcfANtYd5bGArCkcYmMUiO2R
 zfr3Yev+0xVtLlXFWoC9wkr7CE9DN6c=
X-Proofpoint-GUID: B9kS_JF-0810t1lBSiGGNszn5GwLhbuU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA1MiBTYWx0ZWRfXyM4KuCbP2g8w
 k4NIinLBxzYzh33cvhwxINjXZyqzKWUzcKoa9aNpiNY0vnIw2VXTT2Eo2bDzSACRKGPOfmON9Jz
 EF/djq8KCUcQpafjMW0AshS9NrZieP+02xt+Nm2nY5p4Xy4GlECwPSQ6ulk3xfojYxe2RKYF59t
 kVMsG1yhHPDw/XMZ3gi5EiCra2/EqnCXWwgw05JwtGAuVVFM7U5SgMmExlp1V7C1PjmToIhC/dI
 kzuqzP0ui6XfE1CngSLe2bakrDUApOi5HXeNNAn4BpWa+s2Gsrrgxt1tA6QINRskYUuhLgkpNmF
 0VaBY3dRJvcizsWejxsEoQxOw+KCkZ4DlOtp1QIofvDu+wWvNeWmXEzcQcoPLm8lSAForfdItcG
 A/NXe63Bgob2NO1e2v3efV6UY2ZKa0QQqPCzSq/qgL+DNxst+91WbBW3jVEQ/4fqec9fmyra6Op
 UIxFmzRVK4DtA7qINmQ==
X-Proofpoint-ORIG-GUID: B9kS_JF-0810t1lBSiGGNszn5GwLhbuU
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abbb941 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=b6sxjRZ3zF5b7u068BwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290052
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

This is a follow-up to the applied ILI7807S panel support series.

Link: https://lore.kernel.org/all/20260701-ili7807s-v4-0-c7d76d4780a5@oss.qualcomm.com/

Some boards, such as the Qualcomm Shikra CQS EVK and Shikra CQM EVK,
drive the panel's backlight from an external WLED driver whose enable
input is wired through a supply, typically modeled as a fixed
regulator (e.g. vreg_wled).

Platforms without this hardware may omit wled-supply and
use the existing DCS or external backlight handling.

Signed-off-by: Arpit Saini <arpit.saini@oss.qualcomm.com>
---
Arpit Saini (2):
      dt-bindings: display: panel: add optional wled-supply
      drm/panel: ili7807s: Add WLED supply

 .../devicetree/bindings/display/panel/ilitek,ili7807s.yaml   | 12 ++++++++++++
 drivers/gpu/drm/panel/panel-ilitek-ili7807s.c                |  1 +
 2 files changed, 13 insertions(+)
---
base-commit: 6375e61c01e93e35ee7acd336a689ac1fae4b509
change-id: 20260929-wled-supply-series-e10b2c5d5103

Best regards,
-- 
Arpit Saini <arpit.saini@oss.qualcomm.com>

