Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9E3CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 07:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C50D10EC8E;
	Tue,  2 Jun 2026 07:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lZhhK0eW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YgOIdseD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8CD10EC8E
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 07:18:22 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6526L97p2884844
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 07:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HU4ZtcghD0M
 28On2VNhDRQP9LlC0xqJF34085t8tRAU=; b=lZhhK0eWBbNrvuuk9NZsrLbeJVC
 Fr2cHMY5Ev1KSDWse+dEPHqxxPOvyQo0NvHfUrNX0QfzkL3nvzxkhOwLyvgTF8VB
 ZJFBFKOIN9E/Kvg9WrkDKUJWaEADt4vnlhN0kI0ansOspTcJKSuz5BpUA3W+j9sF
 b+7BoRqAIRALrPocHNeE8LrMpN1AdvjTebCLOmavG+PQ0yO2Xks22cmtw4VrhMNT
 6X1ndFN6N9zo+s5t12scC8B0vd9/24zKB0Sgea5eorKhnoXEHVk5gVW8P4M0Cjcq
 dZ+pgVK8A8fSFP4MGXs1KFgwlDZJkIs33KRVucojqkzO5BIMf0fb4sUNxmg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsu1075e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 07:18:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36bd4146cb2so4050212a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 00:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780384700; x=1780989500;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HU4ZtcghD0M28On2VNhDRQP9LlC0xqJF34085t8tRAU=;
 b=YgOIdseDiFzCMdo1IFKxxsMnRABPAlUf5yCtnyD/bXgJD37K3p/yHjt875nPY5YTah
 aw9ziODPTWNYzqBubzfiMfhDmQhV9ckMWjIxSn43yp0dA8ISxgEIc15Q6326d+BpP23X
 1zu//+BtuuMwhGk8kMZU5QzaZLLqMc9eCtdpAp8hLxqqE5jCuumUTPl5rUx2m5YotvNl
 EYMz5gBgx2Ubn+wC0jhZImd+wE9WS4i73V+NogcvgwccMPX3cdY0yVrm2PoBQh3G6RtH
 XUs4FRI/E6baNm2vVDRcPpCXUjVEPvksfMMMdGoZGF8dNtkAShGAZJWHdAHKH5qD25gc
 QT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780384700; x=1780989500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HU4ZtcghD0M28On2VNhDRQP9LlC0xqJF34085t8tRAU=;
 b=EYeUpdhSh19sONsbUAZTsPcXrnnUz1KVNCXkp56WX8rP9nnB7vL4U1jrj5+NKSgO7R
 9HivTgqCT4EVrNNf0Mt7dyIOSootPLbs+A/dkg+CxX8FJVctXzDNhOh3er6i/ZjTEuIz
 qt4lH+E+n96/Ujiyo2Qij2oTFiAa2EVOgIe/XZspURf49CIamG7p5VKGTYQDNB2KjqD3
 YJqqDeQZEpMyxNQGo2cd15+qvYMEc/LMO4K4N+7g+KtAQ/JhMESD7PEoMUvquRu7Q9Qo
 g8awGkoUoN++9hx/kJj1t7jH1DO+ueZzkWnwCgtLUZP+VqL9Eah8ZmLwt/5MZyWm8h3a
 KY2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NIp9KO8LXaWjKeXnXj4yaRZhus8Baa8J3Pt51fi9wO5odG+xKgToRalG7tbd3img3gHoVFIJ4IwE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHK9F0VfokjO7rGHrupY6p2K7wE+Odv7sCNr1VljWyFMk6IgLr
 NNSyig+3Nu7to8WWORvmvgcNYdvwn5z24AEDqANPZVYFX7q/z3bdK/qd1I5hEhtYfiBvBafL9hT
 W48EfGhEGHaFq/faGMsd0YNGxHsQZfuD5fjPlbP04s/kQenLkyk3hvKCBQPthrxoM10VvXjE=
