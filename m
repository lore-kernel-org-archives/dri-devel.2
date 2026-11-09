Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61734606D803
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cAEruVzZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 832D810F2F8;
	Mon,  9 Nov 2026 13:56:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7841710F300;
 Mon,  9 Nov 2026 13:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232584; x=1825768584;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BSGN6B1OtEml15HHYwcabE/c1CHb9WMnqRzQ1Ax9nyI=;
 b=cAEruVzZ2Qq/uuQbSlQswPUdZ3CTalrO9oXragGGsXypWETeRFyRyBi9
 SxEQhBUdX7Vcz9WJzJFFjbdj7wgmElUMO5Kyrno2Rhclz7wMPm6p4+yHY
 eob0p8TfQVCMyhAvhuS3rurt1e+ReLYMkCk0Z82NB+7x1KrcpGKGqhihT
 L2eNHhVVHz7U/owBLx59BYfuOGTGnREJwX9/s+sm+Ai7p29EGVkNsbBwr
 yuNG/0Y1OxCQ35ZyHBlJdpvO4WyYd/R3rQunMk0ZXEljF9hMwyNv4PNsN
 aKM10OmH86gAQEX/sV/TG2NoUjloR1vs8+dCvQOVrZm//EMqd1Z+UZ8XC w==;
X-CSE-ConnectionGUID: aTH+IzELTHSvkW+oMiSzDQ==
X-CSE-MsgGUID: 4sQ4ceI/Tz21RI/Eq+X6TA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850715"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850715"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:24 -0800
X-CSE-ConnectionGUID: YmIyq976RHm0WxN/MF1ptA==
X-CSE-MsgGUID: hGt5ShHnQfWFV5TYtR+7OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202578"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:19 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 03/20] drm/xe/eudebug: Add documentation
Date: Mon,  9 Nov 2026 15:55:28 +0200
Message-ID: <20261109135549.4128280-4-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
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

Add core documentation for connection setup and events.
Follow-up patches can then incrementally add their workings.

Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 Documentation/gpu/xe/index.rst      |  1 +
 Documentation/gpu/xe/xe_eudebug.rst | 56 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_eudebug.c     | 19 ++++++++++
 3 files changed, 76 insertions(+)
 create mode 100644 Documentation/gpu/xe/xe_eudebug.rst

diff --git a/Documentation/gpu/xe/index.rst b/Documentation/gpu/xe/index.rst
index 0247a255f7e6..8d4abdfe71a7 100644
--- a/Documentation/gpu/xe/index.rst
+++ b/Documentation/gpu/xe/index.rst
@@ -36,3 +36,4 @@ The display, or :ref:`drm-kms`, support for drm/xe is provided by
    xe_configfs
    xe_gt_stats
    xe_sigid
+   xe_eudebug
diff --git a/Documentation/gpu/xe/xe_eudebug.rst b/Documentation/gpu/xe/xe_eudebug.rst
new file mode 100644
index 000000000000..a73f8bd9a8e9
--- /dev/null
+++ b/Documentation/gpu/xe/xe_eudebug.rst
@@ -0,0 +1,56 @@
+.. SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+===================================
+Xe EU Debug (eudebug)
+===================================
+
+.. The uapi header is also included in full by driver-uapi.rst, so keep
+   the structs pulled in here out of the global C namespace to avoid
+   duplicate declaration warnings.
+
+.. c:namespace:: xe_eudebug
+
+Overview
+========
+
+The EU Debug (eudebug) subsystem provides an interface for debugging
+Execution Unit (EU) workloads on Intel Xe GPUs, independently from
+CPU process debugging. This enables tools like GDB (via gdbserver-intelgt)
+to debug GPU compute workloads through the Level-Zero Debug API.
+In practice, this allows SYCL/DPC++ workloads submitted by the
+compute-runtime to be debugged interactively.
+
+
+Connection Establishment
+========================
+
+.. kernel-doc:: drivers/gpu/drm/xe/xe_eudebug.c
+   :doc: Connection Establishment
+
+Events
+======
+
+.. kernel-doc:: drivers/gpu/drm/xe/xe_eudebug.c
+   :doc: Events
+
+Reading Events
+--------------
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :doc: DRM_XE_EUDEBUG_IOCTL_READ_EVENT
+
+Base Event Header
+-----------------
+
+The debugger receives events with the DRM_XE_EUDEBUG_IOCTL_READ_EVENT
+ioctl on the eudebug file descriptor. Every event has
+:c:type:`drm_xe_eudebug_event` as a header.
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_event
+
+Resource Event Types
+--------------------
+
+.. kernel-doc:: include/uapi/drm/xe_drm_eudebug.h
+   :identifiers: drm_xe_eudebug_event_vm
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index 0a57d99fc5e8..61572c006d22 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -19,6 +19,25 @@
 #include "xe_macros.h"
 #include "xe_vm.h"
 
+/**
+ * DOC: Connection Establishment
+ *
+ * To debug a target DRM client, the debugger must first establish
+ * a connection using :c:type:`drm_xe_eudebug_connect`.
+ *
+ */
+
+/**
+ * DOC: Events
+ *
+ * Resource creation/destruction and hardware state changes are
+ * delivered as events to the debugger.
+ *
+ * To read an event, ioctl DRM_XE_EUDEBUG_IOCTL_READ_EVENT command
+ * can be issued with prefilled :c:type:`drm_xe_eudebug_event` as argument.
+ *
+ */
+
 #define cast_event(T, event) container_of((event), typeof(*(T)), base)
 
 static const struct rhashtable_params rhash_res = {
-- 
2.53.0

