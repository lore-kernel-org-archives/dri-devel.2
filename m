Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E4606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TJCZg4Pz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SiD6ct6C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBD010E3E4;
	Thu, 29 Oct 2026 21:24:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A6210E485
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:51 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjkhO1122782
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=TzzXFuNiq+D
 OToFpekJQ4MBDEjsWCEdNN/aJK57pRJ4=; b=TJCZg4Pzwyuj+Fp2/ydS72faFti
 vP3k7bkoejYpzXKZpeGpYDqEV4YMyXzaaKVT86aBPvF35VGulkxcpcMEB5UwKxEg
 v87XtV9m78Vj2ruauEckOTuF4xWrSax0/sG43AyBEhSH6hdlW5xatfGpSnL15t4k
 51m7V5nt9RqDjGSRsoqXZLsFcXDSDgMOPN2JJHtUYK2mY2oy7WqWvjTbckkBcMaK
 sBdhNG7YJkszATsByXuaYbQdH67t1yrhnsyllTN/Rz+6X5TRUql/hUWHnNiNNDeT
 wyks8KMLfBOl8FsI+xy6A/+KVKmPpT2EwZ2XjraoQda5vDmT5469CjodvAA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm8k4k8eb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 21:23:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ae1d132d52so42325a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793309030; x=1793913830;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TzzXFuNiq+DOToFpekJQ4MBDEjsWCEdNN/aJK57pRJ4=;
 b=SiD6ct6C03LreO4ayVdB+Giiq/uCUbseE7He4XGGs2keoQ4/cRlTz9B28Po4HUHfXL
 r4VmbXuUxUcxIukpRAIlqp63I2xdtEUE7w8fn3HDF2V4FQZgFyzgThWVQjfpi9XyTfHU
 NLtNtVN2HOWKEWOJrdNIiT3mJimsZ5F0JRfLiG0suc8YnEv4K+Z+sciq+pP85gNdFPKf
 U8YQ/sXoHucw9sGbQVaXE/VHrRsDfMGxltQDLkv298QK+439Rq3kweVkaRABQ72KH0jg
 In9o96ZAO7koIyUN1BUlMZVkH6/oB9gv1N1Uy625I/k0nJbCvJ1+XmTShBGi/K70CkjW
 IMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793309030; x=1793913830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TzzXFuNiq+DOToFpekJQ4MBDEjsWCEdNN/aJK57pRJ4=;
 b=t7SVJRXI5S6ceI8MJ6YCjBNPKEpFoUGtzeLPW3VXiEytsoqeExlSumT5YGLJVWXSw0
 GWY7qWebfK86jcUgyrk0LWs5u/bS18E7e9rB87639qCsz0S+DDEZbH4mZ9rQimp58AWe
 rgEnYdCmrw+3TNTA8/gzrY0cwf55CWBIk+wFGAdC/7vYPnIkGbCIQezWsOs2eUj98SVj
 lZm2a8G6Rne544QHha7p2k4n0ugnKnQYODflGacEJ12p7pz+JD1VAcuGLHOaLcclCipk
 b4bnUvbtYeqigZGKaAF0D7SMh6cf0OGm+9jPRwtoOiqnbiNmi2igZ6MS46NaIspNX6d3
 /hpA==
X-Gm-Message-State: AFq9FYKMbgz0B8eOv5QOegy6+Q9biZEO37Ff+mEhIHu6hD28WJgRSiZ7
 KnV0A9wn6/5dYBajvFx+UFqpW06cDAqq5SKDIAsYUSzs1ff1S0QlGEYgDCFobbAcbzFWfV936I/
 HWojVfqDUroYXx+WY/9JPXtN4upY2CzPzZ7Y0j+Y/7v5dDbZNF0MQZcBoHFQwk1RE0VTYiqQ=
X-Gm-Gg: AYBFou1ZoUja5elM+vGw4/IasCEhNv6ALoK01fryKiyWHDN4PNySq10mCBu7me75ceS
 BzIRiWziLPL9o8HEnu53ntRdMcJVIzv/lLA2QdeLfyBeLV7u5ufQepJj9tn0UCEqz51hk0KeBZ7
 mjmheYJW6+qbFwppXCnwyWtJqG875OoD8LZVl6WiRUFXwcymPKDzDM1vDq33++EYfoPxjG8fnTm
 R/1L2tVHcfgpQPvtNOHJSq7VC4XgQehRMTJqsZVWgfSjyPnke8v7aERafM459RUaJb2Sj1R48yL
 y3y04rJxo9zwqaIdEftQ/6d90kloA1AzukRet7Qbk7w3QZ+jgpH+QUFNnsSKSqDy19tXe4Wb0Vr
 B8PAl5KV23Z4UswB942A/aJATLwLPnS7EDc/4Nm/0Ta/ka7pLSCnm2e2JzN4NGzDcc8OJdv0+M+
 IqYAJuk5LKmxqSNAYf77PlEg==
