Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083BACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 09:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A2B10EB7E;
	Thu, 15 Oct 2026 09:55:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF0B510EB7E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:09 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jgSC1955865
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=wgs9PkeAUCVHu6qTEMPUP7
 TY/qohNgRhvSmy425EbjM=; b=NqREwGdd6LFHD74BMvYvseWlCS4jWexu4hBuNh
 F+RK1AeNImU7NpbN0fbAYnjNqr0WDK9a792iBb6ayxgyhmyS1UZmeRcyd1gQCnzZ
 KN8y23wULaDNwYb53qgSntmk0R9Wd/9QES9iIylqZGLdnRk3yWMvl3bBSz9Rygap
 9g9dOCaEocyyh23QfY/5QMxtwxM15bxzyAdAVU1q8uqJwgwT3EsFvqg4Xo1bsGYZ
 9/YzvhIAPdXXLIPPaAFxq4mNmwd6h+C5ys3vwZWLo9FUICMTD390WF+1C2e0hj3T
 xH8nk82qPaeQzdusA7P8yZMadpJt0tMFxx7Ihd3QA535MIEg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hakdet80a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 09:55:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso1087309a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792058108; x=1792662908;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wgs9PkeAUCVHu6qTEMPUP7TY/qohNgRhvSmy425EbjM=;
 b=hm3R7kRv6RsyfgSPDTL7DXAQiCjxMiRUiqa/TcmlW1b4y79fiKIfGpiR3ivGmkW8XF
 mSEIydSaNJPYgks6pgW79q1f7lLPYv7lHXhjKSZ6l903V/Bqt2KC1q6H6xqLr7xzspAF
 hmv2qlqqGqnGcHDeCjk0ECnyimu8Q5pUGQrM6iZ0WHB8Mmgv0BVJVLPtfgQxz2+ex1lt
 Tf1z6MLPZzGlsA0+R/oKrifrTcANHW3xE6LGK6wBe6PvCOTTuX9HhzjlDvhIEw/CPLh8
 PY+5foxbTMAocrEHWxXrRGTmZNpE+4Bd6+HoXfI39U8+vq5TRFObIkm26HKvN3JqxD7X
 Sihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792058108; x=1792662908;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=wgs9PkeAUCVHu6qTEMPUP7TY/qohNgRhvSmy425EbjM=;
 b=UWIzb5K+qb/NtgaGJQNk+v7VN3M1h06O1efH1yLiw4E0jZBU5Nt1K2JTC73Zaix11U
 7srQzZc/Xhb0mxKo5TjY2lpJe7mHlW3HAd7OTnu9+7KWHwkTuUqaWmeivSMfe4QKtWUr
 Ue8w5WZtSRNNcUIGbT8Qmg1shgBEtABjwulX9R5XsaN/vJM0IriUgJy0ffNkJHg+rbHv
 O9A5Do3IN52XoF745itQ7V4d0kZDwzwT5fVTqgasAEwlMsyDzc3LkLmt4tNnSxDqS/zX
 sY7CX0zWdhHPys796qOxXjt8JoaFPaTK+6dNHSnqhvKOxTM8aZPT0Q56vDuHuW1XwL4L
 9d4A==
X-Forwarded-Encrypted: i=1;
 AKwUvByBfnbB17BiXbm0J1SpsIzEqapQc9AWkc/QpzcDha1z1PvU0Hujqb7tNFgKF3Fm/EK9/W8WL+nZY8k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJ2PYisIvZkW+gSTQ54P/ho8KPdI8Db3n++PAkfLcq8FaL67RNl
 LLG2Lneg9ysCiuu6f3Yj44BU7xw1NL36izWBQG5OD0IAG9xBHad+3BK+sc5htBzTQ0GJ4g3c0sG
 BInCx+cC8ITRAJmzHijrIw6LVHp6luVfSDP3Ap4WedHAS/xargp3a+47uzmv8xVoQJYILfbM=
X-Gm-Gg: AYBFou3CPMsfrudg/THK6l34p1+Qj8Vnbm578T9NeJn85+tWSJN4vEhoEOj3S3bVl5h
 I4otQAlAjLAzaRCRrMsfFQ9h2hJkE6jWao2hmHHZD8renn2JiiUPxrGAEKbH+MrrFR8Fgi6M1Z1
 iSBR/fuCQlPUEG82hf/9tBFsFKhLyJkRtAaj7kkz8I5qHbo0gLi0B1hVcYSosgACroLKqD56lfF
 qjuhDUXVjQ3gWa+m27P+mNAVDIkfrITjL9kgyXP/gcqtgL8DjBLrn2tQM613/hEjx0T0g0fRObH
 rYOG4rxbRg1M3/pdP0kiu5/TIzNQsvir28DsJZUKqB35jOSaVOdUqtgx/hd9fkBAgFaRRRkdXV6
 SRJ15dyxeTiGcEDRZM/Ec9MclcvD4iO7jacXE
X-Received: by 2002:a17:90b:5808:b0:3ac:ad90:7090 with SMTP id
 98e67ed59e1d1-3acad9083b9mr288495a91.67.1792058107831; 
 Thu, 15 Oct 2026 02:55:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5808:b0:3ac:ad90:7090 with SMTP id
 98e67ed59e1d1-3acad9083b9mr288453a91.67.1792058107309; 
 Thu, 15 Oct 2026 02:55:07 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac943e1a11sm3612322a91.7.2026.10.15.02.54.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:55:06 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Subject: [PATCH v2 0/5] arm64: dts: qcom: kaanapali: Enable DisplayPort
