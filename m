Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 593CECC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B420210F7B1;
	Wed, 14 Oct 2026 16:19:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4977010F7B1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:26 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbN0w3643036
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=WLJdnOu7zalmLPYlOcnVTI
 +JOF39KQbZ+zn1YXHnHCs=; b=AunjBc7uMMq8tgxtSwxU144uc4pMa2fafLl2p2
 QoheRVaumtjh33CGvylRWezd/zUUTLxe1MlwA5LSKbk8R+Pv9jznwD4nCjQjz8v3
 h4Sidfx3ddfdW8qktcX7WeqxYftx48IjgXxBbSLU2Z2Z++OMJXxgTO1zlCivWVQ9
 frPceb7tRQtDcsPCSrC1PvyTp9AMbFtqnNRmeixxh2EECqxPBJrufAHT6Doz59RR
 RegN9B9TOkKlglSNR77P5HVVgzK57fq9nlc8fXIQ6yT7IkPxLlshiuXtvz1fOWLO
 VgjyFURJ8aDY+xECDzkAnWKLtxRKgH0Yg8oDD6Q2eP47YntQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha470aetv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:19:24 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93dea1b6c89so819477085a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791994764; x=1792599564;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WLJdnOu7zalmLPYlOcnVTI+JOF39KQbZ+zn1YXHnHCs=;
 b=i2DPZkWHrUFpp5sgEut7R3nT9G6dxeOx+BcP/ewlk3pI5WD3JbNXk+hbVCx9oQRDXg
 zhzo/o9QfR9TprXXRrkCTge7hbVyZ90sxjDYtmqgtk97lOHN/eeWy/eXxOoci/xZWQGT
 ikj+OrwoA+ikMFhbabWUcU4oO7PMi1qFYzQITnB+ivQVcRxC8hrpBw440AISPyA8ZzfK
 S8eyv358Zg+uObFcQ4kzJBjwZTmFbxOCMGl9LfYHH85TesZPduyhok6JLmmEwLk6Xsq1
 1m2RVHnHNTz9HIGlA+LfIn8mItM9I3l2FdZFKGSWLAJ8mqFWbsikIzdBEi3MLGVf8VEk
 TS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994764; x=1792599564;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=WLJdnOu7zalmLPYlOcnVTI+JOF39KQbZ+zn1YXHnHCs=;
 b=qvy0Y5diomlhaNJNZHYOuNlrb+7fN4vH+LzWUeMXrapTMSjM6VjPqqNTKaaaZ4BniV
 KPLzfM8BQJRTqc/XsSlDu9KrysNMBLWqLtP7ZkyLBm2z+hxftbtM4UEB1UfyongS8MYn
 CszpOyrwLCWin2lGuNd6hGo/Go5HNGHr9klIcAfSL6VkY2Fmd/YfN4U+dDYP5ChRIueJ
 v6mgnElVKJ358orY6zzNTEmV/kMz/9/qFr/EajI0brfcEanl6vy6xEfsUjF7fzvnnNpy
 Hct3KTS82o4S7PKNDeViS6qtuqtl4mJ/LaaPXsQoieqj25m7ZvUEFZrrrck6n9afjgDJ
 s74w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAgXNvzbWAEOOsDi7NL9oCQ50Oi72+4eZdYFv+3KbWi5rgAGkPntJd1ewDcdn0h0WxTDFYvXeqa9Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKc75K14SHN6KX735A86kj6U7W7nDr+LC6BR0bCCLfbj2Vnj1X2
 URpeb+PrBBFnCVpzq2nl/UTGs3oasvvGjA5iKJhWsQ2zzmSAQxF84o5UWOQuGbw/uCRo5pNQUSR
 p2EDKkhj2NFdJpOVeTkP5knRim2Rmvb3i8fm4jdN7hj2CIKITDfGsvzQ0c14ZMYlz+pu5LpY=
X-Gm-Gg: AYBFou1UcnLPmptya/eYMh5V7soEWtRbT/R8Kj4iK67JkosR256GW+DE8xtdwvB25Pi
 l5CN1I/H3AaO01Qo25DsniL8zkS7Wct8/Mq365FTjcCyahKadqZ2ylfdQB4yp3PIClD+Xe7c51I
 1MKb8o8QUiRI/vCpHk8iWhzY0+pWKfTo4hw11FqejAAruYuG0EkVlaBdb+vAnDrhcBuSLyvgHJG
 /h6Wp2cmG5ClHMY7MAlHn+yXeravAhORq9zMxx8/U3her61QAsc8f3Bv5KNX8oe/NmC0RxMo26y
 MBiCejNbOszO86o4hYOi3gBfOOzynE0NvORg4AxzUXlE/dSzraM2iYka7J3L0J8A9uta5veWZQl
 w3f3prY8t/fHf2acqWDQckcsP8aA3Ob/xja/PMTC/Z9SU+tM8SRbVtk4z782gS016pun2CVdOzh
 Nzq2ys3w4yWnkd
X-Received: by 2002:a05:620a:1789:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93ebd233be3mr2728370285a.43.1791994764212; 
 Wed, 14 Oct 2026 09:19:24 -0700 (PDT)
X-Received: by 2002:a05:620a:1789:b0:937:5ab5:53f7 with SMTP id
 af79cd13be357-93ebd233be3mr2728364485a.43.1791994763716; 
 Wed, 14 Oct 2026 09:19:23 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d7d0f6sm740187e87.38.2026.10.14.09.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:19:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/5] arm64: dts: qcom: support SDM845 HDK
