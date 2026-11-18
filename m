Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C1E606A335
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbdQkCjQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31BA910FBA1;
	Wed, 18 Nov 2026 12:11:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E219F10FBA1;
 Wed, 18 Nov 2026 12:10:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6C1341397;
 Wed, 18 Nov 2026 12:10:54 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795003854;
 b=PZ37KmkNuyKUWTnYl+OQzWc/c450XDK2/AdLIhJXAFHwONi4W+as8wkq55nlfPU85VfY
 JnK9sdQuqxuZtCV8EQ+frxpn/5nD6OP3ogeunA1R2Bh30aDtir9RSQEd18RCkrBa8Tx2A
 5w76SETEpS3/qCPEPyjt6bQIb45eB2sWAVmioh2yN+BAp82cocIQk7YXealj6/u88WQv2
 DzOZa+E1UPo+O/3/7X6VoYe06iyZrEMHzrVVrXwIspPOAbOPqznJpoNBt/WGCez54TXNB
 cgN5xmLKdG6Rc0ReNepyq49ogZ0VXZsA277nOWTZH88FKxda5bsYYs8a7EYfF6t6DVg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795003854;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=QKf013hDq3C3wopUeXomw6MyGTl/FJoQzeumjJ07VZg=;
 b=l2h+LFM1/SEXSnCv6xgyM+5lMeGnPFsAdK9BVdC8VhzvSER771PumqUSdGJYOvBjma2d
 MAUjqXiF87RlAmLxRQeiQOLs+uYtVKX7asvr/ahh7HdbkSXQaoChERqgdc4fCqDe6SJBd
 oLyFBnwmiabYRuB9BSubcgaD934/n5+puSKB+ykF39bBkA68Xsv8xszqkN8K8Aox+yA3+
 N7PIxE/GGvYnWAwM4lOu08UjQw708HfrkZ3SKP6LBG/AzeN7W72dpRJWfKHANzIJ8EJKf
 I4EG2DEGTVP9hBrAR7kYxLwqfYrHIF0HmeWP8nLDt2BbFefdLK82OoIDk4agWHFe9Qg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 141411F000C7;
 Wed, 18 Nov 2026 12:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795003854;
 bh=QKf013hDq3C3wopUeXomw6MyGTl/FJoQzeumjJ07VZg=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=QbdQkCjQjWOO8OBUuChroBEdCCxTCJ8u2pnw3vz9JoECNkd+x2lrm8gA9bOGA9ROG
 XtbBMRrj9KE6LLjECZwzWm29lVeiKJXz1E2ii11c0YtR/IeKIu8AhlwCkj/MYQ5cn2
 +xaiA/nXcbhZuq7OWd3l2vsr0TO9Bknj8DBIwIHhfL35svv+btbQvtl4OOPzxhjNvW
 ac+3MvZDuMrZkM1nD/YF2xJ4EyHnoqI0pEMwquDKEvYB0kf7f7TkyNyl3D9Rq22057
 sQ/Si4+OY3xpGlngbP0zS3qstDokEhhYtssTtDEV09Bh/fZQg4GwTt75xeFR5NekAX
 6m3y7i7heWdQQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 9CBF04AD5B;
 Wed, 18 Nov 2026 12:10:53 +0000 (UTC)
From: =?utf-8?q?Eren_=C3=96zen_via_B4_Relay?=
 <devnull+erenozen.protonmail.com@kernel.org>
Subject: [PATCH v2 0/3] drm/amd/display: Fix FRL status polling work lifetime
Date: Wed, 18 Nov 2026 15:10:51 +0300
Message-Id: <20261118-frl-polling-wq-teardown-v2-0-957e61c0b698@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/4XNTQqDMBBA4auEWTslPyitq96juNA40YGYaCLaI
 t691At0+xbfOyBTYspQiwMSbZw5BqiFLgTYsQ0DIfdQC9BSV0opiS55nKP3HAbcF1ypTX3cA+r
 OGFNZSw+qoBAwJ3L8vuRXUwgYOa8xfa7Rpn71v7kplCidk/rel9aU3XNOcY1hatnfbJygOc/zC
 5kZYLrDAAAA
X-Change-ID: 20261110-frl-polling-wq-teardown-2b3336cce9e6
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>, 
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, 
 Alex Hung <alex.hung@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795003852; l=4876;
 i=erenozen@protonmail.com; s=20261110; h=from:subject:message-id;
 bh=o4xp1XWRc/cv7WWAhJEyxTWE3Q7ktwDyLfzkelJnCZc=;
 b=AgfFfB9uvzQRRPn5Cpfcvxl2Ctp2Doit/H49xJSknhBcNbfN2Sd3Kgdb0xcebzwQHvUuKZ5C9
 uUnV/OtTe8uBjdvR4JQBLMYz3OE0CYYjJ089JVHXCxfswPtY1fd9QRL
X-Developer-Key: i=erenozen@protonmail.com; a=ed25519;
 pk=tPAwfVmIbYF3QziJ3LcoTIZDU12BsjVK+EkAB9nN1gA=
X-Endpoint-Received: by B4 Relay for erenozen@protonmail.com/20261110 with
 auth_id=1479
