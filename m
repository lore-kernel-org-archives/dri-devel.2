Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9353AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAFF310E43B;
	Tue,  7 Jul 2026 06:17:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OoIDc5xK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R54IUOw2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A0110E43B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 06:17:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667495K42526330
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Jul 2026 06:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=pl1sWeMBafq5dBYywth/L+4oTHWDQJ/jNNc
 0mkSxTac=; b=OoIDc5xKTfO2RCmuaSgRisk3U91iIdyLsZxShpQ5Ug8oFX7kfEj
 WOQKn7ZtEVwPNQY2HEQPn9jmxfuMll+VBffdeRhbe8mOiiY9s6Zdirbfe+N+HJeJ
 7CMwMCxXVWwxEHgJTXxWroIzrXhJZcNHmrcmOxyu2wsEzxcMHttiQeBwqhvKimt0
 2VZTurA7U0ETULhaQmsdBmFxoR2nWPPQ9yS82dFwV+GXJM30gvaqYNyvecIU1T6V
 KHGOYwLTyMOHu28WILMuG6J8HC3ybluos7vQV8uNqpJST5BmRC0UjTD9ZWgOpTAM
 OtRtBm8qcWidh8NYd6s706nrGdjmkRhCMXQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98mawj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 06:17:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8478d2bea7cso388658b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 23:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783405060; x=1784009860;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pl1sWeMBafq5dBYywth/L+4oTHWDQJ/jNNc0mkSxTac=;
 b=R54IUOw2mETFQpyYtNoUqJHz4Msb0PoaKOwkrLXinCgHJCLzifCTqvTq1zOujCbGHW
 wjX+5lJJixwE1qNaAl/qs1xwr+vKGfZtFS69aDotwforZEuWaCHV7/VdjciISH09rEhE
 Gh+H1QfCBngrrL6gVXIr+e948PTSj9OKOSHLG3HT+z2xHyEW0tKMAjrlFoW3zmQi0zMv
 wu/gjtOwiH4DycOE5hLe4j2o8fmH4OuKMmu4v32qhGyU4NP2eI2CUJh67Njo9DISZJDG
 KAXwqHPPN54VrzUojQ9D8B+v7AuEx9izJR2HAMW+IvAgSyRMM7+8h7fa5apqOth8COqr
 LO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783405060; x=1784009860;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pl1sWeMBafq5dBYywth/L+4oTHWDQJ/jNNc0mkSxTac=;
 b=IoNFwcCaLBJaA/jmfEv5TnAmHsCXSpwhYZx9omufy0cRmmN107OOKTnwphWjAbyrgp
 xOuI55SW/m5bWS3KqqQ15Q6lZ1EMYgEKreC9nWfFkWDmrRaDOZBNmjfiA/a1KhWs0Qmd
 C+N6WnA4+ck6uhSgy4a/JSIdysby9kLstEmHVJWQeqBqQ2MgcG/kS6n1iiBZgCxOcRQB
 7mGnf+SFQFPYn3feLxiwHwR9ahjLbERE7RL+hjH+4WrXy2E25lVKbgENqsjEzVw2YHFF
 DdUg1Y+8HWUaMf3WRxXVhqrqEfQuqzdOdv1B0Hj7/aKFVarHJMvHJ3qZlzoT7eQ69TP9
 EX0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpwcXfx1GiBD3Z/rQbAZwaheZ5Ad/6ecGT3S99De4YvHowDWtqyBZ/RNPswtAXy/t0ySWLc1gcuF54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdTgBnyp/W+MJWU9QYAuYk0HfJo3l6Cz1kWG2vzWnd0wnDCZGX
 Q3h4EUwNQTeGTUOURosTY6RxmFG5EvkH8JNm5Bzo+xbnptIdsc3ukvPxn1a3aKkUOO+FAKaJZIP
 n1yo9vogAzyEnFU8tD3E2hRnXfTJT/ai/QR2PpVWJcIcfhk6GCOuzoDSh0+xG5q9glTZboPLxGs
 iiawQ2fQ==
