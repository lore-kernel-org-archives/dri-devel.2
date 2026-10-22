Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1E0606A324
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BK+0HED6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DC801125AC;
	Thu, 22 Oct 2026 12:35:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B98B1125AC
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E8F6D41A66;
 Thu, 22 Oct 2026 12:35:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DCA1F000C2;
 Thu, 22 Oct 2026 12:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672509;
 bh=9YBzLehkWhn3M64oh9mKNENz6T/mnMNmdSeQLi1xGrs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BK+0HED6+P9zVawOqdqzo1mKBscBYRRqxaev0cl1lP4gRlqcEGmqjsXo9fjF3Z8Fx
 Pb606SgOJBXg6KDvB//ZNXDAUS4yWE5/8wXyrQ5eItX9QO69/bKooXmHg3uhOGu2fv
 rQiLitvxdRxZu1XOUy6FG2vJxkl2jQFvxG8z1kIWaW1mhuRkc+IabHWRroGsxMs1ie
 Y0L60bNuiBt43dpI562jFITZzadZOWO+s7Z1UlvytLNlLeLINUAoPRrE/sUai0rmMm
 K0n3/rs4wyt9j66Ihn4EC8cvM0tJXFoaeHqJbOUMft+kewYvFudDTvrE/mGLFtk1el
 RlPn34sym1how==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:22 +0200
Subject: [PATCH v2 23/59] drm/mipi-dbi: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-23-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=975; i=mripard@kernel.org;
 h=from:subject:message-id; bh=t8mhbv5Zrzk9yERHNbGXZqPWVGWDKNUOMpWnKAIRKlg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mKb3euRlxqv7+ytbR+cHFt7it/n6vajw1CRW5RTdj
 7mc5h87prIwCHMyyIopsjyRCTu9vH1xlYP9yh8wc1iZQIYwcHEKwETs7jI2HKr5bbjGdPKEfoF9
 H3bfP79Nyd/bd6ey2K20O0r6n0RPah05I7p7Wuuvj/8U6u99fC7jz1hnXLhRvDdR8R6X+48H7hr
 zVTNfh0q2FxtJev37yOJad+CsOofyjroDK7oe7Z+83ePMpOMA
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

