Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A27CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5F9310E5A9;
	Mon, 12 Oct 2026 13:32:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5601910E59E
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:39 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CBxuPr1404987
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Dx+5DlXOJvegtnA3Kmrrw1
 qJ6BKbC1jFDAUZNCC1dnQ=; b=Ov+Y1iLztTChqp6fYm9U0PUNsYfH79Vdf9GBmP
 vHXgqOtIkmspbWEYwT2xPOfM7ly4OBz2/35RY0mAXr9S5EUKQg/NifPXBpFuuE7d
 PIBC4NLx5hfAfPqtAVIU8pSBjxcl+h1N/VCIh7+MPFwAbDRSSyUp+uBsG64fSVu/
 VLCJB2qFAjicF4h7bASglNABMZm2PT6khALwJM13Gmagv120qnbg7glMac0Oop58
 Kn573MWky0RIqzHMMcEnw1o7SoefmqmlnYJq0D1k9W+HYQBMuqShtIgMRvbfjzzq
 8xO168vqvdqc92DiXBBV8rNRS7EMPwXdEvkxc+x2Ztl1wnsQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8v7ks9th-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:32:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-359d11365bfso3670072eec.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791811958; x=1792416758;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dx+5DlXOJvegtnA3Kmrrw1qJ6BKbC1jFDAUZNCC1dnQ=;
 b=iR9lS4+p+XMozjXf66CFjzxfQyKdCUB5Lt6AD1Yl5dQs13R/dmmF+4nskk8HS4wRot
 CsNDJalsm7Y0wSofk+MEcB/RWf7UKlKc3JHAdxCyb1494sV2JqwQlGx7okv4u56rQupH
 RCFGCOY4BjjumJtVJJ3dOEtg2r7MWs0X1eV7XLWgn+6d9rbOuGzNk5Np0OzzPEbpGU/M
 ZtEP2iHy+8V+IAF4rLeOhTqRS+bu7poEg8FlHczL6fNE3iho9VkHnWSiRrXbjoCBXHnK
 eed/u33zLw6T+0PC7/z+Hytzol4SlRr5QIk/4N+sXaKKQCtv3PQ+7oSJ2hHN5SoGmNZG
 lU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791811958; x=1792416758;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Dx+5DlXOJvegtnA3Kmrrw1qJ6BKbC1jFDAUZNCC1dnQ=;
 b=sxZRWFVwIbianwE9/wNt/cOMTmApa6a2VoIVlvxsvB0/BMi4QB7Ci1AZ9R6KC47CS6
 CP3kP2YUCr50BwGm7kuemRvw3A1/YX+Og0TVdfM4CDroWa++f086sfowsyEnWTuIyHmJ
 KqZpKSxce7Z+Bkc+mmCGxnAeOJdZesoS0g1cquGlRNb5m966uKLjo/Qz3Xz4qAN7Wk8z
 2GeOenAgrts9SDH5hWTgnAWDJj88w0kAOwAwpA5CfLPDl7nWSIOPuDJxNXex4J4ow57w
 8q3n1uDAiScolleLSBnDtsoPJJsFMDTXggg1lxpvlVBHgGe94fIfdogSh1oOKbky8qXB
 KRwA==
X-Forwarded-Encrypted: i=1;
 AKwUvByiIV/EYwVIxPPHhykaBKjYfhBgxWwDSqsjtOnwbAh17Uh08HRDeqFsM9+/0NQmQ8CN0NA1wCyNplA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLIH9TXNc8tnr9tpSII6QOy1/Fwolp69OD3jo4Up6JZ+csZFN3d
 KBshVbj+KIdPK7rVG1x1YpvszuG5prRJ/hSUUNSyY2z6I5egCKY1dxn7uzkeIW7cJ0PH48LSHcS
 IMJ1pG5qTKmthhNm/ExRiyFcT5DIUyECH6H1Fy+zwJBgqU6ag0u74vCdmZoPvaKdxMDrc0n7qUh
 IYmes=
X-Gm-Gg: AYBFou3rTHcy6ncjDWMBbMGl3CZXieIgGuah19UMgjcWFGRqyD334XpmbkQk1KSBmgR
 AobNN2P42vR+ovYmmrD7lZNl3vSB7hBtxD875d2BX79vO3igAGNVBWczvv19ngqb75RReV/XVqt
 T44ej3UO51Da4fsq3ePUsf1rufYIfYl2OIqILSDlr5YyBBQAq2PpTqiIeROUwb3WKVM2Uv+q6NT
 16G7z0s0wTiSG4jGZ7YAUMbt/Ekwhd/Q9tyILqgHPKF2K2MO8THa/0gzgCBIMubppTckPBBr54a
 U9rpqf5PnKe/OH0fqIxiW8nEDoLjH6/vJpM+NcH0J6VM5jDJnHLEgqvmJG21pGMENoX/X0FuWQ4
 aPR1Cs5VvmXaYkbHbZIPDuWzLQOo=
X-Received: by 2002:a05:7300:b293:b0:351:207d:bff4 with SMTP id
 5a478bee46e88-3537deccb0fmr13597432eec.4.1791811957919; 
 Mon, 12 Oct 2026 06:32:37 -0700 (PDT)
