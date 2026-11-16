Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D4606A8A9
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akU+Q9fZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D2710F1F8;
	Mon, 16 Nov 2026 14:01:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E223210F1FB;
 Mon, 16 Nov 2026 14:01:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C242C46313;
 Mon, 16 Nov 2026 14:01:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794837666;
 b=D33wqzlXzR1IftqnXGYPN+KEz8iKCoLByKJ32I7bMM6QPK5tusMc6GKKdRDLOYBKskZY
 Sho0SdZIaj6u3+3f8TBFyFomOeHeAfPseuDXEsW9vdo/FSBcKzgn24V+PcRcEVSJWdBok
 BRpAii1/VVAiZGzZZ/WkZrO6/WPQthBsgC4HOeNt6F9OL3L2lnkwyOoZLnZyq0mDZu5eD
 w0a7amnY3cHX1790qOU9FxKgCm6wE2/a1m4+yyp26d7p3rza3d01CkkCv2Re2ZlUKvLOJ
 ue77Fx0IJcFWsa9BznT5K750qZiwmGd4lTAfrCqu3uVHok8tT0axrNXi4muecintUBQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794837666;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=9sKa8kK84taFvU3DD1unfRm+EL6l4cXY/Jh8rpu6nDM=;
 b=hn0S1dj8AQleSrU3e/0H38fUCxVXamuksJjLDVab0wUWgPZr3D/6twfEeKFzCnA7Dspf
 aO9bHJBG3ZTm4eQu2zk08EfD7F+jdC1wOp0ituRgrmhi4JhYOACAMGpyjuawp9/BuboPJ
 TQqb+JI0AdDMGMFYkJBGZAzeszGA+KzvCO1VmRhd2WloKvEIH+1Rlv6/GmOLQ/3vVZ7iD
 F8rx5Fk1kTkrCkUXo87JkOSzwYxxji9qS2AJWqQWLoxjQG/L0yTYdZPXfxGV+6LsD5uJm
 bWvG6qvhZCiXfTXFu7ov6xTIY94YEQtZje1U8sj0Y7gkWorQusuDAJzb/sTKRaGtOCg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id F11F71F000C7;
 Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837666;
 bh=9sKa8kK84taFvU3DD1unfRm+EL6l4cXY/Jh8rpu6nDM=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=akU+Q9fZTO8qLdbZ02EQvHEynqvSHDk4YvpOAXWXymGm+hh7V6va53g2eOqWskYNd
 RmGYWh3hb0ieTxrc0PFEULuXui3aLcgXVu5rOkTbd1A074VCHHk2DAiq7EjnTgMtiU
 pFFdhXzzICM9yfW79bddDBC1bloH0mfV0NG1OkM3PKqpF2k5hZcuwJV8x6O06OjFFO
 2FkNBgeVT4F5si/k4Jj1nmdcQ83e8Lv8mmAvj7ao8uhv6c1cxeVsfyO+xPIeQLAK3M
 eo5reisv87jJFkvGAnza8Ac4l6HY/XXhVatn86osLoyqMOcS00t5IL2bvNHz4AMLFK
 lYQhGfigog2wQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 68CD64A497;
 Mon, 16 Nov 2026 14:01:04 +0000 (UTC)
From: Hugo Sales via B4 Relay <devnull+hugo.hsal.es@kernel.org>
Subject: [PATCH v3 0/6] drm/amd/display: Commit panel_power_savings writes
 from the kernel
Date: Mon, 16 Nov 2026 14:01:02 +0000
Message-Id: <20261116-abm-sysfs-commit-v3-0-7a3d84a5328e@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22PSU7EMBBFrxJ5jVFsJx6y4h6IhYdyx4gM2E7Ur
 VbfHScBBQmWX6r3/q87ShADJNRVdxRhDSlMYwnsqUK21+MFcHAlI1pTTkhNsDYDTrfkE7bTMIS
 MFddMOiDaco4KNkfw4borX9+OnBbzDjZvnu2iDylP8bZ3rmS7+9HTv/qV4BpDq53zTrVM6Zc+6
 Y/n4t/kK/2FE/YPTgveylo6IrQAqU78cYyL8LmUt/Ox+Py6q07r4C7zgucU94JldjoDHuGasQN
 aG0uZIdR2ZU1xGp3gu76rjG4UN0YyISUFQ7RvpW9IK6i3VCpouBXCSFvmPL4AmvcqpI0BAAA=
X-Change-ID: 20261101-abm-sysfs-commit-96a38de1ac66
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Ray Wu <ray.wu@amd.com>, 
 Alex Hung <alex.hung@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 David Weber <weber.aulendorf@gmail.com>, 
 Shivam Kalra <shivamkalra98@zohomail.in>, 
 Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Sales <hugo@hsal.es>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8013; i=hugo@hsal.es;
 h=from:subject:message-id;
 bh=agewbrERfLbXrkPWku+awNiz1ig9obCaZxikdAiYcTA=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsn7zzP/5c0VLlKaFf1/xbvHAFeX2rc3u6awcFUyCG
 fNEuWeUrOwoZWEQ42KQFVNk0b3hycAycfLMnKLnS2DmsDKBDGHg4hSAicStYfjv9tYp1+zFyhUG
 E/sin2q4bytaqRfBsIFJzHWd0XvftfVbGBne+v85IVC0+tGJ7Wv3V294sDK+f1WXxO6Vz+0ygja
 3nyznAgAqakoN
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
power-profiles-daemon writes this file on every profile, AC and battery
change, so none of its ABM changes applied

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
  2. Add the CRTC's planes to a commit that changes the ABM level, which
     the forced modeset used to do. With VRR active, such a commit would
     otherwise carry only the primary plane
  3. Stop forcing a modeset when the connector's ABM level changes. DM
     already sends a new level as a stream update, and the commit that
     added the modeset flag also added the CRTC, which is all that update
     needs
  4. Move the store tests onto a full pipe the store can commit to
  5. Commit the level from the store through a duplicated connector
     state. The write returns the commit's error and no longer sends a
     uevent
  6. KUnit cases for a connector with the CRTC on, off and failing
     atomic check

