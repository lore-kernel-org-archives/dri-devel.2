Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D2EC5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 10:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAB110E2F8;
	Tue, 11 Aug 2026 10:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DJ1K7LkV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3957A10E2C5
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786443467;
 bh=n2LFrJBjqEt0S3FwnAc/qzIpuno0S80LfEbfke81lOk=;
 h=From:Subject:Date:To:Cc:From;
 b=DJ1K7LkVRiBy1ySELffjMC/Q3S4+C0F9mMu3SlZHXJIiydMC/0f8lz5pg+pOKgKJv
 rb8IK19ZlQlPH7Kq0Bo6vcMHiOgQ/9Q+tJocX1WNL8m64jj95nJEDlsnby/FKtFoXw
 OFd3ETEubEBRProA3b/pUZ7h37vGRpyOXpk8Ukf90WF5+DYhz7HGSCJWKviu/HFr6x
 jORwPx4TJ/eBTfGug2Udkn+Km6Z2ju4AaaMzknERjs2UcMKY4a3Lsp6E/kvO47rE+z
 BmjPV7rH2oaOzmwxKre+L8bQFWw8y28LJNEF7TI62pFygZFrpzv5m2nA5XLIfMiv/I
 bQQzuav2Od4yQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 151BD17E0048;
 Tue, 11 Aug 2026 12:17:47 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v2 00/17] drm/panthor: Fix the unplug logic
Date: Tue, 11 Aug 2026 12:17:34 +0200
Message-Id: <20260811-panthor-unplug-fixes-v2-0-6b583e37f9ae@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf4XM2pq2VBBW/odh0ccATYBiW4iG8
 O9W2Ls8M/fM3A0CeosB6mwDj6sN1k0J+CUD3cupQ2JNYuCUF/ROBZnlFHvnyTLNw9KR1r4xkLL
 ipcqN0bytIKmzx2ORzGdzssfXkq7HcwhKBiTajaONdSYEVqhusiw4g1++tyE6/zlarewQ/hdYG
 aFEKqUMN4Iplj+0GwapnJfX9AWafd+/4hQRz+wAAAA=
X-Change-ID: 20260804-panthor-unplug-fixes-7927b3ddc2f9
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786443466; l=2682;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=n2LFrJBjqEt0S3FwnAc/qzIpuno0S80LfEbfke81lOk=;
 b=v7NPLYnspfQdvWNBnlDY9EUEQf8vkpa6znb/YzgXyFLmkgt6EA9z9TIts2czERtwdzn+Kelui
 mwyZwrFmyY1D+6WtWWG2fQnJPWHEHfg5NEqAc3gNeEbe81q3pTmPH50
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

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
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

 drivers/gpu/drm/panthor/panthor_device.c |  175 +++-
 drivers/gpu/drm/panthor/panthor_device.h |   38 +
 drivers/gpu/drm/panthor/panthor_drv.c    |  124 ++-
 drivers/gpu/drm/panthor/panthor_fw.c     |    9 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    | 1453 ++++++++++++++++++------------
 drivers/gpu/drm/panthor/panthor_mmu.h    |    1 +
 drivers/gpu/drm/panthor/panthor_sched.c  |  128 ++-
 7 files changed, 1284 insertions(+), 644 deletions(-)
---
base-commit: 44e9eb5a762142a4aa46c0b5da7c39bfeb78910e
change-id: 20260804-panthor-unplug-fixes-7927b3ddc2f9

Best regards,
--  
Boris Brezillon <boris.brezillon@collabora.com>

