Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0805B606A32C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZXBHMkV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDFE1129AF;
	Fri, 27 Nov 2026 10:20:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1E351129AC;
 Fri, 27 Nov 2026 10:20:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1303E6240F;
 Fri, 27 Nov 2026 10:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F42F1F008A0;
 Fri, 27 Nov 2026 10:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774800;
 bh=IcbJ3HwDV6eQS7j0xWG6IHOPX1VHnl4XhqZJPvk8Q3Q=;
 h=From:To:Cc:Subject:Date;
 b=cZXBHMkVZ6HrIDgRa8C+P6G4pE4Bo5cyu8C9nWRhpcvUkha9Ki0GOZX+gH/9yNA9p
 8qhX6wfy7u5xBVMYbYl0792G7y0kfIjb/gAiRzb5WLB8rA+zgrie1X/ptfh6ovm3dI
 Uy4VWqBaGYvLMt9grOZ5bY2l/IzE7q2HbfnyuPlEEstti9smmEMbK6jItfGDF25jDB
 2S9pKM+xv1cr+5BrTd/h1yp9yWLkQ8aJRX3EH/kgMqx1NQc27PhE72EIEf/Zp0YycZ
 w6EaSZirxdSwxDmKJP/sduX0o8s8UHhVcAAMM1ELNaxd9FJPlUxP2DcD1LO0z6kVb1
 n1RQbvJS8oqgg==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Ruslan Vagner <rusya92266@gmail.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Subject: [RFC PATCH 0/8] dma-fence: Remove TIMESTAMP bit
Date: Fri, 27 Nov 2026 11:18:05 +0100
Message-ID: <20261127101812.2706432-2-phasta@kernel.org>
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

The timestamp bit is annoying and dangerous because it makes memory
ordering difficult. It's only accessor function, dma_fence_timestamp(),
is unnecessarily complicated.

The current state is largely UB. Most notably, since there is no memory
ordering, people might accidentally read a list head for a timestamp,
generating total bogus output.

I have previously proposed backporting a hot fix for the ordering [1].
Tvrtko recently dived into fixing drm_sched [2].

My hope would be that the full drm_sched fix could be set on top of this
series.

The first two patches could be backported into misc-fixes, and the rest
enter into misc-next? I'm not entirely sure what the best strategy is.

Pls review,
P.

[1] https://lore.kernel.org/dri-devel/20261126172046.2473303-2-phasta@kernel.org/
[2] https://lore.kernel.org/dri-devel/20261126154200.71180-1-tvrtko.ursulin@igalia.com/

Philipp Stanner (8):
  dma-buf: dma-fence: Hot-fix timestamp misordering
  drm/sched: Hot-fix timestamp misordering
  dma-buf: dma-fence: Ensure ordering with locks for timestamps
  dma-buf: dma-fence: Improve dma_fence_timestamp()
  drm/amdgpu: Stop using dma_fence internals
  dma-buf: sync_debug: don't use TIMESTAMP bit
  drm/i915: Remove TIMESTAMP bit
  dma-buf: dma-fence: Remove TIMESTAMP bit

 drivers/dma-buf/dma-fence-unwrap.c          | 20 ++++++++++-----
 drivers/dma-buf/dma-fence.c                 |  2 --
 drivers/dma-buf/sync_debug.c                |  8 +++---
 drivers/dma-buf/sync_file.c                 |  8 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c     | 11 ++++----
 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c |  1 -
 drivers/gpu/drm/scheduler/sched_entity.c    |  4 +--
 drivers/gpu/drm/scheduler/sched_main.c      | 26 +++++++++++++++----
 include/linux/dma-fence.h                   | 28 +++++++++++++--------
 9 files changed, 68 insertions(+), 40 deletions(-)

-- 
2.56.0

