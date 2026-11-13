Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CCB606A327
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P5FLy5u5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC0FF10EC85;
	Fri, 13 Nov 2026 20:24:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC25710E04F;
 Fri, 13 Nov 2026 20:24:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 457E045B58;
 Fri, 13 Nov 2026 20:24:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794601490;
 b=Ay9XZeqspdXCLsBN8mpuqVA50v05T4l7uRzDnFJPNTKUyX1YrRc+yPIWS1mRFQRVj0tw
 8aPaIKWsSgnT1LVXZJYmxCIFPL18mTndgDU8uVh7Cxaad6l7tgV2Ef2Fe1zF3vwU2tG37
 RCWN+1IxN563CAMZxXAm3CNpIU+hIewvRD9UJzJ/SGbEvvhpyb5HhR1cpAnOHdu6TgFv8
 Jhm0VMfkGLbWyoXavmw3Vda7TrUL4Yscw5+qKrcw8Yg/1sgpZ+mz+iS5XOHTydr6IiJgg
 P2gSmMHfegLG0xqc8AMTsFq2E1zQFd67rsr1Zngrb+6HMU5BFjz/RmK8pyJ3tFQKASQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794601490;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=7YHiwcMUuPl1orWkDGedWTRTH1mJAdTS5/v2XtAzJa4=;
 b=Ky66ixbbEcTVMnw6uxYDc+aCCdvN3moTDBk7HhCzyGyLzKQC9xaN+PvappwVUKmqFrxS
 L8Ju2MQI64R8NUHszSjLzk54qxIr68vnZXS+BuoDPt2iN9bLxbV9Zse6dbCcH2t8w+9a3
 07/C42v+vx85xBfMwE+Ok7TVpkTfVjKUHaNnI2bsEITSMiXi+4KUs5rKSrRiBb2riFQYp
 66ZNW9UDeO3aLCsCbZs1AZLWAFVuwdKV0ir9jti/1vsOoBD1Q/+DXSEyNNCPU19rtlYLn
 9rgjIoD7bE6QpwZQg3RFCHkF8MyZQN44UJ8MfBvikLOvJlIbXLvjm3X4hcWkGkqLPcw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 26CC61F000C4;
 Fri, 13 Nov 2026 20:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794601490;
 bh=7YHiwcMUuPl1orWkDGedWTRTH1mJAdTS5/v2XtAzJa4=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=P5FLy5u5u0HdgvthVHVao6aSAAP+n15Qdys/N9TCR+IjONAvgQbk4536vK+POKUy0
 8ybSt/AnV6lEfT0KMEvgMnAFoNeKmv8hemk3YUNcVFjjJEeia3g5XcXe72RmnTMQfp
 VAxxIKGC5PP3Ofzb8v/Rp1nsHMWGH8iGQDX2aKPZFYhR0/qU4Y0+SLt6OR8UIrgqif
 YwuxAfcDAl4CXpfovpfgthHPzZwK71dbbAnxmYXJzcNdCy2VqQx7vKIHCYrZnJOyfQ
 lGtMjA/W/CZfxB4X4+ftqDPrW6K4Xk/gCfN7LBbJ1WdvS6G06fZTkRB+8y4GDHrIwv
 KgYIVx0xs+b+g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id A886449AD0;
 Fri, 13 Nov 2026 20:24:48 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Subject: [PATCH v2 0/5] drm/amd/display: Commit panel_power_savings writes
 from the kernel
Date: Fri, 13 Nov 2026 20:24:47 +0000
Message-Id: <20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPS26EMBBEr4K8TkfYgDGsco9oFm27PTgKn9gGz
 Wg0d4+BRFlkWVL1q9cPFil4iqwvHizQ5qOfpxzES8HMgNOVwNucmSiF5LzkgHqEeI8ugpnH0Sf
 oJFbKEkcjJctnSyDnbwfy/XLmuOoPMmnn7I3BxzSH+7G58b33ixf/8RuHEqhBa53tmqrDtyHi5
 2vmX54nPdDXmr3TOfmnnb84qLwCHO11WWGJ4RhYF4uJYKJbAkui1EZUmgvTb2L30xjpZ74vNNa
 d1FpVrVKCNEfXKFfzphXOCNVRLU3bamWyzvMbtHizmk4BAAA=
X-Change-ID: 20261101-abm-sysfs-commit-96a38de1ac66
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Alex Hung <alex.hung@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6571; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=Z+B7EYH/cs0wT10GwtFfFZ6Vmbt0trdeYZW28crr0lk=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsr4X8Wvaqzzebetyj/E0W/ESY2XPZq0/zAcmHS28b
 bD8VrTkT8aOUhYGMS4GWTFFFt0bngwsEyfPzCl6vgRmDisTyBAGLk4BmIjBQ4b/8YnZug0bss98
 PXL9LqccT6+81PqjOoJ5MpukJ989EqEhxcgwQS3xWnXqm5AN9nzHKt5fsLQLfDPV9Ey5qcuZL5a
 iPJW8AD6bRqQ=
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Endpoint-Received: by B4 Relay for hugo@hsal.es/default with auth_id=1417
X-Original-From: Hugo Sales <hugo@hsal.es>
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
Reply-To: hugo@hsal.es
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A write to panel_power_savings stores the ABM level and sends a hotplug
uevent, but the level reaches the hardware only on the next atomic commit
that includes the eDP connector. Hyprland adds the connector to a commit
only on a modeset or when a connector property it sets changes, so on my
laptop the file read back the new level and the backlight never changed.
power-profiles-daemon writes this file on every profile and AC change, so
none of its ABM changes applied

