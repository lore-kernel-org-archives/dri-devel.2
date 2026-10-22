Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B082606A322
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Scs+bHbH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D9E1125B6;
	Thu, 22 Oct 2026 12:35:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D211125AF;
 Thu, 22 Oct 2026 12:35:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F64460A89;
 Thu, 22 Oct 2026 12:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D132D1F000C3;
 Thu, 22 Oct 2026 12:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672513;
 bh=+0LuoyrNY2M2xNAxNIEv1eNUof956wGD4Lw0YLoA+0E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Scs+bHbHWxV53tobel3lG4QDjCvIPX1Gg+YBcTq+nmvsV/Iq3ra6yXkTdmNywsLYT
 Oo9UekTRyvhPLa1xf0qgiwThJhyVAb0UOr5AaLqVbKkrpZh37RhWwiFQ9mCaAlCkj3
 GgqD3k9kgVZYFhwAwytdSdRSv28RtAu4rYcT+44VEXUwSLXqEXmU7IQiGeyiHZqyrS
 /EXsKdesg95Uzgtj0RXcd2eHbxdyZqg+uGGl8w0by+F6UlYLoNMl9ZV3E0w70b9Clg
 z2zYhG9TxhSBXdw+syn+iL0J5VE1wBKxrpKB4pL7OQDkF3btt0kCpIfeyj9SLw7zXE
 iP22kURrGeKmA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:23 +0200
Subject: [PATCH v2 24/59] drm/qxl: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-24-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 spice-devel@lists.freedesktop.org, virtualization@lists.linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1195; i=mripard@kernel.org;
 h=from:subject:message-id; bh=sA7bucIT/41HYFCGwypCIgGH4JQh0Qt8z/YGI32/ZB8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGb0nZx6ff7pA/ECXkouey7qit9e1rxoTt1K0RU12
 VOCTnKu7ZjKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQAT6bnI2PCH4WlBQ9Pcu8lm
 F9RNcjyKj9XKKgU2s4baHC5/9VUs4XCk6r/N4Rs8T/l5hV8QWLejkbE+psal/aR255JjvN57uK/
 O9y019nS/yOvnrGya/cm2e2vO3F9T93jkmfAVS/ldbzt04xUA
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

The qxl connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org
Cc: virtualization@lists.linux.dev
---
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 63fc7c6a7f1a..204c47d61373 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -1142,5 +1142,5 @@ static const struct drm_connector_funcs qxl_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = qxl_conn_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

