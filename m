Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6957CD98D9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 12:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28E2110EEF8;
	Thu, 11 Jun 2026 12:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lq+k76j2";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A44C10EEF2
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 12:45:41 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490791a3e92so9891365e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781181940; x=1781786740; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZC8AOgwDUkqE3FrJgyPhYy8Ulxsg9q9DK142dUYM4M=;
 b=lq+k76j2Zqtjb+bm1Q4hO2yM4r8UOq0mHBTieV+MSY9O30Hvw9ASjhoLe0sNIt3ZeF
 bEaHgIWY9bEh/C0qmSZl+LLTk/hFB2akHeYiUBjczkoqzCFKmYzN3rmJWwLqjBfiVL65
 hRqdFqyTeAK7nTNzOJnMe1fCPpq5MLyiaIZ3z02F3G3Z1R69O/jWk/XFz4cfVXMF4aoE
 194YDwqeXwPzxUqqk2xPeCgNEhdR2xrpSWfQQg+wNTWFlLnDqe2CMnCD+8yRHtMrNCHi
 MddRVNNMzU4WP2uCAgtY/v1gAxg0x0fgC1cg9KDi/Q1M1KWZWuLHmzVS5IHAoxibnTe6
 6ivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781181940; x=1781786740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cZC8AOgwDUkqE3FrJgyPhYy8Ulxsg9q9DK142dUYM4M=;
 b=fTrFtmr7is6SHrQxn72AgndhL3QbYpvV4uDvvniPy6OgT84cMKAY3S5WaUufOA8+2W
 rhIAoCiPOWlJ9lYQEclsDDsFqMpXfe1rKKnB7HYL/dN7Z5lCFNMAxD+kZIswBOk9LCom
 1XEca3OIOGj/nh+4UjdL/U+ruhBlZ2ImDboqEI7CvspVSaLPhMs3ODeXBbHkbvw6fLF8
 FyD4xjpTShk5g9Mz4I+f9gwJOub16aj9Unxl2jk1Ck1k0NAyhxN9OiTBiZZMGXb9kFZh
 SvsshTlVoepAbRrZUXu3FjYPWlZVpMRa/Bbibx/RGWaUPRT8l1wODoUhp9Px8pybEJyi
 JVbQ==
X-Gm-Message-State: AOJu0Yy8IExrLq4l2k78CdRitCI2Qm0WDKPIolQ8cfIJWLERo78qgSvm
 J51sFwRn+GFrSiTNSloV56g6dfB04+TZoYWSLl4yWxAu5GOrBglvC5yH
X-Gm-Gg: Acq92OEz5HqAN1a3fJKG7g7oyUU9OROwXmuAdawaKHq/7KUfRzZuiP4HVWikLOv3pcD
 /DkR6Rmc6jgkE+aOsrRCtiqNzd69bHAuwZn7N1kWgYKRnt+FIzwIdj5JpYYRUs1jq26SZ+LSAzL
 WERtji6ru+QmOobnSdc0ZDxnss6pwbLIQztRIfu0CFfCMxlOlPlZ/ddMswpK2HBNKyXeT0F2jtH
 smI94yYPR9T0sVq7Wbj4aFAldp1jY/wOy12i6XNp85w7KA2nQxAIg1qaSpO+RKycVKlNICPX9w7
 npRrf80/Vt8WO1KRfATT92t1VClDvzklR0EXoNrF/b5TeX78UMFCIalkTFQ+pjjPt2WoAFcB6SG
 WEg83LBVqlJROwNlna8uCn4wTiiNssCToKT0dBA1CzQHiOZUrTrOdAfZWFamaKxadhZjc2bOwrt
 3eu2bFJOlPtZnF29H8ZbX0lQLaIm7okN2ych9q7gmVk4UZ+n+UoL8NonKn1sbhp308snCsYRfLW
 3kvW870KX5RRuH1m74ikxOMhjnE
X-Received: by 2002:a05:600c:1d16:b0:490:e919:7bba with SMTP id
 5b1f17b1804b1-490e9197c83mr3700335e9.8.1781181939386; 
 Thu, 11 Jun 2026 05:45:39 -0700 (PDT)
