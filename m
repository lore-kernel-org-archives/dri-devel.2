Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A27CD3447
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 10:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5078610E2E6;
	Fri,  8 May 2026 10:21:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WxXcNDWD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44DE489349;
 Fri,  8 May 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778235661; x=1809771661;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=3jcqc+/gUzleI8Wi5ukl5J/EPADm702T7CnpcFWRUOg=;
 b=WxXcNDWDYrVniE1UAoKi9BvUe+Pdzpmoqi/pufZgLmDQ9PPH0bnFRHbM
 0+7L3IQSP7f13mZ/wh65YlP/CKOlk4+uQDZ6VrgKX+tdCCqacHZp4wGCq
 ZXFxTBnJ3NYGUBZn5SUhhgcjp6J4ZS/DmPtMVa3SP7MXPCl39FA7RntzB
 C4xD5BPgrwhrtQd+vhVqkVZaXPt2uYeDYgC3O6WPx/56RUWAD5Sby3ZlN
 NB53PzpFwKuaRHIWb+y+jdmEtcTiN31RUCRXuSfNyqaFrb2jVu/mFbkdC
 pHDHTm4A3zWjfjTaexcRumWByfB3+orMkh340TiL1TscmzlXMPU589j5O A==;
X-CSE-ConnectionGUID: 3q6UHLgIShSGGmLTtbMwSQ==
X-CSE-MsgGUID: wMcL+phvSwebk/G8OV7YvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79055456"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="79055456"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 03:21:00 -0700
X-CSE-ConnectionGUID: lMbkoIwSR/+VvLUyv6+IJg==
X-CSE-MsgGUID: 0hSwl9kSQ5CC7H8GcYPdvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="230333917"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost)
 ([10.245.244.40])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 03:20:58 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Cc: rodrigo.vivi@intel.com, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 0/3] drm/i915: reorganize display documentation
Date: Fri,  8 May 2026 13:20:46 +0300
Message-ID: <cover.1778235406.git.jani.nikula@intel.com>
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

Move Intel display documentation under Documentation/gpu/intel-display,
and reorganize into smaller documents. There's lots of room for
improvement, but it's a start.

I intend to merge this through drm-intel-next, as it's fairly isolated.

BR,
Jani.

Jani Nikula (3):
  Documentation/gpu: add dedicated documentation for Intel display
  Documentation/gpu: use === for Intel display section heading
    underlines
  Documentation/gpu: add remaining DOC: comments to Intel display
    documentation

 Documentation/gpu/drivers.rst                 |   1 +
 Documentation/gpu/drm-kms.rst                 |   3 +
 Documentation/gpu/i915.rst                    | 202 +-----------------
 .../gpu/intel-display/async-flip.rst          |   8 +
 Documentation/gpu/intel-display/atomic.rst    |  11 +
 Documentation/gpu/intel-display/audio.rst     |  23 ++
 Documentation/gpu/intel-display/casf.rst      |   8 +
 Documentation/gpu/intel-display/cdclk.rst     |  11 +
 Documentation/gpu/intel-display/cmtg.rst      |   8 +
 Documentation/gpu/intel-display/dmc.rst       |  26 +++
 Documentation/gpu/intel-display/dpio.rst      |   8 +
 Documentation/gpu/intel-display/dpll.rst      |  14 ++
 Documentation/gpu/intel-display/drrs.rst      |  11 +
 Documentation/gpu/intel-display/dsb.rst       |  11 +
 Documentation/gpu/intel-display/fbc.rst       |  11 +
 .../gpu/intel-display/fifo-underrun.rst       |  11 +
 .../gpu/intel-display/frontbuffer.rst         |  14 ++
 Documentation/gpu/intel-display/hotplug.rst   |  11 +
 Documentation/gpu/intel-display/index.rst     |  44 ++++
 Documentation/gpu/intel-display/plane.rst     |  11 +
 Documentation/gpu/intel-display/psr.rst       |  11 +
 Documentation/gpu/intel-display/snps-phy.rst  |   8 +
 Documentation/gpu/intel-display/vbt.rst       |  14 ++
 Documentation/gpu/xe/index.rst                |   5 +
 24 files changed, 290 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/gpu/intel-display/async-flip.rst
 create mode 100644 Documentation/gpu/intel-display/atomic.rst
 create mode 100644 Documentation/gpu/intel-display/audio.rst
 create mode 100644 Documentation/gpu/intel-display/casf.rst
 create mode 100644 Documentation/gpu/intel-display/cdclk.rst
 create mode 100644 Documentation/gpu/intel-display/cmtg.rst
 create mode 100644 Documentation/gpu/intel-display/dmc.rst
 create mode 100644 Documentation/gpu/intel-display/dpio.rst
 create mode 100644 Documentation/gpu/intel-display/dpll.rst
 create mode 100644 Documentation/gpu/intel-display/drrs.rst
 create mode 100644 Documentation/gpu/intel-display/dsb.rst
 create mode 100644 Documentation/gpu/intel-display/fbc.rst
 create mode 100644 Documentation/gpu/intel-display/fifo-underrun.rst
 create mode 100644 Documentation/gpu/intel-display/frontbuffer.rst
 create mode 100644 Documentation/gpu/intel-display/hotplug.rst
 create mode 100644 Documentation/gpu/intel-display/index.rst
 create mode 100644 Documentation/gpu/intel-display/plane.rst
 create mode 100644 Documentation/gpu/intel-display/psr.rst
 create mode 100644 Documentation/gpu/intel-display/snps-phy.rst
 create mode 100644 Documentation/gpu/intel-display/vbt.rst

-- 
2.47.3

