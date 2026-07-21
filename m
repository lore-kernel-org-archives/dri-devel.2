Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E54C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 05:03:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FD610E1DF;
	Tue, 21 Jul 2026 05:03:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="DA2qq/kB";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16CB710E1DF
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 05:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=mv/cq8waz8AeeO/pBWTo132KEtTLoxQvFQlCFigMDs0=; b=DA2qq/kBW6IgwB0dUynBzHd/N3
 BIDFfMTrKlid4CAsWfywu5Gw7q7GGq0qI4yxliJ8a/9nPUE6TxhMj2QXfO2rx9bsKlAVdVPQLPrFe
 WLdgHLtTxPrVmjp2KOXYSRO+WR5zYQonMef1wto3QlCboR6Mh4fwBHHfGZxL9xL8nKU/XxO9c4Y44
 CTGKIlGNBPYfEQzeSfRYrvE2wkNNqZPtdfUXxeLjC1zgv9lbXwQfqY5tv1u4rTq2uTSWOgHbRlxNG
 G+M3klGYy3ewvC1rNatWOenLPzQ00OFs7TEkYmxb0KFwACSG7dAJ60LUI9X4SoDBgrkrkcvMCd/k3
 O17j/IJQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
 id 1wm2d8-00000008PTB-3x3Y; Tue, 21 Jul 2026 05:02:58 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v3] accel: Arm Ethos-U NPU: fix most uapi kernel-doc warnings
Date: Mon, 20 Jul 2026 22:02:57 -0700
Message-ID: <20260721050257.3546073-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Use correct struct names, struct member names, and kernel-doc
format to resolve most kernel-doc warnings:

Warning: include/uapi/drm/ethosu_accel.h:87 expecting prototype for struct drm_ethosu_gpu_info. Prototype was for struct drm_ethosu_npu_info instead
Warning: include/uapi/drm/ethosu_accel.h:178 expecting prototype for struct drm_ethosu_wait_bo. Prototype was for struct drm_ethosu_bo_wait instead
Warning: include/uapi/drm/ethosu_accel.h:214 struct member 'cmd_bo' not described in 'drm_ethosu_job'
Warning: include/uapi/drm/ethosu_accel.h:214 struct member 'sram_size' not described in 'drm_ethosu_job'
Warning: include/uapi/drm/ethosu_accel.h:214 struct member 'region_bo_handles' not described in 'drm_ethosu_job'
Warning: include/uapi/drm/ethosu_accel.h:230 struct member 'jobs' not described in 'drm_ethosu_submit'
Warning: include/uapi/drm/ethosu_accel.h:230 struct member 'job_count' not described in 'drm_ethosu_submit'
Warning: include/uapi/drm/ethosu_accel.h:230 struct member 'perfmon_id' not described in 'drm_ethosu_submit'
Warning: include/uapi/drm/ethosu_accel.h:274 struct member 'flags' not described in 'drm_ethosu_perfmon_set_global'
Warning: include/uapi/drm/ethosu_accel.h:274 struct member 'id' not described in 'drm_ethosu_perfmon_set_global'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend
v3: rebase & resend

Cc: Rob Herring <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

 include/uapi/drm/ethosu_accel.h |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- linux-next-20260720.orig/include/uapi/drm/ethosu_accel.h
+++ linux-next-20260720/include/uapi/drm/ethosu_accel.h
@@ -65,7 +65,7 @@ enum drm_ethosu_dev_query_type {
 };
 
 /**
- * struct drm_ethosu_gpu_info - NPU information
+ * struct drm_ethosu_npu_info - NPU information
  *
  * Structure grouping all queryable information relating to the NPU.
  */
@@ -80,10 +80,12 @@ struct drm_ethosu_npu_info {
 #define DRM_ETHOSU_VERSION_MINOR(x)		(((x) >> 4) & 0xff)
 #define DRM_ETHOSU_VERSION_STATUS(x)		((x) & 0xf)
 
-	/** @gpu_rev: GPU revision. */
+	/** @config: NPU revision. */
 	__u32 config;
 
+	/** @sram_size: NPU SRAM size (KB) */
 	__u32 sram_size;
+	/** @pmu_counters: number of performance counters */
 	__u32 pmu_counters;
 };
 
@@ -165,7 +167,7 @@ struct drm_ethosu_bo_mmap_offset {
 };
 
 /**
- * struct drm_ethosu_wait_bo - ioctl argument for waiting for
+ * struct drm_ethosu_bo_wait - ioctl argument for waiting for
  * completion of the last DRM_ETHOSU_SUBMIT on a BO.
  *
  * This is useful for cases where multiple processes might be
@@ -173,9 +175,12 @@ struct drm_ethosu_bo_mmap_offset {
  * completed.
  */
 struct drm_ethosu_bo_wait {
+	/** @handle: BO handle */
 	__u32 handle;
+	/** @pad: Reserved, must be zero. */
 	__u32 pad;
-	__s64 timeout_ns;	/* absolute */
+	/** @timeout_ns: Absolute timeout in ns. */
+	__s64 timeout_ns;
 };
 
 struct drm_ethosu_cmdstream_bo_create {
@@ -203,14 +208,14 @@ struct drm_ethosu_cmdstream_bo_create {
  * sequentially on the same core, to benefit from memory residency in SRAM.
  */
 struct drm_ethosu_job {
-	/** Input: BO handle for cmdstream. */
+	/** @cmd_bo: Input: BO handle for cmdstream. */
 	__u32 cmd_bo;
 
-	/** Input: Amount of SRAM to use. */
+	/** @sram_size: Input: Amount of SRAM to use. */
 	__u32 sram_size;
 
 #define ETHOSU_MAX_REGIONS	8
-	/** Input: Array of BO handles for each region. */
+	/** @region_bo_handles: Input: Array of BO handles for each region. */
 	__u32 region_bo_handles[ETHOSU_MAX_REGIONS];
 };
 
@@ -220,13 +225,13 @@ struct drm_ethosu_job {
  * The kernel will schedule the execution of these jobs in dependency order.
  */
 struct drm_ethosu_submit {
-	/** Input: Pointer to an array of struct drm_ethosu_job. */
+	/** @jobs: Input: Pointer to an array of struct drm_ethosu_job. */
 	__u64 jobs;
 
-	/** Input: Number of jobs passed in. */
+	/** @job_count: Input: Number of jobs passed in. */
 	__u32 job_count;
 
-	/** Input: Id returned by DRM_ETHOSU_PERFMON_CREATE */
+	/** @perfmon_id: Input: perfmon ID */
 	__u32 perfmon_id;
 };
 
