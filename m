Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12C606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ph7Tec2U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HTBTsA68
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BD210E839;
	Thu, 29 Oct 2026 21:24:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA75410E7E9
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJk1bG3718143
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=k99yZnPO//u
 kQtkYAl64CwdQpomDxI0ACN/FhmeAnkU=; b=Ph7Tec2UImH0TA0hHZJxI9PY+gV
 4RgrfuGlj6cfSV3KRpT3h1tiZIc8syLaeQpZM+h2XLHL66cXuBkY3QO7u643dA0Z
 TGo2gCl4ynKB9v0b2M+uEta1c1qA3g3s3fF5RHYGtxoY4lR+zcLLABWpcVTT9zXt
 mCddJ47Zexo3Lke5hBHl/14zWyAuEvEfsAGBKFcxYNvn2e7XDwc+QHryNq27V0gr
 13AXaRadWKoHjQ/1cE3yMs+hv/Xan8eyHTQKqSVx9pAFstH/nlWyyT0+ZtOlY5fj
 rfqxGd4WzdlYtFw69ak3VCW98XohMaRpPVxQwAzAtWQFAD5Fdw5qwMuv8Bw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm31b372d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8a05c820ecbso3496850b3a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793309031; x=1793913831;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k99yZnPO//ukQtkYAl64CwdQpomDxI0ACN/FhmeAnkU=;
 b=HTBTsA68BkDFf/VyW1fiMaFMHMsUf32SaY5bnAlcjaGCRNLp9wMjg9Esru4JXBaCts
 PIl6Zi7rtsHfF8aBeD+UuTWqIIjTPcED9B0xQH68iEP4xfkae9vV5H6jxOIgWxhDWdky
 jtpxH91/RttmT6bBXUvB56uYY36NW6DnT0W+YzEoshZ4iOdnbwyqsWuI3o5lv0A17oOY
 a6kYnGuYbwZP6HyF1ZrO9Trol9H5M3papDBd8n8tLYp9xINmnMJVZPoWgT61LY5Iep0q
 fCBrOtjtLjEitSwoiFgNXZHIJg0zuosHmUEYqIutAJzFsIlk8CkgveOxK4Q23dapaPNi
 Z3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793309031; x=1793913831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k99yZnPO//ukQtkYAl64CwdQpomDxI0ACN/FhmeAnkU=;
 b=1dEQuVqFpYLFHwSSt6dzZ2bKpU63gCMR5bQPf1LH2kFdIxdmx440OqqyuY8yW1pOMG
 aZQAEpelsLvXCPY+PxGYczHeEbLOHXua1Yaw24aqmAYxgThfvlzTyPPqmV2faWs9R2DZ
 o5T7xATf9xPphP0fGc1tNUf/MSgiHCls1lhFjIzs1SC2w6VoWcDI+pJTXM8IJGIOtv7v
 76yHmgrUOgCmYJB2dD4qu9K/KCY/FZJBgwNfbBDtjML6bGrNdlGCJNZ2cDQvFaYepbG5
 H0Lra520mPR29HXCR48kKALVJd/S6Q6Q2pDYGSwb+ApDeR21M9LFJhaG+6jSEfDllT2G
 NojA==
X-Gm-Message-State: AFq9FYJcilHPN63J/8oJw5enYMt35AUi/rxiwQtcaVuo3VWBfB/yN+3u
 f/8+ZvoQBYuX7lp9MsTceulp/uEvCE+y3AduAN29IyFrafAvR+R0pgrNbuQ0h7sbA9s154gTkGo
 +4d15NNS5EaFhZ2eML1ONcDTcLd2vkFvZKJuBbnDko9M+J4tD0Hq9u+TksJsuU4vOBric7PY=
X-Gm-Gg: AYBFou0v7tvHDKLexDyE953fmi95Tq+33czXckoBWn8OEVqgfNM6sLmr25f7Lb0araf
 iiHFy0ACI5aXphooJ0a6kRX0DDdjeMWaqnLvoSa1QUSpTeWJCCYTcnCx7RmZpLX7T+Tx+iG55+8
 c+0eBrvEy7UDhrr9S9j5LLUR1PBYUqoz7IGy5+CNDZNG4hTOnRxdZW8LAMFGGkJ3VUK/PlC/WRB
 FsQYdfe+T0hlhjBUgxvY6UPseAxPZcpRCmgIjC9jz6+iApDAYCDnn907YMDFKOCmPX370DWHBTd
 7JxpyyM4wB5UNC1yHwl/21S0luvp0YEvMjGuTkB6sEPt89grH4jHKp8TEuVS/+//qoIwABU700U
 B05VcH5WgrGLZG8FQ3854rCo4/pnbtFY2xqEmExV+PVVgWsux6/U/gFgmgumjqcx8V3Em42mr8R
 GlBta35sYbBgGyk0q4CuHxcQ==
