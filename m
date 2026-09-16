Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4506C982C3
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5755C10E135;
	Wed, 16 Sep 2026 13:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dZoo+7FG";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DADA10E082;
 Wed, 16 Sep 2026 13:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789567112; x=1821103112;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=OBrCFnlTEIjhGfk9QvWKZR2eOFWSEpqthqxToIFrvi8=;
 b=dZoo+7FGvyTZaiVDKl/hTgX6pujCwqcLZFWCYzeUvGS99jJbiqpidrH/
 VS+YIQLGEn/FwwcFjMEhSwA9G1B4Vx6t/z8HO2fTNyViKfHa2pK1deFua
 8pWxt3q8ka/VWPr+VwAdZmLfqyApOhF3f4IxqKRGtUi9GUcinyxz6Qpwn
 aaALznSY1/Ja4+F8vIxVzTnvAUi1YiiF45xRGeF8xmkzFHl06VLIb9tHi
 k9sV7jHDsEE7OUi2nTB4TQONEbzmzbf2zklJ/scd/wIjAAlnhhQ9bM3lD
 I83vSH/zF7x/cGhpPTd26ezRfd+y872s8GK+qBANfxP3Hdmwqz8VBTpsW Q==;
X-CSE-ConnectionGUID: UyeijytFTWSwehEXrdFIrg==
X-CSE-MsgGUID: zsxS+d3bQuWsIPh42WQmHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89881921"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89881921"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 06:58:32 -0700
X-CSE-ConnectionGUID: oSCES6cPTaW5GTvUEWGfOA==
X-CSE-MsgGUID: mNCRndabQdqBoNABN76Pew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="277475747"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 06:58:29 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v2 0/2] drm/xe/nvm: add survivabilty partiton
Date: Wed, 16 Sep 2026 16:58:14 +0300
Message-Id: <20260916-cri_surviv-v2-0-7de1b5328204@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23M0QoCIRCF4VdZ5jrDMdToqvdYlhAb24HS0E2Kx
 XfP9rrL/8D5ViiUmQqchhUyVS6cYg+1G8DPLt5I8LU3KKmMtKiFz3wpr1y5Cu1McMHqowkI/fD
 MFPi9YePUe+aypPzZ7Iq/9S9TUUhh0JpD91Bac+a40H3v0wOm1toXylX+YaQAAAA=
X-Change-ID: 20260715-cri_surviv-5a6faf7586f1
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Menachem Adin <menachem.adin@intel.com>, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789567108; l=1433;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=OBrCFnlTEIjhGfk9QvWKZR2eOFWSEpqthqxToIFrvi8=;
 b=bSma6OrE6Kw7lv2dmBhNpnouKEamhknl8paaF2K1r4ItswUjA9xiLrZ5WTCErkC91Xwrr4LaO
 6I+kFqlgQmbC6N2xAqROcoazoVeidahfgSRtri9lTAdD9Tf8/UpZyXA
X-Developer-Key: i=alexander.usyskin@intel.com; a=ed25519;
 pk=X+qoF/nFCdDOV04IForWSxnkyoCAbUE10egZi6PSfcU=
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

One of the reasons for the CRI to enter survivability mode
is corrupted storage.
A corrupted storage partition table can make recovery impossible.
A new partition with a pre-defined size, covering the entire storage,
should replace partitions detected from the storage when the card is
in survivability mode to allow a full memory update.

This series intended to be merged via drm tree for consistency
and requires ack from MTD maintainer.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
Changes in v2:
- Replace usual partitions with survivability one instead of adding
  addition partition to avoid problems with two partitons pointing to
  the same memory area.
- The change is in the mtd part; Miquel, I feel that this requires
  re-review/ack from your side.
- Link to v1: https://lore.kernel.org/r/20260715-cri_surviv-v1-0-61763a6f1076@intel.com

---
Alexander Usyskin (2):
      mtd: mtd_intel_dg: add survivability partition
      drm/xe/nvm: define survivabilty partition

 drivers/gpu/drm/xe/xe_nvm.c        | 13 ++++++--
 drivers/mtd/devices/mtd_intel_dg.c | 66 +++++++++++++++++++++++++++++---------
 include/linux/intel_dg_nvm_aux.h   |  1 +
 3 files changed, 61 insertions(+), 19 deletions(-)
---
base-commit: baafc300cd079a5210c1e70e5ea3d93518e40b38
change-id: 20260715-cri_surviv-5a6faf7586f1

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

