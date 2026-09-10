Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484A3C79FB6
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 01:49:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5993D10E209;
	Thu, 10 Sep 2026 01:49:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=scd31.com header.i=@scd31.com header.b="Wq+YZ+XN";
	dkim-atps=neutral
Received: from mail.scd31.com (mail.scd31.com [205.209.125.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A7D10E209
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 01:49:35 +0000 (UTC)
From: Sophie D <patches@scd31.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scd31.com; s=mail;
 t=1789004974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gqOCUAt0BB0MGG5A7Mb4irXVTS/KZBPzdwYbKbMHAw=;
 b=Wq+YZ+XNLVIYKZW3f3wmn2c02wi81jOjUoO5g8WJFVp4cBGKLhNQ8G63X8QsJeMsxob2Jv
 SFj8Uv6QaPFvCi9mF0Gc2SO28rh2POa8L/Urw5WTqn6ESgd5jTlnpZt6vk/wkFeLWSiE9A
 vV41FD2tQYm+nEIudFcf4+BNr3wUbZo924DQt5Iz5V/WPsA+mS8wc0KyiNrfqskCCDxEud
 tx3JyIxfruDyGXJ3Psq0JH4PhgUqoF3VDXXS5HvDTq3WmbLOg59QTO2gVCqooWTvC6J41n
 pAmlEnXowWQNLmYpAto5pMGyvMVgO3twS64UBMMKK44jBQNgmy0gbiNuTt2vew==
To: Ruben Wauters <rubenru09@aol.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Sophie D <patches@scd31.com>,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/gud: Ignore damage clips in full update mode
Date: Wed,  9 Sep 2026 21:49:10 -0400
Message-ID: <20260910014910.8564-1-patches@scd31.com>
In-Reply-To: <20260907230849.31032-1-patches@scd31.com>
References: <20260907230849.31032-1-patches@scd31.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

When running in full update mode, previously small updates (such as
moving the mouse across the screen) would cause many full frames to be
generated. This would bog down the bus and lower the effective framerate
significantly - I was seeing a drop from 60 FPS to 2 FPS.

Set ignore_damage_clips in full update mode so the damage iterator
yields a single full-plane rectangle instead of one per clip.

Fixes: 73cfd166e045 ("drm/gud: Replace simple display pipe with DRM atomic helpers")
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Sophie D <patches@scd31.com>
---
v2: set ignore_damage_clips in atomic_check instead of merging clips in
    atomic_update (Thomas Zimmermann)

 drivers/gpu/drm/gud/gud_pipe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index 5ef887d84..3388fdc8e 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -482,6 +482,9 @@ int gud_plane_atomic_check(struct drm_plane *plane,
 	if (!new_plane_state->visible)
 		return 0;
 
+	if (gdrm->flags & GUD_DISPLAY_FLAG_FULL_UPDATE)
+		new_plane_state->ignore_damage_clips = true;
+
 	if (old_plane_state->rotation != new_plane_state->rotation)
 		crtc_state->mode_changed = true;
 
-- 
2.55.0

