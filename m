Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D994CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9EA810E0C1;
	Fri,  8 May 2026 11:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dG/R8Grb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DAC810E0C1
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778238736; x=1809774736;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=9i4UXkiTi0qzlvvx1XqvxQArJ4VEq6Gv23WLkgfeHzI=;
 b=dG/R8GrbNye5iWv5pOSLIIFEIpBA2vSinhBbq2/SubpJEbOU8UJnyG94
 VrbVNsp8Lh+LaJ0HiR9cpKb9amnPrmzZ1EK0dCu70R0/cQoPFW42or3NH
 tLfvnW2JTFKtbB0CWvfaBoNOn9R0/0GUi9sHqu7SbFii4f//WM4WC2Fp/
 gQqirUMyV87nBKWBWtmCUDAaaCdR9QdfMS07UIDpndzgL+IUaqbfHtAZk
 ek5EXc/ExlFWIA3fIebgzR2pyETqSHLmpWVNuPDRvYZlhLKLhVB9A0q9J
 LqobIyA4LPQ2eWNM7immGSXWWubzDkV9LdCnhW818LG7EuM/gXUD/7avK A==;
X-CSE-ConnectionGUID: j8i3vPJrTlaKURhr7Z/u5A==
X-CSE-MsgGUID: 2V8wH6jOR328RtkNi1BrtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79245738"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79245738"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 04:12:14 -0700
X-CSE-ConnectionGUID: aj/9XFvpQyGBk0CnKExNvw==
X-CSE-MsgGUID: iKDiAKcIRYWGNQ4TtDydQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="230341304"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.40])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 04:12:13 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org
Cc: jani.nikula@intel.com
Subject: [PATCH 0/3] Documentation/gpu: tables of contents cleanups and fixes
Date: Fri,  8 May 2026 14:12:06 +0300
Message-ID: <cover.1778238671.git.jani.nikula@intel.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
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

Make the GPU documentation slightly easier to navigate.

Jani Nikula (3):
  Documentation/gpu: limit main toctree depth to 2
  Documentation/gpu: add some tables of contents to large documents
  Documentation/gpu/rfc: fix toctree

 Documentation/gpu/driver-uapi.rst     |  2 ++
 Documentation/gpu/drm-internals.rst   |  2 ++
 Documentation/gpu/drm-kms-helpers.rst |  2 ++
 Documentation/gpu/drm-kms.rst         |  2 ++
 Documentation/gpu/drm-mm.rst          |  2 ++
 Documentation/gpu/drm-ras.rst         |  2 ++
 Documentation/gpu/drm-uapi.rst        |  4 +++-
 Documentation/gpu/drm-usage-stats.rst |  2 ++
 Documentation/gpu/index.rst           |  1 +
 Documentation/gpu/introduction.rst    |  2 ++
 Documentation/gpu/rfc/index.rst       | 26 ++++++--------------------
 11 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.47.3

