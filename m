Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED6B606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=QD5XezuQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A3B10F031;
	Tue, 24 Nov 2026 18:36:02 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B92C210F03C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 18:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=SUguSV5CibFKdc1d3UCgn4OpNLZjlUj8XjUdOynS6MI=;
 t=1795545351; x=2110905351; b=QD5XezuQryGjr7qQTC5h/3RKgXrlfX8DsvvhBb/qKtuNLNW
 jqS5wYuNKRxCCuxn8mAlT0O2URphiuy9Zk8EVXjtCt8SOYncoxnp88Lj1MMNHll/TZm9wqy0WzQ0O
 Ck9KGs2FCOqPAhUrjy6T8oJjo6gJycfAFUQGBaNGTy5P9bCH6tTc3zoV6ehy0pOvYVjk3aO1+MtqU
 vyV4rX3SQ/ergpjS5aT8gSyiiOJdjAgQl5kmCMFlcEdAMdTDk2n7MFSrlisRrMoxZtkftpI+8SaXi
 YMBRVl+lbJ2WA6ohPUKu1FybgdxeFe5R2GiPKIJAB0kG42ziUSNG1RQaOiKxz/wg==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVvMi-00000003bVG-2g5O; Tue, 24 Nov 2026 19:35:40 +0100
From: Melissa Wen <mwen@igalia.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com, mwen@igalia.com,
 alex.hung@amd.com
Cc: Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, kernel-dev@igalia.com,
 dri-devel@lists.freedesktop.org, sebastian.wick@redhat.com
Subject: [PATCH] drm/atomic: reject colorop property changes in async flips
Date: Tue, 24 Nov 2026 19:33:59 +0100
Message-ID: <20261124183532.1335786-1-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 0e26cc72c71c ("drm: Refuse to async flip with atomic prop
changes") only allows async flip with plane's framebuffer and a few
related plane property changes and don't include color management
properties.

Apply the same rule to colorops: accept a value that matches the current
state, so userspace can keep resubmitting its whole color pipeline with
every flip, and reject any change with -EINVAL.

Fixes: cfc27680ee20 ("drm/colorop: Introduce new drm_colorop mode object")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..a45e61cd9bc3 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1322,6 +1322,14 @@ int drm_atomic_set_property(struct drm_atomic_commit *state,
 			break;
 		}
 
+		if (async_flip) {
+			/* no-op changes are always allowed */
+			ret = drm_atomic_colorop_get_property(colorop, colorop_state,
+							      prop, &old_val);
+			ret = drm_atomic_check_prop_changes(ret, old_val, prop_value, prop);
+			break;
+		}
+
 		ret = drm_atomic_colorop_set_property(colorop, colorop_state,
 						      file_priv, prop, prop_value,
 						      &replaced);
-- 
2.53.0