X-Received: by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9 with SMTP id
 98e67ed59e1d1-3ae89744ca2mr193132a91.25.1793309029940; 
 Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
X-Received: by 2002:a17:90b:57cb:b0:3a8:c0cd:57f9 with SMTP id
 98e67ed59e1d1-3ae89744ca2mr193115a91.25.1793309029488; 
 Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845aa27esm1054544a91.11.2026.10.29.14.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 14:23:49 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: iommu@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 linux-arm-kernel@lists.infradead.org (moderated list:ARM SMMU DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] iommu/qcom: Use identity domain for GPU and display
Date: Thu, 29 Oct 2026 14:23:42 -0700
Message-ID: <20261029212344.346069-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
References: <20261029212344.346069-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfXz2lZHD0ed9d3
 T7t/F9GssRgg2ANdMWWA6aRc2WxlEqANEPEg07si8j5Z9ecdhZplkKumE73+ws+2lTcLVmVinAi
 1KdAiM/lXWIQBEs6UNIsOdXfI3YnJMZUVhkkrlEI0qfW9RS/TFYvzGnSA9BmesQbBfssTZSrA0e
 7iLRVNvp4dbqOKgugDE8eeYdSgRgTBcQq9P6vIrjNIL804lt/+odqoOD2JojMHv+GoDBqJiUicc
 YmmuV/tRaxDicFumgIqEf52xbjE8b/fQqdZZ3BOUoy+ocdVTP8NnCUijKerJbnu6gcAWJnI62Sn
 D5JIEC2ym/4QBRW36ZeOAM6LO71KrmWFuSj6p0E6flHxjvVUeEUSWqAp00jatu0aXayZd9vrir/
 +6N2zJMjuMmSV+wmW4wjEjXQ31QzPC0M276u0d1n/IvA8KNdZ8Cd+yRyMPmco8esBwcfThfVRWH
 hodX09SnmThbZAC+cuQ==
X-Authority-Analysis: v=2.4 cv=LuAHWXdc c=1 sm=1 tr=0 ts=6ae3b966 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=554yuftmPdPD4gaTNL8A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Oymc-6spYCEVrVJiPPp8k1f9pgrJ17ni
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA4NCBTYWx0ZWRfX8P+foXcg7FVi
 KCNYfmYpWPEZNnaZYfR6dW+h9YD+noRpncIPVPRDUkHNlWtQYCFOlrEk8PEudVHppYPy589n/gA
 tz4w+xOABGJVQBwAkcr44BeSySBFVBo=
X-Proofpoint-ORIG-GUID: Oymc-6spYCEVrVJiPPp8k1f9pgrJ17ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0 suspectscore=0
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
 drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 21d18ce67b98..5b10feb419d8 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -22,6 +22,7 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
@@ -589,6 +590,22 @@ static int qcom_iommu_of_xlate(struct device *dev,
 	return iommu_fwspec_add_ids(dev, &asid, 1);
 }
 
+static const struct of_device_id qcom_iommu_client_of_match[] = {
+	{ .compatible = "qcom,adreno" },
+	{ .compatible = "qcom,mdp4" },
+	{ .compatible = "qcom,mdp5" },
+	{ .compatible = "qcom,mdss" },
+	{ }
+};
+
+static int qcom_iommu_def_domain_type(struct device *dev)
+{
+	const struct of_device_id *match =
+		of_match_device(qcom_iommu_client_of_match, dev);
+
+	return match ? IOMMU_DOMAIN_IDENTITY : 0;
+}
+
 static const struct iommu_ops qcom_iommu_ops = {
 	.identity_domain = &qcom_iommu_identity_domain,
 	.capable	= qcom_iommu_capable,
@@ -596,6 +613,7 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.probe_device	= qcom_iommu_probe_device,
 	.device_group	= generic_device_group,
 	.of_xlate	= qcom_iommu_of_xlate,
+	.def_domain_type = qcom_iommu_def_domain_type,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
 		.map_pages	= qcom_iommu_map,
-- 
2.56.0

