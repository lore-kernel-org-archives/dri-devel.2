Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9368C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E7C10EE70;
	Wed, 19 Aug 2026 16:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="ZAl/UFju";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67BAE10EE2E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787155224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fMF+0ARQ9Eixkloaq8eI+L+kTqWe7Y7ZEuYINPQUR1c=;
 b=ZAl/UFjuAy3aPrL/p0ZVz3EL37/fZJUlUy1/79V/0//eGPFDTxc+xTVXUsk66VfQOjRgLZ
 mbMJlUwuBOrX70rnkcnLVrK5EWeXK4drA8dskBz2UQbJOqfwExLY81MO4DnQgrvG2XnhgL
 hotUHkExPCXUkg24k5Llk7LPKqrpkB8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-5Dfng3uhMEqdLYBca1IOjQ-1; Wed,
 19 Aug 2026 12:00:19 -0400
X-MC-Unique: 5Dfng3uhMEqdLYBca1IOjQ-1
X-Mimecast-MFC-AGG-ID: 5Dfng3uhMEqdLYBca1IOjQ_1787155206
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 950711956047; Wed, 19 Aug 2026 16:00:06 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDE4A18005BB; Wed, 19 Aug 2026 16:00:00 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: stable@vger.kernel.org, "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Marek Czernohous" <marek@czernohous.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Kees Cook" <kees@kernel.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Ben Skeggs" <bskeggs@redhat.com>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Jani Nikula" <jani.nikula@intel.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 3/6] drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc in
 nv50_sor_atomic_disable()
Date: Wed, 19 Aug 2026 11:43:50 -0400
Message-ID: <20260819155934.154125-4-lyude@redhat.com>
In-Reply-To: <20260819155934.154125-1-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: eQ_0ZQqxMnKJIVGCmYnpTgdWrSFxVCvRIMvjbbAQ2u8_1787155206
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This is a leftover CRTC bookkeeping variable from the pre-atomic days.
While it works in most situations, it's prone to breaking - as pointed out
by Marek Czernohous.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reported-by: Marek Czernohous <mczernohous@gmail.com>
Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org> # v5.12+
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 152361f7feb42..f19820dc055ae 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -459,7 +459,7 @@ nv50_outp_get_old_connector(struct drm_atomic_commit *state, struct nouveau_enco
 	return NULL;
 }
 
-static struct nouveau_crtc * __maybe_unused
+static struct nouveau_crtc *
 nv50_outp_get_old_crtc(const struct drm_atomic_commit *state, const struct nouveau_encoder *outp)
 {
 	struct drm_crtc *crtc;
@@ -1606,12 +1606,18 @@ static void
 nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *state)
 {
 	struct nouveau_encoder *nv_encoder = nouveau_encoder(encoder);
-	struct nv50_head *head = nv50_head(nv_encoder->crtc);
+	struct nouveau_crtc *nv_crtc;
+	struct nv50_head *head;
 
 #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
 	nv50_sor_atomic_disable_backlight(nouveau_drm(state->dev), nv_encoder, state);
 #endif
 
+	nv_crtc = nv50_outp_get_old_crtc(state, nv_encoder);
+	if (drm_WARN_ON(state->dev, !nv_crtc))
+		return;
+	head = nv50_head(&nv_crtc->base);
+
 	if (nv_encoder->dcb->type == DCB_OUTPUT_TMDS && nv_encoder->hdmi.enabled) {
 		nvif_outp_hdmi(&nv_encoder->outp, head->base.index,
 			       false, 0, 0, 0, false, false, false);
-- 
2.55.0

