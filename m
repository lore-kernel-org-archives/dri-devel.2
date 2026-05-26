Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323A7CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 13:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9219F10E356;
	Tue, 26 May 2026 13:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="kwqqAwf7";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55BA410E356
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
 Content-Type; bh=PSo2mZnrd+YTMNhrD5rxHDm0q19foH/SymQJKDqIgZM=;
 b=kwqqAwf74delaSBdV0iK2mLT+eFhwhDpexV78bJoEtAO0I8Y6WKOqxtY6UcM+E
 euO4ZBWHdvkgGzKoKnXo5EpuPmGlOtOR2nWQhApxak8oA6Z6voPx5WCK11MnQRds
 EwTo8mu9yhZxV/fwB+uh08cNFAvDXMNznm8P7udAoBUew=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wD3v0evoBVqYN9KDg--.14290S2; 
 Tue, 26 May 2026 21:31:30 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix
 ABBA deadlock
Date: Tue, 26 May 2026 21:31:18 +0800
Message-Id: <20260526133123.691465-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v0evoBVqYN9KDg--.14290S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary3Jw4fCw1DZw4kCF4rXwb_yoW8tw1fpF
 srGr9Iyr4UJF9a93ZxAan29343ZayxGrWvgr97twn8Zr1jyF17AF1jgr43XFZ8Xrs7Zr42
 qr92yry5ur1jkFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jeSoXUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-xI0GGoVoLLfOwAA3I
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

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

This series backports the generic vblank timer infrastructure and 
converts the vkms driver to use it, fixing an ABBA deadlock.

Bug Context:
During local fuzzing with Syzkaller, an RCU preempt stall (soft lockup) 
was consistently observed in the vkms driver. The issue stems from the 
open-coded hrtimer in vkms attempting to acquire the vblank_time_lock 
(spinlock) from the timer's hardirq context, while the disable path 
holds the same lock and calls hrtimer_cancel(), resulting in a classic 
ABBA deadlock.

This 5-patch series is the complete upstream fix recommended by the DRM 
maintainers. It introduces the safe generic vblank timer to the DRM core 
and transitions vkms to it, cleanly resolving the lockup. 

Additionally, a lock dependency audit was conducted on other DRM drivers 
(i915/gvt, xe, msm) that utilize hrtimer_cancel. They were found to be 
structurally safe from this specific deadlock pattern, confirming this 
is a vkms-specific legacy issue.

Changes in v2:
- Added the missing Signed-off-by trailers from Mingyu Wang to properly 
  establish the chain of custody, as requested by Sasha Levin.
- Included the bug report context in the cover letter as suggested by 
  Maarten Lankhorst.
- The 5 patches remain identical to v1.

Thomas Zimmermann (5):
  drm/vblank: Add vblank timer
  drm/vblank: Add CRTC helpers for simple use cases
  drm/vkms: Convert to DRM's vblank timer
  drm/atomic: Increase timeout in drm_atomic_helper_wait_for_vblanks()
  drm/vblank: Fix kernel docs for vblank timer

 Documentation/gpu/drm-kms-helpers.rst    |  12 ++
 drivers/gpu/drm/Makefile                 |   3 +-
 drivers/gpu/drm/drm_atomic_helper.c      |   2 +-
 drivers/gpu/drm/drm_vblank.c             | 172 +++++++++++++++++++++-
 drivers/gpu/drm/drm_vblank_helper.c      | 176 +++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_crtc.c         |  83 +----------
 drivers/gpu/drm/vkms/vkms_drv.h          |   2 -
 include/drm/drm_modeset_helper_vtables.h |  12 ++
 include/drm/drm_vblank.h                 |  32 +++++
 include/drm/drm_vblank_helper.h          |  56 ++++++++
 10 files changed, 468 insertions(+), 82 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_vblank_helper.c
 create mode 100644 include/drm/drm_vblank_helper.h

-- 
2.34.1

