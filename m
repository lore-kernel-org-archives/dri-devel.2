Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AC0606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i+gxsG+Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADD1D10E654;
	Wed, 18 Nov 2026 02:07:37 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7DC10E654
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 02:07:31 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-378915168c7so4740eec.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794967651; x=1795572451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4XYNeMt6VNMRAiLe5EbRBvBhMDIpn29m4tUHZ+DRyz0=;
 b=i+gxsG+YiDPyLmMc2Ho4pvu1FHm+1E3lK0tr27jR5mCw9vcQi+rIGnpXZMMxYMqj7n
 y7CaRi8vI59U5fGSolNyzXMDu/VbCVK3CXDRemNkvDS3k9zx57L2wq7cdlN/R72ncbHO
 UNAoNNZbV2K9gsVVoN2k7OZ/RHfd6Nv7q2IurwV/Rx2/jGq8HoO11NQSWIGrN8hO0mR5
 VfY/XC/Fx1oCg5yAplon3vi6IAb3AZ6fOkxGQpuDjxAdh29KPnTSfC2oBF/xZ4Uhd3I7
 HmqprVOhYovxFuIX1+w2TaDCnTHBb2igC0umwuQcGbtkV6FZ67MF66vB+JhpgclTkffJ
 WKrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794967651; x=1795572451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4XYNeMt6VNMRAiLe5EbRBvBhMDIpn29m4tUHZ+DRyz0=;
 b=av8uuH+PfHHLlUGVITzc/YjXfzD4n4mxzjIIQIgDW0EDgy45RegTLXroVLnwDsmH3Z
 dCu1xVL+s3P+33ooqhkLPYW7+FkKvQf5L8UOcKcCKwbCsyTM68VWIGF/KTW9rZCq0WQv
 9oa1rvd0ikfMI7QIN/QJNswisAa4mjvsVEX9nWjnwtMNNuzejzpE1GjLylkZeH+z4eVb
 L8RBbj9+x2XO1jgKwC9Wf2+0lRtoz9hguTBacs7Nt2lY9S7i9JS6MDjg4Pin6hPC6NVw
 Yviby3dceebJVvTWEympZknqMuQin1FM02Pl0h62BDmeBF3Bnd6gb4n0DJP+GpG3j36O
 M+eQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHqRNlDLCIGY0poKLaXvPDY0MwILLUtdR0cOAmE5z53+XtC5bu5bsaOMtmPuJqWx9U/Av0WS6n7sXk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+urm05DFkiJZdUA2bFHiObboTDj8v8fBNtnCehZhBkLLTEgBcD
 BTaF94ztOeBZGAonlYVSh/i4DbGx7n2hlUYgJDQRjPxfU9/BclpFlGM7
X-Gm-Gg: AYBFou21x19S9QnUYbM+m1EyJM16hraonY2cT1wTEUi9XUIFPHNbk8wttJqt3FpAgPB
 FC6qNwj1+F0vHzfc3A4c1uMEDkIebzXeHWM1X8hVYj1qYdIY5yxtzxxcWyTvIoaT7DHnXolnY3I
 0AduYAySQ7VOAUWuy6qs52vkmDnkX7xJLeSaUu7/bkcTG/iUNkSCPUU87m3oYHfIzOLfmeaom6V
 OczhWvbFEt8XDhbMNBgqIRKOW0IlGCBnRenWrQ5p5zzZaoTjp+cZvZGyokvhf3MyshSJvjs8Shf
 VglJ4T5Bi6zO6e8l1EYmEJlKaVrh7xmvmjJVy/ZDROBkfu60eVgC3XInWhJsGOVo61Wpyt8tSxm
 7527VAtyZO4106pmNknmcUzt1SQjexfS41LdKN1qEFqPyZPcu6wxrsWdCeDK2143ieKTBSMoeL2
 JGxdkRCGf18TGUpafkbF/vKrksP3sG/Ha/i5cw7Le9jCuwRC+/dQPQnafbTLgUycUTLq5uHTPAa
 EYnZS+D0hi8x2l+d/WiJsklNzlzFCzgcTot9Soc6Fq2hnaT9ufDJBuRBl5SZaPBQ1RfKJnB4mWI
 rlIBgqdWzqu9i0oyRluw3jMMHuXDoBc6K6AF5QCX/Z99DSuf9KiDFSsbFJWXo7NUGYdFTWtfOwB
 vlJ7zKog=
