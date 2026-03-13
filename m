Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDC1105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E2A710EBC5;
	Fri, 13 Mar 2026 12:08:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XcyPdW7P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FJWL6o9H";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837FA10EBC5
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:42 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DAseKN530519
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=IGOT9fD2d0q1zlnv6OnUTILWf5Y89gyMTfA
 EqWAQqBU=; b=XcyPdW7PwRzUxdImdzLrJpali8nZRk/vNxl+gBFJaylkCeLHmsn
 bkUOIs0IKBB16FkZp/bdsW/kIZXz59PFr6Hpjt/8CR50A6CbpSqOmN7dB662LDf/
 GDfhbw0m/mT3CJdNIbsG/fkmFy2PPwqrBlYa9zKK1OgvIcTQ+WIXJP89UIg2Ln4Y
 c9hbSFrFk7hik9eSmX9vPEsL2DyEgJt2lpH7CrDhc8dCNSbBDLgXYwyr1HxSQ7IB
 Z9PysOBXEWsBL3k/2l6vG+7U0+585Wilh6B4BRijl9MOMQAiWZG/Lj+UFVk0qgfG
 ETsWtZgbz+MjMbfkBc+To49om/c3torZjcA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh84r66j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:08:41 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35a0998a441so12507905a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773403720; x=1774008520;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IGOT9fD2d0q1zlnv6OnUTILWf5Y89gyMTfAEqWAQqBU=;
 b=FJWL6o9HxJCDHWbsQPKfTqzWon/q0JMI9lzOIJ/rN12bwpJ4KLenVn1fLjs/kt5WM0
 8Uqcej7Hip+05TP2OiObkt2+TsTkuBiNrS6iI1ZO+yy4OB6dG/ktqG5Yst/1BmXEhqvZ
 usuUduHb3ibIfRC3XcjWAFb7lnnCR5KNb+XOtgvGcve6UN6Mu25Ss+8NfR1sBsHvZGfL
 jhVspx0az2Mw2XE6L4YRq98hpoChv598wEd6VURJCIqEfGVMuXKn5yhFWTseQzvjkj8T
 JVRc6L1///MpB2DnaDR5BkyuGw4AO2cIp+2iUTZRT3YMTlZpRfTLgAFmMAsr6yKxWdf6
 S4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773403720; x=1774008520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IGOT9fD2d0q1zlnv6OnUTILWf5Y89gyMTfAEqWAQqBU=;
 b=n10vOFxwApuOFnbCRfsg+upQ5FHkSSfYCwQEwQpnH/J7cQeBVOxJ9OTHk/R5APqMLc
 sLHR9LdUwZqaSKDUlFhJnnCuBuDfzwUEupBEqYeT/7jW3IN2C+PUkRaRQNDj2tivuxBZ
 +kemQuAXBRFvQLvmET80tnX0L2jAa/JB5TOYIboZkit044iDHkLYWF6/XRjc42X2k6EC
 AkyR4NclQ1DeR80Jhf/bSs6j6k+x3zu5EFFW3sNLHvb4oHTpjPcMECQuVrln1o2hIZxR
 bDIqBqmpOQK6i+gDvKkY+9wFUFW8PEIps4T9vEAdTNYBmnYF4YtYNLLGdgi2BvmdecCr
 usFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGPDkm5g1SkOdpXsmlOk+jBBsVnWunBlXkDvSpxeYDQjOb7V4V/5L2jLFDp9pnYdkneEz+ceIfZCI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpIFsb5oSHzy7BtYSsmpVCDlMMDD8wwJ95YR+c2DNcFCiTIvxx
 e8DCEhfcaBEoSB2l0ZXllhy/1nnkl5tZPgDKRUvpkJhy2sB5Nx5ekZuQIO64jveF61WCsKgyYBJ
 aGCM1NAddp53zOR/LfDvOOGTch10ofOjiEsUfIfwOiK35cTYG5B+jbEkD5KxQWY9kybh4TYo=
X-Gm-Gg: ATEYQzwELVquhrqOrSvY/Do2K4ohoyB9XNVKYByBkdfgIlP/mpRte/msu/zxDaVJQll
 qnwzGXAbuA8Ke5CiPwmSYUC+qPlySS4nB9stVjDYd5j0JqS/5et+DZ5RLzGijLI3euHPhVcY4TD
 P1ZuqZsad5cPo9l/HsmdjccH91beRZQ1/YraoN0GiJYl1EHDLAGDJX7Dp1wuWJ2kkexdLvWCyFb
 w3OKGTnHxpyOzk3EQPVJazJkvzNBOpfrVChZIvXK10N9Z2PeNOkvEIHbmeRo3n4y8zDyhzTuHYs
 IpLo5XXMUAXZ7qijTM8HZ7mfI1jWj24vU37nl/Mo9wujl9NslD8d7o/GgddTP9lyKGxEDDbAMUw
 yyH7hwnSJc2zr97yeliZsjdK1F5ov+Q8S1V7s8dZ3yq2PyW6teEdZiIaq04NExpjLBJVT3K1Plc
 VTrh0Gx/rvYPbajef1GspENr9jUm4v35+h7CKu
