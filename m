Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB74C44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:58:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE9910F282;
	Thu, 16 Jul 2026 09:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mn1mPHle";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="inZHN4Vd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BCF10F287
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:58:56 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G9rAZP3489434
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=JpsEaLu0rCn/373mwwPv0+tBDrJYa0gBUv7
 uufH8JPg=; b=Mn1mPHleX9Hw7rD+D5QvPF6SsK7uarwmjRavhwEOsQ3TkeiWkBH
 9jt/rxINC+Z/hQEboic21wqhS1gOamod0cDTdbNmYxdrblK4mkek7iOlywJRzCKU
 8xsQXWvwBUgrkxoWri7F7TxX7t2P5XeRC9sTlKFt2WBLIoV+Yry8aMSzf5Qm7IIL
 8VqGoMTBUzk29OhkD7hMqs4QpPuvV0S8OsSx6s754jjDBpzTqY0fyfiHQlQNCxjH
 7nUfbej3dnsxEHyQBj+Z6z/WTT0S+KE150Ji97MM8uxJUEnXoQ2qKomV5Smarg/z
 0CoPDDhyAMnPg+HO3JQHIASLHUCfbGNrRMQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feq3phe4g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:58:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so703035ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 02:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784195935; x=1784800735;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JpsEaLu0rCn/373mwwPv0+tBDrJYa0gBUv7uufH8JPg=;
 b=inZHN4VdCYqRO0vjkXBA3rgx0Kk/8GlQkgAT1L0THTCuvGxSsCeecuwAiB26e0e3tA
 F441OiLWALQGKVEYohSCKAmPAvuwzGK8uNs13R65C8CqZ+/jbnSJ0vsDmfGANc6fvlC3
 J1/Wrn1t9vz5YlD4U3bnMydKDJQtBnymttDz7J6xRNRGpdHyDP1e5q77n8jiHvyUGI2p
 Upd8J3cE9Bo5hjn30KOFOTXb3+7auzY3DFe7Tzh3cyWXErLfzv9KVStsO+JjvUV4JTp/
 BslSCDytO61YNYTxeieM6U4quZrDOOnoKl+LUusOsMQ/m04zCAHEnhOXUyi359PmUOy3
 pnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784195935; x=1784800735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JpsEaLu0rCn/373mwwPv0+tBDrJYa0gBUv7uufH8JPg=;
 b=Iz3FuZkzV+UFa2puoSsuLB4Be+rbHj+VHe02DOPCY2a0j8dc+3aZvrIgTEumOtZJyG
 f6SrkMd58ZWz02jgk792kUiXpm/fO6MiaAtXoQXj0RjEBqZ7BZgbPHwo5Gqt6KgXEt6z
 p5aRc2ypdtgULk61Vgjoex74ifvu8em5YHgexQWrqUQTaK6sNcbGhc0svcklk1ySbDir
 T3SAvIxA2mKcc2yuyBENr4d17lSTQmiYDr7xn5i1tCWPAghSfP4LxoVHQ4/pYt6wViVQ
 0g+bRJ5Qzk1sBnKKTAJO47EqBVSQZfP7QqxADs9AmXLIttXp2IWvYvtCFAjB55/k139c
 nOyw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0JT/7SjNBCeFeYAzz4CTVIhQ7ZnpAyjAdDWJfrZ0xk878JauvotzrDuPkpY+L5HPfFlnOjcJdoQE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzMjlDpmeR+1tAxiqi+Ty42O/9NVtaDKXRtDlkiBGJSFjldPcr
 Pag05YhKgYGoqt+5VSJborVKMVPgIydRrNJPuGf28AANw16Y2AlZGPvgFoBjOo9rrHW1i+Wkmgp
 NvxQ4uBku+MWRof4Zbmwvsn2qzZP29Ev45O0kIVpwLkXEmkmJnOktjlUsxEi651f1XARMXIc=
X-Gm-Gg: AfdE7clV8A1cWLkNNfdB2UsW+dCaVHov1lEoJM9OjXvMuP2oDZOgzg+iFVeM7wP/b5i
 un8245eC+QUbejhHGUXnNXmxfSXEWirqUH3cZ4BiAodpKjZLsfc5n52+pAI2aYYFx8FnKiZQKD8
 ZHC3KYN2cjQP0TVATB/KoJEKEGJgCMA/1BX60fL8mcm2hY3/CTggvZ8EPACULnrjPeVlyI8RnZE
 oWfBfmNZBi4UUmpEntV3MjYQTi4nf7GoHxKr5K+Ip8nncYF3NABmUXZ6+PR5cU3/EJZwVpGIGNV
 JlD52wKWVk8ty3Tt6RfhEYLAdbmX8qqj6yu7lyDMRxFaK71XS0xmFYO/xkBIzOm7qxmGJ/qd4kq
 HhoY4YOmXp7arZjuie1gtVw73gCnQt85AgPezXPJCiMTfX0vI/k+cYpiFKZqFknmUNK6cwOLhdA
 ==
X-Received: by 2002:a17:903:1aa3:b0:2cc:89ce:2f07 with SMTP id
 d9443c01a7336-2cf1f27ef69mr19283295ad.1.1784195935179; 
 Thu, 16 Jul 2026 02:58:55 -0700 (PDT)
