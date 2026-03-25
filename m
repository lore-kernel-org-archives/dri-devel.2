Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9521B106B50B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E73E310E8A5;
	Wed, 25 Mar 2026 12:17:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RR3IfW4n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KjlOVI75";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF1810E8A6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:16:59 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBG6x22993662
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:16:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OVzaIuHWFCgICrC8E9z9Qn
 bCHnVGjS2giAh9YNd8wbg=; b=RR3IfW4nt+CY5707Qq/eEB46BKn0eNvduv5NL+
 PkK7vpJ17Emm3B/Wc9dlVM4aaoPVUcjDj/K/evvYOx+K1JaFwJ9gBrcT7kxsY82j
 H/sf3j8zUvh0txMZtaezUCUtnB8ZfKWpWijxNfVGAgLGNuLYvgW7wOysY67FkGBz
 2n/Tt7YhF7Jd1UWaqMsJ9Ik2EZ5pxaK+hrH6UYs7+8+zPqUnIdLxG95aQ1U8seYl
 1/sAqgrzhfSiy/dUEh2AJbJvNLQ7Co+9tMcTS2jVIDLYUv1j4GNTBJTD2Uju8crt
 ILN32auwkdGLXLi97wb3IYQT9GdfJUWuPFkEmF5M/HaVKYhw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dy4gc36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:16:58 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-94e9c0edfcfso11902651241.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441018; x=1775045818;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OVzaIuHWFCgICrC8E9z9QnbCHnVGjS2giAh9YNd8wbg=;
 b=KjlOVI75nu9Zq9IJn3OSpPIt9gzbAcgIRgdXe8/RGLzeUWtfKrsIMVX8LISDxqNZZi
 XrmfMjN80f/ZYdoC0fS746xJrfnb9yIImgSnZbasVzQVXvMlpEOlIlDwZKW9aZ3oQuzc
 3noSsdNIcJmzDMnaCMYthzJMR2V5dhfG7tiAi4iqzGYebqpSheYxdw0wm39Qr48E12/g
 vmiZmU6KMq6ak9r7yjS8OPye5gH6hnvHlYSMWhq37XWGrg58CrAOPtnNFgDLlGEkHmL/
 2keG+UvyYEhyx8y1QV+6ucbdadtCuYuNQNYLSCdv8IKHL+UUTCom26O4JpI94LcEzJnC
 Pt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441018; x=1775045818;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OVzaIuHWFCgICrC8E9z9QnbCHnVGjS2giAh9YNd8wbg=;
 b=e4eGrRTtMMOSvuwiXxuFHEeIy8c9JIF7/uwNA6VL4gvk8zf6xpTN5sG0tPKUXnq3vE
 B+bXKM+DZK4AOOGKqpLRKfxXZX40UZ7psqPux8J6pWQXxCRa2tAvD5p2OY6Iy/86KlPD
 8G0dwjxPIGzm55Evf8+F0Ug/cuYeEDkwuRHr+gzO1dHTGirXaplpigClZOECrS7y0yQ1
 4nRqNa/Sqd04Y3Tf6BXJt3ldPbK3lv1ertUXGOQA/kAD5JsbE7bAy1h0yvUhNCq4HAAq
 D+MS0UrXsOxK2R0XlJoOz7L50QEH/k1pbzlaX4/KS7+IPnfiK8NygvyHKh/2FgP9X0es
 gM4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Bn+ot7VgVvHM+wBBBswDHfrZJP8D/Qt7zqqpHg7yhe7GLLwGI/vCnPMN5v605sL7H9ydEIvkV1g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyR06QIL7Lq6vazHisB40BxKSzBf3GuHT/xVi9R5bjOapt6ErVD
 xHF/w/G2jnkF/4pWaymWRBgxKQQ1cDv2lnH2vYrkGt/qt+9hhNrjaK4qopS2scXsRDn8Kq+oG7Y
 FdDp0r+QIdL3Y8Ys3z9dq9brqEX2IWT6fCxA/hZVEhP7uvRVQUAgnAEEA0+fGczJkJqgIpc0=
