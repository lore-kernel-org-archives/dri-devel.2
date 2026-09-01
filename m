Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D18BC61DD6
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 21:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4580310EF3C;
	Tue,  1 Sep 2026 21:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RBLz0DWY";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7773710EF2C;
 Tue,  1 Sep 2026 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788297927; x=1819833927;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=kIj3SQ38TZT4z5GtBLMD6A8gzF/051ealJf9nGBjOAg=;
 b=RBLz0DWY9Ung9Sw4zq+SNAPL54AUgvMUFJBwZRY+Eei3gQXn0CmTNcI5
 RFDpX1CadRv0pWqGUyz2QRuD3zeQt1erdnrfcDf1U/LBSLYAs99ZtH/o6
 63zkSmnrA+mmSOUOflGMAvO7l8S2uGzsbOOgptgkAKVjVOE4wrs0H1knW
 UnjLBgYQm/d0zvGJTKUV5rvFp7F3lq8/ZYbSk6beO8N4rrTlliSRA1ja6
 X396UOTplxXyLCV9t4lYbTJsRtTqXFanruiegKl5It0iK6nzXBpnQzXH7
 gMpOcZ4qt/IFSRJ0Vj8e+R1ZrbD7z4pSb7S4kW8wj5BzmrIOoQ2QX+NKF g==;
X-CSE-ConnectionGUID: 2HrOT7XMR4G7cjThlRolOw==
X-CSE-MsgGUID: ff6aQc+9S6eYhG8EKYyRvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="92442099"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="92442099"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 14:24:52 -0700
X-CSE-ConnectionGUID: xOCjMqKxQIa4ZAinPOxBJg==
X-CSE-MsgGUID: uKE38tjGTOON/6VK4ceBlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="265970521"
Received: from vbelgaum-ubuntu.fm.intel.com ([10.1.39.16])
 by fmviesa007.fm.intel.com with ESMTP; 01 Sep 2026 14:24:51 -0700
From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH v5 0/2] perf: Add some null ptr checks
Date: Tue,  1 Sep 2026 14:19:13 -0700
Message-Id: <20260901211915.127704-1-vinay.belgaumkar@intel.com>
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

Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

Vinay Belgaumkar (2):
  perf: Fix null pointer access in is_include_guest_event()
  perf: Add checks to prevent null ptr access

 kernel/events/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

-- 
2.38.1

