Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD17F589D4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6BE410F127;
	Thu, 23 Apr 2026 13:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OEV6R9wW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HojP7UXB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C384510F127
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:21 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63NBwpPQ010073
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nayjuY7g5QVFWHFlaeUOOsPyzRCe/yAlG6cR/ITXMU0=; b=OEV6R9wWKHsBjjF4
 W0ZtMmUQMdnWtR/CrwHpgS5TF6gdu71dGYtNDWcS8PnyBCH1PU7ftb8P+0NydsBc
 /Bdd7ZMSg+6VlXFOBIH77Ck5DDsdBQkHz876b3qEy2FJ0L2GrKYU0W1hhWehGcL2
 8uOW5qV4iuA8L02NZMn20k7Vfo55r5VLbhDOSmcobpYtlSKIKojmZ71U4ZfzrG3u
 Dboqlp57bjjRMg6L5xumzMR84Al8yQOFOVVLtYrptHTydkc91VyPOHlnlPCQkIAJ
 pVukQdi4EoY/i4h9bruVn/IK4kZxdMpGEDdn1gVGhN5CQtA3U1VVz0MzbT72/YqS
 +BcogQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqk178ad8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 13:31:20 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b7a77b8ec9so6862785ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 06:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776951080; x=1777555880;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nayjuY7g5QVFWHFlaeUOOsPyzRCe/yAlG6cR/ITXMU0=;
 b=HojP7UXB6mwYE0Y6ei84LrOkVT/nwY8pk8284iNCqXU5OLKnPvq8Ql7xUv+2pxkTvS
 Y0KJ6ZwHtroTzGHKJFrIpoAOSNpNcHFX0OZq7ZpCX4A80vfyFZv1SasiyqGCcgquBcdm
 1uBrLTJkgB9tjGVbgSP9TbTd5jRg2K99MRoAxkzfPrKr7mwcNhiMJKtqfmByOVUgi6PO
 WYrsg21KS2FSzKmtCbttLEvHMFfgDliI74BCh4f/SN0T25upyjvd7TNENskJZ/8oOFgG
 21p8SLfIBbgzmMiPqcWyl5vy2Tx36wE8nDR97fBZ93S0VXG4AessUEYQrYchC9mmvtf0
 jmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776951080; x=1777555880;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nayjuY7g5QVFWHFlaeUOOsPyzRCe/yAlG6cR/ITXMU0=;
 b=opq4YNFbtm0UbtMWfbb9N8vY2YGnwteF7J0AX/iVmUQMjANR7sUUw/ICk0n76Lq2g2
 Ntv/ZsUQLwFCiDGlsKyk5glicGpNFMK6CqKJhLDWWDNM2RriOJK5i0gG+Qph72aJ/7KL
 mTq2sPRqm+yAid7X+fbC4zd9KrNTK2XwgYxck7lN63r95E07w8MbOrhLs1omQIvU2QW9
 h2MiIDiINN6Fz025M8DjlkD7Duh59KZH32VidOCPTqErysq8TGiCuBkpWeUVdHcMpp0y
 WpJzxteyvQkCR234pX+dR1AO6sYQ4jcGXV8mwIRQZ2HbX6asFAz7fZ4bUYQ9vV3h63Dd
 s6Ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GaDri+K9NSxe3Ah8NhGgFQFY1NXVWJIqGrCzB43qBKOUWoXzmkXl/YBKWRFt9iSyl5XTvAMF0W/g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzv8l2ggsJHrLGe+eogQLx9vArv7SDyqsMp0Y3zDmZTKzSLk6W1
 6L+6Jn3D7bcqxpgjNBjeNptLT+1jvVfU8qsJRvA0bSfxZ4Enkzyd/CjYmyMnrG+veWq9DZixCsk
 jPV0So2viQjJAw/hfNO5UT2CkoTWPp153OWkGk0x8qpOh7hDZ9XjS6x0Um8iiRTN/9eBLBlU=
X-Gm-Gg: AeBDieuTrtang4yYWtCgJxQSgn0+ahRXmDpC97UN3Vae1Bkl8XXSGbgSEz63hmj+iKV
 k1ADiyPBBwq4XoGlKnXz43bpxA7bvq9cowj6Cs3F6L0+o/AGevw2VFXJTKSbjfK5CGeoVEnJ5gK
 1FO7fRNXAIYyrDw8vTJsXjGbAhN4Qy6PVWGjGCPzJ9eG6O1ZOhkOBzCE1UWGas5z59h37dwOB2e
 vin3YkgOUtTEG8PuDju7k+ijmwCUCXPfqNEBOVSvjjupKxBWaSQZmErRbg/pTj/aOuGAGpBm1M3
 B5ofX3sKp9u3IFYo/b57o+kqR0uF38Dtb2wVKeOeATXaR5xSFot4KxMamWPgT4m/BDgeYVo4Pfi
 PXKkVAPCLQJ60mAD+CWy6coY1tU4LJKzUojpxjUZxejhBKq/Hep1XV9bzZe0ePIToAg==
