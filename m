Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A2DCD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 08:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0369A10FA04;
	Wed,  3 Jun 2026 08:21:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fVV9bH0m";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A4A210FA04;
 Wed,  3 Jun 2026 08:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780474914; x=1812010914;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0wWDWRQZWU1fR7DmQJSsv7Y6P4jeicuZQZO3rak7e7U=;
 b=fVV9bH0mc+G8QIR6eydK7lMPMQK7RMhjen3upVt1l/9JsYwFxrLnX5+0
 F9sCwIFsUhgOdg8h4guGVxgo4HuhjpHDEXcckQaGyt4Rislv02MBJiSsJ
 6ehhke7U/nDzHnXEn/1KC4w37vAWGoPnwFeNayzU/ynVToIpzUxL3IYoa
 +8G75Orx6bTAxno08dz6WUZ/rf/hFGrgCjf/H4kmVQb+5UmOev1aCaT6W
 8jsDlZ6xoUpFHbUlBzf6zRmEUfkUt0nzLQ+Jfw7h/S0xrptXL8NDeurUZ
 ejOtldlRtp1xmz6K73hzz2yNa3mQ0+JAjrdOZxoibUwOXXNqKbWhYE9iA g==;
X-CSE-ConnectionGUID: vk7h78TsS2uLwBtMnvO/sw==
X-CSE-MsgGUID: d8g9g7tvS2GgzC0TflDAjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="92653422"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="92653422"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 01:21:54 -0700
X-CSE-ConnectionGUID: K1PtVEMmQQe5n4e4CP0xXA==
X-CSE-MsgGUID: yMUU2/L1Rdy38wfUOJfimQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; d="scan'208";a="241662387"
Received: from black.igk.intel.com ([10.91.253.5])
 by fmviesa008.fm.intel.com with ESMTP; 03 Jun 2026 01:21:52 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
 id CA27995; Wed, 03 Jun 2026 10:21:50 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] drm/amd/display: Use %*ph to print small buffer
Date: Wed,  3 Jun 2026 10:21:49 +0200
Message-ID: <20260603082150.119785-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
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

Use %*ph format to print small buffer as hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 51924ae87705..ecdd4bac42e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -757,7 +757,7 @@ void dm_handle_mst_sideband_msg_ready_event(
 			break;
 		}
 
-		DRM_DEBUG_DRIVER("ESI %02x %02x %02x\n", esi[0], esi[1], esi[2]);
+		DRM_DEBUG_DRIVER("ESI %3ph\n", esi);
 
 		switch (msg_rdy_type) {
 		case DOWN_REP_MSG_RDY_EVENT:
-- 
2.50.1

