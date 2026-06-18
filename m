Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F02ACD98F5
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 09:51:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 690E110ED2F;
	Thu, 18 Jun 2026 09:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QuDHZAuY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJUJScXT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FC310ED2F
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 09:51:30 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65I8DrBu2246914
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 09:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=b8NCvzGF3XF3GM7U4sZSXs
 LifZwFKnI0trHh5fGvjOA=; b=QuDHZAuYZfY34qaFOCpR6diZwQpkdNZI34S/bc
 SDswjGC8iM4fp/1ZeIoFEapwfjsij/v7jAIPKq9mtDLP2Vzw5UYmOps5OUHxhzuu
 jCJk+D86GCMRWiLgUWKP+EvJ6QDFbR3qUG9h/Wc4v5x+p0ZGnUXQbynng9SHOEye
 PvZUsWkUEbg/h6SH34PqNsmSBJIlnaTBdUsFL7wCdCDyMZR6pO7dQlWWjgm5a2ij
 WRH7y/YuFB8cJ3vv4NDavTC6qMXRKhVh6IjgmGyVK/35BiXirHQjbpJzv7PnXMYT
 XKcXeXLM29XWCqKeifLzj2Q1hQ3/yqvFP0jbEz/cjCj84Nxw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euw9vmb0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 09:51:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c6bbd0afffso18090195ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 02:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781776290; x=1782381090;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b8NCvzGF3XF3GM7U4sZSXsLifZwFKnI0trHh5fGvjOA=;
 b=UJUJScXTgO0irnRUxVykT8A+ZqwsTH7+Fk7Q9h8Yu5vNUc47UYrUsvNU8Xc9SNA8Q0
 65fxGDjPIJIrrBqRF0PjYROhEpWFqOoXf4VYOVKmfYXq5vYq7Tr84GLPCwIdAQMrWNHv
 8+GhPEBy9Pkuq2JUR0EAmpQphEgoREvoZxk7/e5eJ52EzvX3YtCdZoM9uYwQXtnxKmLN
 nNVj/q5utOJr7Zbe4A8PN6/IOwyZ8fHNDQPAWDmls23rRx8xDCiF9detq9FMlY8nxFFd
 25Gu/F6LwmdmOazdodS9LvEVSseBAL9Fw/nyQIhnMUo3qWQJIc9BBsc+3T2CAPsblL5n
 v3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781776290; x=1782381090;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8NCvzGF3XF3GM7U4sZSXsLifZwFKnI0trHh5fGvjOA=;
 b=X4KLFXfChr9/is3VvUOWjWcefRcOYYN5SSC9PJB00SXaL3oN3sUj1euPfTVFUOsngp
 HioXAIj2epJF8Md1kHFe9ues4vHLspvKbUBadDXtzNk8jVHfBnxawHJVyC9kh+E5LhKA
 KKWHFvTma/uSQ1gAE4XQAc3+8sICy6QNuOi5xpIaMpMaP/vpF1SYZUV+2L8EzyXCpw9G
 uQXMsALlKVprFT6anA7JzePOVheHLxrkTbvd2Wq1KWx65Xj4Cffk/SbMSstyI+adJPVt
 5xfhhnd870m3hrVEV0C6M+mTvx1qvLf4UzHhPsiMDQ6JlFBY9TjpyC6nO340gx2nOiCW
 1QeQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+FE3KDQqSRH+AWmqKQy1AOItE4rf8ISputWkxxddT6jMvbxYPWWUaudrSWp5z2d851eBmEGkuVOTI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0qnaUULEFo1KgTEmURR9nEH51sjE0hWDBamtUciEEtCN7wLHs
 Kgmy3ag3UYLrcREPFHw/75JhHbJgLapUqg4U4fxe4ZDUh4Z75fqhofjtSEJJbXL1TqeyreRnGtg
 nz6fHskvF3gBaig5gRW+jcc9Mq3/vRmZQfHtpYhVgEhrXT2B3QjPEh4X8F2KFNCs2BTMrTfE=
X-Gm-Gg: AfdE7clQchzUHg7rcrMP8Zf1OK4c2LXdneUsve6uCj0w+dIaGHshl69Xd42u4pG32Y1
 iTDrz6p0DeVxCBl5DjYaKTxyvhOOUJ1vMR4/TtxZ7dc4/GNZrSOW7k6yxMZ7rXL37DplD3xlhSa
 alTpW08FkI14IaBk4/h17AwNeO0rnjfV13QfTEFR3Yc5h3vC+TdCrakiscp4doGtE2aQoDiUkhI
 0jMVST+nDNCwVfJcTL9jnCFtduxBibaeO6rvatdNncMRbM2/9bg7F+x4jLph7x5LSZEIyXMj2uj
 kKaNrVUFOLcP5MEq/rEX5eAtRh9NDpiznbKE60tqaoj36jNypGFBLPduhqEwQtGnPdLSqph/4VC
 DC7JdSDZuDkWWDnO1h8FP
