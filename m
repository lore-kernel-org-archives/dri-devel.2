Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69873606A69F
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=OqzCw+D4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A27B110F039;
	Tue, 24 Nov 2026 18:18:15 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B7CB10F033;
 Tue, 24 Nov 2026 18:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=s+Yuq/eEWOB/k6XkVjfQbu8Y5QlIWL3M/5uaHGmreUQ=; t=1795544289; x=2110904289; 
 b=OqzCw+D4tT2dWGcX938b8jzH3VatZ9YJmq324/LgAWBHXY55tmNrNcZ+9/9P0qDZTNCik24PmjM
 24JD24ykohKnCyEn4s4mOvH4OXk976zQtw0i/Hz6e63VVSi4hk3QorA5BULXqHd41tb6yVYBP/uVy
 pE6gieZZS6t7Vt9ZkKPU0I7O4jqwTUZDClb09o1eFjneqX46XMPwRYsGx0837PCZpU49VDEkoK3RN
 tNH/E1LD8T6bP6lL862GS1eVpflNPdmAYY6jG24kMLioLSIT2Rg8/IqQcB5DjsE7TYy7SylyLhhvk
 MQNVk0u3y5/7/Rq1dugFv1rEAsZMg3DSxRvA==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5Y-00000003axM-2BIk; Tue, 24 Nov 2026 19:17:56 +0100
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
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>
Subject: [PATCH v3 01/19] drm/crtc: Add color pipeline to CRTC state
Date: Tue, 24 Nov 2026 19:03:18 +0100
Message-ID: <20261124181652.1333986-2-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124181652.1333986-1-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Add a color pipeline to the CRTC state to allow post-blend color
pipelines.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
---
 include/drm/drm_crtc.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index be5dca538d87..03991b381dce 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -274,6 +274,14 @@ struct drm_crtc_state {
 	 */
 	struct drm_property_blob *gamma_lut;
 
+	/**
+	 * @color_pipeline:
+	 *
+	 * The first colorop of the active color pipeline, or NULL, if no
+	 * color pipeline is active.
+	 */
+	struct drm_colorop *color_pipeline;
+
 	/**
 	 * @background_color:
 	 *
-- 
2.53.0

