Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92ECC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:57:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AC610E3B9;
	Fri, 26 Jun 2026 13:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SaaePmeg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F8BC10F5ED
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:57:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A76CC600C8;
 Fri, 26 Jun 2026 13:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19AA1F000E9;
 Fri, 26 Jun 2026 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782482248;
 bh=RbcoK1iY/lQ+qSGUZ4TjR1hpg1Qs0p4B20eZ/wq3XNM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=SaaePmegtJ1liW9ayKltrGyWEUGJj5R9jJisIXOrKhXRubeIayIL8u2lFsEF7CmIg
 6iECD6gzWkQ5qZUc0TdRIMqaBp9nQIWuhi25xMx8tVOibd2qKvaYLMlfGQq+ocnHXE
 SxFvtnZ10e9Rc1JJSHVCz1LsTz/P3yErfps34nQjmdMxd67Th4DeuDo1L3mbUSdGaa
 reckj9XCP8WU5AzQyGILz9u+Y68uqaFRBRfJyBQJm8LC2+o/aenpkohii/ZlhdxspP
 yKSV5ysAi1ddXHNbZH15m9GQaVD6GAxFXv3XUN1ihSZ544ecOXg5+JgvsBinEjZHqC
 7aaLfgMThc5ig==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 26 Jun 2026 15:57:03 +0200
Subject: [PATCH v3 02/30] drm/atomic_helper: Skip over NULL private_obj
 pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-drm-state-readout-v3-2-d5825e3299a8@kernel.org>
References: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
In-Reply-To: <20260626-drm-state-readout-v3-0-d5825e3299a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 lidrm_printf_indentnux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2166; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1zvvWsqKbGCIswL4GEFi5zKzwUt2aU3quV7GlKeKKEw=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFl2rUYd66QaLJbt//bku/iPNVumP91349Hig39nT2Bfp
 HH068Rg3o6pLAzCnAyyYoosT2TCTi9vX1zlYL/yB8wcViaQIQxcnAIwkZb9jA2d97/6R89SvFLs
 onCYP/Ju+Wem6836c3IuJVu63/uy+o/DaU7hy+mPO2R/L5kwY/Hu4nLGhrPCpXkuO9Qdejjelq0
 MZDydpNr+krv9a+S8KZ5KNScNpbhN9idXKFc1TbsY3XXcLzgQAA==
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
index 3af1b9cc9a06..af44bbb5cacb 100644
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
2.54.0

