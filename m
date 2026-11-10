Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346D5606A9D0
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1k8oz7I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59A410E45A;
	Tue, 10 Nov 2026 04:22:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CD410E08E;
 Tue, 10 Nov 2026 04:22:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 46537457F7;
 Tue, 10 Nov 2026 04:22:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794284545;
 b=dQKXeoCb9lxBwqL6bFK5fNDxEhGjf1Pp3tEZC69ypJ6sZ4COhR8KP6Xc6zgKrYeZrk2M
 wnn+Id5eMw+gB4hP/8zxSyZyAErl1xcPhVKB+0gVCSHi5R8SP7sqzLG7rMRYLGuGxw1Gj
 foQTgLWaUh+W0ECtFTb65vJbwlXy4GfDRiajI/OUhQs/++52chglDTwYPephxbpmRGl8d
 loWnaogeXpsFQ85/IsvOI+KV9TL5rMLNi11+8NUFwLXWWtgzlb+S8oor6Wl1COTcw0+mz
 9zong+h8addCDWZTzhh1k7Bze36dDYC5mx5POJxqhTUmLaF5ko1wW15FfZVMozIHdOQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794284545;
 h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=96pDvBb477paBTxH+4CZ9TVlcrjUv5JHm3wNPt3bOoM=;
 b=EOsAR88g9LlmOgTOXCPjwO/ce03BGkSY2NIzae5qQBBp+Fvu9jfAvW3HLgfwMxOer+H1
 8dQEfDAyrfKRS3Q9ou9OnnuliTZAX5PF11s6dhX/9RBFKVWqI597BYxk2m6SDxjfOTgRR
 ttRHDGC7BJAZ1eZ60Oc0LWzPjbdQ87uR+KZZbZNkcLfD/1aOg70Q0lQEOkC1AQNWt+dxq
 O4TlGGOjlz1rfpIrt5/spGW2gk3mQJOcUi4kM2vHAEUkn9lYALIoixgdcYX9spQr6JdZ2
 XQTZor/YR6IpESutr+Jf6T5Dpa48IDMnALsI58WFNI5YJ8iNuMikt2HYD8C4RgFalzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 0A6171F0089F;
 Tue, 10 Nov 2026 04:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794284545;
 bh=96pDvBb477paBTxH+4CZ9TVlcrjUv5JHm3wNPt3bOoM=;
 h=From:Subject:Date:To:Cc:Reply-To;
 b=m1k8oz7IUuTqFeLtMBYMSdh11EWgVkYe07bkknASaoeZsp1O/l2cz5Gd/H7WfpD3z
 o498nJEopU76eWVDuX/1n6tfthfLUxVubjbP07tJG9GZjr7qsD6M0RjRz2Eqtnx89h
 rOzoXVXKBJq78rb9H+IVS0ZOvQjvPa73jVLU/magXx26gWyDtqy9NxNM44hKQznXBR
 n5T25Z3/2l8cPUnQ7Rpk+8UHOqCPSkEuNluhBvkDxGfCJQPyWMqNKi4avq/jMtGM5B
 C6c3mzhMcVs5YsDqIKP6Zns7E5l8MHkh6M+OH4CGtG/BtZi+l6Q6T8Y6QEd9tglVwf
 7jiGoZxfSfAUQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 5733E4883F;
 Tue, 10 Nov 2026 04:22:23 +0000 (UTC)
From: =?utf-8?q?Eren_=C3=96zen_via_B4_Relay?=
 <devnull+erenozen.protonmail.com@kernel.org>
Subject: [PATCH 0/3] drm/amd/display: Fix FRL status polling work lifetime
Date: Tue, 10 Nov 2026 07:21:55 +0300
Message-Id: <20261110-frl-polling-wq-teardown-v1-0-0ff028d5c35b@protonmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/x3MQQqDMBAF0KsMf+2ASSDQXKV0YeNoB0JiJ6UK4
 t0LfQd4J7qYSkeiEyZf7doqErmBkF9TXYV1RiL40Ufn3MiLFd5aKVpX3t/8kcnmtlf2zxBCzFl
 uEjEQNpNFj/98f1zXD1EbqQ1pAAAA
