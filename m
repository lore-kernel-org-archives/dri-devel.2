Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB59606A33E
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R17zM1JO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA27510EF05;
	Mon, 16 Nov 2026 10:32:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3551310EEFB
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:32:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FC2E446E6;
 Mon, 16 Nov 2026 10:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C55F1F000C5;
 Mon, 16 Nov 2026 10:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794825160;
 bh=+GDCaM+39W/xYk0KOfs9vEStjFXuHHrN6VtxV/KGx5A=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=R17zM1JOFXlUOoik7B256q95wVU7tTohLYd2QdTPwN20w+4yXIU3Pmm5YbmGNkLqk
 uDHN4GjkaEpLbX9xl3WM88lyDFhAGhrr+9abA2o2pxsA8eMtWyncFG8zuAPyOIbPQK
 ZsipEvC+42ZQGgVaHc0auP/i/+CheEnTtGU70Lk3ovu8ikObBiRXW4xtbpc+BDb8qo
 sODugMD5GNWpmpqf3Cggct6FLM5RO9zFhQspgNkm3J4RQMCWWwsNIl6d46HEnDvVpn
 bFQw9S0+5fY3WcU6xOSxbkYFVc/Al7NqL9zlv/AQDRxR/78u7Ub0YyQr0u9G8sZkpb
 MiI1D49WP38BQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 16 Nov 2026 11:30:48 +0100
Subject: [PATCH v2 32/64] drm/sprd: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-drm-no-more-config-reset-v2-32-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
In-Reply-To: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484; i=mripard@kernel.org;
 h=from:subject:message-id; bh=wYPBk+ujiu3q5tB3S/Vwf41r1gLazbSV6hZncp1mto4=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm/bvtx1GatrFTluVp2dlmA+eR8q4zAneejtxqsnjsrf
 22K6WvXjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRAi3G+gTtzjt/5vT4/Jhh
 /lTFnu0F38tDTy3SF35/qOuyxdCkc7alT8rOlNAVVWIt6Zsccl0TGRuWsws2i6/Wn/ezJl3TMNt
 snmGRqMR1gQVS4sy6i7s3tpru2/N78gaf1lms2Zv3bO6z3QwA
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

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
---
 drivers/gpu/drm/sprd/sprd_drm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index c2fd5380a834..cef022f54912 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -93,12 +93,14 @@ static int sprd_drm_bind(struct device *dev)
 	if (ret) {
 		drm_err(drm, "failed to initialize vblank.\n");
 		goto err_unbind_all;
 	}
 
-	/* reset all the states of crtc/plane/encoder/connector */
-	drm_mode_config_reset(drm);
+	/* Create the states of crtc/plane/encoder/connector */
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		goto err_unbind_all;
 
 	/* init kms poll for handling hpd */
 	drm_kms_helper_poll_init(drm);
 
 	ret = drm_dev_register(drm, 0);

-- 
2.56.1

