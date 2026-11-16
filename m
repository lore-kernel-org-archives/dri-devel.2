Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7046606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V0tPSJ6P;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jfcvKNTO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4F210F193;
	Mon, 16 Nov 2026 13:18:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5936A10F19E
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:20 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGC0uYD2472407
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eiucA+wtjzHIfQz9RvwaXxBQzP8Dhf3ByqiqoY+aurM=; b=V0tPSJ6PVwrpjHtZ
 Zi3tJ/BSazgFYTmvRqQdk9TSdWokZLmDiLT90OIxED+9p57GGOD3U08rHm/qmUbq
 utNEDf4rSsqp7PuU/t0Z2ichhhuQ2ipjAzQm2ht05MTwZ/tz6S9za4Yi3cCYj7rR
 r6rsEEy7S33hlrbO1axgP235Un0U52/PvBNAQS192Q5iMD47cm4c8n1gFdnN8uAc
 RgKpRgJsGzr88ApI1peasgiYfrdoHK5LLsTB+7A6Lpvopf2/YHMJdQxmberQ9tKW
 uZ5o4INsXMDSszEtSW7tBRTlperwt+Q+uVguZfP1uvIWHu1JXH7HBUJaFEKOAB69
 b+yGIg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhhdxhqr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:18:19 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-94960131befso389473585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794835099; x=1795439899;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eiucA+wtjzHIfQz9RvwaXxBQzP8Dhf3ByqiqoY+aurM=;
 b=jfcvKNTOUKq18pyvI0zjthQH6IyGpJmtovtUYDeBuv8tR1aawurAeeJBknGLBjstbZ
 Jjg2EL1lWCQ8gksVQ99Zq9kI2kzoS6k1FLaQUn+r+0WO6kTYYInljWfWC7r50jpz3fmb
 ydIIxR0VRDbwjhZGZpQmBl++pjaBFuO/SGdRDtNI9NeksC+8xEhtp6DhGkZp7UHxlYiq
 kAIWze0DGsjTx7dVgUsZPTq1fwjeA8Cxpbij5mV5Sp8Cwn8SgAy0lKk2+SlOoIewPfFO
 1lNmgaBs7zym+0wBMBdvEDMYeSB7CVudMHN6UJ4M0IVb57BvgB4Ax8F8OpR8fnmmyk1V
 5TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835099; x=1795439899;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eiucA+wtjzHIfQz9RvwaXxBQzP8Dhf3ByqiqoY+aurM=;
 b=jUsFEF0iwTt9X2MXHIw7ohPpMpFZz6CI2jofxC2swS+yOvR75+zDe1T75+kC57T+Hv
 x5oRVnEqMQbqrbr9yYrm2zRHRkZiQ8IAWg5aQco7jbdrthB8LvKTs7nuDpQOstfAHQFq
 odq5NnGN4yFHG2Dd3QO+ap44v13VmaShJv4Tvd0vQwmbnsMiHFWW7KLrKdOjj+cyH261
 zv1OSS6ME8J93lNEsK4kN+obJpsnr/LhlbgSq5LbEVcQV7VXXF81hcJUVTjXLSMKpUr7
 yo/06iQ/kr475KhI5Am8w88i9eccJBByUayPWZIBJxvUpsOlxED0XUaZNaxccs/wvyqI
 +nWw==
X-Forwarded-Encrypted: i=1;
 AL+hErHlEj3h6aStaIQPe47GOu8KJhyVJqq5oS2nghX5pU3q5Tw7wIdw2LH0i4OquCeQaDvnDhwQjiksijI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+NCeJbADCmaRBR8vH4pKVEAEdWPYrlR7baZ7p4mLJ0lpiFNpjt
 00c8Dy522YVA9BSB6ALiioXyBdupjtUs/X1RiZGU6ftoWWAZzEF8tZUzZ8uy7+5VcQHzKATrZiH
 3SjBpLdvLDW4loBMgAWLPFFeRwtkiyY3fcSedAupoyCs3m9Js0wLo71tvmmyvy4JE70rM0gc=