X-Received: by 2002:a05:6a00:3a1c:b0:8a0:3ed7:93a3 with SMTP id
 d2e1a72fcca58-8a9be7790c6mr302319b3a.29.1793309031374; 
 Thu, 29 Oct 2026 14:23:51 -0700 (PDT)
X-Received: by 2002:a05:6a00:3a1c:b0:8a0:3ed7:93a3 with SMTP id
 d2e1a72fcca58-8a9be7790c6mr302306b3a.29.1793309030908; 
 Thu, 29 Oct 2026 14:23:50 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a98893d1f4sm294090b3a.12.2026.10.29.14.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 14:23:50 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] iommu/msm: Use identity domain for GPU and display
Date: Thu, 29 Oct 2026 14:23:43 -0700
Message-ID: <20261029212344.346069-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX75LBEhvjGn6W
 cvwroaLc+Ap9cFZGf8KDVpBF2UfPnQTacO4izDvnFJcf/dDTwvUwJT0mg5Da03dmZKVHoxkEkiY
 ySnxO8e3K32XiLvqQPRQ8x9inayE95U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfXyxvWA4v0tWdF
 G8iFEIn5POkm42avvAiLWcAgLk4/56mOIR7lLc6xA2tEPPkSm0lbkCYtqjQM1k8x/fLVnutb45A
 tMVGsraLSQba1yfkIH02/7KyodGrbFVJglbT4OesNlF6gbw8E0Z3DaezMAZ9Vi0dOAfXDA5cl52
 tfEdjrw+b6ClWm4mSJCr/iBDfY537Z6zfPq9wSnk76QKUpZzjtGDyVBnoGwn1lwUibqXueM/G6o
 5PQA8kAQAaplQj6q+9iCzzlf475zLFuEUWpK7WqFVPQ1utFCckBUmXP3TtMtA9dAY2oyO+aJ5co
 f0uXQPOonk+TYp/W/MvTZiXA/yqhCpbIUeT9ElTKO4su6hxISnnA1gmoI0znNTabrb3Y4AMew8m
 dDMcyuiPPQ41GhHdU94cTRfRWZxnsEdlXjqnTdcm5sOwwd4tCFMwljTpHdbbDs76gmgKgqso9lW
 efhobTnUKW1D2ieqeQg==
X-Authority-Analysis: v=2.4 cv=A8T5rKWG c=1 sm=1 tr=0 ts=6ae3b968 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=554yuftmPdPD4gaTNL8A:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: mPl-xTWVyEKykvlOAwt2kbj3xuR1meKA
X-Proofpoint-ORIG-GUID: mPl-xTWVyEKykvlOAwt2kbj3xuR1meKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290084
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Similar to commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to
select direct mapping") for arm-smmu-qcom, match GPU and display compat
strings to pick identity domain time.

The drm/msm driver attaches it's own domain, which it manages directly,
so we don't want an iommu managed domain interfering.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/iommu/msm_iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 4ef1e8c8244b..1c5011432628 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/io-pgtable.h>
 #include <linux/interrupt.h>
+#include <linux/of_device.h>
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -691,12 +692,27 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 	return 0;
 }
 
+static const struct of_device_id msm_iommu_client_of_match[] = {
+	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,mdp4" },
+	{ }
+};
+
+static int msm_iommu_def_domain_type(struct device *dev)
+{
+	const struct of_device_id *match =
+		of_match_device(msm_iommu_client_of_match, dev);
+
+	return match ? IOMMU_DOMAIN_IDENTITY : 0;
+}
+
 static struct iommu_ops msm_iommu_ops = {
 	.identity_domain = &msm_iommu_identity_domain,
 	.domain_alloc_paging = msm_iommu_domain_alloc_paging,
 	.probe_device = msm_iommu_probe_device,
 	.device_group = generic_device_group,
 	.of_xlate = qcom_iommu_of_xlate,
+	.def_domain_type = msm_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
 		.map_pages	= msm_iommu_map,
-- 
2.56.0

