Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8161BCD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 20:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A032B10EC03;
	Tue,  5 May 2026 20:04:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WFv0aaOj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D1210E244;
 Tue,  5 May 2026 20:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778011489; x=1809547489;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=hQj7ew5yyafwu7sHr5uG/ljaSR0u5Bsh/VcZf3IjKS0=;
 b=WFv0aaOjUyyFdanCI97dgzb/c+XbxtoZsrCKADYayu9aEgTANbNmLNxO
 UCLWru5ENPJlvQite06jk8yfBYm9hRzlT+tpvXpXqEaOzu8BQukwknbuN
 3WawxxFtE5hF23aHzyk8EWBDY5PyWs4D35vXwROdzuXc9bcJv70jjmC3Y
 2b8sf+4R9sK3ma0ut1+EtYzLvFb5ufoGB84I50EVjx/BRG23MlCVcjXJz
 yy1hDupPRmGArxGq1/xEW8s2lLhzOONe3ChZoQT8xG8Do6/XP9cO2vb6i
 k0lWXDHmEpTtP4yEh1FTPnm3sMqCeSQx6+0+/5jNefPjBjHQViQ1dVG3s Q==;
X-CSE-ConnectionGUID: ZdRNYnfmRWGYLbvGQuenlg==
X-CSE-MsgGUID: +w0CbzPgT/qC0ZFZO4L+PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78832982"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="78832982"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 13:04:48 -0700
X-CSE-ConnectionGUID: 5o4mBuOMTzufYX9WxkuehA==
X-CSE-MsgGUID: EVlu2UNdRFCmo/sxn+QxLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; d="scan'208";a="232786506"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 13:04:48 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/2] TTM shrinker fragmentation / partial restore fixes
Date: Tue,  5 May 2026 13:04:41 -0700
Message-Id: <20260505200443.3300962-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Fix shrinker fragmentation / partial restore fixes. Related to [1],
continuation of [2], patches have details.

Series working shrinker getting triggered in a loop plus the below error
injection:

cd /sys/kernel/debug/ttm/backup_fault_inject
echo 100 > probability
echo 3000 > interval
echo -1 > times
echo 0 > space
echo 0 > verbose
echo M > task-filter
cd -

Matt

[1] https://patchwork.freedesktop.org/series/165330/
[2] https://patchwork.freedesktop.org/series/165877/

v3:
 - Address sashiko concerns
v4:
 - Actual 'Save alloc in snapshot on restore failure (sashiko)' (missed
   local change)
v5:
 - Reordert tm_pool_apply_caching before restore free (sashiko)
 - Add ttm_pool_backup_folio helper (Thomas)

Matthew Brost (2):
  drm/ttm: Drop tt->restore after successful restore
  drm/ttm/pool: back up at native page order

 drivers/gpu/drm/ttm/ttm_pool.c | 125 ++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 19 deletions(-)

-- 
2.34.1

