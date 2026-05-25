Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07933CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 13:17:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C1D10E327;
	Mon, 25 May 2026 13:17:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="ViIADVMJ";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B74E10E323
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 13:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rc
 ojwpS/HH3aFSbpC+5s77qh50pJ7oQ8VBYS0FcRMdM=; b=ViIADVMJK3C/AOjGlo
 Dcx1Y51s2m8Z+gon422bl0ZtGWgdx3oVnXFug1Y8Oe6XCXC3Ib2xvpSg7q+sVSvr
 3ezztEVwQsCcKFbsePkNweXYsXIFQ+FKAYGm0woorvrTVDP+Yly0B74Fedj3AJxD
 CGkdqomKiBMpTF77maX4Ht+h4=
Received: from 163.com (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCn6zidSxRqC7WEDQ--.19334S2; 
 Mon, 25 May 2026 21:16:21 +0800 (CST)
From: w15303746062@163.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: tzimmermann@suse.de, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 louis.chauvet@bootlin.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH 6.18.y 0/5] drm/vkms: Backport generic vblank timer to fix
 ABBA deadlock
Date: Mon, 25 May 2026 21:16:05 +0800
Message-Id: <20260525131610.608273-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
References: <9c4a68c4-43a3-4a9b-a131-9570174c8df3@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn6zidSxRqC7WEDQ--.19334S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFykWF1rGF1kur43KF1Utrb_yoW8uF48pF
 sxJryayr45JFZxJwnxAFs7Z3W5ZayrXrWkKr9rK3s5Zw1FyF17AF18Jw43WFWUJrnrZr42
 qrnFyr1Uur1UCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5_-PUUUUU=
X-Originating-IP: [113.200.174.100]
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC-wWbf2oUS6UmKAAA3A
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

Hi Greg and all,

This patch series backports the generic DRM vblank timer infrastructure
and converts the vkms driver to use it, specifically targeting the 
6.18.y stable branch.

During local fuzzing with Syzkaller, an RCU preempt stall (ABBA deadlock)
was consistently observed in the 6.18.y vkms driver. This deadlock occurs
between the legacy drm_vblank_disable_and_save() function and the
vkms_vblank_simulate() hrtimer callback. 

A previous localized patch was submitted to address this in 6.18.y using
hrtimer_try_to_cancel. However, as discussed with Greg KH and Maarten
Lankhorst on the mailing list, the correct and most maintainable approach
is to backport the mainline commits that inherently resolve this by
removing the custom vkms hrtimer entirely.

Following Maarten's roadmap, this series cherry-picks the exact
dependency chain from mainline to introduce the drm_vblank_helper
infrastructure and migrate vkms to it. 

The series applies smoothly to 6.18.y and completely resolves the soft
lockup in the fuzzing environment.

Thanks,
Mingyu Wang

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

