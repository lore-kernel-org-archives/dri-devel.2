Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB35C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B2A10E550;
	Fri, 14 Aug 2026 10:20:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DeI95hMd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EbyrGeXX";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB26310F44B
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:20:04 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E7faO5273917
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=EUyEBiYm9ml2TXp0VuDHawLVHLpQXWhPq5u
 l5SmPCkQ=; b=DeI95hMdYTqWi4XrJ1ZLyLhYABZeMNgwZQwLqlf5MiNO4hrk2I6
 mOm7gWaV3PgB6nLWcShki24E5QxMxFBYgv/eP8oju10b/IHxawKf8dvjEkrnbdTt
 EX+fiKQHsZbIbvYs2qPfFOti+9Dmt2kJ6Qb4SFPr1Pes+VrhpztLn+4pt+YLKkA7
 +yWVniFwlrruCowM0Rh0Cmk9MHkGdORWEPFzfRWfNDQAhO+k1TY0IffyIdjcbA9q
 Ul5MeAVOjQxNA2MGwgd2qKANeGDTSjgATLCCPg54qspGETfaPyNilan0/KEtR49k
 g8YWVD18wfEBdRqJrlhnOzdFsYgV5mshvhw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1m42jvpa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 10:20:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e22137fb3so1297689a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 03:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786702803; x=1787307603;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EUyEBiYm9ml2TXp0VuDHawLVHLpQXWhPq5ul5SmPCkQ=;
 b=EbyrGeXXjqCP8jI4w5p4v32h3cevuFK4Iohv4C5Ac8ZxNgMhsDR5Xuc4pjx81ZRUIB
 NJuOO5VZ40yvlMmahue7W7ISMLtraf5V5GJjE7xhJu715I5vN7i0rlI2DJpgRemosdgi
 N/N9E/AlquayS7SHamAgngJbM6B6cXdrBZmmPMqryi7JNQ5ZrLvhgVXAfGV4jhFcrtTK
 AKD8GOhbxdg728PSOe7b/I6vGhMHDXwrnfPYfYNjBK3i9oZbYNzkaAI5GZbXuxVQWoAo
 JRejHPa0l8OXZjNI+EdtOIkeQG/nisQFvMouzHujX0chxPYSbXtezbNMa99w5ETjcV3h
 Qg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786702803; x=1787307603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EUyEBiYm9ml2TXp0VuDHawLVHLpQXWhPq5ul5SmPCkQ=;
 b=UhpgqUzEeI6SSMeRlymrTnYjfGNFcifMY9c6RC7+5Pzuz+t29lXJpQtLJB4BXGciuA
 b9uYdIk7uuehdkgAVsjnGDpfEqd2Ksmx+nYqTqBH0G6h/3jv8GVkyDDHOnI5PcAQlO6J
 G3/+cJV9VkWtjLA8PLaa61NlmYESYIGhnTVEs7noj89qoU+/AhaOhoLah6KpmofMURtc
 1h3bPA+mgL6V6IAjmhbx2hXOysn7sYyAJ+6G2fRnCViet1LYbb2SqAryCRfMba2Cdq8D
 Jf5eddBVsr4ZvdXaAZbh62/nk65f6/FT/DR8LbmhaYmbnmZQV0JmExOpf2/S6HP9W3iu
 g2EA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDV9O0UTHRUNVctEr11dyJimvUDf3RHMtlupxt2rCOcuD3lmDS9HI4TWM4DvZRAWVoQ+cIG+VcNuk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyA9k5cLhsp8DbI4myGjG2vBRxO7HDBCLI7CNZqLDsApJ7oUst3
 oO5f4DUGLt1hylJPrrIhSTmCfEGYXfS/twmLrddHOAuzohxO4vGIzTe5xv9XmJZGDcmYCSlWCv8
 w0GWeA8LG5lu3DRe35MnyPp2mcDur/AEXC1Dt4i2WRD6FABtwNMFnacuxDQW5qaGlTiwGm4E=
X-Gm-Gg: AR+sD10aY2zgD0QYfRWm1IMsgP53667jax13VRRrj6ASztI481aTVqYsWjdoaSionw1
 YCdoWQzbyq2s/79MCe0XmuxqggOXp/bkMuGQHd1qyTqaUlRMAOHoEdK2n2gSIbnouRPIb/ZZ08w
 9JmiGSJIyWh6KqQBqpMAuLY2aOPE47C501W0bxpVxVyOgbkhtNIj7fwDyDA39gwp8koh10oocRw
 Oji+6dgGZl1F/HFLb6aFHN4qx5ahthdiGRwXuFs3cJQxXJQ31AC5lKKAeK/AP5vAi74pBj/c4cP
 5qlIR36l6GlevQByF+Rml882cgpdRqaH+KEe04BIHDdVtDNiGGmsMOIdf18trwtsdx4eZJ+bGsz
 oq+GvWXnsugab3uKul8uIUJ2DeenwOpqQLjBAuDlMOEs83SlhWApRPjYCLVO8j91rBeVIGFDrKw
 ==
