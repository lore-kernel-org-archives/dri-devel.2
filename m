Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0983CCD6E40
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:46:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FC910E6D3;
	Tue, 26 May 2026 16:46:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XOT+tD2v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BDD10E6CB;
 Tue, 26 May 2026 16:46:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00EAB40759;
 Tue, 26 May 2026 16:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C5E1F000E9;
 Tue, 26 May 2026 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779813991;
 bh=LuESLJP6Mjmw0qBQu/ftP2J1IXOJsizO90ATRcETkqk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XOT+tD2vVPvQ5PnxSN8VsXf/pegtvu0v6JlZ02k+ZDy1swGkMHDP4xzkfjrCV4wig
 f9SwuZkm7yZMa4gljDIvUFLDXsAn29CBcZCup94WCKYx9cOibBhp3Zf2Apw28fkXef
 bsQkul3dNm8RXR3kgTswR9/Juu2ydAK1phjEeKVG7lfaqadiqHkRIGRemNMHhzsBUr
 2g3EYCqmRdCqHPAeFEE0OUgbw7ko2NuqVmIlrRBk0krWQ1SOoxZ6/ogvUrwINLXz+E
 tM2sPbUzNVQmiPBpfcO6I6d+XfHOrhlNxsv/cH0aFI6oJtF50W3wz3/M87W7Na89gY
 M4Bn77ChddHGg==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 26 May 2026 18:46:14 +0200
Subject: [PATCH v6 02/19] drm/colorop: Fix typos in the doc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-drm-mode-config-init-v6-2-852346394200@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2369; i=mripard@kernel.org;
 h=from:subject:message-id; bh=JdNElNwTIUBx+lfJsjS2BzsCplWERmeATaICya7vgAQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmi58Izc4SXmyovSj/BvGXmPK2jF24vEFm6csnZ+JWzM
 oL23jjzs2MqC4MwJ4OsmCLLE5mw08vbF1c52K/8ATOHlQlkCAMXpwBMRP8gY526w5on054+T1r0
 IbGlsmxWzuFJchoOf59fO2E4c4+gXiubqXVz+qNq9nOn/3zgOt288ANjDaek9+ojao4rbaJzHP3
 +Ss0u3c7g69pS5ea48cCivJa4B/uvSD8y/hnaXnuqev/uyX5WAA==
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

In the documentation of drm_colorop introduced by commit cfc27680ee20
("drm/colorop: Introduce new drm_colorop mode object"), the
documentation of __drm_colorop_state_reset() and __drm_colorop_reset()
were mentioning CRTC when they really meant colorop, probably due to
copy and paste.

Fixes: cfc27680ee20 ("drm/colorop: Introduce new drm_colorop mode object")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_colorop.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 764d12060666..48d0b7ae3fc9 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -503,11 +503,11 @@ void drm_colorop_atomic_destroy_state(struct drm_colorop *colorop,
  * __drm_colorop_state_reset - resets colorop state to default values
  * @colorop_state: atomic colorop state, must not be NULL
  * @colorop: colorop object, must not be NULL
  *
  * Initializes the newly allocated @colorop_state with default
- * values. This is useful for drivers that subclass the CRTC state.
+ * values. This is useful for drivers that subclass the colorop state.
  */
 static void __drm_colorop_state_reset(struct drm_colorop_state *colorop_state,
 				      struct drm_colorop *colorop)
 {
 	u64 val;
@@ -526,14 +526,14 @@ static void __drm_colorop_state_reset(struct drm_colorop_state *colorop_state,
 /**
  * __drm_colorop_reset - reset state on colorop
  * @colorop: drm colorop
  * @colorop_state: colorop state to assign
  *
- * Initializes the newly allocated @colorop_state and assigns it to
- * the &drm_crtc->state pointer of @colorop, usually required when
- * initializing the drivers or when called from the &drm_colorop_funcs.reset
- * hook.
+ * Initializes the newly allocated @colorop_state and assigns it to the
+ * &drm_colorop->state pointer of @colorop, usually required when
+ * initializing the drivers or when called from the
+ * &drm_colorop_funcs.reset hook.
  *
  * This is useful for drivers that subclass the colorop state.
  */
 static void __drm_colorop_reset(struct drm_colorop *colorop,
 				struct drm_colorop_state *colorop_state)

-- 
2.54.0