Date: Thu, 15 Oct 2026 15:24:31 +0530
Message-Id: <20261015-kaanapali_dp-v2-0-c15cb83d9140@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANei0GoC/3WNQQ6CMBREr0K6tqSFUMWV9zDEfNpf+QoUWyAaw
 t0tuHYzyUtm3iwsoCcM7JwszONMgVwfITskTDfQ35GTicwykSkpRMGfAD0M0NLNDNwqo055ecy
 lrVmcDB4tvXfdtfpxmOoH6nFzbI2Gwuj8Z/+b5db7o54lF1xZQNA5KFOUFxdC+pqg1a7r0hisW
 tf1CyZxuFrBAAAA
X-Change-ID: 20261005-kaanapali_dp-f6d6839731fb
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792058098; l=2745;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=3tFIsNi2qTsciuHRU9xAr1KThSqBV8jDMANac62yexk=;
 b=fMPWe1BtK5sccBTp5Tk+RwP/XV52EvBj/roQz8Jii3yWxqIjFdbckyTTxQP5JctTTGg5ij6ch
 FvwwZTfr+OcCSr+L0/Ba/A/hO33kXzzUyXdWvDeoHNFOepjuog4Vb6Y
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Authority-Analysis: v=2.4 cv=OdENnRTY c=1 sm=1 tr=0 ts=6ad0a2fc cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=dO7UQkY1snIeAx-3qiEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: Y006np-veJzW22PdA0Hu7fRk-Pr9FOZ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfXwD897RpFi8cO
 jXZOHZetaZs6jdo4UXWYKoM9Wu1UPv2nCdEXLYlUjOez+Oh/kSQvLq5jW19O0Jg7O4ihKqMWbFR
 QXKXURJe0D3Ow4HHzWVlaAD0QLqN+7uiQCpiY1YjEXNl9KZUUeUGps8Kf8xfdLoMgPc1laHauBc
 g4UgP0MZdxGV5o3w/8qW0HVgdVoYoC3w/WY8qndUgVOR55h8diXA/VYZnUakfE8VFhUNb0Ng2hC
 oPMUhAdk3RIqp50C+xp+j6DF5nRwxOdfQupB1nkdPwP348O1nESIXtrsw2Of2VJiOHkx3LueqkW
 MQ2+oNkJZNjZeWmtvObTOgin4EyeeH+CfeEEt7j+nAvTNBd0Jr02Hpay9tF0gz/7mkzRqzoUQyA
 03/NwoY4KP6jGdCRuBh+G/sHp/sm8OlyhnUX0/apyyGE6S6R8aHuEOm6rmSKtG41HR5Z6AuFhPt
 RKoL8f0ALsMr16vErNQ==
X-Proofpoint-GUID: Y006np-veJzW22PdA0Hu7fRk-Pr9FOZ6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzOSBTYWx0ZWRfX1Wpkkwlmf41a
 buVtSGEp0IKrjEKUgIS2pb/rHUGElKV2mBtP1GSDmW49TBmvf8Sy252hqCLdbauvb76R2ev/XEP
 nqu2KDSO34xb/x3YPlCkd0XvsLbmu9Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150039
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

This series adds DisplayPort support for the Qualcomm Kaanapali SoC
and enables it on the MTP board.

Kaanapali has a single DisplayPort controller based on the SM8750
generation DP block, routed through the combo USB/DP QMP PHY. The
series:

 - Documents the new "qcom,kaanapali-dp" compatible in the DP controller
   and Kaanapali MDSS bindings.
 - Adds the Kaanapali descriptor to the DP driver.
 - Describes the DisplayPort controller node in kaanapali.dtsi, including
   its OPP table, clocks, and power domain, and wires it to the DPU and
   the USB/DP QMP PHY.
 - Enables USB-C audio support on the MTP board (WCD939x USBSS Type-C mux)
   as a prerequisite for exercising DP alt mode over the same Type-C port.
 - Enables the DisplayPort controller on MTP and advertises the supported
   link frequencies for DisplayPort over USB-C.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
Changes in v2:
- Updated the DP controller binding patch subject from "Add Kaanapali" to
  "Document Kaanapali" and rewrote its commit message to describe the
  standalone compatible and SoC-specific resource counts (Sashiko AI).
- Updated the Kaanapali DP node to use the MMCX power domain (Dmitry,
  Sashiko AI).
- Added the missing second DP stream support in the Kaanapali DP node
  (Dmitry).
- Expanded the Kaanapali DP node commit message to document USB/DP PHY
  mode switching for DisplayPort altmode (Dmitry).
- Extended the MTP USB headset and Type-C commit message to document the
  WCD9395 USBSS mux I2C bus frequency of 100 kHz (Dmitry, Konrad,
  Mukesh).
- Removed an unnecessary line break from the DP node clock parent list
  (Dmitry).
- Link to v1: https://patch.msgid.link/20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com

---
Balaji Kalkonda (5):
      dt-bindings: display/msm: dp-controller: Document Kaanapali
      drm/msm/dp: Add DisplayPort controller for Kaanapali
      arm64: dts: qcom: kaanapali: Add DisplayPort controller
      arm64: dts: qcom: kaanapali-mtp: Enable USB headset and Type-C accessory mode
      arm64: dts: qcom: kaanapali-mtp: Enable DisplayPort over USB

 .../bindings/display/msm/dp-controller.yaml        | 19 +++++
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  6 ++
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts         | 61 +++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 91 +++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_display.c                |  6 ++
 5 files changed, 181 insertions(+), 2 deletions(-)
---
base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
change-id: 20261005-kaanapali_dp-f6d6839731fb

Best regards,
--  
Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>

