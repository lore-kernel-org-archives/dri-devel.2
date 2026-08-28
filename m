Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CC2C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E3EB10F2F6;
	Fri, 28 Aug 2026 08:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MwwoebXP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFFFA10F2F6;
 Fri, 28 Aug 2026 08:51:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0562860200;
 Fri, 28 Aug 2026 08:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDB21F000E9;
 Fri, 28 Aug 2026 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787907101;
 bh=iHBSUDDx1WbolXW0Nyh2IRj9cxuhb4M6H5r9hbv6v5w=;
 h=From:To:Cc:Subject:Date;
 b=MwwoebXPHKhkZn8W5TgPtCIHt2/bh0gn5bc3Op2iQ31YgzRxFScemnTxhXARslqi1
 Yr6FVrT05g5hYx0UTnd8lheht+h9oqNXjqp1uFdgM5hBslha1xIAi3O/pfSCvwaAZG
 13tIaTynKi1BrzAbc27OhQ01GK/rWqjFrEHtfJOgUtvDo/bTwLSA8PsZNf0vBlA1JQ
 lDHEo+YlF66FWIZ0wAMlDVeggU+Fbbvv/ddBithXCM83xLYAjMwytdgVZWB3MgjNtj
 bM1XyS4iXqTwQB7FsXYefGA4qA1uSKbJlym1Gp+tgtLZGCbJ66dn31s4GB6/ybmfwd
 c4NC5D8Hafz6g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: devel@lists.crash-utility.osci.io
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>, Gemini <gemini@google.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, stable@vger.kernel.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/qxl: fix use-after-free and NULL pointer deref
Date: Fri, 28 Aug 2026 10:51:36 +0200
Message-ID: <20260828085136.128561-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

When allocating a `qxl_release` structure with `kmalloc()`, the underlying
memory contained uninitialized garbage. Specifically, `release->base.flags`
(part of the embedded `dma_fence`) was not cleared.

This garbage in `base.flags` caused helper functions such as
`dma_fence_was_initialized()` to return true even for releases where the
fence was never actually initialized (e.g. via `dma_fence_init()`).

Consequently, during release cleanup in `qxl_release_free()`, the driver
attempted to put/free an uninitialized `dma_fence`, leading to refcount
underflows (`refcount_t: underflow; use-after-free`) and subsequent NULL
pointer dereferences in `dma_fence_signal_timestamp_locked()`.

Fix this by switching from `kmalloc()` to `kzalloc_obj()` in
`qxl_release_alloc()`, ensuring all fields (including embedded fence
flags) are properly zero-initialized upon allocation, and remove
redundant explicit zero-initializations.

The dumps in question:
 refcount_t: underflow; use-after-free.
 WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90, CPU#0: kworker/0:0/1534
 Modules linked in: af_packet nft_fib_inet ...
 CPU: 0 UID: 0 PID: 1534 Comm: kworker/0:0 Not tainted 7.1.3-1-default #1 PREEMPT(full) openSUSE Tumbleweed  b041a6527f6e58424f4cd3de0fade8d408b378fd
 ...
 RIP: 0010:refcount_warn_saturate+0x59/0x90
 ...
 Call Trace:
  <TASK>
  qxl_release_free+0xee/0xf0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
  qxl_garbage_collect+0xd1/0x1b0 [qxl d93e9381353e619799d56790f5f8dda6cce491f6]
  process_one_work+0x19e/0x3a0
 ...

And then of course:
 BUG: kernel NULL pointer dereference, address: 0000000000000028
 ...
 RIP: 0010:dma_fence_signal_timestamp_locked+0x32/0x120

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Assisted-by: Gemini <gemini@google.com> # only commit log
Fixes: 2bcbc706dfa0 ("dma-buf: add dma_fence_was_initialized function v2")
Closes: https://bugzilla.suse.com/show_bug.cgi?id=1271081
Cc: Christian König <christian.koenig@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org
---
Cc: virtualization@lists.linux.dev
Cc: spice-devel@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org

[v2] use kzalloc_obj() instead of bare kzalloc()
---
 drivers/gpu/drm/qxl/qxl_release.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_release.c b/drivers/gpu/drm/qxl/qxl_release.c
index 06979d0e8a9f..07dc6eafe6f7 100644
--- a/drivers/gpu/drm/qxl/qxl_release.c
+++ b/drivers/gpu/drm/qxl/qxl_release.c
@@ -89,17 +89,13 @@ qxl_release_alloc(struct qxl_device *qdev, int type,
 {
 	struct qxl_release *release;
 	int handle;
-	size_t size = sizeof(*release);
 
-	release = kmalloc(size, GFP_KERNEL);
+	release = kzalloc_obj(*release);
 	if (!release) {
 		DRM_ERROR("Out of memory\n");
 		return -ENOMEM;
 	}
-	release->base.ops = NULL;
 	release->type = type;
-	release->release_offset = 0;
-	release->surface_release_id = 0;
 	INIT_LIST_HEAD(&release->bos);
 
 	idr_preload(GFP_KERNEL);
-- 
2.55.0

