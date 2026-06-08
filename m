Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BB8CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEFE310EDDD;
	Mon,  8 Jun 2026 07:02:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJ66Fx1B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kJfNgZCt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA93F10EDD5
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:02:13 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6586P7372386295
 for <dri-devel@lists.freedesktop.org>; Mon, 8 Jun 2026 07:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=; b=DJ66Fx1BswjDUyEg
 +m9kBhO7qIXWhbLthFaXsPksqnt3w589fO8O6xJ1eWkLomEpC2nrTxxZ2t3o7ZhN
 DfpXFai3Q7Vby04dgnfSrdHzQcHaGS5O2SQ1stwlgogRAQ9hB7SSEWJBR+cGtYmM
 5MH5CWg23cSuXsBcLk31zDjKxgfCbYoOUllAbLTjgBHLyCbFEMyfFZguoxbnyFvH
 shA97w++ZxMmstGOOkcdxsjUTSaKsKsyTZRu9KCG9d+NwJqm6jY/E6Q4g4HGuscN
 faozQ7bHiIUUs1t/9pwf9mh9SPeVriOcvw5R9wXPDZqKpHIW73hSgapKMA/pzOMh
 asULJw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embs1ea2a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 07:02:13 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8424aac207eso3480283b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 00:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780902132; x=1781506932;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
 b=kJfNgZCtgVidLWUeuBUmUJ+iZD3agOD9/445t3RIoye9e4QUWjS2NssAd2BmSiiVuQ
 vHkswvlxpte3tx0y13fiTa/HV0xaAPz9CbntOMrEFi4RGoVBTXW39+Ih07o/4RDJsjMM
 G+hdKZP1UhItxxDPuldsSMl5gz7RGa2vXz3H4L155gDxk8Os8geDN5mdq+wP6SyK2Z9K
 vGBPll8b40blVdJuHQQpcMzTvC2cTN4XkpLNYbwNl07+gaHstoQOilE0WrWo4fe6GYVV
 PritdCW55xI47qEf0mtjoXl8SbbBrO2vFkKUyuZWh6afrcF5I6pYdElAuRftznN+ZMXW
 mvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780902132; x=1781506932;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jg/4zRj4OkceNTXlSoSEHKDpleifNPnfj3feVytWbh8=;
 b=d8Lz8i7fLm5QDFRdegdKsbPmQoDfNQJleUzHl43e1nZd12HnTev5qyRZM6WuiyVOrD
 LkpdL1JarOYlEXSBlnq36NEqWxxUGT3TrMD7paxTlB7OD726eyEELQCRd1q6SEUXBX1M
 5esRsdf4LaDwNJHFir6+0zkh21Q+HB7SRc3hiX+9Elcbm5pXuZsv1QtWxVpuu9L3kHA5
 cq3X9YmBQDjmlHwyD36Km17gQ0SN/xOEez7RayhymYt//yPDY2ixNCmXz2EGda+SiFiD
 yxEGo4pgf6kSrDmdMziCaVjRb6bPKR4EHS2HIhJ0nDSDzw1aC/I5T0Z2N1+p5dMjt1N+
 tilQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rTANjDY9AbbuJK7T2yGjPpC3S7/qLEci/v0NtFy6pXZQmLMrlMkG4qyAVvO2+jbTfuqVLSGLmljY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmBQpYZLhG68uLwn2oD11KaDllqTQkupwehYrhYR647pj2nxNp
 lbK4wcZQOA9RXQcAws/3qkMAZ2uaFJD8hjKC7vzJeX47IMyR+xxn6k3eWMrQJJVzkxtlzI/sMxe
 DzTDiNvfgyDmrwlSJ7FkGgst/6kPs6Wt/zzg7pW1Woz+TS9EWkCgtwBwJc/mC0rOxdFFxOKs=
