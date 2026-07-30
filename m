Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92728C55166
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C789C10EFD0;
	Thu, 30 Jul 2026 16:05:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gD56y8s5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O8TiIeyk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E03510EFCE
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UFQp4a1144998
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a8y0lJAoP13jgR+kOYEHrpotPr79UnqM6rwBXM92zVs=; b=gD56y8s5X6fP1JXA
 /Roy+/9TPOR8JHkyPbPsYdDJq3g9F7yudy6ISFyCqMh786EsH8hGGm3qpxcsw0y1
 80vIeNs/KoL3SlZnysWWcnXMR3E9N7fKGtu+/4vu3pdPUkKEN+1N0bOw2S+7ixal
 TFjLTZbuqlPnnRmNfIV+WNT8iLQzWL2FV6/spHrt6i9tV835raFhJd3aeds1u0uo
 KVvfCSYlEfTYhXPhPZEILnpzUhcVs6JGGl8rsb/r2reyK0ar5JszBay1nLR/YDCL
 xNQDyqo/+qUWBXDhdaDj9oi8h69AemQta2kWWs5dfYXZ8JaOxzyJkwwcCf72qgsP
 Ali47g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8k60gx2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1eb52e1fso42633391cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785427502; x=1786032302;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a8y0lJAoP13jgR+kOYEHrpotPr79UnqM6rwBXM92zVs=;
 b=O8TiIeyknHGgDoM1gPnRUBPKhqaJP8Q0/p8ZFtbLkeiIDPHhg+G8NtAQLgJHchd+3E
 yLpXDfV9cs9Z18rc3xPvbw/JUw8AeWglkAZ24FaxQkYv/Hkn2DESdoJA+orlGZ596sNd
 ncGHR9kuk8VX2UtIaEvrpDVfwFPdnog7NRfxy43YuLjtza7o2hvdT/fHQ5WJT9W7dPob
 yEXTuBVJV7oDBlH80Tx8JCtjyeQDycrmqE5vCwIWOxSu51NiFhFdL5kyp0h+5KVo/LSp
 CZI1wj6RfOdDFajGQCQlvX7TiPFIxBaUlZr4C4vg9FtUPKF3SspcUg1aWuALawSIdpHq
 1teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427502; x=1786032302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a8y0lJAoP13jgR+kOYEHrpotPr79UnqM6rwBXM92zVs=;
 b=c5iYUFSJrtnxyWBuV/YppUK0vFQiJaSX6pcYn4hsg91u1M6ElooMkFn+qFasBmubQC
 25wdUZ46wfqXKXUBZR7esMTpzMJrsiZRkfEQ4S3Zsyz/ZQpU+ScB7mKz9Md1ECLCmkwc
 EurxAaz7KG6MAK0GLXSQlgXGGViDuXE6MazS2/lfATsFaEhD/mezPKrzlvTkMRMQp7Yn
 sqsHWpNZvStvCuanmcmurkn+vBRtfvephemKtTGPIuaFSLA8DrP/CzmORPuSwWkGMmoc
 A6qv+Wp3CfDpNX8xiLcaO3OfhhufsotuAONAyRYv+tXLFysNIIlMsBg77lD1IKYnibtj
 XjUA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov1n6s4buW5a9Y3MwLRdz23sTuoeNFLSBHjsWpHW9JoC4xMtGi12zeAmM9dCYCLNm0r91TiuD0e9A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyT/LWaG3qVgREwuGzu+4+OXqs9TFP0HGTSwdCEaNq87dlWKoTl
 4PQGK9rQ8Nx6lVfLG3Cb9X5bQW0heskeuhLnTX0DlsHv1PLN4LPGFGeXbRML9gvs60Jwg/N9jKF
 M06uk/eDvZYzaa9HTG5ycQ5/pCzkUOn3dyzPLmqxm49IPOawP/jLYKdDHUZXHRGzK+rI4q8A=
