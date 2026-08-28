Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AE7C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49E4110F3C2;
	Fri, 28 Aug 2026 14:05:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lh/V6tc7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fizhxb8h";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D65E310F3C2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkcSi3279759
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ESpmF/AoUuQly5eGwpgeHE
 +vjb2a7bz/klJLDshyWoQ=; b=lh/V6tc7Aj9h/4SvQpCNvtmV55kj/n8Hnhba67
 1UzgJOkq4i+DXRjMfa4SFiTGy0jZfH6M050A5UbMo+L2w3M8lmQ0Ait4TZhnYkb+
 pcHKw9T/rViHEMQYXcmqKCC7nbgQAF2ygBD5PBTCzuRNBS2CPFa43nWaqp5lGqRv
 PDBhth+eNMyDlXwgzIML6hRxSMQxI3Cmtw8hGVj7bedlX1090Et5Z0D0puRWCbNP
 Z37ng9z+r5ilPKJMLqlmWd/KGX6xXwTOco2xIjOU4TQBDmGV5CY28Ooruk5j8IOB
 t6ICd6/nk6ahd4M3aOCxgT6mr8S0qC4ovH/X0X5xvF2bF6Og==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb62h1ghw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:27 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-754acc61c68so234081137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925927; x=1788530727;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ESpmF/AoUuQly5eGwpgeHE+vjb2a7bz/klJLDshyWoQ=;
 b=fizhxb8hpvoc51KzRJKKnAWJ3iCSmcqqXB3I4Lc/58c2ekWly0on3KbH393ZFUVYZp
 QLIiUtrZy1833p/FdlJUon+GPYj0FbXWZ1iqKQBUlT304OlcpP0MXL44evmbtUxqVUE7
 NKLhSFswP9VLA5UCSCWC2rNo6/NAznkFRItHjRHRDeVJm3KfaPZhDFdBeA7eaCkm5E/G
 Pxji6kR/2/6LM7jWBsThYVjTlBkqEHUUJtiNbabD155v0SBIBff+zBQNcm5b1cAMPylu
 s3cDl7DjRecI7LZDqgWuyteVCkM511zhZ+ZBFfrZN4o4gzx3wjkNxfnBPTic7U1EgPGh
 /eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925927; x=1788530727;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ESpmF/AoUuQly5eGwpgeHE+vjb2a7bz/klJLDshyWoQ=;
 b=LgeXbioK3FQ0TloC5PJW6V0xIHFTHBzwcGt8mIoCixZh/y1dm2GOTRiiVVCtXnerrt
 53ScT8/XLhXeHc4w/7GmrU6hI2gOt1/oMUiNRI7REubIK0UlUoRCq15fLhDcyWzrZ1UQ
 uODKQBe2UTKZg7kpU1UaEBSl9kvENc2UDfO09dF74f47bmrG+tsoa25OWgHG+HpsFEjH
 xs+KaahqddQmcVGv2/8MnEF18oMMCadIkP+Rf0bWFfWI98sVi3eF9nw+dLaWWUgO2y3I
 Q3ofKyb4bNUFWq1edn1oQjy7rh8QjH+lL55hps7JUZqssihRNZhXNmkcPQWt4idbkO+G
 bTBw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoU3zodHEbLewKSWP1QxNVNJpHFPbcN6egZmUtf0N/lnyG6o3Y9DnBPqXOI4lQQJLAKnL+kJQLpYs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++npDuMb+cn5D1vOzri1R3MCXBpqPkCv5/avGHCoiaJ6N5Foe8a6
 5Zdg/SqXUo++BaIv1EsfGM4Y46kOtTPR0D0sY24rvsC0N6e3D9cgefjrYOGGumPgDd3IbHnlWXL
 EcgrTTZ5aBZTswOiAH99aWAtwX0nqZcwEl9BlzgUc70h3zp68PYfJ8HZVQ4A1xgEjyj6Us6k=
