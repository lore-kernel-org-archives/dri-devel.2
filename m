Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C74EEC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 11:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3234610E7BF;
	Mon, 10 Aug 2026 11:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eEYviEbn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0A310E7BF;
 Mon, 10 Aug 2026 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786360824; x=1817896824;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wlS5EP4zWMyAAyJH8tlKdVXtEHtB+Rb5uUGHrnFmOLU=;
 b=eEYviEbnI+SohmaWzMI+kfEIi8pImiyrzLYLm26RK0ncWa3ieUZA4p+W
 NkviNEjgtEFkcpk0R20jGKZ1c6+idOEB91eDoInNZD6401cn74PRrIByy
 FxMpxNT/JB8X90+Y4kjgdmNn6XjyB9cziKdJEfLwJ33bvBN+eAO+2tt8b
 OcCH8lwfHAc0WhJixQL4yil+yfLGZpT/mFO8XXB2l2IhUzybQZy/B69cV
 p2c2CLIcYrgfKDAsBghBbZcUHrxBAaz26InBzK6oxhoxJj1qpmueByacq
 uBdqhIAQmFUxb8ts0uMzSfBYXD87w2sfPPELo41W5USlpgkcw9Y39gZmc Q==;
X-CSE-ConnectionGUID: uIhf3ZrVTPSVTCZPnE+L+Q==
X-CSE-MsgGUID: 4ssBpjsaSxasM84LGtC/8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97220922"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="97220922"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 04:20:24 -0700
X-CSE-ConnectionGUID: f62SmnVWTHu1sQZuIjsSpw==
X-CSE-MsgGUID: ZIgEncXNTUyIXfChAkYEaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="264998297"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 04:20:19 -0700
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
Subject: [PATCH v7 0/2] Add drm_ras netlink error event support
Date: Mon, 10 Aug 2026 16:50:09 +0530
Message-ID: <20260810112008.1858731-4-riana.tauro@intel.com>
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

Rev7: rebase
      remove unnecessary Revision history for patches(Rodrigo)

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
 drivers/gpu/drm/xe/xe_ras.c              |  69 ++++++++++++++++
 include/drm/drm_ras.h                    |   5 ++
 include/uapi/drm/drm_ras.h               |  15 ++++
 10 files changed, 303 insertions(+)

-- 
2.47.1

