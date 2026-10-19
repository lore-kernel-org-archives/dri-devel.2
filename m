Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2510ECCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:18:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E27C10E912;
	Mon, 19 Oct 2026 09:18:26 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6E810E921
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:15 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OqQ33256584
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=7udigO7AEbnYsRJJZYNQ2N
 UNZhkQk+qkatcnC+st0rI=; b=Ppf7mxxDFvSZJTI2cRgnYJmrTIjtcJKU967Y4o
 Yrvrhyg0BYs2SAwNvJh21yJxRbUmm/LDQUxK61JU8WBVlZXyKyWuFRC1qUT0Xcko
 JsLjS0Sz8+t8vbfjBG/UqdI//HsuaDvGEcEF7+QTjhN9xdZDVMkPg68E9j9anRym
 +W/QYJ1PJkV1nMd1lH5MuTrz1DISq3R4DqLpZNf5Z45aA6xJZMuKfROF+5+maM8i
 sE2zyeEizzRRe00+HESRLWzLVmOx0InqdSIRcR5xApGMeQwAgXNi8u1iBsHwoort
 pvqEQSl/UQk+ITYzETkkxEtdLZwFok1XHtPDIEMGLhwzgn2w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8ba3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:14 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ce7a85f04so391353485a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792401493; x=1793006293;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7udigO7AEbnYsRJJZYNQ2NUNZhkQk+qkatcnC+st0rI=;
 b=D7iIKVUVeNkaNnnJw7ZKOgtlLRGsl9cgTNxI6Vu3P8FY+1XkfdIn1kmBN70iAT+UtQ
 TYIjn+3Yi/Q6A0mrK42NRgAgLvFJoF1sovBugwb3bprncwjRifdQDZr61gsB3EbOqxPw
 9+N9iA45+9SgiLNMCgXlF2YInXo1UT8+Fg7C1BD1bzmjwQSMW9U/TwkouwHrg2H1vpCM
 SxnkR0KkyobC1re+t5eEqq6AZI7e8FVydPHC+9oBYwzIKJhiEibtKhleSpyZyH+5Ba+V
 4tZeRTqpKWgfG9ULu5UqZrXtBXmWh6RZ/Bl/Pr1gkLPPIpAxSFaBHdmLobi8OT8TDvi8
 pRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401493; x=1793006293;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7udigO7AEbnYsRJJZYNQ2NUNZhkQk+qkatcnC+st0rI=;
 b=VfSXEHNtgARZ+BXWTBRWAeqcFsxmWruCYl3K/1eQ4B7oI1c9wMKZwSweVE9HJqzyWr
 sR9JrCyhTAVXbeYMPWEn8Zd6TegTFGOXMT22XSmF1Iw4IAcSuMHSuWo9WvnPEZsLrVGw
 Xsc5CDauSoYeUUv0gw5ONl3Adb1yHBk1KAWg/2VThIhbgFWkLp7iI4Q67V3iQwM5nwnl
 ckELl12JNG0QJo+j8lPEFoyt/XzJyh01oorpRBIu3UvFyIW5C7sKhytVyoStmFPAXPa0
 waSzsrJFw3p5DSy7dvUuAjN8VIY1Q81tFxNUndK3UpLq57R41IcTJEhJTqGyX3MFRVDz
 SXPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBySa9YpYHYgFqCE3/24MoNsx1H4s4rDhGaTBdMhO0MXzU6UY+jsD1yjOz0eYPIcDe6pLDpBMR+Fj5E=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJKdNNkICwPsP9x1KvbeC10E9832SlGXe4h+G4l/kjvKE889u2
 cSynNFapwwqCgrPNgBWe2l7zbyHPivGL+f5W64IDLtTMkEwqqcbNnsBHtNE/ePJxKev+zlJTFLW
 rpWQiaLoDz/YCHFHycd/rlLIVC/3x3F58HmYqePg7VzzkXEoxfDV4AkdtbHY5/gCTEA5rYkg=
X-Gm-Gg: AYBFou2cYXEFoJpCZlNrRND2UsxqG4ewW6Ecq+BdqPeNRTn7bQSzfEXrzwVNNzixbn0
 m1hpEZFtl7cIPd1+I0fcKyDxolzmt4N0Z2Ax0w+sJM+YHQE2HDbE0BEd47F45H48E3+Sa8XTjw9
 8+GnaAPdUGRdbxS9NvdsnhKz0NKeukylqmXErtErw+9UJTQ5FjSK71Vd5YN5NhcMGE2pFKg7/WW
 8PXSAlbUhJvmlD1KJ/bgQ+8+k2uU2PE9Xvr0GvK/wJ86zotSWdgVfSKJYNdwQmpjF1dvhUBE/rl
 ql+YNIBSgFUe9ZFRSNqqws8Ma88dV6jrsbHxc8mfklPERyUsJLGLDgl0Wc0ECIJuCt3nwu2Th6S
 7L2zSitMg/WG7QMQ1CbHVqDNzmH/b2rtBQlx8CORE7YqTwV8O27ymrz9OrNvyBkBM6hGrF2TfJK
 rxMzv+HEgnbuO6
X-Received: by 2002:a05:620a:3720:b0:93b:d7a0:d9db with SMTP id
 af79cd13be357-93f29d8a748mr1172447085a.53.1792401493224; 
 Mon, 19 Oct 2026 02:18:13 -0700 (PDT)
