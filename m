Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A1B606A32C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=p47nZ7iM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T/dsjIpw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C3610F163;
	Mon, 16 Nov 2026 13:17:18 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8FD10F151
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC1YU24070885
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mX/bLIK/LBbOqRGK+WPRiY
 e1oCKMmUPphTR2ycXJySw=; b=p47nZ7iMx2ZEdr+qIWmsiuMkUMJAltKW/VTGHs
 HQBF3knKftCCwVEhl9HOpSvB7FbaGU+7fUWUlIgoXMaVa1MI7ZZM1cgujk6LltEj
 MEjfe7qp/AdiSshd2HGn7r7BnyYAdCnTonGE7wi6uTs0bSDnBdPv8HZmUcekEW8W
 vOLZjRHUlfLFlDK7WSpWx1PBIk7/oRhzzbEiporDRtsUoUstTZcKO2BDt7z5UANA
 +2pNdUJ7B7uZYiLGDIrCtUeb6VkFhHU+2nFd01ss4/UCp2AJRxtBSf5Za/0XhAPk
 gJh5eSl3H/FAS+veudhy5li784SMAtTRrltzl+DWGYGSejQg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhmcehm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:17:07 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-94961511b61so446203785a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835026; x=1795439826;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mX/bLIK/LBbOqRGK+WPRiYe1oCKMmUPphTR2ycXJySw=;
 b=T/dsjIpwNYvEskuWD5A2SMukKTrmFc4SSeWl2cLXu9OJerBxFmDNHgODQ3SzBVNnJn
 4Y3wD/Rm/qGzv4he1QU7RQsIR7Q8/RuMzZWy1GUtKfq668Gsj51BJzJvy6mATFcfgc9m
 PUhybmozUcbusYagM35NEoRn39FH4UG/003nH/3vzx+1cRfD3NPFHMHE/MGstYeOkWpk
 8bZwW5F9nDhJHC75GGm+8/DW+KidtgFiDKj/paIh2l2KSAFbPjn7dqu8boBrER2z9ABu
 1mCMEWQgSHtm9UHaJ0PVnQA8u4m0Vz1ravIhDUDtlcp+kSOlbapd+QLmuPy9BFy3JrtT
 YUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835026; x=1795439826;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mX/bLIK/LBbOqRGK+WPRiYe1oCKMmUPphTR2ycXJySw=;
 b=xDlB9zi7lK36+4qx4pMlgHjEvO9w2RFxTtSJf9G22NzPAlO2d11TQo+9Pag4mJa4de
 l3zPyUKsfvDBNDE7Y1MSkr+IQ25+0BS2AQSaC+HA5MYEAOfj2FkcjoUqHKpO1iNtMfCC
 oxySclNGKAFkwzofqOIX/iuUypXeeHmDaBOIsjczSVcwQUGBLQZSFZVK3sRRdIrrPB8H
 ZqsJf0iiJFZfXiwYwuUvmLCE2o1MNzRrRbhUtbBKOAWKtmotMWmTFg/jpF8iOzSI/sU8
 mqIc5p8GI+owZwbgwt9gdbspSNCFOiYr8ac1hcfQGpatws/0tzvjeZAXrS4zXbQxyyVV
 Zhhw==
X-Forwarded-Encrypted: i=1;
 AL+hErG9Fl4X89AMzX56mnltosWXdd3XUl4+dL9v+UwrX2aRiKltdbkNoiAzR4+YSz4PZzVzNUJGHPxEumY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+b6pgRcvGmKuU7jmiNg7TnfAYz5NOB47lmo+XwX/OHxopL4au1
 WC+SzH0lw1I/b2Aa7JpKMej0ibODhnWthVfIpUvgStQ+FvATYAqxc1nNV/VkTfoTrFxgQcYaOYm
 09+Fc1If4fy0eAgv9sGy/dBXD1c2sEZ/2KTVwuHw4wkNlVhjnpI5riZ6xcWSWE2awHTDHl88=
