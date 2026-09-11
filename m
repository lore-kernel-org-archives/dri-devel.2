Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784D3C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BABDA10F324;
	Fri, 11 Sep 2026 15:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9RMnlMi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="crKdMX0n";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BEBE10F324
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:39:00 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BFA5at658269
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tKaBjoBGU4g+MPA/QMDjAFsVj4rZ70kS5n2KtwM4AkE=; b=l9RMnlMiGOkxW+pa
 4Ss2zASx45Ad2B0m4MI1wJgI6cx4LhDELtFRKnDAvF8xgAHTLtdZ8LM0iwXy9Hur
 2QkAiWqqfs4ppobzZ2pjg5SNRQy6ijn06uaipg9m22bi3yZ8UkAvM0p4lbSanym9
 wAlHdpokJ7ffsjUx2iMuqac9USBA7fq8Ca0stkNE3dIrlR+5Foehw2ypdhzjaLTl
 ft5VMmJkqGxyO25MzFoC22yW0nqc18oaqDMkghNjkI2Znyi090yREDVo25kLsD/T
 T2feXCdUC98mRqE6av9RooZx6PYC/ScCreKWyvRPz3FY8B4wnOvyE+wmm9ixiLf6
 95a0PQ==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmm22r457-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:38:59 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-44899f99756so1300846fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141138; x=1789745938;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tKaBjoBGU4g+MPA/QMDjAFsVj4rZ70kS5n2KtwM4AkE=;
 b=crKdMX0n/g7MuvS1DTT4/VFV7ddhwNMofx8zQCwIqATepYOlPQI3plJEMWndQVbDxt
 3/Fef40fhym5uUlIub1njtmhX014/teolVf/z83m8vBUwpWHx5283FcMkfn3x2xY0Sza
 F2qnK7vztEwN1BD8pSjJbCIiSguot31mYfEg36ffCO8DF7ECLSaFEdPWzNzVLM+pu3UF
 e/Q/ImI7dtxk895GKTZzVDMZCSNBzKFJsojozKvC/ovZ0+61n1bAtCFbQYj1+vmtYSnJ
 nDaJ/ERg8Z/N7bpT7aaJX0Tt9HickMjPWwAqzL4zEwTqa5d2b0e+tbdlyy7xyDv67YWv
 I0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141138; x=1789745938;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tKaBjoBGU4g+MPA/QMDjAFsVj4rZ70kS5n2KtwM4AkE=;
 b=M4zGI2STwB3eZljEGuiytfqrGW8fAQtFBsRfuwNw4HXiAfq4BCJsl9SuLU82jq4y5n
 UavAKAGNQNf2s9FvU2FhDIlgKjQ26c2shW4cZQxusdJ9tPJzHgB+sKMr9XavfVk5qLYR
 u8Tg/cnjtbUUASiqnDPb4mrqIfQEBmKl+f8jaFBi6bHMGJ+8ONtT5AdH2qza4rr+Se6U
 dgCPHcx2luxYFxa3Rpo3mWvsr0Yp3iRwj6e21A1P7bw9mRZOE50cSdApG8ZpxbcAy2mj
 Oqzkmdb4MgendS02WQo7k4A2tHpf6M0gXSgLmp9UP6gEQ7tIY4TycP2jP5X+d6RIrX3H
 SObw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkmPscp06c3XA1dShtBinnWZLx7Zziudn6WTfPDpxpZysl6L59RHd/t92M1d/gMgrng2CS5LkXI98=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m26muiGCP7Dp6qD3hZftfggoPYeivY6s2BJRmDq2PYd3gyzdcd
 9zdCXXsGud+lrzTV4DLRnuwlfPXgX4xoEXXz/OZkY8PM4061dX58fFuZFMic2RfBK4kNHu3J84/
 xJW4sYSLdBP/SakUykHsMGqAOv9JRHm5McioVPQQaJLU3IgpBEFa3/iFC7suLfy5MUuPqNsk=
X-Gm-Gg: AYBFou1/+ugZxLCxTwP/EIqu5TyeEC3y187q0yRICSU9Tdz2icnngSAxq9lyQTqPY3v
 Ew/wpYsrM4jE59236/dtj1p4iFBMouCtUFVMVXXL+y/YV+7HWG3SET6UTpluh66JX1d+8DYhawj
 00wZ5O5mhmMvnDNveS1MRarmg8apK6l4hgwsfgko69RCdA0jlk9fe5IBLeglUIh+c13l+nAxwGn
 96TtvuGZyhMNYyeodi1mWCKviCjH6W+NtInNhQ/4jXyfI3SnGeaqxAOJtb6ZTJk5cNsxmpFZ58F
 93x2mX4QoWZtGVt3br0vj6/ThiflTHg8qgqcvR1b498QIuBJWYUNcA5Le52dWCGJBz6AXZYJX6L
 ZPy32wIwJ5b5Bg2vJTd/9Bo1WwLg=
