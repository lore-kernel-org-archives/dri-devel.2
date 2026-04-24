Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD907FED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:28:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2694310F660;
	Fri, 24 Apr 2026 17:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="pZxxmov2";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9530310E0B6
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 17:28:08 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OG3iOH275744; Fri, 24 Apr 2026 18:27:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=a
 2TYZdUNJ6OxzgTGpbG7PpBhsV6LeoTIB5SQIKM3Wcg=; b=pZxxmov2NAKrqSXDu
 S9iPjrEhWjQPBKAi+7arPFUIzbP1EqYpI85a9uCN0N7Qws4RBhlu5xuBSyn1gq1g
 FRHr9KQ0PyLrbJJ9Vlg54iehlbbPmIu4K06H6SyuPVUDuBfIthCr2PtFnpjDK8oC
 FLdrRFbAQ+2stoYsQJRqLsv44xMwDJj+aRhg1b+Su/TyY7C8CN/Qxkho3w5fJCRF
 YvkTWqE2LDASTVs77T2qPtm09qpewrtC/stJqCG4I2Z/I3iMHLmtIOvxjxPs+qjg
 iiTq6s+JR8EkmjcQolw8I9uo4aiHRnVu8Vmoja9ROIoyCABGCOKxPY0hEkyaFEGz
 /Fnwg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4drbq401rv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Apr 2026 18:27:50 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.248) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 24 Apr
 2026 18:27:47 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 24 Apr 2026 22:57:33 +0530
Subject: [PATCH v2 1/2] drm/imagination: Fix segfault when updating ftrace mask
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260424-ftrace_fix-v2-1-50146ff526d5@imgtec.com>
References: <20260424-ftrace_fix-v2-0-50146ff526d5@imgtec.com>
In-Reply-To: <20260424-ftrace_fix-v2-0-50146ff526d5@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777051664; l=3744;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=iI4pzedBFuc1gdGmNvqBIOmod0AVVzIXCWdqln1KXCM=;
 b=nYrRDeyHjdPMCYBmQZYhMTFcJ8ZxGdWmVCrciDGK4X6nvkBn6DTQoFKaNYudPCk3J6euezpLc
 3HsPpGHZA0sA//MqIM6BEak57F+gH0/UrjtyO7ZAE2XxdRWQ07sZcOc
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.248]
X-Authority-Analysis: v=2.4 cv=EIs2FVZC c=1 sm=1 tr=0 ts=69eba816 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=GONi4oyU4xsA:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=fGhLjsSNAAAA:8 a=r_1tXGB3AAAA:8 a=vXDThwzsE87Lt0EVRWoA:9 a=QEXdDO2ut3YA:10
 a=LYKFdyShAPKLkGq8p7WX:22 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: IuxKx0HifkfcNdKGD2Mcxn-p22IVvaZM
X-Proofpoint-ORIG-GUID: IuxKx0HifkfcNdKGD2Mcxn-p22IVvaZM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE2OSBTYWx0ZWRfXzqBpMZJlh2sc
 uVdp0/sd8bygcUeCf/ZYDTES4754F2A4WCsj9YoGkNhTjWNii2SbW/Prcu2yjo2SEiErARAYwVv
 nKNfJED9XiPAtaRevmapTLbl5wQKOQkxKfK+tUnqNgBN5bmrrZ2rGJNfvW3O9jPrDEcOU56AQNd
 GiDJrJFC4ptukb0qM261KvUFH64uekOvs5xfOreRWfQjocmTcIbtPGsKUSKgJPUmV2Hqzzzd9ki
 +VG0Y7/5/8Kvr+yMkhQSqjaOIyTBdrqpYEYux0GzXx0F6SbCcVZ12rQY4AQcJXfE1lM7byrAQEN
 fc1FbeBmMFFYuRhBA0weLCUswmmbZ7Qv69sXrG1NgkjVXZM3+f1463oc1OKrPz6qrT3yrpjMFm9
 WDFhUV+VKYXDTFgZNNcIFyQDphsIayayBlE8jiWqctmUUhwlz2wgh4QuYBBn0ryjm1VjpQFMhrh
 TK6reCOZ5wCzaiwH9LQ==
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

Fix invalid data access by passing right data for debugfs entry.

