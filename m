Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45733606D819
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 14:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hsal.es header.i=@hsal.es header.a=rsa-sha256 header.s=MBO0001 header.b=RQPfgPZA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B50610FC42;
	Wed,  4 Nov 2026 14:15:59 +0000 (UTC)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03E6B10FC3C
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 14:15:52 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jKSCW1KYwz8vj1;
 Wed, 04 Nov 2026 15:15:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hsal.es; s=MBO0001;
 t=1793801751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bEePHUew97NQlYUH7O9mv31KwF+DCf1uTt3wuwBLoXY=;
 b=RQPfgPZANXLw7obVU3MlpKmJ8C5/cbxclENEcdDdiLWqrgbjej24ED5CddIkW7qDkF8T6P
 fnC0j/c/DYxDdBulHh6rbPcRXKz4q6YvDpRqwt+PJJ6UMxpj9pyoEZY7jdcQvQiR9yX11s
 COUtUxXgQ6FPjdBLpgYn/PkKTg62sjF+4EUOjr4XIkR0DHvofLwwwCFDfjzyzEltcbBhUu
 3kjobiwvpf7Y973jm2NjcZ3rUHqxZcqLgyI+XbrUJhEF0TLtAkhvf0xc222t2GCbnMOQAY
 hMvI6tVwtkCsdaiD/hvnToDI0YEy3gOiuSZbsQ29FabbUeY6/g17ht2KYaaC6A==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of hugo@hsal.es designates
 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=hugo@hsal.es
From: Hugo Sales <hugo@hsal.es>
Subject: [PATCH 0/5] drm/amd/display: Commit panel_power_savings writes
 from the kernel
Date: Mon,  2 Nov 2026 10:17:53 +0000
Message-Id: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB3IKITaq5QuYpzUKURLRkUR7
 26qy7f4fwflJKzwLHZIvIjKOGRQWYDv3fBhlC4bKlNZIkPo2oi6aVD0Y4wyYWNd/eiYnLcWcvZ
 LHGS9lq/3bZ3bL/vp/4HjOAGfNJK2dAAAAA==
X-Change-ID: 20261101-abm-sysfs-commit-96a38de1ac66
To: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, harry.wentland@amd.com
Cc: Hugo Sales <hugo@hsal.es>, airlied@gmail.com, 
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
 christian.koenig@amd.com, simona@ffwll.ch, linux-doc@vger.kernel.org, 
 bhawanpreet.lakha@amd.com, ivan.lipski@amd.com, 
 dri-devel@lists.freedesktop.org, ray.wu@amd.com, alex.hung@amd.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4553; i=hugo@hsal.es;
 h=from:subject:message-id; bh=/VykqWpSa4U5OYmQVb++KOm7Ng9t9BysDsT7ZZMbyp8=;
 b=owJ4nJvAy8zAJVbLU7f+5A3TBYyn1ZIYsl4kh80qfzB9/Rat+IPvr50T9t34Q2cmY9mE9VPzQ
 l6qs/X4XDXrKGVhEONikBVTZNG94cnAMnHyzJyi50tg5rAygQxh4OIUgImo5jP8lVmdfyerxsac
 890D23ePm374L2rRcfjz5I+5c1qj68IZqxgZTjz+s+HZpU3WEodLlyR78j2zLouL/GRn905d519
 cS/JWRgBXb02o
X-Developer-Key: i=hugo@hsal.es; a=openpgp;
 fpr=193D095149CF7E8737B39064D912B0DB205A91C1
X-Rspamd-Queue-Id: 4jKSCW1KYwz8vj1
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_48_96,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
that the level only took effect on the next modeset [2]. v2's changelog
says "force an atomic commit" [3], but the merged code (63d0b87213a0)
sends a hotplug event instead. 8d20a066fa9b later applied the level
outside atomic and was reverted in 95aaa207e9ef because it broke igt
abm_gradual. The objections back then were to sysfs overriding the DRM
master at all [4], which the property above now covers. I didn't find
any discussion that rejects an internal atomic commit

A write now returns the commit's error instead of storing a level the
hardware may never get. power-profiles-daemon logs the error and tries
again on its next profile, AC or battery change. Nothing I found reads
the uevent for more than a cue to commit the connector, which the kernel
now does itself

The commit is blocking, so a write can hold the CRTC locks for up to a
frame while a compositor commit waits

Tested on my laptop (ASUS ROG Flow X13 GV301QH, DCN 2.1) with the series
on 7.3:

  - igt amd_abm passes all five subtests
  - Under Hyprland, with no modeset during the run, 25 writes cycling
    levels 0 to 4 all succeeded and read back, with no -EBUSY and nothing
    in the kernel log. A write sends no uevent
  - The backlight PWM follows each write. At level 4 the target PWM is
    43% of level 0 at the same brightness, and level 0 restores it

[1] https://lore.kernel.org/amd-gfx/20240126222300.119292-1-hamza.mahfooz@amd.com/
[2] https://lore.kernel.org/amd-gfx/1162e59e-3f53-4c84-b186-bb2f4642216b@amd.com/
[3] https://lore.kernel.org/amd-gfx/20240202152837.7388-1-hamza.mahfooz@amd.com/
[4] https://lore.kernel.org/amd-gfx/b117ccc0-6569-4753-9cb9-c304f9e50d30@amd.com/

Signed-off-by: Hugo Sales <hugo@hsal.es>
---
Hugo Sales (5):
      drm/amd/display: Render the panel power savings kernel-doc
      drm/amd/display: Don't force a modeset when the ABM level changes
      drm/amd/display: Give the panel_power_savings store tests a full pipe
      drm/amd/display: Commit panel_power_savings writes from the kernel
      drm/amd/display: Test panel_power_savings commits

 .../gpu/amdgpu/display/display-manager.rst         |   3 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  90 +++++++-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     | 231 ++++++++++++++++++++-
 4 files changed, 308 insertions(+), 19 deletions(-)
---
base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
change-id: 20261101-abm-sysfs-commit-96a38de1ac66

Best regards,
--  
Hugo Sales <hugo@hsal.es>

