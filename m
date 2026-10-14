Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB13FCC6B2A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2479E10E15B;
	Wed, 14 Oct 2026 23:51:39 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DAB10E15B
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMPuc7500313
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=LmbkMsHPiT3BBG3ZeJHnzx
 QOZZxaOSDnnOlylj3EKhg=; b=a0KUcVxTRKjRJt03yTKS/lmKIBinCps5dyUSph
 PgkzVgrQqMzqMA1vA7n+DhN44U1Y1kOeLZlliEWDwXjlCxE1A3fk5EwCffryva/2
 wYyVfpVdlq0Wb3U4ATwv8n8/OqsFWBum0GqjuewmjNP7VlrUjDRX1RbHY7P2rzBV
 fQVqZII6NheoZxCbJD+EnZq6fG/4vLM2XEzZOP2bRkwiPkWNuqz5hm+g+F3Y4fkb
 p0xEDtt9EKIKyiPrFsHqP00qUig7JJ2K/C1DjUFwZ7ue/AtQjkawvlmih9w6c6X3
 smdWPHgDBHa0r7nscCd+rRT5ZqIc1w9LF0wtpMm3ksRF/sDQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf28uv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:27 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93c5ab5c136so813141285a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021887; x=1792626687;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LmbkMsHPiT3BBG3ZeJHnzxQOZZxaOSDnnOlylj3EKhg=;
 b=gFappMN/Erk1CKj06t0afr/Cra4vLk6NtoXucBGZuXcFGkUcNVHf+AbAdOt2VK7inz
 lM1YEau26b2luBhYFk6c3ErdRFzqHjspKpMqHAu7hvN33DBPt7C4CuNdkNx5IcxpKqXY
 PNX97Dg2e1O+KLoNDjEATCdP7L65YfkvOryIr9WKNG7M18OpMc1RVlGUJjdbgLV8cRZm
 fxata6rTAlRbFD92HSujmj2JVNAxmMXwQj/B4eDU8UAc2m97Jz6l4j8rd4z5r1tuDTOQ
 /JdkXyCH7fhNVr15AWED4E278u8eteqY7dqYRzW/2vBMR45JK8FlvOdBG75pISaDqq7r
 HGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021887; x=1792626687;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LmbkMsHPiT3BBG3ZeJHnzxQOZZxaOSDnnOlylj3EKhg=;
 b=cw3JPd+awo8s4D/fXopfF0sauRur/yMAh/MF2LH8fqKck7mcI5dXoBI50bwAxQr5E5
 hrawCEVt34FMg3s75wCGcpyymGkrJNbS4HlLbRveCkYnRpgtyPUNq7LNLP5/OQp7Oqm/
 VQgz71g/b9lB1f8Wiu9KV+T+2omb9S874n+2n2Bf5m1IgUMa9khEkWbtLJUz73Ue5xIF
 Kl7dm/AwE6OsqnE+/WEso3T+o/a7StzqbDXcx15LaNRdWOGiRnWdYV23ef3L3sgV37IC
 +2+0O2/WAkIMLhvpYoa1ta2Ub5kgz56aNURhT1tYTjskQlDkRF7M0JM8de8HRMXVNEnW
 ThXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw35k/WksTTescmOy7owyOmSzE1sqhudtujrh9qi3AoM4+9P7XGoVF/U0pfAmdudms35PWvlx9QQV0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJgmFHx9c5fOd7kIpT1wt8spU3svhAP2cju7xNd4bzCuankLgWq
 cxfCExngaJQnD8rf3o10bgcQ09sUjdDD6MQhQUZ/WPwoxhjQNj3OkZDrW1opsrH2gq+GE6q77bx
 PnspJ7egTrMEZNJKgAUOOiP8eMG+KfZIBf6QCxXZNwvMqspetO5U0zXH32rveZWIduBi0Hok=
X-Gm-Gg: AYBFou2OmN3iprUiVNMRvIEizjlzfQ3/gT+JNluDnbFI+7JE4DwdZMIhiM3ICzSi9bM
 n9yYbzUDLTOxZe/27pbHoehrGrM2Er8AXy+q+q8VVErvGbP2ZSriDHs95qSZK07kfimpcIyJgdr
 9F/widGXIQ7Id6VAx6Bnnoj2ouzAKPyZJX/Fvaklf2NuDPUnbMRL/G0BYE0SNDFvFQctiC5QhHa
 3RW15c0frC0dDHNP+xVBcfbWodDDZoTsSfP1twl7F/HC98ThVZSqY5B8JyDKxd9vtmm2wLYiUeL
 7wM4efzElVtPET6Dwy0MhpBKNbxsAXgxplQvNzu2mnvFg2FV57BxDn3BhMAuRR6cm+iAx70G6Z3
 ukdKbjiB+Bgj/vx7G5w5lUe/feP0TVw/mQEMhrR5l2FBjRtOizOLZxdtyaXTFTAVHAxhEAHXpFq
 XH14ITpzV7q9kN
