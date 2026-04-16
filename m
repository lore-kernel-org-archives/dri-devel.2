Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE1FF8D77C
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF7D10E15A;
	Thu, 16 Apr 2026 21:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="KrsbRkyr";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F1310E15A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776373257; x=1807909257;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=omhgJevx4k6eqBumpYHfvI4VTADx0TTBN7+wjbPnd6A=;
 b=KrsbRkyrid9yd4NP8dWN3tDej2cR0Q1ZaJ5GlFIrnCecXFfQjFWdzIpa
 dhkdC92aF6PsuShJ2dCx2Estwm7a6e/yB1l+LducJbzWMYoRfso5BbOih
 0MbJwILyvasOnuIv/tBSKbXEF3KdhAUNzGHLGBHfueFbacDrilc0O/AVT
 81zNURnme1Ma5zxEHkTWGeCD28UA+SoXRX1zR0GVLovU4b8giD2ztqcB9
 5sfJI0jPnzBPMuNYgcFtAzalRcJe7ZrIbA135yPNef6JdEKm+Jz7glnCK
 8oKuY4CxVAanRKv2QkjPXy85XUbKviILB1upjcuf4NbwEC1nl3mOqqdgW g==;
X-CSE-ConnectionGUID: AJc/DMsPSmqpHA2vKIpdEw==
X-CSE-MsgGUID: uocM4l2JQ/imqlKCUTj+sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="76553410"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="76553410"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 14:00:57 -0700
X-CSE-ConnectionGUID: iUsdlXd8QUOK7smy+4POWQ==
X-CSE-MsgGUID: otQfzzh7S3OvgUE2ZzYWIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; d="scan'208";a="254310609"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2026 14:00:54 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmerman@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: [PATCH] drm/auth: Only drm_drop_master if it exists
Date: Fri, 17 Apr 2026 05:00:47 +0800
Message-ID: <20260416210047.3904106-1-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
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

It is possible that both dev->master and file_priv->master are NULL when
passed to drm_master_release, which would result in dev being passed to
drm_drop_master (as NULL == NULL here).  This would result in a NULL
pointer dereference when passing dev->master to drm_master_put in
drm_drop_master.

Only call drm_drop_master if dev->master exists.  Also, make sure the
original calling requirement is maintained (dev->master ==
file_priv->master).

This fixes a static analysis issue.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/drm_auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
index e17bb0f1f9e0..e5013b870ba0 100644
--- a/drivers/gpu/drm/drm_auth.c
+++ b/drivers/gpu/drm/drm_auth.c
@@ -347,7 +347,7 @@ void drm_master_release(struct drm_file *file_priv)
 	if (!drm_is_current_master_locked(file_priv))
 		goto out;
 
-	if (dev->master == file_priv->master)
+	if (dev->master && dev->master == file_priv->master)
 		drm_drop_master(dev, file_priv);
 out:
 	if (drm_core_check_feature(dev, DRIVER_MODESET) && file_priv->is_master) {
-- 
2.53.0

