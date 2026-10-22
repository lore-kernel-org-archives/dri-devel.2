Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6734606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OqzIR/TJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E17711125C4;
	Thu, 22 Oct 2026 12:36:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B6FA1125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9440D60200;
 Thu, 22 Oct 2026 12:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AD31F000C1;
 Thu, 22 Oct 2026 12:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672581;
 bh=mHtVHxe6Z1Xdik3nhWNHfeMUJ65jLjAZaYUYjtYFPJM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=OqzIR/TJtz0pL/0D8xrA0aj941ckdT/G8Lu88DCuNwGspjcgNQ2XsdHUvzIVi1Ykt
 N2ATbzUmkF5xjEQvwJRGFoAoGZRdlo8/d3nTxXBUExXVGatOP7GhidtbZ6Xe+2IAQn
 PqqY29DCSGqK3hSPjC9drSoNr7pgPKzCtOWrQO0aOfPvjUqQmFdVdBDJYvDG0UMC/w
 8yWZNUU6W0pi8jhLogKkv8lIFLgL8/q+lJ92U2e55sN2LCsDMeBUKbL9DVD+LuJk9T
 64rsiDQv/tJfITqq50FYURSvFI0YHCnhVL5HKI98uBYC/QyP7lBhGD96mAn+0e1rcW
 5iySW2gX8k0mw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:42 +0200
Subject: [PATCH v2 43/59] drm/xen: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-43-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085; i=mripard@kernel.org;
 h=from:subject:message-id; bh=rQQumCgtItEC5Q/YVE2UcrHb25p3g/4WTrk2HY/k5i4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBZY37otX/+a/dCH+RMdjsh/4j5QueTkwzAXhcfhU
 sWrs5T7OqayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEpgcwNiy1dNuq+tT9psLj
 1nTJTL7Q9Mw1u1YslX35nqN+gdzruc4XVe9FCO4/LGzdbBN4U+b0GsY62x8z1r/oXvohJjP+4RZ
 Fg4+Ldh/wrTNbVy18+WOI0dZ9Hx6sOfFlndnRhhMLjZ+m51nHAAA=
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

The xen connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/gpu/drm/xen/xen_drm_front_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_conn.c b/drivers/gpu/drm/xen/xen_drm_front_conn.c
index a1ba6d3d0568..8ceac0947be2 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_conn.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_conn.c
@@ -95,5 +95,5 @@ static const struct drm_connector_funcs connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

