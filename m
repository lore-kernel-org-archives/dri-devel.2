Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED4C1C55160
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1198010EF21;
	Thu, 30 Jul 2026 13:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4XhQVO/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zb4PXuxA";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF17210EF09
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:38 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDDIax841996
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EyQnsFr+AkCF9FJZQJYLZH0Aizak4PdcRcM5bMpVZbc=; b=I4XhQVO/0yt5Fapx
 y6FEqK1dFBP3zbhxBiDkxGJ+C86CPlnylu5yZpbMk09f/jeabXeWZnzgB6oxSduH
 QIvOMw5QSaEsjyKRdn3wVA2y9EwGV8/kZ3gSaoSKcBGwsMsVB7iaOICypJisskg+
 6bqFzp6RodZFV6mi5oB6yyZ7SYGZEaW252Lq+EgDITMdvY8fyDgBZot20bvwYimW
 HsFzkYEyqqgywiO3Wrw3JYm+NFAxUP5T3pdMTBe7ZoHXub2loyr1piOunOkfO1fA
 ynFnggbqS6rc6c7UF0HuUANmhUCqXMLdv4qrFUMv0j1tSWYV6W3kfpx4bWH5pR3K
 cNLtRw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6wmg6h0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5174a236220so21514371cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785418177; x=1786022977;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EyQnsFr+AkCF9FJZQJYLZH0Aizak4PdcRcM5bMpVZbc=;
 b=Zb4PXuxAzaxbhEvUQlzVPmcUfxWFUEWISzltlmN+FJAD3upW6EtVX0FOvBh/9Vr363
 Si5a5wu1ngDNB+ja+H42xwYQCOGWsUQqF+nlP1yfvYEqj6vRGsS395AnhCW6UGsa7jTi
 OeLuWSav6iBl/RpXMMmSgw3c+b4uiKNjQLYSiepmwe59rnyyKJ1c34KGEEA7UVICiKIZ
 0mh/SeagXdJuzzVsC9WqejVhWn4i/CmqJPbiHvyN50VzyMrhYvEgd7Tk1IcvbV+w3yng
 x4m60PQ+6S39CsLgaiD35fzC1gUwPJgP9jyozoy3YtbOf7lSA2zgMdrqyhabbSQKebIN
 2TEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418177; x=1786022977;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EyQnsFr+AkCF9FJZQJYLZH0Aizak4PdcRcM5bMpVZbc=;
 b=FyN2MYDna0y48kzvpFUf/vlHQaZ4L5VrW/0O2gEZG8fePqChDghlPXMeAvxqPzanzZ
 2+PcC2jqiIcyu+dJr9PEdV3VichJFbrAoLcCdkxkruLdy8+cBlpQK2cP3VS6VB3K5eaa
 uU6e8X883AI8BQbH96K6lFCfN6u5oqWeAhkiOCRVEDw8mrSN1Fn1CFuFe+munovkSEx4
 y3N6icrbzMdSDj/4IB8BSGUgwgEjt9VcxM5Se6GKp9X0tdwT6l5RXPrdT6Rm2/XT9a1b
 MRklfoyfIxogmqKB2pKVEQoDDmKJ8lCSH53UVv3athwH9hIhZuIGkKiFBDhmEf4IvqQT
 kQag==
X-Forwarded-Encrypted: i=1;
 AHgh+RobuC69xjcC8yULapgb/Q2nLzULpucZpWXnSl3MGga8aQUJri71SE5GXLa3Mw6+KQy6Jq+TtJ/aBVU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmQMehTPrQAGMOFW4nmN/BhZmKsCDkvTHHiUNahGY8aDGDkLFD
 9sIYwBXNHmmNfP8ipz6fHMKqZKwZLLUkq5yOB9GUrMPg3K2O9plyJX5OlEMwbutYio79P68OYp5
 yqzXDyOXbRS74xPw9rBD/EUgHsF43SMU7ugWV0GAU4CVslnzE38XDLw1tR/Cx5eniOjlKkqI=
X-Gm-Gg: AR+sD125t1oZ0W1S4oQtxEa+lshW68eQ2ZVhS3wDO/h6NRItcwPS/QYYqW9oXU8S9vg
 EZ2RptFJ/Ue6h9UloWeGpboU0QrM47DF499NJmiuwCP6wX8jkTZuV0SdgWAIsbZOZy+pJ/pnMS9
 1vkS72SeOEahqyYGhyIM3YRvtTI3WkvWQHMy6pQQ7motIGifarWjwnvDCIe0gzreQTAT4jRUlE7
 87A8K1+Mvii3onLtDjLRhyVr8lGyzdFC3FWo7J7PHIKBEP/b8C0rx+/HVxAu9jNuNM06KYkr3m5
 pcC0EO2B/hyn6iVOTBFsVxAXjeyYbcv5oO7NnW+0ym2ktwwVTxdTVvmHM0JKLlJCgvXNgtFZP6n
 pqAEfa9yuHEm2UiLmoJYSS2dSCGJirf0RM3vynHLTCtL6duZcaM336zZm69vSCnuM+wdvkwyN9X
 A7WiVoEX/arTP6yw==
