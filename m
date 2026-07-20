Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1156C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ED4210E816;
	Mon, 20 Jul 2026 08:44:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LtueaTd4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qk7x83To";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432FD10E818
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:10 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K76WtF1712996
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=vvlobRyAUUhK+cnGAKOkDW
 R7oCT3DTmgfyrHEH92quI=; b=LtueaTd4vL0UnA93YkUSSJIVxGLnVUXlcW1NxQ
 Kx03ofOrLf3wO6B4wkJrzpZDr8jSg7NTtTPqklG6cMyEoghaKuR3y41vzG0yLB/D
 5T8lX93OwS3h0Tfy4YUmBd5ZJCjTgry8lfwHAgPP8lcvOugxFqGC36gK11F1FAV4
 6LZkUvrCQvUiPK8lqTaII4Ybaw8iT+xEzSUi93//FuPoWh0nCW7qV8whG0FCkhrp
 kIaIEPqd49ONyIpdfudtjfnyk3T7sYhINX4w2ChtVVQd2jpStCGwSzj4dsAjNZC0
 wHcO5oO6oD+jeMCw5vy60PMPPBmIBRHJuMeXBPjmET37utqg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0c0bqx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:08 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0867a75ecso85024116d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 01:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537048; x=1785141848;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vvlobRyAUUhK+cnGAKOkDWR7oCT3DTmgfyrHEH92quI=;
 b=Qk7x83TovNzD/GlYrrJubs+nxNkCYqJoD6UdnEVgxPohFmuTT3hsifd7mYJ/Wa4VSS
 61rG88IevtX5otavTGsifbdFvWjBBDUT8MBa9xhyZYk48tQsde/eQz5LTlR9EXUXA4L4
 wTbZYmEThu6tsvRHOrzylwMx+siZMriR399fwdoEfxdgkiCrXUDjQ5zAI9l+b6D1YAeI
 HcJKVvwqjiXvw1efC6B7FxhTJifseX6pdwc0WHcA52TfWCd1MYRMwccChrIZYIMbYO2N
 lHpiWZF3iPC0nINhiOYakMoPW2XB8sFiQ9r65HCZZF26e3fNGn4JgnSyIHFyXylF/1ly
 9BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537048; x=1785141848;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vvlobRyAUUhK+cnGAKOkDWR7oCT3DTmgfyrHEH92quI=;
 b=Q6yBb6Bxsjko6p/Fz0M42Cph8vzMMJjoIU3/DFKaRXjaNdjE73kmQtNevqc7+NPgh2
 b0LjHfuwYwuTwRVVCqzaZg01RAyqhjNe1ShUczXMN1t/EJPhhVfmk1adgufVD0mRbFFF
 mqXY8rbo4FquW5csJ0tI4LugwmjuZsx29NYigvxb/pdWp226LUxTTDKeHDuq9SpUV66U
 H8BSNPn96EbJCuvhyX2UdJL+CJeEkLoOlHzY1WrvHTaoPc4g5U73+HasPnQ6vHpdvgPV
 QV1KgWtVxoPjgTYDcK6BleJCAMtomdm6AWaZNrsx6Pt7pTM4o8+K+D8qivlx/P55cJ7S
 YOTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNkO8lV69vFkdPPuWOY52otzpN0SakHamc7zTOgsEJF6HUAWR3oTGPe6rY/ufoyacDBAKQzT2CpbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yznr5T3J34rBdFWN9h2fD1FaaGbeAnS0iweU+ET/0JtJJg+rn/L
 B5Q3zHFlxsMUKe3aCkr0adF9pufyXKVcoCKSP8EV9KsCnXBAk2Bu3bF1p0U+6rB9Qp7uTKVI8Zf
 nXHEGfn6AyiMgLcnCoEWMhwV7iY8mExPj/ZmjwNyYAASY0158cnDL2nicpBemGsAYQlqGuAU=
X-Gm-Gg: AfdE7ckur0nB7uZix9jD+21Ls8aLHHxFlvVCbysinYh4Q3whJd1fK9LYUZ1dTuU1RIW
 WJyrVvAMQSxaLXL94Gp1DrFfOAR/548+yl/TIt0mawKUdo3RorVQA3dqLDhJbnj6vDa2uFwVQrF
 gQS/jTFCO6+qwUCcY+a7BoCbs2RaRV1zLvPJWcHJueuz3JY9TNdw5llAC35teFlgrED9uHrWcQD
 RkOzxGafeyCAkpGHBJe1/w1BrLqM1hkd4K0CmJXhAsz7UQdfVENdh94K75ghQNsn5qkk6+T/T4M
 d7HjKQjiLP1jGwAl+s6r8UBOtinJyBDSOvQL5ih9K6fL9KtO/hXtli9F54t6fp2ITeMZJj6cFyE
 m6EXAxfMWSy7hSprYCXY5sI4uMtTG2Q7sOEnzEXT0EhhtEywPMLNQthBSgdg/Bv8=
