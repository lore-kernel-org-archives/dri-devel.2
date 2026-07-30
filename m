Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D384C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C8E10EFD3;
	Thu, 30 Jul 2026 16:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P59Y+N5L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8MAFoxr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE92810EFCE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UFQrIP1145264
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hQB705iUg9cjPgL+aBVmOnrDJY/xYVqVa7zVBN3y69c=; b=P59Y+N5L7cVuDVWt
 zuGX2bG32jSGlZ0SovPg35dI0f5HBwFVcTOylO2/2+c0jWwVxPe6hLPbUzca5YpW
 m0bVcOX1RqOi5WQscJW8y3z5r3DIAV9/b00ZallZvsOmpPLHJvgPK4Mk99MH50fF
 bR3/G57+apjiZKrKSII6IgvcW6NcKQHgCndt2bhKx37reFi0e1N3QhLAOyEb0SwY
 uqJEq7TnZQKJwC09dSHbYLXPwzwIFwpAfc7mwHc9aYFGLFbLcvf23nVn1AQ/aoZr
 zhZoyN0JphAcyA2Az3XtQvSE7dUC9+oRmboSwakPqFwq2+nvg4FwYi+ueo8TXJcy
 fs/cSQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8k60gxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0199faafso24547851cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785427504; x=1786032304;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hQB705iUg9cjPgL+aBVmOnrDJY/xYVqVa7zVBN3y69c=;
 b=E8MAFoxrPakWHELfKxpWrilCo8afNN/G9wHxAEORTQ1+G2ILB1kE/nR4EvGOlsOE36
 aTYcXe9/VHNEn/DGfZkn8U0+45O3UYT/2izXiRjbGIqHBzRhuihWXra2MUpYcg85EN6A
 tMosk+B5rJhX3Gb3eq6e6bRS7Rv29/jsCtSSVi48eIhfa5+uhYGhVfTmVDYdgQf63zGI
 wyV13A++9GPYjLnC8O6XzDSC0MGQ3EUnR2624MkPQji0ijMDk+Ovonchtnq8UsEB1nfi
 W95/cLsOngpu3FR0XDOPOjwGhdacnAOtVgvFflu/KZbq4beeyea966fLeGqdrFRrWCCT
 /ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427504; x=1786032304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hQB705iUg9cjPgL+aBVmOnrDJY/xYVqVa7zVBN3y69c=;
 b=NxfuJu67nKmUh2MZ2yOHfOQMKlnoRAI04YXM/A4jrK9tt9yALkNDXMj9+6Ka0A4+Mo
 t5QLKeyZjX27wF4lLircNVfKPY72oNPUZSsYwluBPpWarjmNe5iSRYAyMBEhqr2TvY72
 YaaQhPB4CWPuKONZBMk74dP07dC8eOyCIl3BOYTKBJf5JJE+x3MdQE+aXcKkQ6ZfQy//
 3a2iJ9bqlv0xkCpfiLGkixTR31Kq1nTvtdfgYx3heb+7ReIJ7vV84Xuo8SWDXzxPRzVa
 EQcEa7dXD4WjMLykjrcgeM0YrqQf5DqeGHR0XZZPRcB+/tKY+TrpkpJOEe3kMcroa+0V
 xFYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp0G2dlDzkhCzpaEyDRhbgTm/ia3laYQ7p7oC+p+gT/sQV+pz5MVnGzoMAWJqvB9wAvTDrs9q9E4Q0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzu5ZItVa2hxtJOV9V0R0/9r5l8UyAgpZRX2a4zuy/Y67kuJYOs
 z7zhwFIS/WLadKnwMXe0/djGZJPPwQ+lbZoppLxizPmfG9tUfNVK8HjQncLZQ0pihUyI3dtKyMu
 UZf9zTT4KEIDm3CvV2bE0VvSbReS5gJJSf8LdLbLHEk0+SkCxAJLyh/fP3aOp0QPHSSeqwlE=
X-Gm-Gg: AR+sD10v4bwl295sx1kjpBgCakz5p9g5wzfralt8hQLjbANd8pLsNe3JkKEsG1MARMj
 uWR80uBx62aAEich5bAEIlMAK3S2xmrRqsd0PyCty5VaIyTNAST4idXeBZECwrG/nNb+knp73eC
 eKWhgqNmWGLR2j0EsoRUL4Qe2vaiufp3JEPycbdzsbardxMaXhAgZH7Wp1gaJwNtO9jiDqQ/OH6
 oUrOTik3g+mAbvm+CCScqNVHeim3Mo6rhwtKWs1yUx2XqrH0QtY9ugJJC6IQOw9Nic1uU0uUoUm
 lahl09EHzXwfXa9dZbO60ViJETrjUUVDcR+1UFVuAda54t2kvSHpD2AKeFCEnKajV4q87z5g98v
 xxS7y1g02+KZDz+yrc0BLkJhRwGLuC4TxxfV7mlU2rs2qVI9FGkdMwNT3TNfeW++BHOn4GyKfef
 ygJLZeyOXXj9iAvg==
X-Received: by 2002:a05:622a:2512:b0:51a:bec0:1040 with SMTP id
 d75a77b69052e-52b383784b6mr31061121cf.12.1785427504085; 
 Thu, 30 Jul 2026 09:05:04 -0700 (PDT)
X-Received: by 2002:a05:622a:2512:b0:51a:bec0:1040 with SMTP id
 d75a77b69052e-52b383784b6mr31060261cf.12.1785427503397; 
 Thu, 30 Jul 2026 09:05:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db8a3bbbsm455174e87.0.2026.07.30.09.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:05:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 19:04:56 +0300
