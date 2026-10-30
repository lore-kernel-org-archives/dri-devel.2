Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4878C606A320
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUVotT64
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 837971128BA;
	Fri, 30 Oct 2026 15:14:56 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A40E11289F
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:14:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C3320601EE;
 Fri, 30 Oct 2026 15:14:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29B61F000C1;
 Fri, 30 Oct 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373284;
 bh=9YBzLehkWhn3M64oh9mKNENz6T/mnMNmdSeQLi1xGrs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FUVotT64v+Zr46ttSEA3fsGBXjMMruG0UHIheCHNKhHeyKhIrhGJeO44Gk71n+Vyb
 kmJIVA0tWxF7g2raBpdqElm0/nxH9ai67lYCcKh4jxW29KApCVD3EUUHa4dHFLlnJl
 K6dMifRDK5CWpFZpJPUr5CQWo35CvB1lB4cAm5wTYDfk5SfT6bRmVouMhbn8x9/kh7
 RCYvmqy7IjtTkXyL5Y0uG+nf63UsK5YXL6ny7rxPbaZKtLsSlZgZUtRM3cDVaNy1+F
 +s9jVccDPvrNT93XZAXmfdqkccrx1kFpftr52U+qqk9B/DroydENxOiNGbbFwn18fU
 taR5SWRxTMeTA==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:44 +0100
Subject: [PATCH v3 14/37] drm/mipi-dbi: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-14-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=mripard@kernel.org;
 h=from:subject:message-id; bh=t8mhbv5Zrzk9yERHNbGXZqPWVGWDKNUOMpWnKAIRKlg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtignV9vpPVc5XsmwOaDX0mU/z/krwtOVXz0JFPh+n
 kmp+syZjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjAR90bGhp/ce0rDVx8yndF5
 y/Ke3LrZD0+wFqhfS1pTPcVpbprI5xPbD0atF0ru0VvK7pi9MHnHDMaGP0+eHuyev1JRrOyCx3T
 v6C+xkRut5zhtCUzJmsdd6vRk5o/0QmXFvPBdn3xePpHJ/GMHAA==
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

The mipi-dbi connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_mipi_dbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index d93e25fdc2e1..bb3296419910 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -258,6 +258,6 @@ void drm_mipi_dbi_crtc_helper_atomic_disable(struct drm_crtc *crtc,
 
 #define DRM_MIPI_DBI_CONNECTOR_FUNCS \
-	.reset = drm_atomic_helper_connector_reset, \
 	.fill_modes = drm_helper_probe_single_connector_modes, \
+	.atomic_create_state = drm_atomic_helper_connector_create_state, \
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state, \
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state

-- 
2.55.0

