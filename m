Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1F2C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 14:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD07E10E1D7;
	Wed, 15 Jul 2026 14:09:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FJKbViBM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A69810E109;
 Wed, 15 Jul 2026 14:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784124539; x=1815660539;
 h=from:subject:date:message-id:mime-version:
 content-transfer-encoding:to:cc;
 bh=dCyV2fCxlnQlIjGOH8f3xg6tybPY5EsXgQMhHPrmnlw=;
 b=FJKbViBMbof7dL/GdESWirSZ4QDBr/JWbeBaNwya+2x+dwxhDBt19ROE
 Uwug4H1aefTRerA8HVuHp6AFRO4A2DCMyrfu6oFMB2kGcJklMCl2fliap
 ejnxnjQtb5V82jdj7u3VK62BDVx2u5pKNlhJZCWCluWc5EfcGzAIJ4cwb
 24ny3RNkslhF6C5rvo74LYGjYm8Cw2nXJoNAAWDmScW5gMsCZSLwBS9sV
 6g5EoXWUQQfdyEBJGMi+uCXwWsI3PkRbWRjB5GhkcHzrsz84coknb9HcT
 4xGTMRvPG1YMkihuGoxU5xL5p83x/Rqg2aZEGjc8twotamW0h+xL2FKWs w==;
X-CSE-ConnectionGUID: cHtgjbpLS0i/bl10LOAdlQ==
X-CSE-MsgGUID: 0NOe3NWFSJWJS3gZcLUOnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84615774"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="84615774"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2026 07:08:58 -0700
X-CSE-ConnectionGUID: V5IShM9eS32li9A4vFOTEw==
X-CSE-MsgGUID: 9Y9MyI5OSDK0Vbv20334NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; d="scan'208";a="251777863"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by fmviesa006-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:08:55 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Subject: [PATCH 0/2] drm/xe/nvm: add survivabilty partiton
Date: Wed, 15 Jul 2026 16:45:28 +0300
Message-Id: <20260715-cri_surviv-v1-0-61763a6f1076@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NT3eSizPji0qKyzDJd00SztMQ0c1MLszRDJaCGgqLUtMwKsGHRsbW
 1ALqbZt9cAAAA
X-Change-ID: 20260715-cri_surviv-5a6faf7586f1
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784123168; l=1018;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=dCyV2fCxlnQlIjGOH8f3xg6tybPY5EsXgQMhHPrmnlw=;
 b=46LI4ZEe2uhSuVa3oVAfJVy7yPFF6aoOdFUM+ZRMNQCKne9QxG9Ss9o18A2WESMv+4aZPFtym
 kFy/eovxCiAAe6E43/TPisGnzvcHaGhKCJ6N45No2Uk40t0fCsNatX2
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
should be added when the card is in survivability mode to allow a full
memory update.

This series intended to be merged via drm tree for consistency
and requires ack from MTD maintainer.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
Alexander Usyskin (2):
      mtd: mtd_intel_dg: add survivability partition
      drm/xe/nvm: define survivabilty partition

 drivers/gpu/drm/xe/xe_nvm.c        | 13 +++++--
 drivers/mtd/devices/mtd_intel_dg.c | 80 +++++++++++++++++++++++++++-----------
 include/linux/intel_dg_nvm_aux.h   |  1 +
 3 files changed, 69 insertions(+), 25 deletions(-)
---
base-commit: acc744fa62fb098358f371bfb38e6b32032459c7
change-id: 20260715-cri_surviv-5a6faf7586f1

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