Date: Wed, 14 Oct 2026 19:19:15 +0300
Message-Id: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOrz2oC/03MQQ6CMBCF4auQWVvSjnQAV97DsCCltY1CtaNEQ
 7i7FTduJvkned8CbFOwDIdigWTnwCFOOXBXgPH9dLYiDLkBJZJUiIKHsam08MNFtBWR3ktTIdW
 QB7dkXXht2KnL7QM/Ynpv9qy+3x+Dqv5nZiWkaIicakk76+pjZC7vz/5q4jiW+UC3rusHLitGb
 KsAAAA=
X-Change-ID: 20260122-sdm845-hdk-9466530c4267
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=C3SNj+o4nSmOZQcsvatoOKv0uXSF6BYXRfbVTfTvTAA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqz6uGjdwxsEiRA5wBpZhF5ZT2usgjG6+BD2jxf
 iz4Y2so3fuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCas+rhgAKCRCLPIo+Aiko
 1WDpCACBIarplL/y0Mo5vOtfypBdG1ZflLKgW1wwjSJPLPPT3rgF41+93qBvGYJPAnePANm+c+C
 SqLqLNMIzhslGqMJ84RvxMbjS8B87r1uRmjFSCDvPzfH+/U/hlbkquIPBGLGx5fSwMEU2yXvu5l
 Clyn7wGI7zpk5cQBqhLSj2KLjE3XP1aXpqU2dN3p7Q1Y3DkQYskeJ7GbA5htdvEYdjUrNVfChTA
 0/tVGXTiRvLCZbGDlt8U6d3eGWejGYzrdrqlsRFh9icm6Nz+eqBgi18s4pzyEIPFYNtXJAmbIKP
 SdaMy5KlHFO5BnPWPzyNZDwQW2ig1+MQSfd3uIR7Z6kCJbTY
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfXxaqxlqikTfmk
 Z61DeJOL1oq9GNvPLzeYP1sOwHux1GscohLrBMCVEHJ1iP3xdILoXcwu4+yKHnpCcGYxy6eVlyz
 dPu1yd8+sqYl/hcdyjVAZdUNPbzcT4x42ZWNetaRDagM7Y5RLNIg6BeaotQBwNE9t+WntuNGFZG
 AElvF14ACaWZEPKG9Mr9ND/+XWUhzSR0I7lOxjrHmWnbGpJVVZtAEc4k6tCeIfe60DGxoLZ5Qfe
 V0SwQ4sjO+YQsDpdiwDBvdH7Grsyyy+vET7UHqZRKaxIKHZeHLG63pC9kdt0qbxq9cpHufXIikz
 w/MnTHlJw0sp3MRncZVwreY95YpE48JZ9IQkq3QUhMKzSj/vKzQ5A+dGm+pvBcuuDajend/7gom
 z8csBhvWZ1+i74zFrLgggWYTQAGpqDtQR9F6BoT/mF98q/T0p7ZE94Gso2CL10ZDqkGAbVSqZis
 Kix+MOYMxC3cklW5SNA==
X-Proofpoint-GUID: _sCI3UrYDgvbWnaXjl_gYL4_Y3Dvf82U
X-Authority-Analysis: v=2.4 cv=P6avFSAu c=1 sm=1 tr=0 ts=6acfab8c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
 a=e5mUnYsNAAAA:8 a=S_NnZ3hT_RIKTG7XCKUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: _sCI3UrYDgvbWnaXjl_gYL4_Y3Dvf82U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NCBTYWx0ZWRfXzoVcIXgn3uPr
 /wHmfgQFX0fRpQC7QgI1Ne787V4bEL0xO46POx1vu9qBjn9VDRmIogBtPpRZ9Jzkh/ObPkc7NZC
 UYOUYtxIGrkZa00RuYg5V9HHEliwW94=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140064
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

Lantronix HDK845 aka Qualcomm SDM845-HDK is a hardware development kit
for the Qualcomm SDM845 / SDA845 platform. It uses the modem-less
version of the chip (SDA845) and provides a rich set of the peripherals
and connectors. The DSI panel is an optional addon, so it is being split
to a separate overlay. To (hopefully) ease merging, the overlay is split
to a separate patch as it depends on the panel. The base DT doesn't have
external dependencies.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Dropped MDSS reset patch (Konrad)
- Added panel driver and the display card overlay.
- Link to v1: https://lore.kernel.org/r/20260217-sdm845-hdk-v1-0-866f1965fef7@oss.qualcomm.com

To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org

---
Dmitry Baryshkov (5):
      dt-bindings: display: panel: add Truly NT36850 WQHD panel
      drm/panel: add Novatek NT36850 panel driver
      dt-bindings: arm: qcom: add Qualcomm SDM845 HDK
      arm64: dts: qcom: add device tree for SDM845-HDK
      arm64: dts: qcom: sdm845-hdk: add display card overlay

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 .../display/panel/truly,wqhd60-nt36850.yaml        |  98 +++
 arch/arm64/boot/dts/qcom/Makefile                  |   5 +
 .../boot/dts/qcom/sdm845-hdk-display-card.dtso     | 109 +++
 arch/arm64/boot/dts/qcom/sdm845-hdk.dts            | 820 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |  10 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36850.c      | 343 +++++++++
 8 files changed, 1387 insertions(+)
---
base-commit: a7d52d51b31a58da686320f5e4edac74e2dad682
change-id: 20260122-sdm845-hdk-9466530c4267

Best regards,
--  
With best wishes
Dmitry

