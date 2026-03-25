Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84CD106B510
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA1B10E8BD;
	Wed, 25 Mar 2026 12:17:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eR+wV2a5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KgbrNabb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212FC10E8BC
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:22 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBH7rM1024478
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JaWWNuEsgM30JPsQq/Un5nxrZosUzYeSlGe0mJTeQEY=; b=eR+wV2a51z456GOG
 +1RXTAvKbYFflBaHkyGprblzAgmFxqt6+TwATb4dRbUi6s/f1+YSh5QtiJiaHc6P
 nL0WyGYCl8fERgegPcy3uCwwjbipMi3RD1wJPl07o7URqi0BNqODPb9IwK0AL4xT
 79eh0cca7jea/S7kQeDxLv/36PFcUbYn5YAIenMyUlEdqqE56NqvMIXaMQXVGlg+
 /Vm9t7Los/rrmIBzdZmBnCyVtY3Cz3PpJxcqdYPviWM62oLiY/oEHiXLTQ1exvfl
 /BBsPwq/czV4FKbgWPv/F1tloI7WJBWjTGd0uY724mB5pr+nnwCD06phkRlvRH4b
 H6w9hQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3vhvvbqw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:21 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50925fed647so137580681cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441041; x=1775045841;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JaWWNuEsgM30JPsQq/Un5nxrZosUzYeSlGe0mJTeQEY=;
 b=KgbrNabbszzCk6SsLhxZz7jInq4Q2ktbSJ/ItGZaGgCa6JVZABoOSPQ7ZOd64eN9he
 XFALtpRxlHDO1CvmK5bFjSCzEuRGNGglTUGcgfsAhG+aH5m/TqxhkDgmdgUDlOpeRKPV
 86/h5nKY8Xp37zTGOO0FZEVJV87lbnKpfv3oASjrnqzq0srYXDpBO4wjZv2ycJ6yJKsM
 PaprFeEaxmUqq8MYUWvzb1suJuREFR8/wJmLiKwYVlXNSKDsGH1BGWFhg3MD6G5Hk8hY
 SC4O4R2naO9NCrrRe4QNo5H1Qo2JLciCjxxHV7UOk6204F2h4uis5mZauCXSzniX0/bi
 oHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441041; x=1775045841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JaWWNuEsgM30JPsQq/Un5nxrZosUzYeSlGe0mJTeQEY=;
 b=B9tr/UVfhHCv2yB6YhhJwZeKTDRpR+KQsfvb3FpMpEri/A7gb+IhmYyuzeoHLEmTRB
 avpT5IFtnJ2dVzF3WXbAeWAUIdCPUFkG/xViJqp6gurl2L4KFqa7vTmX+CLo3W1QyqFo
 /FHfG8xpxCW4YfulCmnJDikWGgFwxvsfGFoszQFaEzydqED1KMh1w7DQ/NaSy5nI+kO0
 I+H5d/lbTyJiCizCdNvzH9csTWe8f/UqxIGzeXiF3qOJ23kGdjCA8FdHwml3/y7kFW/9
 qHdqN3z2cdoIbMxnE5fKYAiCy2Vf/gGeoCWBB7GCXmkj1cjcp9M3lKvnUe5vDQ3YGqYK
 odvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDDhzqKcwrqv8DJneL2c7HILu1xv/SmTDFRvbBKNv9HQgJU9ExcCvTPC39jD3wEGsoclJi+He+jd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAYP5Izvpkg52MW/TYMRFIP0qnTXAQlERMikOLIg4STsIBD4Bw
 GdYxGmcRy1ZLEE9m9FH0VG46TCQSf2l1I8240bEVSov/zLsN81rCyMPlsJVBJhVJgkFeir08jnM
 ybruZqK5HZwiI+02nuTzPKYqnR1JqEZf6lmDGkQMUA3bZciQiyXNfPnglaAltlaY/36Qylts=
X-Gm-Gg: ATEYQzwcY95BdH2Cmjgk8EvknVplaHspxv6aOHNQCwnYrA3ENmnAlla1HyyZbsRsK4S
 GGGwKXLeeaC2Hr/XeZ8WemVq+ZlQAsMZmWscMHa1tujsnZ7ocq2CP9WHeDvcTGfLZ5P2qFq7oyS
 c9w776Ae4TBXyFX+r3qorPCg87F1igczVQZxi4DIf/joM9TAekQDEHvVxSqGlEAlXl7SgHpmReA
 HLU/P+0qBxBnzZ69/Pf9PuhkoUMy0YJPgzmPeWpRLmv55DS5HMyeoGTSmEclIX3pv+JgRq6OuG8
 0F5HR5DhM5nrbYNs8lcAREW5RCypuSgGhc3W8LFNOPD/pEe5SHmdHbU2VWYsEixi3MkeSyVxG4k
 +YFXFBcBR3PJmRMeqiJi12naRSM4bhBWDUFcHmk6UulT2
X-Received: by 2002:a05:622a:343:b0:50b:4755:949f with SMTP id
 d75a77b69052e-50b80e333b8mr46901251cf.43.1774441040369; 
 Wed, 25 Mar 2026 05:17:20 -0700 (PDT)
