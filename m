Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00534C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 15:54:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E385C10E14B;
	Wed,  2 Sep 2026 15:54:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="M1zLEGLR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE96B10E032;
 Wed,  2 Sep 2026 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788364453; x=1819900453;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5DZU0KY5CpBe8G1TILEFBoltajO1g2hHTfwVwPSzJso=;
 b=M1zLEGLR/W1oKIoNOOAsHV0wzfzxw342oxIG6eRPwROkcGi/yFsK396q
 mBg/PGVhuEV4Gq/SY+JCrvolam4GcVCWGwVClUW7Ygz2+ItbszBAC+WDg
 lyUBOc7jG759QatwvlKuVGcYSE5jjISP5gUo3znae17KsWqWMNSuaj4bw
 y6ZXNhXLBiKE21NMZYGSRGPVf/CsCJ4fPauIHZ7Lb2cgN5DTF3U/cBcvB
 dsHWPJ8a6GNHwgmZt8eAXu1pDheqDEGPRLQozy57P3XzQhwKTSRiPZij9
 E/kh86j13dREUYWzPwY2iVD66vZ22ZuWbvc1JiemEYMEzNbzAtd1N2LrG g==;
X-CSE-ConnectionGUID: S6C/12PZQGq/00PXLBACuQ==
X-CSE-MsgGUID: fPEmQV56TcW6DDa0ltA4rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="76379930"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="76379930"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 08:54:12 -0700
X-CSE-ConnectionGUID: VKYM8H/5RkGAiQr4encQww==
X-CSE-MsgGUID: nZIXxbL2QIO3+0a+q2aEcw==
X-ExtLoop1: 1
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa003.fm.intel.com with ESMTP; 02 Sep 2026 08:54:12 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v7 0/2] perf: Add some null ptr checks
Date: Wed,  2 Sep 2026 08:48:50 -0700
Message-Id: <20260902154852.742844-1-vinay.belgaumkar@intel.com>
X-Mailer: git-send-email 2.38.1
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

This series fixes a crash seen when the PMU ptr is freed while
there is an open perf connection.

v7: Minor fixes in commit message (Dapeng)

Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Vinay Belgaumkar (2):
  perf: Fix null pointer access in is_include_guest_event()
  perf: Add checks to prevent null ptr access

 kernel/events/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.38.1

