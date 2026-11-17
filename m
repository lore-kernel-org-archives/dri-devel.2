Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8CD606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=CksRXY9/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3508A10F5D1;
	Tue, 17 Nov 2026 10:07:10 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC44C10F606;
 Tue, 17 Nov 2026 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=WXoKrWFHi+HfYpxAVk/CJwyKJM2E/SAM8C5ioGRTrdI=; t=1794910023; x=2110270023; 
 b=CksRXY9/doQhwdFQUU+sZBqIEU+CmXiz1H3cctfPwxD8zlU6WpVK7eo80H5Vu+fBiT9Q/3WS3BY
 hyl/e0VwhuJOP8Bv+R8hhsbhWwRJlJmdl598ay1jcYnAVFQZKm6g7o4VPJ8LZAtHJPbF+iRogPjad
 C+HtrT0ZAM3dNrxtLzeIfAkdzOe+GG6Uw7JEKlg4Z41M3LkXVvWZctC9/kipfiagqDy8ShMBE1JwU
 q2edc6jvbeMec6fDG1OSP+VxUZ+4aOiP1ZvQmbiVuIU29SAUjpXiip99lA0CZwDlxRThVYOD4uE3L
 nx25jFyR1IyrBmnkEv9+6q4XM2TaOPXBiV1Q==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTG5e-00000000XMc-06di; Tue, 17 Nov 2026 11:07:02 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/4] drm/sched: Entity handling cleanups
Date: Tue, 17 Nov 2026 10:06:50 +0000
Message-ID: <20261117100654.8593-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stricter rules around entity initialization, removing the single scheduler
special case which fixes the priority override for amdgpu single IP instance
entities and addressing of fence_seq FIXME by pulling the entity->lock up from
drm_sched_entity_select_rq().

In the last round sashiko complained about the first patch breaking legacy v3d
but Maíra has confirmed that is an unused path so no problem to make it
stricter. Lets see what sashiko finds in this round.

Cc: Christian König <christian.koenig@amd.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Philipp Stanner <phasta@kernel.org>
Cc: Maíra Canal <mcanal@igalia.com>

Tvrtko Ursulin (4):
  drm/sched: Disallow initializing entities with un-initialized
    schedulers
  drm/sched: Ignore stopped entity attempt to change its run-queue
  drm/sched: Remove the single scheduler special case
  drm/sched: Address the fence_seq fixme

 drivers/gpu/drm/scheduler/sched_entity.c | 72 +++++++++++++++---------
 drivers/gpu/drm/scheduler/sched_fence.c  |  6 +-
 drivers/gpu/drm/scheduler/sched_main.c   |  7 ++-
 include/drm/gpu_scheduler.h              | 49 ++++++++--------
 4 files changed, 81 insertions(+), 53 deletions(-)

-- 
2.56.0

