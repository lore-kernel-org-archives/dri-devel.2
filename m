Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4C2C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6614A10E2E6;
	Wed, 26 Aug 2026 14:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MUeuMttq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EBA810E0A5
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756179;
 bh=YFWc9SIRLzCxqyMe/dnrb2UbNKSAFmuiL/Ovzn66a30=;
 h=From:Subject:Date:To:Cc:From;
 b=MUeuMttq1cO1nZGB7YcN3qGoHMKJGkO4QkxKK7BDHM4GbwmKpXAbz9kIgZqN9PgpD
 bISiqPnZ9PXmnZSB4p8JaFBaV83tpo9VLkmG0xhSlo0rQAC4nXO8M0wC1q6jIMPqYa
 GDyo6OInm5uZnoQxJ8+N5TMzY1Z2UHfee8m35YDdlN1hiW3LI5OukmwHlWPy8zLUaa
 mTaw4WOX0oUY/WRn/DMqIz59gEo7uh7RzglFjnRDIyPos7htghZdUuOpxxp6Hxc3bE
 FGttoSNSWoW86v4iMtkx4ERKfRCyBzG5eNMyqc5LPmvY5ai0i/BbKTIh9PIfSf2PFO
 yIPwBe0nde5Zg==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0BA2317E035F;
 Wed, 26 Aug 2026 16:56:19 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v4 00/18] drm/panthor: Fix the unplug logic
Date: Wed, 26 Aug 2026 16:55:59 +0200
Message-Id: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32QwW6EIBCGX8VwLo0MrIinfY+mB5BRSVRcUNJm4
 7uXukljmm6P/0zm+2bmTiIGh5E0xZ0ETC46P+cgXgrSDnrukTqbM4ESqrIuBV30vA4+0G1exq2
 nnfvASKUCabi1LXSK5NEl4NHIk2/vjxzwtmX6+igSoyPS1k+TW7NNoEJz0bICRs7mpji8AtSPN
 7p+1iPtgp+oCzdqOa9q0QkLCpokybducHH14fM4KrHD9//+idGSamOMBSuYYfza+nHUxgf9mpc
 8oAlOIMaegCCDKnOpOXLZKY1/gfgZxJ+AeAZxtPkzFTMG5W/Qvu9f7khF270BAAA=
X-Change-ID: 20260804-panthor-unplug-fixes-7927b3ddc2f9
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=10570;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=YFWc9SIRLzCxqyMe/dnrb2UbNKSAFmuiL/Ovzn66a30=;
 b=sc5hghVzMSYE1M6e15PWNrXPzFlFNiKvVDZxExyZrKkypxAtKp7z4k/fPdWtP7C2NIkPgfQWZ
 AQot9odCQlVC6bD4s6UB8OUY3jHJNQ5M8V38BmYKc/O1NJpBoSj4EBC
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
Changes in v4:
- Revisit the RPM teardown logic to properly control when the last call to
  panthor_device_{suspend,resume}() happens
- Revisit the logic to temporarily disable the reset work in order to simplify
  the state tracking/locking
- Make the cleanup_wq/pt_cache device-local instead of global
- Make sure an AS won't be put back in the reclaim list after the VM has
  been destroyed
- Assume SOFT_RESETs can never fail to simplify things (no more explicit memory
  leaks needed if this holds true)
- Make sure l2_power_off() errors are taken into account with a
  __must_check attribute
- Link to v3: https://patch.msgid.link/20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com

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
Boris Brezillon (18):
      drm/panthor: Disable reset work before unplug
      drm/panthor: Revisit the reset logic to avoid reset request loss
      drm/panthor: Make panthor_device::pm::state non-atomic
      drm/panthor: Flush the cleanup_wq in the unplug path
      drm/panthor: Make the page table cache and cleanup workqueue device-local
      drm/panthor: Drop unused vm argument passed to panthor_vm_prepare_sync_only_op_ctx()
      drm/panthor: Move the debugfs initialization to panthor_device.c
      drm/panthor: Split panthor_vm
      drm/panthor: Add fine-grained restrictions on VMs
      drm/panthor: Check AS state before disabling
      drm/panthor: Don't pre-allocate VMAs or page tables when preparing a full VM unmap
      drm/panthor: Let l2_power_off return errors and force users to check it
      drm/panthor: Complain if the SOFT_RESET fails
      drm/panthor: Make the VM cleanup path more robust against UAF
      drm/panthor: Track user owned VMs
      drm/panthor: Track user owned groups
      drm/panthor: Fix the unplug logic
      drm/panthor: Add debugfs knobs to simulate reset failures

 drivers/gpu/drm/panthor/panthor_device.c |  282 ++++--
 drivers/gpu/drm/panthor/panthor_device.h |   42 +-
 drivers/gpu/drm/panthor/panthor_drv.c    |  179 ++--
 drivers/gpu/drm/panthor/panthor_fw.c     |    9 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |   17 +-
 drivers/gpu/drm/panthor/panthor_gpu.h    |    2 +-
 drivers/gpu/drm/panthor/panthor_hw.h     |   19 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    | 1566 ++++++++++++++++++------------
 drivers/gpu/drm/panthor/panthor_mmu.h    |    6 +-
 drivers/gpu/drm/panthor/panthor_pwr.c    |   22 +-
 drivers/gpu/drm/panthor/panthor_pwr.h    |    2 +-
 drivers/gpu/drm/panthor/panthor_sched.c  |  141 ++-
 12 files changed, 1455 insertions(+), 832 deletions(-)
