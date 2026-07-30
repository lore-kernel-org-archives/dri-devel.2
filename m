Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6532C55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B91E10EF1E;
	Thu, 30 Jul 2026 13:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGPuxWrR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEj31lJn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3DB310EF1B
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:41 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDDRrx427139
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oKomwFAwUezzDTIBZ3q145K36werjmHbPF4H/yZ/x6Q=; b=OGPuxWrRMmU2PzD/
 mKwmrbMpkX6jKvRyejXSJfhrzmADzBmBvV5C2lfN93sWUAVbNLw5HonQDm8+kVU8
 IdCnxNP9mvNbUxwyUyStUqoBIY48bISG2zPPa4AN5h7YZmmeRvrlq8r8TDTF8Ru7
 Zmwb0opGC0dJ+N0lcbJPgOsuqfR5vE2TzyKeknewcTjfYj6YyYs6+X03D0qCtP7l
 TaQ21vRB2MLrY/5iRQE3dDMGDxcEMwP28PkkdI6ezrUkYmZo2K5IMGRfRz4dSSR2
 BIp9ni7Xg37VIyT+0IROuSJKa78ynVAKJo0PscQHHPWudnb7JKWGrp5xzc7VuRRK
 nhVbqw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr3tyh1hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:41 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c26012cd0so20445061cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785418180; x=1786022980;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oKomwFAwUezzDTIBZ3q145K36werjmHbPF4H/yZ/x6Q=;
 b=IEj31lJnl63KKTsT3t0ST3jbxzCph9/NyYfOa8nPJeBORzyZ7iz7aPJxEXsQiSSgCR
 Cja+s1wFk9n/paaXoXeZsMH1z8QQ/zDMSa8O+01VoiyD+FaljGkyJd2bdw6hkr+EYSdE
 uOwVGc61kcnYGK4nzOD55rsbGrfo6qSgL6r6XOBdf0IN4DZ6dP7cxt9syohsOI5KFUHS
 ioT4mOb0QOHj4WIXGZFBoVMmIV9IgCe9Od9Y6oaRAEvZInUv9YOfhBqS3HqCmUhTifh3
 YL/dslUj3VJm9Webr7c8qHcpo1qvRVOIr5Y0aiTw5S3BDR8P3MVxMbZk188PbRQRbSlq
 1XPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418180; x=1786022980;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oKomwFAwUezzDTIBZ3q145K36werjmHbPF4H/yZ/x6Q=;
 b=F1/OsLIF3fWQYNV7jwYFYHrK+WrLhTZIUXkTNh7krUm3zh1zVHBrDx2W0Abl/XTV3L
 8xb8DU8LC4LmUpnwmTM79Ezydv2DxaegukZXNWlLze/YCGq65avz3ZO7uiW9yEQn9ru0
 0K2ztdO99uTWHcpmRvbEIBRNQ9kJVps3J6BZOc0qCLNW0xMCN1hTQc1pUXDe4W47AkU+
 24ediTuwR9PNJuzijpaeMU0dJqS/Gs7P6xqtbg7cKfY4JQXozoh/soP7EAjHCl2VA+43
 GdBgRExTZaqFIr21n4MJmBlSPjONZ5xr91XWrB/Qt35Nh034h/FC1zPTr5CXdFpcLghB
 EMlw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7jwmFC/DgilfTyujPA10IzU3Xhlh9VS2OKKgzReGXf4WNG3fclHjeXvy8S95OmFbxBN8HMJQKigc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxKPNg+0oTxHthlQSu8giU0V4wYBQu+21OL/RNsY2QHLXUPVtwC
 fN1D2eiD8gG9xHiRKulmyE+UWs4rxI+jxX+XCnkdFxg/4wb/BxB739y0W6059Ig/lzAOb8UqD41
 6BBX9A7vPSDAauSxbPLV88zjLyehcUgUgnR1sWhWKwFDKoNplqPAlXLMz3Dgu4IUtdnC6avk=
X-Gm-Gg: AR+sD10SSvcyE0ydZb4Aid8rxtPk6Gyo+sYxHPHAWKS7tY/yKAqnU14zH/1TU0DIFcw
 BocDpRt/SFSMwiLZ+RFoHbhrbRLXzUEa/WWCRyl2nfYLSoGHgI/td0sl/ex9XLtHRN/CveJeBFA
 p7lVKMC8B4RHEDCbx59WKh5Lw+W2AHgONdkcPn0krIBGem6Ax5cVFbyBJgEj1HIeZ55VkRuylyQ
 1VHbsdY1n55W3SlK9QRs5Hn4ypAC+oQnxSGosSKZWpQqcyrOGVUAbFXQj53DaRFGNfk6qZJc9lg
 b3X126uXLZ1ok89OOr4yDehcYrtDwtatbrORLOkgGyrM7Bgm1z01zxzj1es27feL+e1aW53n6tJ
 CQU+cDTdzDO1uCMUJ7oLXk7SOGSt+/BI7Vg5WlB18UIl/SHBP6ZAGJ3FYNwvIJUDnUSWnZZTf1O
 83EB7jJQnDPFJ2TA==
X-Received: by 2002:ac8:5801:0:b0:51c:7b12:5fff with SMTP id
 d75a77b69052e-52b386ddf71mr27986771cf.75.1785418179819; 
 Thu, 30 Jul 2026 06:29:39 -0700 (PDT)
X-Received: by 2002:ac8:5801:0:b0:51c:7b12:5fff with SMTP id
 d75a77b69052e-52b386ddf71mr27985881cf.75.1785418178960; 
 Thu, 30 Jul 2026 06:29:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f6acaa009sm2976631fa.34.2026.07.30.06.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:29:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:29:32 +0300
