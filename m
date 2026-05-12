Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CEBCD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A4B110E5A8;
	Tue, 12 May 2026 19:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bZTsiV/U";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA3A10E5A5;
 Tue, 12 May 2026 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778613592; x=1810149592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CJe3bvXXWAkdGN+eiQJQP4xEWvdU0ibcZ7U45uNmSuY=;
 b=bZTsiV/UIqe9g4Dl/y8pGWxJWptYGqwoExjYfJp6A37OjmCJXYgHZonj
 6r1Jihjvl+Z3BoO7kuhkc4Zz684IN1nkNARKmLGaIL8AJZ4q64hyfdxcX
 l4DYRbcJ1fHsq/Lz8wafi/Wb1Gh5suCFUX+xV3XDMm/Dsk4Bj0E/Axmkr
 hHSQmy7GGOVczf07vxH/0RULydDbpHNSpbKqB5Jc/DBMSjqxTOIvxTVdP
 iTWW880wQlu/YRuSGefdEK8b4dFJx1X5HlvYSYn0GavdR7mpDEjkHo0mN
 jjFd9QoI9FDNaXcX07vxK4mGOXzej32da8AHZV9P7fmVnRfixaeJUPDtv g==;
X-CSE-ConnectionGUID: qq4BmvlMS7qwiQdxc6T94w==
X-CSE-MsgGUID: Jl7mRPmsTbi3u2i8Q7qwJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="83406351"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="83406351"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2026 12:19:52 -0700
X-CSE-ConnectionGUID: PCRQwbO6TF2tRHfDVbV30w==
X-CSE-MsgGUID: Pvgo9nFIRB6pmA7xTTNv+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; d="scan'208";a="237781427"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa008.jf.intel.com with ESMTP; 12 May 2026 12:19:47 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, anoop.c.vijay@intel.com,
 aravind.iddamsetty@linux.intel.com, Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 1/9] drm/ras: Update counter helpers with counter naming
Date: Wed, 13 May 2026 00:46:02 +0530
Message-ID: <20260512191610.1817578-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512191610.1817578-1-raag.jadav@intel.com>
References: <20260512191610.1817578-1-raag.jadav@intel.com>
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

Counter helpers deal with counter values. Use the appropriate naming to
match with their functionality.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..03db53d03329 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -168,8 +168,8 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
-static int msg_reply_value(struct sk_buff *msg, u32 error_id,
-			   const char *error_name, u32 value)
+static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
+				   const char *error_name, u32 value)
 {
 	int ret;
 
@@ -186,8 +186,8 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
-static int doit_reply_value(struct genl_info *info, u32 node_id,
-			    u32 error_id)
+static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
+				    u32 error_id)
 {
 	struct sk_buff *msg;
 	struct nlattr *hdr;
@@ -210,7 +210,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	if (ret)
 		return ret;
 
-	ret = msg_reply_value(msg, error_id, error_name, value);
+	ret = msg_reply_counter_value(msg, error_id, error_name, value);
 	if (ret) {
 		genlmsg_cancel(msg, hdr);
 		nlmsg_free(msg);
@@ -278,7 +278,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 			break;
 		}
 
-		ret = msg_reply_value(skb, error_id, error_name, value);
+		ret = msg_reply_counter_value(skb, error_id, error_name, value);
 		if (ret) {
 			genlmsg_cancel(skb, hdr);
 			break;
@@ -317,7 +317,7 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	return doit_reply_value(info, node_id, error_id);
+	return doit_reply_counter_value(info, node_id, error_id);
 }
 
 /**
-- 
2.43.0

