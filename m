Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD95D39410
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 11:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3700A10E3FF;
	Thu,  2 Apr 2026 11:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VY3Uv9Wy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QVcAMaBq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A972910E3FF
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 11:45:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6328d7Vb1249375
 for <dri-devel@lists.freedesktop.org>; Thu, 2 Apr 2026 11:45:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=y5+v4Zjh95FklFgUEdPfXc
 2Y9wfc9QEHDJMzJQm9dmk=; b=VY3Uv9Wymapg/G+K2IVYsU9anyyvptSLK7qz1M
 NaL2N8ZIbsmTueS+6iSYDmLkhT5hZ6FoeeqkD2JWXSyHlC3Fg7mU9rejFgLC4/JQ
 v4TUEOaXTzXgs5dOBvjbocMs4LXB6O1YQXikC+B77Nmn89olin9OYryqThcehdgg
 HvJ0Z1fmLO/w3uRbk3EXORwXfl4cBJhTMdISzDR9fB+p+uLsPikb/3ulvP37P8qG
 r2lzAdFVkQMD5B5Jh8YOjtTuivo+ogZzxj/ZaK8eDZy8wIOw0+WP0YBuPRiP3Xib
 nJWOPQnwgqZJqs9JYiIQtznbV5XCyxKW60+N1ZMsNWARCjhg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9n4t0qya-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 11:45:26 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b323c43fdso16785501cf.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Apr 2026 04:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775130325; x=1775735125;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=y5+v4Zjh95FklFgUEdPfXc2Y9wfc9QEHDJMzJQm9dmk=;
 b=QVcAMaBqmtg91oivS5MmnzwKUHxb0S5VfvYirbfUt+GBfUdKrY7o2sJ7Knqz014IsP
 Zr946SbQtYOAtsIeq47jnbbTNkIT4LkIOJwAMpVdxMY7Cj2P5lEg3X0KFddrmI9H7GWh
 KkIc4o98lxyqoiYh4w9MrI0DoQiz+BedwSFZ7aNq8UeC/7AZsjhDdnD/rIPL0Cm5Scrd
 Yg2e4usGYB/Q9D35lWZchZfif5vs/1ITD9uGlXCOXTe50YA5nRutk9qS/El2GGFBoX2w
 N6ym8laWDiA/Txzzkg4g0kFZJsg47ij46Z5//aZXqsfkCvdVXeDQBcwr+uYNc828TZ9M
 FjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775130325; x=1775735125;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y5+v4Zjh95FklFgUEdPfXc2Y9wfc9QEHDJMzJQm9dmk=;
 b=sq9sWtIU0gil1TipoEJCwHZrqebUK13U6hqep9zZzJSdvKLPpujBEUij7Q6+50jo0g
 UF/qGeTy8tzVGZXDpRiUmVU6swHUmm8WMuFlVyZecn2rB9E46mwOdl6sDqvZdeayVG+n
 hYhb6bxvmaeQWNFq7fV8kz78zqFqj7LdZLmxULiIsujTO+OPgjwngV7BXnNggifH6m8O
 v0QuUoBOHh3NTjF3z92JpsnSvOFTl3v9h4w0XeS2UFg0H/lNOTudms8J2HR8KQKMgsGv
 hn2jQAJPQmYC0ZLIN2dHKILHNN/ggNmtHxZF7wNULzv8GUiRwCgHDP3O7DBOjZVTTosT
 /iYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOnTcq7UbO5a/dN81hm55XW3PRf2nfp4h7aM01Hb6gupPM3dK4aLQvBQ/iYX+T4jWF+dOCjmX4q/s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxt9xJdgdML3umpdUkRujyQ981JU8lZKRUKL/AsW5o6oyAZp/TR
 pMhYquK8QX6TGZLaaLudro8vAovodwXICLTRsrzR7Jyq/aEzjTIEg/2oGA6H3j4yCOjVMOOJjZg
 dKnsFPjK2gIwqYyLA6N4D1yvhK/jsIOSpJDC/7oJF2/nv06xKh/H63z7nzoulQAA9LiF0WBE=
X-Gm-Gg: ATEYQzzdPMQTlLfUDYSGq3CnZe9OiPvEfS760w1jBnIx25ydLRKDulrMDTOJiIYx8p+
 0frYDp0i2y4VfsGmZVcBXGPRPuFRJkc2X/R+M7IvgUS8mKjpv60aVW12jw5EyBNauNhpmYvEPnq
 NGu+93QTbyVubUAXNt0oZibq9LUadM3Lw7opl7yneCniHRY4WUZTXw7ByLeleVImzTsUaAOxt2u
 9YX7zDmrBnG/e4MfwvC2hYGC7OGHWjLdjicRSauEU38bem8pMdXccoDTBGgz8L39Hf2M45s+iRD
 BB2caQrLqH3QrilxK3TcAWgY4NMzenrFIRhUFBhuzfjQyDhbq+XuDULa4VUBpsniHCWjTUqNCNT
 6XM8G6kaRMC1YSWuPiQQeEk3secLbQtv3VFhu3cTewFlp
X-Received: by 2002:a05:622a:9d7:20b0:509:1dc8:e9e6 with SMTP id
 d75a77b69052e-50d4ba33ffemr33804911cf.29.1775130324940; 
 Thu, 02 Apr 2026 04:45:24 -0700 (PDT)
X-Received: by 2002:a05:622a:9d7:20b0:509:1dc8:e9e6 with SMTP id
 d75a77b69052e-50d4ba33ffemr33804351cf.29.1775130324469; 
 Thu, 02 Apr 2026 04:45:24 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a567bfasm141614635e9.0.2026.04.02.04.45.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 04:45:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 0/7] qcom: display / dts: Few corrections of address
 spaces.
