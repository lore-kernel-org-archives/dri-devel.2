Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3FDC5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 22:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1372610E14F;
	Wed, 19 Aug 2026 22:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="CACWfH4b";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-3.mta0.migadu.com [91.218.175.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5914010E14F
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 22:45:13 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=RZ2yuaK9h5x1CBokHk/lofZ9kDXDYsd0ZVL1DQ1bBuE=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787179511; v=1; x=1787784311;
 b=CACWfH4bm4x3ehR2cA6tbb2hdkno/8InBEZ8UfhqcESaKkLqxXlcq/TUdX6hubcTKONIIX0N
 uv2fRjx/5Ao3ZaFKhJzPULur/hgE6TZHSAiZIRewTogbX4c5Eq4OTRG8/XTs9/4HXouoxj3ArKg
 AHARVRRpoooODsqC96tf7iKVzc5sn50+hi8m4tX4GK1VZoTkRg/akPBId9sQb4c2GT+5PwizOVu
 mWtmWAWANcMOfrLHB62U6r26zKcUVd8E2KJwzZG5HyzG2Pg5v3fWZ8xY0ezram0RjdhU40PFl3q
 ogcvUmLCR/OPMWeQVpYCIdV5I3sS43EQK3tgrKlZ0oAFw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 5159431e54a40376;
 Wed, 19 Aug 2026 22:45:11 +0000
X-Mizu-Trace-ID: 5159431e54a40376
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: Lizhi Hou <lizhi.hou@amd.com>, Min Ma <mamin506@gmail.com>,
 Oded Gabbay <ogabbay@kernel.org>
Cc: taimuraz@kaitmazov.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alex Deucher <alexdeucher@gmail.com>, Max Zhen <max.zhen@amd.com>,
 Sonal Santan <sonal.santan@amd.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
Subject: [PATCH v5 0/5] accel/amdxdna: SYNC_BO correctness fixes
Date: Thu, 20 Aug 2026 01:44:53 +0300
Message-ID: <20260819224458.257346-1-taimuraz@kaitmazov.com>
X-Mailer: git-send-email 2.55.0
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

Same five fixes as v4, with both review comments addressed.

Changes in v5:
  - patch 3: XDNA_DBG rather than XDNA_ERR, per Lizhi. An unprivileged
    caller can repeat it, which is the same reason patch 1 does not log
    at error level.
  - patch 5: reworked as Lizhi asked. The assigned_hwctx test moves into
    amdxdna_drm_sync_bo_ioctl(), which has the object already, so
    amdxdna_hwctx_sync_debug_bo() keeps -EINVAL for a context that is
    named but gone, and the handle is not resolved twice.
  - patches 1, 2 and 4 carry Lizhi's Reviewed-by, otherwise unchanged.

One behaviour change userspace can see, spelled out in patch 4: SYNC_BO
answers -EOPNOTSUPP for an imported BO, which on a carveout device is every
AMDXDNA_BO_DEV.

Patch 4 still needs "accel/amdxdna: return early from a zero-length
flush", which is now in drm-misc-fixes, so it wants that backmerged into
drm-misc-next. Patches 1, 2, 3 and 5 apply without it.

  https://lore.kernel.org/all/20260817230655.356785-1-taimuraz@kaitmazov.com/

v4: https://lore.kernel.org/all/20260817230707.356828-1-taimuraz@kaitmazov.com/

Built on drm-misc-next plus that commit, each commit on its own: x86_64
with DRM_ACCEL_AMDXDNA=m, clang 22.1.8, W=1, no warnings, checkpatch
--strict clean.

Taimuraz Kaitmazov (5):
  accel/amdxdna: refuse an I/O memory mapping of an imported BO
  accel/amdxdna: check the sync range for overflow on a device BO
  accel/amdxdna: do not warn when a sync request is rejected
  accel/amdxdna: refuse to flush an imported BO
  accel/amdxdna: do not fail a sync for a BO with no debug context

 drivers/accel/amdxdna/amdxdna_gem.c | 30 ++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.55.0

