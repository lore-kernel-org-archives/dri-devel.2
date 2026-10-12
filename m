Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F84CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 514D510E763;
	Mon, 12 Oct 2026 13:33:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07B710F110
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:33 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC08Hf1933179
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1BgydbxL5gnFgTs/5vZY3z8HM12JSjWAliFP2DRtg+4=; b=B1g/JLZmBYih41fz
 Fo5K7Q2TMnwJFApQt6m5QvfjJVScozrcilJYbcHVCkhIisfwOi4w+di2folhzcYh
 Ov7FMiXD6g28n5tRQ4+wtlbA2e72nP83oYW0fL3r/vAx0LjspyeuIT1Uk7OkNoJd
 JoGpGZW3/BX0oVzJSFJDHBLMDiDHpZdyeaHHHjpL38JVGBOsEx7nSjuvymgqE1/2
 E6qVBbYaHYOrcqR7MB1h1Zq5yIlXt2uqcQQO1ZQKkbA3sqIs5QX1TXj0063E3sr2
 2/P/qNTUnxp83fxpyFPel/Uk523pBuI63rE2BZg7ZRr6BZ8OAKhye3CrG52pIBLH
 YE6irg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkjdgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35a0c25def6so2281635eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791812012; x=1792416812;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1BgydbxL5gnFgTs/5vZY3z8HM12JSjWAliFP2DRtg+4=;
 b=TEVHCwOCmAxnHclImofNul41T9RdXV3/HmizmbiCAgLGnkVKzmZE8plTvSVgZYfiDR
 soaNi1ZkhvojWePTB+5fKqFc/ENx5E/E8GjOHKTLiIGM8uPKXQ72Grreoh/n/AD+jrje
 Wcu87H1zghUvfaOIN6Auxc6lP5V47310Fo0l1WkIhxImNFmR3H+fe1gJohClvR5H0PSO
 k9Fb0BaPPO49tlW7A4oFOpfPcuWhFJgiORsXJ8FJCuYUtts8QurbiP7DuGWWm2n/6WfU
 9TJMJ0LHTuqLMfaZsxzrQMOve6lHOYgrKNomyODFv29q1y1E7iTcf5U/pLPjEJBm2V/O
 IK1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791812012; x=1792416812;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1BgydbxL5gnFgTs/5vZY3z8HM12JSjWAliFP2DRtg+4=;
 b=CvNZNjY/Tr4cvOyli+sKpZsjI+15jCMxY6IhXdq4MJk1nDeocgWaY9blWUZfsKCxpe
 dQP8dbYNOoguKC5f5P6WlpuGL6uyxdRsajRGTlZlm4MnAcX3gpVdpe45TPiBidj4HtR2
 bodzyqKyzgCAl1ve6zn0Xh/WxFqutGV6CZGttep8xb6+SpvHG/eBSLfjs20ERrZma5cb
 rb22kyktkPogCd6IJPU/0A/O63trXY7TEEAajfirYFOu27ycfDGheIqN0iTZn5s5TNvw
 +16bisijfp/GXP3+4C4LCaqN2S5kER9IDt71E6mfHNLZfl4dLtsrgUTPgfR8r4Ovq57O
 vhTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwCobVq0tBitiVkOze7bBb8JTa4fDH/54mvMB6O+0VeoTkr05t+Ag9DnOM5UqUAJGDu7JcojY1Ragk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLnL8Lc/bC7yay6ArqI13K2lB5EQ7EcasrCujFoHdKvOFiT8cEv
 KmMg27f+gxQVf6TAn8Gx1NgxdhJVBTKOq1uPTo8W91iXydjJvDPzUTvqzMgPdQLDvu3dkccy6Vs
 U+/qcng2lre+sSjdffaRVc5VMH6S4poAIZ2DUW+fMlwdsW2V2YjDjkYnsS7nZjEKtRFAlDK0=