X-Received: by 2002:a05:7300:b293:b0:351:207d:bff4 with SMTP id
 5a478bee46e88-3537deccb0fmr13597378eec.4.1791811957167; 
 Mon, 12 Oct 2026 06:32:37 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.32.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:32:36 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v2 00/13] Add Qualcomm Nord display and eDP PHY support
Date: Mon, 12 Oct 2026 19:02:10 +0530
Message-Id: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFrhzGoC/22NwQ6CMBBEf4Xs2SVtiRA8+R+GQ2kXqRGKXWg0h
 H+34NXLJC+ZebMCU3DEcMlWCBQdOz8mUKcMTK/HO6GziUEJVYpaShx9sGhDRDujFXWrZFdUmmp
 IiylQ596H7db8mJf2QWbeFXujdzz78Dnuotx7/81RokBSZyOqwnSyLa+eOX8t+mn8MOQpoNm27
 QuzrMGivwAAAA==
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
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=4153;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=Oy2vFMavUsEa6xHikhMkIegRjj0JnZoJtqReLysfrm4=;
 b=D644PHpCjLdH/Dj6FjK44RlieTC6bfNL+J9F14dTxmv5/r02jogvN+83PcZOABhzJnUGF3F5g
 RPKi+C+4P6kBCEpWO68BDBq27CWTvFv8eWz0yLs+7RcC6h6Lo9qWBNO
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX/Mi1RfuncTRc
 Wjh5y5hxMYpZ2Aj94YInCuNNT98krTQA1LtcKkIEydVaXIjS551v4by0MDfAnvLERLE6T8vK9m9
 KPLUFnsDCvcgBApvCinzAIauOmzajyQ/chogmh6AY3ZejAymzj54K6Wa841XNuyx00kNOsgHA9g
 tJPevZKvK4tLBo3Jnh9IpRiXPD9DFq7A2v31gX9oKL3oCJpoX+vuhmv5+6N4XKGZYlODGN3tjNH
 AnYRpbvD2kbEO8GETgyLfQGAQEvrs+Itrg5cBeCWlKMq4Dnoft3CyrdYMa2vAR2TnPkq57w+Z2i
 AOtjYpZxlnS/9b+bbCvRiAl+6QaEUTvtpDdJL+ARZDE2JIsigpcG0RVoqOvxqk85cOec38WFS16
 xCWwCZB70mA9k9bCgQhKnxyRKXFCR7v2+eyCqkbA3w55zWOrhQ6KsbsnIGGhmCXmSKqm/lL3RFk
 CTDuyNJM0EenuNF+qaQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXw60i8kCXCyTo
 FXn7o+n6fdhdxEBWrHza3mjeHXfp9yH+rBaeYbu6qzCiUcVpckEb/nWtjiqumQbeqUgYfn1u3l4
 n8ZWUeREFcFJjQ1Yuivvy0xpsJa14Ag=
X-Authority-Analysis: v=2.4 cv=VOtIDNPX c=1 sm=1 tr=0 ts=6acce176 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=QyXUC8HyAAAA:8 a=COk6AnOGAAAA:8
 a=JfrnYn6hAAAA:8 a=e5mUnYsNAAAA:8 a=VLagYuF82rudLD4T15cA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=-BPWgnxRz2uhmvdm1NTO:22 a=TjNXssC_j7lpFel5tvFf:22 a=1CNFftbPRP8L7MoqJWF3:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: XGTavw2H6ro8oQliFoxjblbWRq60kt4F
X-Proofpoint-ORIG-GUID: XGTavw2H6ro8oQliFoxjblbWRq60kt4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120053
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

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Changes in v2:
- Reduced the PHY patches from 11 to 7. (Dmitry) 
- Removed redundent comments. (Dmitry)
- Addressed review feedback from v1. 
- Link to v1: https://patch.msgid.link/20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com

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
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-phy@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org

---
Mahadevan P (6):
      dt-bindings: phy: qcom,edp-phy: Add DP PHY compatible for Nord
      dt-bindings: display: msm: Document the Nord DiplayPort controller
      dt-bindings: display/msm: Document Nord MDSS
      drm/msm/dpu: Add support for DPU 12.1 on Nord
      drm/msm: mdss: Add support for MDSS on Nord
      drm/msm/dp: Add support for DP controllers on Nord

Ritesh Kumar (7):
      phy: qcom: edp: Add Nord-specific register offsets
      phy: qcom: edp: Generalize power-on path for per-SoC overrides
      phy: qcom: edp: Add Nord voltage-swing and pre-emphasis tables
      phy: qcom: edp: Add Nord spread-spectrum clocking configuration callback
      phy: qcom: edp: Add Nord PLL configuration callback
      phy: qcom: edp: Add Nord PHY configuration data tables
      phy: qcom: edp: Add Nord phy_cfg, ops and OF compatible

 .../bindings/display/msm/dp-controller.yaml        |   3 +
 .../bindings/display/msm/qcom,nord-mdss.yaml       | 396 +++++++++++++++
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   2 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h  | 544 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |  20 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   9 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 350 ++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h  |   3 +
 14 files changed, 1319 insertions(+), 16 deletions(-)
---
base-commit: 693de981a44b0e7e3b6a73f0b0bcbae9c8d068e6
change-id: 20260911-nord-drv-dt-d09b21f37ae9

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

