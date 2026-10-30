Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE5606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L3lnNYnC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=i23aViHz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EB61129F1;
	Fri, 30 Oct 2026 21:33:17 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A88112A0C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:04 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULJsO2256075
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CR0OA6ftLKP
 m+mGkPsiROgpxTN7mmkcVrmLFwZqhkUI=; b=L3lnNYnCplL/j/FL25Zbv+jeEQg
 OslyFEguab62vIJ+leaeZ0mgUbPfO6XZZDDpLGruk5yvEX5NWzEPfEtUWe+zsu4W
 V8gDJV10HFMiwM1NZTm7mnOa9yXqdhHE3tA/YJQt7GNpmb8qxoErVS/fgu1hJVn+
 zbZ+kmMffSEoJ0tPkqmFHTVMnjrfDOQD8An5WioBpNrQQytTCbLUFre0Y0LuFk7x
 j0DjdIjVKIRIIAzFTmMhLqEvwD8CY4aUewQaTfejbZJgwAJcvfbGy/AubkcQZXQL
 5XTsg0SMzlYWF+DuqJBOfDzum481CAxsdx+ouIfiIQL/M1Bzvil9nZY6sgA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x004fj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:03 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e601800e58so19485805ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395982; x=1794000782;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CR0OA6ftLKPm+mGkPsiROgpxTN7mmkcVrmLFwZqhkUI=;
 b=i23aViHze9+iJ4iWNFOH1BodTI9hC2F0m5Wz43q6V6FiUFP/Ss5Rlu555HHmvTWI6i
 FeobUzpmVEFvFZeE9k2nQ8qaRKYJ0o9vepasx4IIFRsOb5kSReL09d92jP2d8J0GOyMJ
 k6vZT+5tg3R/C9UTBJ9PtGelonYO0L4WJu40RF2+zIIiU57nglCRoDg3HrOsypA1ZAIu
 LDqnBfdApJaB83cr1CR//RtEXhq2SaZodzZvM/jtkFsC9mvzrXtYy8WogJ640s9bBBXJ
 hZebxhL3NUbWlXIvPdFKZaNI0Z6m/dhZRleivctkG1WZFlPDspftgO+zak8QHRZeWo3C
 s/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395982; x=1794000782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CR0OA6ftLKPm+mGkPsiROgpxTN7mmkcVrmLFwZqhkUI=;
 b=ivtzuee0W4QLRw4ZgyJBfwtHbNY407ge/yFHDJa/iydBqV6QL6z9Z3DNszz576DYR0
 +S1CDp2TcbF7EA36Mo/yioouWHKlhaUyBHxSvPSxWkfI6XdQavWSiYtzsK5iVCi6pvDi
 N1rvA/A78dfho/YAzS4RW4xJbPxHMxA/ykMpDKE5SNfC27c+HgH/MibfK1a0I512YIcE
 cdfGWKixN9oRnNeiCU1zbJ4vJjOXbgtes2yn4GkKDi2HmoHg5vxnmN6ZA8aCx1DvzDzO
 VtllIlveR44nrJC0ID1YoVUempGzlIlEYzJxNSzjZaBd2b5D5+tIK3+w2ZEunzPWvIjQ
 MBnw==
X-Gm-Message-State: AFq9FYLN3J+R1Bl/Xdy5RgGEtrBphAwj0PWHa9WwsPmdq9aJvf7DurSQ
 FxQYoGVVrdXkvazbf+sd4pfR3CYfwS0r0QR0qMY9n7gCZm6ny8v4uz57lGqfv0HASUyEieemaA3
 F22Qorjwf/EOb1bC5bfYTUkmSt2g121v0GJ3aY87eq5bel6pza3uHkVdUa7cehuSCzSVrsrdh1k
 r9UDEMqg==
X-Gm-Gg: AYBFou3FN6yawpP2kMo+2ZHIAHK/Sr+fdy4VAUPYa8DQOx8JpN4K9jrLpEW2KNwS2lB
 FMqSGv/qYA80QDwfeB4ESoT/n8o+GdxPA/ev/zJPE74YTbIqTDUAMEiGk0Mk9PDzWupIYo7Tjly
 D2uMerzVj4Q79dg6t4SY9CeXi/iBBZu+fyaK/ITbrDXSAwMNpe1jhJsZO4gEe2Weae6m6kDG3bP
 kAMOBMKr5Wm004Do1DYDHK/80XrmdBANryrAVqJQmA5jW/ILJ50vRwK/ai3yHUOcAnK6HkfWsL4
 epj4loKuUOEkXz4DzCt7e79dennnU1OPCbyUfjEElpIAj07s2a+HXQjMWDJVyzSeuRxXrhqfIjp
 5AfYfwCpMyFJPUKCaOVuZqo3+Yv28UGaxRXi9IEa5L9RqRFOU9jNgf6GLd6EN03JqfCF7g/QYSZ
 qz5wDX1UCaKKDahyIc2Vly9w==