X-Gm-Gg: ATEYQzxKHzi5Nc3ZmXiRMMSEwMZ+qOf7IgObK8zvv3xYiMR7R0mXKeTm9fNBH9qeimD
 inr7gdLcsn5BXYCb00VESJX/zfTvU/VHJv8ThS7EbHfaWhNuXHx+KYCbvCBGKpw4Fdp6jZCBudL
 Wj3/NP5yiHLnSsQkAtwUXbfbUMD5gx/SfO0golJYVdqf7ngFkjJULrMIjGu6tg1dsvORdxnUCmj
 GNNCo6y9q6HInVGJ5cLh8q3SSkhFQby8oJ7Gi3EKYOzzHaaghbb3WtoHbXZ5C/M59BzkqJtQCEx
 OQ/9d/RBJHUG1pPo6e3OoD95gDTXpkhBlEJFxuMAE7BjZ1UyObfvLDoaxXDNNUZVif0r++gmEWG
 wgI6/T8l0CetIDuQ5/FFfcSkHtgNidHV8jA4xRbN4ztwn
X-Received: by 2002:a05:6102:5694:b0:602:7470:2428 with SMTP id
 ada2fe7eead31-603870bc884mr1638635137.10.1774441017982; 
 Wed, 25 Mar 2026 05:16:57 -0700 (PDT)
X-Received: by 2002:a05:6102:5694:b0:602:7470:2428 with SMTP id
 ada2fe7eead31-603870bc884mr1638619137.10.1774441017566; 
 Wed, 25 Mar 2026 05:16:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:16:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 0/8] drm/msm: Add Qualcomm Eliza SoC support
Date: Wed, 25 Mar 2026 13:16:41 +0100
Message-Id: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACrSw2kC/23NSw6CMBCA4auQri1pp4DoynsYF6UPmQQottqIh
 LtbSExcsJnkn2S+mUkwHk0g52wm3kQM6IYU4pAR1crhbijq1AQYVEwwoNr3VGMYOzlR0+FH0ko
 UVnMlFD8Jku5Gbyy+N/N6S91ieDo/bS8iX7c/TexokVNGa15w4LppoLEXF0L+eMlOub7P0yArG
 uEfKvYgSJCRrDyebAWirHegZVm+ujiX6gIBAAA=
