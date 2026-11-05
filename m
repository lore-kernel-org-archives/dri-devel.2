Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BC6606D804
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f5v+7aDu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E60112760;
	Thu,  5 Nov 2026 15:31:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EB0112760
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:30:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7AEFA40364;
 Thu,  5 Nov 2026 15:30:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C161F00A02;
 Thu,  5 Nov 2026 15:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892657;
 bh=QcP/wyaIZ9/H5dcDS6XFL2+EWmlJgrlIM5Af3su0GUE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=f5v+7aDu50RW20fHRwRinnKdaDHve8Qj1FiwnlgC+jpdcgQJCNn5PAfUo1ihaZEs9
 hwccnHVAwKn1Pz/iRIweQI/UdMvPpXZS5QvJQpb/rCsxJMByclKGg68gYsxQWFjoYc
 /Ftzlg3pw0MD+jQ4QGeZQTqyr2jqILP49aND9PW7n25m04MtwT78GXhZOHtGPL/aDo
 scL0TTr9TG+TJ/JpjI0MC0JhcDe4qJRa1nbABgGMET645DvXKo7xfCVPS2I+IG2L1u
 MUvYTqVusTu9FQsxBgWfavC12awEM91qUQVrcVyUdkLVLpNCc9tIM3cak9hYW0X5+k
 wfA1EQhgAH8cg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:29:21 +0100
Subject: [PATCH RESEND 12/83] drm/fsl-dcu: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-12-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 Alison Wang <alison.wang@nxp.com>, Stefan Agner <stefan@agner.ch>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=mripard@kernel.org;
 h=from:subject:message-id; bh=WYPfgpqXSduN4BiKX0UiKPuOuYDxF57UaFb7URAXZ+8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFjwKDStLSEs/a+Dda/dPafOnaYxnDbU5ZEyeRFpzP
 9yhIXKiYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEyk2IGxYc7WLU33v4mcVf6z
 hC8zfY/mrJIzVf6SN1Js5ryd1H9epl/0xpSfBmmSsWdUPTsaG42CGBuatU/O+vrWKfVctcPrCbq
 2n3hOdBkZLbORVAgR+jeHoTenvLbriTbTXY+2doY/T0RXywEA
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
Cc: Alison Wang <alison.wang@nxp.com>
Cc: Stefan Agner <stefan@agner.ch>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
index 5b47000738e4..9c2189661d8a 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c
@@ -43,5 +43,7 @@ int fsl_dcu_drm_modeset_init(struct fsl_dcu_drm_device *fsl_dev)
 		goto err;
 
-	drm_mode_config_reset(fsl_dev->drm);
+	ret = drm_mode_config_create_initial_state(fsl_dev->drm);
+	if (ret)
+		goto err;
 	drm_kms_helper_poll_init(fsl_dev->drm);
 

-- 
2.55.0

