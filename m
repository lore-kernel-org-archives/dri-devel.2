Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868CDC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED5C410E189;
	Thu, 30 Jul 2026 13:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="W1Ki/nu1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IKk8m8cl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DCB510E674
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:36 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDDiGC716734
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=FrBxWxjqRXZNRvOm43VwxP
 FxRLqKBA6+pd4WCL/GOZE=; b=W1Ki/nu1aVDuyPmM9trr6PPb7poeN5QDAOHsEd
 jbhxiSE6nzIRlG6VNHVvOWDlxFMQViG076Bqb32lcOWyDA11SbzoNQuFcWndSZMR
 coFq/pFW78LlK7l6/SU8ZAfJEF1kqB6mhymB891IP2occB8EOuORh89+Z3umwfiu
 3nJpXOCbyDIlG2AHNzAA9xVamUUf0z+LaE5AXSPC3N6D3F37fh7gnq2WekrmZEbv
 jU8oNIbAamDOLMHLdYipWTirAWXO/57+xL347zRIFM3qABSy3Qz8Ww0ucD33k8t1
 HnqTJiKpmwfYcme6ZpzR2LIkHopmHTUrYZ5P64P3tutXgW+g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ucr6wc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:35 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1d137a68so41363291cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785418175; x=1786022975;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FrBxWxjqRXZNRvOm43VwxPFxRLqKBA6+pd4WCL/GOZE=;
 b=IKk8m8clkg5cdN1VpNmXaVNvL2XqYUGwv10yDO+F4Y/ePIyetZg1Nj1xWQl6Hb4UNm
 iUsVVJwuOBgL5e4HqKVwgnB0UrE+lS+ogSFsZr7Lo4qYCbtBXYGQHE6rcnBQzIUsZwMT
 H31lw6Mi6XnUciaa6PeGVlO6dmGWRbP7xHtnUV1/OgbI8wiHU0hd1ZFdijD4OyjKxrLS
 I12EhhDD59nm8Zz+ZSgTUQA82nTXJ3B72iMlM7zJJ/G1KpvFVVUUKG9WWTRRz9C2gPbI
 8BuCIWqOtfBeEi0vbuJ+ZrqH8zHE22qO2sKPJVaLumuvotYBn2+Pmkdhm01/LTCQe5Z4
 UpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418175; x=1786022975;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FrBxWxjqRXZNRvOm43VwxPFxRLqKBA6+pd4WCL/GOZE=;
 b=S+caQaHWaovt8jcFVqdsZr09zbQ0jxrHwVwjl/L2YrkU0Owz05+vELBUSUDvgsd/9/
 kbFtZ3vqb2qMsi8VdBUzpeQBXrYl8p7xEfyI6WVKfWs4maQimSqIZ09UzPwve9U6yhq+
 PJ43b55vtwjGMY4bH3TVqduRU5jCNY86LXeiHOnDuDHcWojK7thz4tL1nitgdLeMXCyX
 xpaB8m7Vz3NedaT/L+7bEnyKURA/E6Uh1pEwA2TUuxrVrPUG7qVSOcGV2fmOnfxQuh1q
 ZQIKcQrY2DHDv0jV5UGQzQAmwJW9/8OKxFV3iYUepVcI1s0eXllM4MvBbSzwY6cDQvsD
 ziqw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgJjfSLz5TDo7DmXBaLh317QIOnZjFY4Z+NEQubJYvNw82qnTk2MgE/a4XfaQd7iIaTVQ+ZE5Or+w=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHhIqz3/MWTBuffpXxgxS6x8/XTcd8fw4mfLPm2qzmj4xZwMJl
 VhQ3kLtzADTyeiSAucsIoWZIOS1bXB5GaRctjw94NX6KDhBxB0ARHdfbbHEG/W72Oq2FJ2EE/Zd
 bEbSeHHpRNOlcdLtw9zV5lc96v1mUGNhTmbb5oNNbvvDjf4infq33/94ohYHi0qwChyZHcDY=