X-Gm-Gg: AYBFou1ABvwZfKByMx7j05jPfkx9doygDw7qPBy0nI4iBF9pIF4lawkiOHnDO50STIt
 o95cARWXLXIfdSAUQPSQShL0sZl5EtTtJl6P64uIQQEyzH1cdFzW1icQeQxphL5TkB2/rDiYTNT
 qZvy91xHYt2Ws83yRQVjj/dQK2Oip/Yhm7bySZvh3Z/ejvQdC/2aVED+jGyWT3cHY+QHMVJDofx
 qzSydh3pkE8vuhoMrt29qh8lN4bpODiFOpo/V/wZdmtiThOrmnKThKb/WkUqA1O/tQQo7uNcld2
 C/FKXhdv3S2m/y5942qvH4YjfGtM0quZjBYANkR8UiRnVvoVcsFgEUWMtschGbym1Nq5nQ4n3eP
 o36iGeiCNLt06MJktodTPUgzo+1kSeb7kvHqJnm0+FJcifBLuKQnCDTqMg+azbQFBtLRvothz8R
 b7
X-Received: by 2002:a05:620a:4111:b0:93f:cbd:8e20 with SMTP id
 af79cd13be357-9494bbeb2cdmr1633082985a.73.1794835025881; 
 Mon, 16 Nov 2026 05:17:05 -0800 (PST)
X-Received: by 2002:a05:620a:4111:b0:93f:cbd:8e20 with SMTP id
 af79cd13be357-9494bbeb2cdmr1633075685a.73.1794835025311; 
 Mon, 16 Nov 2026 05:17:05 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:17:04 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v3 00/11] Add Qualcomm Nord display and eDP PHY support
Date: Mon, 16 Nov 2026 18:46:39 +0530
Message-Id: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcC+2oC/23N0QrCIBQG4FcZXufQs7ZhV71HdOH02IyapZsUY
 ++eLgiC3Rz44T/fP5OA3mIgh2ImHqMN1g0pVLuCqF4OF6RWp0yAQcME53RwXlPtI9Uj1Ux0wE3
 VShQkfTw8GvtatdP5m8PUXVGNmciN3obR+fc6F3nubcuRU0YRasXaShneNUcXQvmc5E25+71Mh
 +SBCD+CMw7/BCRCguyENKLea9gglmX5ABMWLIECAQAA
X-Change-ID: 20260911-nord-drv-dt-d09b21f37ae9
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=4475;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=S8GDL+ZuL9kSueOOYViGlnQ/WIx0vWEkvXhiQqNpogM=;
 b=OIEFjUoskb9ceeeg7IbVVPU3v49Fg1Xl8hofMyd9H3VeVLejaljeM3S4z5OJpRTBrxXyCsYoq
 3JlFoutkMCCDuhYvNvhP2NjntEunPSY+6sS3zQaNOkWfbp0CtQGUHCa
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfXzhKwebx8uDAe
 3gBobr7utwwL+B/6MhB0pSjBUv5utoIb14GhIIioYnhnqIguN7s4EtVpJGhSyFkqd4Fb6ueKunx
 j3qsYR0GD1MeDz5My2vQ2eASc00ZHSA=
X-Proofpoint-ORIG-GUID: k0E29MbghfUk5VW7VH8kRw0MbEi04NMl
X-Proofpoint-GUID: k0E29MbghfUk5VW7VH8kRw0MbEi04NMl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX+oxqph/8ciQH
 nRz4W/7sCiPPeiY5h8hZ7mq7N3zRYCiKuo93wII2dOT6QzwG81PD/ew04pJWjvhhlkudY1gFpbi
 jp4xWr+IyMlQTMUiQM845tkcPfh4+/MXq3BGMH81Zj8xgAO93iq+RAM+SpEXLsi8ym0WKwx90TC
 zT2qEFSu0h6jb7v7WNqOhiTaL4zR4VWp0kYgABRdTA0uZbeztGx5uQ7ER4cgiWo9ENcJphXJFsP
 5x1Q5/6bTh2Tj4N/xAga6j87enwnizWnZjDkMOYQ+7jgECjIvrXTW/opKjq+ykvSVGagmerNrkE
 vT43aTJBkbtE3R/wmc6GsaiFdlDypZYBx9zdDTkoEP7YWX07h4CJbwadLAIm7kZR2WSRzgsoXYv
 KPeNjhIIB3qWpci8nrxWfpwfz6xaIS5Bz3DJ4gIF+d7viNCYcozsdQkyTFHFYrCpYNrVzcBDdGR
 TSJpclSIKMgWmYHXuWA==