X-Received: by 2002:a05:622a:343:b0:50b:4755:949f with SMTP id
 d75a77b69052e-50b80e333b8mr46900611cf.43.1774441039749; 
 Wed, 25 Mar 2026 05:17:19 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:17:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:49 +0100
Subject: [PATCH v3 8/8] soc: qcom: ubwc: Add configuration Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-8-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
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
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1724;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=QpPLeZ1cqQr3FzN2YLabhHgQTjAgivfc8dfYen/DG4w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpw9I2a+J0pjGAmk2+Lny/aKCD6LOagAIf61WE9
 TEYbIYeoteJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCacPSNgAKCRDBN2bmhouD
 17vuD/9QS5FgUbK5hmT6VQaxuq5f9oHtrr6i2dqMuG9xEuhWta21qkW54rZd3HfyAjfUD6rcFTF
 W2efY5RshQmNFlCrH7+OEwjzkp+DsKzF7NLC1IhhGWjvM33HsXPL3B+dabBSBleM+J8JCA1QLbI
 I97cD81ad4nvYau1Go7JHqdSJFBlA1Z3GnOhLFgnLBmAV/Vfpd6dMvfgXQ5nzRphehCFMJOR9Om
 almvBxdKY77/to2cRVG3BM81fMCtK04ErNY/sU/7Qzdrg35vrG6YgL0nz++isdHHxZLJXqFs08s
 AFNlItUxrJtKJNzPByuiuzbhJzbCQ5ApVAjjv1Qpx+COSHB/XHP3t+1maUvBjm2xb2J0o0mN0Yg
 fGZ7VF0ctzyaZaPuDGjqj9+sC2W3s4LMLuTW8Luco3Q+gHnZf4WGOSBvM56OjbCpkkIZM1wspGu
 6XGpg8onA+nNlXw/7cg6L5egB0+qOpjTvAwrhEoZBFS1VMCcjV7JxZH1QLXw5Znf0XNV0R4V4TF
 WBvmUMrM+ZAxthHPGFEhcEukaVlaP99z7OOoyOIxfb+ebz22OHEPIHq+XgDhB7nbgMg1X2S44NO
 9M4Ggsp5X9xU/4Rpz5lmGrtKjWQr8RZKHmXXdPk2Egy4KkvTgK8hiERKXBnm/yADNcnQkN2VOSH
 TsY5lUlhKdkhcEQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX8/CBVpu7RJEw
 PVEZF9UnqR9AcTbV5AE/YLSSKB6hGmrRAgCAqodNdg3R3vs6zPUCVmAXB28obrJqnpA0f1KfH9t
 PNTmlTwagNjfvF4c+PXHGxayeeBaauNcyFJAAUQrfKj+JyTM/I4FZGs4mt/asBIsW9J2QL6wJMd
 VZrPbORMvWjIzsIt7HAVHGFszijHR9JU6kBtEHQ36f9P1MsI6oAWg/DelF5r1uj6g+NNnsvrIvJ
 9n2uMP5kkogDImekRMBpn/pCHVXgTb3sczfCVfx5i6gL2QjuWRhVAHlfBkyQtzAF2znMYLATIFE
 AbayB/9cbTm/yTaeBx3erYr+AHvntQw4rfY6BtpjKqzB/xey7lWaM9/nSPa9aUmPKp7R66W9GX4
 f2qic/tMZHKi6E+b191qBRr8NXg1LvVAMrQt1Uy/buMfBIpDXiP3wW1UCh47mhfftBje+IHtMe3
 0/EK/4QR1XDlJ1uXFeQ==
X-Authority-Analysis: v=2.4 cv=P5M3RyAu c=1 sm=1 tr=0 ts=69c3d251 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=VWhB_nMSBEne6Ym2UFwA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Hl9rFF1bSY7gWuDAEfNWZSTKpXnraWYj
X-Proofpoint-GUID: Hl9rFF1bSY7gWuDAEfNWZSTKpXnraWYj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Add configuration data and an entry to OF table for matching the Eliza
SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes in v2:
1. Use data from manual (UBWC v5 as pointed out by Dmitry, but different
   highest bank bits).
---
 drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 8304463f238a..134c7835e4cc 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -16,6 +16,17 @@ static const struct qcom_ubwc_cfg_data no_ubwc_data = {
 	/* no UBWC, no HBB */
 };
 
+static const struct qcom_ubwc_cfg_data eliza_data = {
+	.ubwc_enc_version = UBWC_5_0,
+	.ubwc_dec_version = UBWC_5_0,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
+	.ubwc_bank_spread = true,
+	/* TODO: highest_bank_bit = 14 for LP_DDR4 */
+	.highest_bank_bit = 15,
+	.macrotile_mode = true,
+};
+
 static const struct qcom_ubwc_cfg_data kaanapali_data = {
 	.ubwc_enc_version = UBWC_6_0,
 	.ubwc_dec_version = UBWC_6_0,
@@ -244,6 +255,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,apq8074", .data = &no_ubwc_data },
 	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
 	{ .compatible = "qcom,kaanapali", .data = &kaanapali_data, },
+	{ .compatible = "qcom,eliza", .data = &eliza_data, },
 	{ .compatible = "qcom,glymur", .data = &glymur_data},
 	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },

-- 
2.51.0

