Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79873C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF01210EE60;
	Wed, 19 Aug 2026 16:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="W9SFQyh2";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2415E10EE7C
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787155249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o/spj4W5FENPyv/B4rNGsfmEZBcto8Uc5DMRDqeD4Hw=;
 b=W9SFQyh2KvHqRkx2n8JChvpVBdSEugJ4Rgh+jNWRO0rSUcnf1Pl4mKwMMq1EQIiyWukzOR
 M+bdnsqE1ue/WgXFRXkcV9WvXGkSr84iQ9Q2qLrukVg2F458ag4l9eFl2wgzNL2gqf13YF
 rm/JXh2yZBZNLW1WHVyjW7RQSpe9Zuc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-j6z_4fppNDCdYmnoOZ5soQ-1; Wed,
 19 Aug 2026 12:00:46 -0400
X-MC-Unique: j6z_4fppNDCdYmnoOZ5soQ-1
X-Mimecast-MFC-AGG-ID: j6z_4fppNDCdYmnoOZ5soQ_1787155231
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 950E319541B1; Wed, 19 Aug 2026 16:00:28 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6904C18005BC; Wed, 19 Aug 2026 16:00:25 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Marek Czernohous" <marek@czernohous.de>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Kees Cook" <kees@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Ben Skeggs" <bskeggs@redhat.com>, "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Jani Nikula" <jani.nikula@intel.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v2 6/6] drm/nouveau/kms/nv50-: Obliterate nouveau_encoder->crtc
Date: Wed, 19 Aug 2026 11:43:53 -0400
Message-ID: <20260819155934.154125-7-lyude@redhat.com>
In-Reply-To: <20260819155934.154125-1-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: b-bCXMzFUAnDsKm85mnkl4uHTgP18xpRX27XM0hcpxI_1787155231
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

This is mostly a leftover artifact from the pre-atomic days, and while
we've been using it for a while now - it isn't great. Mostly because having
redundant state tracking for things atomic already keeps track of is pretty
much always error prone, as anyone working on nouveau who isn't already
very well versed in atomic modesetting isn't going to realize this isn't
the right way to see what CRTC is assigned to an encoder.

Now that we've removed the only legitimate user (DRM audio) and all the
illegitimate ones, let's obliterate it.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c   | 8 --------
 drivers/gpu/drm/nouveau/nouveau_encoder.h | 3 ---
 2 files changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index fbb874b11d7a8..1882ab3176a49 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -502,7 +502,6 @@ nv50_dac_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *s
 	const u32 ctrl = NVDEF(NV507D, DAC_SET_CONTROL, OWNER, NONE);
 
 	core->func->dac->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
-	nv_encoder->crtc = NULL;
 }
 
 static void
@@ -532,8 +531,6 @@ nv50_dac_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 
 	core->func->dac->ctrl(core, nv_encoder->outp.or.id, ctrl, asyh);
 	asyh->or.depth = 0;
-
-	nv_encoder->crtc = &nv_crtc->base;
 }
 
 static enum drm_connector_status
@@ -1634,7 +1631,6 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *s
 
 	nv_encoder->update(nv_encoder, head->base.index, NULL, 0, 0);
 	nv50_audio_disable(encoder, &head->base);
-	nv_encoder->crtc = NULL;
 }
 
 // common/inc/displayport/displayport.h
@@ -1802,7 +1798,6 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 	u8 depth = NV837D_SOR_SET_CONTROL_PIXEL_DEPTH_DEFAULT;
 
 	nv_connector = nv50_outp_get_new_connector(state, nv_encoder);
-	nv_encoder->crtc = &nv_crtc->base;
 
 	if ((disp->disp->object.oclass == GT214_DISP ||
 	     disp->disp->object.oclass >= GF110_DISP) &&
@@ -2013,7 +2008,6 @@ nv50_pior_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_commit *
 	const u32 ctrl = NVDEF(NV507D, PIOR_SET_CONTROL, OWNER, NONE);
 
 	core->func->pior->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
-	nv_encoder->crtc = NULL;
 }
 
 static void
@@ -2058,7 +2052,6 @@ nv50_pior_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *s
 	}
 
 	core->func->pior->ctrl(core, nv_encoder->outp.or.id, ctrl, asyh);
-	nv_encoder->crtc = &nv_crtc->base;
 }
 
 static const struct drm_encoder_helper_funcs
@@ -2794,7 +2787,6 @@ nv50_display_read_hw_or_state(struct drm_device *dev, struct nv50_disp *disp,
 	armh->state.enable = true;
 	pm_runtime_get_noresume(dev->dev);
 
-	outp->crtc = crtc;
 	outp->ctrl = NVVAL(NV507D, SOR_SET_CONTROL, PROTOCOL, proto) | BIT(crtc->index);
 
 	drm_connector_get(conn);
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
index 647322ac1c8df..6dcdfd048a35d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -54,9 +54,6 @@ struct nouveau_encoder {
 
 	struct i2c_adapter *i2c;
 
-	/* different to drm_encoder.crtc, this reflects what's
-	 * actually programmed on the hw, not the proposed crtc */
-	struct drm_crtc *crtc;
 	u32 ctrl;
 
 	/* Protected by nouveau_drm.audio.lock */
-- 
2.55.0

