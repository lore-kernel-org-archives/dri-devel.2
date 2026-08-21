Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201D4C5DF95
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:42:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F5A10F306;
	Fri, 21 Aug 2026 14:42:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PowEY7Eq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F71D10F2EC
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:41:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1370A4402C;
 Fri, 21 Aug 2026 14:41:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE501F00A3A;
 Fri, 21 Aug 2026 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787323306;
 bh=6tWH/HcjSAvvvKfmm0EViTiUquecHx9AihGG1W6yKH4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PowEY7EqjbL2gZpSIZ/1Kc1uqFHYgwZ2Cw7PmwXAWeF7tj8fe6IEmBQW1pDtR4s8j
 7Tp1r1NUe+RRXpev6wsCXExQrJ+QzJYyEgtlRaORM4pA51tfTnjsr1XkdpKpwRfviv
 4NafPgqQDbeUDnFvz9V0TSmml5iUan06WE21ny0pQYWbhEOqhTCrWZi8pXWsVYQWv3
 jCXObuzHUPO3XpSUQ8SkDP7kB2cytj9JCXkQlH+doAZ6CqCJwUdHp0rpNAq+tiswUb
 P+7g9y5qieHcPMwlx3Y2dYfj9GREGf9wt5aebau4CEt+uYa1N9ECQkzN2eq1K8/xCn
 tXXxk8Ng/9qOQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 21 Aug 2026 16:39:36 +0200
Subject: [PATCH 60/70] drm/rzg2l-du: Convert to atomic_create_state
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-drm-no-more-crtc-reset-v1-60-fb793475c05a@kernel.org>
References: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
In-Reply-To: <20260821-drm-no-more-crtc-reset-v1-0-fb793475c05a@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Biju Das <biju.das.jz@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2407; i=mripard@kernel.org;
 h=from:subject:message-id; bh=MoHDzQR3vZtC4B+GHVIn1M0nZcHirEDXZeypVQ/Lbkk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkdyULMoa25jNe89qTvYw3dypvjXScRULLpCBujd4udE
 OfxxlUdU1kYhDkZZMUUWZ7IhJ1e3r64ysF+5Q+YOaxMIEMYuDgFYCLsoYx1loyFazj9ev4sj4lc
 ujnxleQTYd342crzag49+pDPIHxzZ2Bw3Fdj80yeH8pOyx/53MplbHhUn8mlUWse7b0oMIbDw2/
 79tPJL5h3dy85wajms2Xr6yKujLrNEgLhsct7c26uPBkyBwA=
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

The rzg2l-du crtc implementation provides a custom reset hook.
However, this hook only allocates the state, initializes it with
__drm_atomic_helper_crtc_reset(), and frees the previous state. It
does not perform any hardware reset.

Since this is exactly what the atomic_create_state hook is meant to
do, minus the old state cleanup which the caller handles, convert the
implementation to use atomic_create_state with
__drm_atomic_helper_crtc_state_init() instead.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index d0f01aa642a7..ab2f24cc7683 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -330,24 +330,21 @@ static void rzg2l_du_crtc_atomic_destroy_state(struct drm_crtc *crtc,
 {
 	__drm_atomic_helper_crtc_destroy_state(state);
 	kfree(to_rzg2l_crtc_state(state));
 }
 
-static void rzg2l_du_crtc_reset(struct drm_crtc *crtc)
+static struct drm_crtc_state *rzg2l_du_crtc_create_state(struct drm_crtc *crtc)
 {
 	struct rzg2l_du_crtc_state *state;
 
-	if (crtc->state) {
-		rzg2l_du_crtc_atomic_destroy_state(crtc, crtc->state);
-		crtc->state = NULL;
-	}
-
 	state = kzalloc_obj(*state);
 	if (!state)
-		return;
+		return ERR_PTR(-ENOMEM);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->state);
+	__drm_atomic_helper_crtc_state_init(&state->state, crtc);
+
+	return &state->state;
 }
 
 static int rzg2l_du_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct rzg2l_du_crtc *rcrtc = to_rzg2l_crtc(crtc);
@@ -363,11 +360,11 @@ static void rzg2l_du_crtc_disable_vblank(struct drm_crtc *crtc)
 
 	rcrtc->vblank_enable = false;
 }
 
 static const struct drm_crtc_funcs crtc_funcs_rz = {
-	.reset = rzg2l_du_crtc_reset,
+	.atomic_create_state = rzg2l_du_crtc_create_state,
 	.set_config = drm_atomic_helper_set_config,
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = rzg2l_du_crtc_atomic_duplicate_state,
 	.atomic_destroy_state = rzg2l_du_crtc_atomic_destroy_state,
 	.enable_vblank = rzg2l_du_crtc_enable_vblank,

-- 
2.55.0

