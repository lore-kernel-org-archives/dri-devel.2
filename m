Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86354C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE50B10E67E;
	Tue, 22 Sep 2026 10:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cR4WtZN1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A8E10E6B7;
 Tue, 22 Sep 2026 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072257; x=1821608257;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Uj6XEHwEbcxT97VnqD0X4gNpG+jMwBUb2NXs6GzKKF0=;
 b=cR4WtZN14WV7+4gdZqX4cUOwyBA7o9f/5IPVX10jBYF1vzD7xvKqAzM1
 3VvRQK8XMLymh6rrstD+aB0hDdRldXHPA+FoDfrskSJAF5CaNlabJiXQL
 eaYwze0LXN49rBri4WyU6ajPTmnAKBl+IXJa8561rJjO+E2V7wegTXnSB
 1oaZmCveVlOA/6uhCfzDcoRusXSEk6XwJXwaaNQe3+wArE4akyxAEhDqP
 BIiaKiqT05fm42mbYWbd7pgTgW0ojvR9Zq3+AHeZXPTHw1SZwk28TgOAt
 PQpS3sFufMbhltNCOAIF/OUY8iGLyJVVxL27IYXUpzZtiU+0i2sQmC+eZ g==;
X-CSE-ConnectionGUID: diAmBMbbQAWB2ASwkUHkjg==
X-CSE-MsgGUID: HazQosRGQFSwl4yquPEIow==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322774"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322774"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:37 -0700
X-CSE-ConnectionGUID: erhl8yQNT3Cxq892OjiMOg==
X-CSE-MsgGUID: uhB7GH4yTGitQqZZQ6MhCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307742"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:35 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 01/15] drm/xe/irq: Always free requested IRQs on uninstall
Date: Tue, 22 Sep 2026 15:46:46 +0530
Message-ID: <20260922101721.1583542-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

xe_irq_suspend() clears irq.enabled after disabling and synchronizing the
interrupts. irq_uninstall() currently returns when that flag is clear, so
a suspended device can skip free_irq() during teardown.

The managed uninstall action is registered only after the IRQ request
succeeds. Reset the interrupt registers only when interrupts are still
enabled, but always free the requested IRQs.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_irq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_irq.c b/drivers/gpu/drm/xe/xe_irq.c
index 9e49e2241da4..d314993b14a1 100644
--- a/drivers/gpu/drm/xe/xe_irq.c
+++ b/drivers/gpu/drm/xe/xe_irq.c
@@ -786,10 +786,8 @@ static void irq_uninstall(void *arg)
 {
 	struct xe_device *xe = arg;
 
-	if (!atomic_xchg(&xe->irq.enabled, 0))
-		return;
-
-	xe_irq_reset(xe);
+	if (atomic_xchg(&xe->irq.enabled, 0))
+		xe_irq_reset(xe);
 
 	if (xe_device_has_msix(xe))
 		xe_irq_msix_free(xe);
-- 
2.43.0