X-Received: by 2002:a17:902:d4c6:b0:2c6:a97e:1c24 with SMTP id
 d9443c01a7336-2c6bbf8dc65mr77371425ad.7.1781776289658; 
 Thu, 18 Jun 2026 02:51:29 -0700 (PDT)
X-Received: by 2002:a17:902:d4c6:b0:2c6:a97e:1c24 with SMTP id
 d9443c01a7336-2c6bbf8dc65mr77371145ad.7.1781776289219; 
 Thu, 18 Jun 2026 02:51:29 -0700 (PDT)
Received: from [10.213.99.236] ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c433078264sm190231805ad.65.2026.06.18.02.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 02:51:28 -0700 (PDT)
From: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:21:21 +0530
Subject: [PATCH] misc: fastrpc: map ADSP remote heap into remoteproc IOMMU
 domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-audio_fix_clean_v3-v1-1-ec1ee66fe455@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJi/M2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ML3cTSlMz8+LTMivjknNTEvPgyY13LlDQzA3NTEzMDS1MloMaColS
 gPNjQ6FgIv7g0KSs1uQRkklJtLQByNSbwdgAAAA==
X-Change-ID: 20260618-audio_fix_clean_v3-9df607546095
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_bkumar@quicinc.com, quic_chennak@quicinc.com,
 Anandu Krishnan E <anandu.e@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: XAgPoBx8tlyNQGjhIGkwmEL8L-wuArmK
X-Proofpoint-GUID: XAgPoBx8tlyNQGjhIGkwmEL8L-wuArmK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA5MSBTYWx0ZWRfX1KlxGqptDE+x
 HFzZvHI8uemNxnEWbI0zQAEytfsI0lvfBiNrZRUVpyIn0BzP6Qhj7KXoWC3HrSoSfua3S7MvIvm
 lsCv+mGjm3DRFAxiLX5sOn8SEdJ9ug07G89IaqI6HEiiZq+k9F7k2LkGKowb+Cf0fMv6mD6StLb
 4oEd6+J/DqjjCqs+qA0im5yMq3+yO+V819OFOZ/ZuIZkVv/a3BV6QBQBnQuG4XxIn9JzK56THGd
 RzRl3FchsY2sbdFPmP4WjeguYIFVDeU6SiUrpmECbRJ+otbBTjmlhUGnrNC94L1bSVWg/egCGL5
 YryE+EhJt5w+U79H2EU2lXEbeBJkvIuXzEin8RWh3wg0x1Ov8P0V97AWbzHwZZuykceksAodaIc
 nd5K26wmoGuGL9rWzWSS4/b7SZME+9IZ+v1Ifz6E1FeSsg3q8BxZLZ4ZtTndiwA2cV7I0uCqZUA
 wGyNNF5UhzNok/ZhcIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA5MSBTYWx0ZWRfX5fYIUrjAGjcN
 a5gVpHJWSJozpFp1Da/zAqJP9N0v09tOqNmvteMzPSl0yEFmRWyYc8yK4Nm1I1TXeOKEtQA98Ko
 4U+IN25qA51GHVNO1ATc2X6yoG5yybg=
X-Authority-Analysis: v=2.4 cv=YJKvDxGx c=1 sm=1 tr=0 ts=6a33bfa2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=LsPkHLYD-RLW9ZWWSBUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180091
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
a new has_iommu flag in fastrpc_channel_ctx.  When the flag is set,
map the carveout into the remoteproc's IOMMU domain instead of
calling qcom_scm_assign_mem().  Introduce fastrpc_remote_heap_map()
and fastrpc_remote_heap_unmap() helpers to encapsulate the IOMMU
domain lookup and map/unmap operations.

This change relies on the remote heap handling introduced in:
https://lore.kernel.org/r/20260609025938.457-1-jianping.li@oss.qualcomm.com

Link: https://lore.kernel.org/r/20260609025938.457-1-jianping.li@oss.qualcomm.com
Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
---
This patch depends on:

  [PATCH v8 0/4] misc: fastrpc: Add missing bug fixes
  https://lore.kernel.org/r/20260609025938.457-1-jianping.li@oss.qualcomm.com

Please apply after that series.
---
 drivers/misc/fastrpc.c | 141 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 114 insertions(+), 27 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a5af901c1cb8..9ce7af2091f1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -21,6 +21,7 @@
 #include <linux/slab.h>
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
+#include <linux/iommu.h>
 #include <linux/of_reserved_mem.h>
 #include <linux/bits.h>
 
@@ -285,6 +286,8 @@ struct fastrpc_channel_ctx {
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
+	/* set when remoteproc has an IOMMU; use iommu_map instead of hyp_assign */
+	bool has_iommu;
 	u64 dma_mask;
 	const struct fastrpc_soc_data *soc_data;
 };
@@ -2343,10 +2346,65 @@ static const struct fastrpc_soc_data default_soc_data = {
 	.dma_addr_bits_default = 32,
 };
 