Patch 3 also asks, below its cut, whether scaling can leave the same
check

From my reading, other commits that add the CRTC but no planes, like a
change of the HDR metadata, can drop an overlay the same way while VRR is
active. That needs a fix in the CRTC check that pulls in only the primary
plane, which I'll send as a separate series

Hamza's v1 of the 2024 patch that added this file had no flush [1], and
Mario found that the level only took effect on the next modeset [2].
That patch's v2 changelog says "force an atomic commit" [3], but what
was merged, commit 63d0b87213a0 ("drm/amd/display: add
panel_power_savings sysfs entry to eDP connectors"), sends a hotplug
event instead

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

Tested on my laptop (ASUS ROG Flow X13 GV301QH, DCN 2.1) with v3 on
7.3.4, under Hyprland with no modeset during the run:

  - 25 writes cycling levels 0 to 4 all succeeded and read back, with
    nothing in the kernel log. A write sends no uevent
  - I wrote 4, 0, 4, 0, 2 and 0 six seconds apart and read
    amdgpu_current_backlight_pwm and amdgpu_target_backlight_pwm every
    half second. After each 0, the backlight was back at full PWM by the
    next sample. After each 4 or 2, the target dropped, to 25% of full at
    4 and 52% at 2, and the backlight ramped down to it
  - This series on top of "drm/amd/display: Leave self-refresh before an
    ABM level update", with the panel in self-refresh before each write:
    all five writes that changed the level took the panel out of
    self-refresh for the update
  - Writes of the current level return without a commit, so they leave
    the panel in self-refresh

On a text console, igt amd_abm passed all five subtests. I also ran an
IGT test that puts an overlay plane over the primary plane and turns VRR
on, so the CRTC idles at the panel's 40 Hz minimum. On v2, a write took
the overlay off the screen until the next flip. With v3, the overlay
stayed. With VRR off, it stayed on both

[1] https://lore.kernel.org/amd-gfx/20240126222300.119292-1-hamza.mahfooz@amd.com/
[2] https://lore.kernel.org/amd-gfx/1162e59e-3f53-4c84-b186-bb2f4642216b@amd.com/
[3] https://lore.kernel.org/amd-gfx/20240202152837.7388-1-hamza.mahfooz@amd.com/
[4] https://lore.kernel.org/amd-gfx/b117ccc0-6569-4753-9cb9-c304f9e50d30@amd.com/

Changes in v3:
- New patch 2: add the CRTC's planes to a commit that changes the
  level. Without the modeset, such a commit with VRR active carried only
  the primary plane, and DC dropped an active overlay until the next
  flip. Sashiko's finding, reproduced on v2
- Patch 3: credit David Weber, who sent the same condition change in
  August (Chenyu)
- Patch 5: say that a compositor commit waits for the write instead of
  failing with -EBUSY, in the kernel-doc and below the cut (Chenyu)
- Link to v2: https://lore.kernel.org/r/20261113-abm-sysfs-commit-v2-0-5808d17a7e89@hsal.es

Changes in v2:
- Patch 3 (v2's 2): name commit b05e2c5e81f9 ("drm/amd/display: Update
  ABM crtc state on non-modeset") as the one that lets the non-modeset
  path carry the level, say the KMS property loses its modeset too, and
  say "drm/amd/display: Leave self-refresh before an ABM level update"
  has to go first
- Patch 4 (v2's 3): set level 2 before the test that writes 0, so the
  write changes the level
- Patch 5 (v2's 4): return without a commit when the level doesn't
  change (Harry). A write that changes nothing, or that the DRM master
  forbids, no longer wakes the GPU. A write that a signal interrupts
  restarts instead of failing with -EINTR
- Patch 6 (v2's 5): test a write of the current level, check that it and
  a forbidden write leave a runtime-suspended GPU suspended, and fold
  the CRTC on and off cases into one parameterised test
- Link to v1: https://lore.kernel.org/r/20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es

---
Hugo Sales (6):
      drm/amd/display: Render the panel power savings kernel-doc
      drm/amd/display: Add the CRTC's planes when the ABM level changes
      drm/amd/display: Don't force a modeset when the ABM level changes
      drm/amd/display: Give the panel_power_savings store tests a full pipe
      drm/amd/display: Commit panel_power_savings writes from the kernel
      drm/amd/display: Test panel_power_savings commits

 .../gpu/amdgpu/display/display-manager.rst         |   3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 118 ++++++++-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 271 ++++++++++++++++++++-
 4 files changed, 390 insertions(+), 19 deletions(-)
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


