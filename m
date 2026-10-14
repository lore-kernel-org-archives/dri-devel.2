Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56195C3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A149310FEE6;
	Wed, 14 Oct 2026 17:29:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D57710FECC
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2692C412F0;
 Wed, 14 Oct 2026 17:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852171F000C4;
 Wed, 14 Oct 2026 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998992;
 bh=jT9wZYNzhYW9hE7CCRQJYIUuYN0T5s8pVemrG8Vi1L4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=NHcI5XGvrRlqAUf4XdflLpqRjEueKuYfE/HGoMe2CmTOGl9NtpzsRA4RY8LGYPEm8
 RrQhcC//jVX8iyZSOxHcN1+NeS0A+5eSxKNKQcxTStX74oRmByO0DLPfxtygqQNCHm
 zOR4qjwY/LmkfnpETlgvOocdKkkI+fK1wPxemro7I8nW2iDIKc4uOI9G8emBATxi/f
 6Q5Uem6elyZLWHHF4MSV6c6KCnRAQ5bx2WJ1mxLqpCqE53Wzi/tP5/WWCPNo5htaBj
 lvN8qZ/VlYeS66VanEC/u9P88LiDEItDs5RVf2syuhUA9lQabZ50+QefUQ7br/c04R
 29TfjUmqQx/EA==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:27:07 +0200
Subject: [PATCH 44/75] drm/tiny: cirrus: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-44-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=mripard@kernel.org;
 h=from:subject:message-id; bh=f1MTrqWhtx/O+ufSaS7ufzMqffILm6+Ds2swPNaq1Cc=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd8du8zcMb5xbbf+ipWVxtoNKjR5n8OtrER0mOZ1Le
 FfGTPLpmMrCIMzJICumyPJEJuz08vbFVQ72K3/AzGFlAhnCwMUpABNxecPYMOeeaJ9BjEaE3if9
 JbNPLDnPVNZrYt9/PXh/SNvSZ0n7ctv/+CuKunD0iZTVX/Nv4dRnrE994pQ8R7shkKvz0rvaiqU
 uWx4cmXp5h+evU5/iAvIflOdOMMgSre/zbz/UVaVru3jfNwA=
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

The tiny: cirrus connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

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
@@ -448,11 +448,11 @@ static const struct drm_connector_helper_funcs cirrus_connector_helper_funcs = {
 };
 
 static const struct drm_connector_funcs cirrus_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int cirrus_pipe_init(struct cirrus_device *cirrus)

-- 
2.55.0

