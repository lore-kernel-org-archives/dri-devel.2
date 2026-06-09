Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8C1CD8C9D
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 03:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 054B110E05E;
	Tue,  9 Jun 2026 03:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYTtSGuO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CvGkYRTK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA0E10E05E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 03:00:03 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6590s1L9656528
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 03:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CcVm4LVbeat
 o9ydc4x9yKkM2AgVmwI4Qp9HLKCz00oo=; b=kYTtSGuOf387a+MlDoOvtQwDhNa
 bgo7bM/w7cKEw+5Ta+P5ybyKxHiAlYeGZwxLtsqjfUTp8izU2B+EwGh52gad0chK
 Gx8ewTIrMJWCAaw3+Lx9O4A8L/SGG9dIVoh4DQ9RBZ+d0LE/vZeQdzPrJnTfnOgB
 YTbAp710EqOX/YJmvKzP3QPTyBrOuu1z16OsHJSrEl1kRpo213kA0Vsu+gD7TJxg
 oyB9/8pXF9ktDvjQEPx0KDygmysKieKMqrHqbtSubJz3Jpt4u4/wTKMe35Qw3tOD
 J7zEOVQySVb8A/Xm9Yq/ZKxtfTeLAsj7ukX+ok8kXs+z37sWvhFgaM+Hqfw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun442w6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 03:00:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36d985df4cfso5793587a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 20:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780974002; x=1781578802;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CcVm4LVbeato9ydc4x9yKkM2AgVmwI4Qp9HLKCz00oo=;
 b=CvGkYRTKksmPZE34wdb53rgrSRIID525ufoGRkV8OacnAt6R1KfTpRfu3NuAhVp8KD
 LumLssu4TJ1R685+6unAjEmqXthN+5fV7wo7RygagjWlDkMuKNgDv4qyhN5Ktv+QMW2U
 qbmirDoKCq8KWQKJ0iIF/qTinizdLTRvWU56uFZ8PQoqrhwMcJ+M3uAaH+lT3tscGE/T
 sWF7kjL6oFRz8mrconEwLTGXQEtIj0RfG5WPPLW29bB7z3QQuOoTBQJWriCfk6pgiJMe
 jOq0D8v6gNhs1WmiTMfAbuPSY99/ZJyvCGFMYzwY/05udqJaorKMq7hqeSr5kH+3ynpT
 0CNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780974002; x=1781578802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CcVm4LVbeato9ydc4x9yKkM2AgVmwI4Qp9HLKCz00oo=;
 b=X12JtfcuGL9lcbmffUVlMyB9qCwktfWnWYhGOMRrsOQg1XX4U7ji/M66XW+n1Cqu+Q
 MinfX92LK6BEYF1xjcgTXEnU99XfP+1lwOZIhJlqTU2ONzcD7klAzso403FGt/vNJ5uX
 zXEHLpX9fmfiWmUgYp8LXJhYKf2b8yXNrll1MYAiAHE+03bBFxR2v5CFjJgu8qGvurSM
 tilErZT0PCcD5YTm4CSnOZrQfg3c4f8o2bzWO1oU+mBgkVauIMYKOV9cWBsdlbfhWu3b
 AvizhtIaq2cUZgU04SX7vaUZ+HaC2IoBNVDF+f5CPUbyx9GQpG9f/N8kmVwEh+1nN05r
 JJ0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aAAAB287UxACvg+C5ABdw1oYV9lQLtwnXvSxRfpfE2CfzWe1OlmI+HlANXmTOSTDDQHelx6t0Jfo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyELaNDwNjrt5LLcYmMcdu0PaKpNZYtbdqndo9byiyy3eElEfMT
 Y1GKKeZ3MQx5V9gtK3pFQpU15w4Auzy72sNEPp3Z1D6rjW0PlS/ZSOm6PUSt1+WoqnRmuuL1PkK
 clefqpduMa20BCjitXTzgbhtKCQdBEeu+fAbZruGdriivokfNm4RaouP/4d5DnQQvDIBdq/s=
X-Gm-Gg: Acq92OHUZdgdGQMxVTwaCs2ZPU5OEJwoL9zA9sWpdGaBU8jfW+NGUdhmcidHERmOQhz
 YAQBPTcnLfw8/idceis3l9FqVPxNwn77gqfl2Y90/Qb8fC+amEbCIbu3yV68klncKri7A8T8V7P
 lYsBfc6tAMLG7WEL85OG7cWEJlEXxESic7SfLAPbeseB9T4APmVMYRGxoAcw6SPQ174CedeE6rb
 M4Ha+KQVI5udFNz/8MvEw1Jj/J2x8T+9WcMnQj7+q4yGUQNxLXJeWNEvPIUvOoa7l2l8p/hZE4r
 tuKhalLNp/xyCBM37Sb+bHBbZLDTaql5Zo1FX8g1p9FwCbOKX9d9tAf1OFDBj3cagM+SbyrDaKq
 HAo3JnSMcY6c4enY6ZQQyvi4p+/yudjrGqFXcbkKmi2g7y8ByNAUTenZdIS9J6IkxYREYvhBI7L
 YIX0Feffq3IeGdvFDlPIKuSAq7wkcM