Date: Thu, 02 Apr 2026 13:45:11 +0200
Message-Id: <20260402-dts-qcom-display-regs-v1-0-daa54ab448a3@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMdWzmkC/yXMQQ6CMBBA0auQWTtJpzHFcBXjAtsBhyBgpxoI4
 e5UWL7F/ysoR2GFqlgh8k9UxiGDLgX4Vz20jBKywRrrzNVYDEnx48c3BtGprxeM3CoSBUc3cky
 lhdxOkRuZj+/9cVq/z459+s9g23bLsLYFeQAAAA==
X-Change-ID: 20260402-dts-qcom-display-regs-11d61816e172
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
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=4RtJ3X9urLWVHamPANXERFdnBs08cDu+q9rF8QaPqJg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpzlbJXXW+K6dditLlEMovL9DdkbYs3z2C01oPp
 WeCIOPxPESJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCac5WyQAKCRDBN2bmhouD
 1zotD/sGZigVnivjw7TmGHtsengJ6zxMrySAYKWLRwprUUV965Sky1jj910WMb0Lg+VpsTVPNMv
 ulRb1hDT0VZ/4fiX76b+5DX0EMVOJI8HGu8PnGl2yhXK6yc/p4jCguctwovS5lOR68APakxHyRU
 6G5KXH0N/TKogzOe6IV4EOmKKXYd0XQmE0dUHFQ81F9XPgr1wklYuH1WclBjq9+prMIWdajeZW8
 xoUgXfSp0Jd4YN6EvvgRxTuDa2k78EdTHfpK9i6xHDG2IYCs3BI8z+cNwJMPIzJhz7tqoLRrO8N
 vMv0wkfsprhJEIwZwjJnzuffp0M6zwTXiwvrkgImSC5GVMC5XFjxgVBeaivryaLYd7XVIXqNIH5
 bkLUYobAgf6ORS5RoeIbnMaNzQpsf8hWtIT9CPtAY2wy/CvdTm2ij7NpOzE5kMisZAYT+qWcsYX
 yNyduI4FDfXkCVX7HZDMY5C2Na3LK1SNU8lmUmRPQHi/rmrgXclcKXny2U2zprZhx4UCo6x1E85
 9aulgzjSc/rSjH8cezL2BkAle6jJBxinJ6NrjLDT96sIepmSJuzG4vz3GecgNRn5lyuIB5VbqrY
 IoyBQ67gjS6i1zKNQQqa4uxoalqX6bCRXaMWI4IKMhkQ5HRERivuAAceX+fPXWmJlcRZvlMn0Vs
 E3Gfk4290VnP6FA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: w9deh5bW6YrXNHdVOHlHUFPiQfmTnLGp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEwNSBTYWx0ZWRfXxKpqN8BFmaFg
 MJuNE3qAnDri3A5UCQAak9KeEqdD+U64TyrQgZu5EtKQSHaES5r45N5Lgfc0A7YcFUxkBixFmjx
 /Cm7w4PpFraPXUO5OZXxL9NKZqbX3I+Mbjdd/mcr0fjoL+LvzQSohiRnoa1WqUJEVXweyFonpAU
 BlVszUCjMFadA1br5uwgH2ciXBr0tiOw2a1FqAN43e0a8sMhskeRhJjoUtMlF8ZCCqnOZzYdyt8
 8Ijwr5aeEBwhH/st+jIWh0pyLvOSbZl8JylZINQkMtx9sGNJFDUI1/QB/ItqddfYUW1p5MGFzE4
 mrXvYe9BBmPF1Sh40PK2gAdQfoUSLqJXgObiJ8jEgyhfojQAevm9OpUgzWpLpZKmYOzx2tEGhHs
 v55hbeFvms2d41scJRll7zGCAMPGDRW9VdsiYwx/DzJQYeYC5+vDm5mxuHd+LGVR1er2rDWs06e
 NBX+7Vtjp9iJzTAwLhw==
X-Proofpoint-GUID: w9deh5bW6YrXNHdVOHlHUFPiQfmTnLGp
X-Authority-Analysis: v=2.4 cv=Ap/jHe9P c=1 sm=1 tr=0 ts=69ce56d6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8PK1uE_par-WY5z1x_4A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020105
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

These do not have practical impact currently, but make hardware
description correct.

Patchset can go via separate trees, but DTS should wait for bindings to
avoid new dtbs_check warnings.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (7):
      dt-bindings: display/msm: dp-controller: Correct SM8650 IO range
      dt-bindings: display/msm: dp-controller: Allow DAI on SM8650
      dt-bindings: display/msm: sm8650: Correct VBIF range in example
      dt-bindings: display/msm: qcom,sm8750-mdss: Correct DPU and DP ranges in example
      arm64: dts: qcom: sm8650: Correct and complete DP address spaces
      arm64: dts: qcom: sm8750: Correct and complete DP address spaces
      arm64: dts: qcom: sm8750: Correct DPU VBIF address space size

 .../bindings/display/msm/dp-controller.yaml          | 20 +++++++++++++++++++-
 .../bindings/display/msm/qcom,sm8650-dpu.yaml        |  2 +-
 .../bindings/display/msm/qcom,sm8650-mdss.yaml       |  2 +-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml       | 16 ++++++++++------
 arch/arm64/boot/dts/qcom/sm8650.dtsi                 | 14 +++++++++-----
 arch/arm64/boot/dts/qcom/sm8750.dtsi                 | 16 ++++++++++------
 6 files changed, 50 insertions(+), 20 deletions(-)
---
base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
change-id: 20260402-dts-qcom-display-regs-11d61816e172

Best regards,
--  
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