X-Received: by 2002:a17:90b:1c08:b0:359:88c5:3add with SMTP id
 98e67ed59e1d1-35a22004c98mr2877059a91.19.1773403720378; 
 Fri, 13 Mar 2026 05:08:40 -0700 (PDT)
X-Received: by 2002:a17:90b:1c08:b0:359:88c5:3add with SMTP id
 98e67ed59e1d1-35a22004c98mr2877014a91.19.1773403719854; 
 Fri, 13 Mar 2026 05:08:39 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e18f0asm8421945a91.1.2026.03.13.05.08.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 05:08:39 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mani@kernel.org
Subject: [PATCH V5 0/5] Enable ADSP and CDSP for Glymur SoC
Date: Fri, 13 Mar 2026 17:38:09 +0530
Message-Id: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=OMoqHCaB c=1 sm=1 tr=0 ts=69b3fe49 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=9v-nsc7hOUgGWHzJVNoA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NiBTYWx0ZWRfX591VO4Y8OZjz
 EddlG1ox5022+absHt95fHT2Sv0pVEEQLGvNc78FvfSR2K504AWc0rhrcp/RbwpzDqcroGIo3UR
 5QjJYzmZb4kC6j3+tw4+ny6TwI7l+XTkt5HOHCpuCy3hmLz9OtaTD9ua0y8wBL1LlVRm6v8uWR0
 xI4p2r1SnXIBQ/XDlUd4wNoA396BdrwsVmRFWWIa1pmBN0zOEe2ax66Ln0mJcyGsUe5JLGRZY35
 r6NId8V8n00vmvAgCKxJAEGcJvZyKtDbH/N1wu6McwCbf+geveIEUo0EKLCIQdwLYWgmtdr/vdu
 fm+gzvaU0TVjqKw02LYHqBXqKYub3UyKcd4sDcv5P9ahbYsHfTIb/7OOaW07dQsdeehollwlM6O
 Wop2ls2ykKzrfTXpeUoFO6KtURyhw3Jp2tU3mTFmGcs2kwi7PDOYt+Hu8R36hSwO7buDEWDkewI
 DeDojqnXaPYKoP1KUNg==
X-Proofpoint-ORIG-GUID: gVu9tau1tYorhIIwkhFSLatKDoTlUiOZ
X-Proofpoint-GUID: gVu9tau1tYorhIIwkhFSLatKDoTlUiOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130096
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

Qualcomm Glymur SoC variants predominantly boot Linux at EL2. This means
that the firmware streams of the remote processors are managed in kernel
and not in Gunyah hypervisor. Given that the Peripheral Image Loader for
Qualcomm SoCs now support running Linux Host at EL2 [1], this series
documents and enables ADSP and CDSP on Qualcomm Glymur SoCs with its
fastrpc nodes. A few variants of the SoC are expected to run Linux at EL1
hence the iommus properties are left optional.

[1] - https://lore.kernel.org/all/20260105-kvmrprocv10-v10-0-022e96815380@oss.qualcomm.com/

Changes in v5:
- Fix commit messages (patch 1/2) to accurately describe compatibility [Krzysztof]
- Link to v4: https://lore.kernel.org/lkml/20260310033617.3108675-1-sibi.sankar@oss.qualcomm.com/

Changes in v4:
- Fix SID used in ADSP/CDSP for correctness [Konrad]
- Link to v3: https://lore.kernel.org/lkml/20260129001358.770053-1-sibi.sankar@oss.qualcomm.com/

Changes in v3:
- A few variants of the SoC are expected to run Linux at EL1 hence the
  iommus properties are left optional.
- Add fastrpc bindings and nodes.
- Link to v2: https://lore.kernel.org/all/20251029-knp-remoteproc-v2-0-6c81993b52ea@oss.qualcomm.com/

Changes in v2:
- Combined into Kaanapali series since they are fully compatible.
- Link to v1: https://lore.kernel.org/all/20250924183726.509202-1-sibi.sankar@oss.qualcomm.com/

Sibi Sankar (5):
  dt-bindings: remoteproc: qcom,sm8550-pas: Add Glymur ADSP
  dt-bindings: remoteproc: qcom,sm8550-pas: Add Glymur CDSP
  dt-bindings: misc: qcom,fastrpc: Add compatible for Glymur
  arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC
  arm64: dts: qcom: glymur-crd: Enable ADSP and CDSP

 .../bindings/misc/qcom,fastrpc.yaml           |  11 +-
 .../bindings/remoteproc/qcom,sm8550-pas.yaml  |   4 +
 arch/arm64/boot/dts/qcom/glymur-crd.dts       |  14 +
 arch/arm64/boot/dts/qcom/glymur.dtsi          | 286 ++++++++++++++++++
 4 files changed, 312 insertions(+), 3 deletions(-)


base-commit: 5c9e55fecf9365890c64f14761a80f9413a3b1d1
-- 
2.34.1

