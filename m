Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C93C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C99910E4B5;
	Fri, 28 Aug 2026 14:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="id68aQpy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E9FFN70Z";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C6410F3F4
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkcxs3205200
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bFRrVkjQCFlDgD3LOxA8bXZmJYkAPm0glaH1elOSAeU=; b=id68aQpyNyKAhnwd
 0oZXVHKuWaRD0cgimOcDPOmukC6lv/JDk3LBha+x8RUEBUTP1mcJ6k4mGVzcaqYW
 qL3BtIcGkrvhQm+riKRs1Ci/FRfh3DLWPt3VwILNp7XsSWj+JZInZtdlAATqqO+U
 aQLxGPicN8jsYrcly6NrybD5guOZW2OSWxa40LTegAUU8smWrsriF9Vs6ZnmcgZl
 pezORIwcWqWLrXytLoDy9u3HgHuJXdhJWVQ46fY+cgVzERraK/lTS5jUb513Bc6O
 JMQu55/1ojJivgB3b/l8qISj9FKgMHRlsyDkK4lvJI2iwEanmXqDs6iclpM0uKP5
 TUrEsQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh110x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:53 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97cb32961e3so680629241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925953; x=1788530753;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bFRrVkjQCFlDgD3LOxA8bXZmJYkAPm0glaH1elOSAeU=;
 b=E9FFN70ZAA3661jFR6yitM2S270c3AldvkrxDPP13XZR/VZ/TsoZF6E2tifaTjHEpV
 ib7CQ28JbH1VGRf2KYc+LSkzxCsmhr0sOrmwu9QdBRdouHreCglhF5F6RR5KNWyE8hiY
 L+Fzpfzt7ICe/YHFKKF3IFjnzS1iwZtFqIpyE4dZ2upZIRI7xi+ggJQD/26Bx63M+e+A
 7xoD0RFr8XvteMHkQBRwhQ2ayInWQSV3Zz5zI2ceMvHs1/MYAhOgzLbrD7wmrLkMl64t
 JeLsMQ78s5hc77nrXkCfjtGjoEIRTSsUP61PtZspdOKz4v0ONdJvAev66SewajwRUEZ7
 igNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925953; x=1788530753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bFRrVkjQCFlDgD3LOxA8bXZmJYkAPm0glaH1elOSAeU=;
 b=YtfLdTbbsfhGDwxwL2SJsano8DEGA27gAv/C4PDNmbjF9mQnoobRLdW3KG6UxVR4bz
 DI05N+DP/JMRaAonbF6Gmz8PWd5kTgDxS/1iWDzOQg/AvrtgrRJLcjZF2EHjNPJMIbql
 UsyKqKEBUeq+BqsFFfxpWsxma/8vkW/6UJhLin7ZSc0JtRv8tih1Cmghc3HO8epQ12R1
 jfRYqC02bf2aacaOTkVBE77OCZtNExtQ7gXqdHDhrVi26XBR1sAsiMNMeMKO/B+1iP/S
 RwO9Ggh1x3oXaRpeOJjXUQUMGBTaDbY0xHXnZxF8Wl8tZe6lR1pgDt9o7hUN5rt0QaYr
 qB8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoJMHefTTd2Hil5puATe49kluHLBzqWR5fGZFIsyCKzKbJ74h7rjg6bE2hzbAE5wpZYM6GX6HSOBvM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgUdP0PqHlPyVxttJF086+r2C4dcE9ygY9jfDJ7J8MjhsMEzdW
 /2RQLRFhS0u74B9nl8XQLqjXZFDMx8ji00puiLFKACvTZEZXWhmicgv04zcd0vhG7BYsYFHhA/z
 p+azy0kV4VmLZTMV3VLj4BkSFovP31dT2F3hikK70TMI/qRORuspPGnMwUt+7UhnEn+pgbPM=
X-Gm-Gg: AR+sD12Qtcfc1xGeHqhR7Qg0ESlvOSRmHcw+ccqRCWMtoe6Jq/U9UMqA12Xh6poA9is
 0B6UejUUBYurvonRyX0nk/K/y5OlZOyivRP/JXXer00ajcYTm+u2s3uv7G3kjhv3ttENc+uF6EN
 eRLoqIJ7AUtP9e2lJawcD5aJVx0BmCv/3sRM9xnnfc+XCd0WXqZuIs5gG//N6ap3vkFcMwXjWog
 SCLUQIKnj9r01KI0I80hYO9AEpgXK4xSt7tDLkNCZS2ancc2saMcj0Y/ac1gdErMt6BRh6G6rFr
 TyoDyRNsWzpAPm1+Ts8rZERrn41ve9DDlaRMtTmCdCJd8bI1NV5j46uGlQYUq7Fw/fEu0YjeOee
 VDCra1x9Xmjcr2osa3krGcMk=
