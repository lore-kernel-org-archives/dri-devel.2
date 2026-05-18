Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4E7CD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F194910E7AB;
	Mon, 18 May 2026 10:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ehMVWBBa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDB610E7AA;
 Mon, 18 May 2026 10:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779101249; x=1810637249;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=xWNtN1cj4AsYyc9Iat1gRK5QjeGRUVeuYGCtX8xSifY=;
 b=ehMVWBBarcHWGCgyLBT+l/txEJWW3akNu6V3Z0m3SZ1TTvpIEowSuH9Z
 BoXSPnpsa26twpU2YBvcSxTxJQFUu9cUi7fihkhlQQ2vuUwdUSmCsiC37
 OBu98/XaLIP/Zp1LpIDLqPyDTA3U58CfJdAkz2knho5QW7++f9XS6LuzA
 EY4UQoY5ud8IXN/rDxhGmmzBAqby+ZKMWfxFxKiPq0yepv9UfXYJZagBU
 fvxhVDZr+kDDeMo77sEV5+WKZSEL90i2Pr3GcTu99v+gndWQI2yxiYDoT
 kB02V+ns08QnwiI9ZUqnBRmnUq6fzqNDEzzoa3lWZOrkmWzLQ7YOmq5XE A==;
X-CSE-ConnectionGUID: fiI31Ts2Tw6hTi20MQyXZA==
X-CSE-MsgGUID: F4vh8aB6RmqD4ZPq1cccOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79802317"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="79802317"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 03:47:29 -0700
X-CSE-ConnectionGUID: X+NZTGi4RM2XZrI7tfDYYw==
X-CSE-MsgGUID: 882RT+XzTd6br+NdoXihdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="243688370"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 03:47:24 -0700
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
Subject: [PATCH 0/2] Add drm_ras netlink error event support
Date: Mon, 18 May 2026 16:50:49 +0530
Message-ID: <20260518112048.1746280-4-riana.tauro@intel.com>
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
'error-notify' in drm_ras. Each event contains device name, node and
error information to identify the error triggering the event.

Add drm_ras_nl_error_event() to trigger an event from the driver.
Wire this support to xe drm_ras to notify userspace whenever a GT or
SoC error occurs in PVC.

$ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --output-json \
--subscribe error-notify

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

Riana Tauro (2):
  drm/drm_ras: Add drm_ras netlink error event
  drm/xe/xe_drm_ras: Add error-event support in XE drm_ras

 Documentation/gpu/drm-ras.rst            | 21 ++++++
 Documentation/netlink/specs/drm_ras.yaml | 50 ++++++++++++++
 drivers/gpu/drm/drm_ras.c                | 86 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_ras_nl.c             |  6 ++
 drivers/gpu/drm/drm_ras_nl.h             |  4 ++
 drivers/gpu/drm/xe/xe_drm_ras.c          | 29 ++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |  6 ++
 drivers/gpu/drm/xe/xe_hw_error.c         |  7 +-
 include/drm/drm_ras.h                    |  5 ++
 include/uapi/drm/drm_ras.h               | 15 +++++
 10 files changed, 228 insertions(+), 1 deletion(-)

-- 
2.47.1