This shouldn't need a fix in every compositor. The file is for writers
that aren't the DRM master, like power-profiles-daemon, and they can't
commit anything themselves. Today they depend on the master taking a
generic hotplug uevent as a cue to commit the connector again. Nothing
documents that, and a compositor has no reason to read a hotplug event as
"a property you never touched has changed". A compositor that wants to own
ABM sets the 'adaptive backlight modulation' property, and from then on
the file returns -EBUSY. The file has to work without the master's help.
The backlight device already does: a brightness write goes straight to DC,
with no commit at all

This series makes the write commit the level itself:

  1. Render the existing kernel-doc, which no rst file included
  2. Stop forcing a modeset when the connector's ABM level changes. DM
     already sends a new level as a stream update, and the modeset flag
     dates from before the CRTC was added to such commits
  3. Move the store tests onto a full pipe the store can commit to
  4. Commit the level from the store through a duplicated connector
     state. The write returns the commit's error and no longer sends a
     uevent
  5. KUnit cases for a connector with the CRTC on, off and failing
     atomic check

Patch 2 also asks, below its cut, whether scaling can leave the same
check

v1 of the patch that added this file had no flush [1], and Mario found
that the level only took effect on the next modeset [2]. That patch's v2
changelog says "force an atomic commit" [3], but what was merged, commit
63d0b87213a0 ("drm/amd/display: add panel_power_savings sysfs entry to
eDP connectors"), sends a hotplug event instead

Commit 8d20a066fa9b ("drm/amd/display: change the panel power savings
level without a modeset") later applied the level outside atomic. It
broke igt abm_gradual, and commit 95aaa207e9ef ("Revert "drm/amd/display:
change the panel power savings level without a modeset"") reverted it.
The objections back then were to sysfs overriding the DRM master at all
[4], which the property above now covers. I didn't find any discussion
that rejects an internal atomic commit

A write now returns the commit's error instead of storing a level the
hardware may never get. power-profiles-daemon logs the error and tries
again on its next profile, AC or battery change. Nothing I found reads
the uevent for more than a cue to commit the connector, which the kernel
now does itself

The commit is blocking, so a write can hold the CRTC locks for up to a
frame while a compositor commit waits

Tested on my laptop (ASUS ROG Flow X13 GV301QH, DCN 2.1) with v2 on 7.3,
under Hyprland with no modeset during the run:

  - 25 writes cycling levels 0 to 4 all succeeded and read back, with no
    -EBUSY and nothing in the kernel log. A write sends no uevent
  - I wrote 4, 0, 4, 0, 2 and 0 six seconds apart and read
    amdgpu_current_backlight_pwm and amdgpu_target_backlight_pwm every
    half second. After each 0, the backlight was back at full PWM by the
    next sample. After each 4 or 2, the target dropped, to 25% of full at
    4 and 52% at 2, and the backlight ramped down to it
  - With "drm/amd/display: Leave self-refresh before an ABM level update"
    applied, a commit that changes the level takes the panel out of
    self-refresh. All five writes that changed the level did. Four of
    five writes of the current level left the panel in self-refresh,
    since they no longer commit. The fifth most likely met another screen
    update
  - igt amd_abm passed all five subtests on v1. I haven't rerun it on v2

[1] https://lore.kernel.org/amd-gfx/20240126222300.119292-1-hamza.mahfooz@amd.com/
[2] https://lore.kernel.org/amd-gfx/1162e59e-3f53-4c84-b186-bb2f4642216b@amd.com/
[3] https://lore.kernel.org/amd-gfx/20240202152837.7388-1-hamza.mahfooz@amd.com/
[4] https://lore.kernel.org/amd-gfx/b117ccc0-6569-4753-9cb9-c304f9e50d30@amd.com/

Changes in v2:
- Patch 2: name commit b05e2c5e81f9 ("drm/amd/display: Update ABM crtc
  state on non-modeset") as the one that lets the non-modeset path carry
  the level, say the KMS property loses its modeset too, and
  say "drm/amd/display: Leave self-refresh before an ABM level update"
  has to go first
- Patch 3: set level 2 before the test that writes 0, so the write
  changes the level
- Patch 4: return without a commit when the level doesn't change
  (Harry). A write that changes nothing, or that the DRM master forbids,
  no longer wakes the GPU. A write that a signal interrupts restarts
  instead of failing with -EINTR
- Patch 5: test a write of the current level, check that it and a
  forbidden write leave a runtime-suspended GPU suspended, and fold the
  CRTC on and off cases into one parameterised test
- Link to v1: https://lore.kernel.org/r/20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es

---
Hugo Sales (5):
      drm/amd/display: Render the panel power savings kernel-doc
      drm/amd/display: Don't force a modeset when the ABM level changes
      drm/amd/display: Give the panel_power_savings store tests a full pipe
      drm/amd/display: Commit panel_power_savings writes from the kernel
      drm/amd/display: Test panel_power_savings commits

 .../gpu/amdgpu/display/display-manager.rst         |   3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 118 ++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 271 ++++++++++++++++++++-
 4 files changed, 376 insertions(+), 19 deletions(-)
---
base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
change-id: 20261101-abm-sysfs-commit-96a38de1ac66
prerequisite-change-id: 20261113-amdgpu-psr-abm-update-next-de20bc23b12c:v2
prerequisite-patch-id: c6cbeb4671914753ab7526369c2612039ae16504
prerequisite-patch-id: efc64b5a0a1bc2d46494d4797b0d25447b174076
prerequisite-patch-id: 496307c9687a947cfbfdcf1b6d0ad6ba1b6d4089

Best regards,
--  
Hugo Sales <hugo@hsal.es>


