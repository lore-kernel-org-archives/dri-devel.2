Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550BBF99C6A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F36D10EAA2;
	Fri, 17 Apr 2026 21:21:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FSJ5an2R";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D436810E120;
 Fri, 17 Apr 2026 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776460875; x=1807996875;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MALbLYziloaJDRuruyVcQxrY3aqOoQHTCEpG6aNl2cM=;
 b=FSJ5an2R+nf/yQbs2DcTdHR48bBF6wsPDGTEcKPYmShnn8/wjlZ4+HjL
 z7IdNGmQ5BkMyLQvD5wy7wpg7ReWtetpNey4cVaPTa7FpF0JTNiIYceSk
 mXDn99kopIJ2FefzT52+DNDd2Wsek0s8DPIBCwlo31VWn8605NMnplZzc
 qAZ77tBmjN0XVHTxPksoaBsJJsh0l5GDuTg1aP3jUWISbrxwE+83USC39
 PDhSCUh8txOkCUjqL20lH7RmVYQWgUgM3MRqJO6+5NqkveOnb0GweSjcl
 wvqfi+mvNeaBY9pGAH17SRshL/vVCFQiNwbmRz2AwTjGNqzETXykotANe g==;
X-CSE-ConnectionGUID: U+yckEZ2Tm+zuB28ZkvPRQ==
X-CSE-MsgGUID: AbdxIc65Q0u6GSVu407Uag==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="95046083"
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="95046083"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2026 14:21:12 -0700
X-CSE-ConnectionGUID: yR/S2Ym7RUKLv0lJ03SwUA==
X-CSE-MsgGUID: 0k2huwCITbaeC12ChTghRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,185,1770624000"; d="scan'208";a="235503776"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 17 Apr 2026 14:20:59 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, maarten@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, umesh.nerlige.ramappa@intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 anoop.c.vijay@intel.com, aravind.iddamsetty@linux.intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 01/11] drm/ras: Update counter helpers with counter naming
Date: Sat, 18 Apr 2026 02:46:36 +0530
Message-ID: <20260417211730.837345-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417211730.837345-1-raag.jadav@intel.com>
References: <20260417211730.837345-1-raag.jadav@intel.com>
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
index b2fa5ab86d87..1f7435d60f11 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -162,8 +162,8 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
 	return node->query_error_counter(node, error_id, name, value);
 }
 
-static int msg_reply_value(struct sk_buff *msg, u32 error_id,
-			   const char *error_name, u32 value)
+static int msg_reply_counter_value(struct sk_buff *msg, u32 error_id,
+				   const char *error_name, u32 value)
 {
 	int ret;
 
@@ -180,8 +180,8 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
 			   value);
 }
 
-static int doit_reply_value(struct genl_info *info, u32 node_id,
-			    u32 error_id)
+static int doit_reply_counter_value(struct genl_info *info, u32 node_id,
+				    u32 error_id)
 {
 	struct sk_buff *msg;
 	struct nlattr *hdr;
@@ -204,7 +204,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 	if (ret)
 		return ret;
 
-	ret = msg_reply_value(msg, error_id, error_name, value);
+	ret = msg_reply_counter_value(msg, error_id, error_name, value);
 	if (ret) {
 		genlmsg_cancel(msg, hdr);
 		nlmsg_free(msg);
@@ -272,7 +272,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
 			break;
 		}
 
-		ret = msg_reply_value(skb, error_id, error_name, value);
+		ret = msg_reply_counter_value(skb, error_id, error_name, value);
 		if (ret) {
 			genlmsg_cancel(skb, hdr);
 			break;
@@ -311,7 +311,7 @@ int drm_ras_nl_get_error_counter_doit(struct sk_buff *skb,
 	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
 	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
 
-	return doit_reply_value(info, node_id, error_id);
+	return doit_reply_counter_value(info, node_id, error_id);
 }
 
 /**
-- 
2.43.0