Subject: [PATCH 2/3] ARM: dma-mapping: reset DMA ops before detaching from
 the IOMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v1-2-b12fa067804e@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2474;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=zQmiJpPoZNGhjY+XUsKBhhVoMysorcpbs/s+cw3ZEFM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa1G8zRjknHYqUBI8o2MzKUGuZ4oF+rXCx4jn2
 zhq+XjJrpuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamtRvAAKCRCLPIo+Aiko
 1fYcB/wO3cMw7FHxc1VUZwOfY2Tooa/OXl2aPOMopt0xCYxUwpZ5yVYjRHgrQrzKG+mUO93tFGw
 H7pbYScFoKJ2AzsMoN+uN+v8t9Mh3yY1Ud49mcH5NE2zMD9zQK5bM/IksKMNuLWYdtNdkG42CTs
 9j/x4WTPKOrGL7zpcDM76Vfl8slVplqaRrhvGpQmLi8AL9I7jsQWL3Ryyn3uTFjVCXITZAkaSUi
 wdo2aKOX5IdqnZGhap8RWpPU8rPCMTFsvAtExWsnqhoMBkUAwDyw52qu50f9mo0kDdv0RWMzrto
 KRpI9flM9iK+ZUsRzNJxJiOFKou5u7H5EKzCnbAAVDlwcIEf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: u_CCwdzTLfWzvq8tPL6gAVGM2nYbsRsY
X-Authority-Analysis: v=2.4 cv=JZOMa0KV c=1 sm=1 tr=0 ts=6a6b51c5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Js9RLbieTBECFtt6-0oA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX9uCqlXJ2VMrQ
 7LqdUMltsg352sWFD2GVt6oUwU3+TUUE+u5VV+cW4zfvAcWn6dOzZTb1vuBqyLVnbQkuA7OgJg9
 1rklWop3UVDE2KcTMFEp4TkQSBiPU+4aEkBHaxmdu6xvIHn5jhHUKNy1qNdUMcVwk6EoUB/8jcr
 U6+UMzt+RrZd5e7/9XmZoqcAfNG+C+MtxNkuKC0pEzkBF5tXhCN8jbnJ2AHs3vTirO+zDxxh6+U
 x+fOU4qWpRNsJkGURjLxZYcNpOmMi95qz7yftbrTdbEE9HWLpJeOFEw2iFBA/rL/JbCHGVww0cn
 7Q5PLn9yTDtVGF2pftcS1ms3mUWc5dYlFDMWSYIoEfJOOHBuqYW9Vtp1aoyKdKwZJJCBlrcQdP7
 Y88Xfv+j59Uq9EdqmX9XLZ6gy57fcO9xcyImqWsyBVBCm4Wlew5Db2MGRGppcYyRlJNofGxZX9S
 c2+J2j9gkIQOtW6JE7g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX/YSVsdahofkN
 8SB8FjkyKEuKi95ZNx+lIX/R19N3MK5vaEc5s3Nh7y5mhR0MWwLzJvEk6cahtRip1kQDa4DShtj
 2BG94J36ZcuYKftcnsQaM50Y94OYus8=
X-Proofpoint-ORIG-GUID: u_CCwdzTLfWzvq8tPL6gAVGM2nYbsRsY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300102
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

arm_iommu_attach_device() installs the IOMMU-aware dma_map_ops only
after iommu_attach_device() has run, so a driver that builds its page
tables during attach (msm_iommu via io-pgtable) maps them while the
device still has the direct DMA ops: the resulting dma_handle equals the
physical address.

arm_iommu_detach_device() does the reverse in the wrong order. It calls
iommu_detach_device() first and clears the DMA ops afterwards. When
detaching frees those page tables (msm_iommu_identity_attach() ->
free_io_pgtable_ops()), the freeing dma_unmap now goes through the still
installed IOMMU ops, which treat the stored physical address as an IOVA.
iommu_unmap() warns "region not mapped" and __free_iova() indexes an
unallocated bitmap extension, dereferencing NULL:

  __bitmap_clear from arm_iommu_unmap_phys
  arm_iommu_unmap_phys from dma_unmap_phys
  dma_unmap_phys from __arm_v7s_free_table
  __arm_v7s_free_table from arm_v7s_free_pgtable
  arm_v7s_free_pgtable from msm_iommu_identity_attach
  msm_iommu_identity_attach from __iommu_attach_device
  __iommu_attach_device from iommu_detach_device
  iommu_detach_device from arm_iommu_detach_device
  arm_iommu_detach_device from arch_teardown_dma_ops
  arch_teardown_dma_ops from device_unbind_cleanup

This is reached on apq8064 (ifc6410) when the adreno GPU probe fails and
its DMA ops are torn down.

Reset the DMA ops before iommu_detach_device() so page-table teardown
runs with the same direct ops that mapped them at attach time.

Fixes: 78fc30b4bb35 ("iommu/msm: Implement an IDENTITY domain")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 arch/arm/mm/dma-mapping.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index f9bc53b60f99..a467e0d01a5b 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1642,10 +1642,13 @@ void arm_iommu_detach_device(struct device *dev)
 		return;
 	}
 
+	/* Reset DMA ops before detach so page-table teardown uses the same
+	 * direct ops that mapped them at attach time.
+	 */
+	set_dma_ops(dev, NULL);
 	iommu_detach_device(mapping->domain, dev);
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
-	set_dma_ops(dev, NULL);
 
 	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }

-- 
2.47.3

