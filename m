Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F720E9DE41
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 07:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9012E10E742;
	Thu,  9 Apr 2026 07:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aSKG1jV1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA49D10E742;
 Thu,  9 Apr 2026 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775718042; x=1807254042;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T4M9Ilus/mDBe+iZLkGYCpJEjvL/6Z+DbmJz4pcsGAg=;
 b=aSKG1jV1TbkIePqI5bKhYkmdMT7AqHKIoyDnmevSHHmSO3IJeoeuMnYj
 gPUn/phwQ52qOWCDTcoeZBm5Kuk5sSR6WtgPLpZFdGU48HQyCoYMdyLTY
 jXsRe1l91jLl7Dzge8GNe1rVJHHtsnY2NSp+pgyn1wEPPn8FkraOn2Jdi
 Uri9JxzKgSiWLFwfXFQcu50Otmc30sL1ml+/HuCz1Su1y5ySeG5rlkTiR
 qvHjVU61nY9nKbKhyCj358se3HEiPJqq+LvBZRBm/Vvlo0MK1ITxqRrik
 9eZQTr8Y6UeSWhN5nN/4qJ4yF50R0+k7NwuoyLfzUUoytwoXfdGlv8YbD w==;
X-CSE-ConnectionGUID: x0YXJ4GTQtm6GseY2K+2VQ==
X-CSE-MsgGUID: G+bZiPWOSmOlk40g7WW9AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76836418"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76836418"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:00:42 -0700
X-CSE-ConnectionGUID: egu1r6z2S0GbnisB6OAfQA==
X-CSE-MsgGUID: Und1Me7LQvGy6U6mPegjKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="233576390"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2026 00:00:37 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, anvesh.bakwad@intel.com,
 maarten.lankhorst@linux.intel.com, Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v2 0/2] Add clear-error-counter command to drm_ras
Date: Thu,  9 Apr 2026 13:03:18 +0530
Message-ID: <20260409073318.2909379-4-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
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

Add clear-error-counter command to drm_ras to clear a specific error
counter of a node. The request parameters for this command are
node-id and error-id and no response payload.
Implement the callback in XE driver to demonstrate usage.

Usage:

$ sudo ynl --family drm_ras  --dump get-error-counter --json '{"node-id":1}'
[{'error-id': 1, 'error-name': 'core-compute', 'error-value': 0},
 {'error-id': 2, 'error-name': 'soc-internal', 'error-value': 3}]

$ sudo ynl --family drm_ras  --do clear-error-counter --json \
'{"node-id":1, "error-id":2}'
None

$ sudo ynl --family drm_ras  --dump get-error-counter --json '{"node-id":1}'
[{'error-id': 1, 'error-name': 'core-compute', 'error-value': 0},
 {'error-id': 2, 'error-name': 'soc-internal', 'error-value': 0}]

Rev2: Split patches

Riana Tauro (2):
  drm/drm_ras: Add clear-error-counter netlink command to drm_ras
  drm/xe/xe_drm_ras: Add support for clear-error-counter in XE drm_ras

 Documentation/gpu/drm-ras.rst            |  8 +++++
 Documentation/netlink/specs/drm_ras.yaml | 13 ++++++-
 drivers/gpu/drm/drm_ras.c                | 43 +++++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c             | 13 +++++++
 drivers/gpu/drm/drm_ras_nl.h             |  2 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 35 +++++++++++++++++--
 include/drm/drm_ras.h                    | 11 ++++++
 include/uapi/drm/drm_ras.h               |  1 +
 8 files changed, 122 insertions(+), 4 deletions(-)

-- 
2.47.1

