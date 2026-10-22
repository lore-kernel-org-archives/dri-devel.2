Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D7606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxM9IMcO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6F9D1125BB;
	Thu, 22 Oct 2026 12:35:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 746B91125B2
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D69742446;
 Thu, 22 Oct 2026 12:35:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B387F1F000C1;
 Thu, 22 Oct 2026 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672549;
 bh=M/Ejr6jZmsNkQJvBJrviI9RjCHIkd8k5n/e+qs9q3yI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=fxM9IMcOvW/P5dOvhN/mLka9mq6qjRgF6v2v+yAYsebDgEutZYzBJSfVYfeK1Rgsh
 w6mLDfKfM00C3qoZwAz8mPOyzOFpwQB9ilXwKVGVbVuUmvsyMWsY8OtmYkFgpm7/O6
 n8oD+yH73VOUf31Hb2+S8tcs4vJoqYRtx2nZu9z3m41V4da6L67BPST699b1hX4k5m
 gVFH3NydMdsuVLjz96IMUatd5NUm7aI1OVOBR3tPCkxDbEN/H0W8l/AwKny7gAomVw
 SS9z3MP4Pal9w/x2QG/1a2oOscdj2ID0KmDlno1cHBwIktYOZC/gLUMlt4wM33YtGG
 wi8Ma8QJ6DZow==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:33 +0200
Subject: [PATCH v2 34/59] drm/tiny: cirrus: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-34-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1176; i=mripard@kernel.org;
 h=from:subject:message-id; bh=D3XE86b8xjYf5OXrtEhX3Rm4gnpwQoQaWjge25eOHTo=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mOZsfJtmKFiYIb7b4IvF7mBeXbY6lgN1Bfpya7yuu
 27KtufpmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABO5foCxvnLTTlH+PL9MKesg
 XlXdTm+9DWUrcuedT+6WveF/YMnb58vZTSfVdLyeE2u1d1F0a3InYzXb8tRPO1J4mzy2666Tsnu
 a0O+ZvvPN2ydb5ji9WZ2yyuPQ8zsbJ3lXdnROq1GteRvN3w4A
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The tiny: cirrus connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 63c242e25662..9e3051b9c3f7 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -451,5 +451,5 @@ static const struct drm_connector_funcs cirrus_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

