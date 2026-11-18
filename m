Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A69606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 21:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VjGKFIkr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12B0112053;
	Wed, 18 Nov 2026 21:46:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 741C911201C
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795038363; x=1826574363;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XKcIWNixkG1cL2SXOlGvjZOBAhQw8BrYvNsGMzKzKm8=;
 b=VjGKFIkr3+YiGGiBf6q93AzpOAUDCE99y8NGGPxbuIeaURq63iD6Y3x4
 Xhsc+YYePf05Ky3klR1LUf7NqUq6yLhj+YgZmRjq86bMZzLT3kJtp61+7
 /V/9YT7Ekk0Kp/gMoClwZ+fpvrXtiQjl6uljMuBbhocRQfR5lLHhIYttG
 EdtJFb4Hqv6INffx1gDejcpmaLaxKJa0oNxFsmx+mnkR12ZpZ91i0FYzE
 EKAVc+pPLHylCtgwPmPJl8IpOLBZlmzBtk7ZB0JwM33IJu78o70dbAhg/
 qGqMxFAYoAvWkl5PmvEpocIHs6D25+z6VQ+NhgO9ylzy3pnN1vlo3yjnl g==;
X-CSE-ConnectionGUID: N8rTzPGyR5azPyzAZnxEnA==
X-CSE-MsgGUID: oLJmubeyRyGoEhjYaeXa9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3758167"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3758167"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:03 -0800
X-CSE-ConnectionGUID: lzQZq4TzQua/oApMmZlkIw==
X-CSE-MsgGUID: 6cLg93zrQ9KaHREAuJrI6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; d="scan'208";a="10647076"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.245.16])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2026 13:46:02 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: Russell King <linux@armlinux.org.uk>
Subject: [PATCH v4 07/20] drm/armada: Fix armada_debugfs_crtc_reg_write()
 return type
Date: Wed, 18 Nov 2026 23:45:04 +0200
Message-ID: <20261118214518.29317-8-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
References: <20261118214518.29317-1-ville.syrjala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Change the armada_debugfs_crtc_reg_write() return type to
the correct ssize_t. This makes the code actually build on
certain architectures.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/armada/armada_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index 2445365c823f..5d2af08b9397 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -50,7 +50,7 @@ static int armada_debugfs_crtc_reg_open(struct inode *inode, struct file *file)
 			   inode->i_private);
 }
 
-static int armada_debugfs_crtc_reg_write(struct file *file,
+static ssize_t armada_debugfs_crtc_reg_write(struct file *file,
 	const char __user *ptr, size_t len, loff_t *off)
 {
 	struct armada_crtc *dcrtc;
-- 
2.56.0