X-Gm-Gg: AR+sD13/fDnph2fTovtG8xD1fiJuQXf9RA5vgrYPyo56WtzHjly4tfptgEB7pT2/1af
 MiK61WF//Kkjntd4V4nwuYrbnWCLYM0zgmKEZsZtFNSR3XWAP1ekKyULSVOMFibjgoXT72DKa4a
 rQi9+tww9/y2BfAkbtEyJo7hWvvpPDqsltDd5GwanFT0n0Z7oF65g731tq9C7N/Xz5KEazZMlND
 53Hff+98WOA1vAvjdh1d6WBD/gezSlzaUt1jlACiWHS87mFsyiXTjqUziZtiMT9f4leJZeAQ0dz
 jMzYlnNUiv/ya/YORQGCD5ycGmquAqune2tgTu+roOiX3tDJPnTQQoXZAdhCTlxDVBNiXr3E34s
 a8FbYhtAchKT8dUI6CZj086+ZEIWS/TK+o09O51l77YZxxGqSMwFok+26xq+JVoonzB8zQb6GuL
 a6WNGfweizfG6BwQ==
X-Received: by 2002:a05:622a:1aa0:b0:51c:61a:50fa with SMTP id
 d75a77b69052e-52b385eded3mr25658111cf.39.1785418174833; 
 Thu, 30 Jul 2026 06:29:34 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa0:b0:51c:61a:50fa with SMTP id
 d75a77b69052e-52b385eded3mr25657711cf.39.1785418174288; 
 Thu, 30 Jul 2026 06:29:34 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f6acaa009sm2976631fa.34.2026.07.30.06.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:29:33 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] Fix GPU and display on ARM32 platforms using the MSM IOMMU
Date: Thu, 30 Jul 2026 16:29:30 +0300
Message-Id: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALpRa2oC/0WOQQ6CMBBFr9J07UQoUqBXMSxKGaUmBekUQkK4u
 wWMLn/y5r1ZOaG3SFyxlXucLdmhjyO9MG463T8RbBs3F4mQSSEyeNgFRjM4IOcmaPKiKo3MW1l
 WPN68PUbg8N3rc9PUvNCEXfIlPI5TDIUT+3cU+1UcuaNkvKYOSpNmQiRtdZO5mtNd02hCiG84G
 xTrcQlXpymg5/W2fQAr4Tap1QAAAA==
X-Change-ID: 20260723-fix-qcom-smmu-b5798c65d689
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2815;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QeuOZ/3E7srmsN4kZYdWvz+jVIa+pIBlQp4fMxk0c0c=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa1G8vHFfUkazJpdtkfWB5qcSLTbcR9WeggcWK
 ZnHvv659nSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamtRvAAKCRCLPIo+Aiko
 1Q4KB/45W5IuLGMfukDxWtAm4Kn8WpvsrZCG43DTGKSpOFCALq9XgwWFi8s9keLSIB4kYrYNe06
 XtyxqMCC0IkQ0FM1E//oevvm9bvqUqL/VeNT9pSZykkGfRuEFxlwC04OkBZMAY86IHws8iYgGeA
 TBNi1Xu3GnAMhqtBzcqeHzGdVUn87pGMjczIsbbM8CX2dT+xSCjA1ztwD6ZIPhEC4eeYw8XhlyA
 Oew1C0tmhzqsF/zcB37ma81WyXwpOiLc7RGR66XnWNPAIvKsmhyC6UUHLA9v7La6w5GRi890tNo
 uTB4CSpg9MoHUsrXHeKMbwt/nxWdl1Z0ZcaMEM7DxFp2bEvp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX6xQ1vRNMgIpe
 +S/iDb7iTQgazghxXIsUsLV2WHz9C8OoZxFACcmKTKjAUxXKc9W0piDof/+IvYLbXImbDj9QSR/
 Y7kS3RDNPgoUmT57VsL2QfZsqXeZY8k=