X-Received: by 2002:a05:6102:a1c4:10b0:785:c3dc:2f5d with SMTP id
 ada2fe7eead31-785c3ebd1bcmr1298763137.9.1787925952593; 
 Fri, 28 Aug 2026 07:05:52 -0700 (PDT)
X-Received: by 2002:a05:6102:a1c4:10b0:785:c3dc:2f5d with SMTP id
 ada2fe7eead31-785c3ebd1bcmr1298728137.9.1787925952050; 
 Fri, 28 Aug 2026 07:05:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:07 +0200
Subject: [PATCH RFC/DO NOT MERGE 09/12] drm/msm/hdmi: Add HDMI for Eliza
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-9-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10789;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=3tdhm3owA+5jaxcS1URgoZO7Y2lY7qINi0ceeKg9TnE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWg4SJKrYlfhfSTs4mvG5iIa3yXTHG/K/N1q
 8QPz/LOiXiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVoAAKCRDBN2bmhouD
 17E9EACF8KUrHId12k+yzI4p4t3Neswnd9rTeGHAKUTf1ycGMgQV4PdNrG6Mp2qGSjHq7wUtcmm
 UQL2eB0pvJ4hpjO/LgfimmxLkka1Co6jmrklIOq62McbXNkvRHLea2L6RN0xVMkcZ+fPRj7e/rZ
 VSWtROignZpm1Jjkhcz0Y6mwY7QZHayRueZG4XA8FlFew2u+9a2wPo4csDhKh2P5jENshHlqKCm
 8R8Zchj7glcG0xt8mg/qqun+OQjTW64ouAlE6WlBCwTvEExyTecldIpRrtWdptvAnnRwWt+qfCj
 peRUNIQzBXd4xfnyygO8HfqIPjPhrNJcsoc1UMdnstN3xWfilWlSudxBoLZSOtteEXNdVIbOYIr
 6HWpz23G/5ASVEbq322dZisOLX09mbzXXw4aXdMvvEFCzNxtKzP2nhUfuJmImPIQXRSE19FA1Nt
 rg+eDcgVvv/0YqQGWLsOz4L1OTIZNf031HpgQdul+nxex/p7FZ1rdKLLbvsI3pgBnTeLaTYORWe
 13RRSfQuvqaEp//y4+JkG85RnKwyv6VF75gy8tY4rc46TXdtTZqaMSaeCYg0mGdtdSY6s4J9gJQ
 AeyoW+ZoI9hXzFqOP6bvK4022PJbFz7L1PcDMPZ1R1a6Gr+I0OZEjiTzhEvRnN1T8gTk+QN9qhA
 YToDOENfXF4ZF1w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: ZGduGTDz1fvEwaBvsel8WOtrSc0R2Lrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX2TGZ8nKaGAOq
 MnDtUaDDqwoq5Z7IYR5KsIkZ+69UlnA3t2kIuH8IS5YRmELP+LD3CsJEuOXLoF+WwayrpuNWuKI
 /hdIdALhK3jvkCJmC0zAj3Cdmsv1tHPClTv5+Hj2iJIc+wuYO2SAJXRyQfKQf00JSoDufIGf6pC
 9avW1fHZm0APGLhpj3tN9/hmK63Y0S+4Lcz9dmnetm/6NY0ZIJNj2QHTsA3kiR+Vr2k1mmJUdW/
 xX2qAfDciUmZL91QudQWnZFS71Ra0DYdQblIgT3/j+RbVTr1sCPaNS5YM7YrSynIc5s+jMTbxK8
 2uNFNWY2Kmund2lGc560Df7xPq2M32GOsFYFD1/q7XYpwc4LsTrDgqOmiHGVzJ6B2bzOTGhkKHh
 +Ns+EbQe2dvHK5vRXx3//I8c2sQc8YFo3qP0VP5I3rDwCV9kf/od2+t/qkdCrSlTuWgZ4EJ94MP
 OifOiJp5O/nIWJbxL/w==
