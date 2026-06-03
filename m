Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4E7CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D29E4112782;
	Wed,  3 Jun 2026 15:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GGS0WfoC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T4YmXltH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28769112782
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:00:06 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65396BM0781033
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 15:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=; b=GGS0WfoCZgeHzqnl
 hw8vxIT23xX19xU1PnDB2cO6B75LrHO87VXfv1DKd8XjSbhNH0kwKiBv1UoOeo3f
 ssrPtwoOOEBHX1PH+wVbAtGsS/0Xwho7H8jgZGQzE2nCWf3BnujxZOLELrwl+Nz1
 K40mw2BBnmDFTAndAZ4Djp4UpMEoxfDxUdWax/x0YQb8Ie4uxItBIBvY7q/iKMoe
 VFQxQVLAA2eTrOwe2ntQibVK6otdNWkUT+F9/LbvC5lHfmH/lsjfOrw9M+TYhEmp
 90pT85AWiTWdQT5odpQiRn4MvWhSEO+t1sLyr7zwKqaPuMt/X+9xpAu4jNHwtMXM
 W56/Tg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb1d9a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 15:00:05 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8422b1354edso5135912b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780498804; x=1781103604;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
 b=T4YmXltHxgnQ3syKMLbNjCCQaWx72BbbQ8eYGJ+DSW9ZgFEkFMZz2ZLccZuTOOgJzI
 +xX1SRQ3kr6Gq0EJkBcr4qDRbtkr9F6NMIVC3nlRQIR9hIqXIVOus/n9QZ6JvavYxUkN
 sLgPH/hrEetCx/22bE4GU2VAbnb/M5lrKCjQqi89n0Ueju9m3iNGo799EFpyJEivwGU+
 IRb3qcIUC9fl9e687EZqe7f4TruTkhKFCh6ALmkKmr2V87OOHX1ffdzR0JUH10zKQfSX
 J4Ra/zp8gVP/LKtQyN5kMYVr1rY0rqU9AF8PXPCLKkSUly7l11zl3dzLuo1Z6DEknyDB
 h8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498804; x=1781103604;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y6UZz8IjVdVITbvOPHhdrUuJW0/kbNYyuOsWRAfVo8o=;
 b=ClgHezOBpKp+766W7ozMmUfOptPaWlm/SQvXO/SX+CMyTnROsDFEGrxmN6ijhaRJpH
 uSryFdujLD1qxDxLkvWuNcFYenRXHiFbXfefrfzilTplzRhystHvm/1kM4xfcfvAARg5
 KdOjkJZvSF1EEMUS4K1YMLpSaLqI7RN+GWr2gl6dCdfY5RkTklMmMIRop+iAFiTcSe9v
 IUIWrPIIXLy5f1XTtnp2LaiWBwtOWsdWCwqIRHhor6tnp3UJZIlM4jZQaxuFT5u1Bz7U
 0OmPq4zgJ2oo5TVh8mfmscYb+05N3CmtJVbjN30YefMj9TndSFlgd0EbhtoM3GFlVdbl
 NQ1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VK7PtSPqUk/fLFRivIE2JbhEXJ7YVcq6rXXh6aYH6Lf5YoNa7sscrvvFpHPnhbfPr/aBKw+UNyuo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBNpj5zGbSVPmFy1DpocbmFREWA4nn04EXc+kJ5KsQocaKohEt
 Zre8rnVQAcmGWgfOUNboRZr0jgNDLQxPGn+7V0VPW4zypHwhK7m3We5RDBiBeTXYjUf4xtzri9M
 PAuyuXstR5Ld8TSUlKsjfqAUwsT++IV4LHoLxWkFgXiUe3PRsjf1cbDSjnmnpPJEE4BsAMx0=
