Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78AEECC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A876310E251;
	Thu, 15 Oct 2026 15:09:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B0B10E188
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D179843C2D;
 Thu, 15 Oct 2026 15:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9251F000C4;
 Thu, 15 Oct 2026 15:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076958;
 bh=PWbkkVArudCn1Wqn0MZ9vKne+7UKfSCA86eV1cCWnWY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=iMh3P4K2McKslZ+90PZqAi3E9lpUyIMDxfBIKgNafkAlxs1VEuomkMBZuALIazCxj
 2xaYt8V/gyK7TI9AN/JoESzV6IpQK/qI05MfS1xsb40FESBqlkoqUWzFez5umLa7uv
 sJTXcPjK2tqkrlhD+rRdvHrS9R76CBwN3JuUoAT3JpJRXf/5qmVXMyWiBMxPEGJqpW
 u3f9pFqeGqrJxqkeC526tRQtYiltrC+0VrURR4S053x2pAdrYfKneCsWOr1/WjRQpv
 9QkXt3AcveU/rKeQwAGC2CmLVr7tjf5NJ8Ju9ULy8Osd8lUi0G+yV9sQ7LNOfW6Bdm
 V0MuEAQ9QnLgA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:08:53 +0200
Subject: [PATCH v6 01/28] drm/atomic: Fix private obj error handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-1-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1751; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+un5jX5MYKjdi9UVZoGNWQPF9hb1ETjMZY0aEdl6mSg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3nRdUpxhcHjNKfEsm2ZTp2bvxVNblWXiTr48sd5B4
 R1/7YS+jqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRu62M9QHxdh9bebqu7TW8
 ef7BkVP7jm228DvyPXLjV4vTBZvPte1LvrGn33S2+sSV2RvfHJ3Up8rYMInxyGTPo2XT9uTaeux
 fMFkrPE9i6/+Jh/5XV69UlNk6rWi94YeeJ0H+Fz3XnOi//EhxOwA=
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

drm_atomic_private_obj_init() initializes the modeset lock and adds the
object to the privobj_list before calling atomic_create_state().

However, if atomic_create_state() fails, the function returns the error
directly without removing the object from the list or cleaning up the
lock. This leaves a dangling entry in privobj_list and a leaked lock.

Fix this by unwinding both operations in an error path.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9bb761eda59f..9973becb75ae 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1027,25 +1027,34 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 int drm_atomic_private_obj_init(struct drm_device *dev,
 				struct drm_private_obj *obj,
 				const struct drm_private_state_funcs *funcs)
 {
 	struct drm_private_state *state;
+	int ret;
+
 	memset(obj, 0, sizeof(*obj));
 
 	drm_modeset_lock_init(&obj->lock);
 
 	obj->dev = dev;
 	obj->funcs = funcs;
 	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
 
 	state = obj->funcs->atomic_create_state(obj);
-	if (IS_ERR(state))
-		return PTR_ERR(state);
+	if (IS_ERR(state)) {
+		ret = PTR_ERR(state);
+		goto err_list_del;
+	}
 
 	obj->state = state;
 
 	return 0;
+
+err_list_del:
+	list_del(&obj->head);
+	drm_modeset_lock_fini(&obj->lock);
+	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_init);
 
 /**
  * drm_atomic_private_obj_fini - finalize private object

-- 
2.55.0

