Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012DCCD6E54
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:03:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ADEB112846;
	Sat, 30 May 2026 14:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="heEHjAEw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4643B11283B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:03:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EFBA4376D;
 Sat, 30 May 2026 14:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB761F00899;
 Sat, 30 May 2026 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780149783;
 bh=PhWOBQWYUe/gzD7rFqwqR4Uf0ZmBqdp9Oh4zz9+bWFs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=heEHjAEwCSl7OY5/RvK9K6efS3rLFbwNJkHR+nV1lkiOlVNko0DG9Mf4uqN/4lloa
 SH8DIh8NH5bydzUy5aPTBFhxHWFGpUh6HKAnKoUraib6mckcfvdsbY7T+CLzfY2w6I
 d6+TnsJSvsZ/FxRrvBRFgMeNDxitWWXR1OWtCoNgS8RB1SifrnqcZv63HpFZivKn4X
 9T9T14D3D5hgLyuCyYj4MBnXDlvHmBqXo/nG+v9f1Tvn3AnLxrdzCi4QwiHmuQq4Yk
 EE9HDuM90CcqgH/a/l7a85eVp2BCKWV7t0nrCioUpzAS6Y+CeLQv//BIyXVG9xyuD2
 dlTGD6oy2+7oQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Sat, 30 May 2026 16:00:15 +0200
Subject: [PATCH 70/76] drm/verisilicon: Switch to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-drm-no-more-bridge-reset-v1-70-875d828d31bc@kernel.org>
References: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
In-Reply-To: <20260530-drm-no-more-bridge-reset-v1-0-875d828d31bc@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: Dmitry Baryshkov <lumag@kernel.org>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, Icenowy Zheng <zhengxingda@iscas.ac.cn>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2048; i=mripard@kernel.org;
 h=from:subject:message-id; bh=HR6rN1Q9GpU5Ki41pBzj08DLL6RH975rs8otGmtbolQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlSb0M6eg/bslZolKYtmeGrrlUeOtWVNyZC7K1pa1fpx
 JjTm2o7prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwERiwhlr+BYJX8qclLiq7r+X
 7qd7+t/MGdr/rXnL2hF47tv2itXnJhyvTt48P+5O5jOFNsUtd9cHMNYZfpl6oblY333f1kb1iXO
 3JGfrSu2WvmP09aRmyZvTR0rTtJt5b78qae21rmHOnsa4/hEA
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/verisilicon/vs_bridge.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/verisilicon/vs_bridge.c
index 7a93049368db..dc7c85b07fe3 100644
--- a/drivers/gpu/drm/verisilicon/vs_bridge.c
+++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
@@ -244,11 +244,11 @@ static const struct drm_bridge_funcs vs_dpi_bridge_funcs = {
 	.atomic_disable = vs_bridge_atomic_disable,
 	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
 	.atomic_get_output_bus_fmts = vs_bridge_atomic_get_output_bus_fmts_dpi,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static const struct drm_bridge_funcs vs_dp_bridge_funcs = {
 	.attach = vs_bridge_attach,
 	.atomic_enable = vs_bridge_atomic_enable_dp,
@@ -256,11 +256,11 @@ static const struct drm_bridge_funcs vs_dp_bridge_funcs = {
 	.atomic_check = vs_bridge_atomic_check_dp,
 	.atomic_get_input_bus_fmts = vs_bridge_atomic_get_input_bus_fmts_dp,
 	.atomic_get_output_bus_fmts = vs_bridge_atomic_get_output_bus_fmts_dp,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 };
 
 static int vs_bridge_detect_output_interface(struct device_node *of_node,
 					     unsigned int output)
 {

-- 
2.54.0