X-Authority-Analysis: v=2.4 cv=Vpy2kO2n c=1 sm=1 tr=0 ts=6afb0253 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=QyXUC8HyAAAA:8 a=COk6AnOGAAAA:8
 a=JfrnYn6hAAAA:8 a=e5mUnYsNAAAA:8 a=VLagYuF82rudLD4T15cA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=TjNXssC_j7lpFel5tvFf:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Nord is a Qualcomm SoC with a DP-only display subsystem
(MDSS 12.1 / DPU 1499A) and two independent DP controllers
backed by eDP PHY.  The PHY uses a different register layout,
PLL/SSC coefficients and TX signal parameters compared to
all existing SoCs supported by the qcom-edp driver.

This series enables the display pipeline on Nord by adding
DT bindings for the MDSS, DP controller and eDP PHY, DPU
catalog and driver entries for MDSS and DP, and full eDP
PHY support.

Tested on Nord Ride SX board with one DPU. Both MDSS and
DP controllers probe cleanly and panels render correctly.

---
Changes in v3:
- Used the SA8775p desc table instead of adding new for Nord (Krzysztof)
- Add the bindings for Nord DPU (Krzysztof)
- Split the patch "Add support for DPU 12.1 on Nord" (Dmitry)
- Squash the edp patches into 3 patches. (Dmitry)
- Link to v2: https://patch.msgid.link/20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com

Changes in v2:
- Reduced the PHY patches from 11 to 7. (Dmitry) 
- Removed redundent comments. (Dmitry)
- Addressed review feedback from v1. 
- Link to v1: https://patch.msgid.link/20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>

To: Vinod Koul <vkoul@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Kuogee Hsieh <quic_khsieh@quicinc.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org

---
Mahadevan P (6):
      dt-bindings: phy: qcom,edp-phy: Add DP PHY compatible for Nord
      dt-bindings: display: msm: dp-controller: Document Nord DisplayPort Controller
      dt-bindings: display/msm: Document Nord MDSS
      drm/msm/dpu: Add support for DPU 12.1 on Nord
      drm/msm: mdss: Add support for MDSS on Nord
      drm/msm/dp: Add support for DP controllers on Nord

Nabige Aala (2):
      dt-bindings: display/msm: qcom,sm8650-dpu: Add Qualcomm Nord Soc
      drm/msm/dpu: Fix DSI tear interrupts broken by adding INTF_9 and INTF_10

Ritesh Kumar (3):
      phy: qcom: edp: Generalize power-on path for per-SoC overrides
      phy: qcom: edp: Add Nord-specific QSERDES COM register header
      phy: qcom: edp: Add Nord eDP/DP PHY support

 .../bindings/display/msm/dp-controller.yaml        |   1 +
 .../bindings/display/msm/qcom,nord-mdss.yaml       | 396 +++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   1 +
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h  | 544 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |  20 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   2 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 317 +++++++++++-
 .../qualcomm/phy-qcom-qmp-qserdes-dp-com-v8-nord.h |  51 ++
 15 files changed, 1329 insertions(+), 13 deletions(-)
---
base-commit: 693de981a44b0e7e3b6a73f0b0bcbae9c8d068e6
change-id: 20260911-nord-drv-dt-d09b21f37ae9

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

