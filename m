Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EBFC55162
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:05:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B7F10E19F;
	Thu, 30 Jul 2026 16:05:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QusIGmhp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbZeAba/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52FD10E02D
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:04:59 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UFQq6k1087290
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:04:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iFXm/EtDVHs2U2W42SOddH
 PDOyqIH60tAMkZpM5gLvE=; b=QusIGmhp6mW6EyGv9twO/Zq+NzUdxELCLpc6Zg
 0idyNnFuvkQeS+7XVwCljDSKUjhUY7RIyFUO90beTfhaT+Smi+EP8jcIFuHPvTxK
 1eyWN/iGIX+DxHiZPG3JUedz04ZnwDzN0rW8wL3G62t0QQZkOH/M6LRf0p71Uv7S
 p4/R5mX63+WsoKPQJ8m0X9flvaHodWTWCmlHABg9gsBvOIHUdbwY0i55PIKZCOqB
 J3FxLi6u7YFN1WKI69dYyIfas1HEMCLi/oX7CwescZKc3dMVS81rvQ+id4LJ2cUp
 UyJGeGKT3vLL3aa+kwNwLThD6XP1Thtzgcfmdonz5xS30MIw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8n38ess-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:04:58 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97762b21aacso143393241.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785427498; x=1786032298;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iFXm/EtDVHs2U2W42SOddHPDOyqIH60tAMkZpM5gLvE=;
 b=WbZeAba/bhhCB/r7BXaDmnOESQ/s6vK4DK1/M8/LzI4MM9KaumNwFkbNTv4JCgPeMS
 WDMMSd1fT/DAmqCniB5htj5CT5tJr6C+mFIs1qfDsMcN8oeyLQmwCw8paxaKiw25Kl0u
 dlk/LLLeFyjvtk2Y/FdpCoVagImyXJ8bXe12nUbJf3Cq6JwRx/XLmlNqsx0fCDXclAFg
 tigjGfPzwSWkvxhVMyBH95jtS84JidS4g0ZlnFLt9/WZqGQVgm0LUsG6uVy1jlAjFT6g
 H+YV5W5W0T1rz0fJfBbA4VhP3n00l3RPAKF/PUeTk0cgkmGcRwNJUdbABpBjduGUEp9a
 goxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427498; x=1786032298;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iFXm/EtDVHs2U2W42SOddHPDOyqIH60tAMkZpM5gLvE=;
 b=TbSphhanKm/rD01KieOB1Lkg+eJbd2ubJToZAwccQkyEn3tIUaQlpe9YtFlnyFKuhI
 ES6x8VbpX/xkqF4Qz1+d7yQ36oGxGlnvTM4y9zs0lAqhiJNZZ9Pu1ktid6VOsfRpx3+B
 pmseBj9ewRPHrkUHtyXmB+h9Ng+DUJrDdcJNmT184CK74EGNmxH4/8qmCG9v9KyP0azD
 YPu/QIblo4q2EgkC5bEuQIbH3ry/GOtTekdAyYTLxUmNitZQsBOn6yzOnE2Yp7mHWq55
 c9vOm5rR7rFKEd6W/o8KV+g3O9k/UDIDjx+ns6d77iRLNgs9TaUtX51S38jpuasy+mD2
 bR1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZq4MWOejNkqZoRQgJRTMVgrk9LpvoNoH+lbC7mB/jqLkox+1OSOzMyl7AyqwIdvEUYQRxKR17Z0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwA04uWKYmHfZfES/MiY9AoAec0q3mlky57dG46gWl7A/oBIjoV
 ZjOJ/bcpXDcQRjbO9nQiiMU/95wBzZ2/jZpzJlMc9Tpr0QlzRB8YLTKBAcxfr/Q29Ivb64lFIBL
 IYBtPyMrPIYydC3uatIEuCAz/HbDhUYdIGLo4tsvFwpr/NEEzmFWMEyqguzjWysEMUqvBhVM=
X-Gm-Gg: AR+sD11WxjoZUN4wgA/WDGTOpjuqYXZ2MKIAzwyxx16IwNthy14RuhV1lRCbLW/vtmr
 iTqLlLB49k/lRdV5dISwF922h0fN9J4CFPZ869va00zuXAcysYZuIlw+Jrh4xpm6XhSAyMe7PVv
 c/mCHUrhnL8Nu3mwVos/ZQZ5GV5clEzaEcn4UddWscdfpyt0uPcskn9SGq2oPnW60/ZZBZhCbaL
 OeK/2Nvt6Lj1oLbrqbK1wgUDPOhGr30m39sHmRhY8qismSrHI5gIoXmCpQSTdYl9COzAn/Fov+V
 OO7z9G8xCnRTUugKEvr5fYJaXFNasnCXbCWK8E+FJIl/65sDThzBhYjLaz3zN4wb2wSk04j7uCn
 ZW459Eww/FAZFLAhnoluJTXR6qeQ9PYWg6C17EmXbdsNm3BWDnTh6/soWT+FVwu9jVmh3zIEuXE
 q2dX2DXLRkw1vUVg==
X-Received: by 2002:a05:6102:3e8c:b0:73f:7bca:217d with SMTP id
 ada2fe7eead31-7574fa3ba08mr1029608137.20.1785427497777; 
 Thu, 30 Jul 2026 09:04:57 -0700 (PDT)
X-Received: by 2002:a05:6102:3e8c:b0:73f:7bca:217d with SMTP id
 ada2fe7eead31-7574fa3ba08mr1029575137.20.1785427497269; 
 Thu, 30 Jul 2026 09:04:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db8a3bbbsm455174e87.0.2026.07.30.09.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:04:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Fix GPU and display on ARM32 platforms using the
 MSM IOMMU
