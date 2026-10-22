Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3116606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0OkakNJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4299C11259A;
	Thu, 22 Oct 2026 12:36:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4EE11125BD
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9CDE141984;
 Thu, 22 Oct 2026 12:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1DC1F000C1;
 Thu, 22 Oct 2026 12:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672570;
 bh=Dwuc0GdzDmEV2x/rAabl4E6TjscrAf4MHvm+ODIgP/o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=W0OkakNJiQr2wbqPiuEddSP+dYXDR8+OONWDtLzeFe6HH4RFZmRjzKhoHAfpxU1RZ
 wHeAjk6EqS/zOQMkdIQrtp7dAyJv/7BC1CbGUYxYt5JD4O370ht5DVidSCtPf8WV7j
 hpzvWMXDKZ785s+4AKZ2LlM9VyMNJETf8JDFDn1oyl9pIJ0+sfyZY+rnOJz1Y8/Kg/
 Nn787tgHJ/a5kF9RjVDiqQyMx9dUJAE8u/Crm8V5qjtMcfCnMWshTZv9ccRz1vFWVe
 uW16iiX6mHjQqO4e2WLYXT89+zxKY04bfffVNPkZ+EQ6Tm9JWPVo92vBr3qPXA6Qb8
 sslHEsQkp9KlA==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:39 +0200
Subject: [PATCH v2 40/59] drm/vboxvideo: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-40-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Hans de Goede <hansg@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=mripard@kernel.org;
 h=from:subject:message-id; bh=qV+rMKeNiaATL0OEopZMe4eu7j1fPIqIAl4aOTw6jtM=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mObr6r65Mlt60i+nF98OJnP0zkhqNJJ4mf8+f17a6
 /XCSkW5HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi2hWMtcLLiuO3fOcVrTwq
 f5wvn+uh9xlbr84HUd9TX3Pe4JO5XX3Chc9r3hP9/fw30loD4o6HMDb0XvW5snIKo/W2jkphHYE
 fHbd6Lu8+virHWfq0wsGo/idz9+376ivybO+BDJULD56uEVIEAA==
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

The vboxvideo connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Hans de Goede <hansg@kernel.org>
---
 drivers/gpu/drm/vboxvideo/vbox_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index 7c34299fa531..d66dc1cbbd82 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -801,5 +801,5 @@ static const struct drm_connector_funcs vbox_connector_funcs = {
 	.fill_modes = vbox_fill_modes,
 	.destroy = vbox_connector_destroy,
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

