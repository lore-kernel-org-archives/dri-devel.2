Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4EBCD342C
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 03:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F1710E909;
	Tue,  5 May 2026 03:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="h/PHX0u/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B90510E091;
 Tue,  5 May 2026 03:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777950897; x=1809486897;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=pP9Be3xXXUZBGLUZoyY7+dpXUN4c+v9+enaWivJcXkw=;
 b=h/PHX0u/QbDxfqtedwGJ4kOCXAAOM95Dy4KTH0tB9qBjWESRMXBLLz2J
 1tsMXRT68z1E4tVEtvN+PvCHKCe9SgUterk3Ad32B3flHTMzO3FNUvejs
 teuVSk6XnApB8salhU1AOlRZe9boyC0/9IfrjMJ8jFZhbmSjQ2LluNNNz
 XfANeiH4QO5eFZT1mWjiWLBV3Z7N5sQgF1e4fmigDMvVuiWIQS3KdPRil
 D4HPz6yarMPNVgSTy7t00DdogjthlBjiVODV+LhXr4D2dMBPouBU9/bUB
 jujnsqbkrWubvf0VppV40j4glvSQIpUjyehElraSeO8JBcaWeY3e8S3vI A==;
X-CSE-ConnectionGUID: w/yRK3u6QOKF0VADCJp+Sg==
X-CSE-MsgGUID: nUhsbcvVQaG5ZsrrtUAyTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78837534"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="78837534"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 20:14:55 -0700
X-CSE-ConnectionGUID: N/pE9zprRxWV5B2YgWpvZA==
X-CSE-MsgGUID: XOazvYOEQWavYJRoFcm3xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; d="scan'208";a="235939031"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2026 20:14:56 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/2] TTM shrinker fragmentation / partial restore fixes 
Date: Mon,  4 May 2026 20:14:48 -0700
Message-Id: <20260505031450.3262489-1-matthew.brost@intel.com>
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
continuation of [2] Patches have details.

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

Matthew Brost (2):
  drm/ttm: Drop tt->restore after successful restore
  drm/ttm/pool: back up at native page order

 drivers/gpu/drm/ttm/ttm_pool.c | 102 +++++++++++++++++++++++++++------
 1 file changed, 84 insertions(+), 18 deletions(-)

-- 
2.34.1

