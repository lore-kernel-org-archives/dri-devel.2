Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A582606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FIyXKKsP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356CA112832;
	Fri, 27 Nov 2026 08:29:16 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62B310EA87
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 20:58:21 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so70237595e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795726700; x=1796331500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=64p4jkLLf3hJWd/mZVm38nQSWNZQPlgWDMk1O/6JppA=;
 b=FIyXKKsPKl+nPATDjnYTgIZM38alINh6vmAPs+bQYYZBra6XslHBYKCW/UrnhYGQjr
 7lsydWZvsNWbjGqNqbAYUoalbHwtaghD5S33xP/+/t5FZLXSreVjstyczcKIgzMmJ691
 UBwIzUuIBDY3N/JnSe6+YuMTdciTWx4rIthWuFoiDlOyhoj6w4mcBOWHhpPjumMpOoSe
 R35/fq/lk06PYIOpnLZFTbxl7hs2Q9vJIJlT0KPyCoVAeGO3NkkcUkpx6ZaPZdeS75eR
 wwWRalH5EdcuOh6orSq1wGiWlaDyk6RvCIg580xE9lJEMv2Olzs/t4Lb+qujfN0uBqgU
 c+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795726700; x=1796331500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=64p4jkLLf3hJWd/mZVm38nQSWNZQPlgWDMk1O/6JppA=;
 b=D/NkXMxImyzxWt/RIG2NWbZwvIZ4MiJVFVakr13472p7oereQWg/PdV137rvHTHbsB
 +5WP91ZQH8wP5FflzcT4JD2+d2tsDL4ka5OYGxU/lkWOPsmkvqHBSpYBPGOFu4r2d+qJ
 JIVAnuE0a1hS5vn3oyTlgNuQd7E5TLe67ZmtLZeWxRR5NMzvVb+rbynE7H35Ovx2d21d
 oeJ9uYIG61H53lLwvDkAvKRL9XaPwskhZAOO4jAvtXq0LaQ8Pr0/nWFnsjckeQZbMvSb
 UDFWGC+Trk0qesQvLKXpzrpE5eBM/TRXhsnxS3owN4MKQBHqSbLk/RDVNKxs0rReqjAy
 noIA==
X-Gm-Message-State: APuU4Z+3xUVA7SEyJaxfoxB8/gpvv430ZvGsuwmSRcSYVGwV8wUelL+H
 /PKlpsAbA8Zeai/np2kjYGmYTdAOaGrWdCT5wsBm1/nRx9085E+w94lQ
X-Gm-Gg: AZFdTZfeMNl8GLg+mWBPYg0C3iQFqpcOO8KWXnmuA7dprnFNfAA6jxhal9Dyfv4pSR5
 px5aQwzZA2zp9iwlRGihLIX/9VnHcIUGPL3PQNKo8BgYgt/2W4FClzK8Hnns3dg4hlWc7k+qEIB
 KkPc5K668NkOU5l2ZVsFDgbD+EkCoLu8msb/uKsCahUjThtg26ISMtmNh8VhmvHU205XhrrfTm4
 /q8BqZy1V0pc3cT5jwUFULel1BWanusDzBXNwro8nCI55G5see2VFE2xbefv1WgKydCf/x2GZyu
 jpw1+ry6YeZMwY2O54SJ+8hCh1Z+ziTwEIScfvJA5plhFMwW6UwEruZiAzpon4b9WxhN7Oi55CZ
 3VFcK9fdZU5LFWxmcEbP/wSoBRWw0zaZ5jk1rZFZQY4wI/xVXGHR2NYj0LCSNZODSqLjx59hBXX
 aYcheOe3wMdzMytbbU5DWtGKPFgRiTp48Eq0eQavzc4rRIoCyXY5Kp4fD68e5LIg0osyiBBFg+B
 ZFGtnZqUTA/l//PLd1Jt8Qjik7joGMj2FWndZQjI3PBhM1dTqF2Bee7zdKKQ2gjvwdS3ylWiU3e
 8e2VzFGFKWw4OBEk80B4U32xwN95I+WQyJbU22c2xahKS92LhMgeX82zc709YyVjzkC0uUJynG8
 TVz0=
X-Received: by 2002:a05:600c:4585:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4bb8882948dmr457925855e9.18.1795726699905; 
 Thu, 26 Nov 2026 12:58:19 -0800 (PST)
