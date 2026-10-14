Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC93CC6B2F
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:02:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 594E810EACA;
	Wed, 14 Oct 2026 19:02:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CFA10E156;
 Wed, 14 Oct 2026 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792004541; x=1823540541;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=hKUHWtuWX0t4EsYXN5iXg4yNlvHhbuUWHaJutwThhVE=;
 b=lrt2L/q2rYN8JOATxn+KoC0sHlbBLifEQpDtTonkqofeR9oN3yRURLec
 pnpFcMpkpyfFT6Zk5ZMoTnHe/FbEYBivVojpznPUFJEzkZHikTCrh86jK
 YzoYElznhTaASt50s2hZmuBIzF4yQ+10IAC2cubHcU/GVc+J0mF5ddU80
 dpb0mS0JmVUZMN84qEwxo8+P7la/qVTXxVUEawp0DXSURm0Qt2QLkKcq+
 9vs+tBJ8DvXZmq2zi1UXdcTYFatRsB/7ebi3yJPuTw+mzN2aV8O8MST9w
 tYUzzKrT468C/4rfQz1Vqu0GbNZgdTiu2CxhRQWi/sodgAJAlJjkhyI+l g==;
X-CSE-ConnectionGUID: LiEIofF9RuSKEQoQEJKycg==
X-CSE-MsgGUID: 4WYy4X/rSj6igyOBiyx4og==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="648024"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="648024"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:10 -0700
X-CSE-ConnectionGUID: IcFaqx81TD28GtGTNBM0ww==
X-CSE-MsgGUID: cLOS+vDHTjCEOCehtEqAMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1941295"
Received: from nvishwa1-desk.sc.intel.com ([172.25.29.126])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 12:02:10 -0700
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 matthew.brost@intel.com, tzimmermann@suse.de
Subject: [PATCH v3 4/6] drm/panthor: use drm_gem_prime_self_import() helper
Date: Wed, 14 Oct 2026 12:02:04 -0700
Message-ID: <20261014190200.1700470-12-niranjana.vishwanathapura@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
References: <20261014190200.1700470-8-niranjana.vishwanathapura@intel.com>
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

Replace the open-coded self-import check with the drm core
helper drm_gem_prime_self_import(), which performs the same ops and
device match and returns the backing GEM object with a reference.

Assisted-by: GitHub-Copilot:claude-opus-4.8
Signed-off-by: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 72908be5e144..7f713c5f19cb 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -584,15 +584,11 @@ struct drm_gem_object *
 panthor_gem_prime_import(struct drm_device *dev,
 			 struct dma_buf *dma_buf)
 {
-	struct drm_gem_object *obj = dma_buf->priv;
+	struct drm_gem_object *obj;
 
-	if (dma_buf->ops == &panthor_dma_buf_ops && obj->dev == dev) {
-		/* Importing dmabuf exported from our own gem increases
-		 * refcount on gem itself instead of f_count of dmabuf.
-		 */
-		drm_gem_object_get(obj);
+	obj = drm_gem_prime_self_import(dev, dma_buf, &panthor_dma_buf_ops);
+	if (obj)
 		return obj;
-	}
 
 	return drm_gem_prime_import(dev, dma_buf);
 }
-- 
2.43.0

