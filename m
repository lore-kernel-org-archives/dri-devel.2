Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93331C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:53:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8AE910EFDA;
	Thu, 20 Aug 2026 10:53:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gjYy95k9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BD1D10EFDA
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787223234; x=1818759234;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wC+odQ7NMCfO2/AnZqVtobXvos05w3q9VWYgA0RGlYs=;
 b=gjYy95k9UwwLvFG7HD9TiIlH8YVJ3SARlQO6Q5DSNVQC6KcXpDbftxNY
 ccZQIw/5h+/GDHhdCQLDX1TkSjnkhqMMBcZEJUwt1kt/cSD/bTbaalgYR
 3JHeJq0mh0CPigxKFWGzNF4hq2/oNU6BmQIOdqKK0Bmko+FI+mqMxlKWj
 mqNyq+N9UlItVyaESnCsabX5ijrfmnbE0vCuidF6+n9bZl3yrnaGWDP2g
 RkTGNktjMgzadhO545xN2hdYF7jVu1ncX17gS9gIlHYtyZY0Hv3Ww/QcG
 rDZnIgKEmPVroP9rxw0ImwbYQ0SO2OTRca/pXWSayEgIrNKP+NjjNYVoR A==;
X-CSE-ConnectionGUID: Zj33WdU5RJyFisX58PcVNA==
X-CSE-MsgGUID: IUQRLzXCRG6d7spAupElVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87624722"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="87624722"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:53:54 -0700
X-CSE-ConnectionGUID: K9b708UWQ4S6xlcQACeW2Q==
X-CSE-MsgGUID: LsZmcmqzS46BvGPW1OyYQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="267910146"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 03:53:52 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, lizhi.hou@amd.com,
 andrzej.kacprowski@linux.intel.com,
 Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH RESEND 2/2] accel/ivpu: Use drm_warn_ratelimited macro
Date: Thu, 20 Aug 2026 12:48:11 +0200
Message-ID: <20260820104811.803146-3-dawid.osuchowski@linux.intel.com>
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

Fix ivpu_warn_ratelimited() to properly use WARN logging level instead
of an ERROR.

Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
---
 drivers/accel/ivpu/ivpu_drv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.h b/drivers/accel/ivpu/ivpu_drv.h
index 86d7c9966cac..8f29f1dc52b9 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -91,7 +91,7 @@
 	drm_warn(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
 
 #define ivpu_warn_ratelimited(vdev, fmt, ...) \
-	drm_err_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
+	drm_warn_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
 
 #define ivpu_info(vdev, fmt, ...) drm_info(&(vdev)->drm, fmt, ##__VA_ARGS__)
 
-- 
2.43.0

