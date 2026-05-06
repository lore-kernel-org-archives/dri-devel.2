Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D912CD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 10:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A00410E19E;
	Wed,  6 May 2026 10:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="LqF/UBuS";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF34910E19E
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 10:46:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1778064375; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dD+MAHs7bn+0hkCGxAH2Y14qOgcWvY61twD7s6yo6x9dTjPI36bSumE9WInf7BLanZa5cV3iDcTwI0V2CYS8TPeQ5DPD9+i7ikH5LqfVgDWMigtuZ/KASMXc/cCiM+8o0RTqmHWu//A96sukafLW5HT9UQvPCs37VabZe17CH0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1778064375;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RvG681xq2rNXteugTNEM7Um/68qeSlyFUSIc0ImpD0o=; 
 b=eLvhIOnbvatlm909dRF7SgeKmb4GVtOH4neuNjiY38W61SSCYN8IiGFV0k2GU0rOfaBbrF2kPdutXqVUxH8UGh0vdrIRmREqeSi5C4vT+wrHHk/bKpFVgD8/1SQDQbzHom9sr7k/sW7VDmFfeKV2qrXzaFriqSnVlPHncqaBpOU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778064375; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=RvG681xq2rNXteugTNEM7Um/68qeSlyFUSIc0ImpD0o=;
 b=LqF/UBuSIuFQj0g3V9cB/8wAouiRG9F2IhpfRD0BNmzdvc//GE4ixLEkX4q+hdQU
 9AyDOYVy3BtuB6TKO9ufIcLmMgqt2S3T4Qv5XAoHjYcYRUfW/yRcWiheUTuu+4I4sCV
 lUyDjBtjb3xfnkYglxmKGp9GX0GVEIgtFRfKsAOs=
Received: by mx.zohomail.com with SMTPS id 1778064373709928.0603511785826;
 Wed, 6 May 2026 03:46:13 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Subject: [PATCH 0/4] Let userspace explicitly trigger memory reclaims
Date: Wed, 06 May 2026 12:45:55 +0200
Message-Id: <20260506-panthor-explicit-reclaim-v1-0-44f82ac147ce@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NwQqDMBBEf0X23KVpSkX8leIhJmvdYjTdRBHEf
 29aPQ0PZt5sEEmYItTFBkILR57GDLdLAbY344uQXWbQSpfqoUoMZkz9JEhrGNhyQiE7GPZ4d11
 HTunKVRbyPAh1vP7Vz+bgOLdvsunnOxtCnzl/pqMGrYmEdvKeU1048Zg4XM+EZt+/ZGdBLq8AA
 AA=
X-Change-ID: 20260506-panthor-explicit-reclaim-3dffed028d8c
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2
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

RAM is not, in fact, cheap. Especially on embedded systems with a low
amount of memory, but known and well-defined userspace, more explicit
resource management can lead to better utilisation patterns. As an
example, a resource manager process on a purpose-built device may wish
to launch, and then explicitly swap out, memory of processes that are
kept "warm", to improve perceived startup latency of individual
full-screen applications without making the kernel figure out the usage
pattern from observation alone in order to swap out the right pages.

To allow for this explicit control in the context of panthor's GPU
memory, add two new sysfs knobs. The first, mem_reclaim, runs an
explicit priv BO reclaim cycle on the TGID written to it.

The second, mem_claim, does the opposite: it swaps BOs back into active
memory.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
Nicolas Frattaroli (4):
      drm/panthor: Add freed_sz parameter to reclaim_priv_bos
      MAINTAINERS: Add sysfs ABI docs to list of panthor files
      drm/panthor: Add explicit memory reclaim sysfs knob
      drm/panthor: Add explicit memory claim sysfs knob

 Documentation/ABI/testing/sysfs-driver-panthor-mem | 34 ++++++++
 MAINTAINERS                                        |  1 +
 drivers/gpu/drm/panthor/panthor_drv.c              | 93 ++++++++++++++++++++++
 drivers/gpu/drm/panthor/panthor_gem.c              |  7 +-
 drivers/gpu/drm/panthor/panthor_gem.h              |  1 +
 drivers/gpu/drm/panthor/panthor_mmu.c              | 70 +++++++++++++++-
 drivers/gpu/drm/panthor/panthor_mmu.h              |  4 +
 7 files changed, 205 insertions(+), 5 deletions(-)
---
base-commit: 2c4b906cd135bbb44855287d0d0eff0ee0b47afe
change-id: 20260506-panthor-explicit-reclaim-3dffed028d8c

Best regards,
--  
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

