Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59177CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 13:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A920510EA9B;
	Tue, 12 May 2026 13:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GGxZx8KW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 213E110EA99;
 Tue, 12 May 2026 13:06:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 06191444C0;
 Tue, 12 May 2026 13:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA07C2BCFC;
 Tue, 12 May 2026 13:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778591182;
 bh=8gKR8nH9fdwkklOxC1orkJLxbt3pf9ySjt3LJ0StlRk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GGxZx8KW4BSriBhJaMPGvB3SXhxjVOOLsk9Y8Jr7sqdb6k3bB6CBc0MT0A87tMdjZ
 HZR8PCv6rVGbklxUlg1yXZfM+n19jM0aHi6D4mcWTA/Yv/QpAwMuLcMYBA2fjxKjkr
 6bartXn7ScRBz7zE0xSq9Z9a6ZrXc9wFwLbq9UbcAmnqJDQv+YJBLBIiO2VKxs0mB+
 FyziphPUBuKeRXAZxln0Gs4VETqzp1eYv9ekcJCXWXsRiaYnNhcLFOzq61QHb/2BBm
 NeU+CNcMrUwy6GGakhgdrFo4Ry91pD6+8GjrK7FwkRz7HA/dQay5jwlbZgsRWFIHlI
 DOYnx3EGOlBTQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 12 May 2026 15:06:01 +0200
Subject: [PATCH v4 03/20] drm/atomic: Drop drm_private_obj.state assignment
 from create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-drm-mode-config-init-v4-3-591dfdcc1bf9@kernel.org>
References: <20260512-drm-mode-config-init-v4-0-591dfdcc1bf9@kernel.org>
In-Reply-To: <20260512-drm-mode-config-init-v4-0-591dfdcc1bf9@kernel.org>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1621; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8gKR8nH9fdwkklOxC1orkJLxbt3pf9ySjt3LJ0StlRk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnMqrtD1/1LyxZpaGTR47182WtKWs+JnQc33evRO2k6o
 68k+z5bx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjIvHWMDRsN2vRvsDixPdn9
 vHZC+mWOzokGDkGtd09a/IoVE3Z8M79924PTC9JNWKR+HzH+GP12K2PDHefTIQoneRL+cNVVLig
 XSC8/tfDMI9t/f2r+1QZ/KPRhNj835daVSeEyWkpen+cF768CAA==
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

The initial intent of the atomic_create_state hook was to simply
allocate a proper drm_private_state and return it, without any side
effect.

However, __drm_atomic_helper_private_obj_create_state(), which most
atomic_create_state implementations call, introduces a side effect by
setting drm_private_obj.state to the newly allocated state.

This assignment defeats the purpose, but is also redundant since
drm_atomic_private_obj_init(), the only call site for the
atomic_create_state hook, will also set this pointer to the newly
allocated state.

Drop the assignment in __drm_atomic_helper_private_obj_create_state().

Fixes: e7be39ed1716 ("drm/atomic-helper: Add private_obj atomic_create_state helper")
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index cc70508d4fdb..a82568d87e4f 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -729,12 +729,10 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_destroy_state);
 void __drm_atomic_helper_private_obj_create_state(struct drm_private_obj *obj,
 						  struct drm_private_state *state)
 {
 	if (state)
 		state->obj = obj;
-
-	obj->state = state;
 }
 EXPORT_SYMBOL(__drm_atomic_helper_private_obj_create_state);
 
 /**
  * __drm_atomic_helper_private_obj_duplicate_state - copy atomic private state

-- 
2.54.0