X-Received: by 2002:a17:90b:384b:b0:37f:e1af:df22 with SMTP id
 98e67ed59e1d1-3933ba90e38mr4630119a91.17.1786702803081; 
 Fri, 14 Aug 2026 03:20:03 -0700 (PDT)
X-Received: by 2002:a17:90b:384b:b0:37f:e1af:df22 with SMTP id
 98e67ed59e1d1-3933ba90e38mr4630070a91.17.1786702802556; 
 Fri, 14 Aug 2026 03:20:02 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ea9a12ddsm2200370a91.6.2026.08.14.03.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:20:01 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v12] misc: fastrpc: Allocate entire reserved memory for Audio
 PD in probe
Date: Fri, 14 Aug 2026 18:19:55 +0800
Message-Id: <20260814101955.234238-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I+dVgtgg c=1 sm=1 tr=0 ts=6a7eebd4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1D97j8aAK20nWj_7C5gA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: bGcwROGHQTx614O-yYfE8arIbZM6RknY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfX+n/RGNx6yfVN
 sQaXmcvN/FurTQmTLSeL8YFiLJ8Mgs+vACA0gxcSGR9rqjjHUidXguRdbB3kdoiWdKlMbaN+og2
 3lgXQw1i1c5X9vizm6VuEVlngLweE+PbzCSBrHFh32z/VWF0cURevwcJyWZoT+zluqW0ZB4NJBU
 9+Mp3TFfkngxLPHD8XA8NBAnNIYJnXzsNyYM+hoKa/8KURNngBku4JYi3DrV0U2pMZDrP3CTZK2
 2j854L5TdOjF9tYXtgfsB7kE75voN+mOOo2/5bBWJyFtNFqpn6qtSvSc9xdg+YXojYGUKKoRi3p
 DDX8phLCbiK7CsFqRxLqO4+OPbm0l5WrDBm+qHuVpIkDOzfT40WJ/IVhvI/2ldeZeaCfU3BhEkE
 NnYpA1DtcfnKVf0+AHoMPfK+aRYVcXkX1yCbVSsFJ4DvhOvmjX3A9AgSC/JwMf9MW1hopXKsfsH
 sH6U20OLUMTEz8hfb/w==
X-Proofpoint-GUID: bGcwROGHQTx614O-yYfE8arIbZM6RknY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA3OCBTYWx0ZWRfXzazMRac0d0DD
 61w141UNrHAnYYSO1T9kXjNMeQ/BX3WOhNxd7q/NwxqTX2KPpIlUYAiC3ZV7255ZqIWaj6IQ6Qy
 /uQsE2EhBU46W3dBXngaaS1s+Xr5OWY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140078
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

The reserved-memory region is now mandatory for the Audio PD domain.
Rather than failing rpmsg probe when it is missing, validate it in
fastrpc_init_create_static_process() and reject only the static-process
creation. This keeps the fastrpc device probing for all other domains
even on a misconfigured device tree.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>
---
Patch [v11]: https://lore.kernel.org/all/20260731093210.473-1-jianping.li@oss.qualcomm.com/

Changes in v12:
 - Do not fail rpmsg probe when the reserved-memory region is missing,
   validate the region in fastrpc_init_create_static_process() instead,
   so probe keeps working for all domains.
 - Add fastrpc_domain_has_reserved_heap() / fastrpc_domain_uses_static_heap()
   helpers to replace the open-coded ADSP/SDSP domain checks.

Changes in v11:
 - Replace the remote_heap fastrpc_buf pointer with dedicated
   remote_heap_addr and remote_heap_size fields in
   fastrpc_channel_ctx to avoid leaving a partially
   initialized fastrpc_buf.

 - Drop ADSP_MMAP_REMOTE_HEAP_ADDR support from
   fastrpc_req_mmap() since the user process should no longer
   grow or shrink the Audio PD remote heap.

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
 drivers/misc/fastrpc.c | 150 +++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 74 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90fd669636ec..3f14a4673698 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -70,8 +70,6 @@
 #define ADSP_MMAP_HEAP_ADDR  4
 /* MAP static DMA buffer on DSP User PD */
 #define ADSP_MMAP_DMA_BUFFER  6
-/* Add memory to static PD pool protection thru hypervisor */
-#define ADSP_MMAP_REMOTE_HEAP_ADDR  8
 /* Add memory to userPD pool, for user heap */
 #define ADSP_MMAP_ADD_PAGES 0x1000
 /* Add memory to userPD pool, for LLC heap */
