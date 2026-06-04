Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB248CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30AC9113FB1;
	Thu,  4 Jun 2026 12:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKKcfbiQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P0IytbVe";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA131113FB1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:31:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6546k5tr3241567
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 12:31:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q5uBWSpIKAMT49XBoIDUyB5FAbxKelakvTHVeHNdNyM=; b=IKKcfbiQd4EX/21Z
 A6rxQE9bFiAjZalDxu5w+ZGExnX8akdriSFl4molN+SrcgB++6I0Zz4D6csgi/sQ
 CkVNQzKtcspqMHIMbZ/1Ew+/EPoQHgjinFCqn/7pMn4rSYhCZnRQq9rB+syYX4Hn
 U8bahJGzatQZUYPRngyTONXjAYU/hdaPQwlJkXUdaL49+8OZ5OUWTawcJv1AzgiO
 wzfdrfbmomKfTVnyK+YMhzJ624xZi+WLOnryrOe3b/ytmmDLFIndfHD2AG6xJSma
 FpzkfAznOuLB+XGDmEH92xNcfq2iYNYcc+4yQqPVOd71y51JDa3IluqYyS57nmUv
 KFKbvg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejvd0avgc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:31:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a329928dso1088773a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780576297; x=1781181097;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q5uBWSpIKAMT49XBoIDUyB5FAbxKelakvTHVeHNdNyM=;
 b=P0IytbVeVN+LU1jlHSYn8h5ejCALzm5dicnHlO+jWrqTxkUovZPMnhmc9wLibalscf
 TaM/6jh9clEvz73SyfkC1aFU1NoncdgvIdHSSy0YN6Hnp9uwd1XtsfWHubhdcQUEm0t5
 eS16I6Xd38pOk27ykx6wy7s0pvVB8y2qgencNmP/7vRItZc2WpHTKFSKHhLcbgeUohOE
 elKPIpLTIydlum0qx2AZekgTGlFYrEJ1SCJfeeCJjubk0H16FWfGJ5NcFAJbfKqCYeHP
 /GToBd89YdLU4eMw/NPUoPpGeUPmuQYbakgVL4OnH+snU7B3lLFQeTFpChF3G0gBTbmM
 xo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576297; x=1781181097;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q5uBWSpIKAMT49XBoIDUyB5FAbxKelakvTHVeHNdNyM=;
 b=VmpVrKBbOo2UTpAovzYfR+QyaoryIEkAGT+X144tLpoqV7+CJhWw936JGfJXM99AbT
 26gufaNs9ZcwH0Dl10qiMrrtBL89odst2wgrMkWkwq1Y4Q6HfDaJmWQiqsu3kpIc/LkP
 KgaGsjbt497gcnhAbn6a6JYdcEYo9leUx6BT0JXvZ3rpxVl+q+5y+1aRANwZCV4eCmWX
 5NXCAX2eXMPo1F4m+cDU6wZ1I/opzRBj7PzLrMUyei8G+5upXYkgC9S+f/iv9iHeFV2E
 tmLnlDM0xmX93slnQ0ga7rEqvzEWsfLQpC6b8cZkAwWdnpu22Jo049meqveQfnOUp8Oq
 2KtA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8REx1YOLKjXuhZ58bl0TWjlqPz7rXJnTkN3qNBjD7k9qs1+xvxPIAdovI3XwwWDoGrjJPoHWfeUpQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy//4g7jiToMCsv3m3ic/eYqPL67qbrLYbUQBO1oJQqV5kHjADi
 chFVDMa3BptrZy4OuFPqm1ihFWBtbJ67k5tvwmqTa46ZWLrWwaOmQxbFafUPUVKiv4AocSu+vlG
 fo5UpNyNBPxQBx8Ei95xbjHjuJsWbIeDeJXZnrpbtkyqEVe8g6fDjti97aDsXR2oUSROMFu8=
