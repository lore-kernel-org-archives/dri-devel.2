Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0DFC3DA7A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 17:29:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB1FD10FED2;
	Wed, 14 Oct 2026 17:29:15 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4382A10FED0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 17:29:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BBCF760230;
 Wed, 14 Oct 2026 17:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E725C1F000C4;
 Wed, 14 Oct 2026 17:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791998948;
 bh=ZrZND1LiHEzbjERjzIUfS+xkOKj1F5JWMSQ1i54/k6o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=gJvV1t/WM2Ti8F5kPJblGsj3ce4KzbI+OTSUh7lRve0iloGnO9OHcjnvjELsKj0+K
 cXGSjjIEisXepjfxIdy3wyRR6PjoveoATiJzcUL+fsXmBk24nvI75oRpu1CuQI+PWH
 MJGhYjCoF2zxpvD7XAWJgmfVMJsssewrFMPHbiMI20bFeamUfm3n1xufnjCXqqzvg3
 lNVne3A+x7lpZr7DXDuCtT7/fvTkHsQOAqmj457yPhKIMZO+Qchf2cC4cZWY9Li8wN
 TK43Gs9LfDIkHswDyIL5KcbJn2lBapMDRP4Zd2tYfcVcas94LYKNMLPMnDFXQFQB+F
 eoBwqcKoMb6sg==
From: Maxime Ripard <mripard@kernel.org>
Date: Wed, 14 Oct 2026 19:26:55 +0200
Subject: [PATCH 32/75] drm/renesas: shmobile: Switch to
 drm_atomic_helper_connector_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-drm-no-more-connector-reset-v1-32-586c9c026823@kernel.org>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290; i=mripard@kernel.org;
 h=from:subject:message-id; bh=XJPOBy4nF9aD/gLCw2XRN6Z6R3aUocitA+b6qF2WTN8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFnnd0c0vXMPf1MsfWz1yYO/F0xln8rq5HZVtjnaY+I2L
 eM5Exlnd0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJpL5nbLjpFtTOK6+96pj5
 p67QC6dDpUVbxN0j+u8cNa+xmVfHxCSfsFfG1i7V6Z2P8OeY0PJnjPWR9t8OnHZgkuHkYkhSbvU
 qkvmo/OsNM7fvXx7hHb8PmJTnLFyyL3NlgJ/4UxF5+2/KwgA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The renesas: shmobile connector implementation uses the deprecated
drm_atomic_helper_connector_reset() as its reset hook.

Switch to drm_atomic_helper_connector_create_state() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 51bae2008cc6..ef51c4aafc84 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -525,11 +525,11 @@ static void shmob_drm_connector_destroy(struct drm_connector *connector)
 
 	kfree(connector);
 }
 
 static const struct drm_connector_funcs connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.atomic_create_state = drm_atomic_helper_connector_create_state,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = shmob_drm_connector_destroy,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };

-- 
2.55.0

