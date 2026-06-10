Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B560BCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 12:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C33C10E5FD;
	Wed, 10 Jun 2026 12:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="BsWvhz/A";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F2010E5FD
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 12:45:15 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65AC6k0p4086133; Wed, 10 Jun 2026 13:44:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=NS0To7Ea+VUeYW7eeCV6kw2
 23EygU1pFTVNe4d2KUxM=; b=BsWvhz/AgsC4fc72uYWigO+TQAj57/g9u518R6B
 JDc0Zv390jEiJnUOVaayPxovAUNvz1DhkulmdlBEsvkiVrf8fsM5asIfOvCG3Dnz
 cxxPl7e8fASjVNmsa3Vmbki5l94V7vpz2WbagZwZaURdghNHJFVJDWKJFfEM3cHp
 jJLWka68UTFci6NldkcdGDLhmcQU4/QkCL3tVH9+ThF35691fsMsw1+xT4CNTBlj
 Gy/oH9dT/UxMHcF+yIONViu5nYoPZKfZ+pOTn9iihTD5W76vdiDpr9ayHh0AtmgU
 mgTlzlhSbGiZbHtFrX59D+PvWzmBR2Rh6EJN5dfgtxdl6Ig==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4epwppgh14-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 10 Jun 2026 13:44:55 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 10 Jun
 2026 13:44:50 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Wed, 10 Jun 2026 18:13:49 +0530
Subject: [PATCH] drm/imagination: Fix double call to
 drm_sched_entity_fini()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260610-b4-sched_fix-v1-1-c5977a6e0b4c@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAARcKWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0MD3SQT3eLkjNSU+LTMCt3EZOMkSyODNBNz0yQloJaColSgMNi46Nj
 aWgBS+Ce8XgAAAA==
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Alessio Belle <Alessio.Belle@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Brajesh Gupta" <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781095490; l=4473;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=FPEgBDQmk0ZKgiBX6coNPv2NaTbvRcCutPD7evRdzSA=;
 b=NUQnIBpRElBvX9VwXcO2T9s27jp4MDkk4SzWf0hbOvUpCI+1jRJw5QzLbxG5mwGBsT7ZS46qf
 eZ/qeo+6RidB3PehGqbMwSrUY9dZqm/WlVjJA/PAQm3e1xltLBAmEdm
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.214]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEyMSBTYWx0ZWRfXzW+oqi53HALB
 h3x9VIko+O8RVYuovAztgLWbELCVF7ykh5TLg4vbfTUHmbZno8pvaQlf2Nxqyz5MEY3wdnSk/bq
 1YKSkOH7KlZb82Qel8/sM8KvyZR8hySCKhYx8uEFq2ppesKilQEXhlQuDh1PZ0RCn8VEVmIV6Z8
 e+b/iZj0idPJy/z/er4+g5uJZXxboEdLfdQ2QZtCAnc3SxSmLgTe1PoZQAi9oIx+5jIsmVenB+5
 PTbmVd0fyIEfrp8F5awfNTSrx088ax/snGHy9FBstBEKn5Pi6bcFZu6z3eDBFI0z1j2RfS6Wqi3
 dk4KtNsg3rgaOxqXa3txTR1P6rnQlFUq/r3UPbiFWIb4+vSVf+YQPftIQwPmyjMMKgnlRHf7DaT
 SZLvfled31qV3OxlksNrAYy6S0sQKQ4a/tIL13s3otiOTa4KLn2Eh5lZmpLwDZWOIfbQcj9L8ay
 4lw/MuItvsjZQCgs9aA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDEyMSBTYWx0ZWRfXxHExcgGyxcE+
 0yA01O4tqrO8xg/5La+LD31WwRib5xltvIjVpcGVumli7ecYiUoVE+YWaQ2XrOIa3ghbHnDxn3u
 I4CWuX8az7SPl7HtWD8EfsqD8xKNac4=
X-Proofpoint-GUID: 7CM2rIOBs604G0SQuPoArEpkByZCJivL
X-Authority-Analysis: v=2.4 cv=K5oS2SWI c=1 sm=1 tr=0 ts=6a295c47 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=aRQ8HefCnzIA:10 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=yZv0BYdqcVMJ2680O0wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: 7CM2rIOBs604G0SQuPoArEpkByZCJivL
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

Call sequence of double call:
pvr_context_destroy
  pvr_context_kill_queues
    pvr_queue_kill
      drm_sched_entity_destroy
        drm_sched_entity_fini // here
  pvr_context_put
    kref_put(..., pvr_context_release)
      pvr_context_destroy_queues
        pvr_queue_destroy
          drm_sched_entity_fini // here

