Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0FDCD5BB1
	for <dri-devel@archiver.kernel.org>; Sat, 23 May 2026 05:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6022010E2DC;
	Sat, 23 May 2026 05:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AAaLEGFf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A1B10E2D6;
 Sat, 23 May 2026 05:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779512748; x=1811048748;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gkuieD8eV/+j4s6lzj6wHkqvLWyxzl9TyyHdZSnKt28=;
 b=AAaLEGFfpG2SgVuyn2xJKDOQboKGAEip0X1nL6GvFWnvpZwd0TnCoUAs
 0Enu1MUjoNNPL5aAluKipxYSeEstLCNrREpdvMnQzU+OSzRljQUTXHtqQ
 Q0R+q+STIGgppIXR2TtU8LWKW1GgpiD2YjwaD90K+yzd5BWMfGL5VX9Vu
 e0G3MAFSAlwfYCboeW4fltK2JwgpyzmxJKbEpUsBe27A8arPTkXqleqWU
 zxuU9scl1idZAhOvIWEAuXcBd13L6j1KX/l8U1iVJMJ2Wx/vaAqnec2x2
 aWkIgdTqQLGNS+/qxhc51U5DdVaFSOUut3kMc+aUxmYeutYByustUaTMs A==;
X-CSE-ConnectionGUID: l7DZ0TkkQuW9q5bgNjiWMg==
X-CSE-MsgGUID: j1fDTsgXQCuJ2glxe7xF4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="83013532"
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="83013532"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 22:05:48 -0700
X-CSE-ConnectionGUID: r0lcwrAuRUeCFs7N3G0o5Q==
X-CSE-MsgGUID: 4QQDWl+BQsiGI20G2jUnhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,163,1774335600"; d="scan'208";a="279199751"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa001.jf.intel.com with ESMTP; 22 May 2026 22:05:45 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com, riana.tauro@intel.com, dev@lankhorst.se,
 airlied@gmail.com, simona@ffwll.ch, kuba@kernel.org,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/4] drm/ras: Cancel and free message on get counter failure
Date: Sat, 23 May 2026 10:30:19 +0530
Message-ID: <20260523050212.557292-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260523050212.557292-1-raag.jadav@intel.com>
References: <20260523050212.557292-1-raag.jadav@intel.com>
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

doit_reply_value() directly returns on get counter failure, which results
in stale sk_buff and genetlink header that aren't cleaned up. Fix it and
while at it, consolidate error handling using goto.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
v2: Use goto (Riana)
---
 drivers/gpu/drm/drm_ras.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..467a169026fc 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -201,25 +201,28 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 
 	hdr = genlmsg_iput(msg, info);
 	if (!hdr) {
-		nlmsg_free(msg);
-		return -EMSGSIZE;
+		ret = -EMSGSIZE;
+		goto free_msg;
 	}
 
 	ret = get_node_error_counter(node_id, error_id,
 				     &error_name, &value);
 	if (ret)
-		return ret;
+		goto cancel_msg;
 
 	ret = msg_reply_value(msg, error_id, error_name, value);
-	if (ret) {
-		genlmsg_cancel(msg, hdr);
-		nlmsg_free(msg);
-		return ret;
-	}
+	if (ret)
+		goto cancel_msg;
 
 	genlmsg_end(msg, hdr);
 
 	return genlmsg_reply(msg, info);
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
 }
 
 /**
-- 
2.43.0

