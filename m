Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90CDCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E61E48984C;
	Thu, 18 Jun 2026 10:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OYDueIkl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60678984C
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:24:15 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8DsrR2246964; Thu, 18 Jun 2026 10:24:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=KbQFWLDzPNY/bLt7TD70Of
 B5YanHBASADz17mg63nIc=; b=OYDueIklt3C8FEShOFO2Aj2rP5yLiimqh62VzY
 CUJDyIvfd5u6b6TPpeWGocQA4/ZtNSit5IrHlXb3VLHktcblv3tAGDPyKNdKC+Z9
 0//SL95tw+pbSk6gy+GmK4MpUTRHv5Bda4J/uIS7+5OXKRlXpd8xYQ5ZtM8iKYZP
 NPoU3ensfxPNu/okJx5W1e52wHqcZ8xI4deaOp+FwjiYP9V9yNL37gGkTf3P8C0H
 KOuwIYel2Y29qDGJ8MR1v6Fq7qZtVEjzUtG4a6ELfY/CWeTxMlhqeO3rL2PlKIuP
 KmryjgGPdOWVGI9JKIXiJ4CTjyw2rXIUgf5YHDOscJhD/h4Q==
Received: from apblrppmta02.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmeqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 10:24:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IAO7jx008713; 
 Thu, 18 Jun 2026 10:24:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4es09kqmr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 10:24:07 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65IAO722008699;
 Thu, 18 Jun 2026 10:24:07 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-arpisain-hyd.qualcomm.com
 [10.147.248.17])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 65IAO758008693
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 18 Jun 2026 10:24:07 +0000 (GMT)
Received: from hu-arpisain-hyd.qualcomm.com (localhost [127.0.0.1])
 by hu-devc-hyd-u22-c.qualcomm.com (Postfix) with ESMTP id 43EA9624;
 Thu, 18 Jun 2026 15:54:06 +0530 (+0530)
From: Arpit Saini <arpit.saini@oss.qualcomm.com>
Subject: [PATCH v2 0/2] drm/panel: add support for Ilitek ILI7807S DSI panels
Date: Thu, 18 Jun 2026 15:54:01 +0530
Message-Id: <20260618-ili7807s-v2-0-b3f0c109b102@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHHM2oC/y3N0QpAQBCF4VfRXJtaW6y8ilwshp3S0I6k5N0tu
 fw7X50LlCKTQpNdEOlg5VVS2DyDIXiZCXlMDdbYylRFibywq41T3LzQAsn1Xgn76GUIrxQ6d/y
 5efct0sTn99F29/0AS3Sno3MAAAA=
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
 rajeevny@qti.qualcomm.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781778246; l=1389;
 i=arpit.saini@oss.qualcomm.com; h=from:subject:message-id;
 bh=2a5LA1O/vX1Gsmtn9/ND66QoGQzBUzdK5kvXpjQDPFw=;
 b=TPXo9l65S5nlxwZPjaOeL5phGAO74rL7Ww46mJkus8oZjUO2BZ2CatYul7Svx56TRXUPQwYbk
 VY5u4mcn+ynBzlYTF2c0TjTXS+QX91vXFYJJcnDj577TeN5rL2G8cG3
X-Developer-Key: i=arpit.saini@oss.qualcomm.com; a=ed25519;
 pk=OGOh7FGwrnkILHNlcTTABbBMQxxo319duzbTg0YPDAc=
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: wSc5lzGEI9n9ozoVrMnkQ2hcZwZDEYfG
X-Proofpoint-GUID: wSc5lzGEI9n9ozoVrMnkQ2hcZwZDEYfG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfX8wKL6zzmeL8H
 RY0bleNp6ZCt7UIIaX6f8jBqLywhmlzOTqn3MtYl7tuUhReLbHe5kEfN/28Za+YjE1Ep/Fo+9Wj
 XZlQSCCJiRl/yrfFhqzFZ4Vc80Qjh/2jAALeK6GGl+J4vL/KwsYzuoh2sogzTkr6RflF32MM7+G
 H9o0abiMOgq0taJiGapBWm9Fabw7cIubzuz1uBXjE+xzXMIgEHaiKJCLL52T0but7NfavnGL6vj
 imksFAXKDoGcthxVFikaiZaSrNR3YlAS4UIov4SDz/IitnN6GbYasDSwj3+tdzBfkgRCkOXkAsJ
 xyEVpBsMBrcytChYqEdcwOef6NEY7hQF93kqChzz0CKdy7g40T2B+qOexxsS6obd0Ii4nlOg7kz
 QLiXhzOAFx7ZRmGxCFhnylUyckVmLmRsC8n61edaZXYcCbhtd52riSM7J2wI213XtU1pLVWKejX
 uTyM1oN3BaR4FlpDn2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5NiBTYWx0ZWRfX/+q1aAKY4oHR
 6MaYcPhpdG3xTqxiX+/+RZ0IYjkStliCNHRgIMNzcMyyH8KMCZkXCyOf9b9RbNaairw9bVv+wAe
 CJzlIM+evKxHVotloGHLcIxBiOKolVA=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33c74b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RCrcYMzkqC15-5_egV8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180096
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
 drivers/gpu/drm/panel/panel-ilitek-ili7807s.c      | 297 +++++++++++++++++++++
 4 files changed, 381 insertions(+)
---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260615-ili7807s-panel

Best regards,
-- 
Arpit Saini <arpit.saini@oss.qualcomm.com>

