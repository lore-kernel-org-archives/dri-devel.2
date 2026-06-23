Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E12CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DE9C10EA67;
	Tue, 23 Jun 2026 10:14:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xy2U62Qs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF75E10EA5C;
 Tue, 23 Jun 2026 10:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782209693; x=1813745693;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SMkf0D+YV5OJmnBlJj4MkBurBCKh39zccp5DMkHXsoY=;
 b=Xy2U62QsJKpu1JtXtAwdzlKBMg1sxY1OeHCd2cz7ffbFiAPm410KXE7U
 eB85BLT0jOuQ+lefm2xHmbd8Aq85IFn3sqsWvgVshEiKGWILTW9+cZddh
 SZYz1q6VRdCKvPMIMbGU2PTtRS+JJMUT1/UCxO4ZKUasU2HhqeOq+vpGr
 QeStK7IiJhbbvhBfRtqYhLndsLGC8+hMoH5VztoLzhh/qTent7AwadXfC
 oZvIfmhC5awzwNpLsD1HaYplajMuTWAnqhxyrOMOZzVzSAILm0LSEWos7
 RYu30pclDXNbtB7Cwo3B+ziUNnxdPUOEGeA/QmsJoUqBIReLfqjgfMBTW Q==;
X-CSE-ConnectionGUID: VuaGYbWLSsm9//sE/tzxDg==
X-CSE-MsgGUID: JmYoXNghTymlHb36QEg3BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82053141"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82053141"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 03:14:52 -0700
X-CSE-ConnectionGUID: R1kV7eFJQm+LHHdZwJKo8w==
X-CSE-MsgGUID: GJD4eZNlTgyFMek7vzSAjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="273175461"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa002.fm.intel.com with ESMTP; 23 Jun 2026 03:14:47 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, kuba@kernel.org,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, dev@lankhorst.se,
 zachary.mckevitt@oss.qualcomm.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, michal.wajdeczko@intel.com,
 matthew.d.roper@intel.com, mallesh.koujalagi@intel.com,
 Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v4 0/5] Introduce error threshold to drm_ras
Date: Tue, 23 Jun 2026 15:39:54 +0530
Message-ID: <20260623101043.255897-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
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

This series introduces error threshold to drm_ras infrastructure. This
allows user to get and set the error threshold of a specific counter.

Detailed description in commit message and documentation.

v2: Document threshold definition (Riana)
    Return -EOPNOTSUPP on threshold callbacks absence (Riana)
    Cancel and free genlmsg on failure (Riana)
    Document threshold bounds checking responsibility (Riana)
    Add RAS operation status codes (Riana)
    Use goto (Riana)

v3: Move documentation from yaml to rst file (Riana)
    s/value/threshold (Riana)
    Use goto for error handling (Riana)
    Reuse status codes and uapi mapping from counter series (Riana)
    Access request/response counter using local pointer (Riana)
    Mark unused field as reserved (Riana)
    Return -ENOENT on info absence (Riana)

v4: Clarify 0 threshold expectations (Riana)
    Drop redundant wrapping (Riana)
    Make debug logs consistent (Riana)
    Update kdoc (Riana)

Raag Jadav (5):
  drm/ras: Cancel and free message on get counter failure
  drm/ras: Introduce error threshold
  drm/xe/ras: Add support for error threshold
  drm/xe/drm_ras: Wire up error threshold callbacks
  drm/xe/sysctrl: Reuse xe_sysctrl_create_command()

 Documentation/gpu/drm-ras.rst                 |  18 ++
 Documentation/netlink/specs/drm_ras.yaml      |  32 ++++
 drivers/gpu/drm/drm_ras.c                     | 178 +++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c                  |  27 +++
 drivers/gpu/drm/drm_ras_nl.h                  |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c               |  34 ++++
 drivers/gpu/drm/xe/xe_ras.c                   | 105 +++++++++++
 drivers/gpu/drm/xe/xe_ras.h                   |   2 +
 drivers/gpu/drm/xe/xe_ras_types.h             |  51 +++++
 drivers/gpu/drm/xe/xe_sysctrl_event.c         |  28 +--
 drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h |   4 +
 include/drm/drm_ras.h                         |  28 +++
 include/uapi/drm/drm_ras.h                    |   3 +
 13 files changed, 487 insertions(+), 27 deletions(-)

-- 
2.43.0

