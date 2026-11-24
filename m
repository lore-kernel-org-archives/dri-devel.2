Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE14606A33A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=jrDDBnxv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A42B110F82C;
	Tue, 24 Nov 2026 18:18:38 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BE110F048;
 Tue, 24 Nov 2026 18:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=7Q/tvhyADyJrRrirPgaeSBl8R9RNHFpbVSvmUKtXozI=;
 t=1795544292; x=2110904292; b=jrDDBnxvQp3PwqTcKF3ynlOZoTd9m3oKW6/djbtmMsFgZ0A
 pk3M2uElOvgfr4nGzDIuH7SwDV8uGbFpwSLvAETQFuHD/vtpPjdBPOqbIET3PfoZqvRDybnrlUPKO
 MyxTrV5/T/kA9aLvwxSSZqwPHuod0IdjSiONKNfZYuyNyi6sQZq02pFwZN9twW2ctp8s1ZtPmvnvW
 SuXnqpFmDGZcnKa9K3FhULG3HmvdcQ5IrIJiggOhZif99q8Cg7BKUREY30UEsitjrrtgFy3SOQOSK
 SfedSn5yF3pWcVTYrCf37B2DjpQhXOC+di/6jiXKnf4oBvHgNznSL0EajflyejAA==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5f-00000003axM-0yc5; Tue, 24 Nov 2026 19:18:03 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Ariel DAlessandro <ariel.dalessandro@collabora.com>,
 nfraprado@collabora.com, Alex Hung <alex.hung@amd.com>,
 Simon Ser <contact@emersion.fr>, Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 Daniel Stone <daniels@collabora.com>, kernel-dev@igalia.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leandro Ribeiro <leandro.ribeiro@collabora.com>,
 Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 04/19] drm/atomic: duplicate CRTC colorop states
Date: Tue, 24 Nov 2026 19:03:21 +0100
Message-ID: <20261124181652.1333986-5-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the state of every CRTC colorop to the duplicated state, active or
not, so their settings persist on a reset cycle.

Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- new patch
- Note: if "drm/atomic: duplicate state of all colorops" for colorop
  planes [1] lands first, the plane and CRTC loops can be merged into a
  single pass over all colorops.
  [1] https://lore.kernel.org/dri-devel/20261111160814.21326-8-mwen@igalia.com/
---
 drivers/gpu/drm/drm_atomic_helper.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index ccfe3840d505..da908f0266bf 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -3730,6 +3730,7 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 	struct drm_connector_list_iter conn_iter;
 	struct drm_plane *plane;
 	struct drm_crtc *crtc;
+	struct drm_colorop *colorop;
 	int err = 0;
 
 	state = drm_atomic_commit_alloc(dev);
@@ -3749,6 +3750,23 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
 		}
 	}
 
+	/*
+	 * Add all CRTC colorops, active or not, so their settings survive the
+	 * colorop reset done on resume.
+	 */
+	drm_for_each_colorop(colorop, dev) {
+		struct drm_colorop_state *colorop_state;
+
+		if (!colorop->crtc)
+			continue;
+
+		colorop_state = drm_atomic_get_colorop_state(state, colorop);
+		if (IS_ERR(colorop_state)) {
+			err = PTR_ERR(colorop_state);
+			goto free;
+		}
+	}
+
 	drm_for_each_plane(plane, dev) {
 		struct drm_plane_state *plane_state;
 
-- 
2.53.0

