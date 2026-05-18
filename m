Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B45CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 14:15:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB9C310E886;
	Mon, 18 May 2026 14:15:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CjRRmKoh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815B010E884;
 Mon, 18 May 2026 14:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779113701; x=1810649701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=drAOgkSCOpci7XA/wV7u+sd99NUI4AHo9Xp2YycE4n0=;
 b=CjRRmKohYGf5/cSOj8AdkuhkYsXuIm/V2XL7nhpi7oI4bPJgVM1o+XdB
 aEpmMR2OVWswMSj8XGjl2HzZ1sfs/TytCwcugxyia3epO+HdwNlEOFT8v
 X7yoT/5KeGyP/AqEjwqqqHRCd7imwn3O/+mYxXKXwM3toZPGVrFtRNmXx
 Dlgzl72WxabnPDdBN8D8WIKeB45ifvCnjd6Iecnr6ccwh30GPIswRsyIt
 ia5YReeGOSjuNXPNKmnjvKolLHvz79nN4HDeEk2rEc5FN07//5OhjJFe5
 QpKZ5KrejP1iSsxYf/padWPNDPELwLpvWtwE/YGQlAvnPUOAmjKkUgirP A==;
X-CSE-ConnectionGUID: K/7qC4wxQLm52RZPHh5IoQ==
X-CSE-MsgGUID: Hl13NBMJSSS67LmIKXeASw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="79105898"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="79105898"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 07:15:01 -0700
X-CSE-ConnectionGUID: rOZN+S9wQtOW2fOyetZSBg==
X-CSE-MsgGUID: lhDR1jcXSgOkOYls7OAf0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="244417249"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO fdugast-desk.intel.com)
 ([10.245.244.73])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 07:14:59 -0700
From: Francois Dugast <francois.dugast@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, matthew.auld@intel.com,
 Francois Dugast <francois.dugast@intel.com>
Subject: [PATCH v3 2/5] gpu/buddy: Remove redundant condition in
 alloc_from_freetree() error path
Date: Mon, 18 May 2026 16:14:27 +0200
Message-ID: <20260518141446.124508-3-francois.dugast@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518141446.124508-1-francois.dugast@intel.com>
References: <20260518141446.124508-1-francois.dugast@intel.com>
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

The err_undo label in alloc_from_freetree() is only reachable via a
goto from inside the `while (tmp != order)` loop, which means tmp is
guaranteed to differ from order at that point. The surrounding
`if (tmp != order)` guard was therefore always true and can be dropped
without any behavioral change.

Signed-off-by: Francois Dugast <francois.dugast@intel.com>
---
 drivers/gpu/buddy.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dac2027bb64a..9f6696f47f89 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -849,10 +849,8 @@ alloc_from_freetree(struct gpu_buddy *mm,
 	return block;
 
 err_undo:
-	if (tmp != order) {
-		rbtree_remove(mm, block);
-		__gpu_buddy_free(mm, block, false);
-	}
+	rbtree_remove(mm, block);
+	__gpu_buddy_free(mm, block, false);
 	return ERR_PTR(err);
 }
 
-- 
2.43.0