X-Received: by 2002:a05:7022:698b:b0:1b2:5884:a039 with SMTP id
 a92af1059eb24-1b543a1715bmr2662340c88.0.1794967651150; 
 Tue, 17 Nov 2026 18:07:31 -0800 (PST)
Received: from DESKTOP-CJ1L666.dankook.ac.kr ([220.149.255.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b544784008sm2862327c88.5.2026.11.17.18.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 18:07:30 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Julius Bairaktaris <julius@bairaktaris.de>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: [PATCH v4 1/5] drm/msm: Wait for VM_BIND jobs in msm_gem_vm_close()
Date: Wed, 18 Nov 2026 11:07:12 +0900
Message-ID: <20261118020716.1698-2-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118020716.1698-1-arpe1618@gmail.com>
References: <20261118020716.1698-1-arpe1618@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

msm_gem_vm_close() waits for vm->last_fence before it tears down the
VM's scheduler and its remaining mappings, but only submits add their
fences to it. msm_submitqueue_close() flushes the VM_BIND entities
first, but drm_sched_entity_flush() gives up after
MAX_WAIT_SCHED_ENTITY_Q_EMPTY when the process is exiting, or on a
fatal signal, and a queue that was closed earlier with
DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE is not flushed at all. A VM_BIND job
that is then still waiting for its dependencies is not waited for, so
its pgtable updates can still be pending, and the job still queued on
its entity, when the scheduler is torn down.

Add the fences of VM_BIND jobs to vm->last_fence as well, as
submit_attach_object_fences() does for submits, but keep the previous
fence if dma_fence_unwrap_merge() fails. As for submits,
msm_gem_vm_close() waits for these fences without a timeout and
uninterruptibly, so closing the file now also waits for the
dependencies of the queued VM_BIND jobs.

This does not cover a job that is killed, e.g. on SIGKILL while the
process exits: the scheduler signals the fence of such a job before it
frees the job, and the free can drop the last reference to the queue.
That is fixed by "drm/msm: Destroy the VM_BIND entity when its queue is
closed".

This was found with an AI coding assistant, which also drafted this
patch and its changelog. It has not been reproduced, and the change
has only been compile-tested.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Cc: stable@vger.kernel.org
Suggested-by: Rob Clark <robin.clark@oss.qualcomm.com>
Link: https://lore.kernel.org/r/CACSVV00ZppfBKwsHJ+NBYBB7a2f3g1O=6J4Gt1m_A74fudZQoQ@mail.gmail.com
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---
As for submits, a VM_BIND job whose in-fence does not signal now keeps
msm_gem_vm_close() waiting, uninterruptibly.

submit_attach_object_fences() drops vm->last_fence when
dma_fence_unwrap_merge() fails. This patch keeps the previous fence for
VM_BIND jobs instead, and leaves the submit path as it is.

 drivers/gpu/drm/msm/msm_gem_vma.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 8b702422030a..2f0698df1a9a 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -6,6 +6,7 @@
 
 #include "drm/drm_file.h"
 #include "drm/msm_drm.h"
+#include "linux/dma-fence-unwrap.h"
 #include "linux/file.h"
 #include "linux/sync_file.h"
 
@@ -1443,7 +1444,7 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	struct msm_syncobj_post_dep *post_deps = NULL;
 	struct drm_syncobj **syncobjs_to_reset = NULL;
 	struct sync_file *sync_file = NULL;
-	struct dma_fence *fence;
+	struct dma_fence *fence, *last_fence;
 	int out_fence_fd = -1;
 	int ret, nr_bos = 0;
 	unsigned i;
@@ -1586,6 +1587,17 @@ msm_ioctl_vm_bind(struct drm_device *dev, void *data, struct drm_file *file)
 	msm_syncobj_reset(syncobjs_to_reset, args->nr_in_syncobjs);
 	msm_syncobj_process_post_deps(post_deps, args->nr_out_syncobjs, fence);
 
+	/*
+	 * Let msm_gem_vm_close() wait for the job, as it does for submits.
+	 * The VM's resv, which protects last_fence, is still locked here.
+	 * If the merge fails, keep waiting for the previous fence at least.
+	 */
+	last_fence = dma_fence_unwrap_merge(fence, to_msm_vm(vm)->last_fence);
+	if (last_fence) {
+		dma_fence_put(to_msm_vm(vm)->last_fence);
+		to_msm_vm(vm)->last_fence = last_fence;
+	}
+
 	dma_fence_put(fence);
 
 out:
-- 
2.43.0