X-Received: by 2002:a17:902:76c3:b0:2b4:6281:60c0 with SMTP id
 d9443c01a7336-2b5f9f527efmr211822295ad.35.1776951079572; 
 Thu, 23 Apr 2026 06:31:19 -0700 (PDT)
X-Received: by 2002:a17:902:76c3:b0:2b4:6281:60c0 with SMTP id
 d9443c01a7336-2b5f9f527efmr211821615ad.35.1776951078971; 
 Thu, 23 Apr 2026 06:31:18 -0700 (PDT)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cbaasm198795635ad.54.2026.04.23.06.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 06:31:18 -0700 (PDT)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 18:59:38 +0530
Subject: [PATCH v2 09/13] media: iris: Add power sequence for Glymur
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-glymur-v2-9-0296bccb9f4e@oss.qualcomm.com>
References: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
In-Reply-To: <20260423-glymur-v2-0-0296bccb9f4e@oss.qualcomm.com>
To: Bryan O'Donoghue <bod@kernel.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776950985; l=8487;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=LCMjOJtIxtHep2v0soQ3sUv2MXiTZMrsIoi3l55k2cY=;
 b=7X/KgTns18PVEGW+JrZHBV69wODcTX7hJ2smtGg1g7f1oG/DnqCmvhadmTbY/a4SUjPS/a2+w
 69rqAkfhfBwCWSwyuhuGWmWYYSCS7QeYMV5zBevR560DXNeInl5+Klh
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: LxyuvIqO1o1kwtR0KaX9GisrR-C91I8H
X-Authority-Analysis: v=2.4 cv=R98z39RX c=1 sm=1 tr=0 ts=69ea1f28 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Js87xDwMZ--NYW6i2EgA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzNCBTYWx0ZWRfX9iHwtr8a1s5t
 KduZu72sF45GYV3ieAwwOSak/okKvkoRlqli6DYfVVnVorIiOEA6H9zfIYgtIV/ublJXhh6ASKF
 EfAMcH9Q/VTEN4aB1/MT2bvtTAoIpqQFOJsCVfrDmHS1tcEfkJyzXXlly8PRWXwfgmJtv+uMw9a
 QTFHJpIopbxal+0ao5AFo0VUygMLGg4RbKYT2kasCA8ctSWsQYPCUUAbvUcb2aSjBxLInrV8/6U
 uTlwAmh+Syi9aGEmEvy4s9wbXRVtZAOk2EPYh3xBmnkGr0SSTSUQsU+4b3nVxAKUAKwdZwlh2g6
 vudlt6zNVWDNsWiBx4ns26u9Gly/3SMZ08KISsgxmSgwnj2hsDsXZs7mWe2CQlN4E/hLuFUpolz
 leAlGm993DfjRNEDeacRo+NfkWtVEHnFLxd/vdIdFFqH0TI7k+dIu/ivrNyDcmKvt1ndh7lnaCt
 Zdpm+4rOz5tpk/8akcg==
X-Proofpoint-ORIG-GUID: LxyuvIqO1o1kwtR0KaX9GisrR-C91I8H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230134
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