X-Gm-Gg: AYBFou2I0rrMHGbNIyLdvNF0Af0CHVC3NjRXeOzG2GQycnJ4DHlP7oesTzOEA+C0yqb
 +ZaC8ahAFwJE8dO4q9fnyAstiaulPEJhn9LUDqtLs+DfsB0U+q1BXt63tj792+vNbMDkQjQZbyg
 UBLE5RNTxapkW7YSSOtD0A/3DG/8OdeLY4y8Yo3BFSzoeW5z959I17MsH1h15xx8tfjMfwMyqau
 SQeKj2FRLh824++4ZUNpup7nbGCARzuAK5vh4c3BSsujZ/4JijN+C2/mtKK305mSNHhHaVPAKz6
 kqD3DCs1upP8We/Sduvq9ah4g9y74YfLxVjRnnNrBgdCTn2KA+KVzk5WSG3Ep0fY/Z0YTpPtkX1
 5layBMbbYwTn1E1IJ6fvgfZRMj28=
X-Received: by 2002:a05:7300:cf8a:b0:351:1ec9:aa4a with SMTP id
 5a478bee46e88-3537e063a23mr11970360eec.26.1791812011455; 
 Mon, 12 Oct 2026 06:33:31 -0700 (PDT)
X-Received: by 2002:a05:7300:cf8a:b0:351:1ec9:aa4a with SMTP id
 5a478bee46e88-3537e063a23mr11970325eec.26.1791812010749; 
 Mon, 12 Oct 2026 06:33:30 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:33:30 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:16 +0530
Subject: [PATCH v2 06/13] drm/msm/dp: Add support for DP controllers on
 Nord
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-6-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
In-Reply-To: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=1767;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=66JtXzji1QajcVRTK89pE3DM5ER0MuHJ654ycwA6qSI=;
 b=kB21rf3weXGt0FrypFIMvBPneNYZUAMZ7x1MMLTq7YnZY9HA3x+wh0ohqJGZrdtL8m2dfzOT3
 pR3PyqDrrXrDffe2ucAKIJJQcpIRWRlC82ciCDP7B4PXBDbbPK1pL8K
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX7hCOWAI+9Pre
 AqL7ajMH2lJBWqCnniONnsCTtud6oVBgLZq6Ke5GdISYkss4kILkoCW94cy6vREjOoqz+6ha4dL
 4+HNRjMVoVhnolpO2V8WjCAzgZxsIoJrWyy1iJQtbqTKwQa32lKgCmCg2cvdjn/LzSUQ+gJmX4c
 V2MB4D3jnFpvbvB7OV26Nks5nd+3Cjpmx8BVp9IVXHl3mMCcBllq3yjd0FzfdJ42T8iU/Lg7wAo
 3+jyayUbz5bockPvJnpVnJN/ZSn2gH7jMleD3btG2yUc6N1xH6ZUw+zyKe54KtditZlGQb0GffQ
 dFXVDzXuDOsTMk6FZoykhCsA/uQnSm8JVTjcfEtkrcQ6kEdENfuCcKipI8RSkm0ituiS7kXOh+o
 1PlQLIa9r0dIRC122arAvO0oDxPOmK+tw4BGcTYxEufwdJJCZmrm6WpVwAoDGa/ycZ0EDswCkFx
 5foVNK51kuFSySYRvwA==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6acce1ac cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=U3LaRFsynPqcHeHyg24A:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX2uwHONyCgHhL
 vHw4lbqBJ0dI14oR77BfZHye9s4quRM3vvRasxIThTzx/6gn+X6RkIpMlE9uNZ559JSvCw2mJSR
 8JRtzsarOBo2n/yewQbOMzQ4wzyTbw4=
X-Proofpoint-ORIG-GUID: haCbbtu7Ejq5j_9TLDEJS3HKsTeUhv4i
X-Proofpoint-GUID: haCbbtu7Ejq5j_9TLDEJS3HKsTeUhv4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120053
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add the Nord DP desc and compatible. Nord is supporting the
four DP cotnrollers, two per MDSS instance.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..7d233da396fa 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -103,6 +103,14 @@ static const struct msm_dp_desc msm_dp_desc_glymur[] = {
 	{}
 };
 
+static const struct msm_dp_desc msm_dp_desc_nord[] = {
+	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{ .io_start = 0x08d54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{ .io_start = 0x08d5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
+	{}
+};
+
 static const struct msm_dp_desc msm_dp_desc_sa8775p[] = {
 	{ .io_start = 0x0af54000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0af5c000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
@@ -161,6 +169,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 
 static const struct of_device_id msm_dp_dt_match[] = {
 	{ .compatible = "qcom,glymur-dp", .data = &msm_dp_desc_glymur },
+	{ .compatible = "qcom,nord-dp", .data = &msm_dp_desc_nord },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.34.1

