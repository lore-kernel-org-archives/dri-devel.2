Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7A9CA5FCE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 14:15:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D6F10E569;
	Wed, 30 Sep 2026 14:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JSJzmBIB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ADE810E300;
 Wed, 30 Sep 2026 14:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790777719; x=1822313719;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=Uh9gom39WzbNzzzBwCXu/2laBjXWC998zi1qTL8D4Ls=;
 b=JSJzmBIBhWvHsiKL8CuLhK41HMHCCnfAMWain32AX+LKC7HziniuE3jm
 pjD7kj1edaWZ//D61Sk9ARabIyvEodxP02CSOCj5SbkvQmc84ll4j5uhV
 DQLiLw8JTFpSAj0eQaxgzZhqIhUdPSs66XDJqHFAgem5euLDK5SErsbum
 WKgPkhzHPnaphBpUNeoJz19x1Lhfpn7hFlMBDfdtKhVB3hT4k8VNpnnxR
 aPqbArTDxmyTBsouZ88k4gWwCL6Z/s99HXhVdtGJ2RiIF97mH1OT4cIU9
 1e8X36SFmYsHR8tRhCdWE0/Sl33bUWXIMVl+9Ac40ABVKrxnZ948ttfdr w==;
X-CSE-ConnectionGUID: 5myWTgNKTguUXuUJb6MQeA==
X-CSE-MsgGUID: JFATymBhRk2acoHC/eB9dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90469986"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="90469986"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 07:14:58 -0700
X-CSE-ConnectionGUID: N6VUx1vnRFiESVz3cBge7g==
X-CSE-MsgGUID: SMr/RS35T/a+Qv+s2gvgyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="279499579"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by orviesa005-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 07:14:55 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH v3 0/2] drm/xe/nvm: add survivabilty partiton
Date: Wed, 30 Sep 2026 17:14:45 +0300
Message-Id: <20260930-cri_surviv-v3-0-357aeed5fc60@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23MQQrCMBCF4auUWRvJpCaprryHiNR2Ygc0laQGp
 fTupt2o4PI9+L8RIgWmCLtihECJI/c+j3JVQNPV/kKC27xBSWWkRS2awKf4CImT0LVxtbO6Mg4
 hB/dAjp8Ldjjm3XEc+vBa7ITz+5dJKKQwaE2ZPZTW7NkPdF03/Q1mJqlPukXzk6qc2pbwrEtVK
 bn5TqdpegP9w/yR3wAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790777694; l=1591;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=Uh9gom39WzbNzzzBwCXu/2laBjXWC998zi1qTL8D4Ls=;
 b=qBMmZUBGx+CVmIcdAn6rHqQ4J0RItiVqFUJpuPni8jRorjvz6LqJ5T2Meo/Z5UuItQjzkBZV2
 U0vFZKZWPQBA5QOftkP1QoF70wWfmLiVKClQx2EumAWRIl8J3JTcoHF
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
Changes in v3:
- Fix minor checkpatch complain
- Add Miquel ack
- Link to v2: https://lore.kernel.org/r/20260916-cri_surviv-v2-0-7de1b5328204@intel.com

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
 drivers/mtd/devices/mtd_intel_dg.c | 65 ++++++++++++++++++++++++++++----------
 include/linux/intel_dg_nvm_aux.h   |  1 +
 3 files changed, 60 insertions(+), 19 deletions(-)
---
base-commit: 3fc93d311249d5ad969a520dd3aae73bc007d431
change-id: 20260715-cri_surviv-5a6faf7586f1

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