X-Gm-Gg: AR+sD13rs7IxcfZUgYM0WVeYMUew8nFurM98jUKM+t44jDz9VsyQHuKFu/101TKJGni
 8wQll05GCSDeqxZOvYusHg49fUDKKbK1YJ3XGyIzqKA68chjEU/9RVda+gzhctETamLwuKGpU+G
 j8PXZQfbm9Td0KrERimn/KxzuzJkFRLI/fTlQiedKCPXj8v4IJhYFinLVi30ZI0GKfVUeX6PKMh
 uYEtDnGsbqgSn9fqiVkXYCp/U10cpDVhD7AtJHsO778JPwak5Wy+H4lPIqmq+ZLQtCgDSLua+Px
 QTNV9suXirJrJbyepmRvg4NemNkSkqoWc6rkSoVeWrPHX045n0cRwVZQsdn4oIlJThXVB7Rdcr2
 Ot8nWIr/C1HHEBeEcxsMq77Q=
X-Received: by 2002:a05:6102:5128:b0:780:7e65:f0ab with SMTP id
 ada2fe7eead31-7859822155fmr1884400137.1.1787925926791; 
 Fri, 28 Aug 2026 07:05:26 -0700 (PDT)
X-Received: by 2002:a05:6102:5128:b0:780:7e65:f0ab with SMTP id
 ada2fe7eead31-7859822155fmr1884351137.1.1787925926256; 
 Fri, 28 Aug 2026 07:05:26 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:25 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH RFC/DO NOT MERGE 00/12] drm/msm/hdmi: Add Eliza HDMI and
 HDMI PHY
Date: Fri, 28 Aug 2026 16:04:58 +0200
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCyMT3ZSiXN3c4lzdjJTcTN3UnMyqRN0k45RE07Q0U3MLU0MloMaCotS
 0zAqwodFKQW7O+i7+Cn7+IQq+rkHurkqxEBXFpUlZqcklILOVamsBxh4E04gAAAA=
X-Change-ID: 20260824-drm-msm-hdmi-eliza-b3da5ff57851
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
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vJbhpstV+ttcZLNyRwj3/fWbYL3GtHiutJk3K5SuMGE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWVnzNVHc+lG26q5VD6MUoiPWo4+IJEQmloY
 NARu+bwH9KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVlQAKCRDBN2bmhouD
 1ytFD/9hbKOrNeWlLxDmBPlo/nIBIDXI2BK3P/ZzCU6Un51/tyatSsYVJQXke1oILq9TTYQrwRa
 T+ltjftm0bzGloK3PQvumopARUNa3G4rqfmxJ0Zu94zemUlCtN8q+T3OipJKYWmS2EaAd+HS8YY
 QKifEwpnO7ibqhBC19OY8Hiawn71/2ZhdyA4wBZTd39hjVwc0eqO2xPxpPbxAX+dl3CCYY/iO38
 8GEuM/JrsuK00RvXw9rOyr7grpVn4Oqenf1Beo4cJxhE6iKfjGej1luIJPsCxo9Wy+p7jJdVfFV
 vAmAGMuSMlYNi8mEHoDDy0eKo/KArNTvcCuoZa9sFSztf6MKtG2YiZF4ExSO3iSojWMzVQGMw6Z
 YFuWzvJ4qv5WND/rZMXhdqBjw7LykVJcokpLFxYp8tfFa4IEzb9srSjIAfaFhJvwVC7mcafh9Fp
 4TWev0SAlfXWrEAZjlcdtPOimiOruhvOkONSUaCTmxF4QgyEFplXliL0wzZTi6s5EAWSiA2G2jh
 xxGsUpFGV1pFHeSexBm0uRmRUYR4rn+NMLQxqO97j06JVjBI3XceHNqELd/QeRkSA6sNq6Gk9ZE
 rZ1lC5eFQhJobPBBkV2dEdgKwjBNTNCrojmUwtY5gdk7rs4nVrRjAZarf8lrsQA3+HKkgy9ghrV
 8I3UTJFJzEt5b7g==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX0XYsQEiasmU8
 LCY8QEnx179nhp0LsCEV9U7ltgkyRSqXo7FaxRHHxAwAc0IO/658DwVNtdJZroPb1pBQ81LuWlv
 RbBnRjcOP8wY5h4V1OPeJwrbAUatPGw=