X-Gm-Gg: AfdE7cmWOlvCehEZ90tDG1fCPCMn8/kiJrmTZws2jOcXVyeWFpYul2D7nWjzWg6Hnw2
 AfZ7CMfkhdrYIT1Rwtts1kaAZid9aRfUEtcWgB4mQk0p3l2SpUHTmiUFmVkvT+i9GLDQr6TRgRs
 xHWRkcmJiL0m/+fLVuQvCz9KPJomIer90GtIwd+/TeHxRJqbNm+HHngJBnpilc/MYFWKh+7R6nj
 6okwEbUKTup06I+au+k6mWijnwm6d6K28S0Y52/va8Jck+AET4nw2WWDCTexkDxlsm0jpJjrfO3
 APyJ2/vG72pE+nwl2gEl0K4FdCcTZuxBQT90iubc306tZPPsyLIAm1e09Mp5VENSIWZ/y476ObC
 fm3frs6Qgx2xemCZpFrO0viCxXFI/coLHSzyuIAw1lMXx6GTcnUIx+Qd43XmLs+PHd9x+KaJRor
 H34ywMPOQ=
X-Received: by 2002:a05:6a00:3e1c:b0:842:3838:cb03 with SMTP id
 d2e1a72fcca58-8482f358cd6mr1181892b3a.11.1783405060454; 
 Mon, 06 Jul 2026 23:17:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e1c:b0:842:3838:cb03 with SMTP id
 d2e1a72fcca58-8482f358cd6mr1181856b3a.11.1783405059795; 
 Mon, 06 Jul 2026 23:17:39 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b96c0fsm4816238b3a.20.2026.07.06.23.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 23:17:39 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v9] misc: fastrpc: Allocate entire reserved memory for Audio
 PD in probe
Date: Tue,  7 Jul 2026 14:17:33 +0800
Message-Id: <20260707061733.495-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c9a05 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=c8cBMUidy7NAwe8AhH0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX35i8mzEtQz/v
 AglsYvQU9rFgB2VY7o6qaFOSjoaqeqbX0Uf6+6g8NLsmfW4h7nBfSIwEtKUzxw5JwliBOmZ6MnX
 6MzD/mKiGqsBvv+NTHuwD3O/9wVMMwJZ5q/a4eWpbKCMUBDfv8q2whQNOkLvOsThTjlSq6ui3h6
 8JSPmu1UnzcBQ0KVH2B9rhWDl7hmPuL00oGGb1SbSl/+39HgieBQmmhLJyfTaLC8uirSCxMexUo
 oJkE6JnJFuZtm174xsOR75XPGZhuE4akW3IBLypK+FYdiqji1lCuRCQHbrER5/Kx3Ucg2vriPzW
 uxxkNqu0G62wAQc/f+QjjSqeAMEJJMa7aFG4TZIj2OtoSX5nI3iKdUxJUcyIsA78+A2MD1bnn3u
 5nUS2zPpD0G+32P+JUHGb5eLTnWFMZ1MUYwh4KTqEYg4h4vLmiAN0MgUuPD5OwemicfO2EYKb6I
 1rQ8C+RdibVlvhF/onw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1OCBTYWx0ZWRfX8ydlEPYcydZ2
 Mr6zzJWoLk7cCpZgl08QA4BqgDY6LTR9Yycvl6kYobIzruss0FvhvC1nMsxfZtSchUpS3FcM62k
 P6Wc0zXPS2U03gyyhzQsyeH/8OaRBNU=
X-Proofpoint-GUID: B1RPLVdrRa9QKYPfq1qDdNqUDe5otUYF
X-Proofpoint-ORIG-GUID: B1RPLVdrRa9QKYPfq1qDdNqUDe5otUYF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070058
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
 drivers/misc/fastrpc.c | 119 +++++++++++++++++++++++------------------
 1 file changed, 66 insertions(+), 53 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..1ec37e6c68a2 100644
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
@@ -1344,15 +1346,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
@@ -1376,31 +1387,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1412,8 +1398,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 	args[1].length = inbuf.namelen;
 	args[1].fd = -1;
 
-	pages[0].addr = fl->cctx->remote_heap->dma_addr;
-	pages[0].size = fl->cctx->remote_heap->size;
+	/*
+	 * Audio PD is a static PD and retains the remote heap
+	 * information across daemon restarts. Therefore only
+	 * the first attach should provide heap information to
+	 * DSP. Subsequent attaches reuse the previously
+	 * initialized memory pool.
+	 */
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
@@ -1431,27 +1433,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
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
@@ -2418,12 +2400,23 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
@@ -2431,7 +2424,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			if (err)
 				goto err_free_data;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2490,6 +2482,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
 err_free_data:
+	kfree(data->remote_heap);
 	kfree(data);
 	return err;
 }
@@ -2512,6 +2505,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2529,8 +2523,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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