X-Change-ID: 20261110-frl-polling-wq-teardown-2b3336cce9e6
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Eren_=C3=96zen?= <erenozen@protonmail.com>, 
 timur.kristof@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794284542; l=3048;
 i=erenozen@protonmail.com; s=20261110; h=from:subject:message-id;
 bh=YcYq/sMmQ2Dt4zDzYoXhOXb5tw84PZDjWw85HQWmBF8=;
 b=JNJJ3FzZnLlnZp3PU0D/iAnSIMslTMd9PMPyeRy9A+SR5djYV2JIAwAC3CRzmsa3sFkVweZ7W
 qqlhjon2/GpBccJifSiYV6fU46ifzuTQ4U1eXb/BPm9fNF/tXHte9AE
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The HDMI FRL status polling work and its workqueue, added in commit
5c9b8b27a883 ("drm/amd/display: Tie FRL support into amdgpu_dm"), have
three lifetime problems:

1. The delayed work is initialized in amdgpu_dm_connector_init_helper(),
   which also runs at runtime for every new MST connector. A hotplug
   while FRL polling is armed re-initializes a pending delayed work.

2. amdgpu_dm_fini() never cancels the self-rearming work and never
   destroys the workqueue, so the workqueue and its rescuer thread
   leak on every unbind, and the work can run after dc_destroy().

3. If the workqueue allocation fails, amdgpu_dm_atomic_commit_tail()
   still passes the NULL workqueue to queue_delayed_work().

Patch 1 moves the initialization to amdgpu_dm_init(). Patch 2 tears
the work and workqueue down in amdgpu_dm_fini(), and depends on
patch 1. Patch 3 skips queueing when the workqueue does not exist.

These issues were pointed out by an automated review of the
workqueue rename patch earlier this year.

This series should combine cleanly with Timur's pending "Check HDMI
FRL support before creating polling workqueue". With that patch, the
workqueue is NULL on hardware without FRL, and the NULL checks in
patches 2 and 3 handle that case. If his patch lands first, patch 1
needs a trivial rebase because both touch the same context.

Testing:
- Built for x86_64 with GCC 16, no new warnings with W=1 on the
  changed files.
- amdgpu_dm KUnit suite (UML): 1910/1912 pass both with and without
  this series. The two failures are pre-existing
  (dm_test_detect_hides_secondary_tile and
  dm_test_dmub_sw_init_gtt_only_asic).
- Booted on a Cezanne (DCN 2.1) laptop with
  CONFIG_DEBUG_OBJECTS_WORK and CONFIG_DEBUG_OBJECTS_TIMERS: one
  polling workqueue thread, no ODEBUG warnings, and a clean s2idle
  suspend/resume.
- Unbinding amdgpu through sysfs on the same laptop, then counting the
  hdmi_frl_status_polling rescuer threads:
    without this series (Fedora 7.2.15): 1 before, 1 after (leaked)
    with this series:                    1 before, 0 after
  No ODEBUG warnings or splats during the unbind with this series.
- Not tested: MST hotplug with an active HDMI FRL stream, since I
  have no FRL sink or MST hub. Cezanne has no HDMI FRL, so the
  polling work itself never runs on my machine.

Signed-off-by: Eren Özen <erenozen@protonmail.com>
---
Eren Özen (3):
      drm/amd/display: Initialize FRL status polling work once at DM init
      drm/amd/display: Destroy FRL status polling workqueue in amdgpu_dm_fini()
      drm/amd/display: Don't queue FRL status polling on a NULL workqueue

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c           | 12 +++++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c |  2 --
 2 files changed, 11 insertions(+), 3 deletions(-)
---
base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
change-id: 20261110-frl-polling-wq-teardown-2b3336cce9e6

Best regards,
-- 
Eren Özen <erenozen@protonmail.com>


