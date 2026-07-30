Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B31C55164
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F5E10EFD4;
	Thu, 30 Jul 2026 16:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="glkT3Zu0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TfjSSu9s";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB5E10EFC9
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:01 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UFQn2C731340
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9UELQc9w8LCzzjxYarbpAJ9nz5UK+I9ucKQ5zTVatiM=; b=glkT3Zu0udYthktq
 uif3L3Z1Sw4AagvP5V/vdQcnBSDJprLWJR+cHZPBtz1+8SBzGGJW8F+EgcLD7Ver
 jrkcxUM9vqAwv5/PmO4FQgNw+eL/aA+j/bQp2obub37lkSeolEpaKi3RAENUuWTA
 qRQop5KTdsw4u3ibSi6+t4CjxkOOBSfhQLZlePyXjwhCmTiet5/bLV1bRq33C83I
 m61B1CccBPEdyHvW2zymcYZeEYQPudP+xmw2nTDBX/+hjuRT8BOlSMPsSm8lCRqZ
 3URtdM4XN3O+QnwIAom9VjXI0iDz8mKYSisFazpz1fH/DnsqR3OLYH7CiqN0qaYS
 jmQohQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr8j7rh0h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 16:05:00 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so27019611cf.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785427499; x=1786032299;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9UELQc9w8LCzzjxYarbpAJ9nz5UK+I9ucKQ5zTVatiM=;
 b=TfjSSu9s5LOTAxbUNXo8U/VmwuA3lXsj0kLJFBoyIxX9oTj1fNgwIaxl/DsCRVXLam
 0cf1M6gHIM27L7NvCEDfrvb1DF6ZJ3wQE6NHtHYTi8rTnsnNvYpStFzrHkS7E0G58/tL
 JQVRL1wb/4m+w9dVtsEoGhV8YWFHche7zCaSmrylWMXMS5fQy/4J/6Nr9/cKdN9ai5j9
 p7Qn/tgTpdeJbvZvuP+Pbrbf/NRPD314IJmAHaV8WM/jNmnljkY+b1wpqJ3hFHZObTJ7
 z+RrDc0bb6QV21hqdyoYAj/8kpLdsaC+fXQ0Nnf76DV1xcNkZ8odncgL8ufjT6xc1kEM
 vbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427499; x=1786032299;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9UELQc9w8LCzzjxYarbpAJ9nz5UK+I9ucKQ5zTVatiM=;
 b=sjlVLV4f+06W5cDmPwbS1xmvuL9yni3/XsBgmpU2N0DLxACur7tyonM1K4v8c+0sQ/
 gYyno9UVTP5ApbbchPXk87+vxzjcmQ8Mq06wJZx0gLBpTtoSDMXJTqFcxdYthmsmPTW7
 vZzIUnsGUv5BX0m5cDgDQzy8rudxTjPWiYTq8jHlzFuhRBZhShJQdg9BKqx1s2Z5kDr4
 TRzB+gRHIEXIYZCFfLRRf0GOnk+XGOQfBC17wSEO9Mj1YIee5+wtaEVfPEG6wHu2ucm0
 5mLFQQn3TshbOdcp3YFHpg8Ar/rSvVkNeod2+DW9ccLm2sy/kMb9H+FeX0KvIzHAH2R+
 qu5Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RptQprG2hEwbzHNkFd2D2J4L/4NkbMUl7pYJiDlxHsLAzNy0HmialMlQfowq0AYfiI+DM4lMo0bgys=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySp0vQljYLU6p6NOGO5dj6vd94sTZqmdIjIe17wSn/YKS1apPJ
 aLVTn9YKsm2/qiTkNkkfo2ZP15uxaNEmsugG62lZYWMxkZcuLjWAhQrpdhHh+aHx54r3Zq/eMDw
 4kshYf2IpDOIPCC/5pw+4Z3s7KJXM7Q9pBAMIu8vnm72qLujkFwRQLJwGaI79d/pBysYr30U=
X-Gm-Gg: AR+sD11zfp/Whmxw5EY87KJZiXRxAWOt2ZObmzGolMHeuf5CteCkSHKkHE7eYI5yMqd
 +V6hp/qnT3HjzRtOoxRctx0Lx7rqH9EuLg/B9iwAiYSWO0CripTdNbC6cDuF+U1d6otgvOjHLXy
 qm1/8qwvoZH80qfR2jbvxRRNy0sHyLKZAy76SPU6GPwydl6VVrz2nPPbiPagRivKKvs6mZotZMn
 /n+EIe8m9NVBlUtTZCk5TE7vLO51Z2MCwjppGRN7UqRM7Sm2XT4b3eGBD2ttLexZ0kgqGkrKz9w
 ZkD3t1El4zJ3n+Q1z2/m2btOAChqEdN2vfg+QOVDUlxlzsjO03CwNb5C4wsqTY5qWzrJVmdBZgU
 7lfRHm8+fnrwTY1oEF3SvudBOW6vwLrgeZPrpJZKA7Bzk4kaaUbFqPnf0L/tLLyk64W/kTqNOOD
 tmVFUlai7UEVEUvw==