X-Proofpoint-GUID: Z73TGNFRvZkiIStDaJLHs7NwFb98voZK
X-Proofpoint-ORIG-GUID: Z73TGNFRvZkiIStDaJLHs7NwFb98voZK
X-Authority-Analysis: v=2.4 cv=W6QIkxWk c=1 sm=1 tr=0 ts=6a6b51bf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=shkEvlnnkTupmQYayisA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX1MYxKIvX38hM
 1aMq3+9aefilocwefIiJ9wxgHIPwNFD0xkikHuhRZnm3zG2RIYB3b/mJx0V5cmkStd/qEd950sL
 3WIula1Nv4GnKeni061RBaHegv52C2nGoZSwRfy4OV4OR9A1lgYQ2SSht3qXR7U59Js4AGakSQM
 ea5/1VVto6DNDPMAM3moHQ3Ix+HS1HuCbOUd2CZgoLdKtAJ4Cfdj0cdrv3ORqps9urjixb2K8v4
 CiDP55X4zSJjr7UK+mhSiuXQxQUBGaZZ6xPC34ZRaKTugoQnb26t+7anSN517+u64R9Tw24lnU6
 8r1FdWhQBGCLCA9qfKM4QwU4Ex0OlTLGBR2YfRyEOmn3bOblNfE+/WxoIq6y3x3Ofn3i4/ZNhQN
 g0QMb1b62Te+0sUZG/FvXrqDyZeRuZhCXrODqkzxyR1QG5kOgBYGgkVWljgu8fLvM5g6XSLhXfM
 igRH0frmjbOf8iTu8MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
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

On apq8064 (tested on the IFC6410 board) neither the GPU nor the display
controller comes up in mainline: with CONFIG_ARM_DMA_USE_IOMMU enabled
both devices either fail to probe with -EBUSY or take the kernel down
during the ensuing unwind. Three independent problems stack up on that
path, one in each of three subsystems, and only fixing all of them makes
the board usable.

First, the MSM IOMMU driver does not handle a device that is attached to
several IOMMU instances, which is exactly how apq8064 describes both the
GPU (&gfx3d and &gfx3d1) and the display controller (&mdp_port0 and
&mdp_port1). It keyed the per-device bookkeeping off two mismatched
things, a per-IOMMU list and a per-device pointer, so only one of the
instances ever got programmed with the stream IDs. That had been merely
wrong for years, but it turned into a NULL dereference once the IOMMU
core started deferring probe per instance, so today the board does not
even reach a shell with the display enabled.

Second, on ARM32 the arch code gives every IOMMU-backed device a
dma_iommu_mapping of its own and attaches it. drm/msm manages its address
spaces itself and cannot take over a device whose group already has that
foreign domain attached. The other ARM32 DRM drivers that are in the same
position (tegra, rockchip, exynos) drop the arch mapping first; drm/msm
has to do the same.

Third, arm_iommu_detach_device() undoes things in the opposite order from
the one arm_iommu_attach_device() set them up in. An IOMMU driver that
allocates its page tables during attach therefore frees them with the
IOMMU DMA ops installed rather than the direct ops that mapped them,
which ends in a NULL pointer dereference. This is trivially reachable as
soon as any of the probe failures above unwinds, and it is what turns the
GPU probe failure into a crash rather than an error message.

The three patches are independent and are expected to be picked up by
three different maintainers.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      iommu/msm: track a context master per device and IOMMU
      ARM: dma-mapping: reset DMA ops before detaching from the IOMMU
      drm/msm: detach the ARM DMA mapping before attaching our own domain

 arch/arm/mm/dma-mapping.c       |  5 ++++-
 drivers/gpu/drm/msm/msm_iommu.c | 22 ++++++++++++++++++++++
 drivers/iommu/msm_iommu.c       | 27 +++++++++++++++------------
 3 files changed, 41 insertions(+), 13 deletions(-)
---
base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
change-id: 20260723-fix-qcom-smmu-b5798c65d689
prerequisite-change-id: 20260723-msm-fix-crash-8c13220d9465:v1
prerequisite-patch-id: 3556d41e924ad64e8e9c06cc5bd1972c66957f42

Best regards,
--  
With best wishes
Dmitry