[  171.549793] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[  171.559248] Mem abort info:
[  171.562173]   ESR = 0x0000000096000044
[  171.566227]   EC = 0x25: DABT (current EL), IL = 32 bits
[  171.573108]   SET = 0, FnV = 0
[  171.576448]   EA = 0, S1PTW = 0
[  171.579745]   FSC = 0x04: level 0 translation fault
[  171.584760] Data abort info:
[  171.588012]   ISV = 0, ISS = 0x00000044, ISS2 = 0x00000000
[  171.593734]   CM = 0, WnR = 1, TnD = 0, TagAccess = 0
[  171.598962]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[  171.604471] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000083837000
[  171.611358] [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
[  171.618500] Internal error: Oops: 0000000096000044 [#1]  SMP
[  171.624222] Modules linked in: powervr drm_shmem_helper drm_gpuvm...
[  171.656580] CPU: 0 UID: 0 PID: 549 Comm: bash Not tainted 7.0.0-rc2-g730b257ba723-dirty #13 PREEMPT
[  171.665773] Hardware name: BeagleBoard.org BeaglePlay (DT)
[  171.671296] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  171.678306] pc : pvr_fw_trace_mask_set+0x78/0x154 [powervr]
[  171.683959] lr : pvr_fw_trace_mask_set+0x4c/0x154 [powervr]
[  171.689593] sp : ffff8000835ebb90
[  171.692929] x29: ffff8000835ebc00 x28: ffff000005c60f80 x27: 0000000000000000
[  171.700130] x26: 0000000000000000 x25: ffff00000504af28 x24: 0000000000000000
[  171.707324] x23: ffff00000504af50 x22: 0000000000000203 x21: 0000000000000000
[  171.714518] x20: ffff000005c44a80 x19: ffff000005c457b8 x18: 0000000000000000
[  171.721715] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaaae8887580
[  171.728908] x14: 0000000000000000 x13: 0000000000000000 x12: ffff8000835ebc30
[  171.736095] x11: ffff00000504af2a x10: ffff00008504af29 x9 : 0fffffffffffffff
[  171.743286] x8 : ffff8000835ebbf8 x7 : 0000000000000000 x6 : 000000000000002a
[  171.750479] x5 : ffff00000504af2e x4 : 0000000000000000 x3 : 0000000000000010
[  171.757674] x2 : 0000000000000203 x1 : 0000000000000000 x0 : ffff8000835ebba0
[  171.764871] Call trace:
[  171.767342]  pvr_fw_trace_mask_set+0x78/0x154 [powervr] (P)
[  171.772984]  simple_attr_write_xsigned.isra.0+0xe0/0x19c
[  171.778341]  simple_attr_write+0x18/0x24
[  171.782296]  debugfs_attr_write+0x50/0x98
[  171.786341]  full_proxy_write+0x6c/0xa8
[  171.790208]  vfs_write+0xd4/0x350
[  171.793561]  ksys_write+0x70/0x108
[  171.796995]  __arm64_sys_write+0x1c/0x28
[  171.800952]  invoke_syscall+0x48/0x10c
[  171.804740]  el0_svc_common.constprop.0+0x40/0xe0
[  171.809487]  do_el0_svc+0x1c/0x28
[  171.812834]  el0_svc+0x34/0x108
[  171.816013]  el0t_64_sync_handler+0xa0/0xe4
[  171.820237]  el0t_64_sync+0x198/0x19c
[  171.823939] Code: 32000262 b90ac293 1a931056 9134e293 (b9000036)
[  171.830073] ---[ end trace 0000000000000000 ]---

Fixes: a331631496a0 ("drm/imagination: Simplify module parameters")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_fw_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_fw_trace.c b/drivers/gpu/drm/imagination/pvr_fw_trace.c
index e154cb35f604..6193811ef7be 100644
--- a/drivers/gpu/drm/imagination/pvr_fw_trace.c
+++ b/drivers/gpu/drm/imagination/pvr_fw_trace.c
@@ -558,6 +558,6 @@ pvr_fw_trace_debugfs_init(struct pvr_device *pvr_dev, struct dentry *dir)
 				    &pvr_fw_trace_fops);
 	}
 
-	debugfs_create_file("trace_mask", 0600, dir, fw_trace,
+	debugfs_create_file("trace_mask", 0600, dir, pvr_dev,
 			    &pvr_fw_trace_mask_fops);
 }

-- 
2.43.0

