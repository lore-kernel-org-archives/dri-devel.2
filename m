Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34CE610987A9
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:28:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E278410EB62;
	Fri, 20 Mar 2026 16:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KM/M8DbM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EEBF10EB5F;
 Fri, 20 Mar 2026 16:28:13 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EC3D260141;
 Fri, 20 Mar 2026 16:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2050CC4CEF7;
 Fri, 20 Mar 2026 16:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774024092;
 bh=wxvIbslsFOe+8OR1tP24GsCg3PyWA7sUK7uSel4Swqg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KM/M8DbMI4cQ51n4PrNKbVDyepwp+XaKiCX9TL8p3egLC7ajUeVHSRCHBv1xZYxZ4
 IbyvpfmTRNYivbC9qTEMn2ReWq360mbwcoZ03g0Hktfl89CWBfjmxyGzkCuqZWEkFI
 XSQAd0rZeeJy8masn23VpfsooUbxy6raFOIA53Zr1xnqfc+GeunlSQCqXGgdsf+TIC
 oI61Kj29xVzn90u/8R3OvE9xjVFn+4ziqUDXQX5nxfL/wuyrmHgVSnO8q5lU7Tib2g
 59de87igWktKY/xlNasqJ6UTmZVJjvq5voBnndn/G8KQv8+9jnjZ0pUBBgNFv6J5BM
 0AwUUvi9yZOTQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 20 Mar 2026 17:27:23 +0100
Subject: [PATCH v2 16/20] drm/atomic: Drop private obj state allocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-drm-mode-config-init-v2-16-c63f1134e76c@kernel.org>
References: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
In-Reply-To: <20260320-drm-mode-config-init-v2-0-c63f1134e76c@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Simon Ser <contact@emersion.fr>, Harry Wentland <harry.wentland@amd.com>, 
 Melissa Wen <mwen@igalia.com>, Sebastian Wick <sebastian.wick@redhat.com>, 
 Alex Hung <alex.hung@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Daniel Stone <daniels@collabora.com>, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Maxime Ripard <mripard@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1451; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wxvIbslsFOe+8OR1tP24GsCg3PyWA7sUK7uSel4Swqg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJl7S7OCbn+8dc39U0vJg8nZdpOvO65nua8bUaB9Xsdgx
 an1HDofO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEJu9lrE/7u5hT4pqPR+CX
 DSvU3YPkVm/5zxB2IY49sG8ai108mxnvQ4sngRl7pq59dVhh0dv4j4x1VrNOKB+e4/Rn2UV7jp4
 i24dPW7TF5fcKCOTOXRVc4yN5pdPkZXkJ53R+1tZ7YlOcVvcAAA==
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

Now that drm_dev_register() calls drm_mode_config_create_state() for
every modeset driver, the private obj states will be initialized at
driver registration automatically if they haven't already.

Thus, the explicit initial allocation we have in
drm_atomic_private_obj_init() is now redundant, and we can remove it.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 5aa3f9f0620bd155dd53023e6c76e3883ffaadef..3bd52602fe307a1b82a3b68d82b458e1da8a4f6d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -995,25 +995,18 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
  */
 int drm_atomic_private_obj_init(struct drm_device *dev,
 				struct drm_private_obj *obj,
 				const struct drm_private_state_funcs *funcs)
 {
-	struct drm_private_state *state;
 	memset(obj, 0, sizeof(*obj));
 
 	drm_modeset_lock_init(&obj->lock);
 
 	obj->dev = dev;
 	obj->funcs = funcs;
 	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
 
-	state = obj->funcs->atomic_create_state(obj);
-	if (IS_ERR(state))
-		return PTR_ERR(state);
-
-	obj->state = state;
-
 	return 0;
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_init);
 
 /**

-- 
2.53.0

