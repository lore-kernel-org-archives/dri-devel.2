Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18983C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B65110E687;
	Tue,  4 Aug 2026 10:09:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FVHuln2J";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1FB10E12F
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838194;
 bh=2wpTawbUiGFGrS7RN/caIgMdAvB/bpBx3yG/Xsme92M=;
 h=From:Subject:Date:To:Cc:From;
 b=FVHuln2JnHWBwybZ/hmSBloHdTOFsS7Sk+NmyQRZNsr9SgzGYduqeCfBf7+tVEDVX
 9Igx8lRB4OK8RsOK9DI6VT8Iluf8WvBQtEnm6sHvQoj3DWswT08+7IiLdi8mA35psw
 KUBIdQ+/O8G1Nsm3DPiEiTHWmH46GwOXk+0dHlyGWFuDs42+FTbUFd6YRlACuLAtCs
 S5eYhfny0X3I5rIlaIUIT0OZtlgNm5HISXTqAYB/LSI0WkeqE6ax52oGRI4J8/DnWh
 evxwhzdQs06TMn4zotBY6KjKQMV4G0ssyH+v+vzbszwN7op/QjVngkxtR+F4R1xrBP
 YhQLbPaYNtDng==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5F17017E0892;
 Tue, 04 Aug 2026 12:09:54 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 00/12] drm/panthor: Fix the unplug logic
Date: Tue, 04 Aug 2026 12:09:39 +0200
Message-Id: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMyw6DIBQFf4XcdUmQUin+SuOCx1VJKiiPponx3
 0vqcuZkzgEZk8cMAzkg4cdnH0OD7kbALjrMSL1rDJzxnj2ZoJsOZYmJ1rC960wn/8VMpeLS3J2
 zfFLQ0i3hf2jla7w44V7be7kkGJ2R2riuvgxECFRoHlr2vIPxPH/JRJp4lgAAAA==
X-Change-ID: 20260804-panthor-unplug-fixes-7927b3ddc2f9
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=1724;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=2wpTawbUiGFGrS7RN/caIgMdAvB/bpBx3yG/Xsme92M=;
 b=RN8XWea9gnG0b9qTpFRwp3zFF+xa3j2YE7y8k6+i2BU8KJSyyE6foiMWMSXc2fXJ2gas6lKmM
 qUTMvq5ou9nAoxa/LUhMFH60po2edu4ClejXOQFmAW63GpTeKKD5w+c
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
Boris Brezillon (12):
      drm/panthor: Disable reset work before unplug
      drm/panthor: Further delay reset work enablement
      drm/panthor: Move the debugfs initialization to panthor_device.c
      drm/panthor: Flush the cleanup_wq before destroying the drm_device
      drm/panthor: Drop unused vm argument passed to panthor_vm_prepare_sync_only_op_ctx()
      drm/panthor: Split panthor_vm
      drm/panthor: Add fine-grained restrictions on VMs
      drm/panthor: Check AS state before disabling
      drm/panthor: Don't pre-allocate VMAs or page tables when preparing a full VM unmap
      drm/panthor: Make the VM cleanup path more robust against UAF
      drm/panthor: Make the unplug logic more robust
      drm/panthor: Fix unplug in the reset path

 drivers/gpu/drm/panthor/panthor_device.c |  155 +++-
 drivers/gpu/drm/panthor/panthor_device.h |   37 +-
 drivers/gpu/drm/panthor/panthor_drv.c    |   12 +-
 drivers/gpu/drm/panthor/panthor_fw.c     |    9 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    | 1374 ++++++++++++++++++------------
 drivers/gpu/drm/panthor/panthor_mmu.h    |    1 +
 drivers/gpu/drm/panthor/panthor_sched.c  |   17 +
 7 files changed, 1015 insertions(+), 590 deletions(-)
---
base-commit: 44e9eb5a762142a4aa46c0b5da7c39bfeb78910e
change-id: 20260804-panthor-unplug-fixes-7927b3ddc2f9

Best regards,
--  
Boris Brezillon <boris.brezillon@collabora.com>

