Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B44FEA805
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E70810E065;
	Wed, 25 Mar 2026 03:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hG8HmLWY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FvY8DXwQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F1B610E065
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:53:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCt7k2808009
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=28PMbL2jvquYr9ww9Imwe/RUFpb6JBePIL5
 +Ewjv8kg=; b=hG8HmLWYLHq8hViQWi94tCFrHkP1CzBBWZF42wbEHLc+rcgm1wI
 FbsPJACY4rGrTsfCjT1SvIcAqmRYyYyeP7PjVJ25516/46jWMqTJb6cksWKFpYAK
 2nw/IgzFxSXnvQX/yuDFOP3jZRa7YoCgme/J5GQF8XM+Q1k2pfV8KE7JqfZZ/wxi
 U9HGKUXXaEo3rhqibj17fcQQkwp0hUKWajFi1u2v1PLNTwgm8doOEQQ0pFjOca1S
 vN5AIogOWW0+f8agZ3r5hORjtk0hhG6FRqff/asfD461aimzZBkvQmkxTQnHR3bu
 VazcLBgz1VYLmOUAO2BHXeBYZuDsJcHgALg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3t9ek6nr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:53:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c74217894d9so2754861a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 20:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774410832; x=1775015632;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=28PMbL2jvquYr9ww9Imwe/RUFpb6JBePIL5+Ewjv8kg=;
 b=FvY8DXwQZxvOhwvw3oCFr9Uwrr8XlipbSU31pTXWlk22nXtxhg7beXiBPFpk1+WNKP
 cxdo6qkOy2383zy046sCPNo3VY/NIxFRasiGiTXmPmMFTw6ybGl6dpfIRPclOcT35phM
 FPJppqhsUU3zLaC7DUqkAcvM7X87gbioHUSwXRQ8ObYb89GwYStUf7WlTmpaubpCxqKr
 n8CQJYeoecFisYkq5XRq6+xEilKxlSEACWVi/u80CvKuDEG1ihS20ysHhbehGpuC9T4T
 OhmaULWg/Ja2R/36QVEkpdWsUF1l/+/n9QP9G50BHVbEKXPVmi2cICYhPop/hTJh0g9D
 0j0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410832; x=1775015632;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=28PMbL2jvquYr9ww9Imwe/RUFpb6JBePIL5+Ewjv8kg=;
 b=r7gV9EiLLWFMOEcZY9978BPm1v62EciE3/iuDxEcImulQv/I5V9pOUa0dlhcI7yVwM
 JHBqxzmzAM3YtvcuvLYKWRDuRT/xecj4TXmvZtPHh8UhaOTlR9SjoJpPJ+6aXm2g3tgt
 ahBFSb93/WRuSoUtTsiuoqZtHc9Exhz7o3ozMsw5h8BWsLsxRwgkxeqqW1qfi686eTvC
 +Kitx58z2VG4gb0qndNHZZNDFiFNx0Ayv4j7DnWyk7T7TUU5DnW28SAhoZdGPpJcJDAt
 zIoJ4n0YdEIfrj+wUa+3AsuvbH5LKpODvbXpTs8LE/0CJOfWittMXZc9GE6vCx/451P9
 VFyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEo8Ynh12yFU6c+WrUY3YxulehSj0dHk6Z4GZOc+oX4NIi+A97CordZk1Dpfd65iA7aavs0L0ALjQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw11nB7FAkrMcah+yoh6k0RCMrM1hIEKCE6RCzguGU46vI27och
 EecNA7Pr/GkHkykgZfxM1NBLniW4h6AS679v1timmug6Ps4wwzrkMTcF8ARVY5UhO+doLNBy/tr
 +s0s+ZBhF/GtO5w3zkdyzaIU7+rtuyDo4qmsrSG04iI+L5zJoSS0aQKTUwMPpRvEO+TCTkYs=
X-Gm-Gg: ATEYQzypPoZwzqqm6R8tDvyIMywUapXSAKoplTEcXRdkbOiAfA0XViZRC8Nzj8wjoga
 6hT4jICY207VILOYFSv+o8yIs0iS3XMvajC58icvHN9Zt4NVM0eEUi6ebcwHOZo+oc8BxSaVzxo
 mgP+LjAyCVmoGcdMdmmgj+ypA8cnkIjOlLBX7suvnGKRZMa9JcrruACrDOwzgywC+XKkBq6s6Fo
 QDn1fRPa2FkN58s6nGV9dY8DaHomlspRSKoniu3Fh5+js9hdVWKRL0j7SZIgGM2Q7XzUnB5iq8e
 a3jvVT2xHFS0iMFMvJlvd+0HSsT3dGPDXMbTWlRn2sJhXl41ybsxHuQ+5NOfAHM8/fjnTHRVPNK
 MP7O34g/k2ZssA7IRclJQY1xkLwaDQJCU7ziGvnl1nKNizBt5qNCS8itvM24Ntdfbb4xmU1HwGu
 6Zlns2mJYscYuQwfdjliHFJg4G50R2keVjwqEN