X-Received: by 2002:a05:622a:230d:b0:51a:89db:95a4 with SMTP id
 d75a77b69052e-52b385fd29fmr35355241cf.6.1785427499412; 
 Thu, 30 Jul 2026 09:04:59 -0700 (PDT)
X-Received: by 2002:a05:622a:230d:b0:51a:89db:95a4 with SMTP id
 d75a77b69052e-52b385fd29fmr35354661cf.6.1785427498920; 
 Thu, 30 Jul 2026 09:04:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2db8a3bbbsm455174e87.0.2026.07.30.09.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:04:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 19:04:54 +0300
Subject: [PATCH v2 1/3] iommu/msm: track a context master per device and IOMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v2-1-18e0daf2d836@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6092;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=guIutXCKMCgx6tORPQOqWmA7vPORsOE/TVjA3vw9Q+A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa3Yn4kLhQsAPOamQT6NCi7uPbs+IAU2y/t5LQ
 qsyvGkAc2mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamt2JwAKCRCLPIo+Aiko
 1Z/uB/9vT5qu9uIJIIMy7XHgHWLW37RCZ2CoK4tJ5Bdp3Hjqtz5Gry7EuPZUYOX7/rbSdPAflmt
 GgX2KmJaq0KQxkBzUVcfMhdKrG1biJhQqEObfPqk66yXWdNbxCUetfcvJ9FIkNhWY3AUz+KH4sV
 PcaX0Fd+4Sh7r+zRA411KE3gkAljn7kRJP96LDJpmTbHmxAEO5bV9TjZkzk2nsRZEI/ffWPHlgO
 bJXSjJcH6PnTI2rRQGtFkdsa8LDaR9sU4U7LNV7TICEdHL/LKS6/Yep/9CtXM3PLRRV5Bl6RLCc
 S0Cyzn/jdNMB3rX7GKRPZANXNB+4wcPzFmonhmDIH8JG18vf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfXzV59CFOzkcQv
 vvkIGFSZ41uN8n0sW/GUm2nI+T+dxcghCacGo3NdOPE2IBuTuH0EsDK9oOth5FIAxaj+j1iHl1W
 bGNPQVTxHs8rgY3nCLe7Aq17FUfE7cAtNIifZHXFnNySNz68ywVi7JIHqx7/f4PQ2R2sc7CucCM
 oTUGSlSCnna2zjECqXOe/NNBTHBxZCqhEFe8NcqYHdHMZMHDYwEAwt2eLMemNgnc2D0gHkRKUKb
 ZkesClf2K0W1Aa+bKUK71YxVnHJR7GLAaK8f+nAAhpf7iyEUHrELmvoHJuWo8skYX0n1ywyyE1M
 ysYTkZiHU3Ui+CeWTC+n00+5/G57oyhhDYp+pytHEhq+PtEx0rPlzXpScarT1zq/x6JyyEUiLqF
 +XiQoMAke0e85xDL3Gq53DIMKfdIPCY2xAn+TMkjm4dOOpRBijsmXac/jgspnSsTgo+S4hv9ldF
 sP95pMnkCFO9ToZFpZw==
X-Proofpoint-GUID: vIoXz7R1SzrCWk8lRn66tOcig_pgXB6t
X-Proofpoint-ORIG-GUID: vIoXz7R1SzrCWk8lRn66tOcig_pgXB6t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEyMSBTYWx0ZWRfX5hcYhVwvwmEE
 Jhg9KbW685DZcegxA3L60PNUuwdpH7D4r/DcGa4KFzG7/+7MakjD8EcEICI62s+6Y0DHzCRf/l9
 wZ650w9TTeiMZPEIM/ydeVvlbe5HH+k=
X-Authority-Analysis: v=2.4 cv=LraiDHdc c=1 sm=1 tr=0 ts=6a6b762c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=NB2GtN1_7RWpjchEhWAA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300121
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

insert_iommu_master() decided whether to allocate a struct
msm_iommu_ctx_dev by testing whether the IOMMU's ctx_list was empty,
caching the result in dev_iommu_priv, then unconditionally dereferenced
the master:

	master = dev_iommu_priv_get(dev);
	if (list_empty(&(*iommu)->ctx_list)) {
		master = kzalloc_obj(...);
		...
	}
	for (sid = 0; sid < master->num_mids; sid++)

Neither key is right. A master describes one device on one IOMMU
instance: the attach and lookup paths find a device on an IOMMU by
walking that IOMMU's ctx_list for a master whose of_node matches. The
ctx_list emptiness test is per-IOMMU, and the dev_iommu_priv cache is
per-device, so the two disagree as soon as one device spans several
IOMMUs. On apq8064 the GPU uses &gfx3d and &gfx3d1 and the display
controller uses &mdp_port0 and &mdp_port1, each instance carrying the
same stream IDs.

