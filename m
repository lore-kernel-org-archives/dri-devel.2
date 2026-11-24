Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BD606A696
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=m+ZDBG3/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2075910F837;
	Tue, 24 Nov 2026 18:18:40 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6487B10F033;
 Tue, 24 Nov 2026 18:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=znC4sG6BZKe98gRYlVdYMFewri6JoIv6eM12y10D+Iw=; t=1795544301; x=2110904301; 
 b=m+ZDBG3/WkhwaolQUXH3W3aNJItVBq5+PbvbFCTTi7dHkGhaA7NKLltzeH7c/nd3c27wlAffaDm
 B710iYL8/XQikVrrxC3rzSF8zAkiZhFLQ/GXkmomYSnKYcMeovb3ixCsyVwYckG5ntDQi8S4f/5fG
 f05RXAdNJE/XCBISDv+qZRsbxog3gSJOPNTqJ5Qm1dPWZNEmoOKvaGo0KFd9eHaJsy/yRS1Fp50wC
 ZUhFFGbhB/EbzAJ1OAnbY/WOPNcitVJhC/S/2xvcyj5itQRimRpX2R/+7uGtJzuTno/mMNAZKuYde
 VqzkkznV8sy5Jy03IeDP5+RbKb4+R7eLhnTw==;
Received: from 84.125.127.4.dyn.user.ono.com ([84.125.127.4] helo=killbill)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xVv5o-00000003axM-1FlR; Tue, 24 Nov 2026 19:18:12 +0100
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
Subject: [PATCH v3 09/19] drm/atomic: Print the color pipeline as part of the
 CRTC state print
Date: Tue, 24 Nov 2026 19:03:26 +0100
Message-ID: <20261124181652.1333986-10-mwen@igalia.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Print the value of the color pipeline in the CRTC state as part of the
CRTC state print.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Co-developed-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>

---
v3:
- rebase on drm-misc-next, no other changes
---
 drivers/gpu/drm/drm_atomic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 6d608795f28b..430d4a95241b 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -575,6 +575,8 @@ static void drm_atomic_crtc_print_state(struct drm_printer *p,
 	drm_printf_indent(p, 1, "plane_mask=%x\n", state->plane_mask);
 	drm_printf_indent(p, 1, "connector_mask=%x\n", state->connector_mask);
 	drm_printf_indent(p, 1, "encoder_mask=%x\n", state->encoder_mask);
+	drm_printf_indent(p, 1, "color-pipeline=%d\n",
+			  state->color_pipeline ? state->color_pipeline->base.id : 0);
 	drm_printf_indent(p, 1, "mode: " DRM_MODE_FMT "\n", DRM_MODE_ARG(&state->mode));
 	drm_printf_indent(p, 1, "background_color=%llx\n", state->background_color);
 
-- 
2.53.0

