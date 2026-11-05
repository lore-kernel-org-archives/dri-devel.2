Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C5606A32F
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJcA3TyN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B49112793;
	Thu,  5 Nov 2026 15:34:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9C31127C0
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:34:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C6104432FA;
 Thu,  5 Nov 2026 15:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335411F00A1A;
 Thu,  5 Nov 2026 15:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793892870;
 bh=BeXq9QDHvotUIXRtBLjxr9rMI5Mo0fX7/osS3BsKWoo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YJcA3TyNGUjocW349K4r8suP+szVS3G+RDndqnGARPfU//L/jL8hG+gWjDcRtsIfh
 xdw5LnQJt5gRFXk6Sq9Dh1n/W3iHI3i+Nlr4jHRGt2rXuarK0D6CnlO3jfSn/96EUM
 ebNXVJyDmAh/9JDoRaPswDeTlVY+jM1WGWfPJGNorcYwm9kxzpR4QrQ4N9zS3hX6lS
 XwIRxUQ/1pXvMSulugdzyK3aV5XtqXCelW2lQgtHfEMWKPNO1mSuGLj3r97fT86VeJ
 Ulra0XugHTBBiB9jvBSoJ9N5rQ6IW0ENNJ8k0Vm2XHuyO4l2AOuya/32Rjx34cKdVb
 04Jrbb91Gkr7Q==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 05 Nov 2026 16:30:20 +0100
Subject: [PATCH RESEND 71/83] drm/pixpaper: Switch to
 drm_mode_config_create_initial_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-drm-no-more-config-reset-v1-71-1f58d1e33380@kernel.org>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
In-Reply-To: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
To: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org, 
 LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=mripard@kernel.org;
 h=from:subject:message-id; bh=xQ0Y/zqA/yl10WxFoPBsrKCO18sXIBXGsk9uDy7wlDk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvFvxZduPGMR73ldnfOhVdjbMnfmcp2ajBsnS+9O6cN
 vZHLM/tO6ayMAhzMsiKKbI8kQk7vbx9cZWD/cofMHNYmUCGMHBxCsBEXGYyNkyNk7thcqK8Wf76
 BIF9vxddesApX7Px63Xn9zn7p2lcecPC6lA446fB8u1PLXkdpx/22MRYw73R+F/9yi4flvSdD9N
 kT+meD1zRPd/wnn34Eqf8L0ZMRuf6NOrchM/X1DO1L+919k0DAA==
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
Cc: LiangCheng Wang <zaq14760@gmail.com>
---
 drivers/gpu/drm/tiny/pixpaper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index 2a92a28b40f6..f8a633d0fbd8 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -1119,5 +1119,7 @@ static int pixpaper_probe(struct spi_device *spi)
 	drm_connector_attach_encoder(&panel->connector, &panel->encoder);
 
-	drm_mode_config_reset(drm);
+	ret = drm_mode_config_create_initial_state(drm);
+	if (ret)
+		return ret;
 
 	ret = drm_dev_register(drm, 0);

-- 
2.55.0