Glymur has a secondary video codec core (vcodec1), equivalent to the
primary core (vcodec0), but with independent power domains, clocks,
and reset lines. Reuse the existing code wherever possible and add
power sequence for vcodec1.

Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 .../platform/qcom/iris/iris_platform_common.h      |   4 +
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 122 +++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |   1 +
 .../platform/qcom/iris/iris_vpu_register_defines.h |   7 ++
 4 files changed, 134 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 7d59e6364e9d..8995136ad29e 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -61,6 +61,9 @@ enum platform_clk_type {
 	IRIS_VPP0_HW_CLK,
 	IRIS_VPP1_HW_CLK,
 	IRIS_APV_HW_CLK,
+	IRIS_AXI_VCODEC1_CLK,
+	IRIS_VCODEC1_CLK,
+	IRIS_VCODEC1_FREERUN_CLK,
 };
 
 struct platform_clk_data {
@@ -210,6 +213,7 @@ enum platform_pm_domain_type {
 	IRIS_VPP0_HW_POWER_DOMAIN,
 	IRIS_VPP1_HW_POWER_DOMAIN,
 	IRIS_APV_HW_POWER_DOMAIN,
+	IRIS_VCODEC1_POWER_DOMAIN,
 };
 
 struct platform_pd_data {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu3x.c b/drivers/media/platform/qcom/iris/iris_vpu3x.c
index a9f43dbfc695..bd70d1c0ea76 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu3x.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu3x.c
@@ -27,6 +27,16 @@ static bool iris_vpu3x_hw_power_collapsed(struct iris_core *core)
 	return pwr_status ? false : true;
 }
 
+static bool iris_vpu36_hw1_power_collapsed(struct iris_core *core)
+{
+	u32 value, pwr_status;
+
+	value = readl(core->reg_base + WRAPPER_CORE_POWER_STATUS);
+	pwr_status = value & BIT(4);
+
+	return !pwr_status;
+}
+
 static void iris_vpu3_power_off_hardware(struct iris_core *core)
 {
 	u32 reg_val = 0, value, i;
@@ -260,6 +270,110 @@ static void iris_vpu35_power_off_hw(struct iris_core *core)
 	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC_CLK);
 }
 
