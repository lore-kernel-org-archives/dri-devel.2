Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147F3CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AEA810EDEA;
	Mon,  8 Jun 2026 07:01:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dq1qXWvz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SKQcoIR0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17CA10EDDD
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:01:56 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586OrI22274530
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 07:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=GQJ43BCxRXT3sj0FEby1LK
 Vsqp3NgRy9qYHkeoXHJ+Q=; b=dq1qXWvzVvalAJasL/vbP2x5I769P5VN64Yb6G
 R9SCxURObCDupJhqTu9kS1BN+F6oqm0jOtLrGAQ/edcecX6v0q3EYKsMZoMcwCcT
 o5w/ttOlT1hQq6RwUWTeGQrEGY+JtYnKFlpr8bw7GX8Mvs6a3jQtN08QxggxQbum
 qRG8C85BDtIKMEj/vh/mdTz6H27vgGuu5iHwLKT6JASWtbyVYDQThDw2ftgGazjm
 z/Xe5M7I6OgKbXzytR0zR1xY4HLawoqsEy1OI3kelQv0XOl4PIVWfrszgq9+E4Kb
 OW5Imw+NvANpY8vtugmqUGIer8iB64ABptv6gSh1MSi7LzqA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgx4s3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 07:01:56 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso2747471a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 00:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780902115; x=1781506915;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GQJ43BCxRXT3sj0FEby1LKVsqp3NgRy9qYHkeoXHJ+Q=;
 b=SKQcoIR0kyUprXwrXhhwsZsYFgoW0WIvZ0mT3aJM3Nnlb4WPvJn8S1196SEZRJ0pq0
 iVh90PAd7K8vZA6oHBXB5wv3AQ2EFFMPj726LZOEuaJNcRSm4AWnvViSztdbUcM1vlGY
 xHHI3HN65QWeVf6oZM1/4FusPlxZPrSyQZZ+ITNjpd8d9c6y4qF1RY6R1MvricOnOOmZ
 +tV5f9TeCcxeIbc04nmnZS0e+l+PznKHY96Pln1cyvdB943mn/ImKfTuvgUZPepwRIwM
 1r8BRNaMMroLzbAiiSJCPO0ahqz5UeTMUhtXJnwyHxIrVtZhFX/WNVft+tYGs9l0TrIh
 0uwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780902115; x=1781506915;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQJ43BCxRXT3sj0FEby1LKVsqp3NgRy9qYHkeoXHJ+Q=;
 b=GBDImy+70O3jDLErhy68quDA548fBbCKyXrYdkTaPW0hRYSFTTtzQ00E/wrzlU9KzY
 kKlcf95HdVGIlkpwwePmJDWWc/BqdoHlp3Rlbc7yH1sCFpBnGucZN3utgUpQtCQuX2ra
 PUcsiufpcqqdufoq2D60RuNT2N+/RS82mnvxAcj9u44NBPB/oiANUuq/Qg+tXH/tvHoC
 F39OfkpnkbUiJLpthkn6BNRfaClTr3OrX6N0UQRYZT6BLHcCaUgS1eOmyca4OAWXz4ZT
 xM1nK78YNQP/el4GiKoyi+9KLFJU8iZ4AdcfSMYfFseYrXfWyjHF9gNa2E3SYyh8uh5p
 85Vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ih9LLcjyqohTq/dSIFnauQw7XDNWMF4E47kXNK6qQqTlZcsGvG52nOfMeR45gTjlWgEIoHLxZhvs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzxaou3ZjsiEMaD4e+azMVVSpJXcoARfrnqUXtX283DQ4vaXJry
 aw7hxT6J9sNgab6m4EpeM4kE6EIwAEb3nxtN0dPpJsqlXnMSayM8mJHM03NzeHOpQ0GKYLhOzke
 ZTRo0kipHIRvZ18/88ARUzu4Cvgf31axwhJfyVHPA0Kdur4ie3hLwaAPjCdDp9yGWRUkUha8=
