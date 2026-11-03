Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954F8606A339
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwgu3IA3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D79EE10E0F4;
	Tue,  3 Nov 2026 20:02:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 015F110E0F4;
 Tue,  3 Nov 2026 20:02:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B816D434D6;
 Tue,  3 Nov 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793736173;
 b=QJ9vtwMi38yjcN+O+BsC6QSadnBGSkH9sRYwALQftsk5o54raPYAFblIha61wwR4O/09
 h+SdRmEApfmZ8OBf4YhXhRBmjuWgN7nSYF0qTK+4rUNEmQN1X1J5DVk55rdwptvtN1foB
 DigPuwUqx4QzpfklKWZiEw984k8kbbdfl4dIaIGpBpBWKVTUwldYSt4qL3laPR1MzeIj3
 NJ4u8R+csN/mZF7XadTzabbyUY5DSwYaOWpCQSPaOkJMfAa7ae0mRCCu9V/iu9l/gegp/
 DBLr+qWqdGZ80CVkJhFvyTYzUvsuTi5DzHzbncnkwhgZ2pPFdr97oStcuFkS1jsNbJw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793736173;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=V8bhaW0ZrvMinjR8/va52cxxrgoArfzeg+J00cAsiXM=;
 b=opuvMFBDRV3tmDGSsWZ+oBN/zpplo4v2YbjO51jklWuSduLy69Pg7Y8Rk4J0QYQTC2hV
 o76CmoWZ49fLvzEAxF1e/XsWTeTpMaR2/kLuEOS86PcchGT3mc56heG5jW48GGc0fRF9A
 fR+k4rBdKFR03sbGytCHZwCNEiIeiNjWInCZu/WoT1tn0j1SYMr9/4+N+pyraF3KqImV+
 hSKehbbdKGJeAaiZI1ppbh00i+yqUyEl7sZ88LRvKkzn1roy87XbO53jxe8zUg5WJZTWl
 C7F2weLDmUjaUUfS3pCM/wf1xkFPo4elTqFHIq1qqiBmYFBspjG4s4hSicyQ/XSDbgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 56C631F00919;
 Tue,  3 Nov 2026 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793736173;
 bh=V8bhaW0ZrvMinjR8/va52cxxrgoArfzeg+J00cAsiXM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=dwgu3IA3gTGRbJ4o6bHcrXyipS3EYm6nFMHogRe6+58QYEzFcBFULlrUZghOVEtJT
 0+I2asCF6dm3b2qyhzM6kuToG9S01vdYfFbHITGUdpvSFt6pb+q8xXnLiIPcr4cWN2
 c3nqN+H1+UfTQAVv5z3BfHVFxIqKjibuSgTqDzlPV/37F0yt7xgtNECXFBQSfTnmC7
 56gksQo14CiMYG0FWHhBs495iX4VHI8ehpHLJyyEVThFWu3uCyEyHEah9MyYwU9TuM
 dp0bw/dlIB4Gy8Y/YdT+1vMI34/xc5n/2Nha/mK70rXn1uCKa7r5tRXVv04VQcyZEV
 vx5nGbxcOn6Jg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id D0FD646ADB;
 Tue,  3 Nov 2026 20:02:51 +0000 (UTC)
From: "David R. Hedges via B4 Relay"
 <devnull+linuxdev844.thelittleman.net@kernel.org>
Date: Tue, 03 Nov 2026 14:02:47 -0600
Subject: [PATCH 1/5] drm/nouveau/kms/nv50-: reject DP modesets the link
 can't carry
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-nouveau-dp-relink-v1-1-7ee88c7f1e8a@thelittleman.net>
References: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
In-Reply-To: <20261103-nouveau-dp-relink-v1-0-7ee88c7f1e8a@thelittleman.net>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@intel.com>, Ben Skeggs <bskeggs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Danilo Krummrich <me@dakr.org>, 
 "David R. Hedges" <linuxdev844@thelittleman.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793736171; l=3402;
 i=linuxdev844@thelittleman.net; s=20261103; h=from:subject:message-id;
 bh=NdWN23uKT/9mBJCO7M1jmiktyYPpdGsPPw0VjH8l0q4=;
 b=IDMPhXCycTOWwZ/CRnLH/Xfh5uYfJtanaF2UzJY8wy5H+5T0PisIBcpFVhOQcX/XX7dqv8lD7
 BGybTpcR0nDB4K6k93VWh8f58LWKetnMziHXxpiJcFefJYu4bXsneZ+