Date: Thu, 30 Jul 2026 19:04:53 +0300
Message-Id: <20260730-fix-qcom-smmu-v2-0-18e0daf2d836@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACV2a2oC/12P3W6DMAxGXwXleu5CKOHnau8x9SIEd2RaYMQBd
 ap49zrQadJuLH3S53PsuyAMDkm02V0EXB25aeSgXjJhBzN+ILies1BSaVmpAq7uBrOdPJD3C3R
 l1dRWl72uG8E73wG5sPPeL0empftEGxPk2Qg4LyyKR+3Pw9pfiye/m2wwNEBt80Ip2TdnXbZrn
 jCdIQQ+w7vYZiPe4qs3FDGIZB0cxSn87E9xPUkOciH/3b/mIKHL1dVIXdXyjG8T0WlezFdin3i
 Iy7ZtDyLZA5knAQAA
X-Change-ID: 20260723-fix-qcom-smmu-b5798c65d689
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3859;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BHH+L9EWf1eI35feeV2M9kSj2Yp6qdSNKH4O3ElD7TY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa3YnzXUe8LbXC2C3A+oEnLgKRB++0m7O/7hCb
 Kdljnb8F8iJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamt2JwAKCRCLPIo+Aiko
 1QAAB/40QNIv6eWzYMBfkNAG/IWHLSeopWBSj9IuGGh+y3n0U2PsnvmupUFge4UGzK/jZkHbvVF
 kIFu+pfiSMmcmXeZNrLv4cGbM5DhT/hlWEmAZT1SKsmPGa7CHgNBW0ghINKEPeKrNCmDmRr0wiC
 FVbeq3T0PK5r9vQ1nCOhdW+dmQb0noPxhBq8gzdkdZ0t3bltjHAtBOH0dOKJ2SyIKAwfwodCMqp
 S1Nzq/OZ1MuKwEpitAjq2piPoYNNm/q57FPnoxKtow5u/9MfNI6SGTIO+d7kcGOoHvBqS1yvA6p
 jnn614YdJ5rEs6LZd1UrTWGCv6zi74/8nVASY7z9PK2deEKM
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Ar/eGu9P c=1 sm=1 tr=0 ts=6a6b762a cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=tA7aZXjiAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=tVI0ZWmoAAAA:8 a=e5mUnYsNAAAA:8
 a=JfrnYn6hAAAA:8 a=CmaK_EYR3W9A6RVS5Z0A:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=FO4_E8m0qiDe52t0p3_H:22 a=kIIFJ0VLUOy1gFZzwZHL:22
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=TjNXssC_j7lpFel5tvFf:22 a=-BPWgnxRz2uhmvdm1NTO:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: zgcYl_IK7ralFqVUnudlNg_oyireNvBF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX9yoeyRhl/SRJ
 g2fCc/5mUbvXDEriHZQ8739t4SNnxJT1d317/7uy/VzRyKszx1F9HzBjkWnrMB/JzM+kY7jEyE4
 Wn2YJP00tHjhALFdnLnvNb7wtCAnS88Gk35mkODAmOvBWjE2lPQXZ8H0c/LUFqRtROOX+2wWtF5
 zsBGSM9j7Gv7lUpAlGelps3iX54xbfXAmcUawO8lKDiRVbTY7jUAiyfHW7Hs9pZuqX16g1o1CA6
 ZFwOWfdV2+5Sm8p8xGHa6by5glXuUT7ID+HkPHESkih7dqRkTDiJ5UszV9rUXQFQYmRKmu5UvdG
 bcsgiMxetRRjdJk9amH8lE8WYtFc3sIOg3Z6rI9R1Y6sogvBIr92VC9EOMH7gobf1Uvu/oeS+An
 r/0bJV2QRdFhetpwi7ad3r/RCwcrcG8qMBY856fP8A5DNaWo4qGgS98MY1VsNthUUnobmhN75kj
 anYVyQQYk3o9oCbzTDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX3mkpaJhbJGeI
 ot/q938gBppLo4Sq/a3mDVfRsgEERUxqOP79HT+L16B931u8WZSM0RSXLBgIfZpIhn09OP6CDPP
 TgFp8khOBgAueB4ZERBQkpuCkfPu4Y4=
X-Proofpoint-ORIG-GUID: zgcYl_IK7ralFqVUnudlNg_oyireNvBF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
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
Changes in v2:
- dropped dev_warn -> dev_dbg chunk (Konrad)
- rewrote second patch to use correct device inside msm_iommu unmapping
  (Robin)
- Link to v1: https://patch.msgid.link/20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Joerg Roedel <jroedel@suse.de>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Heiko Stuebner <heiko@sntech.de>
Cc: iommu@lists.linux.dev
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org

---
Dmitry Baryshkov (3):
      iommu/msm: track a context master per device and IOMMU
      iommu/msm: use the IOMMU device for page table allocation
      drm/msm: detach the ARM DMA mapping before attaching our own domain

 drivers/gpu/drm/msm/msm_iommu.c | 22 +++++++++++++
 drivers/iommu/msm_iommu.c       | 68 +++++++++++++++++++++++++++++++----------
 2 files changed, 74 insertions(+), 16 deletions(-)
---
base-commit: 78bc8af4affb9a732504eb22eeac7d1e50883853
change-id: 20260723-fix-qcom-smmu-b5798c65d689
prerequisite-change-id: 20260723-msm-fix-crash-8c13220d9465:v1
prerequisite-patch-id: 3556d41e924ad64e8e9c06cc5bd1972c66957f42

Best regards,
--  
With best wishes
Dmitry

