Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8C606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 09:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=O+hub82O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C625410FA38;
	Wed, 25 Nov 2026 09:10:06 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5F6F10FA2D;
 Wed, 25 Nov 2026 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=M3vtZofjTmsp23qgQTvjgjIReu0eeNCUnUrku5J1vkE=; t=1795597800; 
 x=2110957800; b=O+hub82OSWJwJ8wFt80nDqxklCtVTD6ZFwYuRoXAQCwakTBB4HNmEaG42FYvi
 +HMsrN4PzIL+DE9aRHrwxFZtjxK+vGCOEq5VcE3OfXkIZ4lrsrGblUX7g+sSP2P7vFjxJBrv4FSFx
 7o2Ht8T3xHeVhEVpNywS/A6/+Tu4DKTQgHYTROnKqixfPbtD65yE2Nuein5H81KprrphrKMjAUcJ5
 8kk5obfTINGbvqSvYl3A04c8qWo1Zh5DR1CV6JFSSSDUCuXHLv0QngwZaCP1Ag5dzUmUJkae0WUo7
 S3uytnmAC5sm5W9qDUalOthLaSTTWpWnRPhVCaolEOX0345VVA==;
Received: from [81.79.79.1] (helo=localhost)
 by fanzine2.igalia.com with utf8esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xW90i-00000003q2R-3mNX; Wed, 25 Nov 2026 10:09:53 +0100
Date: Wed, 25 Nov 2026 09:09:47 +0000
From: Tvrtko Ursulin <tursulin@igalia.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-intel-gt-next
Message-ID: <awal23LmCd1nyXF5@localhost.localdomain>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Dave, Sima,

A rather small drm-intel-gt-next pull request for 7.5. Not sure yet if I
will do another one nearer to the cut-off, we will see.

Anyway, this one only contains one selftest fix and a fix for syncobj
timeline error handling, where the latter is probably already upstream
via the fixes flow.

Tvrtko

drm-intel-gt-next-2026-11-25:
Driver Changes:

Fixes/improvements/new stuff:

- Reset err for each fence entry [gem] (Lu Yao)

Miscellaneous:

- Do not destroy uninitialized timer [selftests] (Krzysztof Karas)
The following changes since commit ca4a6deadad15b91ee083afe445fa6bdbfb68206:

  drm/i915/gt: Unmask interrupts only when ACTIVE is true (2026-09-30 11:58:59 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-gt-next-2026-11-25

for you to fetch changes up to 4e9db08db75f55c920986ac929cfd82a4ee99f41:

  drm/i915/gem: Reset err for each fence entry (2026-10-29 09:40:26 +0100)

----------------------------------------------------------------
Driver Changes:

Fixes/improvements/new stuff:

- Reset err for each fence entry [gem] (Lu Yao)

Miscellaneous:

- Do not destroy uninitialized timer [selftests] (Krzysztof Karas)

----------------------------------------------------------------
Krzysztof Karas (1):
      drm/i915/gt: Do not destroy uninitialized timer

Lu Yao (1):
      drm/i915/gem: Reset err for each fence entry

 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c     | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)