X-Gm-Gg: Acq92OEhoAWzW4gPv6S2V1KozafHUnz3ayo1lIHUR3i31d4ta/b5MtKR18cxVXjT19L
 zxybm4GK1x8W9QUt39KDVk4D7btXl9lnS76WNmrJInJvy9bGzkSx7xaBsUAWUFOdGR6VczS5Q6j
 Mh1JxZInoD3hWgSlEd2DRFGckvgnYLuJ+m/2gRq23kTyqboE/OfvgycpiMs1rh+KIH7i6l6BBqO
 sCp3zKJVGSm3DSy9RUS+bNeqROMD6JqYtyjTwggYaXlY5cwhcpLU2g/HokpIYl25kxMSv8Fhpeh
 5e9k8OE8MiKr2UJ2KeIOZLt+YR16R4HLiZWk0MrtzkNppUjLlRCm8UhlEz6YOSJcqR43O38tiyG
 Ok2I/xkmqqz8jgJBNsa9AF4xbvLHBQn5Y0a06ix8dSrPJUn+EfPIbNIr/NrQ=
X-Received: by 2002:a05:6a20:be86:b0:3b4:b24e:27a2 with SMTP id
 adf61e73a8af0-3b4ccf7fefamr15902100637.31.1780902115323; 
 Mon, 08 Jun 2026 00:01:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:be86:b0:3b4:b24e:27a2 with SMTP id
 adf61e73a8af0-3b4ccf7fefamr15902049637.31.1780902114854; 
 Mon, 08 Jun 2026 00:01:54 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c86151154a8sm6267723a12.22.2026.06.08.00.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 00:01:54 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v4 0/2] Add Shikra (QCM2390) display support
Date: Mon, 08 Jun 2026 12:31:41 +0530
Message-Id: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANVoJmoC/3XNTQ6CMBAF4KuQrq0pLbTgynsYF9MySP1DO0Ikh
 rtbcEOibiZ5yZvvvRhh8Ehsk7xYwN6Tb68xZKuEuQauB+S+iplJIbXQQnFq/CkArzzdzjBwYYw
 2UhQ1lILFp1vA2j9ncLf/ZOrsEd1jUqZG4+nRhmFe7NOp9xfvUy44ILjUllkNYLYt0frewdm1l
 8s6HjZt9HKpZF+KjIpVEZFWG6zcH0UtlfxLUVEpi0xbyGvUKv+hjOP4BvJD/NZRAQAA
X-Change-ID: 20260603-shikra-display-07767208fa90
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780902106; l=3551;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=qoPjmohCj+qt+VnuKdYhqh4uHy1Ot3eveLLAi8iChK8=;
 b=GggoWg0wf8qT155TttrTaciEjH77CjKueLHxsW41Jlb4McBcfrIRBKW+Rytru5kPA/RgJ83qb
 BUv/XSFcBNWDOtsjCayphHwV6JyhMvY5Cu1GGuaKEUk+Xkdannknxzg
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a2668e4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_X6I45OPZ5LLD3mXDKYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: wg278zrcpTPRiPH0FiYzf_OkqzWvWZBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX+9uVMMFje5fG
 2bhhJRbi01PsLvTRGfVF764SpOsdmxAs9U98J572gigf7s4vlCHQ3B7exnMkC1Q3Ywg4hpStaW0
 AF94+QtrV6An7Q0kTAlmouHsyjpPGWy+dslvqiWoRGxKJ1CqKT9W1ndwOS51E8t/BqQwoQHoxQp
 Iv46Z6oXgUZM8X9NnQAMGU/mK29l0Zccb8n/8cRCa3r5g0EfhtISIJuqsmQqerRrim/EefbpR0G
 lUulbrfomVePiuSAlV0ja5Hxa4qysULd+ZkZQOILHLvBaRAumB4ZNYwcssFzZwOi7meLnrGByYO
 kP1rz3s6w/w/wEWm92P7TM69a6RhnzPeuttW5Uku/YQezTclPi3hbaP246Xj52OORa/JgrtjHzi
 6NMMg/YSKf99SIy/pjuk4IluRuJiqCTYfxAcfOGzw0wSlUz7g2lFF93xqIzhNpFfLBdkpjqEPqI
 1EKugtYbCzUiZfCqpkg==
