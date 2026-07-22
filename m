Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDBBC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 09:42:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8786010ED0C;
	Wed, 22 Jul 2026 09:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lU6G4AMc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A15D10E27F;
 Wed, 22 Jul 2026 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784713335; x=1816249335;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lV2TH5JFeo658sAQoo8B9k/C5PBNzfn6fQJmlaOnMDo=;
 b=lU6G4AMc/G6tzDkWE+gKsszaqiAk/GsPYViT79yhLh3pono4QQMq5t/4
 Atq0d+o43pfFhYyDtO458pZN6SKjLqvOOCFtFjj4Itnx0MyYUawclHB+j
 RsYKQrf/WSs0AjMmgbZQvzjohRPj3hc+gCDx0KbeyMC03uEe3Wm1c4mau
 qCR7HsBCB8Vp4Eb4yC+4Srx6xmb3LfBOkRERINvcytmtsNoYO5j5y6Plc
 iogdRsxzBmtIkFsHBxYzjKz1Ve029tPiHs/ltfiWZr/qZuog0E7pa4a4X
 2/9HIWScus0iaUQLJVhEPw30T++8D/oYTKQtjPZJ/6cdMnngqNYAOt+Fs Q==;
X-CSE-ConnectionGUID: X36swYScQFugrbITE5xV8Q==
X-CSE-MsgGUID: YcKXOxxOTS2n0NdlTgwLDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11853"; a="95706069"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="95706069"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 02:42:14 -0700
X-CSE-ConnectionGUID: HdtI5MTHQdyUDholT7uFXA==
X-CSE-MsgGUID: j7mIpx3+Q12j78GLFfEOhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; d="scan'208";a="254647365"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 02:42:08 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, maarten.lankhorst@linux.intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH v6 0/2] Add drm_ras netlink error event support
Date: Wed, 22 Jul 2026 15:11:35 +0530
Message-ID: <20260722094134.3036087-4-riana.tauro@intel.com>
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

Define a new netlink event 'error-event' and a new multicast group
'error-report' in drm-ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Wire this support to xe_drm_ras to report to userspace whenever a
correctable/uncorrectable error occurs on CRI.

$ sudo ynl --family drm_ras --output-json --subscribe error-report

{
    "name": "error-event",
     "msg": {
         "device-name": "0000:03:00.0",
         "node-id": 1,
         "node-name": "uncorrectable-errors",
         "error-id": 1,
         "error-name": "core-compute",
         "error-value": 1
     }
}

Rev2: use ynl in document and commit message
      fix cosmetic review comments
      simplify caller

Rev3: replace error-event with error-report
      had has_drm_ras check
      add support for correctable errors in CRI

Rev4: send an event at most once per component for each interrupt
      add xe_warn for unexpected values from firmware
      fix sashiko reported issues

Rev5: Remove has_listeners
      send netlink event to all network namespaces

Rev6: Add additional checks for event
      remove unnecessary checks in xe_ras

Riana Tauro (2):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_ras: Report correctable/uncorrectable error events to
    userspace

 Documentation/gpu/drm-ras.rst            |  21 +++++
 Documentation/netlink/specs/drm_ras.yaml |  48 +++++++++++
 drivers/gpu/drm/drm_ras.c                | 101 +++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |   6 ++
 drivers/gpu/drm/drm_ras_nl.h             |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c          |  31 +++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |   3 +
 drivers/gpu/drm/xe/xe_ras.c              |  68 +++++++++++++++
 include/drm/drm_ras.h                    |   5 ++
 include/uapi/drm/drm_ras.h               |  15 ++++
 10 files changed, 302 insertions(+)

-- 
2.47.1

