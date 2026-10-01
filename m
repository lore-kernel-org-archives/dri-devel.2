Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35CDCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ACF410F6D5;
	Thu,  1 Oct 2026 15:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Kf6rJcWY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G6C40vq1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E72B10F6D5
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 15:01:02 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691DwsQx2008510
 for <dri-devel@lists.freedesktop.org>; Thu, 1 Oct 2026 15:01:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5bAcYGIy8jeI69YAlNTN0l
 uYORkRy+CXm8QV/D8mVoQ=; b=Kf6rJcWYegaDp3jf1LFrlEekIm8E3HGo4HFZD9
 rFDaOuewIJHuP0ht4l3tOWqs60ZsMZIrKD9pKJNymlvt4OT46mWm5YwYObpL5qyS
 ODOTUoRxfZurjBvRUa8gZ84R9pEsqJX21/XvdKD9qN9/+jlK4Zr5kE0pTjt4mfX5
 NXLaAI+DAlGxbpwPmu55xILYVcNQo1gSZV+QMyasWMFS2lymZXZktyXkmtqvCnmz
 a74ZZHVBkG1lVkUKfXFC1btAXPHrtsTMlX0sDsRUvPzIp1yMIxGyU1CKN/Sg+bLM
 3pDs81pC7AjbfxzzHU1hhh/FbrGET9Gc6XM9Id1kmf+kB1IA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvq8a4v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:01:01 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-80668533f9fso10151650a34.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790866861; x=1791471661;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5bAcYGIy8jeI69YAlNTN0luYORkRy+CXm8QV/D8mVoQ=;
 b=G6C40vq13wdoAEFhBWdm5VQmQdyA38W/QEG3hQPyZyk2w3wifDh1FGBvmftpoKd8o/
 2UbuVsiy7L1Xa01VcM9BNbhzEj5nw4u+ZwMOipOKmVrQsLwL5j6toAjtTinc2tIpC1dA
 w9tgrkzj+SaLW0PTIg3vK06IvQFjLQ/CAtaj9fNkgdIC8WbPXZfq8XGJQlfU+W1AQP8y
 59/FvXwJYl9W/kNR0U0z2fq9Tm5oPwU4e6zS3GF7XHmZ6wHnt5RqbXJEUwC2yUobi/CM
 Peh9E7XAaV3Abwt5O3kJQ7FLI6WbtYP/pKKo4t75Om3+uPOjmrDyNmLa1FBDzpZ5pO9e
 Ur1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790866861; x=1791471661;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5bAcYGIy8jeI69YAlNTN0luYORkRy+CXm8QV/D8mVoQ=;
 b=qtJ5SOaqETwV0gyWfnIBQEreNfJ2pIky8rNEd95+AmFsg8duSXCyATEMeXPxXTVpeH
 7+5/mE6UD8312demZzU693x8kfK9hAXSlSW6M0j1/cV4QglgQodI2K0CsLOBMiymtezC
 3HFUflQcE+hyaipr1UeGapWR/gIkbdEF6eeQP3Zfw9S0cNw84SxP1ESDp6ESo/jOJb5x
 EAUO9r6rPHn8P/ISxua4P6nNdVnA+hFtKFgt/ckUFjdZPcCKwZ85wh3eyYVyOz4JP86m
 IVcZiTd6snRpqJbmjeJopWGZ7WRpR30VLxq73b7GU4EsjFC7GQ76qXsNlcYDVbFWWyYG
 fgzg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz08/zYW5HGaCqwTOmSRfiVXQ+SlZgxgAWI2AEY9IaqyBwmctsuyiyy3dywfylJ7rKS5u0zpR6Coag=@lists.freedesktop.org
X-Gm-Message-State: AFuF++laeQ3GyQqK+SgWWlKzts0RKqxH9gUIheRMQs3ncFeqo+V3xacZ
 BGD9Xm+Ei7rkY8IR/1bE3NDPQCXaghRn8uH0wCBx9lLZuAffLedlp76SSTLMRSWNHy3nWEHcZZa
 ZMfyTK3VADji+Sr5w619GI1/44Oz4I8+0VQRTOpecuu5/R+KqSqSaTkHsZLHpZYThC++aujJcfY
 VugzQ=
