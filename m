Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A0BC5DF74
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86CC410EB8E;
	Tue, 18 Aug 2026 13:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LDrZbMYx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1381610EB8C;
 Tue, 18 Aug 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787061262; x=1818597262;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1XTJMHORqJ2wFunzykShatjYkKBFknM2dQKtqWIEXJI=;
 b=LDrZbMYxoEtZ4eH1qk7sC+2sQup5Q4zWQum8+Oxa/8ZxB4x58nHwW+L9
 Dzw/HhfrgjQ7AZwqmVcryP1vIYK4igEBFHqrsuDNnPYwXyPoeG5XNOMS3
 R4+M7lG+opCOjrL8vEguwQl/so5k5DS1ZKA+P+UvAyEWRxmKj09rxFFu3
 05Ig+IZntlmM0kS83Ro8+tx+6Q1fjcbb8Ns4L/vUOisUVX/5g4pA3+qWO
 2Num7PKIZ4mauNis0JYnJLhyI7EnLRDTNc7JiAi3S+6m0+Kh3jdlCTgCL
 8ZuxFaVWdwssRDLf5VDhhWlOt/Xhde5XTM5f9mYXPz/ZLgMKFi9AV4edp g==;
X-CSE-ConnectionGUID: 20nhpCsPQA2IrwbmuW3/jw==
X-CSE-MsgGUID: R8ioEkyTRn2igM5L36dZGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87315112"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87315112"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 06:54:22 -0700
X-CSE-ConnectionGUID: U1IIre1OQYKwqiGi6GsB5w==
X-CSE-MsgGUID: NppMlLOWSF+fCO7vjG8KCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="261021583"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 18 Aug 2026 06:54:17 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, dev@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, mallesh.koujalagi@intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v6 1/5] drm/ras: Cancel and free message on get counter failure
Date: Tue, 18 Aug 2026 19:22:05 +0530
Message-ID: <20260818135304.497098-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818135304.497098-1-raag.jadav@intel.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
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
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
v2: Use goto (Riana)
---
 drivers/gpu/drm/drm_ras.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index 39155fb514de..4fa1a257b0ed 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -234,25 +234,28 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 
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