X-Proofpoint-ORIG-GUID: ZGduGTDz1fvEwaBvsel8WOtrSc0R2Lrh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX8PYe+5zo83sp
 xQH727hcf3/bi1dK2ru+BJdcZ2O+5l4Zg4GQqalPhNtJefwDxM+/0ZehQV0YuFw152VEFfEKq6K
 6wuL6lfMYfGG3pi3wUXL/LO9iNpHE64=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a9195c1 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=RX5K5x96Qe6Feoj_i64A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

Qualcomm Eliza SoC with DPU v12.4 comes with HDMI on INTF_11 with
additional INTR registers.  The device clocks look different comparing
to last variant of HDMI from MSM8998.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h |  8 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c  | 15 +++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h  |  3 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |  3 +
 drivers/gpu/drm/msm/hdmi/hdmi.c                    | 32 +++++++++
 drivers/gpu/drm/msm/hdmi/hdmi.h                    |  4 ++
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c             | 75 +++++++++++++++++++---
 drivers/gpu/drm/msm/msm_drv.h                      |  5 ++
 8 files changed, 136 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
index b93d32888972..c95cf4e38c12 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_4_eliza.h
@@ -294,6 +294,14 @@ static const struct dpu_intf_cfg eliza_intf[] = {
 		.prog_fetch_lines_worst_case = 24,
 		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 30),
 		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 31),
+	}, {
+		.name = "intf_11", .id = INTF_11,
+		.base = 0x3f000, .len = 0x4bc,
+		.type = INTF_HDMI,
+		.controller_id = MSM_HDMI_CONTROLLER_0,
+		.prog_fetch_lines_worst_case = 24,
+		.intr_underrun = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 14),
+		.intr_vsync = DPU_IRQ_IDX(MDP_SSPP_TOP0_INTR, 15),
 	}
 };
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 5b7cd5241f45..f6d1f944f4ba 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -206,6 +206,21 @@ static const struct dpu_intr_reg dpu_intr_set_7xxx[] = {
 		MDP_INTF_REV_7xxx_INTR_EN(8),
 		MDP_INTF_REV_7xxx_INTR_STATUS(8)
 	},
