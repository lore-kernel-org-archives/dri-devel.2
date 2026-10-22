Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC82606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UeAE8f3Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0ED41125A4;
	Thu, 22 Oct 2026 12:35:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 703941125A4
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:34:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 593D641A86;
 Thu, 22 Oct 2026 12:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B754F1F000C2;
 Thu, 22 Oct 2026 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672499;
 bh=JLXWi+ZCWXkM5wvuZ1E8CfdtnMQADzoF5JcJV/fV6ME=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=UeAE8f3YkkOT7YLVSR2ThOPzh0wqnpaqfMshwC18835jWBSdlx2mB4LEw//NrV7ts
 z8ROHKjhdYsbqJFrAI4IF1l6MClgfSh/et+cP6VHteucYjBbUIbKg8ATs/QjcCEIvC
 mo4ki5SdJHU/i19f6bx6pYFyxYJ4+OX6pSVBFO1ZdA2WnoF7OB6+uCRfKx7BQTsbRx
 8Q6NOGpWl+fXMzA/7vdiTakDPCAXopMAd8pjMNNQqlAcgWV0TlM05nicIhQlk08AK0
 toCmkv8Z2I4VfLN5kwvxXGEKTXWU0NBS9JvknJIw1m9eheLydy1aoVsp8C5Qk4E3Ud
 SwfIisJP1oNxQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:19 +0200
Subject: [PATCH v2 20/59] drm/logicvc: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-20-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Paul Kocialkowski <paulk@sys-base.io>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=mripard@kernel.org;
 h=from:subject:message-id; bh=FJI80b2dsQrZdnNDLROTHbwq7NMSAK+tDWa/9hgUSSQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mKbtbsq5cqBCaMnDP9MyfeyCzrda8Ybdau0W2taya
 EHy/oCsjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCR8jTGhgVX9h/37v23SV1D
 7222FfNdyeYte/R4Uq/LXftvZBRnq/r+h26z1av74usWPA2t6Kz8xlhf9LPidfY1H+4t39X5Ljr
 uStX92/mDy91R19tuztcric0lzD9enrvI2F5+1MTDrFVNSw4A
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

The logicvc connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/gpu/drm/logicvc/logicvc_interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/drm/logicvc/logicvc_interface.c
index 81f760dc07f8..32c0ee6226c9 100644
--- a/drivers/gpu/drm/logicvc/logicvc_interface.c
+++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
@@ -88,7 +88,7 @@ static const struct drm_connector_helper_funcs logicvc_connector_helper_funcs =
 
 static const struct drm_connector_funcs logicvc_connector_funcs = {
-	.reset			= drm_atomic_helper_connector_reset,
 	.fill_modes		= drm_helper_probe_single_connector_modes,
 	.destroy		= drm_connector_cleanup,
+	.atomic_create_state	= drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state	= drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