X-Proofpoint-GUID: GmgDwc4Cjw8Dl34MPKyGDLNw6o3hFixZ
X-Proofpoint-ORIG-GUID: GmgDwc4Cjw8Dl34MPKyGDLNw6o3hFixZ
X-Authority-Analysis: v=2.4 cv=I5dVgtgg c=1 sm=1 tr=0 ts=6a9195a7 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=qF0omb1No2WOS10Eni0A:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX6s1Z2u4m1HYN
 g+8CZpayMwAmK95asDBtLdhGa3czUA5Q/3ML37oq5tSqn9nWgYTDgYnIgBONwk34icmPu39I8WO
 LPU2tF2QeZxlWCvtrZXqopGTgprOzwmIH8qgtClFOsB0PsZFhkXeIwmsvq+Mq99s9MT7YpeN9kZ
 W0tdYXMZADivX8D0NPhkJp7QV6Ucu6SyF3NliRit9csFRLFmGyWggSlB4sJAl7S33Vv0GkUCKP1
 ysG7GVI9MMJ0GryN80sygLiNXmY0QY42yZSYhHf4eKwcuuRn3BsrBXP/UJxY6UwQoQ48XvFtsj/
 pOg2N8p0bMnv0oTdcW1V8CbST+3YCtd69uf/VSwlX48j00jfgvW9N6LlRjNDZLgYOe1DnY9wRLl
 9G8MbLpHM2bj+Ugq6NAWaMJzstZwLnRaiO7VSUFDuLTTkdab/yVYk6o3jBZUTELDJYmzvJlph/P
 x4p/116qOt59qBestQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280122
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

RFC
===
Posting to get some comments or just for reference if anyone wants to
build on top, because unfortunately HDMI does not work - no signal and
missing TX ACK on HDMI PHY (hdmi_eliza_phy_ready_poll).  The TX ACK
appears for all four TX0-3 lanes only on the first boot configuration.

The MSM cleanups (first four patches) can be taken as is.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (12):
      drm/msm/hdmi_bridge: Drop redundant initialization in msm_hdmi_bridge_init()
      drm/msm: Properly handle msm_ioremap() without name
      drm/msm/dsi: Fix indentation of if block in dsi_mgr_bridge_mode_valid()
      dt-bindings: display/msm: hdmi: Correct name of disallowed supplies
      dt-bindings: display/msm: hdmi: Add Eliza HDMI TX
      dt-bindings: display/msm: eliza-hdmi-phy: Add Eliza HDMI PHY
      drm/msm/hdmi: Split PHY init from power up
      drm/msm/hdmi: Add support for PM OPP table
      drm/msm/hdmi: Add HDMI for Eliza SoC
      drm/msm/hdmi_phy_eliza: Add support for Synopsys-based HDMI phy on Eliza
      arm64: dts: qcom: eliza: Add HDMI display with HDMI PHY
      arm64: dts: qcom: eliza-evk: Add native HDMI

 .../devicetree/bindings/display/msm/hdmi.yaml      |  71 +-
 .../bindings/display/msm/qcom,eliza-mdss.yaml      |  96 ++-
 .../bindings/phy/qcom,eliza-hdmi-phy.yaml          |  71 ++
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi            | 103 +++
 arch/arm64/boot/dts/qcom/eliza.dtsi                |  94 ++-
 drivers/gpu/drm/msm/Makefile                       |   1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h |   8 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  |  15 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |   3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   3 +
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c                    |  40 ++
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |  26 +
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             | 117 +++-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c                |  28 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy_eliza.c          | 723 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h                      |   5 +
 drivers/gpu/drm/msm/msm_io_utils.c                 |   6 +-
 drivers/gpu/drm/msm/registers/display/hdmi.xml     | 140 ++++
 19 files changed, 1520 insertions(+), 32 deletions(-)
---
base-commit: 448e60718f7b424994fe1a9013b5317e756e18eb
change-id: 20260824-drm-msm-hdmi-eliza-b3da5ff57851

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

