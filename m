Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EA5C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4588110E4A8;
	Mon,  7 Sep 2026 13:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LOOozFKJ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9291510E4A8
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:24:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 11C6260D99;
 Mon,  7 Sep 2026 13:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C931F00A3D;
 Mon,  7 Sep 2026 13:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788787448;
 bh=uzTWV9D0syghrcguqb/zrWbgBGzDrBoozwJ7+hJErBQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=LOOozFKJqE5UeAScDf+X4NsHtAcvQuPsP76Bn4VeRee6xXOb2akQdpZ1SLUkB5esf
 G5xF6A2Pu9nUSx0gADsgHAmaVxgNpQatZw7kfQ9QVPizpvs+Wg25e9QX0hqJ/mK638
 po4pHegaKQfwtWgazmmxMQM0ypElR8VrCLLh4bXXbVZ+mvXr4Llm6K0MCSRmDDZPGT
 v4cHfbU1Iq5mDHF1lcWjBUtlWZEadqWIFM6bZBl/xsB2qAZmHR8mUMfTsPscZP5oxh
 yhuJ0ZSfziw4TVPZ2M8MW4dBmoqVMS36HBv2Nzr53MpH6cNqlaYjv73ev24QefHOGH
 XpEmCrwhgb1TQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 07 Sep 2026 15:23:38 +0200
Subject: [PATCH v5 02/33] drm/atomic_helper: Skip over NULL private_obj
 pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-state-readout-v5-2-5fa1ac7a5148@kernel.org>
References: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
In-Reply-To: <20260907-drm-state-readout-v5-0-5fa1ac7a5148@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=mripard@kernel.org;
 h=from:subject:message-id; bh=06kpR2i5iiLjAxwd0fy0yH2BuonVSjnG0MZkgIuEo7A=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnzdt3r/DdHVfHXwVSryQt2Jy+16FeRSxI4m2mdYnBS4
 vMUrgUsHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiGcmMDf/fKn4My0xq9c4U
 DV5o2FPR5L7MPXDroi1uwm8Tv96dXb32zvKL37cc1Lm8tfTPwhNpkoz13k8lfpbW8E85zvTyuXl
 A0837SSbFNbP1Pfk6lmcpiqeeXDUvwLZyOuviS7ZrrQ7fu90BAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Just like for all other objects, drm_atomic_commit contains an array of
drm_private_state, with the number of states found in num_private_objs.

If we are to clean up a state by hand for some reason before calling
drm_atomic_commit_put(), chances are that the pointer to the affected
drm_private_obj and drm_private_states would have been cleared to avoid
any use-after-free.

However, since it's just an array, as we progress and free the items, we
can't update num_private_objs as we go since we would reduce the array
size, preventing us to remove the final elements.

And if the caller was to forget to update num_private_objs after it
iterated over the whole array, we're left with a (valid) array with a
non-zero number of NULL elements.

If we were to call drm_atomic_commit_put() at this point, chances are
that drm_atomic_commit_default_clear() would be called and it would
iterate over all those empty NULL items.

However, unlike what is found for connectors, crtcs and planes, we don't
test that our pointers are non-NULL before dereferencing them, leading
to a NULL pointer dereference.

Such callers should obviously be fixed, but there's no reason to not do
such a simple check, if only to be consistent.

Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 45df6376f408..596b0de44f00 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -351,10 +351,13 @@ void drm_atomic_commit_default_clear(struct drm_atomic_commit *state)
 	}
 
 	for (i = 0; i < state->num_private_objs; i++) {
 		struct drm_private_obj *obj = state->private_objs[i].ptr;
 
+		if (!obj)
+			continue;
+
 		obj->funcs->atomic_destroy_state(obj,
 						 state->private_objs[i].state_to_destroy);
 		state->private_objs[i].ptr = NULL;
 		state->private_objs[i].state_to_destroy = NULL;
 		state->private_objs[i].old_state = NULL;

-- 
2.55.0

