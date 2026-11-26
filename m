Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1B606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=C87gxbT1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C24A11281F;
	Fri, 27 Nov 2026 08:29:10 +0000 (UTC)
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FCA610E145
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:24:29 +0000 (UTC)
Received: from [169.254.254.254] (localhost [127.0.0.1])
 by smtp.ideco.ru (Postfix) with ESMTP id 2D3312032496;
 Thu, 26 Nov 2026 13:24:28 +0500 (+05)
Received: from fedora (5cfcd9fa.dynamic.mv.ru [92.252.217.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp.ideco.ru (Postfix) with ESMTPSA id 5D043203679C;
 Thu, 26 Nov 2026 13:16:27 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru 5D043203679C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
 t=1795680989; bh=0kvkohFIVoj8f2Me/6uzQ3sWm8aGGRnxnWLHr2+eero=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C87gxbT1P8Tf0TAGi7G71ijMpY+k1lmzdFcGQBS4vFdVsN8AQQC+Tv4nnmbUCazUY
 WhTRJiUfWyv/O1CFZ5DSEOoSXomaanM7Nl0jgjRM8WFp/ZP2knbPDomDw/oMuPfOui
 DJc3GqXqklpe1C6RsnbEXOLAO2Wa6kodS/hQ68t9q86kQ/+QW8YknfU2BAyL6Llvf5
 gb6IoF/1gei3gxFlmy/cljPnWMf1ZSKN+3RN082Go0ioqneATWhtz3WgoSvdWw+t8c
 bmgErIgMsmt50LgHii0lOkkhmDTHl/TG38RBseGDCsfyaQCYM/ZeMbCCbP6A7sOtq6
 PsMhfxg7YiknQ==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Emil Velikov <emil.velikov@collabora.com>,
 Oleg Vasilev <oleg.vasilev@intel.com>, Jeevan B <jeevan.b@intel.com>,
 dri-devel@lists.freedesktop.org, lvc-project@linuxtesting.org,
 stable@vger.kernel.org
Subject: [PATCH 1/5] drm/connector: Check DP subconnector property before
 attaching it
Date: Thu, 26 Nov 2026 12:15:56 +0400
Message-ID: <20261126081602.2901498-2-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
References: <20261126081602.2901498-1-a.kazinsky@ideco.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_property_create_enum() can return NULL on allocation failure.
Passing this pointer to drm_object_attach_property() causes a NULL
pointer dereference during DP connector initialization.

Attach the DP subconnector property only if it was created successfully.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Fixes: e5b92773287c ("drm: report dp downstream port type as a subconnector property")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 drivers/gpu/drm/drm_connector.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 893716a9e489..41cbd76e0b1c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -2106,9 +2106,10 @@ void drm_connector_attach_dp_subconnector_property(struct drm_connector *connect
 				drm_dp_subconnector_enum_list,
 				ARRAY_SIZE(drm_dp_subconnector_enum_list));
 
-	drm_object_attach_property(&connector->base,
-				   mode_config->dp_subconnector_property,
-				   DRM_MODE_SUBCONNECTOR_Unknown);
+	if (mode_config->dp_subconnector_property)
+		drm_object_attach_property(&connector->base,
+					   mode_config->dp_subconnector_property,
+					   DRM_MODE_SUBCONNECTOR_Unknown);
 }
 EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
 
-- 
2.56.0


