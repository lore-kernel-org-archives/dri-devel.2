Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F50C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0472A10E61F;
	Thu, 27 Aug 2026 10:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PZGEzi1h";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33AEC10E61F;
 Thu, 27 Aug 2026 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825911; x=1819361911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KTLf0Y4IQTLCQaJNElZWWxs395jzyzWna7ivpTy53Zw=;
 b=PZGEzi1hl/IZ8FnuheY6RIFzfs9WQwia5kD0TsoyN7V0qE+lOVqQiroi
 vMcsZD3NInd0yPW9jH8DCwdsOh5wdXJwIeWQHiUkal9VjNuZeWTJtajGk
 kXlMqNDK/sJ0kal0mXu6dv3I9IVKpSTldwS9rn6639A8jlCiCN3w+TQ1M
 6/ViqweyZEiPc/9KJXi5nJAd1hyvGnQm+7s6JRs1xHlGeSRB3D8y+35eS
 WteFcw+fXSga8T4vzgtDqMIPegaOg0RVUgmu0yrwtHyg/aX+fqhJ74FtC
 QZOrSbJKNBWVElBttTWkSKNApyHIEK+qHGiaxFRnPJvw657myzg5IteXf g==;
X-CSE-ConnectionGUID: vXmQQdP2T9CCP3fiZYmRUA==
X-CSE-MsgGUID: RIm2dR4ER8+YuaThNDIJ2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445857"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445857"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:31 -0700
X-CSE-ConnectionGUID: wCyLXC/4Rva4WgT8kWm/XQ==
X-CSE-MsgGUID: IhCXaGg2Rv2g0TW+RUclew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057607"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:29 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 01/13] drm/xe/irq: Always free requested IRQs on uninstall
Date: Thu, 27 Aug 2026 15:47:49 +0530
Message-ID: <20260827101801.1247654-2-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

Fixes: 4d79a1266d4c ("drm/xe: Make irq enabled flag atomic")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
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

