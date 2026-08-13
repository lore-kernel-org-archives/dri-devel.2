Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD52C5CFEB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4FFD10E4C5;
	Thu, 13 Aug 2026 10:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eKcuAMlB";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5208010E4C5
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786618622;
 bh=j6EAf47SHJISxupDTfLLM/lak1zxCPjvWl8BxZ3vYLI=;
 h=From:Subject:Date:To:Cc:From;
 b=eKcuAMlB3HSSyD+wRxTZslOZDCgYMKkmAW3JyiTJrgitHPoMv2uWSsvQtSnorLXaT
 dtbNMmBBSWyP3sm6JfA0T1Cb5u7kiA799jEtZtKcmMr7ONQ4trtDVM3Qujdr4NN6Wg
 KlTf5+VUQdxkMSXQhGE4rwxfpOloy4YpxreknIkI0LOhbqgXYUaCXm8Jj0sqLwwJkP
 pzYqqhQHTPmczUgYDbSFTMA8LNXFNjW27r0h2jkQIJkal53LrP4uyXpnqf6WjcH8Tt
 U/WY4YNWoxFTYd7BTQLKUE3ptuy2Dtro1Cy16epMeXJgImhfKVRjimKZ5HM0+3G6Bp
 d+l891Bx4cDog==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5162017E013E;
 Thu, 13 Aug 2026 12:57:02 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v3 00/17] drm/panthor: Fix the unplug logic
Date: Thu, 13 Aug 2026 12:56:58 +0200
Message-Id: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf4V0bQ1tea/8D+OiQwdoAhRbIBrCv
 1vLxpjo8szMPXM34tBqdKSKNmJx1U6b0YM4RaTu5Ngi1coz4THP4iJO6CTHuTOWLuPULy1t9AM
 dzUueg1Cq5k1JfHSyGBY+eb0dbPG+ePt8DAlIh7Q2w6DnKkoSLBFSmWeckfd9p91s7DO0WlkI/
 C+wMhpTCQCKq4QBE5fa9L0EY+XZfwnSlX+IGPsh4l6UQVoIFHlTSvwW7fv+AgIZZQE1AQAA
X-Change-ID: 20260804-panthor-unplug-fixes-7927b3ddc2f9
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786618621; l=3533;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=j6EAf47SHJISxupDTfLLM/lak1zxCPjvWl8BxZ3vYLI=;
 b=GKjNHbV1lKqN7dQZ6DXZKNjtQt5gPLLZ1md8Io13B5C8jSkNMv/vP1guiONlYBVWGcJWOyaHQ
 JngFs6sG6uPDBYTQ9ACycW+g8vJZHDpAiKd2iEZrwelzP+9s7UAo1Se
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

The current unplug logic is broken in multiple ways. This is an attempt
at addressing the various problems found along the way (some were
reported by Sashiko, others have been found while trying to address
Sashiko's concerns).

Sending a new version even though v2 didn't receive any human review
just to try and address the new stuff pointed out by Sashiko.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes in v3:
- Fix a race in the reset reschedule logic we added to
  panthor_device_resume() (missing smp_mb__after_atomic())
- Fix a VM leak when reset and suspend are racing with each other
- Add missing drm_dev_enter/exit() sections
- Insert the groups in the user_owned list even if the group creation
  happens during a reset
- Try to document why some of the issues pointed out by Sashiko are
  either not real issues, or are expected (either fixed in a later
  commits, or just expected behavior)
- Fix a race between panthor_device_unplug() and vm_prep_for_cleanup()
  (introduced in v2)
- Link to v2: https://patch.msgid.link/20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com

Changes in v2:
- Fix UAFs caused by deferred cleanup works
- Fix UAFs caused by open FDs closed after unplug
- Fix deadlock when device_unplug() is called from the reset work
- Make sure reset requests are not lost in the resume and post_reset
  paths
- Fix a deadlock in the suspend path
- Fix a clk prepare_enable leak in the unplug path
- Don't use a drmm_action to flush the cleanup queue (this could cause
  UAFs)
- Drop the now unused panthor_vm::unusable field
- Keep track of user owned resources to prevent leaks and/or UAFs
- Link to v1: https://patch.msgid.link/20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com

---
Boris Brezillon (17):
      drm/panthor: Disable reset work before unplug
      drm/panthor: Further delay reset work enablement
      drm/panthor: Make sure reset requests in the resume path are not lost
      drm/panthor: Make sure reset requests in the post reset path are not lost
      drm/panthor: Flush the cleanup_wq in the unplug path
      drm/panthor: Drop unused vm argument passed to panthor_vm_prepare_sync_only_op_ctx()
      drm/panthor: Move the debugfs initialization to panthor_device.c
      drm/panthor: Split panthor_vm
      drm/panthor: Add fine-grained restrictions on VMs
      drm/panthor: Check AS state before disabling
      drm/panthor: Don't pre-allocate VMAs or page tables when preparing a full VM unmap
      drm/panthor: Make the VM cleanup path more robust against UAF
      drm/panthor: Track user owned VMs
      drm/panthor: Track user owned groups
      drm/panthor: Fix the unplug logic
      drm/panthor: Add a debugfs knob to simulate unplug failures
      drm/panthor: Add a debugfs knobs to simulate reset failures

 drivers/gpu/drm/panthor/panthor_device.c |  189 +++-
 drivers/gpu/drm/panthor/panthor_device.h |   38 +
 drivers/gpu/drm/panthor/panthor_drv.c    |  132 ++-
 drivers/gpu/drm/panthor/panthor_fw.c     |    9 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    | 1493 ++++++++++++++++++------------
 drivers/gpu/drm/panthor/panthor_mmu.h    |    4 +-
 drivers/gpu/drm/panthor/panthor_sched.c  |  132 ++-
 7 files changed, 1344 insertions(+), 653 deletions(-)
---
base-commit: 44e9eb5a762142a4aa46c0b5da7c39bfeb78910e
change-id: 20260804-panthor-unplug-fixes-7927b3ddc2f9

Best regards,
--  
Boris Brezillon <boris.brezillon@collabora.com>