X-Gm-Gg: AYBFou2uxcHJdkSFy/4gwaDJq7GFVyPr2wY1vj6zLT6qW8Gd7W9NI0p8DLo4tr5xhqj
 um1fPGQZQUMl3mU5nn1CtqkS5S3UhghgJZBHJuCfYmPwDKmdhe8eaiPvvmFlgBTgyzGGbiFjH6r
 3VFrMYYCkT/zUZYfx2pq9w1XlAO2XHGRSRzc39qZenYcqO3rYaTWdF7zpE8MnS10CUOaaGJmp+y
 2+vT+95DlsdH2rI4kHxlZCE/srgGnpLsuEixw1GQ8AJzbvR/EvNZV6NqxH9EZdlKXvkCr3jE6t6
 LWeLFrd2GmSymAQnCycl01tgGskIUhwS2SlE5h7PUY3LgIP9Q5Fc7bUXzjZICzLgXdCDbllCdGD
 /M5MK2zA+kA==
X-Received: by 2002:a05:6820:1501:b0:6d7:a325:35f7 with SMTP id
 006d021491bc7-6dcf68163a3mr5166243eaf.81.1790866860331; 
 Thu, 01 Oct 2026 08:01:00 -0700 (PDT)
X-Received: by 2002:a05:6820:1501:b0:6d7:a325:35f7 with SMTP id
 006d021491bc7-6dcf68163a3mr5166181eaf.81.1790866859513; 
 Thu, 01 Oct 2026 08:00:59 -0700 (PDT)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6dd982ed764sm2590712eaf.11.2026.10.01.08.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 08:00:59 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Thu, 01 Oct 2026 20:30:49 +0530
Subject: [PATCH v2] misc: fastrpc: map ADSP remote heap into remoteproc
 IOMMU domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-fastrpc-kvm-iommu-v2-v2-1-6c32ad6f662f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKF1vmoC/yXMQQ6CMBBA0auQWTtJnRpEr2Jc1HaQ0RRIBxoTw
 t2psHyL/xdQTsIK92qBxFlUhr6AThX4zvVvRgnFQIZqc7MGW6dTGj1+c0QZYpwxE57dNdiL5dA
 YgpKOiVv57dvH87DOrw/76f+Cdd0A9/+rPXgAAAA=
X-Change-ID: 20260930-fastrpc-kvm-iommu-v2-1a7d343ed802
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, quic_bkumar@quicinc.com,
 quic_chennak@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfXxHimNB6Xe84j
 DquBHngaLkq8rxM82BFiKB5uiHKtxrOapya0+1903F9k4cPha7GKJIdD7P99sB49ldenmUFhKbz
 eWZzwPL/4TKt1J3Mhd4uMdjcMVV9BhqHibo3/0yo2jzUdlXcEWM5Hmp4cgE4RaTdnv7pcJsRmoG
 jCY1gheEOT8Bj0BHGd262XF4E6MH29qOGGevqqwHjYAvwEti48Ac7NaRoAoOJHGJ44F0u30Q8Et
 wZQv6WaEhnK9Za7XsVIhHyEEyF3f7Y/I7dS61bF7BdK36TJEVIEhOaA4U/iML0WeN6eR8Wc/HlV
 pCSLSpdOITzJezkm60d/R3uQkDWF4PSSiZLBomtAbCbLwTEGAR5lGVWnIKd2OIMrSXZHiAMumbs
 9Q0apY+W0LNFk1UkqEhq/XTaGndrzBvxPw5EdkQLNibD6hH1qVUu8ni0GdDLzIh9ghaPsnrrPfZ
 A0YnZNTEH1siStEc5nA==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abe75ad cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ag1SF4gXAAAA:8 a=e5mUnYsNAAAA:8
 a=COk6AnOGAAAA:8 a=Mo4pmYlT2hf4TzH739EA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: LcGpfVk788qj68jXiIGg-4aceTlrgUlZ
X-Proofpoint-ORIG-GUID: LcGpfVk788qj68jXiIGg-4aceTlrgUlZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA1OSBTYWx0ZWRfX6mqbR8u6FIMV
 YsQTSCg6Gksm2eouBX6QJK+pCy1Oq0ImNcIhzOA50phrzNvjeuBD9+XD10uoLd+YwK+E/m8Yfow
 ZFIkXyx2cC6bHy7Znr31zs6CFuYHmUA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010059
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

On KVM-based targets the kernel runs at EL2 without a separate
hypervisor to manage inter-VM memory access control.  In this
configuration the remoteproc is assigned its own IOMMU domain, and
any memory carveout the DSP must access requires an explicit mapping
into that domain before the DSP can reach it.

The existing code calls qcom_scm_assign_mem() to transfer ownership
of the ADSP remote heap carveout from HLOS to the DSP VM.  This SCM
call is only meaningful when a separate hypervisor (e.g. Gunyah) is
present to enforce inter-VM memory access control.  On KVM-based
targets no such hypervisor exists, so the carveout must instead be
mapped into the remoteproc's IOMMU domain via an identity mapping
(IOVA == PA) using iommu_map().  Without this mapping the DSP
triggers an SMMU translation fault when accessing the remote heap
during audio PD static process creation.