X-Change-ID: 20260302-drm-display-eliza-634fd1c3c193
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=uTGT+HwoXv3r5ZEopikDz0sZtchwtzveYy4ceCEFL6k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9Ivgtj85TYGF809/neI0AN9sHw5BoGn4llqV
 hMIIJQ1UnaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSLwAKCRDBN2bmhouD
 101bD/0QGddyyISd3zfx+N2t3rQhikfcuLeZvwIo2WHhFJCJHQLHENy8ivKO7I/oe4982lZ8A6C
 dJS1a4MO0e174ZCEAVaTACeQBRlXmeic3Qq43tid5xQEU59vzqe1g4l0Go0xzTROjGqM9u7tLdo
 rzSZN8Pi5P6EQPNcXcycef9Rg5FoBhmheuXU9bJVPAnHre6e2fPxGVPTLfWUEBS9/mGrq5LEM+T
 Q8EJmvoReokW+YjddIbbJ0Sq2hIsOtoNiEYVQmW0jNqPsrWDvU0bdmiSquMhpQmtyRCqZ0wKPz+
 SLgSoHdhY6aEuqv33gGbw0ndPWMmSaTUVZQDth+zXA2dWdMUhUXlhkMq4hnmej34C+PFZIP1rXB
 nmMsWoOL61LGKD2/TpkS47Bk1VH2kIYNHlTp27pcMiPXnq/16ewG0jT6aOvdt74tY+2YXW+kVm/
 EKy5rjT0w1Z8oy0SDWCFV3Be3XAORNJq1LwSGCMcRrQl+k44s6qIZHC4/PPlvfBgfD+XGwPI2lJ
 Xv9HT/nJplPEEtwSKIqNvndawRx2xGoOCM/sddyU60w7d2ArHHZOJP5F7tfWkxy02Wmdsbu5J5s
 7RXCqI6S5O/n4EjGlTmNkXqi1QN2JjWWcRrDHKO1c3mb26hmRqN2WeZML/ZJ/vCiDEKULgTrZPA
 F+mdC1Bo/lJbP+Q==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX3eJVJLAXVe2i
 L4grqzIQeUt9U5T1BeAbl22qUZDZttmsHdb8eN5xpM31UDt3wf7V7VT+VOUxBxFnNq6IY7p70Bs
 ZRz9A/QQ3A+7zwbBsVamXABoLtY1jhgec+oxDIWy048TQg1CiFekJB1pSPxqPxIOeG05MFtAZ3C
 9iTe2/nzabfGtPWwa6hUDmfbaCI60t8quo6WmMDPEAcT1lWVbVhX7lKZyV0OVzArAQ2jBxaUISB
 hXDxwaZXfJkCYAaJGSoNQxuhBY5IUFSE58XkZmIZeoUjmaHuM/rGaW4fgw6oBmLs/+2PLxvZY/k
 fFgkvXNUeIbg0EFMUbuH0SLXLSeDbGjRw3dhws1MqmLLJRX+8LDDlaDPEKtE2/KaEZrWyMNIVra
 1AuxU0y9y/p84KI5Dc2v2adZptvIbUzw5h/UFJ6yuk1KfNxX67HtPZePr0gE1BXkv2HMQHjCWxH
 IdgMmcGren6iT8s2LGg==
X-Proofpoint-ORIG-GUID: -bHGv-ieb72k5UsHPtk2umECmJUQahZI
X-Proofpoint-GUID: -bHGv-ieb72k5UsHPtk2umECmJUQahZI
X-Authority-Analysis: v=2.4 cv=eeUwvrEH c=1 sm=1 tr=0 ts=69c3d23a cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=dxrMdQflyC4LrkcXn-kA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Changes in v3:
- Re-order soc/ubwc patch to be last in the series. Maybe it should be
  sent separately?
  Use defines for .ubwc_swizzle value
- Tags
- Link to v2: https://patch.msgid.link/20260304-drm-display-eliza-v2-0-ea0579f62358@oss.qualcomm.com

Changes in v2:
- Add Rb tags.
- Changes after review - changelog per individual patches
- Link to v1: https://patch.msgid.link/20260303-drm-display-eliza-v1-0-814121dbb2bf@oss.qualcomm.com

The MDSS on Eliza SoC is evolution of one in SM8750, with several blocks
removed and added HDMI.

This posting brings working and tested DSI panel, while DP on USB was
not yet tested and HDMI was not prepared.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (8):
      dt-bindings: display/msm: dp-controller: Add Eliza SoC
      dt-bindings: display/msm: dsi-phy-7nm: Add Eliza SoC
      dt-bindings: display/msm: dsi-controller-main: Add Eliza SoC
      dt-bindings: display/msm: qcom,sm8650-dpu: Add Eliza SoC
      dt-bindings: display/msm: qcom,eliza-mdss: Add Eliza SoC
      drm/msm/dpu: Add support for Eliza SoC
      drm/msm/mdss: Add support for Eliza SoC
      soc: qcom: ubwc: Add configuration Eliza SoC

 .../bindings/display/msm/dp-controller.yaml        |   1 +
 .../bindings/display/msm/dsi-controller-main.yaml  |   4 +
 .../bindings/display/msm/dsi-phy-7nm.yaml          |   4 +
 .../bindings/display/msm/qcom,eliza-mdss.yaml      | 494 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h | 365 +++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/soc/qcom/ubwc_config.c                     |  12 +
 11 files changed, 885 insertions(+)
---
base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
change-id: 20260302-drm-display-eliza-634fd1c3c193

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

