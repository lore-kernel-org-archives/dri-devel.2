Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420C7CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:28:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B95010F5B9;
	Fri, 19 Jun 2026 12:28:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KffM32uJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86E3B10F5AC
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:27:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D7CE434C3;
 Fri, 19 Jun 2026 12:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE791F00AC4;
 Fri, 19 Jun 2026 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781872075;
 bh=lA1CPccc4IzDk6F9dgYJnV0WcWYn8rPddYN09zLC59s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=KffM32uJ+hf0nfEc0hOZWgtPexe0Aao/2T8t65CI4+ehvghupXNRgTRpKvr4/Tzkr
 OUXWn7V+h8jonXTHDQqM1/H+apeLrCBUAiDGY5cVkR88ioqS1IOqNIEHSNNKYgsRZc
 J5GEo67HsIci418xXsVWkKYfiYH7HukK9YCHVRoZA25fFolaxgVyECGiHUEYJ7D0Ql
 dzOi+/wJqUa8x7AIbUXShfgvB2jUWbh+eE5jFtJVvEoiB79zWEC+bakOG/5LfjFr+d
 GneIfGxShTKhDPpBimjbgbkP8H6Jy0a2LKMlpXtMPpTuEc63rfoRr4vgNTR3kL85Mu
 w0QUa6SDfECUA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 19 Jun 2026 14:25:15 +0200
Subject: [PATCH v3 70/78] drm/tidss: oldi: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-drm-no-more-bridge-reset-v3-70-ff399263111b@kernel.org>
References: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
In-Reply-To: <20260619-drm-no-more-bridge-reset-v3-0-ff399263111b@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1438; i=mripard@kernel.org;
 h=from:subject:message-id; bh=du9GkspUEYiNb8CcsKdSJ0Jsiucp/DI3PQhUOJ7+JKk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmmphzeXJ9Fgg0fy81qV467ffrt6afT9kXwiPhYm61Va
 YlarcraMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACbyehtjw9Xazj0vvEQMeBq9
 dycmia/s+7Vppt2s+uleVQe6a4rNVu/5Et70yT74l4L4c60rD4N0GeuTfr0P7vBZLjXFVjVtoun
 hyin/J04srv95/aDYl48BEne1DBeziX90j45/eNbdnuuh2AEA
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

The drm_bridge_funcs.atomic_reset callback and its
drm_atomic_helper_bridge_reset() helper are deprecated.

Switch to the atomic_create_state callback and its
drm_atomic_helper_bridge_create_state() counterpart.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
To: Jyri Sarha <jyri.sarha@iki.fi>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/tidss/tidss_oldi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tidss/tidss_oldi.c b/drivers/gpu/drm/tidss/tidss_oldi.c
index 9c9725aac829..5eb749f495d5 100644
--- a/drivers/gpu/drm/tidss/tidss_oldi.c
+++ b/drivers/gpu/drm/tidss/tidss_oldi.c
@@ -333,11 +333,11 @@ static const struct drm_bridge_funcs tidss_oldi_bridge_funcs = {
 	.atomic_pre_enable = tidss_oldi_atomic_pre_enable,
 	.atomic_post_disable = tidss_oldi_atomic_post_disable,
 	.atomic_get_input_bus_fmts = tidss_oldi_atomic_get_input_bus_fmts,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.mode_valid = tidss_oldi_mode_valid,
 };
 
 static int get_oldi_mode(struct device_node *oldi_tx, int *companion_instance)
 {

-- 
2.54.0

