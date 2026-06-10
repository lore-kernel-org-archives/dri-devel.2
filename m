Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297E9CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:08:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767F210E8DE;
	Wed, 10 Jun 2026 11:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BU7c/n5k";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D7B10E8F5
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 11:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781089724; x=1812625724;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Oivs7vNEYmn5ftt82WShznqniVToq/o3ChI6hx4bVsE=;
 b=BU7c/n5kkIqDOgVKjul2k/gTc3kFD800W3T9QwNe8i/6GNOFw7iDRJO0
 r5whgcDF30Wuj7QYQb+ntNAQLAEuoZaZsZjqCDnW3h9tm70rwT+GDOFIU
 ORDdznl16m8DpJYMp4UkRIXtmPTOJauQCEuig08YospmcZipB1T77OhIq
 tQCtLOixbBYLNkAMFuUk3HWXLENAzgu+q+7mBUdmF7dce4fq85CUtHxwm
 pMX8D0Rf3yJe9HNUYKOIO9m0k0hY4vuLEPcABmqDsfvXBmjxiOIuRDG0X
 tEPy/AJZIQagPFsKTD67EaaIfECdKuFEgrj/vVxvedgOqfoMdOGDQh8rm Q==;
X-CSE-ConnectionGUID: vORFtxjZQNKT3EEZb5p5sw==
X-CSE-MsgGUID: xm+nxvg4ROykJERPn1CmfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="81882251"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="81882251"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:08:44 -0700
X-CSE-ConnectionGUID: aidOhpIETRW3wxucPeWzBw==
X-CSE-MsgGUID: ODDWwEAKQYCgY2Dh5AeL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="245290456"
Received: from try2-8594.igk.intel.com ([10.91.220.58])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2026 04:08:43 -0700
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: ogabbay@kernel.org, jeff.hugo@oss.qualcomm.com,
 karol.wachowski@linux.intel.com, andrzej.kacprowski@linux.intel.com,
 lizhi.hou@amd.com, Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Subject: [PATCH 2/2] accel/ivpu: Use drm_warn_ratelimited macro
Date: Wed, 10 Jun 2026 13:03:48 +0200
Message-ID: <20260610110348.1796333-2-dawid.osuchowski@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610110348.1796333-1-dawid.osuchowski@linux.intel.com>
References: <20260610110348.1796333-1-dawid.osuchowski@linux.intel.com>
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
index 9eefbbb7ba11..d5f77cf84196 100644
--- a/drivers/accel/ivpu/ivpu_drv.h
+++ b/drivers/accel/ivpu/ivpu_drv.h
@@ -90,7 +90,7 @@
 	drm_warn(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
 
 #define ivpu_warn_ratelimited(vdev, fmt, ...) \
-	drm_err_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
+	drm_warn_ratelimited(&(vdev)->drm, "%s(): " fmt, __func__, ##__VA_ARGS__)
 
 #define ivpu_info(vdev, fmt, ...) drm_info(&(vdev)->drm, fmt, ##__VA_ARGS__)
 
-- 
2.43.0

