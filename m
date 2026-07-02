Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF21C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64FC10F1D2;
	Thu,  2 Jul 2026 08:03:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="QQ6+Xbo0";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C92910F1A6;
 Thu,  2 Jul 2026 08:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782979393;
 bh=p8vFu5ZO38DeWmtmHerWiYppbZkyxOD03KdKcavkyNM=;
 h=From:To:Cc:Subject:Date:From;
 b=QQ6+Xbo0aUUlsMTub56+hRJGWUiGHIZjDYZc70h0qXenRG0W+EWPcOB5Z3WtVLH03
 VUI266B0M2yjx5/W72QjIOpmq3NhVu966pZ3PbV12gdva+rLevwTYay/QVxUij2PNT
 iAD1NfG4+JdXmbf0WNRW5eIz3HvKg2YBnJ3lGgW4reJ+A4LSIp5aGaB0tKwaTF7uA3
 7ElsHmGSP+wKEX08s0mvAPSWuc5j6yMxqwa76b9IicyccnyI457KA/dGg5dAef8ems
 hMCSprRPyNVHTqeOLRVA4W+NwCUIXxQM/kBo+PCYz3LD3Zf80YJahd2BeCF52rsZ4p
 Od837zuYD7M0g==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 0/4] drm/intel/display: Remove forcewake during pipe updates.
Date: Thu,  2 Jul 2026 10:03:41 +0200
Message-ID: <20260702080346.431508-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
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

Change all calls that use the normal intel_de_read/write variants to use 
the _fw variants. This prevents taking the DMC wakelock unnecessarily
during vblank evasion. If the DMC lock would be needed there, we should
instead take it in advance when needed.

Maarten Lankhorst (4):
  drm/i915/display: Make icl_dsi_frame_update use _fw too
  drm/i915/display: Use intel_de_read/write_fw in colorops
  drm/i915/display: Use intel_de_write_fw in intel_pipe_fastset
  drm/i915/display: Make set_pipeconf use the fw variants

 drivers/gpu/drm/i915/display/icl_dsi.c       |  4 +-
 drivers/gpu/drm/i915/display/intel_cmtg.c    |  6 +--
 drivers/gpu/drm/i915/display/intel_color.c   |  6 +--
 drivers/gpu/drm/i915/display/intel_display.c | 52 ++++++++++----------
 drivers/gpu/drm/i915/display/intel_vrr.c     | 18 +++----
 5 files changed, 44 insertions(+), 42 deletions(-)

-- 
2.53.0