Detect whether the remoteproc has an IOMMU by checking for the
"iommus" property on the remoteproc DT node and store the result in
a new use_iommu_map flag in fastrpc_channel_ctx.  When the flag is
set, map the carveout into the remoteproc's IOMMU domain instead of
calling qcom_scm_assign_mem().  Introduce fastrpc_remote_heap_map()
and fastrpc_remote_heap_unmap() helpers to encapsulate the IOMMU
domain lookup and map/unmap operations.

Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: ekansh.gupta@oss.qualcomm.com
Cc: quic_bkumar@quicinc.com
Cc: quic_chennak@quicinc.com
---
Changes in v2:
- Rebase onto the fastrpc-for-next tree, which now has the remote
  heap allocation and reserved-memory handling changes.
- Rename has_iommu to use_iommu_map for clarity.
- In fastrpc_rpmsg_remove(), the IOMMU unmap path now mirrors the
  qcom_scm_assign_mem() path exactly, so the two are handled
  consistently instead of leaving the IOMMU case with different
  cleanup semantics.
- Add fastrpc_get_rproc_node() to fix a device_node refcount leak:
  the previous of_get_parent(of_get_parent(node)) pattern never put
  the intermediate parent node.
- Unmap the remote heap from the remoteproc's IOMMU domain if probe
  fails after the mapping succeeds, instead of leaking the mapping
  and causing -EEXIST on every subsequent probe attempt.
- Log a warning in fastrpc_remote_heap_unmap() on each failure path
  (remoteproc node/platform device/IOMMU domain not found, or a
  partial iommu_unmap()), instead of silently leaving the mapping in
  place with no diagnostic.

Link to v1: https://lore.kernel.org/r/20260618-audio_fix_clean_v3-v1-1-ec1ee66fe455@oss.qualcomm.com
---
 drivers/misc/fastrpc.c | 149 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 128 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 5ac7b3e78ba7..89f4a80ad9be 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
+#include <linux/iommu.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
@@ -317,6 +318,8 @@ struct fastrpc_channel_ctx {
 	/* Audio PD reserved remote heap region */
 	phys_addr_t remote_heap_addr;
 	u64 remote_heap_size;
+	/* set when remoteproc has an IOMMU; use iommu_map instead of hyp_assign */
+	bool use_iommu_map;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
@@ -2507,9 +2510,90 @@ static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unuse
 	{},
 };
 
