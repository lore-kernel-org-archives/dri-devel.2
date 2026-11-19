Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8388460A2609
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iYrxmap9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC8D10E8A9;
	Thu, 19 Nov 2026 13:19:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328D310E8A9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 13:19:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D909B40570;
 Thu, 19 Nov 2026 13:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195CB1F000C5;
 Thu, 19 Nov 2026 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795094378;
 bh=gK1ForMjyEmgPmikJ+yHxqKUGm6sEgHvzRHvKpK3TlY=;
 h=From:To:Cc:Subject:Date;
 b=iYrxmap9F95zC7zevzlIkNvm2EvW0xFeZEV4uDvbltwjqYDMQDZgoctTK79JgpP6v
 I33+MyJSK1AWI6xpnh/bQL3XsfaZZloLDwjcq6M4OhHbjxka2rqWS/9C7k6QjiQKpV
 lo9owqejGMK+pEir1kr72Cu8/95kEj1SBJdg2h30swHFWBbRjuuNVzjPRpqxwoL+eP
 JDSvzEUSbDMIK3mvtQTtE9JZ1/HfPvaNx7LxdLihSiTz0hvgD8IYiimYGBgxw7degI
 5NitSr8PHy4otVpN269UpDlnCkWhacVOysN65dLm6121gLeZ0CWiNJqtj03mZ6OGen
 CyOlsrJR23T0w==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Yunxiang Li <Yunxiang.Li@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dma-fence: Fix timestamp memory ordering
Date: Thu, 19 Nov 2026 14:18:28 +0100
Message-ID: <20261119131830.2535266-2-phasta@kernel.org>
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

Based on misc-fixes

The memory ordering for obtaining a fences timestamp seems to be broken.
Moreover, there is no canonical way for users to obtain the timestamp,
as proven by the broken ordering in drm_sched.

See also my patch for the signaled flag [1].

@Tvrtko, would you mind basing your patch [2] on this series? That way
we'd solve both bugs.


[1] https://lore.kernel.org/dri-devel/20261119104030.2381685-3-phasta@kernel.org/
[2] https://lore.kernel.org/dri-devel/20261117094324.8256-1-tvrtko.ursulin@igalia.com/

Philipp Stanner (3):
  dma-buf/dma-fence: Ensure correct ordering in dma_fence_timestamp()
  dma-buf: dma-fence: Add dma_fence_overwrite_timestamp()
  drm/sched: Fix memory ordering with dma_fence_overwrite_timestamp()

 drivers/dma-buf/dma-fence.c            | 28 ++++++++++++++++++++++++++
 drivers/gpu/drm/scheduler/sched_main.c | 28 +++++++++++++++++++++-----
 include/linux/dma-fence.h              | 15 +++++++++-----
 3 files changed, 61 insertions(+), 10 deletions(-)


base-commit: 7488ee210542b918b9c5749a29fd1502c49a0665
-- 
2.56.0