X-Gm-Gg: AYBFou2lfp9MrJTpTgvtGLA5GoFYnsA3jWQJlYL0kBaCLvv9eKA3VZG107r1WnjUHPu
 /8menDSPFYDil9hGgtvKC67ELUUhHxFiEuN5weZTVA3dh6mU4LuUEJFkLOmBKO2Ze2l7/9GOOTs
 Ve6zUAD4H72P/f3QI45wiORQIdWc2hc4jjWlxTMt8vF008JwEq1cxovK3nLOCN/5GSrYCsWaQZg
 hyfVJzKYduoWfYzx0yh5fF9EKQq1us/Kbl82cqiyrBhNgu9nBjjNo57WTXL03H6ornTW4ezgccz
 9AU5XIJXhYU83317yccyGURi4GHZ7K0rd5FX78JotNtFWB/ggq/uLI6+tqaLhDEzvjmQ1QbHZAb
 l7kEYnzS3wRuVznivC3kxNbcenbRpXDrdz6qV4qOpEa5WLgKl8I0KLxpui3ZLqHP2OrM1QdW5vZ
 h1
X-Received: by 2002:a05:620a:2709:b0:944:d79:c02 with SMTP id
 af79cd13be357-9494ba55576mr1456184485a.10.1794835098908; 
 Mon, 16 Nov 2026 05:18:18 -0800 (PST)
X-Received: by 2002:a05:620a:2709:b0:944:d79:c02 with SMTP id
 af79cd13be357-9494ba55576mr1456179385a.10.1794835098475; 
 Mon, 16 Nov 2026 05:18:18 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8e1c94sm843927285a.39.2026.11.16.05.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:18:18 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 18:46:46 +0530
Subject: [PATCH v3 07/11] drm/msm: mdss: Add support for MDSS on Nord
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-nord-drv-dt-v3-7-e3d3bf0e2c49@oss.qualcomm.com>
References: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
In-Reply-To: <20261116-nord-drv-dt-v3-0-e3d3bf0e2c49@oss.qualcomm.com>
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
Cc: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835013; l=978;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=cUv9ygkqVGKsKi0AqbVOUesQJiSTwCdwgeTcXPt+zc0=;
 b=feVgYY8v1OmtMYZhR56xObEddH4ZfXk+7alnHhbbpkFAvGzUXeze73NFNgFXi7LWeLUnEunZb
 K9td4X7BvYFCOuLLmWeFhM3EL6B86ftpqGoAb+5luNQDk3Pj6p2k7jJ
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=VOVIDNPX c=1 sm=1 tr=0 ts=6afb029b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ikCT10dxFQO67KJDykEA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX9AUqc+FGaEVt
 5Bq3Vbv2zjcpJSVkp6nqRvV7Lzk0u4RIzjVkcSTU7UJfpcoPIMoYmncQ+zzzhZjoR5vbarT/jMz
 LzRxdkrm0iW737ekrp+fMVnbcN3QCqQ=
X-Proofpoint-ORIG-GUID: H-W70mORvYvcwzt9ID3mri1xVlFNx395
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MiBTYWx0ZWRfX7GVUKZc1P/PF
 mA+AkbOofrLA5iugJdfRcMglzPdHX85MRIxG0bx2d5h06ietfPP4Ba8/U+9rK9EF/pnrd6cJNIt
 Of2t2Ei53derfCWCynI3dhAMBg/gUMzX1taEvVM28/PTmzDdpWaomS45gPYro2rppm9wkXlPMf2
 8CLHqvYC57OczXa79ljlfo3uD1ICB0QDmaubV00JBHrKv4o6srVg1h/q0vufxhgO2NwOSpp7VWR
 k21eu9ibeOxVvlYQQGOl1dE5a+0pmNVNmsev5sQHbVaE+YGifSxB90xG4v1WrYpQtuGL1FUnhHf
 ZvDZ4zT7Sy7GJqKAKb/BaScMYV0DrP/QmcJb9fAwphLAk/MR2VGKreCnRxzBFKnaOHBeWSLPtIG
 Xkk7XZ66Do2SP7zK6WZWonYP+LyF8KGYIiJlI6G7X2M+wnus0PSXg8nTXDIdDLCK7vwZValcWvY
 yow/0Bl0Yvwrq8z7z5g==
X-Proofpoint-GUID: H-W70mORvYvcwzt9ID3mri1xVlFNx395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160052
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add Mobile Display Subsystem (MDSS) support for the Nord
platform.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290db..90bcc8c28dc2 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -531,6 +531,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
 	{ .compatible = "qcom,milos-mdss", .data = &data_14k },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,nord-mdss", .data = &data_57k },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcs8300-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },

-- 
2.34.1