X-Proofpoint-ORIG-GUID: wg278zrcpTPRiPH0FiYzf_OkqzWvWZBx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
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

Shikra (QCM2390) is a Qualcomm SoC based on the QCM2290 family that
reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
the display subsystem for Shikra by adding DT binding updates for MDSS,
DSI controller and DPU and UBWC configuration mapping Shikra to
qcm2290_data.

Driver and SMMU support are covered by the existing qcom,qcm2290-mdss
fallback compatible string — no separate drm/msm or IOMMU patches are
required.

Tested on Shikra CQM EVK board with ILI7807S DSI panel. Display
pipeline probes cleanly and panel renders correctly.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Nabige Aala (2):
  dt-bindings: display: msm: qcm2290: Add Shikra MDSS
  soc: qcom: ubwc: Add Shikra UBWC config 

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml		|  4 ++++
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml		|  6 +++++-
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml		| 19 ++++++++++++-------
 drivers/soc/qcom/ubwc_config.c							|  1 +
 4 files changed, 22 insertions(+), 8 deletions(-)
  ---
Prerequisite-Message-Id: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>

---
Changes in v4:
- Fix sort order of qcom,shikra-dsi-ctrl entry in
  dsi-controller-main.yaml
- Replace oneOf in qcm2290-mdss patternProperties DPU compatible with
  contains: qcom,qcm2290-dpu, consistent with DSI child node pattern
- Drop arm64: defconfig: Enable ILI7807S DSI panel driver from this
  series; will be sent separately alongside device tree changes
- Link to v3: https://patch.msgid.link/20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com

Changes in v3:
- Use a fallback compatible chain for qcom,shikra-dsi-ctrl
  in dsi-controller-main.yaml instead of a standalone enum entry, with
  qcom,qcm2290-dsi-ctrl and qcom,mdss-dsi-ctrl as fallbacks
- Replace oneOf in qcm2290-mdss patternProperties DSI compatible with
  contains: qcom,qcm2290-dsi-ctrl to avoid duplicating full chain
  validation already handled by dsi-controller-main.yaml
- Drop unnecessary select: block from qcom,qcm2290-mdss.yaml; default
  dt-validate compatible matching is sufficient
- Remove self from qcom,qcm2290-mdss.yaml maintainers list
- Link to v2: https://patch.msgid.link/20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com

Changes in v2:
- Drop drm/msm/mdss: Shikra support patch; driver reuse is handled via
  the qcom,qcm2290-mdss fallback compatible string (per Dmitry's review)
- Drop iommu/arm-smmu: Shikra SMMU client table patch; not required with
  fallback compatible approach
- Fix UBWC config to map qcom,shikra to qcm2290_data instead of
  no_ubwc_data; Shikra shares UBWC support with QCM2290
- Refactor series from 5 patches to 3 patches
- Link to v1: https://patch.msgid.link/20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com

---
Nabige Aala (2):
      dt-bindings: display: msm: qcm2290: Add Shikra MDSS
      soc: qcom: ubwc: Add Shikra UBWC config

 .../bindings/display/msm/dsi-controller-main.yaml     |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml        |  6 +++++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml       | 19 ++++++++++++-------
 drivers/soc/qcom/ubwc_config.c                        |  1 +
 4 files changed, 22 insertions(+), 8 deletions(-)
---
base-commit: 3a34f9c13cc0688f8db2a0db8506bf8c0d90737d
change-id: 20260603-shikra-display-07767208fa90

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