X-Developer-Key: i=linuxdev844@thelittleman.net; a=ed25519;
 pk=Cynzuei/w0GLdh3LuNJdvH7aaszLrHSxY5UyujS7l+g=
X-Endpoint-Received: by B4 Relay for linuxdev844@thelittleman.net/20261103
 with auth_id=1397
X-Original-From: "David R. Hedges" <linuxdev844@thelittleman.net>
Content-Transfer-Encoding: 7bit
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
Reply-To: linuxdev844@thelittleman.net
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "David R. Hedges" <linuxdev844@thelittleman.net>

nv50_outp_atomic_fix_depth() lowers the bpc of a DP mode until it fits
the link's capabilities, but carries on at 6 bpc if it still doesn't.
nouveau_dp_train() then finds no lane count and link rate fast enough,
trains nothing, and the output is enabled anyway.

Modes are checked against the link when they're probed, so this takes
a sink whose capabilities have dropped since, or that couldn't be
probed at all.  An IGM L28TN4K on a GA102 (GSP-RM 570.144) manages
both: for a moment after being switched on with its power button it
advertises DPCD 1.1 and HBR rather than DPCD 1.2 and HBR2, and the
3840x2160@60 mode it had been running needs 1336500 kB/s even at
6 bpc, against 1080000 kB/s for 4 x HBR; and while it's switched off
it keeps HPD asserted but doesn't answer AUX, which leaves its link
capabilities at zero.  Enabling the output in either state ended in
"core notifier timeout", after which GSP stopped answering RPCs.

Fail the modeset in that case, so that userspace can pick a mode that
fits.  A commit that only turns the CRTC back on mustn't fail (see
struct drm_crtc_state), so that case is left to the commit path, which
the next patch deals with.

Link: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515
Signed-off-by: David R. Hedges <linuxdev844@thelittleman.net>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 7daecaecccac..8af01de822d5 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -373,7 +373,8 @@ nv50_outp_atomic_check_view(struct drm_encoder *encoder,
 	return 0;
 }
 
-static void
+/* Returns false if the link can't carry the mode even at the lowest bpc. */
+static bool
 nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *crtc_state)
 {
 	struct nv50_head_atom *asyh = nv50_head_atom(crtc_state);
@@ -389,17 +390,26 @@ nv50_outp_atomic_fix_depth(struct drm_encoder *encoder, struct drm_crtc_state *c
 		asyh->or.bpc = min_t(u8, asyh->or.bpc, 10);
 
 		/* reduce the bpc until it works out */
-		while (asyh->or.bpc > 6) {
+		for (;;) {
 			mode_rate = DIV_ROUND_UP(mode->clock * asyh->or.bpc * 3, 8);
 			if (mode_rate <= max_rate)
 				break;
 
+			if (asyh->or.bpc <= 6) {
+				drm_dbg_kms(encoder->dev,
+					    "[ENCODER:%d:%s] mode needs %u kB/s, link carries %u kB/s\n",
+					    encoder->base.id, encoder->name, mode_rate, max_rate);
+				return false;
+			}
+
 			asyh->or.bpc -= 2;
 		}
 		break;
 	default:
 		break;
 	}
+
+	return true;
 }
 
 static int
@@ -423,8 +433,13 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
 	if (crtc_state->mode_changed || crtc_state->connectors_changed)
 		asyh->or.bpc = connector->display_info.bpc ?: 8;
 
-	/* We might have to reduce the bpc */
-	nv50_outp_atomic_fix_depth(encoder, crtc_state);
+	/* We might have to reduce the bpc.  If the link can't carry the mode
+	 * at all, fail a modeset, but not a plain DPMS on, which userspace
+	 * expects to always succeed.
+	 */
+	if (!nv50_outp_atomic_fix_depth(encoder, crtc_state) &&
+	    (crtc_state->mode_changed || crtc_state->connectors_changed))
+		return -EINVAL;
 
 	return 0;
 }

-- 
2.55.0