X-Received: by 2002:a17:903:1aa3:b0:2cc:89ce:2f07 with SMTP id
 d9443c01a7336-2cf1f27ef69mr19283035ad.1.1784195934598; 
 Thu, 16 Jul 2026 02:58:54 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf1015e45bsm17581045ad.33.2026.07.16.02.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 02:58:54 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v10] misc: fastrpc: Allocate entire reserved memory for Audio
 PD in probe
Date: Thu, 16 Jul 2026 17:58:47 +0800
Message-Id: <20260716095847.479-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nGBfP1GGIdISdUX2hyTtRMP2Efeb7M2W
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEwMiBTYWx0ZWRfX9TVSLOQFqMFJ
 eZRKVO2MAXABREioUDbLb4eu5tzjMFU8ErXdUtFh8ZB6doZgrhJzeGdKGH8THA158KXPFAEIwjV
 x25l6wl0fv1Xw3iBuKGi6182XrRqOUE=
X-Proofpoint-GUID: nGBfP1GGIdISdUX2hyTtRMP2Efeb7M2W
X-Authority-Analysis: v=2.4 cv=PN8/P/qC c=1 sm=1 tr=0 ts=6a58ab5f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0G0rfPxOs2MEFri9fakA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEwMiBTYWx0ZWRfX9YkEG5N5kBdj
 m6mbsXMHGFibhXLeViRruyTxdCX9l5bGUHIAEi8GdsfdS2EUWDuRtjOHXysVnAYqJR4+2LQGD//
 yc/mLjbBhs9tBu6UJYy0N3efH8FQxOS13vqVhQrzfwU0g83QCTe4qKoCyPLySIaAvOC1YzYsBl8
 Eodk+ljmUURXe9f/Tuo6lSAQ4lHGV03WdZemghaLHkTqA8koH8N0cDWpwvUeevQ9V80fMyi9tAi
 DgSqrrxzw1hGTX1F6iU1EnTyWfz+pGk+QwDQn7c9SXEuo0YIlH342535I1M3T9HWvgwAhsvEOoK
 BGnrGHHsCxDmvg1oiWiLe9Vg6W+VC0l40xvVKdy5tBSbAr7yRuJtIOao5Kujmo0jdk9Fe0bSrn9
 JBDRhWJTkqmzmY0TKr+9iB4018qylLpdcfTQD5DHwEvAJXcF/OT+RSw1izsn+T9fv938j2INtJs
 nptTqeooHX7iZTF705Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160102
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

Patch [v9]: https://lore.kernel.org/all/20260707061733.495-1-jianping.li@oss.qualcomm.com/

Changes in v10:
 - Move Audio PD remote heap validation into
   fastrpc_rpmsg_probe().

 - Treat Audio PD remote heap as a mandatory
   resource and fail probe if the reserved
   memory region is missing.

Changes in v9:
 - Make sure fastrpc_init_create_static_process()
   only sets audio_init_mem to false when the sent
   address is actually invalid.
---
 drivers/misc/fastrpc.c | 121 +++++++++++++++++++++++------------------
 1 file changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d86e79134c68..03f633028c00 100644
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
@@ -1344,15 +1346,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
+	bool sent_heap = false;
 
 	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
 	if (!args)
@@ -1376,31 +1380,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1412,8 +1391,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
+		sent_heap = true;
+	} else {
+		pages[0].addr = 0;
+		pages[0].size = 0;
+	}
+	spin_unlock_irqrestore(&cctx->lock, flags);
 
 	args[2].ptr = (u64)(uintptr_t) pages;
 	args[2].length = sizeof(*pages);
@@ -1431,27 +1427,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
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
+	if (sent_heap) {
+		spin_lock_irqsave(&cctx->lock, flags);
+		cctx->audio_init_mem = false;
+		spin_unlock_irqrestore(&cctx->lock, flags);
 	}
-err_map:
-	fastrpc_buf_free(fl->cctx->remote_heap);
-	fl->cctx->remote_heap = NULL;
-err_name:
 	kfree(name);
 err:
 	kfree(args);
@@ -2418,12 +2398,29 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
-	if (domain_id == SDSP_DOMAIN_ID) {
+	if (domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID) {
 		struct resource res;
 		u64 src_perms;
 
 		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
+
+		if (err && domain_id == ADSP_DOMAIN_ID) {
+			dev_err(rdev, "missing mandatory remote heap memory-region\n");
+			goto err_free_data;
+		}
+
 		if (!err) {
+			if (domain_id == ADSP_DOMAIN_ID) {
+				data->remote_heap =
+					kzalloc_obj(*data->remote_heap);
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
@@ -2431,7 +2428,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			if (err)
 				goto err_free_data;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2490,6 +2486,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		misc_deregister(&data->secure_fdevice->miscdev);
 
 err_free_data:
+	kfree(data->remote_heap);
 	kfree(data);
 	return err;
 }
@@ -2512,6 +2509,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err, i;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2529,8 +2527,27 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+	if (cctx->remote_heap && cctx->vmcount) {
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+
+		for (i = 0; i < cctx->vmcount; i++)
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

