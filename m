Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A90606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MtFSnPFH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36CFC10F309;
	Mon,  9 Nov 2026 13:56:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA7F10F304;
 Mon,  9 Nov 2026 13:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232594; x=1825768594;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZFP0GSeRTHpFHzej+c3V+AwIYKmXeSPTe+a9U34LLxw=;
 b=MtFSnPFHmQZs1OMXk+TqJcjCCT5rqOR34oCJFCsO0+S6WtMMNnNoENVT
 xfbuo3P9Baix2FxAwy+3o+VXW4G2kQEWeqDVpYMYyZxA8aAgelEHSwT4d
 3tHZH/WVJbA5MQWR24CHS86CMLOCpy2aYe0HbGVwxNDwcnmlyQJ7wBX6R
 DpMuTPP68DWjZ8T47O5/5u6BxTsNZehbXOyzWJsYYi6ldthm98LMyqALy
 Pz+jOsqz9LPAPaklYcwccx4nn2dalp+8NFoy9vhRRyFdi922NFHoBaorW
 xV0brkJMcKl3IhUZVS6BWcUNubGWU7lBnpF1PIzJt4z9dYtAcrI5EuG94 A==;
X-CSE-ConnectionGUID: YBEkHQK1RP2MkRcYpBg3ww==
X-CSE-MsgGUID: ywnY5g4/RvyDLbR2cR9kGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2850729"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2850729"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:34 -0800
X-CSE-ConnectionGUID: Nfu8Y+2PRCmC2QbjNn0juQ==
X-CSE-MsgGUID: 4O88QJBHSDmVJKM/mkmfnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8202631"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:56:28 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Christoph Manszewski <christoph.manszewski@intel.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 05/20] drm/xe: Implement SR-IOV and eudebug exclusivity
Date: Mon,  9 Nov 2026 15:55:30 +0200
Message-ID: <20261109135549.4128280-6-mika.kuoppala@linux.intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christoph Manszewski <christoph.manszewski@intel.com>

EU debug functionality relies on access to specific mmio registers.
Since VFs don't have access to those registers and in order to avoid
interference with VFs, make SR-IOV and eudebug functionality exclusive.
I.e. don't allow enabling eudebug in VF mode and don't allow enabling
eudebug when any VFs are enabled. Likewise, don't allow enabling
VFs when eudebug is enabled.

v2: initialize lock early (Sashiko)
v3: say why eudebug was refused (Claude)
v4: avoid racing with work (Sashiko)
v5: - don't log per VF probe (Sashiko)
v6: - cap_state under eudebug.lock (Mika)
v7: - poll stop comment: a PF waits the last round out (Sashiko)
v8: - move right after the interface documentation, the vm access, EU
      control, attention worker and live tests patches now cover their
      own parts (Mika)

Signed-off-by: Christoph Manszewski <christoph.manszewski@intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 .../ABI/testing/sysfs-driver-intel-xe-eudebug |  4 ++++
 drivers/gpu/drm/xe/xe_eudebug.c               | 21 +++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
index 26aff5116b8a..884a791789ad 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
+++ b/Documentation/ABI/testing/sysfs-driver-intel-xe-eudebug
@@ -34,3 +34,7 @@ Description:	RW. Controls whether the EU debugger interface is armed for
 		CONFIG_DRM_XE_EUDEBUG and the interface was set up at probe
 		time. If probe could not set it up, the attribute is absent
 		and the connect ioctl fails with -EOPNOTSUPP.
+
+		On an SR-IOV VF the attribute is absent. On a PF, writing 1
+		while VFs are enabled fails with -EBUSY, and while the
+		interface is enabled enabling VFs fails with -EPERM.
diff --git a/drivers/gpu/drm/xe/xe_eudebug.c b/drivers/gpu/drm/xe/xe_eudebug.c
index d18ba28f43b1..ad8e1c02f20b 100644
--- a/drivers/gpu/drm/xe/xe_eudebug.c
+++ b/drivers/gpu/drm/xe/xe_eudebug.c
@@ -17,6 +17,7 @@
 #include "xe_eudebug.h"
 #include "xe_eudebug_types.h"
 #include "xe_macros.h"
+#include "xe_sriov_pf.h"
 #include "xe_vm.h"
 
 /**
@@ -1203,6 +1204,8 @@ void xe_eudebug_file_close(struct xe_file *xef)
 
 static int xe_eudebug_enable(struct xe_device *xe, bool enable)
 {
+	int ret;
+
 	guard(mutex)(&xe->eudebug.lock);
 
 	if (xe->eudebug.cap_state == XE_EUDEBUG_CAP_NOT_SUPPORTED)
@@ -1214,9 +1217,21 @@ static int xe_eudebug_enable(struct xe_device *xe, bool enable)
 	if (enable == __xe_eudebug_is_enabled(xe))
 		return 0;
 
+	/* Lock VFs out first, so that a refusal leaves nothing to take back */
+	if (enable && IS_SRIOV_PF(xe)) {
+		ret = xe_sriov_pf_lockdown(xe);
+		if (ret) {
+			drm_dbg(&xe->drm, "Can't enable eudebug: VFs are enabled\n");
+			return ret;
+		}
+	}
+
 	set_cap_state(xe, enable ?
 		      XE_EUDEBUG_CAP_ENABLED : XE_EUDEBUG_CAP_DISABLED);
 
+	if (!enable && IS_SRIOV_PF(xe))
+		xe_sriov_pf_end_lockdown(xe);
+
 	return 0;
 }
 
@@ -1288,6 +1303,11 @@ void xe_eudebug_init(struct xe_device *xe)
 	if (xe->eudebug.cap_state == XE_EUDEBUG_CAP_NOT_SUPPORTED)
 		return;
 
+	if (IS_SRIOV_VF(xe)) {
+		drm_dbg(&xe->drm, "eudebug not available in SR-IOV VF mode\n");
+		goto out_not_supported;
+	}
+
 	err = devm_add_action_or_reset(dev->dev, xe_eudebug_sysfs_fini, xe);
 	if (err)
 		goto out_err;
@@ -1307,6 +1327,7 @@ void xe_eudebug_init(struct xe_device *xe)
 out_err:
 	drm_warn(&xe->drm, "eudebug disabled, init fail: %d\n", err);
 
+out_not_supported:
 	scoped_guard(mutex, &xe->eudebug.lock)
 		set_cap_state(xe, XE_EUDEBUG_CAP_NOT_SUPPORTED);
 }
-- 
2.53.0

