Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED4CC88E77
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:07:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D27310E30C;
	Tue, 15 Sep 2026 21:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hbxCa4bw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A409C10E30C
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789506448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aS9CJ6a5mDPOCckG4U1k7Yinjt22rR82uZwHt40L5ZM=;
 b=hbxCa4bwa9/aZUG8atkvJKnEJPJtfbYG1wdZWmvdfd5VEzAHT0T33/xB9nF7s1a0FYLNZY
 Mo/3ihBs30F7fc3fu/s6bmO2OaupEa5GYDxJ4B0Mt7LE80Cpt+k8r0OVqBmtzGVtAdXtIy
 aaBGZnKe/rj95H7FnPLrKbQby5nDr2s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-sjzzTnZQOwaX_4aI7rOtMg-1; Tue,
 15 Sep 2026 17:07:25 -0400
X-MC-Unique: sjzzTnZQOwaX_4aI7rOtMg-1
X-Mimecast-MFC-AGG-ID: sjzzTnZQOwaX_4aI7rOtMg_1789506443
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E44CA195608C; Tue, 15 Sep 2026 21:07:22 +0000 (UTC)
Received: from GoldenWind.redhat.com (unknown [10.22.80.179])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98C2F180034C; Tue, 15 Sep 2026 21:07:20 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: "Timur Tabi" <ttabi@nvidia.com>, "Dave Airlie" <airlied@redhat.com>,
 "Mohamed Ahmed" <mohamedahmedegypt2001@gmail.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Hongling Zeng" <zenghongling@kylinos.cn>,
 "Mel Henning" <mhenning@darkrefraction.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 2/5] drm/nouveau/gsp/r535: Add support for
 MEMSYS_GET_STATIC_CONFIG
Date: Tue, 15 Sep 2026 14:51:49 -0400
Message-ID: <20260915210647.695187-3-lyude@redhat.com>
In-Reply-To: <20260915210647.695187-1-lyude@redhat.com>
References: <20260915210647.695187-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: VOPh6GGMzl5A3vXcroquuytYgXjBxiIGYVl8-hTiAcI_1789506443
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This is a GSP structure describing various characteristics of the memory
management system that GSP provides. Start by fetching it during driver
load, but don't do anything with the information we get from it just yet.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/include/nvkm/subdev/gsp.h |  4 ++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c | 17 +++++++
 .../nvkm/subdev/gsp/rm/r535/nvrm/gsp.h        | 45 +++++++++++++++++
 .../drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c |  8 +++
 .../nvkm/subdev/gsp/rm/r570/nvrm/gsp.h        | 50 +++++++++++++++++++
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h   |  1 +
 6 files changed, 125 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
index 64fed208e4cf8..0e193baaf9bbb 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
@@ -156,6 +156,10 @@ struct nvkm_gsp {
 		struct sg_table fbsr;
 	} sr;
 
+	struct {
+		bool use_raw_mode_comptagline_alloc;
+	} memsys;
+
 	struct {
 		struct nvkm_gsp_mem mem;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
index 09b17b85dc1ac..c57a3250d6b96 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c
@@ -1808,6 +1808,23 @@ r535_gsp_fini(struct nvkm_gsp *gsp, enum nvkm_suspend_state suspend)
 	return 0;
 }
 
+int
+r535_gsp_get_static_memsys_info(struct nvkm_gsp *gsp)
+{
+	NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS *ctrl;
+
+	ctrl = nvkm_gsp_rm_ctrl_get(&gsp->internal.device.subdevice,
+				    NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_STATIC_CONFIG,
+				    sizeof(*ctrl));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
+
+	gsp->memsys.use_raw_mode_comptagline_alloc = ctrl->bUseRawModeComptaglineAllocation;
+
+	nvkm_gsp_rm_ctrl_done(&gsp->internal.device.subdevice, ctrl);
+	return 0;
+}
+
 int
 r535_gsp_init(struct nvkm_gsp *gsp)
 {
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
index fd1170037c030..fee5418a72a68 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/nvrm/gsp.h
@@ -789,6 +789,51 @@ typedef struct NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS {
     NvBool bIsGCOFFSatisfied;
 } NV2080_CTRL_INTERNAL_GCX_ENTRY_PREREQUISITE_PARAMS;
 
+typedef struct NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS {
+    /*! Determines if RM should use 1 to 1 Comptagline allocation policy */
+    NvBool bOneToOneComptagLineAllocation;
+
+    /*! Determines if RM should use 1 to 4 Comptagline allocation policy */
+    NvBool bUseOneToFourComptagLineAllocation;
+
+    /*! Determines if RM should use raw Comptagline allocation policy */
+    NvBool bUseRawModeComptaglineAllocation;
+
+    /*! Has COMPBIT_BACKING_SIZE been overridden to zero (i.e. disabled)? */
+    NvBool bDisableCompbitBacking;
+
+    /*! Determine if we need to disable post L2 compression */
+    NvBool bDisablePostL2Compression;
+
+    /*! Is ECC DRAM feature supported? */
+    NvBool bEnabledEccFBPA;
+
+    NvBool bL2PreFill;
+
+    /*! L2 cache size */
+    NV_DECLARE_ALIGNED(NvU64 l2CacheSize, 8);
+
+    /*! Indicate whether fpba is present or not */
+    NvBool bFbpaPresent;
+
+    /*! Size covered by one comptag */
+    NvU32  comprPageSize;
+
+    /*! log32(comprPageSize) */
+    NvU32  comprPageShift;
+
+    /*! RAM type */
+    NvU32  ramType;
+
+    /*! LTC count */
+    NvU32  ltcCount;
+
+    /*! LTS per LTC count */
+    NvU32  ltsPerLtcCount;
+} NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS;
+
+#define NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_STATIC_CONFIG        (0x20800a1c) /* finn: Evaluated from "(FINN_NV20_SUBDEVICE_0_INTERNAL_INTERFACE_ID << 8) | NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS_MESSAGE_ID" */
+
 typedef union rpc_message_rpc_union_field_v03_00
 {
     NvU32      spare;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
index b45781cd0dfdc..5a51fe7e5ab98 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/gsp.c
@@ -137,6 +137,14 @@ r570_gsp_get_static_info(struct nvkm_gsp *gsp)
 		}
 	}
 
