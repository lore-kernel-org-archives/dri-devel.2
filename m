Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88E606A31F
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XQtI05PL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6165F1125A9;
	Thu, 22 Oct 2026 12:34:50 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D151125A7
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E076A4149F;
 Thu, 22 Oct 2026 12:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4931F1F000C1;
 Thu, 22 Oct 2026 12:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672477;
 bh=MaZpJx+Qe/72/3oMNa6zHNkc2W0kYMQAgnH7D8dXdck=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XQtI05PLwkDTvQm+b5ZXv+W4RQH6ofzBNmimwh5SYVF6aI8aOOd44i8xBUhfRXWVd
 J2iCVGd36ppyWVVZcjXQNL4dFWgEkmaC0i0p69aIJcTENftJ+oAX99ya4YlB3jeGEk
 P9v9Jg/1chjnqVwLjW8dW0Tm5sqs9faXpKevOICikv6xYAhNcoOcKNTkbEtSSgbG1A
 76x5Yj0RyU6MusZKWpJ8v0e6mheHbB3q/DTqO5XMZ/RmmTEE3wfi+NkKbGXMiCgA0a
 rfLnnrmW1qjBtWZl/ZT4I+HySVsx4Vn39rKnyfuK7IVV/fZ8yqC9D6VpWoff/BnQs/
 OmDVm6An0BvAw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:13 +0200
Subject: [PATCH v2 14/59] drm/bridge: tc358767: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-14-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1001; i=mripard@kernel.org;
 h=from:subject:message-id; bh=aU9tnOdAllgNbAZMQbuOGMrrYY65gktz9LK7WwgSGzk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mCbfNbnn8HHZjqWVh50uLf1pJ7nn+aLMq+xGoXs23
 M0Td7vG0TGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmkmzC2PBgv1hS90zmjo0+
 fwKuJm93nCguq7/uBotX4dZzmh1fq+wuaL06/W2BbrvWzE9ZO9oWXGFs6HWZW3rmyZYdq1dwCE/
 Sq1hjOuVpg+q0uXZZf0vbfugnq5icYD3hcVjxq8aGYhZ7WVZXAA==
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

The bridge: tc358767 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/tc358767.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 51f4baa62a53..5ea6d3726bee 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -1797,5 +1797,5 @@ static const struct drm_connector_funcs tc_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

