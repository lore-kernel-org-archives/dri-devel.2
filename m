Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A58C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 23:07:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4E110E989;
	Mon, 17 Aug 2026 23:07:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="FgXxACm9";
	dkim-atps=neutral
Received: from mta1.migadu.com (out-154.mta1.migadu.com [95.215.58.154])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C1C10E989
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 23:07:26 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=8mh+gMKm2Kq9UgpcMVnmdCOPhEonRamdsvBb6eKpz/k=; 
 c=simple/simple; d=kaitmazov.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787008045; v=1; x=1787612845;
 b=FgXxACm9nTQ4oqlUILHrF1ndJqe9+mNfh3UU4oyK2whK+QbhtotL6T8JUpdSNVEygZu/a4ff
 4VcB7Vzfk6/V44VZTp+CWkjPH/7JMMTJVA16+mZbq/KL1oTcEeHiV4NXm3eUoz5cED/d8ogdBWF
 SEkCi2HFo6e0crUNy2jt5J1P8ZxtVIbLsjmKTnH0KnuJptxB5iTEaM+hciaN6iZ/fQysHau7Yrs
 bDF4X7jiYKn/7YB0/yFf86mt3JL3/3i9Hd0lGCQrhzO4yZpbGwRpmseQfMFu4PN9ONDhLFu7fY1
 vKjHUL2EyJ6Ai/r9cEed229v8ZKdiuxEzkE4+PoMkWGFw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: from cachyos-26.lan (193.42.111.69)
 by smtp.migadu.com with ESMTPS id b98ff7bb7de7f142;
 Mon, 17 Aug 2026 23:07:25 +0000
X-Migadu-Flow: FLOW_OUT
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: lizhi.hou@amd.com,
	mamin506@gmail.com,
	ogabbay@kernel.org
Cc: christian.koenig@amd.com, sumit.semwal@linaro.org, alexdeucher@gmail.com,
 max.zhen@amd.com, sonal.santan@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v4 0/5] accel/amdxdna: SYNC_BO correctness fixes
Date: Tue, 18 Aug 2026 02:07:02 +0300
Message-ID: <20260817230707.356828-1-taimuraz@kaitmazov.com>
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

Five fixes in and around amdxdna_drm_sync_bo_ioctl().

Patch 1 refuses an I/O memory mapping the driver would otherwise store as
if it were an ordinary kernel address. Patch 2 checks the device-BO range
for overflow. Patch 4 refuses a flush of an imported BO, which is why
patch 3 comes first: the ioctl answers a rejected flush with drm_WARN(),
so without it an ordinary sync on an imported BO splats. Patch 5 stops
the ioctl reporting failure for a flush that succeeded.

v3's zero-length patch has left this series. On hardware it turns out to
be a page fault in drm_clflush_virt_range() rather than the tidy-up its
commit message described, so it is a -fixes patch now, sent separately as
"accel/amdxdna: return early from a zero-length flush" with Fixes: and
Cc: stable. Patch 4 here needs its hunk, so this series wants that one
first.

Changes in v4:
  - patch 1: the is_iomem check moved from the .vmap callback into
    amdxdna_gem_vmap(), per Lizhi, and it logs at debug level rather than
    error, since an unprivileged caller can repeat it.
  - new patch 3: an unprivileged SYNC_BO with an out-of-range offset
    already reaches that drm_WARN() today. Sashiko's review of v3 3/3
    flagged the same thing.
  - new patch 4: refuses the flush for every imported BO, as asked.
  - new patch 5: the debug-BO sync I mentioned on the v2 thread. Only a BO
    attached with ATTACH_DEBUG_BO has an assigned hwctx, so every other
    FROM_DEVICE sync ends in -EINVAL with its flush already done. The
    -EINVAL reproduces on a Strix Point NPU.

On patch 4, one consequence worth deciding before it lands. A heap BO is
created through amdxdna_drm_create_share_bo(), so a device running on
carveout memory reaches its heap through a cbuf, is_import_bo() is true of
it, and SYNC_BO on every AMDXDNA_BO_DEV now answers -EOPNOTSUPP. Today
that path flushes nothing anyway -- amdxdna_cbuf_map() fills in only the
DMA address and length, so drm_clflush_sg() walks zero pages -- so the
change is silent no-op to hard error, and XRT's dbg_buffer::sync() reaches
it without Debug.force_driver_sync. If you would rather keep our own
exporters working, I have the variant keyed on the exporter's ops, which
confines the refusal to foreign buffers. Say which you prefer.

v3: https://lore.kernel.org/all/20260813164700.43960-1-taimuraz@kaitmazov.com/

Built on drm-misc-next, each commit on its own: x86_64 with
DRM_ACCEL_AMDXDNA=m, clang 22.1.8, no warnings. Patch 5's reproducer was
run against 7.1.8's in-tree driver, where that call is unchanged.

Taimuraz Kaitmazov (5):
  accel/amdxdna: refuse an I/O memory mapping of an imported BO
  accel/amdxdna: check the sync range for overflow on a device BO
  accel/amdxdna: do not warn when a sync request is rejected
  accel/amdxdna: refuse to flush an imported BO
  accel/amdxdna: do not fail a sync for a BO with no debug context

 drivers/accel/amdxdna/amdxdna_ctx.c |  3 ++-
 drivers/accel/amdxdna/amdxdna_gem.c | 27 +++++++++++++++++++--------
 2 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.55.0

