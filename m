Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6950606A33B
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aGKdKqva
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EF7510F7FC;
	Tue, 10 Nov 2026 16:03:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E85110F7E3;
 Tue, 10 Nov 2026 16:03:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1558A47367;
 Tue, 10 Nov 2026 16:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CD61F008A4;
 Tue, 10 Nov 2026 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794326604;
 bh=ca0P2BfPUIA1lK0FICOapDfKS40M1P4WeHh69MT1Qlg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=aGKdKqvaBLADc4u9aqc6AVaVtdyCerKZTyrtSpVeFGaNHf6unaGfLa4Yg3ph3NZbi
 DiT+uCC2UhdBac26RIiAoSK1SxQzlGD72FhL3vjfKgsZ//xI4eIKb3vxkn1mkkmUsR
 4KX7ioXR0cqUQLBJG3NzHNF+WeSK3/v1pIkwGmKbWf3yjbboM4bqz02xmTUcaHHbOL
 atAb/m/n/O0SOPVPMlk6YsD3dA0s29YHGb36dVbI2AeMlO44AHv5lb+B4KwNeGunag
 ntCEYOU6VAxLCCquagiTvIxfiCdBxsN/iqdSgSeKbXJOAs/8Ms5S/dsvbIGhGTLEOi
 3+87+mKmlIY4A==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 10 Nov 2026 17:02:55 +0100
Subject: [PATCH v9 08/10] drm/msm/dpu1: Carry the mixers over to created
 CRTC states
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-drm-reset-state-flag-v9-8-ddb0e26324a0@kernel.org>
References: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
In-Reply-To: <20261110-drm-reset-state-flag-v9-0-ddb0e26324a0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Louis Chauvet <louis.chauvet@bootlin.com>, 
 Haneen Mohammed <hamohammed.sa@gmail.com>, 
 Melissa Wen <melissa.srw@gmail.com>
Cc: Daniel Stone <daniels@collabora.com>, 
 Harry Wentland <harry.wentland@amd.com>, 
 Jocelyn Falempe <jfalempe@redhat.com>, 
 =?utf-8?q?Jonas_=C3=85dahl?= <jadahl@redhat.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 Sebastian Wick <sebastian.wick@redhat.com>, Simon Ser <contact@emersion.fr>, 
 Victoria Brekenfeld <victoria@system76.com>, 
 Xaver Hugl <xaver.hugl@kde.org>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, freedreno@lists.freedesktop.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2634; i=mripard@kernel.org;
 h=from:subject:message-id; bh=nIBZgN9qljHznfTUu5JixwvDzJ3IvKzNrFrk/k4dhYw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmfHfRDor1S3XY+nLdLWnxqptxBpU1uk5X/P7P3KC7ey
 27B1erSMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZSeI2xoXm20o3VprN8NLy6
 X2ecmGV21W6f7ayNkqKszL1SczR2vzu0cXOH1OJnTaUiQgarbHI2MtaHs7Q0L580u6zi5LLct+1
 qLzhe/5mga7bsSoHvr36+C0frpqkdXrS/sbbmL78cQ95x358A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_atomic_commit_fill_with_defaults() builds its commits out of
states created through atomic_create_state() instead of duplicating
the current state. A created CRTC state comes with no mixers, while a
duplicated state carries the ones currently assigned, since the
duplication copies the whole state.

dpu_crtc_atomic_check() only goes through dpu_crtc_assign_resources()
when the mode, the connectors or the color management properties
changed, so a CRTC that keeps its configuration with a created state
runs with no mixers at all.

Copy the mixers and the CTLs of the current state over when the new
state has none, like a duplicated state would have carried them. This
is a no-op for duplicated states, which already have them.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: freedreno@lists.freedesktop.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 77a2d1f6700d..97deadc976ed 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1538,10 +1538,31 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
 	    crtc_state->color_mgmt_changed) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)
 			return rc;
+	} else if (!cstate->num_mixers) {
+		struct dpu_crtc_state *old_cstate =
+			to_dpu_crtc_state(drm_atomic_get_old_crtc_state(state,
+									crtc));
+
+		/*
+		 * A CRTC that keeps its configuration keeps its mixers.
+		 * A duplicated state carries them over, but a state
+		 * created through atomic_create_state() comes with
+		 * none, so copy them from the current state like a
+		 * duplicated state would, to make sure the checks and
+		 * the commit see the mixers in use.
+		 */
+		if (old_cstate->num_mixers) {
+			cstate->num_mixers = old_cstate->num_mixers;
+			memcpy(cstate->mixers, old_cstate->mixers,
+			       sizeof(cstate->mixers));
+			cstate->num_ctls = old_cstate->num_ctls;
+			memcpy(cstate->hw_ctls, old_cstate->hw_ctls,
+			       sizeof(cstate->hw_ctls));
+		}
 	}
 
 	if (crtc_state->planes_changed || crtc_state->zpos_changed) {
 		if (dpu_use_virtual_planes)
 			rc = dpu_crtc_reassign_planes(crtc, crtc_state);

-- 
2.56.0