X-Gm-Gg: Acq92OHwTtBw1QE0eowhpjZyvRSsH2u0ju66bY4UE2KzHjnP9EGM+4i0G5jwE2UaTId
 +XZB9z+IVU2pJkNM5NDlRZYQIHfC6dzm14I7ItyKCqptdbNFLHqbTPu6by8pGFLk8hkQyE/X737
 oreAnr9A0WyED7pg5DISrkws5cQaoWPL6RMvOB61mQ5f4R/2inhrpJgMGXIwFisCreK4xcUYB/G
 XbcJvI068jGrFTHynGb2hn59036xNxExpVcVRqB45z766RWU24pjj4cQgbddihacrUZRKZkjlW5
 mejDpzXN7vIeR6oOBwQmgKKMF6jDCY+QWs0BxkyZHK1Ufmfl9rsF+CV6ZS7JRgWH2rBvP9vCSlp
 9iDdI8deVFCgy0zOUxPAQcjrDpyOTsMYNhUDENN9JAFfWKOoiYAVAcUYjIoI=
X-Received: by 2002:aa7:8887:0:b0:82f:355a:857e with SMTP id
 d2e1a72fcca58-84284f19a34mr7916033b3a.47.1780576296745; 
 Thu, 04 Jun 2026 05:31:36 -0700 (PDT)
X-Received: by 2002:aa7:8887:0:b0:82f:355a:857e with SMTP id
 d2e1a72fcca58-84284f19a34mr7915977b3a.47.1780576296198; 
 Thu, 04 Jun 2026 05:31:36 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428325d9a3sm6015917b3a.34.2026.06.04.05.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:31:35 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 18:00:49 +0530
Subject: [PATCH v2 3/3] soc: qcom: ubwc: Add Shikra UBWC config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-shikra-display-v2-3-b3c1b2b67edc@oss.qualcomm.com>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
In-Reply-To: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780576263; l=1005;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=RszZ82isccZ6HTay6fmDewNiy8+hVMevI+lNe+sJbQQ=;
 b=b49w/HlsBNCONlirsUpO5rkEIu3aZiKg8UbSER51g6trjxtIHBA3pBF3VltP4RNl+n6X4WcDy
 tWxKEYVttzaCry/mB9JVehbo1q/1hFQVEJvE8KFVIUyofFNpmhHZ2ea
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: tIgBd47pVBgZ8v9rh9kGDsfHmmCHw7yh
X-Authority-Analysis: v=2.4 cv=M8h97Sws c=1 sm=1 tr=0 ts=6a217029 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=vtxxaatxrD0BdpsZsnUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: tIgBd47pVBgZ8v9rh9kGDsfHmmCHw7yh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyMiBTYWx0ZWRfX7LjptOFixzk0
 ukDAe7bKV9XIWImAjRccEbIORK1CK/w0SUu2Emnrx36NZnqJ61avMbdo6YCSUSgEQKXGjQc8/Dq
 NSmeLEB+aq3lHHf6ULUcYqQoU19Nmwrxx55tgGF5+uRttG3Yc1ac0gR4emtu4pcnjOH/3cr8Uke
 vzXNXflzed51zVjNuvx6e0kf+7O9wekQLWFeMGcPusGRe/cFgYfPB/LFUi92csjN2r3zEXGfaUr
 8TTkQMSZNASsaU52eAm9smugO3VuS4T9XXi86YnL//8oJzcaZwb4zL1aDFZmUN1QkarwYCKemhh
 CtUSQDweU/TA1KAhs/CtuaReDJA/Z/xGjyoazvx+fkXIPvs2ao5FtOVelncYdL4JbzHpfyYn9PC
 b0FIxtMYMz5reP+KZG+yCK1HlmrfSLCPZDf/ubUuvN3jBtnigzQdgWWWz5kguf3tmOwEQArOLX1
 KKbnK56WKGn3Z8s13sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040122
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

Add UBWC configuration for the Shikra platform. Shikra shares the
same hardware as QCM2290 (Agatti), so reuse qcm2290_data for the
UBWC settings

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..1a2e54c6480d 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
 	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
+	{ .compatible = "qcom,shikra", .data = &qcm2290_data, },
 	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },

-- 
2.34.1