X-Gm-Gg: Acq92OHUAFxax+0FIR+IJe3yM9foqHb4PocwCsqeKB1uFaoMesAOFZmMTPpIh+e8+ZQ
 MdJYJ2riA7zqQhtLcc+YLi76R4yiG7NK0WLRVFq4nteryEn15afKZUDDWN9JQcamH2ZHmCxibrJ
 xsDZY0ignyiW7acN14agklB1Q4z2CBChkY8q2pApj9nVb070+h9liE/C7mvUw0ftNzpJGDmncEu
 F5j7Jy3+jpmKcsXGbASVh79akcimpYJI4rxGk8uQZij7MV7B17yhoRckx6sDMppw8IP93Uf+dwr
 4/qv+HEUpzbstxn2z1AokbeTNCygxhrKwT1sg2O5CPUCgrbyLa74OjZGGi82sAgt2brF6Zz823k
 o0rZxtBVBtscMEXMtIItNeGwR8FbdYXq+EJWVyaPfUmT0miX8phDZ4AJVsEe7Oe4Y5a5tsAPSbu
 E3LMZHe3t407hYeiHCSlXll8KrZ70myg==
X-Received: by 2002:a17:90b:520a:b0:36b:a162:a1be with SMTP id
 98e67ed59e1d1-36dd91f0f42mr2277832a91.4.1780384700329; 
 Tue, 02 Jun 2026 00:18:20 -0700 (PDT)
X-Received: by 2002:a17:90b:520a:b0:36b:a162:a1be with SMTP id
 98e67ed59e1d1-36dd91f0f42mr2277800a91.4.1780384699782; 
 Tue, 02 Jun 2026 00:18:19 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36dd91c9991sm1766279a91.7.2026.06.02.00.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:18:19 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: srini@kernel.org, amahesh@qti.qualcomm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, abelvesa@kernel.org,
 jorge.ramirez@oss.qualcomm.com
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ekansh.gupta@oss.qualcomm.com, quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v7 4/5] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
Date: Tue,  2 Jun 2026 15:17:49 +0800
Message-Id: <20260602071750.526-5-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
References: <20260602071750.526-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7N0pESPFGYZUmjfhPMN_23eeZL5DV9gO
X-Proofpoint-GUID: 7N0pESPFGYZUmjfhPMN_23eeZL5DV9gO
X-Authority-Analysis: v=2.4 cv=MKFQXsZl c=1 sm=1 tr=0 ts=6a1e83bd cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vXPY0jRleWu_0xqwLycA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA2NiBTYWx0ZWRfX8aQHSax47Ttp
 mfRZVJe6T4YKdZLXVmX1D5abDiEOqdrr2ug22wHFY39LVONymhgToun9yGXDyW9XB+PhVrCrtoQ
 CEubHrRF62SjqliOlLk9aROIt6tVSjVUzFDv+Ndh0J8YmDSn0O3w1ozX4Ikkeo8sr5vk98J5jOs
 J1gsLzWZyLg+PTo8qWvIPNRfmKPkqBe+1oPvD29vsjdkJQ/EUnA/N3FpW2IQJdwpOjTarFHsX61
 6p7yz1T1/bw/vfUEpzJdt1VizBOdJWrm8G5Ke587SzYEH+BqH+muG9zlyBGOEDZqKWDoofXJFp8
 0dkpTxWbrpDgTrsc73i4a8TWs7H0OHoXPazgzAQwYlCKPImQwUeMWiLUU/iU3CpodMlTjRniyAM
 t5j9E2jZJ2NtO4WsqhUKkY+q9aoPrzNUvdO0wTYVxnDfjShGtW7aacCymHSNGkxXhjgN3bxr348
 i5aWldd4vJ95F77uAaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606020066
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

Allocating and freeing Audio PD memory from userspace is unsafe because
the kernel cannot reliably determine when the DSP has finished using the
memory. Userspace may free buffers while they are still in use by the DSP,
and remote free requests cannot be safely trusted.

Additionally, the current implementation allows userspace to repeatedly
grow the Audio PD heap, but does not support shrinking it. This can lead
to unbounded memory usage over time, effectively causing a memory leak.

