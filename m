Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9BFC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5565B10F4DD;
	Thu,  2 Jul 2026 16:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Z4I2NWrM";
	dkim-atps=neutral
X-Greylist: delayed 314 seconds by postgrey-1.36 at gabe;
 Thu, 02 Jul 2026 16:29:55 UTC
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F355C10F496;
 Thu,  2 Jul 2026 16:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
 t=1783009479; bh=IY5C6F1/QEO/Tb6bgJrWUfZwUAuddxbrXqk1mvKaQME=;
 h=Date:Subject:From:To:Cc:From;
 b=Z4I2NWrMuK7o6dkdA3eom/gnVJMtzM+pHTiA+poVFlYWJRbtobsG4Xv4rZx79uHxi
 yCC2zVVXuHk3djLK1MOBT1AsabhBlDHL1d1H3vGz76lKp8B4AN+8gvodq44Bf7jK7x
 IZDm3svpa4fuBFJW7XUC3nqcpFBE777f4RwKZopIQawIIgxf4+6v+TFpgaqVKVVrDq
 fZgIj44mMOMkyH6OxHuW/lq+AaBUuG7IcFMEda7wgP9a6sshAHk4pn26+q8SKlTJUJ
 HKd97VMEV/a5PcniZobXzDEISnH7QGuO2gOoURezeYSW9EUGV0JRrwMfoLQjhMtIpQ
 iXnDd0VEzjyaQ==
Received: from remote.user (localhost [127.0.0.1])
 by rere.qmqm.pl (Postfix) with UTF8SMTPSA id 4grhzp0HGWzBL;
 Thu, 02 Jul 2026 18:24:37 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.4.3 at mail
Date: Thu, 02 Jul 2026 18:24:37 +0200
Message-ID: <cover.1783009338.git.mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/5] Random debugging quality-of-life improvements
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
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

This is a set of small improvements to debugging and error handling in
amdgpu driver. Please consider each patch independently.

Michał Mirosław (5):
  drm/amd/display/amdgpu_dm: show error names
  drm/amd/pm/smu7: make SMU message reports more readable
  drm/amd/pm/smu7: return error on message send failure
  drm/amd/amdgpu/cgs: Avoid redundant copying of firmware filename
  drm/amdgpu: debugfs: avoid extra EOLs in amdgpu_gem_info

 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c       | 54 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 40 +++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 +++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 12 +++--
 .../drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 25 ++++-----
 6 files changed, 76 insertions(+), 78 deletions(-)

-- 
2.47.3