+	[MDP_INTF9_INTR] = {
+		MDP_INTF_REV_7xxx_INTR_CLEAR(9),
+		MDP_INTF_REV_7xxx_INTR_EN(9),
+		MDP_INTF_REV_7xxx_INTR_STATUS(9)
+	},
+	[MDP_INTF10_INTR] = {
+		MDP_INTF_REV_7xxx_INTR_CLEAR(10),
+		MDP_INTF_REV_7xxx_INTR_EN(10),
+		MDP_INTF_REV_7xxx_INTR_STATUS(10)
+	},
+	[MDP_INTF11_INTR] = {
+		MDP_INTF_REV_7xxx_INTR_CLEAR(11),
+		MDP_INTF_REV_7xxx_INTR_EN(11),
+		MDP_INTF_REV_7xxx_INTR_STATUS(11)
+	},
 };
 
 /*
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index 142358a105c5..231809607be1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -27,6 +27,9 @@ enum dpu_hw_intr_reg {
 	MDP_INTF6_INTR,
 	MDP_INTF7_INTR,
 	MDP_INTF8_INTR,
+	MDP_INTF9_INTR,
+	MDP_INTF10_INTR,
+	MDP_INTF11_INTR,
 	MDP_INTF1_TEAR_INTR,
 	MDP_INTF2_TEAR_INTR,
 	MDP_AD4_0_INTR,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
index 0e65bf5ddc4a..bdcc0caa4e4f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h
@@ -226,6 +226,9 @@ enum dpu_intf {
 	INTF_6,
 	INTF_7,
 	INTF_8,
+	INTF_9,
+	INTF_10,
+	INTF_11,
 	INTF_MAX
 };
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index c46f30063f14..b769780cd5dd 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -234,6 +234,16 @@ static const struct hdmi_platform_config hdmi_tx_8974_config = {
 	.pwr_clk_cnt = ARRAY_SIZE(pwr_clk_names_8x74),
 };
 
+static const char * const pwr_reg_names_eliza[] = {"core-vdda", "core-vcc", "vddio"};
+static const char * const pwr_clk_names_eliza[] = {"iface", "core"};
+
+static const struct hdmi_platform_config hdmi_tx_eliza_config = {
+	.pwr_reg_names = pwr_reg_names_eliza,
+	.pwr_reg_cnt = ARRAY_SIZE(pwr_reg_names_eliza),
+	.pwr_clk_names = pwr_clk_names_eliza,
+	.pwr_clk_cnt = ARRAY_SIZE(pwr_clk_names_eliza),
+};
+
 static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(master);
@@ -360,6 +370,27 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 		goto err_put_bridge;
 	}
 
+	hdmi->phy_iface_clk = devm_clk_get_optional(dev, "phy_iface");
+	if (IS_ERR(hdmi->phy_iface_clk)) {
+		ret = dev_err_probe(dev, PTR_ERR(hdmi->phy_iface_clk),
+				    "failed to get phy iface clock\n");
+		goto err_put_bridge;
+	}
+
+	hdmi->pixel_src_clk = devm_clk_get_optional(dev, "pixel_src");
+	if (IS_ERR(hdmi->pixel_src_clk)) {
+		ret = dev_err_probe(dev, PTR_ERR(hdmi->pixel_src_clk),
+				    "failed to get pixel src clock\n");
+		goto err_put_bridge;
+	}
+
+	hdmi->pll_clk = devm_clk_get_optional(dev, "pll");
+	if (IS_ERR(hdmi->pll_clk)) {
+		ret = dev_err_probe(dev, PTR_ERR(hdmi->pll_clk),
+				    "failed to get pll clock\n");
+		goto err_put_bridge;
+	}
+
 	hdmi->hpd_gpiod = devm_gpiod_get_optional(dev, "hpd", GPIOD_IN);
 	/* This will catch e.g. -EPROBE_DEFER */
 	if (IS_ERR(hdmi->hpd_gpiod)) {
@@ -458,6 +489,7 @@ static int msm_hdmi_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(msm_hdmi_pm_ops, msm_hdmi_runtime_suspend, msm_hdmi_runtime_resume, NULL);
 
 static const struct of_device_id msm_hdmi_dt_match[] = {
+	{ .compatible = "qcom,eliza-hdmi-tx", .data = &hdmi_tx_eliza_config },
 	{ .compatible = "qcom,hdmi-tx-8998", .data = &hdmi_tx_8974_config },
 	{ .compatible = "qcom,hdmi-tx-8996", .data = &hdmi_tx_8974_config },
 	{ .compatible = "qcom,hdmi-tx-8994", .data = &hdmi_tx_8974_config },
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 306b988bca72..2fa9bec455b4 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -52,6 +52,9 @@ struct hdmi {
 	struct regulator_bulk_data *pwr_regs;
 	struct clk_bulk_data *pwr_clks;
 	struct clk *extp_clk;
+	struct clk *phy_iface_clk;
+	struct clk *pixel_src_clk;
+	struct clk *pll_clk;
 
 	struct gpio_desc *hpd_gpiod;
 
@@ -171,6 +174,7 @@ struct hdmi_phy {
 	struct platform_device *pdev;
 	void __iomem *mmio;
 	struct hdmi_phy_cfg *cfg;
+	void *pll;
 	const struct hdmi_phy_funcs *funcs;
 	struct regulator_bulk_data *regs;
 	struct clk **clks;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 621083a97b37..c6a75f653915 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -14,6 +14,18 @@
 #include "msm_kms.h"
 #include "hdmi.h"
 
+static void msm_hdmi_clk_reparent(struct hdmi *hdmi)
+{
+	int ret;
+
+	if (hdmi->pixel_src_clk && hdmi->pll_clk) {
+		ret = clk_set_parent(hdmi->pixel_src_clk, hdmi->pll_clk);
+		if (ret)
+			DRM_DEV_ERROR(hdmi->dev->dev, "failed to set reparent pixel src clock rate: %d\n",
+				      ret);
+	}
+}
+
 static void msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
@@ -29,16 +41,34 @@ static void msm_hdmi_clk_prepare(struct drm_bridge *bridge)
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	int ret;
 
+	msm_hdmi_clk_reparent(hdmi);
 	if (hdmi->extp_clk) {
+		/*
+		 * Set rate to hdmi->pixclock: PCLK_CLK_SRC and PCLK_CLK
+		 * Set rate to hdmi->pixclock/2: INTF_CLK and PCLK_DIV_CLK_SRC
+		 * Set rate to hdmi->pixclock: HDMI PHY PLL
+		 */
 		DBG("pixclock: %lu", hdmi->pixclock);
 
 		ret = dev_pm_opp_set_rate(&hdmi->pdev->dev, hdmi->pixclock);
 		if (ret)
 			DRM_DEV_ERROR(dev->dev, "failed to set OPP rate: %d\n", ret);
 
+		ret = clk_set_rate(hdmi->pixel_src_clk, hdmi->pixclock);
+		if (ret)
+			DRM_DEV_ERROR(dev->dev, "failed to set pixel src clk rate: %d\n", ret);
+
+		ret = clk_set_rate(hdmi->phy_iface_clk, hdmi->pixclock / 2);
+		if (ret)
+			DRM_DEV_ERROR(dev->dev, "failed to set pixel iface clk rate: %d\n", ret);
+
 		ret = clk_prepare_enable(hdmi->extp_clk);
 		if (ret)
 			DRM_DEV_ERROR(dev->dev, "failed to enable extp clk: %d\n", ret);
+
+		ret = clk_prepare_enable(hdmi->phy_iface_clk);
+		if (ret)
+			DRM_DEV_ERROR(dev->dev, "failed to enable phy iface clk: %d\n", ret);
 	}
 }
 
@@ -61,6 +91,7 @@ static void msm_hdmi_clk_unprepare(struct drm_bridge *bridge)
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 
 	if (hdmi->extp_clk) {
+		clk_disable_unprepare(hdmi->phy_iface_clk);
 		clk_disable_unprepare(hdmi->extp_clk);
 		dev_pm_opp_set_rate(&hdmi->pdev->dev, 0);
 	}
@@ -443,21 +474,47 @@ static enum drm_mode_status msm_hdmi_bridge_tmds_char_rate_valid(const struct dr
 	 * mdp4/dtv stuff where pixel clk is assigned to mdp/encoder
 	 * instead):
 	 */
-	if (kms->funcs->round_pixclk)
+	if (kms->funcs->round_pixclk) {
 		actual = kms->funcs->round_pixclk(kms,
 						  tmds_rate,
 						  hdmi_bridge->hdmi->encoder);
-	else if (hdmi->extp_clk)
-		actual = clk_round_rate(hdmi->extp_clk, tmds_rate);
-	else
-		actual = tmds_rate;
+		DBG("requested=%lld, actual=%ld", tmds_rate, actual);
 
-	DBG("requested=%lld, actual=%ld", tmds_rate, actual);
+		if (actual != tmds_rate)
+			return MODE_CLOCK_RANGE;
+		return MODE_OK;
+	} else if (!dev_pm_opp_get_opp_count(&hdmi->pdev->dev)) {
+		if (hdmi->extp_clk)
+			actual = clk_round_rate(hdmi->extp_clk, tmds_rate);
+		else
+			actual = tmds_rate;
 
-	if (actual != tmds_rate)
-		return MODE_CLOCK_RANGE;
+		if (actual != tmds_rate)
+			return MODE_CLOCK_RANGE;
+		return MODE_OK;
+	} else {
+		struct dev_pm_opp *opp;
+		unsigned long pclk_rate = tmds_rate;
 
-	return 0;
+		if (mode->clock > 600000)
+			return MODE_CLOCK_HIGH;
+
+		opp = dev_pm_opp_find_freq_ceil(&hdmi->pdev->dev, &pclk_rate);
+		if (!IS_ERR(opp)) {
+			dev_pm_opp_put(opp);
+		} else if (PTR_ERR(opp) == -ERANGE) {
+			/*
+			 * An empty table is created by devm_pm_opp_set_clkname() even
+			 * if there is none. Thus find_freq_ceil will still return
+			 * -ERANGE in such case.
+			 */
+			return MODE_CLOCK_RANGE;
+		} else {
+			return MODE_ERROR;
+		}
+
+		return MODE_OK;
+	}
 }
 
 static const struct drm_bridge_funcs msm_hdmi_bridge_funcs = {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index eb4bbae8557b..e63c63ae7d6f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -67,6 +67,11 @@ enum msm_dsi_controller {
 	MSM_DSI_CONTROLLER_COUNT,
 };
 
+enum msm_hdmi_controller {
+	MSM_HDMI_CONTROLLER_0,
+	MSM_HDMI_CONTROLLER_COUNT,
+};
+
 #define MSM_GPU_MAX_RINGS 4
 
 struct msm_drm_private {

-- 
2.53.0

