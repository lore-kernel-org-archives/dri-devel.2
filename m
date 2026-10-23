Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A768606A31B
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QWHhpvJS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D4A510E6E3;
	Fri, 23 Oct 2026 17:36:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6188510E6E3;
 Fri, 23 Oct 2026 17:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792776987; x=1824312987;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=N2axu/uf+xMPAzPuqcyJY/I8LlsgfoMWU0tBqtGpB3s=;
 b=QWHhpvJS0FyPdUAqHC3ABcZ0WV1odperzOwNwqvSgg/fZOouL9gN1IOT
 YvUyff4ZrLUTxpc/F45B1qVs+Bkvou/56j62QfmgiWALDb/IemIlhbQ6t
 /pQexkhCN9/stVQvBN5McFxgeJY9QS+cXUmeo6Rbfv/xlq7zpaqS+g+mf
 bwYGevviyHPStRPqHIZDFgyo8IM4QSZTHe+54o15K8UyuYFhZ84QuV7ph
 Qwpf7u2nOSF8UqTwG2adpcXbWjuCk9XxVF5vgNwFTlPpKpZ4MStMVf9NW
 PuiCxHlIgyaHHLYtgiZvgIeR7q8DFNZYJ2hqaGmPUuw2zcN87kPFPV7WW w==;
X-CSE-ConnectionGUID: h9CD5pYORtW2EFvFJAh3tg==
X-CSE-MsgGUID: QyzKWHB8RxekaCC9uVM5/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1554085"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1554085"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 10:36:27 -0700
X-CSE-ConnectionGUID: TM/KEAZnQo6cKER6dC14nA==
X-CSE-MsgGUID: yl2kzK2wTlK9NZnEMpefiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="5511626"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa013.fm.intel.com with ESMTP; 23 Oct 2026 10:36:27 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
Date: Fri, 23 Oct 2026 10:36:25 -0700
Message-ID: <20261023173625.601113-2-alan.previn.teres.alexis@intel.com>
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Today, when the driver faces issues with early pcode errors
and attempts to enter survivabilty (when explicitly requested)
it may either succeed or fail (latter being possible due to
underlying subsystem blockers). During this flow the driver remains
loaded and completely silent. No messages indicate that it may need
or it attempted and succeeded or it attempted and failed, to enter
survivability mode. This patch adds some awareness in dmesg.

 v2 : Remove / modify messages to reflect underlying behavior. (Sashiko)

Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c | 35 ++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index a07655b4c7a9..23ee6f255205 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -710,7 +710,8 @@ static int xe_device_vram_alloc(struct xe_device *xe)
  */
 int xe_device_probe_early(struct xe_device *xe)
 {
-	int err;
+	int err, pcode_err;
+	bool survival_requested;
 
 	xe_wa_device_init(xe);
 	xe_wa_process_device_oob(xe);
@@ -734,20 +735,34 @@ int xe_device_probe_early(struct xe_device *xe)
 	 * initialization is complete. Until done, any MMIO or lmem access from
 	 * the driver will be blocked
 	 */
-	err = xe_pcode_probe_early(xe);
-	if (err || xe_survivability_mode_is_requested(xe)) {
-		int save_err = err;
-
+	pcode_err = xe_pcode_probe_early(xe);
+	survival_requested = xe_survivability_mode_is_requested(xe);
+	if (pcode_err || survival_requested) {
 		/*
 		 * Try to leave device in survivability mode if device is
 		 * possible, but still return the previous error for error
 		 * propagation
 		 */
-		err = xe_survivability_mode_boot_enable(xe);
-		if (err)
-			return err;
-
-		return save_err;
+		int survive_err = xe_survivability_mode_boot_enable(xe);
+
+		if (survive_err) {
+			if (pcode_err && survival_requested)
+				xe_err(xe, "Early pcode err(%pe), survivability requested but unavailable(%pe)\n",
+				       ERR_PTR(pcode_err), ERR_PTR(survive_err));
+			else if (!pcode_err)
+				xe_warn(xe, "Early pcode ok, survivability requested but unavailable(%pe)\n",
+					ERR_PTR(survive_err));
+			return survive_err;
+		}
+		if (pcode_err && survival_requested)
+			xe_notice(xe, "Early pcode err(%pe), survivability requested\n",
+				  ERR_PTR(pcode_err));
+		else if (!pcode_err)
+			xe_notice(xe, "Early pcode ok but survivability requested\n");
+		else
+			xe_warn(xe, "Early pcode err(%pe) but survivability not requested or unsupported\n",
+				ERR_PTR(pcode_err));
+		return pcode_err;
 	}
 
 	/*

base-commit: b255dd13059988fddde9ea187d1dd1017c9a5766
-- 
2.43.0

