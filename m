Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDB1606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Aivk3xom
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A70810E833;
	Wed,  4 Nov 2026 18:25:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C013D10E5F5
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 18:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793816724; x=1825352724;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wgn+6fgfXqn11aO7kEGszzMbNYa+lu4A164Y1GawPkA=;
 b=Aivk3xomTWDcfiCMSkUVeYvf7/EaKlRl4mTJQDAVvieX65D14yLUst3G
 B6j1ZzdciZOEYYqVKQJblCeBjg2qGuBwras8fSModgMOkovspeaYwKfy+
 kr6Chf1bxUF2x6gwirTg4QHaJzK75yjY+x/zkprNl0n6eJo3fTqB8ioVN
 l0Wjog9HPU93NBNefhmmkCQTNtdgPYveTjLr8ugF4Hdn4k/tYjZ4PCqth
 omLeQ9znJg7HIbiwiDxOw3SyUv0wilyID0hocwlIHGbvAlMWYA7XXXAFg
 DAjiDE26AJmlw/9ttk2b+JQXj4mcMQM/6cWRmH1WQ0wAJXVxUyNMagRdd w==;
X-CSE-ConnectionGUID: SHZuJUgjR4enYEruQ6w4Yg==
X-CSE-MsgGUID: b/VkvqFdTKWW0ij6BabyOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2459177"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2459177"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:25:23 -0800
X-CSE-ConnectionGUID: OFx3f3m6ROKuhR8RN/LtlQ==
X-CSE-MsgGUID: JB5OhQ1cSnO5RGgCtr++hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7186520"
Received: from pl-npu-pc-kwachow.igk.intel.com ([10.91.220.239])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 10:25:22 -0800
From: Karol Wachowski <karol.wachowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com, dawid.osuchowski@linux.intel.com,
 Karol Wachowski <karol.wachowski@linux.intel.com>
Subject: [PATCH v2] accel/ivpu: Limit SSIDs to 128 on all generations
Date: Wed,  4 Nov 2026 19:25:15 +0100
Message-ID: <20261104182515.3198239-1-karol.wachowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some generations support only 128 SSIDs, while the KMD configured 256
CD table entries and allowed user contexts up to SSID 130. Align the
limit across all generations.

Limit the CD table to 128 entries and the user SSID range to 2-127, so
root can create 126 contexts and non-root users 64. Also fix the off by
one SSID bounds checks against the CD table size.

Before this patch the driver allowed 128 user contexts. Now the limit
is 128 SSIDs in total, which leaves 126 user contexts, so the only cost
is 2 contexts for root. Non-root users keep 64. In return the SSID
range, the CD table size and the bounds checks all match, testing gets
simpler because exact limits can be checked instead of loose minimums,
and the userspace interface is consistent with the same limits on all
generations.

Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
---
v1: https://lore.kernel.org/all/20261104082920.859706-1-karol.wachowski@linux.intel.com/

v2:
- Explain in the commit message why the limit is applied to all
  generations: it costs only 2 contexts for root (128 -> 126), simplifies
  testing and makes the userspace interface consistent (Jeff)

 drivers/accel/ivpu/ivpu_drv.c | 2 +-
 drivers/accel/ivpu/ivpu_drv.h | 3 ++-
 drivers/accel/ivpu/ivpu_mmu.c | 6 +++---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 475c4255c10b..28cb18dcfa9b 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -127,7 +127,7 @@ static struct ivpu_user_limits *ivpu_user_limits_alloc(struct ivpu_device *vdev,
 		limits->max_ctx_count = ivpu_get_context_count(vdev);
 		limits->max_db_count = ivpu_get_doorbell_count(vdev);
 	} else {
-		limits->max_ctx_count = ivpu_get_context_count(vdev) / 2;
+		limits->max_ctx_count = IVPU_NON_ROOT_USER_MAX_CONTEXTS;
 		limits->max_db_count = ivpu_get_doorbell_count(vdev) / 2;
 	}
 
diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 8684e5814d4f..13f24b0ada26 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -38,7 +38,8 @@
 /* SSID 1 is used by the VPU to represent reserved context */
 #define IVPU_RESERVED_CONTEXT_MMU_SSID 1
 #define IVPU_USER_CONTEXT_MIN_SSID     2
-#define IVPU_USER_CONTEXT_MAX_SSID     (IVPU_USER_CONTEXT_MIN_SSID + 128)
+#define IVPU_USER_CONTEXT_MAX_SSID     127
+#define IVPU_NON_ROOT_USER_MAX_CONTEXTS 64
 
 #define IVPU_MIN_DB 1
 #define IVPU_MAX_DB 255
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index c846499d96ce..1df690b0fd78 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -65,7 +65,7 @@
 #define IVPU_MMU_IDR5_REF_FPGA		0x00800075
 
 #define IVPU_MMU_CDTAB_ENT_SIZE		64
-#define IVPU_MMU_CDTAB_ENT_COUNT_LOG2	8 /* 256 entries */
+#define IVPU_MMU_CDTAB_ENT_COUNT_LOG2	7 /* 128 entries */
 #define IVPU_MMU_CDTAB_ENT_COUNT	((u32)1 << IVPU_MMU_CDTAB_ENT_COUNT_LOG2)
 
 #define IVPU_MMU_STREAM_ID0		0
@@ -700,7 +700,7 @@ static int ivpu_mmu_cdtab_entry_set(struct ivpu_device *vdev, u32 ssid, u64 cd_d
 	u64 cd[4];
 	int ret = 0;
 
-	if (ssid > IVPU_MMU_CDTAB_ENT_COUNT)
+	if (ssid >= IVPU_MMU_CDTAB_ENT_COUNT)
 		return -EINVAL;
 
 	entry = cdtab->base + (ssid * IVPU_MMU_CDTAB_ENT_SIZE);
@@ -918,7 +918,7 @@ int ivpu_mmu_disable_ssid_events(struct ivpu_device *vdev, u32 ssid)
 	u64 *entry;
 	u64 val;
 
-	if (ssid > IVPU_MMU_CDTAB_ENT_COUNT)
+	if (ssid >= IVPU_MMU_CDTAB_ENT_COUNT)
 		return -EINVAL;
 
 	mutex_lock(&mmu->lock);
-- 
2.43.0