X-Original-From: =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>
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
Reply-To: erenozen@protonmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HDMI FRL status polling work and its workqueue, added in commit
5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm"), have
two remaining lifetime problems:

1. Since commit 0e967e086e75 ("drm/amd/display: Extract connector and
   encoder code to amdgpu_dm_connector"), the delayed work is
   initialized in amdgpu_dm_connector_init_helper(), which also runs
   at runtime for every new MST connector. An MST hotplug while FRL
   polling is armed re-initializes a pending delayed work. Because the
   work is only initialized once connectors exist, the cancel that
   commit 8bcad6d7acbb ("drm/amd/display: Stop HDMI FRL status polling
   on fini") added to amdgpu_dm_fini() can also run on a work item
   that was never initialized, if amdgpu_dm_init() fails after the
   workqueue is created but before the first connector is set up.

2. If the workqueue allocation fails, amdgpu_dm_commit_streams() still
   passes the NULL workqueue to queue_delayed_work().

Patch 1 moves the initialization to amdgpu_dm_init(), before the
workqueue is created. Patch 2 skips queueing when the workqueue does
not exist. Patch 3 adds a KUnit test for the MST case of patch 1.

These issues were pointed out by an automated review of the workqueue
rename patch earlier this year.

This series should still combine cleanly with Timur's "Check HDMI FRL
support before creating polling workqueue", which is not in
amd-staging-drm-next yet. With that patch, the workqueue is NULL on
hardware without FRL, and the NULL checks in amdgpu_dm_fini() and in
patch 2 handle that case. If his patch lands first, patch 1 needs a
trivial rebase because both touch the same context.

Testing:
- Built on amd-staging-drm-next 8dd68a79583a with GCC 16. W=1 build
  of amdgpu_dm.o and amdgpu_dm_connector.o: no warnings.
- Booted on a Cezanne laptop with CONFIG_DEBUG_OBJECTS_WORK and
  CONFIG_DEBUG_OBJECTS_TIMERS: one hdmi_frl_status_polling_wq thread,
  no ODEBUG or workqueue warnings, s2idle suspend/resume works. Sysfs
  unbind of amdgpu: the FRL thread count goes from 1 to 0, with no
  warnings.
- amdgpu_dm KUnit suite (UML), with CONFIG_DEBUG_OBJECTS_WORK and
  CONFIG_DEBUG_OBJECTS_TIMERS: all FRL polling and connector init
  tests pass, including the new one from patch 3. Without patch 1,
  the new test fails and ODEBUG reports "init active" on the polling
  work's timer. On this tree the suite needs a local workaround first:
  since commit 48b8c06b05ad ("drm/amd/display: Route connector DDC
  over AUX for native DP sinks"), dm_test_i2c_xfer_no_ddc_pin
  dereferences a NULL ddc->link and crashes the UML kernel. With the
  test given a zeroed dc_link, 1931 of 1932 tests pass. The remaining
  failure, dm_test_fs_caps_dp_vsdb_version, also fails without this
  series.
- v1 testing with a debug-only change that forces the polling work to
  run (lockdep, ODEBUG, about 1200 runs, s2idle, unbind) still applies
  to patch 1.
- Not tested: MST hotplug with an active HDMI FRL stream and real FRL
  link training, since I have no FRL sink or MST hub.

Signed-off-by: Eren Özen <erenozen@protonmail.com>
---
Changes in v2:
- Rebased onto amd-staging-drm-next with the "DC Patches November 16,
  2026" batch.
- Dropped v1 patch 2/3 ("Destroy FRL status polling workqueue in
  amdgpu_dm_fini()"). The same change went in from the DC batch as
  commit 8bcad6d7acbb, as agreed with Wayne Lin:
  https://lore.kernel.org/all/20261113031935.53510-1-Wayne.Lin@amd.com/
- Patch 1: the commit message now also explains the init error path
  in amdgpu_dm_fini().
- Patch 1: Fixes tag corrected to 0e967e086e75, which moved the
  initialization into amdgpu_dm_connector_init_helper() (pointed out
  by sashiko-bot).
- Patch 2 (v1 3/3): trivial rebase over "Move HDMI FRL Polling Outside
  dc_lock". The code change is unchanged. The commit message now
  compares with amdgpu_dm_crtc_set_vblank(); v1 wrongly said
  amdgpu_dm_atomic_commit_tail() checks vblank_control_workqueue.
- New patch 3: KUnit test for patch 1.
- Link to v1: https://lore.kernel.org/r/20261110-frl-polling-wq-teardown-v1-0-0ff028d5c35b@protonmail.com

---
Eren Özen (3):
      drm/amd/display: Initialize FRL status polling work once at DM init
      drm/amd/display: Don't queue FRL status polling on a NULL workqueue
      drm/amd/display: Test connector init with FRL status polling pending

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  6 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  2 --
 .../amdgpu_dm/tests/amdgpu_dm_connector_test.c     | 34 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 3 deletions(-)
---
base-commit: 8dd68a79583aaf6df6fe4feea3ee9e9f26b02993
change-id: 20261110-frl-polling-wq-teardown-2b3336cce9e6

Best regards,
-- 
Eren Özen <erenozen@protonmail.com>


