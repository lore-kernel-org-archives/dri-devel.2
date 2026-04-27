Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F2AFF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DE5C10E8CE;
	Mon, 27 Apr 2026 18:41:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="zZ2TnrJt";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5877E10E8CE
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=tKFjVU+J+YR0H4z/pWtJPVpnt8Lv9io4o0Njdlbzr6s=; b=zZ2TnrJtfh8aucZ8JMdrZiJO0b
 ky0vZmdvYCudxfmfilVbSli/BDHiRFdDGGf9X00wotHRB8ScpKwDf/FKKPtq2Ygf50xRsCylyUL55
 qYviv3V/gxChxCTfsN3KakeKwsbKPvqKq9OjUHp6fL8Y3SFk15OZYMb4opwhfXUw2suMW2p0syeUh
 3MwLAuI+TKLJi+1JYdiFyQpkLvxxfnqn4G1q4W3tBf8Ph+dclMjphghkXdYzRUNnZEzehxX/wGWDJ
 RMSs0oblj37ySePSmjJG/BLJYMpfGLmg4uyW7m2BRyRKmi2Zqacva+YNhfJhxVZJT8ZJsTS+NbJ1q
 +DXDoctw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wHQtW-0000000Harj-2Ykx; Mon, 27 Apr 2026 18:41:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh@kernel.org>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2] accel: Arm Ethos-U NPU: fix all uapi kernel-doc warnings
Date: Mon, 27 Apr 2026 11:41:21 -0700
Message-ID: <20260427184121.680672-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
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
format to resolve all kernel-doc warnings:

Warning: include/uapi/drm/ethosu_accel.h:81 expecting prototype for struct
 drm_ethosu_gpu_info. Prototype was for struct drm_ethosu_npu_info instead
Warning: include/uapi/drm/ethosu_accel.h:81 struct member 'config' not
 described in 'drm_ethosu_npu_info'
Warning: include/uapi/drm/ethosu_accel.h:81 struct member 'sram_size' not
 described in 'drm_ethosu_npu_info'

Warning: include/uapi/drm/ethosu_accel.h:172 expecting prototype for struct
 drm_ethosu_wait_bo. Prototype was for struct drm_ethosu_bo_wait instead
Warning: include/uapi/drm/ethosu_accel.h:172 struct member 'handle' not
 described in 'drm_ethosu_bo_wait'
Warning: include/uapi/drm/ethosu_accel.h:172 struct member 'pad' not
 described in 'drm_ethosu_bo_wait'
Warning: include/uapi/drm/ethosu_accel.h:172 struct member 'timeout_ns' not
 described in 'drm_ethosu_bo_wait'

Warning: include/uapi/drm/ethosu_accel.h:208 struct member 'cmd_bo' not
 described in 'drm_ethosu_job'
Warning: include/uapi/drm/ethosu_accel.h:208 struct member 'sram_size' not
 described in 'drm_ethosu_job'
Warning: include/uapi/drm/ethosu_accel.h:208 struct member
 'region_bo_handles' not described in 'drm_ethosu_job'

Warning: include/uapi/drm/ethosu_accel.h:224 struct member 'jobs' not
 described in 'drm_ethosu_submit'
Warning: include/uapi/drm/ethosu_accel.h:224 struct member 'job_count' not
 described in 'drm_ethosu_submit'
Warning: include/uapi/drm/ethosu_accel.h:224 struct member 'pad' not
 described in 'drm_ethosu_submit'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend

Cc: Rob Herring <robh@kernel.org>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>

 include/uapi/drm/ethosu_accel.h |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--- linux-next-20260427.orig/include/uapi/drm/ethosu_accel.h
+++ linux-next-20260427/include/uapi/drm/ethosu_accel.h
@@ -60,7 +60,7 @@ enum drm_ethosu_dev_query_type {
 };
 
 /**
- * struct drm_ethosu_gpu_info - NPU information
+ * struct drm_ethosu_npu_info - NPU information
  *
  * Structure grouping all queryable information relating to the NPU.
  */
@@ -75,9 +75,10 @@ struct drm_ethosu_npu_info {
 #define DRM_ETHOSU_VERSION_MINOR(x)		(((x) >> 4) & 0xff)
 #define DRM_ETHOSU_VERSION_STATUS(x)		((x) & 0xf)
 
-	/** @gpu_rev: GPU revision. */
+	/** @config: NPU revision. */
 	__u32 config;
 
+	/** @sram_size: NPU SRAM size (KB) */
 	__u32 sram_size;
 };
 
@@ -159,7 +160,7 @@ struct drm_ethosu_bo_mmap_offset {
 };
 
 /**
- * struct drm_ethosu_wait_bo - ioctl argument for waiting for
+ * struct drm_ethosu_bo_wait - ioctl argument for waiting for
  * completion of the last DRM_ETHOSU_SUBMIT on a BO.
  *
  * This is useful for cases where multiple processes might be
@@ -167,9 +168,12 @@ struct drm_ethosu_bo_mmap_offset {
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
@@ -197,14 +201,14 @@ struct drm_ethosu_cmdstream_bo_create {
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
 
@@ -214,13 +218,13 @@ struct drm_ethosu_job {
  * The kernel will schedule the execution of these jobs in dependency order.
  */
 struct drm_ethosu_submit {
-	/** Input: Pointer to an array of struct drm_ethosu_job. */
+	/** @jobs: Input: Pointer to an array of struct drm_ethosu_job. */
 	__u64 jobs;
 
-	/** Input: Number of jobs passed in. */
+	/** @job_count: Input: Number of jobs passed in. */
 	__u32 job_count;
 
-	/** Reserved, must be zero. */
+	/** @pad: Reserved, must be zero. */
 	__u32 pad;
 };
 
