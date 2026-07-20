Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355B4C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73EB510E801;
	Mon, 20 Jul 2026 08:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RXlJfjUl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF22310E7FF;
 Mon, 20 Jul 2026 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784535744; x=1816071744;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0q1JjJT+NyJ3KoGJBvEOCOT0C4whnoSf+Mg9FkxS1XI=;
 b=RXlJfjUlZu2sXlv1Qh/ulqYq5mVFyaSLIl3+dkkH4vlyi8pdgQ0+P6Ba
 S0iNbLir9lFBRkDFuzZEELCgI2QtdR/n9zStKITIoT+9VXgLGs+NWwebN
 Gtsv3j1RmBc+3kM0wvRCJWSEoKHy2Dlhs/iAhmlXY4QFKCfgaqEh/QqcX
 b5IY8OzaDNJVjrMc7Eow1wQdf4TIvKrQN+28gQGl8FlLZ0ugtOOdM/CsR
 hWb9TFlXgQIagujAMCXWASA/yMeRotulwY6Sr9NXDx+9a4V/hHj9Q9vqV
 50zs+nRj+IzXDzq9uT80Py/eGufsWB0TzvXpjBqeWaRAwpFJnVEL5kurC w==;
X-CSE-ConnectionGUID: KEHoHw/kTl+O5tW3sbQo1A==
X-CSE-MsgGUID: 1Vo2nSpXQzu22dfiYXd/nQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85228579"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85228579"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:22:24 -0700
X-CSE-ConnectionGUID: xFMmqMuHQjGxdpCWUBrHDg==
X-CSE-MsgGUID: p68X0I5VQQ+yAaawjcofPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="258034723"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 01:22:20 -0700
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
Subject: [PATCH v5 0/3] Add drm_ras netlink error event support
Date: Mon, 20 Jul 2026 13:52:09 +0530
Message-ID: <20260720082208.2648279-5-riana.tauro@intel.com>
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
'error-report' in drm_-as. Each event contains device name, node and
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

Riana Tauro (3):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_ras: Report correctable error events to userspace
  drm/xe/xe_ras: Report uncorrectable error events to userspace

 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 48 ++++++++++++++
 drivers/gpu/drm/drm_ras.c                | 84 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 42 ++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |  3 +
 drivers/gpu/drm/xe/xe_ras.c              | 74 +++++++++++++++++++++
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 +++++
 10 files changed, 302 insertions(+)

-- 
2.47.1