X-Received: by 2002:a05:6214:2608:b0:8ee:6442:833 with SMTP id
 6a1803df08f44-907783bec64mr141899796d6.43.1784537048151; 
 Mon, 20 Jul 2026 01:44:08 -0700 (PDT)
X-Received: by 2002:a05:6214:2608:b0:8ee:6442:833 with SMTP id
 6a1803df08f44-907783bec64mr141899656d6.43.1784537047774; 
 Mon, 20 Jul 2026 01:44:07 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077871f650sm87061716d6.45.2026.07.20.01.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:44:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH 0/3] drm/msm: Enable dual MDSS power domains
Date: Mon, 20 Jul 2026 16:43:52 +0800
Message-Id: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjfXWoC/yXMyw6DIBCF4Vcxsy4JDgriqzSm4TJYFmgF2zQxv
 ntJXX4nJ/8BhXKkAmNzQKZPLHFdKtpbA+5plplY9NWAHCVXyFkq6TH74pA5q1Fwjsqgh/p/ZQr
 x+2/dp8uZtndN7tcI1hRibk0p7mNjiZQUvg+ia63WLnQKTSDb88F3ehiCRCOdaWE6zx/CGvvLp
 wAAAA==
X-Change-ID: 20260720-msm_gdsc2-cb9230027a2d
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
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784537040; l=1345;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=GzRBa/CpmHvPCWeBD/1K7jRI5LN32M9YssWSaorgAWs=;
 b=mMBKRBvO3BukDTilK1sJd4kFQW7fRML5r0v5GGbLwKmyKF6h8k9wsswegPqFaz+QRfADzsnTW
 0+OEUfir98yCUc+417vn0duLDpM1dydRqJDtD3koxo+kaE1QX3FP42+
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=HeYkiCE8 c=1 sm=1 tr=0 ts=6a5ddfd8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=zZWzZaWlDQgj5UJjSeUA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: BbPeLKfpCH9G-6Gb3oLsD3ZZa1XzSEcs
X-Proofpoint-ORIG-GUID: BbPeLKfpCH9G-6Gb3oLsD3ZZa1XzSEcs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXzNwq7Ue1/zJ4
 Bs6XxtDbh0JfGEzWAkw1oX2KbcSd6GmNZurPIlLDi8AnZoRoWptCME1fp8H7LP9ZL2S1w94kxG7
 Ko8KnqJAsTE81dhYIpRCum8/2bD7tZg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX5EhBbRLx5SMp
 QwrwEsXJFRhfa1JSMjk2iGh67aB5yDU9NPBWNCQxsN0/My6iMWQUh78bJG8NJ3s2WggwJgLetuC
 RkbXVdGC2pKGf/LLqjzFdJS/S1Ocvde1yy+OQhQjLja12Csx12FDVfy+Vq3ZDe1o2UGPZuzchcZ
 7eAdOVqXequWmzLeF0qpec1G6ShgEU1qZiOd1oXJ7py8m01+CUwQIzb/ybhKudUpkmnOGFrF2Vq
 0najBb0M9k/ZTMHMc5wyK1CTQ6P7ASXkukX8Y5YG/oTdc0t8uF+GMJo00zsRMyA5ryIKy2SiuJL
 wZd9xbq3MjcQdryJ/MeUHGUlAs8z0FdVBGUKFxzaFpj+DQ0CGF6td82DD8A1BsWSA0OmkEK0xWZ
 AlSSlI50slbrbHwyI4ykhaK+BafuRY8wd0r8vPqIVTywFyUSHXRPuRYMVdtrAmSYpyHjL6LvbWL
 uCv2xz/QA2Aai5/+iEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096
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

Kaanapali (SM8750) and Glymur use two display power domains.
CORE_GDSC powers the main display hardware while INT2_GDSC powers
a subset of SSPP blocks.

The current MDSS implementation only manages the primary display
power domain. SSPPs backed by INT2_GDSC therefore remain inaccessible.

Add dual power-domain support to MDSS, update the DT bindings to
describe both domains, and add INT2_GDSC to the Kaanapali and Glymur
MDSS nodes.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Yongxing Mou (3):
      dt-bindings: display: msm: Allow two MDSS power domains
      drm/msm/mdss: Enable INT2_GDSC alongside CORE_GDSC
      arm64: dts: qcom: Add INT2_GDSC to MDSS on Kaanapali and Glymur

 .../bindings/display/msm/mdss-common.yaml          |  3 +-
 .../bindings/display/msm/qcom,glymur-mdss.yaml     | 13 +++++-
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  | 13 +++++-
 arch/arm64/boot/dts/qcom/glymur.dtsi               |  4 +-
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            |  4 +-
 drivers/gpu/drm/msm/msm_mdss.c                     | 53 +++++++++++++++++++++-
 6 files changed, 84 insertions(+), 6 deletions(-)
---
base-commit: bee763d5f341b99cf472afeb508d4988f62a6ca1
change-id: 20260720-msm_gdsc2-cb9230027a2d

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