+static int fastrpc_remote_heap_map(struct device *rdev,
+				   struct device_node *rproc_node,
+				   struct fastrpc_buf *heap)
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
+	ret = iommu_map(domain, heap->dma_addr, heap->dma_addr, heap->size,
+			IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
+	if (ret)
+		dev_err(rdev, "failed to map remote heap phys=0x%llx size=0x%llx err=%d\n",
+			heap->dma_addr, heap->size, ret);
+
+	put_device(&rproc_pdev->dev);
+	return ret;
+}
+
+static void fastrpc_remote_heap_unmap(struct rpmsg_device *rpdev,
+				      struct fastrpc_buf *heap)
+{
+	struct device_node *rproc_node;
+	struct platform_device *rproc_pdev;
+	struct iommu_domain *domain;
+
+	rproc_node = of_get_parent(of_get_parent(rpdev->dev.of_node));
+	if (!rproc_node)
+		return;
+
+	rproc_pdev = of_find_device_by_node(rproc_node);
+	of_node_put(rproc_node);
+	if (!rproc_pdev)
+		return;
+
+	domain = iommu_get_domain_for_dev(&rproc_pdev->dev);
+	if (domain)
+		iommu_unmap(domain, heap->dma_addr, heap->size);
+
+	put_device(&rproc_pdev->dev);
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
 	struct fastrpc_channel_ctx *data;
+	struct device_node *rproc_node;
 	int i, err, domain_id = -1, vmcount;
 	const char *domain;
 	bool secure_dsp;
@@ -2390,9 +2448,12 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
+	rproc_node = of_get_parent(of_get_parent(rdev->of_node));
+	if (rproc_node)
+		data->has_iommu = of_property_present(rproc_node, "iommus");
+
 	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
 		struct resource res;
-		u64 src_perms;
 
 		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
 		if (!err) {
@@ -2401,21 +2462,41 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
 				if (!data->remote_heap) {
 					err = -ENOMEM;
-					goto err_free_data;
+					goto err_put_node;
 				}
 
 				data->remote_heap->dma_addr = res.start;
 				data->remote_heap->size = resource_size(&res);
+
+				if (data->has_iommu) {
+					err = fastrpc_remote_heap_map(rdev,
+								      rproc_node,
+								      data->remote_heap);
+					if (err) {
+						kfree(data->remote_heap);
+						data->remote_heap = NULL;
+						goto err_put_node;
+					}
+				}
 			}
-			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
-			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
-				    data->vmperms, data->vmcount);
-			if (err)
-				goto err_free_data;
+			if (!data->has_iommu) {
+				u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
+
+				err = qcom_scm_assign_mem(res.start,
+							  resource_size(&res),
+							  &src_perms,
+							  data->vmperms,
+							  data->vmcount);
+				if (err)
+					goto err_put_node;
+			}
 		}
 	}
 
+	of_node_put(rproc_node);
+	rproc_node = NULL;
+
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
 	data->soc_data = soc_data;
@@ -2471,6 +2552,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (data->secure_fdevice)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
+err_put_node:
+	of_node_put(rproc_node);
+
 err_free_data:
 	kfree(data->remote_heap);
 	kfree(data);
@@ -2513,28 +2597,31 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap && cctx->vmcount) {
-		u64 src_perms = 0;
-		struct qcom_scm_vmperm dst_perms;
-
-		for (u32 i = 0; i < cctx->vmcount; i++)
-			src_perms |= BIT(cctx->vmperms[i].vmid);
-
-		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
-		dst_perms.perm = QCOM_SCM_PERM_RWX;
-
-		err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
-					  cctx->remote_heap->size, &src_perms,
-					  &dst_perms, 1);
-		if (err)
-			dev_err(&rpdev->dev,
-				"Failed to assign memory back to HLOS: dma_addr %pad size %#llx err %d\n",
-				&cctx->remote_heap->dma_addr, cctx->remote_heap->size, err);
+	if (cctx->remote_heap) {
+		if (cctx->has_iommu) {
+			fastrpc_remote_heap_unmap(rpdev, cctx->remote_heap);
+			kfree(cctx->remote_heap);
+			cctx->remote_heap = NULL;
+		} else if (cctx->vmcount) {
+			u64 src_perms = 0;
+			struct qcom_scm_vmperm dst_perms;
+
+			for (u32 i = 0; i < cctx->vmcount; i++)
+				src_perms |= BIT(cctx->vmperms[i].vmid);
+
+			dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+			dst_perms.perm = QCOM_SCM_PERM_RWX;
+
+			err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
+						  cctx->remote_heap->size,
+						  &src_perms, &dst_perms, 1);
+			if (!err) {
+				kfree(cctx->remote_heap);
+				cctx->remote_heap = NULL;
+			}
+		}
 	}
 
-	kfree(cctx->remote_heap);
-	cctx->remote_heap = NULL;
-
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);

---
base-commit: f1256704b88067430e255e5c85d6b727e1bbb2ea
change-id: 20260618-audio_fix_clean_v3-9df607546095

Best regards,
--  
Anandu Krishnan E <anandu.e@oss.qualcomm.com>