---
base-commit: 44e9eb5a762142a4aa46c0b5da7c39bfeb78910e
change-id: 20260804-panthor-unplug-fixes-7927b3ddc2f9
prerequisite-change-id: 20260429-panthor-signal-from-irq-d33684f4d292:v7
prerequisite-patch-id: 35735cbaa1997e2df4b2aae61970d580a94e755a
prerequisite-patch-id: 1b18d1d374715eaf8d1141ac9e51a0e304cf01ba
prerequisite-patch-id: ec524c6adfca6c0d694e0a750dc19e8eac106f45
prerequisite-patch-id: 4dc1e1dd06539c8274987208ba8737d2ab9bec30
prerequisite-patch-id: 2c4b51b7853ae85888e3181b00425f5615eb81ac
prerequisite-patch-id: 7d0cc8e0ec61131f0c715a8c74cb73aceffb1124
prerequisite-patch-id: 05ef0af6f1bc9567b4e2ee4405d9cf8ce3e3ecc0
prerequisite-patch-id: e8134f9708010d4c679db257f022acb26ce2e9e7
prerequisite-patch-id: 655903bf9a0a260a2710ff18d812d3c979eedab4
prerequisite-patch-id: 209e8372941a405f50de769d92cde6d3550f4e01
prerequisite-patch-id: 2a204da753bafd464e1751392b63120480f3273f
prerequisite-patch-id: 58c2642c2468fa75e5f2132e09a3ced3b55d4adb
prerequisite-patch-id: 380faeb44cb4b192271235ed6a08ce3727ee8851
prerequisite-patch-id: 9efcb5ec489431979c45da11452c9c1765e70997
prerequisite-patch-id: c210d79f7d6bf76aaaa1142f7baf262aca8289fb
prerequisite-patch-id: 7c885da1b72b8efe9bff3af120fb14496a0327e9
prerequisite-patch-id: ee8eebffdd3caeb4ed21c16375f6b6cb11370fab
prerequisite-patch-id: 5d4289478982e6aa6c96b12ba051c4dc2eaf172f
prerequisite-patch-id: fdd0adb45d355662f5e0705e5bd42f41b5db68cd
prerequisite-patch-id: ddfb77436009ac891520f244f6628a57055a1bb3
prerequisite-patch-id: 8a8e7fcea2aed0893668fec395e71b37a0a8ae76
prerequisite-patch-id: b2f5eff9ffefff9feaede54c74a9fa78c03a3124
prerequisite-patch-id: 5e4dc08b9eede222f1dbc697cc030cb07fb4a6bc
prerequisite-patch-id: e932978d746d3bffdedbef47410049bab51c02a9
prerequisite-patch-id: 3dc5c92615aa215dcba8755659b6fb66b4663eb8
prerequisite-patch-id: c3ad370d5b3a3501edbaf3a36cc6cdedb5491b69
prerequisite-patch-id: b69fed0ac3c13bdfccc42f17ec7979c31d6b4866
prerequisite-patch-id: 2680125abbc0415771369c1755987cb7f6edf1ba
prerequisite-patch-id: 3e883d51ce7a70c57cc081ddf28be2636a347b47
prerequisite-patch-id: 1fd1fe22f8fb8cc1bb89211fe48727cf1f5cebce
prerequisite-patch-id: 602326650213640640f1e20a44a7d61e01dd9d57
prerequisite-patch-id: 8cbd2db8da9f956a7e5c41f3136c2ddbec59825f
prerequisite-patch-id: 99912d0bd174abefd133a01fd3cea9847d9bb3a4
prerequisite-patch-id: 7d576356820309ef320ae3420918546123aa6bfc
prerequisite-patch-id: 6ba2744f009ca7fbe05fc171b431907760861c24
prerequisite-patch-id: 28bf3b7eb553e9838a988bec26f021a67436d37f
prerequisite-patch-id: 6098f85b57866459e3f1c910985f4017a0b02480
prerequisite-patch-id: 583606866f8aae3e5429271abf352bdfe80eb6af
prerequisite-patch-id: 8345e72ae5ba8de92d422980143c11f4527e9517
prerequisite-patch-id: e5e47df8f9e416bdee9f8c7dddd55ea132d295f2
prerequisite-patch-id: 8310631a5a1f522d310e8d11645e49840713ab54
prerequisite-patch-id: a8f0c66891e2d9a619a2fe9662186645489654dc
prerequisite-patch-id: f75eef43b5cbe151cc4e1d6f361ef41597a82582
prerequisite-patch-id: da421d8737bd1fd84a3c954ac166a57d8ef00cea
prerequisite-patch-id: 3c7a7c8ff073984e6bd1d329e6c59685334f2703
prerequisite-patch-id: 2faecdc38e12ef87aa7a1d5aa063cc67b2c4c72f
prerequisite-patch-id: df7bf83ab2de05b0e38935f8d9e481f6fd1aef02
prerequisite-patch-id: 5179339320cdc5381beefd2733fe961185bba9bc
prerequisite-patch-id: 8176015aa4bd977a36116673ea2921d5e659c9df
prerequisite-patch-id: 9da6d54591d5c0db98070d62a55dee95e8245cfc
prerequisite-patch-id: ed025417c1b221930a9d9defd4caf72ed9007663
prerequisite-patch-id: cc44ec1f5cf026f560f35d60e9b314e8738f6b52
prerequisite-patch-id: aeb3c2f38dd8d3e2561a915ae046d5c1ca9b6fe8
prerequisite-patch-id: 15591002611d855b070236366d885690f15dd70d
prerequisite-patch-id: 40e60acb3fe63fb81249251538ad9e150c137384
prerequisite-patch-id: 521c7e7d8e1a4eae568410ac74e008b75675f5e7
prerequisite-patch-id: 020043b86caebb6a8ef08b83e9243c5a870eab6c
prerequisite-patch-id: 719e285f54f8bc3fa3869e2ebd444312275b0970
prerequisite-patch-id: 1c1ded1281059aae3b2a87a117b9a7afc697d132
prerequisite-patch-id: 54a23de4e88f7a4abeb3ea205b30e5ede017a809
prerequisite-patch-id: ce5dd51a1562240c3a7b31201da62a5bd2d2a48f
prerequisite-patch-id: 09d082023004a7b90621a2db3cf9732facbf211e
prerequisite-patch-id: 4db42306fbcb07e9fd2eb1a73f64fb19bf2b141c
prerequisite-patch-id: d3f04d3510049bedf8eec82c2e6adfd01cd1f460
prerequisite-patch-id: 4fcd5ea808977e11aa4ef85e75baa8c13103800e
prerequisite-patch-id: 8b27be15d44641eedc4b0daa097c750b00286cb5
prerequisite-patch-id: be81db0e4f0528ef028a50e861f9350e964ecb70
prerequisite-patch-id: 9455eed728beca427378866051d80d8e8f55a679
prerequisite-patch-id: 26b15a5819a92b0481b900175ff22a31608a9de5
prerequisite-patch-id: 79fbfdd0ca009249978c3c349e66df957ed140a0
prerequisite-patch-id: 98723c87b69e65f8602b6450b5e037486a78eb90
prerequisite-patch-id: fd9ad21628d14109f863fcb31f3a8bf31cf08370
prerequisite-patch-id: 08bc16eeba34a85020885a8a83c50017d7a1aa80
prerequisite-patch-id: 257cbc08f24a92b2734a3ec0f044bedde8e81b00
prerequisite-patch-id: 54aa12783bac8524b468e961b89157cbd64cb1e1
prerequisite-patch-id: 9b1f83c6c3141da339965ad96c17e5d31b98e5a6
prerequisite-patch-id: 0a36c69593ad7455cfc4f23abd273753f07f2d34
prerequisite-patch-id: c42c70c43731fc0ec612c7feb5eebec6e667fff2
prerequisite-patch-id: 42e95b3e450413d2306c11cee88e3a8787843759
prerequisite-patch-id: dd579c9d4cfd06a62ff58c4180410efa2bc51f24
prerequisite-patch-id: ab25d3567d5d3e32f4a7b42c69317d1bf4d86e16
prerequisite-patch-id: 75ee7cdc29cd45f924889757a56e144ab5ea4455
prerequisite-patch-id: 93b12e5839fe895a081c9d3eb88f4e6233cb26ab
prerequisite-patch-id: 79820e6740c0c456efc1dfa273de04e495515a1c
prerequisite-patch-id: f518e06627c0d6055453ae279add55bce203806d
prerequisite-patch-id: 944933d170f17be13a43e50588e35826974c76cc
prerequisite-patch-id: b0097ee5639defbadfe69cc19bf172e790021fe7
prerequisite-patch-id: 8a197a241c2904e99dc49d6b80d52ba1128a368b
prerequisite-patch-id: 1380f7788e59064b639513a4b5a27480e4e34b6a
prerequisite-patch-id: e1d60ca759b4607804e991a3e61b579742696fef
prerequisite-patch-id: d406492379391d3bc1c0984b5e87ca0d2e0674ad

Best regards,
--  
Boris Brezillon <boris.brezillon@collabora.com>