X-Received: by 2002:a17:90a:d606:b0:36b:5b82:4834 with SMTP id
 98e67ed59e1d1-370ee547414mr18903626a91.7.1780974002428; 
 Mon, 08 Jun 2026 20:00:02 -0700 (PDT)
X-Received: by 2002:a17:90a:d606:b0:36b:5b82:4834 with SMTP id
 98e67ed59e1d1-370ee547414mr18903604a91.7.1780974001960; 
 Mon, 08 Jun 2026 20:00:01 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3712fcb2607sm8713835a91.0.2026.06.08.19.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 20:00:01 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, ekansh.gupta@oss.qualcomm.com,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v8 3/4] misc: fastrpc: Allocate entire reserved memory for
 Audio PD in probe
Date: Tue,  9 Jun 2026 10:59:37 +0800
Message-Id: <20260609025938.457-4-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
References: <20260609025938.457-1-jianping.li@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyNSBTYWx0ZWRfX34YfqnyrZM/9
 8rNTEeiCm4Tcxj02wTWSfGCyiepQAWhU8az//QF14BGBa507X4KIARZgQtwtZLB/25MuULrDjYc
 VbHPMLp5Y6XItXyY7zlyy8JIRZhQkkJgAyMGxnuH4yuCcQ14jbhWt6h6ZkQZsVs+bT4Ke0cBSRj
 3Cfk+QrhSsHekm9HORAAJxhk5rgdlMPlHagdmYujUzdz3dMIRfYFTrWKlsD940oitdD0rZNJAjr
 wHhXYAUxQ9QcvV5g0skGaTQKJ23gKPbwAop1C562UMuRwcVh7CuICL6FEsx2GTxkFbXu3eb4Tt7
 qNKdka9C0ymYI8/ga0JoRfSzpK0SOQ5GrFPDc7tz6WUf8xWhQoYIaRjPryTY4Pyy739RGMSOC47
 TVt/0VTA5QcvtvJy8hmQp9TXuXcpGZ+EMQEq1dRMrU3+vVSbGwCXyemG091wUTwdKniqnJBodwm
 jD9vLQW3rTfISRQVq1w==
X-Proofpoint-ORIG-GUID: G-vMi6FwmbyBxqb3EF1NEllImNyN3keG
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a2781b3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c8cBMUidy7NAwe8AhH0A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: G-vMi6FwmbyBxqb3EF1NEllImNyN3keG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090025
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

Add explicit validation for remote_heap presence and size before sending
the memory to DSP, and fail early if the reserved-memory region is
missing or incomplete.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 112 ++++++++++++++++++++++-------------------
 1 file changed, 59 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 517884000331..1942e74535e5 100644
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
@@ -1341,15 +1343,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
+
+	if (!cctx->remote_heap || !cctx->remote_heap->dma_addr ||
+	    !cctx->remote_heap->size) {
+		err = -ENOMEM;
+		dev_err(fl->sctx->dev,
+			"remote heap memory region is not added\n");
+		return err;
+	}
 
 	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
 	if (!args)
@@ -1373,31 +1384,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1409,8 +1395,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->dma_addr;
-	pages[0].size = fl->cctx->remote_heap->size;
+	spin_lock_irqsave(&cctx->lock, flags);
+	if (!cctx->audio_init_mem) {
+		pages[0].addr = cctx->remote_heap->dma_addr;
+		pages[0].size = cctx->remote_heap->size;
+		cctx->audio_init_mem = true;
+		inbuf.pageslen = 1;
+	} else {
+		pages[0].addr = 0;
+		pages[0].size = 0;
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1428,27 +1423,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
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
+	cctx->audio_init_mem = false;
 	kfree(name);
 err:
 	kfree(args);
@@ -2415,12 +2390,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
+				if (!data->remote_heap) {
+					err = -ENOMEM;
+					goto err_free_data;
+				}
+
+				data->remote_heap->dma_addr = res.start;
+				data->remote_heap->size = resource_size(&res);
+			}
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
@@ -2428,7 +2414,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			if (err)
 				goto err_free_data;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2487,6 +2472,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
 err_free_data:
+	kfree(data->remote_heap);
 	kfree(data);
 	return err;
 }
@@ -2509,6 +2495,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2526,8 +2513,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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
+		if (err)
+			dev_err(&rpdev->dev,
+				"Failed to assign memory back to HLOS: dma_addr %pad size %#llx err %d\n",
+				&cctx->remote_heap->dma_addr, cctx->remote_heap->size, err);
+	}
+
+	kfree(cctx->remote_heap);
+	cctx->remote_heap = NULL;
 
 	of_platform_depopulate(&rpdev->dev);
 
-- 
2.43.0

