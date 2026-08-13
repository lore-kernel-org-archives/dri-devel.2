Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9B0C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:33:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 836AE10F4C4;
	Thu, 13 Aug 2026 18:33:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="SCN88PPV";
	dkim-atps=neutral
Received: from mta0.migadu.com (out-95.mta0.migadu.com [91.218.175.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BDF310F4CA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 18:33:33 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=785H/QYz7tbrhz5y8FohqEh3tkF4DH8VaJ9KJX9xcIA=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786646011; v=1; x=1787250811;
 b=SCN88PPVTNRv81/a0IcpZ3hg/iK2UAXhgCuVz2DiarPCAbZH2J4r3cfKBe+0QdgcTTbqfLdd
 oNZdUi6rFAvC4P393iRcB/x5bUCY7sXUsg2xvfpodiRhXbUT0bsz+rEiqNcxIrv/Z4pz24K10IG
 RMvqOoBLpif8a1WJAMeEAZ2PgIRWnn7aaRFABXC7NvvJk4T9K5Bc3MZmNQF6Cmx+S4EExynJCuz
 w/KpkUCt9RM8g9eQDR9KBVTyiEaLw/rQ2kxEp2MOqZ+55KSevtHM8k6lPpBkDp6H6EPXRzS/cor
 4Nm4JXZ7EOCHGi3uGqg7G3/e+TGSgi7nFSRIU2ejILfMw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id 203b5f4320f74005;
 Thu, 13 Aug 2026 18:33:31 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/3] accel/amdxdna: SYNC_BO correctness fixes
Date: Thu, 13 Aug 2026 21:33:15 +0300
Message-ID: <20260813164700.43960-1-taimuraz@kaitmazov.com>
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

Three independent fixes in and around amdxdna_drm_sync_bo_ioctl(). None of
them depend on each other.

Patch 1 refuses an I/O memory mapping of an imported BO, which the driver
currently stores as if it were an ordinary kernel address. Patches 2 and 3
fix two ways the ioctl mishandles its own range: a zero length reaching
drm_clflush_virt_range(), and an offset and size added to the BO address
without an overflow check, one level above a function that checks the same
arithmetic.

Changes in v3:
  - dropped the range patch ("flush only the requested range") and the
    quiet-vmap patch that existed only to serve it. Christian NAKed
    flushing an imported dma-buf, and the numbers in that patch came from
    exactly that case; I also have not tested its premise on a matching
    tree.
  - patch 1: corrected a wrong sentence in the commit message about which
    errno drm_gem_vmap_locked() returns.
  - patch 2: also says what changes for an imported BO, where a zero-length
    request currently flushes the whole scatterlist.

Refusing a sync on a genuinely foreign import is still being discussed on
the v2 thread and is not part of this series.

v2: https://lore.kernel.org/all/20260811231351.1011244-1-taimuraz@kaitmazov.com/

Compile-tested on drm-misc-next only: x86_64 defconfig with
DRM_ACCEL_AMDXDNA=m, gcc 16.2.1, no W=1 warnings. Not booted, and not run
on hardware.

Taimuraz Kaitmazov (3):
  accel/amdxdna: refuse an I/O memory mapping of an imported BO
  accel/amdxdna: return early from a zero-length flush
  accel/amdxdna: check the sync range for overflow on a device BO

 drivers/accel/amdxdna/amdxdna_gem.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
2.55.0