X-Received: by 2002:a05:620a:6cc3:b0:93e:c12c:f128 with SMTP id
 af79cd13be357-93ec12d059dmr2761716585a.67.1792021886666; 
 Wed, 14 Oct 2026 16:51:26 -0700 (PDT)
X-Received: by 2002:a05:620a:6cc3:b0:93e:c12c:f128 with SMTP id
 af79cd13be357-93ec12d059dmr2761713685a.67.1792021886184; 
 Wed, 14 Oct 2026 16:51:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafded5414sm2285281fa.16.2026.10.14.16.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:51:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 0/5] arm64: dts: qcom: support SDM845 HDK
Date: Thu, 15 Oct 2026 02:51:12 +0300
Message-Id: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHAV0GoC/23OSwrCMBCA4auUrE1Jpum0deU9xEWbhw3aRhMNS
 undTSuIgpuBf2A+ZiJBe6sD2WYT8TraYN2YothkRPbteNTUqtQEGCDjADSooRYl7dWJNgKxLJg
 UgBVJBxevjX2s2P6Qurfh5vxztSNftm8GePXNRE4ZrRENb7A02lQ7F0J+vbdn6YYhT4MsWoSPw
 BkXPwIkARXrRCfApG/+CPM8vwCrvqJ+7QAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2832;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=RP7WTrwAPt6xLoUSEeNrq3/jN4TYEWno3wYkzoYf07I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0BV1C2bhr93FymPWgE8pLAQxduOhlAe8Ec7rl
 oEbFE3/5iyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatAVdQAKCRCLPIo+Aiko
 1fU5B/9EQtqAkzf2qdc1i8rt4O/Z1ucIW8ZYZRV9y1fwjJK55oSjCDiiQVbvMdZdC0kmB9zn12A
 XiQAsg1i4PTCWWmctEQok0A0MhuC+qs9sxOxeVgjlkTfQWu0Hm3yRMiA7zDQmH0wrmgfHzaVj0h
 0QS92wvtu9dcrbG/4WYhw/PU3G23q72owT/KbZtGu7LaifX73BYrKeOYFAhD7LAtuqegBUsQUqX
 3i8ZGo+LFJUHNE3MfrgZl2trBnP/GhzmFYl2Gcm5umdSKRTwiKs6d6Xw72Za/4K/f0doVUOxR2J
 xr+f5rdhEnSu+GFsqydNiKjnZ5QOKMCQVv5fB/i4YYjid8ND
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfXyiDVihcO6F5L
 39ec9TUnNELVObOmBzKEXNSndLT9mS30TlbR7qz3B8EICuSo22FgEGsEZhwHACO6ralkdP2xsM0
 hs32BedCMxtiZrF3yjMETvfPESW2zB3a+Fps+Zdcd4QV6hODw46nDTTXMj+Ikf35zDt8OnYrsJ4
 URPMiqkJrrEBw3zx0pw0ciYXe/u2EmjbjWpCEb7Rsh+qeseNTRERO/xMRUyjL0jS/mTEHJ3dUw3
 ecU2MbMzBUKAZMALm150K5xluDEQYbPoSgAIF28UpzYKKmYHy7x0KZ0s5ia8l5vrS+GS2fV6bzI
 i/z3jIq8YIgQZC1WMbxz2Ntz2VPShDx084T+56u6jd7tu+GMRIZCORX4KCIDpwA4M54At+867fs
 40qpaINrImHLgDtoi85CS2ZaYBopioLe2kQT7MB4PBf65M/p273hgIC2KMPDLt//I0tu4YWYaz/
 qu3+HFxdiAjf+qKGlow==
X-Proofpoint-GUID: noDmtquY8D6sntlnUgUzrp7VZMSupuZp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfXxBHQcp3cmpFe
 dZJqWN69bvGneYEv9pe9zuCld3PonH8L0ALHoy7QsaYA8n9NcirLsjEt29ey00ta+GwXBE/4Wp9
 OWDEzycyVZlDWfTwH9oAZja35xbFhHk=
X-Proofpoint-ORIG-GUID: noDmtquY8D6sntlnUgUzrp7VZMSupuZp
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6ad0157f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=QyXUC8HyAAAA:8 a=e5mUnYsNAAAA:8 a=S_NnZ3hT_RIKTG7XCKUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140095
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
 arch/arm64/boot/dts/qcom/sdm845-hdk.dts            | 824 +++++++++++++++++++++
 drivers/gpu/drm/panel/Kconfig                      |  10 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt36850.c      | 344 +++++++++
 8 files changed, 1392 insertions(+)
---
base-commit: a7d52d51b31a58da686320f5e4edac74e2dad682
change-id: 20260122-sdm845-hdk-9466530c4267

Best regards,
--  
With best wishes
Dmitry

