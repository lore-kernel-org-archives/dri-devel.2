Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838D6C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 09:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D96E10E1F3;
	Fri, 31 Jul 2026 09:32:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMmx1NUm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYaxrVrg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83CBE10E1F3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:32:20 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V8ZoxB3476235
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=wUbHtxRx1UaykzKn9/78x3dxb6CH/2YkVI6
 E2YLTXV8=; b=CMmx1NUmKE6qtZuHyowodg4iRF/Hn5XtQkvpX00+wLiVNeg32iU
 avNscTpkK+JrWKVzEHzshg9VqQwnsxbO1a4h9njJQuVrmA2iVJr6jZQs9dwAHji/
 3P5e3h9uCtlIs2SOZ0z2o3tUAfF/yecsKbAo1maMGkRN2b2F413WY7uE+SNDbQHz
 i31GrOcGU5XVtM0lm7DntI6yNdodMCdmRSSKJwUOe/7qPcy/frFfdLSD/pvCUKfr
 0adlja/wIYtGR65Wbi/PrSmbukwQmtwjWFUqPdQbNa3ay8R/O/6/e0lS5QZGqckY
 Eabp0Fngrol2ynUFhtVs6gDKrrbYtmWLjcA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frrb907r1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 09:32:19 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-848474825ffso830859b3a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785490338; x=1786095138;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wUbHtxRx1UaykzKn9/78x3dxb6CH/2YkVI6E2YLTXV8=;
 b=OYaxrVrgIrXUwCfBcK6G+iMnnO/ek3FFDgormmgs5e9ixNVN/2JX+6fd3SZEAGMIw+
 Zg0+t59bqL1P5lVFcvC0wn6HyIcTsyhVsjMAGSWOsk5l69s0Lz+m4ijWeZX9KzvxqJXo
 wjyukx5dRx28FIPhMiZjnJN9L6lscv1kwXzUxkJA+QDcRdgco5ZjjLlgjbSwyhgUKoCi
 5jk2JtBoLnNAoHVYQxeA9LyCZ9s7xOTpMBIoITqZNhA/xDqhOvEX77hcDAIqHLFovVI9
 BVJd1D9lrd9xeG4t9VlkpAQx+E5eIg3eM7JDU7S4r90ZVQNB1++Vr9G+YQ7tMSUwuHVp
 mckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785490338; x=1786095138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wUbHtxRx1UaykzKn9/78x3dxb6CH/2YkVI6E2YLTXV8=;
 b=rzYfKX9A5ySHehVMP5I7jKyyJjDduDdybRHjKHnjAWAE60NE5amMTP8W//LIYoJygY
 NRDD8fgmoeopv7H5Szk6cmk+Zx4loKAA2iJLIGFByVahOIcv9dAk7Pau2069/iZAOOqs
 JwN9GeDV5ndVt1yAotmrajxHtlsMzkeQhHSQADbU2jdGVqyKf0CoBYpqbs+dUeWkfQo9
 H9CoIvdUN9Q4uETHveQCQmeVMObwucBQFMmjO3InyxU567yny/gmXe+DLJb+uwXNm11e
 ypnMzxYexW1XXscoxiwqdIYouKUf24jitxtxUlrsVY0VbU3Xr/A1q8GbbpOud74aAI+7
 Vs9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkDDBHyVPy7ArXc935oY/lRpKCCXe8AZGv7eP2/rH36fwk2CFwx1BM9YpQtJMsZXrorLXZaOw7Fzk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYw5uYnoOfRKgfnJ9qK900fwpPcLiTsF0baWxQWyzIHWKcA9C+
 47kGz/Vj9453hJDai1lhUrU0haU0mjWoYVMlZxb4Nhu6X1QZmdMMTTla06cnUXu78EELegTFcr1
 mQThsew2ZpZKhqv6ZTNUx7nA/BgR/Y2UhRfuniXkFtyKKCffzLabwhdAjOAnUinkgs0i7pes=
X-Gm-Gg: AR+sD11OUZXonPYrlRvFGBt6BkJkkO7+fKDzTVeUYcEjeS021oETwH0T5LcVTlITvlJ
 502IA0pNIaD9fRm6jdebFZ8AgEnCLBFaZaodTfEP5sb4Cnd9TFA98arQFNDqSGg5+Y/itz36r3V
 9iWBoXGFtoMyp3lzItPehE7zvnFSDcZzBdlde3G3g2na24x9vAw4nek46AeSGKFmEOwj847rDWY
 FBcN5rYEyLJOnsr5/qD4N9fc6deQzGzn7VpoJtcdSHyWwZ+B4ypqfGZs45NTXf8ZOjFUOuPsisN
 LY9WfOrahu6GqwtnIkkI/DjeOncyXPD1fWynNY7tZDgdNrdPrJf9bGBLsFtPk5WH5F4bY9Xkvyu
 Z/+4lLT1yFqKNrIsXCgFFL1nWyQNutIAljPv44nNdMEHFVk4/Sl9u8JZBjd7F6Lvm6aXaQCBi5A
 ==
X-Received: by 2002:a05:6a00:35cd:b0:82f:51e8:b38e with SMTP id
 d2e1a72fcca58-84ed7483bc7mr1020530b3a.24.1785490338092; 
 Fri, 31 Jul 2026 02:32:18 -0700 (PDT)