@@ -314,10 +312,14 @@ struct fastrpc_channel_ctx {
 	struct kref refcount;
 	/* Flag if dsp attributes are cached */
 	bool valid_attributes;
+	/* Flag if audio PD init mem was allocated */
+	bool audio_init_mem;
+	/* Audio PD reserved remote heap region */
+	phys_addr_t remote_heap_addr;
+	u64 remote_heap_size;
 	u32 dsp_attributes[FASTRPC_MAX_DSP_ATTRIBUTES];
 	struct fastrpc_device *secure_fdevice;
 	struct fastrpc_device *fdevice;
-	struct fastrpc_buf *remote_heap;
 	struct list_head invoke_interrupted_mmaps;
 	bool secure;
 	bool unsigned_support;
@@ -1454,15 +1456,24 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
+
+	if (!cctx->remote_heap_addr || !cctx->remote_heap_size) {
+		err = -ENOMEM;
+		dev_err(fl->sctx->dev,
+			"remote heap memory region is not added\n");
+		return err;
+	}
 
 	args = kzalloc_objs(*args, FASTRPC_CREATE_STATIC_PROCESS_NARGS);
 	if (!args)
@@ -1486,31 +1497,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1522,8 +1508,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
+		pages[0].addr = cctx->remote_heap_addr;
+		pages[0].size = cctx->remote_heap_size;
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
@@ -1541,27 +1544,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
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
@@ -2090,7 +2077,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES) {
 		dev_err(dev, "flag not supported 0x%x\n", req.flags);
 
 		return -EINVAL;
@@ -2101,10 +2088,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
-		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
-	else
-		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+	err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
 
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
@@ -2143,20 +2127,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	/* let the client know the address to use */
 	req.vaddrout = rsp_msg.vaddr;
 
-	/* Add memory to static PD pool, protection thru hypervisor */
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR && fl->cctx->vmcount) {
-		u64 src_perms = BIT(QCOM_SCM_VMID_HLOS);
-
-		err = qcom_scm_assign_mem(buf->dma_addr, (u64)buf->size,
-			&src_perms, fl->cctx->vmperms, fl->cctx->vmcount);
-		if (err) {
-			dev_err(fl->sctx->dev,
-				"Failed to assign memory dma_addr %pad size 0x%llx err %d",
-				&buf->dma_addr, buf->size, err);
-			goto err_assign;
-		}
-	}
-
 	spin_lock(&fl->lock);
 	list_add_tail(&buf->node, &fl->mmaps);
 	spin_unlock(&fl->lock);
@@ -2537,6 +2507,16 @@ static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unuse
 	{},
 };
 
+static bool fastrpc_domain_has_reserved_heap(u32 domain_id)
+{
+	return domain_id == SDSP_DOMAIN_ID || domain_id == ADSP_DOMAIN_ID;
+}
+
+static bool fastrpc_domain_uses_static_heap(u32 domain_id)
+{
+	return domain_id == ADSP_DOMAIN_ID;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2584,20 +2564,25 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
-	if (domain_id == SDSP_DOMAIN_ID) {
+	if (fastrpc_domain_has_reserved_heap(domain_id)) {
 		struct resource res;
 		u64 src_perms;
 
 		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
 		if (!err) {
+			if (fastrpc_domain_uses_static_heap(domain_id)) {
+				data->remote_heap_addr = res.start;
+				data->remote_heap_size = resource_size(&res);
+			}
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
 				    data->vmperms, data->vmcount);
 			if (err)
 				goto err_free_data;
+		} else {
+			err = 0;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2681,6 +2666,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err, i;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2698,8 +2684,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+	if (cctx->remote_heap_size && cctx->vmcount) {
+		u64 src_perms = 0;
+		struct qcom_scm_vmperm dst_perms;
+
+		for (i = 0; i < cctx->vmcount; i++)
+			src_perms |= BIT(cctx->vmperms[i].vmid);
+
+		dst_perms.vmid = QCOM_SCM_VMID_HLOS;
+		dst_perms.perm = QCOM_SCM_PERM_RWX;
+
+		err = qcom_scm_assign_mem(cctx->remote_heap_addr,
+					  cctx->remote_heap_size, &src_perms,
+					  &dst_perms, 1);
+		if (err)
+			dev_err(&rpdev->dev,
+				"Failed to assign memory back to HLOS: addr %pa size %#llx err %d\n",
+				&cctx->remote_heap_addr, cctx->remote_heap_size, err);
+	}
 
 	of_platform_depopulate(&rpdev->dev);
 
-- 
2.43.0

