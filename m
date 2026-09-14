Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7BDC88E50
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FD810EE56;
	Mon, 14 Sep 2026 13:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X+TEiLro";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4AF10EE56;
 Mon, 14 Sep 2026 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789391919; x=1820927919;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:to:cc;
 bh=li3QXltipxKEHiQpkDyZl5H8yuTNVO70BZpcI0h4e1Y=;
 b=X+TEiLroxg6TFn/BfKe8+6ryeSN1rIBIUQRIYLo6q+PHIBKlP9ec9JZH
 HIXmZ0n4dC9SymU+e/KJId5qWRQyY5PXWNcYZcZuXn35tDpuLBYSpNtIX
 2jUZtnXUWqYyMLmy3qlMrdVqXFMcncvvLUrSesZTv6eQY3UWNfm2YqQOA
 S/Lo+pN3TMjOwIDkTb+Mt9SHPZ2GfTJxyuTeASyKPojKIU4bOHlh1eLI9
 3BWLm33qVFR3wps5QR1d6OWtpJ2s81pNXq8K9px2mYOaPkxc+osmR9A0P
 jSstyI09hi+e3G3exp99ZF1eM4Uo/k/swE8ItH/KH6fIe0lOI/ci/PEPZ w==;
X-CSE-ConnectionGUID: scbm7J8wQ8urI0Xt+t77TA==
X-CSE-MsgGUID: DndOP7ukSOCgR2W9gLf6YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89768228"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89768228"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 06:18:38 -0700
X-CSE-ConnectionGUID: gLmUT0d9SWGeZhp5c2DZ4g==
X-CSE-MsgGUID: xBWAYN1BQ6uYAsUSlwfxbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="276171115"
Received: from sannilnx-dsk.jer.intel.com (HELO [127.0.1.1]) ([10.12.231.107])
 by ORVIESA003-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 06:18:36 -0700
From: Alexander Usyskin <alexander.usyskin@intel.com>
Date: Mon, 14 Sep 2026 16:18:02 +0300
Subject: [PATCH] drm/xe/nvm: add system controller region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-nvm_add_sysctl_region-v1-1-75d710daf5d0@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M0QpAMBSA4VfRubaaxRqvIq2xg1OMdiSSd7dc/
 hff/wBjJGRosgcinsS0hRRFnsEwuzChIJ8alFRa1kUpwrla573lm4djsRGnJISujHKmN1pLBcn
 uEUe6/m/bve8Hruo4IGcAAAA=
X-Change-ID: 20260914-nvm_add_sysctl_region-6582a8b86602
To: Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Alexander Usyskin <alexander.usyskin@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789391915; l=884;
 i=alexander.usyskin@intel.com; s=20260315; h=from:subject:message-id;
 bh=li3QXltipxKEHiQpkDyZl5H8yuTNVO70BZpcI0h4e1Y=;
 b=TMrp+TtcG+Wocd0zT0UJHADOd9VE0Lf3JgUDiOSUmxfoTFR2hYr7CjRrAaPLu9mNFbItcAWL2
 Na2NEGXtfMvA2mugLPvwwcu6iVBR29aF2P4uN+h7NGIuL54T+YaAxtW
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

Add region 5 (System Controller) to the list of regions
available on device.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/gpu/drm/xe/xe_nvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_nvm.c b/drivers/gpu/drm/xe/xe_nvm.c
index 1ea67eaeae24..51a1a431ad85 100644
--- a/drivers/gpu/drm/xe/xe_nvm.c
+++ b/drivers/gpu/drm/xe/xe_nvm.c
@@ -28,6 +28,7 @@
 static const struct intel_dg_nvm_region regions[INTEL_DG_NVM_REGIONS] = {
 	[0] = { .name = "DESCRIPTOR", },
 	[2] = { .name = "GSC", },
+	[5] = { .name = "SYSCTL", },
 	[9] = { .name = "PADDING", },
 	[11] = { .name = "OptionROM", },
 	[12] = { .name = "DAM", },

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260914-nvm_add_sysctl_region-6582a8b86602

Best regards,
-- 
Alexander Usyskin <alexander.usyskin@intel.com>

