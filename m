Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91509606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mTJwNm4m
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA0DE10E8A2;
	Thu, 26 Nov 2026 17:21:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5A5F10E1A0;
 Thu, 26 Nov 2026 17:21:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1FD260CDA;
 Thu, 26 Nov 2026 17:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9239D1F000C4;
 Thu, 26 Nov 2026 17:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795713668;
 bh=3U4ZmO6S4QfEt/0nkql9n+zraERnhGp5O1oAWKI8DhM=;
 h=From:To:Cc:Subject:Date;
 b=mTJwNm4muBgPSCGc64/Nxa/Yqq8VD8DExUAgAmSaFUqoqQogRhM3TaRi+/0fHv+UF
 gIOnIcyf5/tLdiZordWsLWTYWAv+kF5m4ISeXMXSwEf4Ld18dsbc/ywSTp3fgQySwg
 j1YKVGEcc5kZ03yxNqXZGri3/e1VY4l7me75qvhHXTf2FJfM37MknEiCvknRFxOYiQ
 0gLyX/te8A0rpHwrwQJviE7u3wbUVJ+0kNL/PaeH9SO1N+p+8odmzCGDLTPK2h+zy3
 QXifcEdJn0akMa1x/s1fBLQDCrfntJ0RY22qQ6kpXkO/d1eaCYB8S2x29GALOw19sf
 J+xCbh2ySobTA==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/3] dma-fence: Properly order timestamps
Date: Thu, 26 Nov 2026 18:20:44 +0100
Message-ID: <20261126172046.2473303-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

I propose stuffing these hotfixes into the stable kernel / misc-fixes
while we move on on misc-next with a more proper solution. I'll post a
series for that soonish, too.

P.

Philipp Stanner (3):
  dma-buf: dma-fence: Hot-fix timestamp misordering
  drm/sched: Hot-fix timestamp misordering
  drm/amdgpu: Hot-fix timestamp misordering

 drivers/dma-buf/dma-fence.c             |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c |  4 ++--
 drivers/gpu/drm/scheduler/sched_main.c  | 12 ++++++++++--
 include/linux/dma-fence.h               |  8 ++++++--
 4 files changed, 27 insertions(+), 6 deletions(-)


base-commit: bf57105b00e32d37b666c029c8c6b8708391da20
-- 
2.56.0