+static int iris_vpu36_power_on_hw1(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_enable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
+	if (ret)
+		return ret;
+
+	ret = iris_prepare_enable_clock(core, IRIS_AXI_VCODEC1_CLK);
+	if (ret)
+		goto err_disable_hw1_power;
+
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+	if (ret)
+		goto err_disable_axi1_clk;
+
+	ret = iris_prepare_enable_clock(core, IRIS_VCODEC1_CLK);
+	if (ret)
+		goto err_disable_hw1_free_clk;
+
+	ret = iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, true);
+	if (ret)
+		goto err_disable_hw1_clk;
+
+	return 0;
+
+err_disable_hw1_clk:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
+err_disable_hw1_free_clk:
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+err_disable_axi1_clk:
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
+err_disable_hw1_power:
+	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
+
+	return ret;
+}
+
+static int iris_vpu36_power_on_hw(struct iris_core *core)
+{
+	int ret;
+
+	ret = iris_vpu35_power_on_hw(core);
+	if (ret)
+		return ret;
+
+	ret = iris_vpu36_power_on_hw1(core);
+	if (ret)
+		goto err_power_off_hw;
+
+	return 0;
+
+err_power_off_hw:
+	iris_vpu35_power_off_hw(core);
+
+	return ret;
+}
+
+static void iris_vpu36_power_off_hw1(struct iris_core *core)
+{
+	u32 value, i;
+	int ret;
+
+	if (iris_vpu36_hw1_power_collapsed(core))
+		goto disable_power;
+
+	value = readl(core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+	if (value)
+		writel(CORE_CLK_RUN, core->reg_base + WRAPPER_CORE_CLOCK_CONFIG);
+
+	for (i = 0; i < core->iris_platform_data->num_vpp_pipe; i++) {
+		ret = readl_poll_timeout(core->reg_base + VCODEC1_SS_IDLE_STATUSN + 4 * i,
+					 value, value & DMA_NOC_IDLE, 2000, 20000);
+		if (ret)
+			goto disable_power;
+	}
+
+	writel(REQ_VCODEC1_POWER_DOWN_PREP, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+	ret = readl_poll_timeout(core->reg_base + AON_WRAPPER_MVP_NOC_LPI_STATUS,
+				 value, value & NOC_LPI_VCODEC1_STATUS_DONE, 2000, 20000);
+	if (ret)
+		goto disable_power;
+
+	writel(0, core->reg_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
+
+	writel(VCODEC1_BRIDGE_SW_RESET | VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base +
+	       CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(VCODEC1_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
+disable_power:
+	iris_genpd_set_hwmode(core, IRIS_VCODEC1_POWER_DOMAIN, false);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_CLK);
+	iris_disable_unprepare_clock(core, IRIS_VCODEC1_FREERUN_CLK);
+	iris_disable_unprepare_clock(core, IRIS_AXI_VCODEC1_CLK);
+	iris_disable_power_domains(core, IRIS_VCODEC1_POWER_DOMAIN);
+}
+
+static void iris_vpu36_power_off_hw(struct iris_core *core)
+{
+	iris_vpu35_power_off_hw(core);
+	iris_vpu36_power_off_hw1(core);
+}
+
 const struct vpu_ops iris_vpu3_ops = {
 	.power_off_hw = iris_vpu3_power_off_hardware,
 	.power_on_hw = iris_vpu_power_on_hw,
@@ -284,3 +398,11 @@ const struct vpu_ops iris_vpu35_ops = {
 	.program_bootup_registers = iris_vpu35_vpu4x_program_bootup_registers,
 	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
 };
+
+const struct vpu_ops iris_vpu36_ops = {
+	.power_off_hw = iris_vpu36_power_off_hw,
+	.power_on_hw = iris_vpu36_power_on_hw,
+	.power_off_controller = iris_vpu35_vpu4x_power_off_controller,
+	.power_on_controller = iris_vpu35_vpu4x_power_on_controller,
+	.calc_freq = iris_vpu3x_vpu4x_calculate_frequency,
+};
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
index f6dffc613b82..99e75fb4b10d 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
@@ -12,6 +12,7 @@ extern const struct vpu_ops iris_vpu2_ops;
 extern const struct vpu_ops iris_vpu3_ops;
 extern const struct vpu_ops iris_vpu33_ops;
 extern const struct vpu_ops iris_vpu35_ops;
+extern const struct vpu_ops iris_vpu36_ops;
 extern const struct vpu_ops iris_vpu4x_ops;
 
 struct vpu_ops {
diff --git a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
index 72168b9ffa73..37f234484f1b 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
+++ b/drivers/media/platform/qcom/iris/iris_vpu_register_defines.h
@@ -7,6 +7,7 @@
 #define __IRIS_VPU_REGISTER_DEFINES_H__
 
 #define VCODEC_BASE_OFFS			0x00000000
+#define VCODEC1_BASE_OFFS			0x00040000
 #define AON_MVP_NOC_RESET			0x0001F000
 #define CPU_BASE_OFFS				0x000A0000
 #define WRAPPER_BASE_OFFS			0x000B0000
@@ -14,6 +15,8 @@
 #define AON_BASE_OFFS				0x000E0000
 
 #define VCODEC_SS_IDLE_STATUSN			(VCODEC_BASE_OFFS + 0x70)
+#define VCODEC1_SS_IDLE_STATUSN			(VCODEC1_BASE_OFFS + 0x70)
+#define DMA_NOC_IDLE				BIT(22)
 
 #define AON_WRAPPER_MVP_NOC_RESET_REQ		(AON_MVP_NOC_RESET + 0x000)
 #define VIDEO_NOC_RESET_REQ			(BIT(0) | BIT(1))
@@ -35,6 +38,8 @@
 #define CPU_CS_AHB_BRIDGE_SYNC_RESET		(CPU_CS_BASE_OFFS + 0x160)
 #define CORE_BRIDGE_SW_RESET			BIT(0)
 #define CORE_BRIDGE_HW_RESET_DISABLE		BIT(1)
+#define VCODEC1_BRIDGE_SW_RESET			BIT(2)
+#define VCODEC1_BRIDGE_HW_RESET_DISABLE		BIT(3)
 
 #define CPU_CS_X2RPMH				(CPU_CS_BASE_OFFS + 0x168)
 #define MSK_SIGNAL_FROM_TENSILICA		BIT(0)
@@ -52,11 +57,13 @@
 #define WRAPPER_DEBUG_BRIDGE_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x58)
 #define WRAPPER_IRIS_CPU_NOC_LPI_CONTROL	(WRAPPER_BASE_OFFS + 0x5C)
 #define REQ_POWER_DOWN_PREP			BIT(0)
+#define REQ_VCODEC1_POWER_DOWN_PREP		BIT(1)
 
 #define WRAPPER_IRIS_CPU_NOC_LPI_STATUS		(WRAPPER_BASE_OFFS + 0x60)
 #define NOC_LPI_STATUS_DONE			BIT(0) /* Indicates the NOC handshake is complete */
 #define NOC_LPI_STATUS_DENY			BIT(1) /* Indicates the NOC handshake is denied */
 #define NOC_LPI_STATUS_ACTIVE			BIT(2) /* Indicates the NOC is active */
+#define NOC_LPI_VCODEC1_STATUS_DONE		BIT(8)
 
 #define WRAPPER_IRIS_VCODEC_VPU_WRAPPER_SPARE_0	(WRAPPER_BASE_OFFS + 0x78)
 #define WRAPPER_CORE_POWER_STATUS		(WRAPPER_BASE_OFFS + 0x80)

-- 
2.34.1

