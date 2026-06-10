Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF60CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 589B310E59E;
	Wed, 10 Jun 2026 11:08:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OowjbV4U";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0B6710E59E
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 11:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781089716; x=1812625716;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=qmJnnNzyKf/aiZbln6mGxaykwJO765mJKlyR9ewvaYY=;
 b=OowjbV4UCwq0S7EyvmFtNlDv5GpA5aWeHa3sIFdHT1UN2C8IMv+6d3u4
 +cWifaV6ThBYqTjhmOH6SHD9KZNPG1HZXIPVWeDaa7Qe5HI/xLCYktc0o
 QqIDhwJim1mkkKKwhQEzewKnyL1GTcrt0ImLBpx6e02h/PULFWGyGi5eI
 pbJtvwZETzCnIgM6PkQ3RjYDyz1jvXdEuyLwRK2Xg1JGZsizu3254Ch33
 8UPZZuChklYHsH3iUjTqDixeo7/2gg2Ot6p9eU8KneWqGIeB+PEUXC2bk
 UX69fVi3rh/UtzaY7vVNiwbWXxxlrLnLrc3PUcfv+s7MKald8Q9wUuHRl Q==;
X-CSE-ConnectionGUID: X68uyDZzQhqhVD3KcuOY0A==
X-CSE-MsgGUID: 63KSfnBnSoeIUBG+ZjJdsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81882213"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81882213"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:08:31 -0700
X-CSE-ConnectionGUID: V2Y0nx4eTuywrKx5Ul5cRQ==
X-CSE-MsgGUID: JRUEH/bWQ+e5Mw8NJ5hVXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245290428"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:08:29 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: ogabbay@kernel.org, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, andrzej.kacprowski@linux.intel.com,
 lizhi.hou@amd.com, Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 1/2] drm/print: add drm_warn_ratelimited logging macro
Date: Wed, 10 Jun 2026 13:03:47 +0200
Message-ID: <20260610110348.1796333-1-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-31
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

Add a drm_warn_ratelimited() macro to complement the existing
drm_err_ratelimited(), providing rate-limited logging at warning level
for drivers that need it.

Link: https://lore.kernel.org/dri-devel/d8cdb0c5c420b7ac9bf64367a25d2ad6dff95637@intel.com/
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 include/drm/drm_print.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 2adc5ac688e1..0805903c093b 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -644,6 +644,9 @@ static inline struct device *__drm_to_dev(const struct drm_device *drm)
 #define drm_err_ratelimited(drm, fmt, ...)				\
 	__drm_printk((drm), err, _ratelimited, "*ERROR* " fmt, ##__VA_ARGS__)
 
+#define drm_warn_ratelimited(drm, fmt, ...)				\
+	__drm_printk((drm), warn, _ratelimited, fmt, ##__VA_ARGS__)
+
 
 #define drm_dbg_core(drm, fmt, ...)					\
 	drm_dev_dbg(__drm_to_dev(drm), DRM_UT_CORE, fmt, ##__VA_ARGS__)

base-commit: f2f4e6d45fecc6ead92bf5ea06a04a00c245904e
-- 
2.43.0