Subject: [PATCH v2 3/3] drm/msm: detach the ARM DMA mapping before
 attaching our own domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v2-3-18e0daf2d836@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
To: Robin Murphy <robin.murphy@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <jroedel@suse.de>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2786;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=YMHA00MGVdMnlcJxJUco7AZri2HHepPYlEdrPa5Y7M0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa3YnaPFREPHCdxSgZcp5fpVW9xlJ/nlVPFcVS
 v0UUSRLrMKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamt2JwAKCRCLPIo+Aiko
 1VQHB/4jV3KN0jQQp5q7JC3OLW/+7/9QYHQszWWEPbzovZ7YSoVIaUjgRZYI/1ctEi+wcrpzaAv
 Va5WmD7hjl/D2fCOXFhNsDNVitwbyzMoFcySrFAP6HHiFtTWfb0LolQS2OWn1XDa6L78DNFut9s
 fJJlX6ARuf/n9NgAbt3aVC3gHG+EXDp7uX0Dgo5NNP72nh/ericsR62eeX3/BOo2HjazwEyDnqh
 76tcLP0DlMrGzVG4djvTwWelXB6ADuZvwe4f2F8EtHfEzsw0GpbMok6Z+pcijQJU69cv/8GOjvc
 qO76MtdwYmfE05Nk6nmAJJcIncdyXlN+lD/MqChGEPSB6DSi
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: aPsq9g6Qi-SbUaBX1ChJ2Pu9eOBxDYC5
X-Proofpoint-ORIG-GUID: aPsq9g6Qi-SbUaBX1ChJ2Pu9eOBxDYC5
X-Authority-Analysis: v=2.4 cv=Wqgb99fv c=1 sm=1 tr=0 ts=6a6b7631 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=epCurf6C53ZFYVxhAokA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX8k+huf3kMop6
 onMe/QPLa9bRqfVW4JkJQaYqerCA8WWGFDEwKBfEHujyksVUnQTeiMlR8+wJL6V82mNakqNJOKA
 Dresi8Z8Rat/cpzTcX9IOwmkSMxhMW+ThLgXt7MqdyKBpCYYBi42FiaJLlGyQobZlmUZtnRZtR1
 yvT88ECGLCj9VP9Rana+Z/h55JlmSnIemZQub5jK425qmh9NIT94NMyil5ozzAU6NR7ynx5UFfP
 7puVE0G9OqPntZQU6/ejiMmjX+0bhgfqucMYzYcaT/6NtTO6zI6OatorscmOlcDoJ1GiiWsSJux
 wpkq1fWCcQmCTF9J8c4++rjYQRREJOxBjW0uYob5FZ/7NYo9dYXc8A/DiLQWNsPrO5h7D1LybN2
 TpnRMGXv/J673nLxd60SBq6XfZDoBo57BIV1YumwSgsHYuZNizBP0d6p8rxXNC3wNohrrMJgXn5
 8VaO3N0FKEYpo98PsVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX86FAMDORWpz+
 Y6LRK0OmuaMZJBk0qlTdvCaXG77Kzke7wvJxaDZHXWkWquHB/YM+mAnIPwHrZWRYe1oi/jsis7I
 MtaQK+m80HWEsZ7W2RF0x6mgH/PpEoo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300121
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

On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
dma_iommu_mapping for every IOMMU-backed device and attaches its domain
to the device's IOMMU group. That domain is neither the group's default
nor its blocking domain, so when msm_iommu_new() later attaches the
domain the driver manages itself, __iommu_attach_group() refuses it:

	if (group->domain && group->domain != group->default_domain &&
	    group->domain != group->blocking_domain)
		return -EBUSY;

Both the GPU and the display controller are hit by this on apq8064
(IFC6410), leaving the board with no GPU and no display:

  adreno 4300000.gpu: failed to load adreno gpu
  adreno 4300000.gpu: probe with driver adreno failed with error -16
  mdp4 5100000.display-controller: [drm:msm_drm_kms_init] *ERROR* failed to load kms
  mdp4 5100000.display-controller: adev bind failed: -16

Other ARM32 DRM drivers that manage their own domains (tegra, rockchip,
exynos) drop the arch mapping first. Do the same in msm_iommu_new(),
which both the display and the GPU paths go through.

With this the GPU and the KMS device both initialise:

  [drm] Initialized msm 1.13.0 for 4300000.gpu on minor 0
  [drm] Initialized msm-kms 1.13.0 for 5100000.display-controller on minor 1

Assisted-by: Claude:claude-opus-5
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 897e42c8d5c8..da6782fca6bd 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -7,6 +7,15 @@
 #include <linux/adreno-smmu-priv.h>
 #include <linux/io-pgtable.h>
 #include <linux/kmemleak.h>
+
+#if defined(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#else
+#define arm_iommu_detach_device(...)	({ })
+#define arm_iommu_release_mapping(...)	({ })
+#define to_dma_iommu_mapping(dev)	NULL
+#endif
+
 #include "msm_drv.h"
 #include "msm_gpu_trace.h"
 #include "msm_mmu.h"
@@ -749,6 +758,19 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 
 	mutex_init(&iommu->init_lock);
 
+	/*
+	 * ARM32 attaches a DMA mapping domain to every IOMMU-backed device,
+	 * which would make attaching our own domain fail with -EBUSY.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+		if (mapping) {
+			arm_iommu_detach_device(dev);
+			arm_iommu_release_mapping(mapping);
+		}
+	}
+
 	ret = iommu_attach_device(iommu->domain, dev);
 	if (ret) {
 		iommu_domain_free(domain);

-- 
2.47.3

