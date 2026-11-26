Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C587E606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=d0PanxCk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C849112814;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB2F10E145
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:24:14 +0000 (UTC)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 9B4D32032485;
 Thu, 26 Nov 2026 13:24:09 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id B69B22035D4B;
 Thu, 26 Nov 2026 13:16:12 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru B69B22035D4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1795680983; bh=eMdjIFXeUiWFK7ttfGJTTy2lE233TLypjz/ZlMAU4Jw=;
 h=From:To:Cc:Subject:Date;
 b=d0PanxCkmwPs26fLt3+AElLEVuwDTbKTzXjM4y+6T+wLV77y++AWAnu6+yF9UnBsP
 tXRrIozVJy0q3UTFmjuqqMyjwjSB7NYFkaKzrA87hA8H5Tuj2IjegHeRMKbOBBNj8M
 xpZq4hxgBKrkNy0F6W4trGOR3jGamrQpMBa6wnXtSMQzFm8ELqUyJ1c4jZnSHuOxbX
 oVHImU6qydB5FKbEf1LsUELeEnDcXHbGclM6UFAFIX1arKwwAKl5DLFqrJkRbtqe0T
 m+eKDHIJYhQHNAqEFRMeOqKgR5WyA1PBGB8r5/4qVMMrd67MBl9JQYCZ+PFO/8APjz
 wgueYD5VHMPeg==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Emil Velikov <emil.velikov@collabora.com>,
 Oleg Vasilev <oleg.vasilev@intel.com>, Jeevan B <jeevan.b@intel.com>,
 dri-devel@lists.freedesktop.org, lvc-project@linuxtesting.org,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 Eric Anholt <eric@anholt.net>, Jesse Barnes <jbarnes@virtuousgeek.org>,
 Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Alex Hung <alex.hung@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, George Zhang <george.zhang@amd.com>,
 Adrian Betschart <adrian.betschart@cinemaone.ch>,
 Alex Huang <Alex.Huang2@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Albert Esteve <aesteve@redhat.com>,
 =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
 Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
 Hans Verkuil <hverkuil@kernel.org>, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Lu Yao <yaolu@kylinos.cn>,
 Jani Nikula <jani.nikula@intel.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rajat Jain <rajatja@google.com>, Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <Mario.limonciello@dell.com>,
 Emil Velikov <emil.l.velikov@gmail.com>
Subject: [PATCH 0/5] drm/connector: Handle connector property allocation
 failures
Date: Thu, 26 Nov 2026 12:15:55 +0400
Message-ID: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series improves allocation failure handling in DRM connector property
helpers and their callers.

Patches 1, 2, 4 and 5 prevent NULL properties from reaching property attach
or update paths. Patch 3 propagates content type property creation errors
and reports failures in the Intel and AMDGPU callers while preserving
initialization without this optional property.

Patch 4 reuses the Nouveau cleanup added by patch 2. Please apply the
series in order.

Validation performed during development on the previous base:
- Compiled the affected DRM core and driver translation units using the
  existing x86 kernel configuration, including Nouveau, Intel display,
  AMDGPU, Radeon and GMA500 paths.
- Checked the diffs with git diff --check and scripts/checkpatch.pl.
- Exercised the extracted privacy-screen creation and provider functions
  with userspace stubs for allocation failures, rollback, retry,
  idempotence and provider reference ownership.

No full kernel link, hardware testing or in-kernel allocation fault
injection was performed.

Alex Kazinsky (5):
  drm/connector: Check DP subconnector property before attaching it
  drm/connector: Handle DVI-I property allocation failures
  drm/connector: Propagate content type property creation errors
  drm/connector: Handle scaling mode property allocation failures
  drm/connector: Handle privacy-screen property allocation failures

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  3 +-
 drivers/gpu/drm/drm_connector.c               | 94 ++++++++++++++-----
 drivers/gpu/drm/gma500/cdv_device.c           |  2 -
 drivers/gpu/drm/gma500/framebuffer.c          | 17 ++--
 drivers/gpu/drm/gma500/psb_drv.c              |  4 +-
 drivers/gpu/drm/gma500/psb_drv.h              |  2 +-
 drivers/gpu/drm/i915/display/intel_dp.c       |  3 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c     |  3 +-
 drivers/gpu/drm/nouveau/nouveau_display.c     | 11 ++-
 drivers/gpu/drm/radeon/radeon_display.c       |  6 +-
 include/drm/drm_connector.h                   |  2 +-
 12 files changed, 107 insertions(+), 46 deletions(-)


base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
-- 
2.56.0