The per-device cache also turns into a NULL dereference. When the first
of a device's IOMMUs registers, iommu_device_register() walks the bus and
drives ->of_xlate(), which links a master onto that IOMMU's ctx_list. The
device cannot finish probing because its second IOMMU is not registered
yet (-EPROBE_DEFER); that tears down dev->iommu and drops the cached
master, but the master stays linked on the first IOMMU's ctx_list. Once
the second IOMMU registers, its bus walk replays of_iommu_configure() for
all of the device's entries, so ->of_xlate() runs again for the first
IOMMU: dev_iommu_priv is NULL while ctx_list is not empty, allocation is
skipped and master->num_mids dereferences NULL:

  qcom_iommu_of_xlate from of_iommu_xlate
  of_iommu_xlate from of_iommu_configure
  of_iommu_configure from platform_dma_configure
  platform_dma_configure from __iommu_probe_device
  __iommu_probe_device from probe_iommu_group
  probe_iommu_group from bus_for_each_dev
  bus_for_each_dev from iommu_device_register
  iommu_device_register from msm_iommu_probe

The faulty guard has been there since the driver gained generic master
bindings, but it stayed dormant for years because a device's ->of_xlate()
only ran once all of its IOMMUs were present. It became reachable when
iommu_fwspec_init() started deferring per instance on the ->ready flag,
which is what lets a master be stranded on the first IOMMU and then have
->of_xlate() replayed with dev_iommu_priv already reset. Hence the two
Fixes below: the first introduced the guard, the second made it fatal.

Look the master up in the target IOMMU's ctx_list instead, allocating one
only when that IOMMU has none for the device yet. Each instance now keeps
its own master and gets programmed with the full set of stream IDs.

That replay also means a master outlives the attempt that built it, so
the stream IDs it already holds have to be dropped before the next
attempt collects them again, or every ID is seen twice and the whole set
is reported as repeated. dev_iommu_priv is now free, and it is allocated
and cleared together with dev->iommu, so use it to recognise the first
->of_xlate() of an attempt and reset the device's masters there.

Fixes: f78ebca8ff3d ("iommu/msm: Add support for generic master bindings")
Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/iommu/msm_iommu.c | 49 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..109688d69e50 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -597,24 +597,51 @@ static void print_ctx_regs(void __iomem *base, int ctx)
 	       GET_SCTLR(base, ctx), GET_ACTLR(base, ctx));
 }
 
+/*
+ * ->of_xlate() is replayed from scratch every time the client device's probe
+ * is retried, so the stream IDs gathered by the previous attempt have to be
+ * dropped before the new set is collected. dev_iommu_priv lives in dev->iommu,
+ * which the IOMMU core frees whenever an attempt fails, so a NULL value marks
+ * the first ->of_xlate() call of a pass. The device itself is stored as the
+ * marker, its value is never used.
+ */
+static void start_of_xlate_pass(struct device *dev)
+{
+	struct msm_iommu_dev *iommu;
+	struct msm_iommu_ctx_dev *master;
+
+	if (dev_iommu_priv_get(dev))
+		return;
+
+	list_for_each_entry(iommu, &qcom_iommu_devices, dev_node)
+		list_for_each_entry(master, &iommu->ctx_list, list)
+			if (master->of_node == dev->of_node)
+				master->num_mids = 0;
+
+	dev_iommu_priv_set(dev, dev);
+}
+
 static int insert_iommu_master(struct device *dev,
 				struct msm_iommu_dev **iommu,
 				const struct of_phandle_args *spec)
 {
-	struct msm_iommu_ctx_dev *master = dev_iommu_priv_get(dev);
+	struct msm_iommu_ctx_dev *master;
 	int sid;
 
-	if (list_empty(&(*iommu)->ctx_list)) {
-		master = kzalloc_obj(*master, GFP_ATOMIC);
-		if (!master) {
-			dev_err(dev, "Failed to allocate iommu_master\n");
-			return -ENOMEM;
-		}
-		master->of_node = dev->of_node;
-		list_add(&master->list, &(*iommu)->ctx_list);
-		dev_iommu_priv_set(dev, master);
+	/* A master describes one device on one IOMMU instance. */
+	list_for_each_entry(master, &(*iommu)->ctx_list, list)
+		if (master->of_node == dev->of_node)
+			goto add_sid;
+
+	master = kzalloc_obj(*master, GFP_ATOMIC);
+	if (!master) {
+		dev_err(dev, "Failed to allocate iommu_master\n");
+		return -ENOMEM;
 	}
+	master->of_node = dev->of_node;
+	list_add(&master->list, &(*iommu)->ctx_list);
 
+add_sid:
 	for (sid = 0; sid < master->num_mids; sid++)
 		if (master->mids[sid] == spec->args[0]) {
 			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
@@ -646,6 +673,8 @@ static int qcom_iommu_of_xlate(struct device *dev,
 		goto fail;
 	}
 
+	start_of_xlate_pass(dev);
+
 	ret = insert_iommu_master(dev, &iommu, spec);
 fail:
 	spin_unlock_irqrestore(&msm_iommu_lock, flags);

-- 
2.47.3