Fix this by allocating the entire Audio PD reserved-memory region during
rpmsg probe and tying its lifetime to the rpmsg channel. This removes
userspace-controlled alloc/free and ensures that memory is reclaimed only
when the DSP process is torn down.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 96 +++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index f46a8f53970d..33be8bed6a0b 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -276,6 +276,8 @@ struct fastrpc_channel_ctx {
 	struct kref refcount;
 	/* Flag if dsp attributes are cached */
 	bool valid_attributes;
+	/* Flag if audio PD init mem was allocated */
+	bool audio_init_mem;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
@@ -1344,15 +1346,16 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	struct fastrpc_init_create_static init;
 	struct fastrpc_invoke_args *args;
 	struct fastrpc_phy_page pages[1];
+	struct fastrpc_channel_ctx *cctx = fl->cctx;
 	char *name;
 	int err;
-	bool scm_done = false;
 	struct {
 		int client_id;
 		u32 namelen;
 		u32 pageslen;
 	} inbuf;
 	u32 sc;
+	unsigned long flags;
 
 	if (!fl->cctx->remote_heap ||
 	    !fl->cctx->remote_heap->dma_addr ||
@@ -1383,31 +1386,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	inbuf.client_id = fl->client_id;
 	inbuf.namelen = init.namelen;
 	inbuf.pageslen = 0;
-	if (!fl->cctx->remote_heap) {
-		err = fastrpc_remote_heap_alloc(fl, fl->sctx->dev, init.memlen,
-						&fl->cctx->remote_heap);
-		if (err)
-			goto err_name;
-
-		/* Map if we have any heap VMIDs associated with this ADSP Static Process. */
-		if (fl->cctx->vmcount) {
-			u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
-
-			err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
-							(u64)fl->cctx->remote_heap->size,
-							&src_perms,
-							fl->cctx->vmperms, fl->cctx->vmcount);
-			if (err) {
-				dev_err(fl->sctx->dev,
-					"Failed to assign memory with dma_addr %pad size 0x%llx err %d\n",
-					&fl->cctx->remote_heap->dma_addr,
-					fl->cctx->remote_heap->size, err);
-				goto err_map;
-			}
-			scm_done = true;
-			inbuf.pageslen = 1;
-		}
-	}
 
 	fl->pd = USER_PD;
 
@@ -1419,8 +1397,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->dma_addr;
-	pages[0].size = fl->cctx->remote_heap->size;
+	spin_lock_irqsave(&cctx->lock, flags);
+	if (!fl->cctx->audio_init_mem) {
+		pages[0].addr = fl->cctx->remote_heap->dma_addr;
+		pages[0].size = fl->cctx->remote_heap->size;
+		fl->cctx->audio_init_mem = true;
+		inbuf.pageslen = 1;
+	} else {
+		pages[0].addr = 0;
+		pages[0].size = 0;
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1438,27 +1425,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
 	return 0;
 err_invoke:
-	if (fl->cctx->vmcount && scm_done) {
-		u64 src_perms = 0;
-		struct qcom_scm_vmperm dst_perms;
-		u32 i;
-
-		for (i = 0; i < fl->cctx->vmcount; i++)
-			src_perms |= BIT(fl->cctx->vmperms[i].vmid);
-
-		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
-		dst_perms.perm = QCOM_SCM_PERM_RWX;
-		err = qcom_scm_assign_mem(fl->cctx->remote_heap->dma_addr,
-						(u64)fl->cctx->remote_heap->size,
-						&src_perms, &dst_perms, 1);
-		if (err)
-			dev_err(fl->sctx->dev, "Failed to assign memory dma_addr %pad size 0x%llx err %d\n",
-				&fl->cctx->remote_heap->dma_addr, fl->cctx->remote_heap->size, err);
-	}
-err_map:
-	fastrpc_buf_free(fl->cctx->remote_heap);
-	fl->cctx->remote_heap = NULL;
-err_name:
+	fl->cctx->audio_init_mem = false;
 	kfree(name);
 err:
 	kfree(args);
@@ -2425,12 +2392,21 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
-	if (domain_id == SDSP_DOMAIN_ID) {
+	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
 		struct resource res;
 		u64 src_perms;
 
 		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
 		if (!err) {
+			if (domain_id == ADSP_DOMAIN_ID) {
+				data->remote_heap =
+					kzalloc_obj(*data->remote_heap, GFP_KERNEL);
+				if (!data->remote_heap)
+					return -ENOMEM;
+
+				data->remote_heap->dma_addr = res.start;
+				data->remote_heap->size = resource_size(&res);
+			}
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
@@ -2438,7 +2414,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			if (err)
 				goto err_free_data;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2519,6 +2494,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2536,8 +2512,22 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+	if (cctx->remote_heap && cctx->vmcount) {
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+
+		for (u32 i = 0; i < cctx->vmcount; i++)
+			src_perms |= BIT(cctx->vmperms[i].vmid);
+
+		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms.perm = QCOM_SCM_PERM_RWX;
+
+		err = qcom_scm_assign_mem(cctx->remote_heap->dma_addr,
+					  cctx->remote_heap->size, &src_perms,
+					  &dst_perms, 1);
+		if (!err)
+			kfree(cctx->remote_heap);
+	}
 
 	of_platform_depopulate(&rpdev->dev);
 
-- 
2.43.0

