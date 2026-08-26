Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4368C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 03:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9218F10E23E;
	Wed, 26 Aug 2026 03:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YwMdu0xx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SVbWDd9q";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BF1010E23E
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 03:38:12 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67Q3HFVP713666
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 03:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=7L1HH1SV4UKECcl7A4Q4VvEr/8i7bUzPh/g
 ZMR9t50g=; b=YwMdu0xxzJhXoO+7uspshInznRFeZctE7RwbUMATv6FNEKETFJx
 qhA1GlGrM04DClqY/xxueF0N2IsWrTouVNxcE7IS4QbMvcLQpv8bspghE8EWPHGr
 SA5DdbvBVCbOjLnvh3UJukr2frS9m73T2gWEnO4CpwKjRLHt7BWgr81XOuB8xIIY
 ug4MGsfasY4ILSDQMnQpf1EX9JdKuRzEtY6dBvECg6g9OW6IFECCK3x5LvbThiWq
 R4HNsTofdCyFydzDqevEtmhRqkxmIpprF4uGH6gk598+/QCTCRKqAhj+vsJbDuWe
 vPl0MNKE+p6JtR5l2kCrnRECjvg5LohEPZA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bnjb2qp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 03:38:11 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e6d253330so860722a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787715490; x=1788320290;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7L1HH1SV4UKECcl7A4Q4VvEr/8i7bUzPh/gZMR9t50g=;
 b=SVbWDd9qJK589kDCmtF0JLogxN3JL3VRFqKJNuCe2eDgIY6YEudocCmcs5fBVtk/z8
 oNVM8PCNZ6ffoeUz2/WBKCO9jDVEqGRJbT4SA+NFQ2WopfcTyeB201o2RjYMIEQ5hoMX
 JZ4ToQ9/40MSe/BrtcqvYf9N8JSvbRq04wFLgO5JixRwNfjDGsXAKp+obf7yuf8JVknX
 LRAnAq602lP0cGZfm0gZ89EoPBYc/P4b4b5X+IKRvkWqlgXUu6OoWqcxLsTnMDiiY7UD
 vaCeEhvY4hSlusEEKlvbvO3bhxuiuHfx3NdqMB0e8StJIY+AyV3k6SRvBSJ1Fu6sGBxD
 ScXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787715490; x=1788320290;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7L1HH1SV4UKECcl7A4Q4VvEr/8i7bUzPh/gZMR9t50g=;
 b=hCCv2twn2yQLaf76QDQBzIRI4tW1S3YBz3F+6gb4YD2y62wkqS/VkEKKdb8pbg4Tl+
 dlx4PgxTsjULQ7yi1uV7xsnYjh2DmqvVC4E0L8Sb03jM4CTt/d/Jdtllz8lT0Vyw+ebH
 DoFlnBTXGHAxwxEQ2CCQp6UXwrnwZliPud86GXy28DFojxr85GR/1eZPhkwe6xZ/1ka/
 DQSHdMErxIs5PAPjdBNJxWwTaaGpEqDYWUWzv5M9qgMTCAL0WhaFCDD8ZDVVxXcrkgQk
 j4w6h3kC2kfZtsuBEHsuyZt63/l0zm8bWFPa6hgS7czmDSLU6RjX4EdpM/oWpwBI8478
 6Kag==
X-Forwarded-Encrypted: i=1;
 AHgh+RoIoSrLSNQyov/nCSWTwKBB0JpH/0Ikoza3MNFSf3N0ACRSxjzFFzD06GYbY8WCq8QMSz65UqehIZk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nudUFgZF31DrgnY1fCNm91cS64vlbPlJd04WbNX7bo2H9ycqbH
 9aEZaQE+C46LoEN7bgYQZrfv0DBj+YunmcCl+kjGFyudGmBgAKAqepu1Q30JGW4rXYWwFSfhIOr
 Q7+5d7YDggtQAhQBXHp9QOmdsqEcxCIbS218kVp9CHCK8lATDuyTvb9YG6v3+30myDqfA/h8=
X-Gm-Gg: AR+sD11qHU7MQ1PcfD1SnXk9XCHfcH/EHbCrDW+x6bCZM/7HZ65b6uRk/mf0DKw7wgL
 4YPZIgRy+0ekad0Rn5GfaQwt275gQwTn/QOO+IG1YU/P8RLFQhxz/XU7wSTA8vqx5qBCCeyvvWy
 d64+DUX1qj46eLMcqmwo3nCxU7g5mNirFq50NOUW9TMBE9Qe89O0tbvZ6NIg4gz0FhGC8KMZRue
 sX2ZXUXlztF6U9/de501rnzL9jkPZJTIqURkqU4Dpqov/m0oziQY/6gmeeArUE6agk0O5cq692A
 A6wBqptXgQPzEwptndzq8bOVjOfa2ZqvNJdRQwED87XTdG0/2lt0mzDxFTw07X+TWs35g5p8dAs
 9nl9xN6T3LH/8JfrILh85OEmP6+oxs5vG7EkBQxMXT0BjIiIk6WFlxP3MuGfph0DefFsSvprNPg
 ==
X-Received: by 2002:a17:90b:3d81:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3966d3d1262mr4805024a91.3.1787715490285; 
 Tue, 25 Aug 2026 20:38:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3d81:b0:38e:6d55:b1a6 with SMTP id
 98e67ed59e1d1-3966d3d1262mr4804942a91.3.1787715489706; 
 Tue, 25 Aug 2026 20:38:09 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670607ea5sm514357a91.0.2026.08.25.20.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 20:38:09 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v13] misc: fastrpc: Allocate entire reserved memory for Audio
 PD in probe
