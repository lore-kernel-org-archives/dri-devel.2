Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BC5C5CFC1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A6410E3C1;
	Tue, 11 Aug 2026 23:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kaitmazov.com header.i=@kaitmazov.com header.b="uCoY5JXW";
	dkim-atps=neutral
X-Greylist: delayed 485 seconds by postgrey-1.36 at gabe;
 Tue, 11 Aug 2026 23:22:32 UTC
Received: from out-171.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C82F10E217
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 23:22:32 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaitmazov.com;
 s=key1; t=1786490061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=13kbMSmLvcqjFkH/E/F3IPUgdaomZM6iY09xBQHneIY=;
 b=uCoY5JXWDwAf/rGjZU5yOU3sNXGaXrgozGrgcTP90uhZYLj50pZGMh8MA5OK8W11xMxAyQ
 28m3qsCI/zEOqThr/sg35zp0xrXC4fUsUDii7uACfeMUfjJzL2C3hnBKte33dvn+ijuXqz
 L1Qiyu9xROSLNq1hbqDlba5FXo0X96bDKYCi2xTz0RBSpxoDsfWYPqeaFyroejrF6fW10P
 Zh+vfP7Q6OmwwIK2FZ8BAp6UPn0WgwgnOOWAl2KAYZwPUHV4BdhC4+41v/OOGizmj9kZlB
 /QYdf28wp+rYuLCfn3uGyUutZAiVaCDoD6HupNCVxEEuQOXmTf/3VEU8k8on0A==
From: Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
To: mamin506@gmail.com,
	lizhi.hou@amd.com,
	ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 Taimuraz Kaitmazov <taimuraz@kaitmazov.com>
Subject: [PATCH v2 0/5] accel/amdxdna: honour the SYNC_BO range
Date: Wed, 12 Aug 2026 02:13:46 +0300
Message-ID: <20260811231351.1011244-1-taimuraz@kaitmazov.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

SYNC_BO carries an offset and a size, but amdxdna_flush_bo() honours them
only on the vmap path. An imported BO is tested for first and flushes its
whole scatterlist, so a sync costs what the BO is worth rather than what
the caller asked to maintain: on npu4 an imported 64 MiB BO cost 1056 us
to sync at every size from 4 KiB up. Patch 5 reorders the arms so the
vmap path is tried first, and indexes the page-array fallback from the
requested offset.

The four before it are the ground that has to be solid first. Patch 1
refuses an I/O memory mapping, which the driver currently stores as if it
were an ordinary kernel address. Patch 2 adds a probe that does not log,
so patch 5 does not make an exporter without a vmap op print on every
ioctl. Patches 3 and 4 fix two ways the ioctl mishandles its own range: a
zero length reaching drm_clflush_virt_range(), and an offset and size
added to the BO address without an overflow check, one level above a
function that checks the same arithmetic. All four stand on their own and
can be taken separately; only patch 5 depends on them.

v1 did not reach dri-devel, so this is the first version visible there.
It is on lore via the other lists it was copied to:
https://lore.kernel.org/lkml/20260811204556.875037-1-taimuraz@kaitmazov.com/

Changes in v2:
 - patch 2: take the device from the GEM object rather than abo->client.
   amdxdna_gem_obj_close() clears that pointer under abo->lock, which the
   pre-split code held across the log and the split did not.
 - new patch 3: return early from a zero-length flush.
 - new patch 4: check the sync range for overflow on a device BO.
 - patch 5: say why the persistent mapping adds no pin.

The measurements in patch 5 were taken with the equivalent change in
AMD's out-of-tree xdna-driver, where this merged as #1541. That version
and this one differ only in a page-array fallback mainline has no field
for, reached when the mapping fails and the BO is neither imported nor
shmem backed, and in the name of the mapping helper. The flush and the
helper are otherwise identical. This version is compile-tested; it has
not been booted.

Patch 1 is from inspection rather than a reproducer. The exporter I can
test against is amdgpu, and amdgpu is the case that cannot reach it: it
implements .pin, so a non peer to peer attachment like this driver's
forces the buffer to GTT before anything maps it. Reproducing it needs a
GPU whose exporter has no .pin, which I do not have paired with an NPU
here.

Taimuraz Kaitmazov (5):
  accel/amdxdna: refuse an I/O memory mapping of an imported BO
  accel/amdxdna: add a quiet variant of amdxdna_gem_vmap()
  accel/amdxdna: return early from a zero-length flush
  accel/amdxdna: check the sync range for overflow on a device BO
  accel/amdxdna: flush only the requested range in amdxdna_flush_bo

 drivers/accel/amdxdna/amdxdna_gem.c | 66 +++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 17 deletions(-)

-- 
2.55.0