X-Gm-Gg: AR+sD135P1140fxZEddk+waS8xdjHDT8pY2k5iatpeXyN9WcUHYFsR9BSDrilE+uUaJ
 QBsDw03fM9ZGKCOOy3kyTqxhT7iDDFLi8UWQ5EPbwHoe5N9mZVJV2bsUgiyGJi4/Njj3iaVn6mP
 S0M7LvyGrgpS70fq7MlplCSUPDjwKD4jGiu/+6wxgMDVD8Mq24rAE4O1NJ7c+i1MFywJHho5eKO
 yZyYZpDxXytPR/oJdKwzgRvCfgtM6Vt70Sz74Enr1dlAOn6f1iDZ1V3rO/AprIjAkcalzobvICd
 Zy21Fji0glyjIcI+h+cnxplgMvYPUgmHEdxVX7BBx5Y3wvNeEhuN9TvGOB4bSzRvj27IYigKL74
 X6Oe9Ky5PxbVV4OvYWh26xmUwkKl0hJJymvX0i2DZU+DHoQb/m+8A5uXdGVgpqxmohCSI2/LMVd
 mfEmWqUHg5EFu6JQ==
X-Received: by 2002:a05:622a:410a:b0:51c:7b12:5fd4 with SMTP id
 d75a77b69052e-52b38701050mr31840051cf.80.1785427501620; 
 Thu, 30 Jul 2026 09:05:01 -0700 (PDT)
X-Received: by 2002:a05:622a:410a:b0:51c:7b12:5fd4 with SMTP id
 d75a77b69052e-52b38701050mr31839361cf.80.1785427501076; 
 Thu, 30 Jul 2026 09:05:01 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db8a3bbbsm455174e87.0.2026.07.30.09.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:04:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 19:04:55 +0300
Subject: [PATCH v2 2/3] iommu/msm: use the IOMMU device for page table
 allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v2-2-18e0daf2d836@oss.qualcomm.com>
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
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3976;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=yylnZwZL30zYazuVfjsidUHvHDh1/ZHcvFZVH/q3EiA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa3Yn4LRMmKH2hP112MTUGn1A2CzlJEBLVqtPp
 LAeD7A4P0SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamt2JwAKCRCLPIo+Aiko
 1cx+B/98g7StpIO2hL9jj/qBiRFSU/vSn9xglHxuoBbQMs2HR9pt0gcz+IK/S1FaTLF18Ve5azl
 FsSckp8I/juT6AAQTlIAnG/GRiY3S9omseCRp6S/HQX9Tm/2NWbLGlHfFHREoOWYf2h8kH9Cpdy
 S24hPjqZzJOrpQaZ83gw2tVqAioJmv2JImnoZxeVXw8PX/Hyxf3tIvxrnzmTfgqu2bsehCyjOnI
 XXrx8xa2guRBqdlYxxViI/y16QNfxvHWE/kNTDO0eSewLl0T5BHSiWC6q+/pf2yiiTyZZPm97AK
 ugnCQ0Sk0x5Xtn0oaa7gTExl2M5GkcBVRAHjhm+S3owboOsb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: poxGzv8Z8syQAUhdZQpsL_QX0zas7deF
X-Proofpoint-ORIG-GUID: poxGzv8Z8syQAUhdZQpsL_QX0zas7deF
X-Authority-Analysis: v=2.4 cv=Wqgb99fv c=1 sm=1 tr=0 ts=6a6b762e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=qBQ8OOdg5lpXHOzljU0A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX0qFh9VnaY3Py
 gOUaRB7PpXUdSXxJ8uOyfOn5SfzLyT/MdFkidzTwQpX90p3wL9k1jJh/98iqW7Z6jyx28roZbJv
 sH/PpXgWZo5OHhxTb8G2TqbRfpwrkoJZ1yj1CK/nfx1DwGqrbq954imCRlPUO+rQPuMN83YYTZX
 XxZ16P4fvyDu2kNtSKi9tgbATkTdcvRbmDK3L8jYY+bhyi22bJYve8zi01VBksuiBy61muQS436
 jFwka9rYsr+nWI+8CHK7okGvdKXsrX87xgKKLd/It/NkaUsjcdszkenFj+nHo77+MvJB+p3a0OC
 HlddfKrqJNDmhmJY3QB71bd+01XrlN+6u3BeD6Vu5QO6YUPH6zibuRZA5YZuYNJ2sDB5z6rRofo
 l4Zk9vNZb3nP1lZnnxOqt3x2IdBrQQY1OcmNe7w32yfxiFmnkFzsBi/dHHIT5WWOVaR3CKDsmrH
 YuEkD1rIxdASY8rz3Og==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX4eEqftugkOX+
 erCqeKA3iwnZXFV2UA3lHzQb6ArStiN9RlHeJvtbOPmwH3AAyS/ou4RBc/+auT+Y8pWO05cDmk5
 oZJnb/uF+TBFztH3fGzU+UPDU56E3Gc=
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

