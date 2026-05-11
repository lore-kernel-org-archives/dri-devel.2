Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2725DCD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 14:25:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86C6110E792;
	Mon, 11 May 2026 14:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X1rrK4TY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10A5310E792
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778509553; x=1810045553;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=QaRL90yyKRYJf2/QGkjbRLAMcFvanLvA5zXjYzi0ksk=;
 b=X1rrK4TYOXpevjCCMOm/Vizv1HVkr7vbJCnzgjNzpwCumytnTTkpNlFv
 WgE1+3FRc0ZMhcZlXVixg5hG63nz85Cdtu0DtAbRnIRwdjmlXc+GsVI4b
 9TduXeVzGh3AjPP6wID+0NGOB1P9Wn2z+P6kW7vsznqRlQwI1FP0sagne
 Z9oEKUrbNyb5G6AQpl34+3pFCwnMFwSkSZo2F4IPXglqdA/l1aKMWglWK
 jChxTXbWMdMNWnacjbD7bJsxfwiRa90SYw9XRMf5vSZ6l7oFnAAmfFJq1
 9PKIcJyrvIxX2nWTmf0/jr2j+S+NhdQMXvc6lblSeEtTNSD3tXMSfPPlU Q==;
X-CSE-ConnectionGUID: QOHVdMz0QiW0fGPln/aSvQ==
X-CSE-MsgGUID: ehf8dm93R/G2O00ztnv/DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="96961226"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="96961226"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 07:25:53 -0700
X-CSE-ConnectionGUID: g+NyUk49SsiDTBzzCo+GYA==
X-CSE-MsgGUID: 7XtGAQvRT7ah+wP4EQ9HUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; d="scan'208";a="234807071"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2026 07:25:50 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gem: Remove unneeded ret check in change handle ioctl
Date: Mon, 11 May 2026 22:25:40 +0800
Message-ID: <20260511142540.2989187-1-jonathan.cavitt@intel.com>
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

Remove the "if (ret < 0)" branch after idr_replace in
drm_gem_change_handle_ioctl.  It is unused, as in the only place we
modify the return value between there and the previous return value
check, we also immediately jump to out_unlock, bypassing the check
entirely.

Issue caught by static analysis.

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/drm_gem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index abc8e41d6652..110bc5a58862 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1067,9 +1067,6 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 
 	spin_unlock(&file_priv->table_lock);
 
-	if (ret < 0)
-		goto out_unlock;
-
 	if (obj->dma_buf) {
 		ret = drm_prime_add_buf_handle(&file_priv->prime, obj->dma_buf,
 					       handle);
-- 
2.53.0