X-Gm-Gg: Acq92OFeMc1PdXIEtZC6FXZSUllOWpm8/WH1P3Y9FM37skxgLAIKvJOdu1BY41fAGXI
 28yPyASabOYrhGkXayZPLAEp4VloaGg9ljj3CqYpV1AnGUaHQKZDKVXN4ihNB1C9DqcGkBnQXZz
 RtPEfVPknUcYeGKBLS8EIbzKetAqxCrfWuQg80eYyM2UYBnqNAhtqhWhkr7foeEwabZpTTscl3V
 5dSD8A5XRW1Skp3uJ6H9hWSiCWic6KxB9/AHMqCbStLYsSC+Bb2vmLO+nkh55992qe8qsnYAIFk
 5C9DKJRyRXZ90PGeFtzMuBk2RDQ9k2Pw5pzjN1AQH0vax8GTmeBGP5fzb4qZGY6PPrLMiAjaLOi
 Sb+qK+CKTlUnyfnJ1YWt3+dxxrV/o0l1Q6SKzxMnHRXeVCB46DkQKwzG44Uk=
X-Received: by 2002:a05:6a20:3282:b0:3b4:6cae:4a51 with SMTP id
 adf61e73a8af0-3b4ccd60b95mr15783338637.11.1780902132547; 
 Mon, 08 Jun 2026 00:02:12 -0700 (PDT)
X-Received: by 2002:a05:6a20:3282:b0:3b4:6cae:4a51 with SMTP id
 adf61e73a8af0-3b4ccd60b95mr15783282637.11.1780902132028; 
 Mon, 08 Jun 2026 00:02:12 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c86151154a8sm6267723a12.22.2026.06.08.00.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 00:02:11 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 12:31:43 +0530
Subject: [PATCH v4 2/2] soc: qcom: ubwc: Add Shikra UBWC config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-display-v4-2-88a846afdd5d@oss.qualcomm.com>
References: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-display-v4-0-88a846afdd5d@oss.qualcomm.com>
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
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780902106; l=1072;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=rVf9yUiI4s1YDWhWJ0K07qBAlGQcKyt9Ku/bgoySARA=;
 b=ny50TIyWUidyGAoanv9GgdCfanSDF9NUNBpKf2lLq5HsfD74oor5jsEU2fR/ek82X97Y7wl5a
 pQpTBxFfCAWD6I+WS5VaSGpScGu+HZgiinG9WqdVvLOmKN6/XspjrnE
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX9XuNGwadfabe
 SYWplPxmpGa/3Lzhz0cCA5sGgWlxFTUY55tID8znBOs6vqGXnUluRjbvRNK5r5sMcDdPGzwAesV
 muOT89tCUDAJrzIhxDb2vYF5jsZphElUx/N7fCJo7HGsuo0BL9rZvV28zXZVpY9u3cOX9CMCrI8
 5ldbT2QfxUymFHtK6FWjnMv1k9DNd1l7cnr1i0rPaajimaHkR0bk+Ee9CL4AXDs7NYHjMjTNMLv
 aAqYR35Ut8WwVxMVK0+L7TDdBfIktyszYlR7ZkRG+Ylc3dOqY1gqpIcjdunU66RF1JYkRWCARUF
 grrRCFKQDrRFjnxLyKzcf9kqcDB+fxPgyLItz59+Xi6T8CACPLSNuQW7BzOPe0OyBvrGycoORRk
 fPE4Wk9oaLKUZYn/PbLTFmOMt4U5KhQJ4SPPNB7tF7lTbv4Gh7IQI/wo1i/BlSG5P2WX0E0+OIZ
 c7mEqce5QFWPrrpaX0w==
X-Authority-Analysis: v=2.4 cv=CeY4Irrl c=1 sm=1 tr=0 ts=6a2668f5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=XuKMx7f3ltwE3Y0lsuMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: Dw2HuAtqdYj7Wm4W950VWMfJ7kOU9PAE
X-Proofpoint-GUID: Dw2HuAtqdYj7Wm4W950VWMfJ7kOU9PAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080062
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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

