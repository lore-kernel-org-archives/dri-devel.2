Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0651606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oj+E3AMg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F079211289A;
	Fri, 30 Oct 2026 15:14:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26AE111289E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DCD942E64;
 Fri, 30 Oct 2026 15:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DE71F0093A;
 Fri, 30 Oct 2026 15:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373251;
 bh=lnF3aOs0mBCKLFSfviEvGmuocNk325HmzRlGQ5ON3Bc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=oj+E3AMg3O9wvcQVKniMmzRRmtzPyorrGtKPXC0IG29UT9InWnG9BI4HjKrKhUhnF
 ehBAAp/qCT6TrrA+m8jMhFv4Re6cNJBvW0+HBVZQOrEg00Qpt05WLRyt4kEoEMleX3
 BAJgAUEJsAnYy3+7P/TJxedXSh4JYrJ1PrmMeA3+JasN3LKyfl/33A4zjcckTEAaBU
 R8aRmC292O8q06tJbjS19qP4O/GSUEFFTUmNX+KoN5yEW2EJbsZKcG/YnpFrVOP4eN
 nJqzBaTka6PqzWdxmllucSJySP7CaWbsf9dnpo09UgPNL27HhTCfx7F9lswGjVEDsW
 Mr9hOC0re++Hw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:35 +0100
Subject: [PATCH v3 05/37] drm/bridge: nxp-ptn3460: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-5-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MLfpm48fDksmyi+j7h6LECLJz7aW0y74STSdWjaE958=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtshXsrhJP+71O1IafyHgvfrOG3f3nl3Db6BZbcK/T
 mVX6vvijqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRdfaMDRszr1Rt1co06jjK
 9T45qk180p4dZ6cHKuZaLRVZemuVsKCUZa/XkzWtU3w+Ma15+JPLiLE+a0rk7Kh9Qk+uJv11OPa
 sZsv6J7db919OS0x5d+K6VMrmX0qlrjMSLA8Y2Nu8t+Q/UPsZAA==
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

The bridge: nxp-ptn3460 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index f9eff8bfceb7..be6a06130ba9 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -211,5 +211,5 @@ static const struct drm_connector_funcs ptn3460_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