Call to drm_sched_entity_destroy() from pvr_context_kill_queues() calls
drm_sched_entity_flush() + drm_sched_entity_fini().
drm_sched_entity_flush() ensures all pending jobs are completed and
drm_sched_entity_fini() ensures no further submission is allowed as
per expectation from pvr_context_kill_queues(). Drop the extra
call to drm_sched_entity_fini().

Stack trace for issue with addition of refcounting for DRM entity
stats in commit fd177135f0e6 ("drm/sched: Account entity GPU time"):
[  789.490527] ------------[ cut here ]------------
[  789.490559] refcount_t: underflow; use-after-free.
[  789.490657] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0xf4/0x144, CPU#0: kworker/u16:1/440
[  789.490695] Modules linked in: powervr drm_gpuvm drm_exec gpu_sched drm_shmem_helper xhci_plat_hcd xhci_hcd dwc3 usbcore usb_common snd_soc_simple_card snd_soc_simple_card_utils sa2ul sha512 sha256 dwc3_am62 sha1 authenc rti_wdt libsha512 at24 sch_fq_codel fuse dm_mod ipv6
[  789.490798] CPU: 0 UID: 0 PID: 440 Comm: kworker/u16:1 Not tainted 7.0.0-rc7-02049-g5e2c0700091b #22 PREEMPT
[  789.490809] Hardware name: Texas Instruments AM625 SK (DT)
[  789.490815] Workqueue: powervr-sched pvr_queue_fence_release_work [powervr]
[  789.490868] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  789.490876] pc : refcount_warn_saturate+0xf4/0x144
[  789.490884] lr : refcount_warn_saturate+0xf4/0x144
[  789.490892] sp : ffff8000822cbcc0
[  789.490895] x29: ffff8000822cbcc0 x28: 0000000000000000 x27: 0000000000000000
[  789.490909] x26: 0000000000000000 x25: ffff800081b1e338 x24: ffff000004541405
[  789.490922] x23: ffff000004bea950 x22: ffff00000042e400 x21: ffff000007123e30
[  789.490935] x20: ffff000007123000 x19: ffff000007a80d50 x18: fffffffffffe7768
[  789.490948] x17: 74736574202c6e6f x16: 697461746e656d65 x15: ffff800081b269f0
[  789.490962] x14: 0000000000000030 x13: ffff800081b26a70 x12: 0000000000000211
[  789.490975] x11: 00000000000000c0 x10: 0000000000000b50 x9 : ffff8000822cbb30
[  789.490988] x8 : ffff0000014e7bb0 x7 : ffff00007725e780 x6 : 0000000372a05f49
[  789.491001] x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000010
[  789.491013] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000014e7000
[  789.491027] Call trace:
[  789.491032]  refcount_warn_saturate+0xf4/0x144 (P)
[  789.491043]  drm_sched_entity_fini+0x164/0x18c [gpu_sched]
[  789.491081]  pvr_queue_destroy+0x64/0x134 [powervr]
[  789.491110]  pvr_context_destroy_queues+0x34/0x64 [powervr]
[  789.491138]  pvr_context_release+0x70/0xac [powervr]
[  789.491166]  pvr_context_put.part.0+0x5c/0x7c [powervr]
[  789.491193]  pvr_context_put+0x14/0x24 [powervr]
[  789.491221]  pvr_queue_fence_release_work+0x20/0x38 [powervr]
[  789.491249]  process_one_work+0x160/0x4c4
[  789.491264]  worker_thread+0x188/0x310
[  789.491276]  kthread+0x130/0x13c
[  789.491287]  ret_from_fork+0x10/0x20
[  789.491300] ---[ end trace 0000000000000000 ]---

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
Fixes: eaf01ee5ba28 ("drm/imagination: Implement job submission and scheduling")
References: fd177135f0e6 ("drm/sched: Account entity GPU time")
---
 drivers/gpu/drm/imagination/pvr_queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 7ed60e1c1a86..c163f8da2106 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -1453,7 +1453,6 @@ void pvr_queue_destroy(struct pvr_queue *queue)
 	mutex_unlock(&queue->ctx->pvr_dev->queues.lock);
 
 	drm_sched_fini(&queue->scheduler);
-	drm_sched_entity_fini(&queue->entity);
 
 	if (WARN_ON(queue->last_queued_job_scheduled_fence))
 		dma_fence_put(queue->last_queued_job_scheduled_fence);

---
base-commit: 61de054a772a1feda6364931ab1baf9038abf1c8
change-id: 20260610-b4-sched_fix-ac3b920f475b

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

