Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01DC606A885
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRYDWBSa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E46F710EEF9;
	Mon, 16 Nov 2026 10:32:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 552CF10EE50
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D20040AEF;
 Mon, 16 Nov 2026 10:32:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A9E1F000C7;
 Mon, 16 Nov 2026 10:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825141;
 bh=XAJwt4YfHM1QBg18GoEs/a6MkRO/9asrmTnjYHxU5q0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=lRYDWBSaFqAdsQOZQPhNFdViFMnjIWXEOb6nB7ze0m85Lh4P4tXLKmVY9Pvp2tVN1
 RkIx8B+Ynk3XM88hzzm3JaAnBXGq5Db1c14vsvMjft3Fsxaw6/0mDtfFwGzuEnCvIO
 1cuO3PXM8q7Hs9DpzaxvmWbiQsplZJYjGqMjB4TFkup4FjmqjNtCPiCsWFHr/GL4rF
 65eqS7bWw/wx8nOzQwPLftAsipNX7+xQTTPGxE7KJX/FHqM//wTiQ4+jYO7DBDu8SL
 0MvpGN+yy4k9g0i0r5dBTe+WRFscrY1RDF4FuxqUYUFEkW8jy/sL+SUJFmr9a3FBW3
 FaiRBqtQ7rOpw==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:42 +0100
Subject: [PATCH v2 26/64] drm/rz-du: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-26-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399; i=mripard@kernel.org;
 h=from:subject:message-id; bh=3vL7MQtn8a2/F2wH/4VzddnIz5viJ05pIXR8WHpdLQs=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bnv7LFsu9TJG9abyx7STNm5rNLc8a33QsbbrtFb+4
 wUJT/lXdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJLEtibPjdVbRDoOyHPAvj
 AqMT9fW1ek5JEumzt34J+O6UP3PhDesm3f/vvrpd0JvtfWRhWZvhOsY6tf7yO0WXvBSrpNuWPd6
 3Mr1+rf6P8h7tz/cYD1Q0SJsYMhl0vpH1OyJ38+6B58zsD4IB
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

drm_mode_config_reset() has a dual role: it creates the initial KMS
state at probe time, and resets hardware and software state during
suspend/resume cycles.

Since the two roles need different behaviors (notably for objects like
drm_private_obj that must persist across suspend/resume),
drm_mode_config_create_initial_state() was introduced to handle only
the initial state creation at probe time.

Switch to drm_mode_config_create_initial_state().

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
index 87f171145a23..07171f2f3052 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c
@@ -469,11 +469,13 @@ int rzg2l_du_modeset_init(struct rzg2l_du_device *rcdu)
 
 		encoder->possible_crtcs = route->possible_outputs;
 		encoder->possible_clones = (1 << num_encoders) - 1;
 	}
 
-	drm_mode_config_reset(dev);
+	ret = drm_mode_config_create_initial_state(dev);
+	if (ret)
+		return ret;
 
 	drm_kms_helper_poll_init(dev);
 
 	return 0;
 }

-- 
2.56.1