X-Received: by 2002:a05:620a:3720:b0:93b:d7a0:d9db with SMTP id
 af79cd13be357-93f29d8a748mr1172444085a.53.1792401492639; 
 Mon, 19 Oct 2026 02:18:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab2e4e05c2sm15893441fa.25.2026.10.19.02.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:18:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/5] arm64: dts: qcom: support SDM845 HDK
Date: Mon, 19 Oct 2026 12:18:02 +0300
Message-Id: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEvg1WoC/3XOzYrCQAzA8VeROTsySTOp42nfQ/Zg58MOWut23
 LKL9N03uiAK9hL4B/IjV1XikGNRm8VVDXHMJfcnCbtcKN/uTvuoc5BWaJANIOoSujVZ3YaDdsR
 sK+MJuVZycB5iyj93bPsp3eZy6Yffuz3CbfvPINTPzAja6DVzAsc2xVR/9KWsvr53R9933UqGu
 mkjPgQwQC8CisDBNNQQJvlmRqieBfsiVCKAh9r5YAJwmhFoXiARGlth4xIZdP6NME3THwHmTDZ
 xAQAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3576;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=SRCh87j8WV4ncKAd3kt7UhX6o3odVhDR/GaASpgOZBs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1eBMS6rUocTpCO7ESGVS6uBDCJ5SKC2Ptu30L
 X4q1/D/CDWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatXgTAAKCRCLPIo+Aiko
 1XBYCACZpLG5jLTo5w8jXq7RTlh6a3NKrrx7/4pGKD3oVQtYzlOGBdOWqpvM1KIDm+dMY/bhjjf
 A+wu5ycd0iPSRbi6RJS6vSMiT5iTtmFaZskJ2tE+YkzdNA6e2vxPiXMW9sFdommNh54etO2f7Db
 QvMaHs3aAHgZ/hoSZlMy+t8Db6LqNLev1pLaiSVTLIBC+D1ikMPD234L6BmhAZAEUpzHh8ibRCB
 oTIfKC/g7zvqPmX+T90HE5AxyNpMN56wRHx6qHEslMQRuRseHrVq7IzAZjRQt7qklZ4ZbFT6NPU
 u2MY1JJbAWjVQ+T97CZqpBZ2E/+CI73RxWfq8YY0vzopdUKs
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: DVWKyG7G_Mv8NcqvmdirmpsdXuGIR6nF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX12FqLv875zYj
 vzhY+TFDdyjXJ8677byI4dEiG1UILarS7YPNCD7yMULlywydTEbQZIDgRJ9nd/OmX5BMIel4m5X
 bwebAVKdychizjuUFYCkdEv8bqpT0iQVK6omIKGWT1rDxRNgiMCZ5DBXr9yZ3S8Hx5JHuSUaiPi
 eAJNju/YCwkn/Cif7S7ZSTz2PIKEL4OcSf574+QpIFKV/EdFVgCTSFTqIZDwkMNb3+r2K8nIiRO
 cReJINM/rdkH7lU9OpFSEs/RLE+916JztOGB3p66OZmEPuPeCXkvqSs5ymKA/pno4YZ2d7CkDYO
 Abo1M/k95J0f8t0HRzLq8qfCIV6Y6VkTkbn3IxE0gRzHj5eIN2aMYqktCAJvD8faEdqkVHo06aD
 3KcEN9B8g+RcxKN4aRBMiZ/I+ZOvQwL+iPnDqPGASdT7uXe+r24StyMz8u30K2wUZfQpfXc52vm
 E4mQ8UtKLkY6R6VTbHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX2vDyi1gAXeCD
 q+CSuxYI1mylY0k7XWyBM3GY0uEjStuBxb7FGq2/DaZ/MhtiE0RhgYAz1VAqxjUn9gDqa1KB/b4
 /ZQjomMZSAX9rsyw97p2oY51p25a4wI=
X-Proofpoint-GUID: DVWKyG7G_Mv8NcqvmdirmpsdXuGIR6nF
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5e056 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=WDvwZioAV1Qa1_QZ0V8A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190036
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
Changes in v5:
- Fixed panel disable function to prevent NULL pointer dereferences
  (Sashiko)
- Reformatted the HDK DTSI,reordering properties (Konrad)
- Fixed commit message for the display card, removing mentions of SM8150
  HDK.
- Link to v4: https://patch.msgid.link/20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com

Changes in v4:
- Dropped backlight from the panel (Sashiko)
- Corrected GPIO used for the Home key (Sashiko)
- Corrected USB PHY supply mapping (Sashiko)
- Dropped backlight pointer in the panel driver (Sashiko)
- made driver more robust for a single-host DSI (Sashiko)
- Added comment regarding USB OTG
- Link to v3: https://patch.msgid.link/20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com

Changes in v3:
- Dropped mipi_dsi_device_info from panel_desc (Sashiko)
- Added comment to SYS_BOB (Sashiko)
- Corrected commit message for the display card, dropping mention of
  mode select line (Sashiko)
- Link to v2: https://patch.msgid.link/20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com

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
 arch/arm64/boot/dts/qcom/sdm845-hdk.dts            | 826 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |  10 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36850.c      | 350 +++++++++
 8 files changed, 1400 insertions(+)
---
base-commit: a7d52d51b31a58da686320f5e4edac74e2dad682
change-id: 20260122-sdm845-hdk-9466530c4267

Best regards,
--  
With best wishes
Dmitry