X-Received: by 2002:a05:6808:4f60:b0:4b9:e5fa:890b with SMTP id
 5614622812f47-4c31b9f16eemr4174503b6e.30.1789141138642; 
 Fri, 11 Sep 2026 08:38:58 -0700 (PDT)
X-Received: by 2002:a05:6808:4f60:b0:4b9:e5fa:890b with SMTP id
 5614622812f47-4c31b9f16eemr4174468b6e.30.1789141138155; 
 Fri, 11 Sep 2026 08:38:58 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:38:55 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:43 +0530
Subject: [PATCH 12/17] phy: qcom: edp: Add Nord bias and clock buffer
 enable callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-12-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=1163;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=TJ+MFSHUURH7gOS+pdGimYtOjH3VbFvgcOMzvr6FrkY=;
 b=H1xeQ4VQYRjCAdIOLL7ZZUQ8aeKbS2ViYdolASdA7VKj8S9mICvGiaBIYo7Fsv/BUIAOeWESp
 e8cjF4dHeaOChbU8dcgjgs3RnwXdzjlRc66uRQZhPDgmgXF+iNiD/rq
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX4RJQ82jnSSn3
 AX8X2FhcS+rAnXwNOesYJZTPH2NZ4jMFmEmj+tx5LpHUOB1cejXlyc8Hb7Orh/w2pPJO0zkUq52
 ogCUrHxFyPgclUOagNNIAVt3iI5ZUTt3xUwEGJBntWsoOIZ3pFGc4N+k5WBs4KM7gT4gajFboWV
 nIiRqfAY1BcvPlACz+LBYPhMVEEBZpppOMg95PkJajZFgOxooNlyOyk2aQ9EIjql4y+FuKaWAC1
 tooTEUNsiuvbp+wRg038hhitH8Lbqw0Ry9mrfwKxHmKg/8nkoLYYMMQtFHOGKM8oLMEFiLWj6nl
 JrTK+dehHZ3tbDpXVoHYRBjglC9d+NdwT/NKNwlVgKtCoFOoeHA6zMSSn9/vW2T4Wh7v+GF9Ckq
 GpoOM6BSPEhlbu2IagX/1Xaah9TbsFQsnrUBOon1pCBVXtZOD84Rf1GzrJuEyTvT7WrcNQ+AEP0
 YJ493thcMY82gh2IEqQ==
X-Authority-Analysis: v=2.4 cv=LPDz05W9 c=1 sm=1 tr=0 ts=6aa42093 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=UH4Y3tt_PtaHL7u5GSsA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: E9CAGw7mAcIyOl4srWWldTtxsS7_6Rop
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX4EaBYPsfLDZ9
 +kkvz6rUkTQHLNRPiF8W6j8knAB8r8C8XwqU5fVUBlDfrguaZKru5SX/gM7qkgKTgqWgsDL+RXb
 Ohw+8QbszdAUqgE/YarDhghkmdAmwak=
X-Proofpoint-GUID: E9CAGw7mAcIyOl4srWWldTtxsS7_6Rop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218
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

From: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>

Nord requires BIAS_EN_CLKBUFLR_EN to be set to 0x1f to enable the
internal bias generator and clock buffer, which differs from the value
used on existing SoCs.  Add qcom_edp_com_bias_en_clkbuflr_nord() per
HPG Table 2-1-d.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-edp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-edp.c b/drivers/phy/qualcomm/phy-qcom-edp.c
index 6cac4b55b66f..ec4220cffe69 100644
--- a/drivers/phy/qualcomm/phy-qcom-edp.c
+++ b/drivers/phy/qualcomm/phy-qcom-edp.c
@@ -1637,6 +1637,14 @@ static int qcom_edp_phy_com_resetsm_cntrl_nord(const struct qcom_edp *edp)
 }
 
 
+static int qcom_edp_com_bias_en_clkbuflr_nord(const struct qcom_edp *edp)
+{
+	writel(0x1f, edp->pll + DP_QSERDES_V8_COM_BIAS_EN_CLKBUFLR_EN);
+
+	return 0;
+}
+
+
 static const struct of_device_id qcom_edp_phy_match_table[] = {
 	{ .compatible = "qcom,glymur-dp-phy", .data = &glymur_phy_cfg, },
 	{ .compatible = "qcom,sa8775p-edp-phy", .data = &sa8775p_dp_phy_cfg, },

-- 
2.34.1

