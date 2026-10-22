Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9DB606A329
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U7r9f0XE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CBBE1125B1;
	Thu, 22 Oct 2026 12:35:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2ED51125B1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4731860200;
 Thu, 22 Oct 2026 12:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5BB1F000C2;
 Thu, 22 Oct 2026 12:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672524;
 bh=B9MFHKqg/8FY8eG4hBaIhbEeB+qcBkdHLw0UuZFE4G0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=U7r9f0XEU9Cv7GRY/re9MpGtscQEyHarFEBA0AB0p0AoVlffjB54TamtICY9qYec5
 kAU17CIFpk423UqhRteZ2g3HtzEIZENhVegDrRxVb5SAWsiL/dakT3dgDOvAty2ghA
 DlYxXSPJ7s4IXCZU22SBB+EPBdcpdp8mAB4stfEtp8/3yztZqjRegGyjda9csCm4Q6
 cQUUNN3q3tI9wyAd8xjBr7/HIHGJiCJQ9TW1S4Clu/M4bFDef8jxltb10uCKSfWS4j
 tXnwtq7bouklKQxo7EBPu0r7LTtsbVlKoBd8yIqutrG6YbvMxaStulbksDLs1J9pCc
 Z82spkocyExpw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:26 +0200
Subject: [PATCH v2 27/59] drm/sitronix: st7920: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-27-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1189; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ug6S3pKuSyA9fXGUF/JW+Pn6xL4cKhVOQQDb3iH0iPM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGbaKbYFP9p9i9d+v/zNCFWHvmdbbLUaas5+MApyN
 mR6JlPWMZWFQZiTQVZMkeWJTNjp5e2LqxzsV/6AmcPKBDKEgYtTACZic5Gx4StL10+bF2L9E6ts
 1wjv9T0c09Cr/f3Ps/4pzwxqZ1afqX/058+tVTenSVreYr52dmrWD8b69K6eh2nb3pRmW0ecSH/
 26vnVY4t7w1+I/HrMm7uN++qKQ75XnA67xVQxLZo6y9NSUvYEAA==
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

The sitronix: st7920 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 drivers/gpu/drm/sitronix/st7920.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 9887ed746ceb..2f2c808e783b 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -654,7 +654,7 @@ static const struct drm_connector_helper_funcs st7920_connector_helper_funcs = {
 
 static const struct drm_connector_funcs st7920_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