+static struct device_node *fastrpc_get_rproc_node(struct device_node *node)
+{
+	struct device_node *parent, *rproc_node;
+
+	parent = of_get_parent(node);
+	if (!parent)
+		return NULL;
+
+	rproc_node = of_get_parent(parent);
+	of_node_put(parent);
+
+	return rproc_node;
+}
+
+static int fastrpc_remote_heap_map(struct device *rdev,
+				   struct device_node *rproc_node,
+				   phys_addr_t addr, u64 size)
+{
+	struct platform_device *rproc_pdev;
+	struct iommu_domain *domain;
+	int ret;
+
+	rproc_pdev = of_find_device_by_node(rproc_node);
+	if (!rproc_pdev) {
+		dev_err(rdev, "failed to find remoteproc platform device\n");
+		return -ENODEV;
+	}
+
+	domain = iommu_get_domain_for_dev(&rproc_pdev->dev);
+	if (!domain) {
+		put_device(&rproc_pdev->dev);
+		dev_err(rdev, "no IOMMU domain for remoteproc\n");
+		return -ENODEV;
+	}
+
+	ret = iommu_map(domain, addr, addr, size, IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+	if (ret)
+		dev_err(rdev, "failed to map remote heap phys=0x%llx size=0x%llx err=%d\n",
+			(u64)addr, size, ret);
+
+	put_device(&rproc_pdev->dev);
+	return ret;
+}
+
+static void fastrpc_remote_heap_unmap(struct rpmsg_device *rpdev,
+				      phys_addr_t addr, u64 size)
+{
+	struct device_node *rproc_node;
+	struct platform_device *rproc_pdev;
+	struct iommu_domain *domain;
+	size_t unmapped;
+
+	rproc_node = fastrpc_get_rproc_node(rpdev->dev.of_node);
+	if (!rproc_node) {
+		dev_warn(&rpdev->dev, "failed to find remoteproc node for heap unmap\n");
+		return;
+	}
+
+	rproc_pdev = of_find_device_by_node(rproc_node);
+	of_node_put(rproc_node);
+	if (!rproc_pdev) {
+		dev_warn(&rpdev->dev, "failed to find remoteproc platform device for heap unmap\n");
+		return;
+	}
+
+	domain = iommu_get_domain_for_dev(&rproc_pdev->dev);
+	if (!domain) {
+		dev_warn(&rpdev->dev, "no IOMMU domain for remoteproc during heap unmap\n");
+		put_device(&rproc_pdev->dev);
+		return;
+	}
+
+	unmapped = iommu_unmap(domain, addr, size);
+	if (unmapped != size)
+		dev_warn(&rpdev->dev, "partial/failed heap unmap: requested=0x%llx unmapped=0x%zx\n",
+			 size, unmapped);
+
+	put_device(&rproc_pdev->dev);
+}
+
 static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 				     struct device *rdev, u32 domain_id)
 {
+	struct device_node *rproc_node;
 	struct resource res;
 	u64 src_perms;
 	int err;
@@ -2536,6 +2620,19 @@ static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
 	if (domain_id == ADSP_DOMAIN_ID) {
 		cctx->remote_heap_addr = res.start;
 		cctx->remote_heap_size = resource_size(&res);
+
+		rproc_node = fastrpc_get_rproc_node(rdev->of_node);
+		if (rproc_node)
+			cctx->use_iommu_map = of_property_present(rproc_node, "iommus");
+
+		if (cctx->use_iommu_map) {
+			err = fastrpc_remote_heap_map(rdev, rproc_node, res.start,
+						      resource_size(&res));
+			of_node_put(rproc_node);
+			return err;
+		}
+
+		of_node_put(rproc_node);
 	}
 
 	if (!cctx->vmcount)
@@ -2611,7 +2708,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		data->unsigned_support = false;
 		err = fastrpc_device_register(rdev, data, secure_dsp, domain);
 		if (err)
-			goto err_free_data;
+			goto err_unmap_heap;
 		break;
 	case CDSP_DOMAIN_ID:
 	case GDSP_DOMAIN_ID:
@@ -2619,7 +2716,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		/* Create both device nodes so that we can allow both Signed and Unsigned PD */
 		err = fastrpc_device_register(rdev, data, true, domain);
 		if (err)
-			goto err_free_data;
+			goto err_unmap_heap;
 
 		err = fastrpc_device_register(rdev, data, false, domain);
 		if (err)
@@ -2627,7 +2724,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		break;
 	default:
 		err = -EINVAL;
-		goto err_free_data;
+		goto err_unmap_heap;
 	}
 
 	kref_init(&data->refcount);
@@ -2655,6 +2752,11 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (data->secure_fdevice)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
+err_unmap_heap:
+	if (data->use_iommu_map && data->remote_heap_size)
+		fastrpc_remote_heap_unmap(rpdev, data->remote_heap_addr,
+					  data->remote_heap_size);
+
 err_free_data:
 	kfree(data);
 	return err;
@@ -2695,24 +2797,29 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap_size && cctx->vmcount) {
-		u64 src_perms = 0;
-		int err, i;
-		struct qcom_scm_vmperm dst_perms;
-
-		for (i = 0; i < cctx->vmcount; i++)
-			src_perms |= BIT(cctx->vmperms[i].vmid);
-
-		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
-		dst_perms.perm = QCOM_SCM_PERM_RWX;
-
-		err = qcom_scm_assign_mem(cctx->remote_heap_addr,
-					  cctx->remote_heap_size, &src_perms,
-					  &dst_perms, 1);
-		if (err)
-			dev_err(&rpdev->dev,
-				"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
-				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
+	if (cctx->remote_heap_size) {
+		if (cctx->use_iommu_map) {
+			fastrpc_remote_heap_unmap(rpdev, cctx->remote_heap_addr,
+						  cctx->remote_heap_size);
+		} else if (cctx->vmcount) {
+			u64 src_perms = 0;
+			int err, i;
+			struct qcom_scm_vmperm dst_perms;
+
+			for (i = 0; i < cctx->vmcount; i++)
+				src_perms |= BIT(cctx->vmperms[i].vmid);
+
+			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+			dst_perms.perm = QCOM_SCM_PERM_RWX;
+
+			err = qcom_scm_assign_mem(cctx->remote_heap_addr,
+						  cctx->remote_heap_size, &src_perms,
+						  &dst_perms, 1);
+			if (err)
+				dev_err(&rpdev->dev,
+					"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
+					&cctx->remote_heap_addr, cctx->remote_heap_size, err);
+		}
 	}
 
 	of_platform_depopulate(&rpdev->dev);

---
base-commit: ef071c4906eb45d16b60f09154cf0bc6ec8f5435
change-id: 20260930-fastrpc-kvm-iommu-v2-1a7d343ed802

Best regards,
--  
Anandu Krishnan E <anandu.e@oss.qualcomm.com>

