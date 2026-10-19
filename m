Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536C606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AzdtfAe5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AE4210F2F6;
	Tue, 20 Oct 2026 07:36:32 +0000 (UTC)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A0E10E0B1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ig
 E/kEh0g7gFKv5PAwWV/CKHlROUnBFZYW4mh6vr2N4=; b=AzdtfAe5zCDyzRWfoy
 A8T89jA2HQr8wbyEZdpPqe/doMfmtb9xr4UUbuMykAvVfcCXOEvfuLObr+ILhobp
 Zk9lujS6CP6KKg9YJeEC9+/DkFLfwCNo35LZ4C+rU2LMSgHi93QP73mb3EnU+Q0I
 PChWPOT8P+Ax5fzR8RSis8rNA=
Received: from pc.localdomain (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wDnt9ng19VqcQOlAw--.9091S2; 
 Mon, 19 Oct 2026 16:42:10 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Zack Rusin <zack.rusin@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ben Skeggs <bskeggs@redhat.com>, David Rheinsberg <david@readahead.eu>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/6] drm: reject empty TTM range manager sizes
Date: Mon, 19 Oct 2026 16:41:32 +0800
Message-Id: <20261019084138.1821477-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDnt9ng19VqcQOlAw--.9091S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrWkAFWUGFW8GFyfAw4rGrg_yoWkArb_u3
 40vas7Wr1UGrnxXF4Iyr47Ar12ka1UuayDZwnFv3y3Ary3Xr1UX348Gr93Ww18C3Z8KFn0
 krnYqw1YyrnIkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRt9a97UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wM+eGrV1+M2UQAA3G
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_mm_init() rejects a zero-length allocation range with a BUG check.
Several DRM TTM users can derive a zero page count from device-provided
VRAM metadata and pass it to the range manager.

This series rejects empty ranges at the affected callers and adds a
defensive check in the common range manager. Patches 1 through 4 and
6 validate the individual driver inputs. Patch 5 protects the shared
range-manager API against any remaining zero-page caller.

The series was checked with scripts/checkpatch.pl for every code patch.

Jiale Yao (6):
  drm/vram-helper: reject empty VRAM ranges
  drm/nouveau: reject empty VRAM ranges
  drm/qxl: reject empty TTM memory ranges
  drm/radeon: reject empty VRAM ranges
  drm/ttm: reject empty range manager sizes
  drm/vmwgfx: reject empty VRAM ranges

 drivers/gpu/drm/drm_gem_vram_helper.c   | 3 +++
 drivers/gpu/drm/nouveau/nouveau_ttm.c   | 3 +++
 drivers/gpu/drm/qxl/qxl_ttm.c           | 3 +++
 drivers/gpu/drm/radeon/radeon_ttm.c     | 3 +++
 drivers/gpu/drm/ttm/ttm_range_manager.c | 3 +++
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     | 4 ++++
 6 files changed, 19 insertions(+)

-- 
2.34.1