X-Gm-Gg: Acq92OHmdayzqK50X8t/BtA5vlNXrLjWfcppV/2LgbnfzI995nXGzZln70vizCfBOoj
 ck/3sa+awPfOOF6oIaWxXoBCXVfHA4GFC8KD6iM/Z/BZSWC6ldkptM8ppztU2286mXFgI2DQUmM
 O/PRMTfO1mQzqN/HeHPriuwfwFEc5T1Drb+3OAi9TQKH/xuzHoeH2kmRrQS4qyB2Fnxg8WuR2VG
 BmYv8x6D6AGdTq1RyapZBf6FebPf13TnAPTP4Abr13x5bIrIPenac/k0F1Q4xP3MGu1XjEhX55T
 zRDPw5Dg4pyPfnqUdp/BYV31Ng4X3QcibG6wZj5H8DHS91+jFjmSOg92FN/uI78E+NA1t3Ds6wr
 ObDXSCh9Fscnln4Qw5s7m7mkEjIfOx8mYsOaAoLdgxwT8pLWR9oyshgdY9uU=
X-Received: by 2002:a05:6a00:3695:b0:842:48ae:1d43 with SMTP id
 d2e1a72fcca58-84284ee8c92mr3870635b3a.23.1780498804268; 
 Wed, 03 Jun 2026 08:00:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:3695:b0:842:48ae:1d43 with SMTP id
 d2e1a72fcca58-84284ee8c92mr3870595b3a.23.1780498803819; 
 Wed, 03 Jun 2026 08:00:03 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:00:03 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:28 +0530
Subject: [PATCH 3/5] arm64: defconfig: Enable ILI7807S DSI panel driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-3-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
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
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=708;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=SCs9KQKBtzRapnZIGqIOvP+xU2+TnEvlesLmeM6sxt0=;
 b=gUg6b8DX/BHqfCi1J5KoY5oWrnsM+HG3We+0qp76rEwPG/U5JUeiHQ71ZupKip7+1WYpddQA2
 CnY839GbgoyCf7ysCC7p9za7OOQ7Q8Ys5N6TLLl+YlfMU9KTqS7JKzv
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: 3KZHOZc6LtEa6D_ge0DlF_s58q3aDZhJ
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a204175 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=aMhaXRkMA95IrCOZcTgA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: 3KZHOZc6LtEa6D_ge0DlF_s58q3aDZhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX+Enlfw7+REVJ
 e7H/uy816uQs/FxKOTujH7NAJw9MJvmZRMZQaSQRIKIVVOFHEKxr1HY8uXHzvWU8vhHRqd5WchA
 zSE53w9OkgoTMxTjF89cnvz6Rqi5yaGDQicx5fPokS5NnWlrhKADdbaqSVvH9/yaC14LTRaKR9P
 oiY0cl+74X7NxnWwq14gl6BxR9Uc7X7juw7O54szOGkJCxx0zJvJ3WpalCUmj9eebLjrPGniH76
 wR8iMploiXZ+jaTROQSH65PJNS0sif0lLRlBIrgZI5A/FRCaAuqN8AT0Nk3S9B231zk9osBBsiB
 mO/t7Ce6HdjBcjRHKi5pcMaQ4qzxWvaq7I0zvsZimy5kJdszxWaar1SNdyc0tRTO29iXW4nkas6
 ++PiyinelWktV1bqBfJeEjt5DFdmsyruz39yG/qelNMuZNlhx/B1BtiYBPDtjTgO3Lv68Gy5RVh
 kicYeVqbT5ddf+ct6pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030144
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

Enable the ILI7807S 1080x1920 video-mode DSI panel driver as a module,
used on the Shikra CQM EVK board.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 909f3c188e75..a6d72ff63e57 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1005,6 +1005,7 @@ CONFIG_DRM_MXSFB=m
 CONFIG_DRM_IMX_LCDIF=m
 CONFIG_DRM_NOUVEAU=m
 CONFIG_DRM_PANEL_BOE_TV101WUM_NL6=m
+CONFIG_DRM_PANEL_ILITEK_ILI7807S=m
 CONFIG_DRM_PANEL_LVDS=m
 CONFIG_DRM_PANEL_HIMAX_HX8279=m
 CONFIG_DRM_PANEL_HIMAX_HX83112A=m

-- 
2.34.1