Received: from localhost (2001-1ae9-5b-ad10--33.ip6.tmcz.cz.
 [2001:1ae9:5b:ad10::33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb85399d52sm611178075e9.6.2026.11.26.12.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 12:58:19 -0800 (PST)
From: Arisa Snowbell <arisa.snowbell@gmail.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
 Arisa Snowbell <arisa.snowbell@gmail.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 4/5] drm/xe: hold video decode work and HuC queries for a
 pending DG2 HuC load
Date: Thu, 26 Nov 2026 21:57:56 +0100
Message-ID: <20261126205758.49845-5-arisa.snowbell@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126205758.49845-1-arisa.snowbell@gmail.com>
References: <20261126205758.49845-1-arisa.snowbell@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

On DG2 the HuC load by the GSC completes asynchronously after probe, a GT
reset or a resume. Media submitted before then would run without the HuC,
and userspace querying the HuC version (as Mesa and the media driver do at
init) would see a device without one.

Like i915 (i915_request_await_huc()), make video decode jobs depend on the
fence of the pending load. The HuC version query waits for it too,
interruptibly and bounded by the load's own 10 s deadline; document that.

Signed-off-by: Arisa Snowbell <arisa.snowbell@gmail.com>
---
 drivers/gpu/drm/xe/xe_exec.c  | 13 +++++++++++++
 drivers/gpu/drm/xe/xe_query.c |  5 +++++
 include/uapi/drm/xe_drm.h     |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index f9b0fdb96..65e445205 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -14,6 +14,8 @@
 
 #include "xe_device.h"
 #include "xe_exec_queue.h"
+#include "xe_gt_types.h"
+#include "xe_huc_mei.h"
 #include "xe_hw_engine_group.h"
 #include "xe_macros.h"
 #include "xe_pm.h"
@@ -317,6 +319,17 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	if (err)
 		goto err_put_job;
 
+	/* as on i915, video decode must not run before a pending HuC load */
+	if (q->class == XE_ENGINE_CLASS_VIDEO_DECODE) {
+		struct dma_fence *huc_load = xe_huc_mei_load_fence(&q->gt->uc.huc);
+
+		if (huc_load) {
+			err = drm_sched_job_add_dependency(&job->drm, huc_load);
+			if (err)
+				goto err_put_job;
+		}
+	}
+
 	if (!xe_vm_in_lr_mode(vm)) {
 		err = xe_svm_notifier_lock_interruptible(vm);
 		if (err)
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index 9cc35fc83..696bae5ee 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -22,6 +22,7 @@
 #include "xe_gt.h"
 #include "xe_gt_topology.h"
 #include "xe_guc_hwconfig.h"
+#include "xe_huc_mei.h"
 #include "xe_macros.h"
 #include "xe_mmio.h"
 #include "xe_oa.h"
@@ -600,6 +601,7 @@ query_uc_fw_version(struct xe_device *xe, struct drm_xe_device_query *query)
 	case XE_QUERY_UC_TYPE_HUC: {
 		struct xe_gt *media_gt = NULL;
 		struct xe_huc *huc;
+		int ret;
 
 		if (MEDIA_VER(xe) >= 13) {
 			struct xe_tile *tile;
@@ -619,6 +621,9 @@ query_uc_fw_version(struct xe_device *xe, struct drm_xe_device_query *query)
 			break;
 
 		huc = &media_gt->uc.huc;
+		ret = xe_huc_mei_wait(huc);
+		if (ret)
+			return ret;
 		if (huc->fw.status == XE_UC_FIRMWARE_RUNNING)
 			version = &huc->fw.versions.found[XE_UC_FW_VER_RELEASE];
 		break;
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 578f0c1eb..db893d041 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -628,6 +628,11 @@ struct drm_xe_query_engine_cycles {
  *
  * Given a uc_type this will return the branch, major, minor and patch version
  * of the micro-controller firmware.
+ *
+ * On platforms where the GSC loads the HuC (DG2), the load runs asynchronously
+ * after probe, reset and resume. A query of %XE_QUERY_UC_TYPE_HUC then waits
+ * (interruptibly, for at most 10 seconds) until a pending load settled, so
+ * that it does not report a HuC that is about to run as missing.
  */
 struct drm_xe_query_uc_fw_version {
 	/** @uc_type: The micro-controller type to query firmware version */
-- 
2.56.1

