Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E16FF99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:18:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83FEE10F05A;
	Thu, 23 Apr 2026 10:18:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ICxR71xu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B3210F063
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:18:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C38F260120;
 Thu, 23 Apr 2026 10:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256B1C2BCB2;
 Thu, 23 Apr 2026 10:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776939516;
 bh=ZXq2fGzF3baRtOkzR6/UWZvmPhl8qyFGt/u1hfLtn/Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ICxR71xuSXF0nNaggipC4agYg8UZsT/28BjdRSYaaAIYl6mcHaZ7e2nUmuTPgX7oq
 V+9xmb9AY3/3mKGRB1S8rP2Ph4RRbC03n+6ET0aEmwGTy5EbSG/DYE44b1STNhlLMc
 S7KYWN3DHlc6NZr7xOmoHz/K3xbqUrBRpd+PI063RJn/CPkKN4w066N8qSBjm5s0q5
 6dGZwhSAoliia6L0YdpWUKFcZZ8BJlkynYR7mCnjCCp/96RYVe9ls5uYr8PjrlSgXA
 2uiFHomduVNfYjSX0D7zqgDgjYfYYQyFHR3hCXoGwFbjO4pqWWRoGY8vQWhz67fZkr
 T0lj6mDfSkoqw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:18:15 +0200
Subject: [PATCH v2 02/28] drm/atomic_helper: Skip over NULL private_obj
 pointers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-2-8549f87cb978@kernel.org>
References: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-8549f87cb978@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2100; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ZXq2fGzF3baRtOkzR6/UWZvmPhl8qyFGt/u1hfLtn/Y=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkvP76ImMfhKxey9+v/20eaX37c0hTlknWdf90jj+Yb0
 2s2zdwU2jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmEnWUsVbG+MSB04wqHA+O
 S7t2TkmY/snkklzV8zLfZvOAMNtQ/b59lv373zwxv/Yt2i38VWWnJmPDmodz3xjmpV488arZK2n
 vRAeex23vD5Wd2OZuNO+lKEf6vRBZjsqlXpOi+rjnvO0UX3AfAA==
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

Just like for connectors, drm_atomic_state contains an array of
drm_private_state, with the number of states found in num_private_objs.

If we are to clean up a state by hand for some reason before calling
drm_atomic_state_put(), chances are that the pointer to the affected
drm_private_obj and drm_private_states would have been cleared to avoid
any use-after-free.

However, since it's just an array, as we progress and free the items, we
can't update num_private_objs as we go since we would reduce the array
size, preventing us to remove the final elements.

And if the caller was to forget to update num_private_objs after it
iterated over the whole array, we're left with a (valid) array with a
non-zero number of NULL elements.

If we were to call drm_atomic_state_put() at this point, chances are
that drm_atomic_state_default_clear() would be called and it would
iterate over all those empty NULL items.

However, unlike what is found for connectors, crtcs and planes, we don't
test that our pointers are non-NULL before dereferencing them, leading
to a NULL pointer dereference.

Such callers should obviously be fixed, but there's no reason to not do
such a simple check, if only to be consistent.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3bd52602fe30..84bc91886b4c 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -334,10 +334,13 @@ void drm_atomic_state_default_clear(struct drm_atomic_state *state)
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
2.53.0

