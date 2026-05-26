Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122C4CD6E40
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:46:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C26710E6F4;
	Tue, 26 May 2026 16:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HDOdftTZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F56210E6F2;
 Tue, 26 May 2026 16:46:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 035D140460;
 Tue, 26 May 2026 16:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3495F1F000E9;
 Tue, 26 May 2026 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779814008;
 bh=/cKXnzyrX5lutQ6EZwTcZY3rLV03+GZQqQU++EjnDVU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=HDOdftTZPvS7pfLNptRkGlwz1VGENy4v8sAEwT5F0F0rKQTmU/D2bqj9DXwVqN/Kb
 GmQaWH9Oy0WDDMVIc+CWPcREa8dAjEU4E0cn154CkEDJQ73UmhDWugEPjUV8kOBugq
 WbaigteXeh7UAYVhRCopE7TWEF8X0WDMDuu+1clw2qIH/+Oei6X4VaS9JfCp4Ykwys
 /pzOShzCr23UW2IO9ACobV70WTI3bVVJ6GcH6xXPeeAUOqhnFOtnnoI6Wid3NveCpL
 ggUuXEck0xu64Mq8nP6ZkoBCmSExg3AL0ZLzVubGBFpOwwnlqvDgND0r3iqk93vbDh
 UdhNZLSlefd9Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 May 2026 18:46:20 +0200
Subject: [PATCH v6 08/19] drm/atomic-state-helper: Fix
 __drm_atomic_helper_plane_reset() doc typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-drm-mode-config-init-v6-8-852346394200@kernel.org>
References: <20260526-drm-mode-config-init-v6-0-852346394200@kernel.org>
In-Reply-To: <20260526-drm-mode-config-init-v6-0-852346394200@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1365; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3P/ZjAcLUex4P3oNpd5Z+isOTz0WG4WoSqpftWEhPh8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmi56I0ZTf4PJ+qtET3HceDSRs8g85M59nPzOl8xEVDV
 7xHOc6uYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzk81/GOv3z4b/tqky+h3a7
 nIia4PbQ/NG2OK9X+7SqPOMu/77lMevlRMvL6XOmnbXlNRMpqe/lZWxo9vM/vatYb59NlFVp6nr
 ezsv901ZtivxkZfJCKaEievHZQzY3W25H3ZdpuD6rJzOfuRcA
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

A typo has slipped through in the __drm_atomic_helper_plane_reset()
documentation, probably due to copy and paste. It will not assign
drm_crtc state pointer, but rather the drm_plane's.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index a82568d87e4f..c8ccf8be5074 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -303,11 +303,11 @@ EXPORT_SYMBOL(__drm_atomic_helper_plane_state_reset);
  * __drm_atomic_helper_plane_reset - reset state on plane
  * @plane: drm plane
  * @plane_state: plane state to assign
  *
  * Initializes the newly allocated @plane_state and assigns it to
- * the &drm_crtc->state pointer of @plane, usually required when
+ * the &drm_plane->state pointer of @plane, usually required when
  * initializing the drivers or when called from the &drm_plane_funcs.reset
  * hook.
  *
  * This is useful for drivers that subclass the plane state.
  */

-- 
2.54.0