io_pgtable_cfg.iommu_dev is "the device representing the DMA
configuration for the page table walker": io-pgtable-arm-v7s hands it to
the DMA API to allocate and sync the tables on behalf of the IOMMU's
table walker. msm_iommu_attach_dev() instead stores the client device in
priv->dev and passes that, so every page table is allocated and synced
through the DMA configuration of the device being attached rather than
through the IOMMU's own.

That is wrong on its own terms, and on ARM32 with
CONFIG_ARM_DMA_USE_IOMMU it is fatal. The client device carries a
dma_iommu_mapping, so the tables are mapped and unmapped through the very
IOMMU they describe. The mapping happens while the device still has the
direct DMA ops installed, because arm_iommu_attach_device() only swaps in
the IOMMU-aware ops after iommu_attach_device() has returned, so
dma_handle ends up being the physical address. By the time the tables are
freed the IOMMU-aware ops are in place and treat that physical address as
an IOVA: iommu_unmap() warns "region not mapped" and __free_iova() clears
bits in an unallocated bitmap extension, dereferencing NULL:

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

Locate the IOMMU instance before configuring the domain and pass its
struct device to io-pgtable. priv->dev has no other user, so drop it.

Fixes: c9220fbd7741 ("iommu/msm: use generic ARMV7S short descriptor pagetable ops")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/iommu/msm_iommu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 109688d69e50..15220d79ece3 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -42,7 +42,6 @@ struct msm_priv {
 	struct iommu_domain domain;
 	struct io_pgtable_cfg	cfg;
 	struct io_pgtable_ops	*iop;
-	struct device		*dev;
 	spinlock_t		pgtlock; /* pagetable lock */
 };
 
@@ -336,7 +335,8 @@ static void msm_iommu_domain_free(struct iommu_domain *domain)
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);
 }
 
-static int msm_iommu_domain_config(struct msm_priv *priv)
+static int msm_iommu_domain_config(struct msm_priv *priv,
+				   struct msm_iommu_dev *iommu)
 {
 	spin_lock_init(&priv->pgtlock);
 
@@ -345,12 +345,12 @@ static int msm_iommu_domain_config(struct msm_priv *priv)
 		.ias = 32,
 		.oas = 32,
 		.tlb = &msm_iommu_flush_ops,
-		.iommu_dev = priv->dev,
+		.iommu_dev = iommu->dev,
 	};
 
 	priv->iop = alloc_io_pgtable_ops(ARM_V7S, &priv->cfg, priv);
 	if (!priv->iop) {
-		dev_err(priv->dev, "Failed to allocate pgtable\n");
+		dev_err(iommu->dev, "Failed to allocate pgtable\n");
 		return -EINVAL;
 	}
 
@@ -400,8 +400,15 @@ static int msm_iommu_attach_dev(struct iommu_domain *domain, struct device *dev,
 	struct msm_priv *priv = to_msm_priv(domain);
 	struct msm_iommu_ctx_dev *master;
 
-	priv->dev = dev;
-	msm_iommu_domain_config(priv);
+	spin_lock_irqsave(&msm_iommu_lock, flags);
+	iommu = find_iommu_for_dev(dev);
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+	if (!iommu)
+		return -ENODEV;
+
+	ret = msm_iommu_domain_config(priv, iommu);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
 	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node) {

-- 
2.47.3