+	ret = r535_gsp_get_static_memsys_info(gsp);
+	if (ret) {
+		nvkm_error(&gsp->subdev, "Retrieving static memsys info failed\n");
+		return ret;
+	}
+	nvkm_debug(&gsp->subdev, "memsys: Use raw mode for comptag allocations? %s\n",
+		   str_yes_no(gsp->memsys.use_raw_mode_comptagline_alloc));
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
index c458569af9d72..e2d9d1949e4e1 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/nvrm/gsp.h
@@ -494,6 +494,56 @@ typedef struct
 
 #define GSP_FW_WPR_META_REVISION  1
 
+#define NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS_MESSAGE_ID (0x1CU)
+
+typedef struct NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS {
+    /*! Determines if RM should use 1 to 1 Comptagline allocation policy */
+    NvBool bOneToOneComptagLineAllocation;
+
+    /*! Determines if RM should use 1 to 4 Comptagline allocation policy */
+    NvBool bUseOneToFourComptagLineAllocation;
+
+    /*! Determines if RM should use raw Comptagline allocation policy */
+    NvBool bUseRawModeComptaglineAllocation;
+
+    /*! Has COMPBIT_BACKING_SIZE been overridden to zero (i.e. disabled)? */
+    NvBool bDisableCompbitBacking;
+
+    /*! Determine if we need to disable post L2 compression */
+    NvBool bDisablePostL2Compression;
+
+    /*! Is ECC DRAM feature supported? */
+    NvBool bEnabledEccFBPA;
+
+    NvBool bL2PreFill;
+
+    /*! L2 cache size */
+    NV_DECLARE_ALIGNED(NvU64 l2CacheSize, 8);
+
+    /*! Indicate whether fpba is present or not */
+    NvBool bFbpaPresent;
+
+    /*! Size covered by one comptag */
+    NvU32  comprPageSize;
+
+    /*! log32(comprPageSize) */
+    NvU32  comprPageShift;
+
+    /*! RAM type */
+    NvU32  ramType;
+
+    /*! LTC count */
+    NvU32  ltcCount;
+
+    /*! LTS per LTC count */
+    NvU32  ltsPerLtcCount;
+} NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS;
+
+/*!
+ * Retrieve Memory System Static data.
+ */
+#define NV2080_CTRL_CMD_INTERNAL_MEMSYS_GET_STATIC_CONFIG        (0x20800a1c) /* finn: Evaluated from "(FINN_NV20_SUBDEVICE_0_INTERNAL_INTERFACE_ID << 8) | NV2080_CTRL_INTERNAL_MEMSYS_GET_STATIC_CONFIG_PARAMS_MESSAGE_ID" */
+
 typedef struct {
     NvU64 sharedMemPhysAddr;
     NvU32 pageTableEntryCount;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
index 3de7871e22934..46fdd11c4d2b3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/rm.h
@@ -175,6 +175,7 @@ int r535_gr_promote_ctx(struct r535_gr *, bool golden, struct nvkm_vmm *,
 			struct nvkm_memory **pctxbuf_mem, struct nvkm_vma **pctxbuf_vma,
 			struct nvkm_gsp_object *chan);
 int r535_gsp_gcx_ready(struct nvkm_gsp *gsp);
+int r535_gsp_get_static_memsys_info(struct nvkm_gsp *gsp);
 extern const struct nvkm_rm_api_engine r535_nvdec;
 extern const struct nvkm_rm_api_engine r535_nvenc;
 extern const struct nvkm_rm_api_engine r535_nvjpg;
-- 
2.55.0

