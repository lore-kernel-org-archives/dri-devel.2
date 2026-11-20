Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E5E60A2601
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hbyVScs2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4ED0112A27;
	Fri, 20 Nov 2026 13:10:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88F10112A24;
 Fri, 20 Nov 2026 13:10:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7098840A70;
 Fri, 20 Nov 2026 13:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79E01F00AD4;
 Fri, 20 Nov 2026 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795180241;
 bh=U+hegRIy/xY+dpQTnd+QgneMyrjorR6EiSVKHDOG3Sw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=hbyVScs29A+7Wv27mCUvHVh/8Q1lUXNtyP3A94pepSYMtvVPQJlrCp1XvwGJETkSf
 L7ie4beIvmjwG2Jwi3fxKd8rKYZSVhKhvqA5XIGJfaFgP+k/0co1k1TRNTYbkkpMuj
 WacsjXxGmsdTlKRn6LwYBR5jNefUyHnPAMBC/rIUri0gzjBv8EH3XfyzQKMr/pywE3
 hTKyy/gKDzCWGP7jUDfU3pxDiXYVCiNIf9YGE2aPjXm6+Meh2hZCL9Ct9JuNvxD1tO
 bPpbmPmaodMIi+rjy7eeOOd7bHH7lf8jUbuWeWZRpUJ6V20ixYZpAkJi/YQasPG62/
 y0VcwzTc9xq3g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Nov 2026 14:10:14 +0100
Subject: [PATCH v12 7/9] drm/msm/dpu1: Carry the mixers over to created
 CRTC states
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-drm-reset-state-flag-v12-7-42d63d7417fc@kernel.org>
References: <20261120-drm-reset-state-flag-v12-0-42d63d7417fc@kernel.org>
In-Reply-To: <20261120-drm-reset-state-flag-v12-0-42d63d7417fc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3090; i=mripard@kernel.org;
 h=from:subject:message-id; bh=VOsWcDdoQhmil64ZECFvPndZo8/WP7wCswM7Ex/ZBaE=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNkMblsnBOiL2Ov87X+jr/yr68IsuTW+N/8/Efy9sCxkl
 mqvyh6PjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR4gTGGu6y30/XbDO35HDR
 VLPVab315sVf1T8zO37vnWWgnjehdk3bhorQDcvb7+2QkN59/GzZXcb6gkUMXv9n1SSeUvik817
 VdNHUiTbz3rzRdt5isqHXX/aL0zoR91jWvbc2ykUWTH6pv8QJAA==
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
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

Copy the mixers of the current state over when the new state has
none, like a duplicated state would have carried them. This is a
no-op for duplicated states, which already have them.

Only do so for a CRTC that stays enabled. dpu_crtc_assign_resources()
returns right after dpu_rm_release() for a disabled one, leaving the
mixers it just released behind in the state it was given, and those
must not be handed over to a new state where the consumers that don't
check the CRTC enablement could reach hardware reassigned since.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: freedreno@lists.freedesktop.org
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 77a2d1f6700d..a99f6761035f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1538,10 +1538,33 @@ static int dpu_crtc_atomic_check(struct drm_crtc *crtc,
 	if (crtc_state->mode_changed || crtc_state->connectors_changed ||
 	    crtc_state->color_mgmt_changed) {
 		rc = dpu_crtc_assign_resources(crtc, crtc_state);
 		if (rc < 0)
 			return rc;
+	} else if (crtc_state->enable && !cstate->num_mixers) {
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
+		 *
+		 * Only do so for a CRTC that stays enabled:
+		 * dpu_crtc_assign_resources() returns right after
+		 * dpu_rm_release() for a disabled one, leaving the mixers
+		 * it just released behind in the state it was given.
+		 */
+		if (old_cstate->num_mixers) {
+			cstate->num_mixers = old_cstate->num_mixers;
+			memcpy(cstate->mixers, old_cstate->mixers,
+			       sizeof(cstate->mixers));
+		}
 	}
 
 	if (crtc_state->planes_changed || crtc_state->zpos_changed) {
 		if (dpu_use_virtual_planes)
 			rc = dpu_crtc_reassign_planes(crtc, crtc_state);

-- 
2.56.1

