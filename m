Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40A606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gIx6xwJX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5022110E81D;
	Tue, 24 Nov 2026 10:58:49 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3A9E10E672;
 Tue, 24 Nov 2026 10:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795517923; x=1827053923;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=98o+aDgbV9EfwRRQx4ZVtKvTcDkwwn9qBFkWlOnJEi0=;
 b=gIx6xwJXZ0EtkYEU+wDl1+Fri0wd9FZFKJbshLLGG2ipSkcBgf3zK4kX
 5jsR0UiwZezF0Lo6WnfxhFelCx4f2CHqiYHUxVxpD+az848ApqGZohz6K
 aaBVE6msoylPPNVuC/Vt/ZEvKJ35TK7068JabdBCu+l9ztsfmx91f22Le
 7q+w81eg7BDYTVLrOVVWeeJ6GFUmPj60nmNp46AZ9UQGvbtmi/w3NIebL
 0jKKBv35nhjkQgwO9C8dqXtJc7oIDVWs8m6/K/0BlzneYTYu7AM86Gd3q
 EYeeSSTi7faifxVSQRq7koyrzzBxI8mxbc9HuSQFKLqeHRFUBdTveYCOx A==;
X-CSE-ConnectionGUID: DthpINExQfyVN5mYYk+4Zg==
X-CSE-MsgGUID: wc20vGz9TEiGi9ZR5GpY6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4440464"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4440464"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 02:58:11 -0800
X-CSE-ConnectionGUID: 4nVnnpubRoC4FRqL1kccZw==
X-CSE-MsgGUID: bVuZCwJrTj2noveyqhDIPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11416955"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa004.jf.intel.com with ESMTP; 24 Nov 2026 02:58:09 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id 786D89D; Tue, 24 Nov 2026 11:58:08 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v1 1/1] drm/i915/hotplug: Use DEFINE_SHOW_STORE_ATTRIBUTE()
 helper for debugfs
Date: Tue, 24 Nov 2026 11:58:05 +0100
Message-ID: <20261124105805.617827-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Use DEFINE_SHOW_STORE_ATTRIBUTE() helper for read-write file to reduce some
duplicated code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_hotplug.c | 32 ++------------------
 1 file changed, 2 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
index d095eb13dc06..c47a7c9044e7 100644
--- a/drivers/gpu/drm/i915/display/intel_hotplug.c
+++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
@@ -1246,20 +1246,7 @@ static ssize_t i915_hpd_storm_ctl_write(struct file *file,
 
 	return len;
 }
-
-static int i915_hpd_storm_ctl_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, i915_hpd_storm_ctl_show, inode->i_private);
-}
-
-static const struct file_operations i915_hpd_storm_ctl_fops = {
-	.owner = THIS_MODULE,
-	.open = i915_hpd_storm_ctl_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.write = i915_hpd_storm_ctl_write
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(i915_hpd_storm_ctl);
 
 static int i915_hpd_short_storm_ctl_show(struct seq_file *m, void *data)
 {
@@ -1271,13 +1258,6 @@ static int i915_hpd_short_storm_ctl_show(struct seq_file *m, void *data)
 	return 0;
 }
 
-static int
-i915_hpd_short_storm_ctl_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, i915_hpd_short_storm_ctl_show,
-			   inode->i_private);
-}
-
 static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
 					      const char __user *ubuf,
 					      size_t len, loff_t *offp)
@@ -1324,15 +1304,7 @@ static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
 
 	return len;
 }
-
-static const struct file_operations i915_hpd_short_storm_ctl_fops = {
-	.owner = THIS_MODULE,
-	.open = i915_hpd_short_storm_ctl_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-	.write = i915_hpd_short_storm_ctl_write,
-};
+DEFINE_SHOW_STORE_ATTRIBUTE(i915_hpd_short_storm_ctl);
 
 void intel_hpd_debugfs_register(struct intel_display *display)
 {
-- 
2.50.1