X-Received: by 2002:a05:6a00:35cd:b0:82f:51e8:b38e with SMTP id
 d2e1a72fcca58-84ed7483bc7mr1020497b3a.24.1785490337392; 
 Fri, 31 Jul 2026 02:32:17 -0700 (PDT)
Received: from QCOM-SocCW5bzXR.qualcomm.com
 (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe3963ddc3sm340155a12.7.2026.07.31.02.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 02:32:16 -0700 (PDT)
From: Jianping Li <jianping.li@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Jianping Li <jianping.li@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 quic_chennak@quicinc.com, stable@kernel.org
Subject: [PATCH v11] misc: fastrpc: Allocate entire reserved memory for Audio
 PD in probe
Date: Fri, 31 Jul 2026 17:32:10 +0800
Message-Id: <20260731093210.473-1-jianping.li@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3MCBTYWx0ZWRfX3ko/e+XzFjNu
 ZULfTgwlW8jqW3EtWt4m2vxSXquX/A7qxK59NDMCl4IiRKrbP98ZJ0BnLPHPzUmZ7bkgF4L74iK
 KkTyBj1laQdEraFx6uvq0B6Dsdnt6W8=
X-Proofpoint-ORIG-GUID: avpPN-zu3B8qBMNpKEJHFQofQbb6fI-9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3MCBTYWx0ZWRfX9ipZZz9Pz//d
 hH1B/gYKUoI25EylYzypm8wVI0nSoDuT1bUMoHxoaPtWIczBrbaEesSUAqgDndqkanTv0Mu399R
 VHH3QbHYxugm5gQw4Z+06Yi3LdAB4Q85T0Kbs9QYWexXJfGQvOnKbr+0iYx/I1wRVYgRVNsvtMp
 O38Q3yyD0cJrabge9ELvXfQYLD5rDEmLI3ytfO0n25CumMFxLSMRf3lvz+LNIPSOUYewZaUUl8v
 RoaTXYBRFrR5KuoqFvf3IRDXc3ue09Wq3RE1dftXybtX04m6CKsox8H6EDsuLVfzUqL5I/LNrER
 XosAkdyTo4L+uewrNpK32riPeAn6sjC9oZd5hduiboA3WimX1tX9XWjVVqataJBBUDE8tf3OqMF
 DmR6iO8wkxv6WnbLp7L0KVwinczbXGTVdpolBvLwHx3y8o7ehbb9zlSU3prxIDgQIH2ggG8+HxX
 BO2jdlJqBE6NuyHkvoA==
X-Authority-Analysis: v=2.4 cv=c4ybhx9l c=1 sm=1 tr=0 ts=6a6c6ba3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yegpaEAI8PfkSgOXudcA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: avpPN-zu3B8qBMNpKEJHFQofQbb6fI-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310070
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

Validate the presence of the Audio PD reserved-memory region during
rpmsg probe and fail early if it is missing, so that a misconfigured
device tree is caught at probe time instead of at process creation.

Fixes: 0871561055e66 ("misc: fastrpc: Add support for audiopd")
Cc: stable@kernel.org
Signed-off-by: Jianping Li <jianping.li@oss.qualcomm.com>

Patch [v10]: https://lore.kernel.org/all/20260716095847.479-1-jianping.li@oss.qualcomm.com/

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
 drivers/misc/fastrpc.c | 137 +++++++++++++++++++----------------------
 1 file changed, 63 insertions(+), 74 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index dd51d475a74e..e054e80584a2 100644
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
@@ -1454,15 +1456,17 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
@@ -1486,31 +1490,6 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
 
@@ -1522,8 +1501,25 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
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
@@ -1541,27 +1537,11 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 
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
@@ -2090,7 +2070,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
 
-	if (req.flags != ADSP_MMAP_ADD_PAGES && req.flags != ADSP_MMAP_REMOTE_HEAP_ADDR) {
+	if (req.flags != ADSP_MMAP_ADD_PAGES) {
 		dev_err(dev, "flag not supported 0x%x\n", req.flags);
 
 		return -EINVAL;
@@ -2101,10 +2081,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
 		return -EINVAL;
 	}
 
-	if (req.flags == ADSP_MMAP_REMOTE_HEAP_ADDR)
-		err = fastrpc_remote_heap_alloc(fl, dev, req.size, &buf);
-	else
-		err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
+	err = fastrpc_buf_alloc(fl, dev, req.size, &buf);
 
 	if (err) {
 		dev_err(dev, "failed to allocate buffer\n");
@@ -2143,20 +2120,6 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
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
@@ -2584,12 +2547,22 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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
+				data->remote_heap_addr = res.start;
+				data->remote_heap_size = resource_size(&res);
+			}
 			src_perms = BIT(QCOM_SCM_VMID_HLOS);
 
 			err = qcom_scm_assign_mem(res.start, resource_size(&res), &src_perms,
@@ -2597,7 +2570,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 			if (err)
 				goto err_free_data;
 		}
-
 	}
 
 	secure_dsp = !(of_property_read_bool(rdev->of_node, "qcom,non-secure-domain"));
@@ -2681,6 +2653,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 	struct fastrpc_buf *buf, *b;
 	struct fastrpc_user *user;
 	unsigned long flags;
+	int err, i;
 
 	/* No invocations past this point */
 	spin_lock_irqsave(&cctx->lock, flags);
@@ -2698,8 +2671,24 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
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

