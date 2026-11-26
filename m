Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D30606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=FOsxRjwd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37D810E97C;
	Thu, 26 Nov 2026 11:11:36 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EAF10E97C
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=/Rx41dVsqwYN5JnwZZJigGwj/E5yq5fqStcWRNyWDEU=; t=1795691491; x=2111051491; 
 b=FOsxRjwdeRTvgk7m7GqTBfwpodf7Y2siJU7+s6sTEFue+VdTX28yqvP8aj89GHTXyHcq7dLU3e2
 2xGa+wFj3L1zNI8i9ZgRuVMBpQwzrNkhgPlPGpHtBvbqmpxpOZ+usyQmo2SjybapSBi5nZ3sVG68U
 5nlYotAQw3VuoRzulBziNjGroldBRbDJTS0GDhGBVIBT6vfDLBVPp0DPOsb4xUxMa1voILC8xC0Xa
 Ttx5NwSnZkqe79cwShKf/WQSUfnGgEt7m86eL4YVYPTw5UPCanxsepJoTfS7lB1iI84EQeop2stFx
 ii4QbTeIEsV7HhxrNe+owTLLiDyvCcaDzsJg==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xWXNx-00000004MPj-1GgD; Thu, 26 Nov 2026 12:11:29 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Fei Yu <fei.yu@intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/7] DRM syncobj scoped cleanup and fast path
Date: Thu, 26 Nov 2026 11:11:10 +0000
Message-ID: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
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

A different flavour of:
https://lore.kernel.org/dri-devel/20261117103916.9101-1-tvrtko.ursulin@igalia.com/

Where Christian suggested to try with scope based cleanup macros. This is that
attempt.

We start with converting all the functions which use temporary arrays to scoped
cleanup and then in the last patch fast path is added via two handy macros.

Syncobj IGT pass, light gaming and light desktop as well, and there are no
kmemleak reports. Nevertheless this version is a bit more invasive so if the
approach is looking good a careful review will be required.

Cc: Christian König <christian.koenig@amd.com>
Cc: Fei Yu <fei.yu@intel.com>
Cc: Maíra Canal <mcanal@igalia.com>

Tvrtko Ursulin (7):
  drm/syncobj: Use vmemdup_array_user in drm_syncobj_array_find
  drm/syncobj: Use scoped cleanup for drm_syncobj_array_wait_timeout
    points
  drm/syncobj: Use scoped cleanup for drm_syncobj_array_wait_timeout
    syncobjs
  drm/syncobj: Use scoped cleanup for drm_syncobj_timeline_signal_ioctl
    points
  drm/syncobj: Use scoped cleanup for drm_syncobj_timeline_signal_ioctl
    chains
  drm/syncobj: Use scoped cleanup in drm_syncobj_array_find and callers
  drm/syncobj: Add temporary array allocation fast paths

 drivers/gpu/drm/drm_syncobj.c | 384 ++++++++++++++++++++--------------
 1 file changed, 224 insertions(+), 160 deletions(-)

-- 
2.56.0