X-Received: by 2002:a05:6a00:3d0b:b0:824:188b:c173 with SMTP id
 d2e1a72fcca58-82c6de8582amr2084387b3a.5.1774410831572; 
 Tue, 24 Mar 2026 20:53:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:3d0b:b0:824:188b:c173 with SMTP id
 d2e1a72fcca58-82c6de8582amr2084349b3a.5.1774410830885; 
 Tue, 24 Mar 2026 20:53:50 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0410870csm14220689b3a.52.2026.03.24.20.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:53:50 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 0/5] Enable ADSP and CDSP for Glymur SoC
Date: Wed, 25 Mar 2026 09:23:33 +0530
Message-Id: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: mPXPAytjaG8HRuZ8wYvqiIxaB0v9cF-e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMyBTYWx0ZWRfX4n6qCoHX/kD6
 XXhGRvMsfDd/1r24V8XzabK9g7TflXqvT5LahYNsKym1b/CHpp8m3OgVBYqeApNN8qIk0DGgbmk
 WGxxRHIP2erhVMlF3IRfFjj46R69Re7eplyTqrE+YKrCbMHtQaaKi9druQbf9luCRCCQX9pKaD6
 OyZG6Dch4tZPNtqQKGFpKtfQJwzp1+QTKXb5peuM86Nd191Sxg5KQq1C/Ebstc4h3uQxUPatggB
 dgBZxllWPYnDyQcR5xo1mzbJcg32mWvC79TvUFXkdDthneIkOneZBI7F53yfhyizx2lcSewn8I3
 nXg6ZA66GayHb12RvvZW04Ojb8q5x740WcMAeNc+/9O4zfcXXviQZSbEGosRZ3WWJTZ25MJkqRi
 XUtiUOBuzjPuMJ7a8rN7xRQ8F0DWVpLt2miPcLUm4ZXAhKmE5/RBsebJlDojweSYtUqTYlUI7w8
 spzfVD9bm1FE1eHeStQ==
X-Authority-Analysis: v=2.4 cv=DdAaa/tW c=1 sm=1 tr=0 ts=69c35c50 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=9v-nsc7hOUgGWHzJVNoA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mPXPAytjaG8HRuZ8wYvqiIxaB0v9cF-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250023
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

From: Sibi Sankar <quic_sibis@quicinc.com>

Qualcomm Glymur SoC variants predominantly boot Linux at EL2. This means
that the firmware streams of the remote processors are managed in kernel
and not in Gunyah hypervisor. Given that the Peripheral Image Loader for
Qualcomm SoCs now support running Linux Host at EL2 [1], this series
documents and enables ADSP and CDSP on Qualcomm Glymur SoCs with its
fastrpc nodes. A few variants of the SoC are expected to run Linux at EL1
hence the iommus properties are left optional.

[1] - https://lore.kernel.org/all/20260105-kvmrprocv10-v10-0-022e96815380@oss.qualcomm.com/

Changes in v6:
- Pick the audio series up. [Srini]
- Pickup Rbs from the list.
- Rebase on top of the lastest linux-next.
- Fix up address size and other misc fixes. [Konrad]
- Fix the ordering the various audio nodes. [Sibi]
- Link to v5: https://lore.kernel.org/lkml/20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com/
- Link to v0 audio series: https://lore.kernel.org/lkml/20260311124230.2241781-1-srinivas.kandagatla@oss.qualcomm.com/

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

Sibi Sankar (3):
  dt-bindings: misc: qcom,fastrpc: Add compatible for Glymur
  arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur SoC
  arm64: dts: qcom: glymur-crd: Enable ADSP and CDSP

Srinivas Kandagatla (2):
  arm64: dts: glymur: Add LPASS macro codecs and pinctrl
  arm64: dts: qcom: glymur-crd: add Audio sound card node

 .../bindings/misc/qcom,fastrpc.yaml           |  11 +-
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi      | 124 ++++
 arch/arm64/boot/dts/qcom/glymur.dtsi          | 549 ++++++++++++++++++
 3 files changed, 681 insertions(+), 3 deletions(-)


base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
-- 
2.34.1