Date: Wed, 26 Aug 2026 11:38:03 +0800
Message-Id: <20260826033803.475-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7APSKJeNuwInzgt6Tn-YQmXuQcM3XlUI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDAyNyBTYWx0ZWRfX5KUsRj0kUlPk
 g4n1c/+cItJ6uLJ4E37mTdSQkhq0UoUXkBq0FlqRFF3KvIrC8a17lN4Ffv6001mGBXUPFahLgZe
 Mi+jEL83K4mTH4hF1nb4RAh0mFnZ2onqJ1ExgbmZvDGDZoUcoBLhoNFk1Xv+Vllh7T0EGmKph+g
 1DB+TJth+1z2iVZRtD/qCwrMG9lrZGgcaAoPNAKKZLkNv4Z9cZhOUp2jZJMjRzCHkPw3unya+o/
 1NRAlt7VkK2RR5XMJQGVQEWhCgyHHCWMTqYBlj4btO+Vq6E/pcz5SfO89xi84omNK+nGxZ2XrS/
 1QepZfo5Qn01Y3i+op1Pc9NCuPaapJIeIbPc3lbWCCPmcdVju9lSRIbxXYMbKnjalkeLTurvbOY
 NsbrMHvoeOl/l2p+QCfcXVQcLKEuHaO0ClooVLXRWdkzgKVRuhwKCblCUOClZPxjzsod1uD68Ne
 QXL/V2RP2PDbhrYJbgA==
X-Authority-Analysis: v=2.4 cv=ZuHd7d7G c=1 sm=1 tr=0 ts=6a8e5fa3 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=1D97j8aAK20nWj_7C5gA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDAyNyBTYWx0ZWRfXyGwqLQSfOSWX
 JEv8HcJH5t33Z8KfUKBSv8tuFA9AAKDmiJ0Z/WUfwjSW5FuQ5/7F6d4c+uVd+nQCUP9o0XHWJlv
 sQe0NWHkObHDQGWP2hm6y0w+PNYPwbk=
X-Proofpoint-ORIG-GUID: 7APSKJeNuwInzgt6Tn-YQmXuQcM3XlUI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260027
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
Patch [v12]: https://lore.kernel.org/all/20260814101955.234238-1-jianping.li@oss.qualcomm.com/

Changes in v13:
 - Replace the fastrpc_domain_has_reserved_heap() /
   fastrpc_domain_uses_static_heap() helpers and the open-coded
   reserved-memory initialization in fastrpc_rpmsg_probe() with a
   single fastrpc_init_reserved_mem() helper.
 - Check cctx->vmcount before calling qcom_scm_assign_mem() so the
   secure assignment is only performed for domains that actually
   have heap VMIDs configured.

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
 drivers/misc/fastrpc.c | 188 ++++++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 87 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 90fd669636ec..d47e2d01092a 100644
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
@@ -2537,6 +2507,45 @@ static const struct of_device_id fastrpc_poll_supported_machines[] __maybe_unuse
 	{},
 };
 
+static int fastrpc_init_reserved_mem(struct fastrpc_channel_ctx *cctx,
+				     struct device *rdev, u32 domain_id)
+{
+	struct resource res;
+	u64 src_perms;
+	int err;
+
+	/* Only SDSP and ADSP domains use a reserved remote heap region */
+	if (domain_id != SDSP_DOMAIN_ID && domain_id != ADSP_DOMAIN_ID)
+		return 0;
+
+	err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
+	if (err) {
+		/*
+		 * The reserved-memory region is optional at probe time. For
+		 * the Audio PD (ADSP) domain its absence is validated later in
+		 * fastrpc_init_create_static_process(), so keep probing here.
+		 */
+		return 0;
+	}
+
+	/*
+	 * Audio PD (ADSP) is a static PD: cache the region so its lifetime
+	 * is tied to the rpmsg channel instead of being controlled by
+	 * userspace.
+	 */
+	if (domain_id == ADSP_DOMAIN_ID) {
+		cctx->remote_heap_addr = res.start;
+		cctx->remote_heap_size = resource_size(&res);
+	}
+
+	if (!cctx->vmcount)
+		return 0;
+
+	src_perms = BIT(QCOM_SCM_VMID_HLOS);
+	return qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
+				  cctx->vmperms, cctx->vmcount);
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -2584,21 +2593,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		}
 	}
 
-	if (domain_id == SDSP_DOMAIN_ID) {
-		struct resource res;
-		u64 src_perms;
-
-		err = of_reserved_mem_region_to_resource(rdev->of_node, 0, &res);
-		if (!err) {
-			src_perms = BIT(QCOM_SCM_VMID_HLOS);
-
-			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
-				    data->vmperms, data->vmcount);
-			if (err)
-				goto err_free_data;
-		}
-
-	}
+	err = fastrpc_init_reserved_mem(data, rdev, domain_id);
+	if (err)
+		goto err_free_data;
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
 	data->secure = secure_dsp;
@@ -2698,8 +2695,25 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
 		list_del(&buf->node);
 
-	if (cctx->remote_heap)
-		fastrpc_buf_free(cctx->remote_heap);
+	if (cctx->remote_heap_size && cctx->vmcount) {
+		u64 src_perms = 0;
+		int err, i;
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

