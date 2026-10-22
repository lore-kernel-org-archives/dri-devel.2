Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C863F606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TxS0ayZP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307D11125B3;
	Thu, 22 Oct 2026 12:35:29 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7D441125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:35:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 911EF437F4;
 Thu, 22 Oct 2026 12:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF02C1F000C2;
 Thu, 22 Oct 2026 12:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672520;
 bh=6kz9JgpwV3nDMi2d90e1LyLC+ALN+e/RIzLN/BwDw6U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=TxS0ayZPQ7iSj16Es5wqguhcJiHDiqHZu3KGFHsbqJl5sNP+va+M2lyd7O+cd7OMh
 RRuxBoCqsV4MmfTDzJp4P3kTM6MNxDHz7VyPoLPf/0yycb89dI39fTn5/Sb2rzPFg1
 o/C0oOulhJHLV0J1cB2ju8b27QOzFWYIiVgUKiLRqHscTIDCHwme+hRYCJKKY/ho1W
 Ffy8+SIi9xxcnplirqtQfbKeQZpNRLOIZPJto9bFqWoBDZHZ1jXVz5Mo9aqvpa3oan
 YuR7Ub8RCFkw+5DcqCdY6Srq7nwuCeJyvKb05hCCFUNX+KVUTI5i4lRNGIUnS7sof1
 ig1DY5xLuLmhw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:25 +0200
Subject: [PATCH v2 26/59] drm/sitronix: st7571: Switch to
 drm_atomic_helper_connector_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-26-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=mripard@kernel.org;
 h=from:subject:message-id; bh=7uWsDaytMnAwefbf0B4qGOPMCFgVQOuKGmbYfO/zW+s=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mGZsK2ZvzHu/evW7882SezivF9oeNjMQa1E+Hn23J
 2JX1WXnjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRPxKMDXe282kUrOx2n3VG
 fk3SgYNSB4qORy6+sHHzzFPfHijUbHZZu3ya+q55E6s4Arb8Enh2IZ6x4Wm36zzlC1XyAif6p3D
 /4bbb8UBDv1CQXezTOfspF9w/un+pO+U/4aWHZUhE1dV9WUccAA==
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

The sitronix: st7571 connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/gpu/drm/sitronix/st7571.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix/st7571.c
index 5e60c4685671..608d38eab0fc 100644
--- a/drivers/gpu/drm/sitronix/st7571.c
+++ b/drivers/gpu/drm/sitronix/st7571.c
@@ -476,7 +476,7 @@ static const struct drm_encoder_helper_funcs st7571_encoder_helper_funcs = {
 
 static const struct drm_connector_funcs st7571_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,

-- 
2.55.0

