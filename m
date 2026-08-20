Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64166C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67FB10EFD8;
	Thu, 20 Aug 2026 10:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LYI4vRFi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB62510EFD8
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787223223; x=1818759223;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aCOyu52e260JW+250vdGzvG2846IGmYeGsS4xajlqvw=;
 b=LYI4vRFiDF9qc4n0hrkhlNG2HyEba9mCAjXN0pj72DglBpgd4tarFHIo
 uoYjxtGo6N3rQC+6PhxNicFMM2uqjZ1ZbYgnzkgbD9CH19DqRY9H7X8ZY
 H4jAnkgZRYMXE9SO/XjpikMJVpVwD90O25S+RxtEKpT6WFPUMl3HziA/k
 hVzvxEoULMViJ69JSj1G3nagwsJEpp6lAFD/DdaEbQg3LF2dpHIQUxLA4
 SQ8NDbi+kh40VFv2YhtaX9+zXPOWy5eKXgjq8mbh/iApZNRnBMNGBruNN
 o0EsrgCi12PuR3dacnF9ZSOVuHg3P0CtvfK1CH3+jznTCcCa35yAQGJM/ w==;
X-CSE-ConnectionGUID: 2gNQDgTsRumKTCCNuGuNUg==
X-CSE-MsgGUID: 1c5bn5duQFqdhFJaBkmFTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87624709"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87624709"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:53:43 -0700
X-CSE-ConnectionGUID: CDHboyEPTsyZ67bRUUipuw==
X-CSE-MsgGUID: fk+khkjcSdeBCO7Yos4vpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="267909681"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:53:41 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH RESEND 1/2] drm/print: add drm_warn_ratelimited logging macro
Date: Thu, 20 Aug 2026 12:48:10 +0200
Message-ID: <20260820104811.803146-2-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820104811.803146-1-dawid.osuchowski@linux.intel.com>
References: <20260820104811.803146-1-dawid.osuchowski@linux.intel.com>
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
-- 
2.43.0