Received: from localhost.localdomain
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e532c778sm48697645e9.14.2026.06.11.05.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 05:45:38 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fab Stz <fabstz-it@yahoo.fr>
Subject: [PATCH v3 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
Date: Thu, 11 Jun 2026 14:45:35 +0200
Message-ID: <20260611124535.527275-3-mczernohous@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611124535.527275-1-mczernohous@gmail.com>
References: <20260611124535.527275-1-mczernohous@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Marek Czernohous <marek@czernohous.de>

nv50_sor_atomic_disable() unconditionally computes
nv50_head(nv_encoder->crtc) and dereferences the result a few lines
later.  nv_encoder->crtc is nouveau's own shadow pointer, set in
.atomic_enable and cleared at the end of .atomic_disable.
Commit f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc)
checks in ->disable callbacks") removed the NULL check here,
reasoning that the atomic helpers never call ->disable without a
crtc.  On NVAC (MCP79) under Wayland sessions (observed with Weston's
DRM backend and with labwc/wlroots) we have hit the NULL case in
practice during session teardown and VT switches: disable runs without
(or after) its matching enable, and because nv50_head() is
container_of(), the NULL does not stay NULL but becomes a bogus
non-NULL pointer, so the subsequent head dereferences fault and the
kernel oopses.

Restore the guard, as drm_WARN_ON_ONCE() instead of a silent return:
a NULL crtc here still indicates a state-tracking inconsistency that
should stay visible.  Return without touching the output; in this path
either enable never ran (nothing to tear down) or an earlier disable
already did the teardown, and the encoder release is handled by the
commit_tail release loop in both cases.  (That loop then rejects the
release of a never-acquired output with -EINVAL in the nvif layer,
which is harmless; the vanilla code oopsed before ever reaching it.)

The same inconsistent-state path can also leave the encoder without an
old connector state, in which case nv50_outp_get_old_connector()
returns NULL while the backlight teardown dereferenced it
unconditionally, so the oops would only have moved there.  Hoist the
guard above all of that and look at the old connector only after
checking it.

Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org>
Tested-by: Fab Stz <fabstz-it@yahoo.fr>
Assisted-by: Claude:claude-opus-4-7
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Marek Czernohous <marek@czernohous.de>
---
v2 -> v3: hoisted the guard above the CONFIG_DRM_NOUVEAU_BACKLIGHT
block and made the old-connector lookup NULL-safe (reported by the
Sashiko AI review on the v2 posting: the unconditional
nv_connector->backlight initializer ran before the guard); folded
review nits (pointer wording, release-loop note, comment).  Tested-by
carried over; the changes stay confined to the inconsistent-state
path, normal-path behavior is unchanged.
v1 -> v2: dropped the nvif_outp_release() call from the early return
(the release is owned by the commit_tail release loop; calling it here
released twice and detached the OR before the disable flush); turned
the silent return into drm_WARN_ON_ONCE(); reworded the commit message.
v2: https://lore.kernel.org/all/66ea307dd4fa080db27b2b9a0caa31b562d72c2b.1781162589.git.marek@czernohous.de/
v1: https://lore.kernel.org/nouveau/20260409172126.115441-3-marek@czernohous.de/

 drivers/gpu/drm/nouveau/dispnv50/disp.c | 30 ++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 6c3a871..47e15a4 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1565,16 +1565,36 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_state *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nv50_head *head = nv50_head(nv_encoder->crtc);
+	struct nv50_head *head;
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
-	struct nouveau_connector *nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+	struct nouveau_connector *nv_connector;
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
-	struct nouveau_backlight *backlight = nv_connector->backlight;
-	struct drm_dp_aux *aux = &nv_connector->aux;
+	struct nouveau_backlight *backlight;
 	int ret;
+#endif
 
+	/* nv_encoder->crtc is the driver's shadow pointer, set in
+	 * .atomic_enable (and by the boot-time hardware readback) and
+	 * cleared at the end of this function.  NULL here
+	 * means disable-without-enable or a double disable; bail before
+	 * container_of() turns it into a bogus head pointer (checking the
+	 * result would not work, container_of(NULL) is never NULL).  The
+	 * encoder release is handled by the commit_tail release loop, so
+	 * there is nothing to clean up here.
+	 */
+	if (drm_WARN_ON_ONCE(encoder->dev, !nv_encoder->crtc))
+		return;
+	head = nv50_head(nv_encoder->crtc);
+
+#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
+	/* The same inconsistent-state path can leave us without an old
+	 * connector state, so check before touching it.
+	 */
+	nv_connector = nv50_outp_get_old_connector(state, nv_encoder);
+	backlight = nv_connector ? nv_connector->backlight : NULL;
 	if (backlight && backlight->uses_dpcd) {
-		ret = drm_edp_backlight_disable(aux, &backlight->edp_info);
+		ret = drm_edp_backlight_disable(&nv_connector->aux,
+						&backlight->edp_info);
 		if (ret < 0)
 			NV_ERROR(drm, "Failed to disable backlight on [CONNECTOR:%d:%s]: %d\n",
 				 nv_connector->base.base.id, nv_connector->base.name, ret);
-- 
2.53.0

