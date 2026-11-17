Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED8606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=MydHyvuh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7614E10E548;
	Tue, 17 Nov 2026 10:39:26 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F5710F5B4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=Qo35RJ+A8ZynuqWisvvTeCAm7YKJTjbGS6eS2yH/Ln4=; t=1794911960; x=2110271960; 
 b=MydHyvuhMvg6+UDkUkYn4r1rLrbtUo7CtqvN0kN4tYz8glCJDoVAt3HhahClueAvwmyPkPN+B6Q
 s6iml/kNDB3cS6WTJXIHWvJEBRT4rJG0QwefWWyhZxWzhYvaU6DkMLVl+qramGHO2BbgQtC+yxnny
 mVOqMSuF/AU06Ma4vBvkXWMRlO8Cst3VxCZ35MiCFAwhIqVwMUD6IURnuu3Nq5TdkU5SMryDccPhY
 KgPV1qjJlnGby9pzSnj8hZwGvZxUXxdSdO9KbB2MqlE43rnSnc3r6gfuLPngzDe0zvRyn8hmQkDd8
 wyFnsNNU391TD/W/BX1UsCAFzxiJLAALoFtA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xTGas-00000000XyG-116d; Tue, 17 Nov 2026 11:39:18 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 0/3] drm/syncobj: Allocation avoiding fast path
Date: Tue, 17 Nov 2026 10:39:13 +0000
Message-ID: <20261117103916.9101-1-tvrtko.ursulin@igalia.com>
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

In practice there are multiple DRM syncobj operations (and/or ioctls) per
rendered frame, and vast majority of them operates on a just a couple of
handles, or timeline points.

This series adds a fast path to avoid the temporary allocations for those cases.

Cc: Maíra Canal <mcanal@igalia.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Christian König <christian.koenig@amd.com>

Tvrtko Ursulin (3):
  drm/syncobj: Use vmemdup_array_user in drm_syncobj_array_find
  drm/syncobj: Add a fast path to drm_syncobj_array_wait_timeout
  drm/syncobj: Add a fast path to drm_syncobj_array_find

 drivers/gpu/drm/drm_syncobj.c | 134 +++++++++++++++++++++++++---------
 1 file changed, 99 insertions(+), 35 deletions(-)

-- 
2.56.0