X-Received: by 2002:ac8:598e:0:b0:528:3ae6:14a0 with SMTP id
 d75a77b69052e-52b42c461ccmr2050571cf.46.1785418176524; 
 Thu, 30 Jul 2026 06:29:36 -0700 (PDT)
X-Received: by 2002:ac8:598e:0:b0:528:3ae6:14a0 with SMTP id
 d75a77b69052e-52b42c461ccmr2050201cf.46.1785418176070; 
 Thu, 30 Jul 2026 06:29:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f6acaa009sm2976631fa.34.2026.07.30.06.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:29:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:29:31 +0300
Subject: [PATCH 1/3] iommu/msm: track a context master per device and IOMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v1-1-b12fa067804e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4681;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HDvKxpINpBdyUinpnTD4Zel+FLNhUAi/UNzRGhoHMSU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqa1G8k9/g5eNcbQTp950ENXclQTiusv0LgYSR2
 XAet/hi4xKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamtRvAAKCRCLPIo+Aiko
 1VpfB/9FYILN4yvdF3Vwn4jVt5QhJoVPIwN0sjpqfAnTByi95EeWKKE5S87ktT0abAPbZ2UOVT/
 Z2k/Ru/yCM7HCPUm42G7XLGJIRiJ+TGSojMsfCIu4vAVXgWqO5jyv62CSaMCw8zNuuJz10C6wuK
 OVh7YrahohCLi3+ZsXvJELj0N092LIAY5idouHvL0w9oX3x279RmxMw2C2MB7OuOzowOu1ZGydf
 ZYTyz45hsbQf9YS8JQq8u8gpJJPEltmaIL+9mTTsqPdRhRw4uUqApovyaLGZxXxYnw4iKFVsZFl
 vjxJXlzNI9fWzWdu6RJh4IxnKnbjlisUbM4Iky6LJp3ctWbl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX0UzbqedcTakf
 TyPAdN0CTvKBweqmRomuinmR+a8b2JYXh60uCMu/KXYaHfXxuPtmaKvEDnG6/EB1RidPVjUUHU7
 xQbNOmS6m4YqOoca02jdDtw/M+jLyh8=
X-Proofpoint-GUID: sznTBzsQjpck84RyGDtck79QkBSmcqws
X-Authority-Analysis: v=2.4 cv=OauoyBTY c=1 sm=1 tr=0 ts=6a6b51c1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=wn2kx61HezQC-XnySuMA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: sznTBzsQjpck84RyGDtck79QkBSmcqws
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfXwr3zYP0wvnqw
 yNh5zlAz8oRcBVMy/IKvxKw9YrMLjm1FiBjsoFwCtZsPOBnYQ3dLMY7vbOPLESlU3nnOoB+rHH2
 W1TxATr6C5xYxEpRjzOe53lbRQgsL5mLPpNFUqpsRE7xiHDV85AmkrL0TKfl7KM3p7qPyd5olnF
 P0AyHzp0QfjpMbU1HbZbRiNB8TM648/jFhTQpW4Zn/4SltFnbPzvYAFDpvsff5VIfit9d2PuQKh
 WAVRt9oRGoLdEiaBVO3fZPDZn2yXMOzjcuv4huccIfUYkwSPzfgx+ETY7bhXzXlE1rjHMRrKWl7
 TfuVZetCUmRGuazrrCjcEkqQPNkqw+5Tj8Hwij8oK5GM95zQu8wQjB6+3qdLnsu3Anq4p7EPnnI
 IXXsAKkpFqMs3W+X5x0D6UiRV9XzCTVyLuhQwbHrIuGwrn8YG9ul2BsUNV+OaMEzrZ2BDdviHVe
 deTBfF6lPJSCqFp6prg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300102
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
its own master and gets programmed with the full set of stream IDs. A
stream ID seen twice is an expected consequence of the replay described
above and is already ignored, so demote that message to dev_dbg().

Fixes: f78ebca8ff3d ("iommu/msm: Add support for generic master bindings")
Fixes: da33e87bd2bf ("iommu: Handle yet another race around registration")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/iommu/msm_iommu.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..3847f5f0059f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -601,24 +601,27 @@ static int insert_iommu_master(struct device *dev,
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
-			dev_warn(dev, "Stream ID 0x%x repeated; ignoring\n",
-				 sid);
+			dev_dbg(dev, "Stream ID 0x%x repeated; ignoring\n",
+				sid);
 			return 0;
 		}
 

-- 
2.47.3

