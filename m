Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9EC606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZDa195X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAC181125BF;
	Thu, 22 Oct 2026 12:36:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5CA1125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5295060200;
 Thu, 22 Oct 2026 12:36:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804FF1F000C1;
 Thu, 22 Oct 2026 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672560;
 bh=r5W1K6C/rG9S9/2zGPEUS+4G6FAZgmNq9ZO/wtqh/P0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gZDa195X38XZWqFv7MzSPFBF5AuapJyyPtFFAcEzKwL5aBseb3lMQf9xTcOCwBLSx
 pkjHoGYPEfzYADvqzHYv1VOw/v2TNBpWR7jn8jMZZV8TIEXfUQzSy2wHuI7qVsb/Ls
 eElerbeXLqyUGHU8ljNWwYgs8uAU4gQxMy2NHpqdUNIAdfy/cqiHoOCL6Fov3614by
 K+onqDZnOqC+rLfN3S90Mzz5annjOyxzomQy6ZM7FjhoAxTL3OFsQOo6DtBS/XjqEM
 vbSnbrB04IfEo77az0Lhid1Q2mYrP72zIKm+4hfmaYKI0vxhIUD9c/LaRw1O/XmyNi
 UwcIfB87foZWA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:36 +0200
Subject: [PATCH v2 37/59] drm/tiny: repaper: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-37-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=mripard@kernel.org;
 h=from:subject:message-id; bh=UFz5Aqhl8f+yz1reLrwu9CxhMldpv/m7UKMQO2OA3+w=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOYWMGU/N/qwJOzvopYAx9ZPt+5O+ddQmJnBnCHXf
 69d+d7OjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR6EDGhtfLV/3SOrEmzXmu
 23Hrku1TM9a12JR6ND764b7hk4bnvR9/eU238vCzysbfiJ3DklKuwNjQoV8m23nz2sPnh6IWPXG
 bwFbcPuXguxeOTPffz0lby7Nkwo0TWheE1q1fxvtJbWH5pKy/AA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tiny: repaper connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Alex Lanzano <lanzano.alex@gmail.com>
---
 drivers/gpu/drm/tiny/repaper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 82c99d86656f..25e6a7a4affc 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -927,7 +927,7 @@ static const struct drm_connector_helper_funcs repaper_connector_hfuncs = {
 
 static const struct drm_connector_funcs repaper_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