X-Received: by 2002:a17:903:3c6c:b0:2e9:73db:3c78 with SMTP id
 d9443c01a7336-2eb3649bef0mr37789095ad.17.1793395982370; 
 Fri, 30 Oct 2026 14:33:02 -0700 (PDT)
X-Received: by 2002:a17:903:3c6c:b0:2e9:73db:3c78 with SMTP id
 d9443c01a7336-2eb3649bef0mr37788695ad.17.1793395981808; 
 Fri, 30 Oct 2026 14:33:01 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb39265090sm11490155ad.41.2026.10.30.14.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:33:01 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 4/6] drm/msm: Convert iommu map/unmap to helpers
Date: Fri, 30 Oct 2026 14:32:46 -0700
Message-ID: <20261030213251.55365-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX3C5kPyEs62kH
 5zHRXHrBUuseTLnbP1SpWoJbT5RDx0sfSanCS3tI+xHa0q1uyT+7uku5Yy6dx7leHQCi2gSmBIc
 qm6qw7RDjxxXQ9sHA1E+O+SMPzawJKD3vAti7Lam5PUJkNoT3e65dtiAfBLibKFVMCbl06JFWuD
 M8jXpBw7HzLQr50g1/vDh7pnBziG7Wd1LG4SQdShcMol5jnEK8GcmEtozmWZt5pgE5tc009U39I
 ZMV2oAM3zR1gYatXlHKrugEDivYcndEU9W/viRsUaA+MQKW3go3EzuygCYGLRuNE5pnFCXQLpks
 SJ+oAIBq25p2+0re2ChNo3dWCBCNMXOJNpB4k5I7IJJwuPtFX6KOQl+z1xR+9nqeQGFrQcL8Bg8
 iX3gnTvvFxoxu2VbYcqsul5JJscNAFl1TZmjhP0dFZe2bdH2ikxYZ9YnuW4MUn5pkGZyZkCxCxv
 6wj2GpEfAlN73usZtfw==
X-Proofpoint-GUID: PDiu-u9AadxKFKtn1eySIElQQMIcvlKz
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae50d0f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=3T_YcleVrN8O_gWOTnoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: PDiu-u9AadxKFKtn1eySIElQQMIcvlKz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX1dOy86nOmABY
 vbdmhLk9x6ALepftu/Awu+PRnBIv+txkx/3X4stBjRXLVjtgx6el+WFt2WoQSo/37C6QVduPKaZ
 5fVdRqKdywOhLdlijzDnjz285Ex26CM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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

Re-use the previously introduced map/unmap helpers in the iommu path
(TTBR1 for GPU, ie. kernel managed buffers, and display/etc).

The callbacks work in terms of iommu_domain/ops instead of io_pgtable.
It would be kinda nice to just deal with io_pgtable, but the tlb ops
that arm-smmu uses for it's own io_pgtable require doing runpm, which
we wouldn't otherwise be able to do.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 43 ++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 5c13ad6d5a36..479e5450a4dc 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -731,12 +731,38 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
 	iommu_detach_device(iommu->domain, mmu->dev);
 }
 
+static size_t
+__unmap_iommu(void *arg, u64 iova, size_t pgsize, size_t pgcount)
+{
+	struct iommu_domain *domain = arg;
+	return domain->ops->unmap_pages(domain, iova, pgsize, pgcount, NULL);
+}
+
+static int
+__map_iommu(void *arg, phys_addr_t paddr, u64 iova, size_t pgsize,
+	    size_t pgcount, int prot, size_t *mapped)
+{
+	struct iommu_domain *domain = arg;
+	return domain->ops->map_pages(domain, iova, paddr, pgsize, pgcount,
+				      prot, GFP_KERNEL, mapped);
+}
+
+static void
+__flush_iommu(void *arg)
+{
+	struct iommu_domain *domain = arg;
+	iommu_flush_iotlb_all(domain);
+}
+
+static const struct map_ops iommu_ops = {
+	__unmap_iommu, __map_iommu, __flush_iommu
+};
+
 static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 			 struct sg_table *sgt, size_t off, size_t len,
 			 int prot)
 {
-	struct msm_iommu *iommu = to_msm_iommu(mmu);
-	ssize_t ret;
+	struct iommu_domain *domain = to_msm_iommu(mmu)->domain;
 
 	WARN_ON(off != 0);
 
@@ -744,23 +770,18 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
-	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
-	if (ret < 0)
-		return ret;
-
-	return (ret == len) ? 0 : -EINVAL;
+	return __do_map(domain->pgsize_bitmap, iova, sgt, off, len, prot,
+			domain, &iommu_ops);
 }
 
 static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
 {
-	struct msm_iommu *iommu = to_msm_iommu(mmu);
+	struct iommu_domain *domain = to_msm_iommu(mmu)->domain;
 
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
-	iommu_unmap(iommu->domain, iova, len);
-
-	return 0;
+	return __do_unmap(domain->pgsize_bitmap, iova, len, domain, &iommu_ops);
 }
 
 static void msm_iommu_destroy(struct msm_mmu *mmu)
-- 
2.56.0

