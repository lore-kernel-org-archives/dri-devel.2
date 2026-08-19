Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21F3C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348A710EE62;
	Wed, 19 Aug 2026 16:00:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="gHsdlZf8";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02DC110EE4A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787155224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cdwphjmf7twiQKozt/YmavKP3Voyo4Fdnf0ShOQkMVE=;
 b=gHsdlZf8i+sr1kiAQwxJCQ8qM0nEqO4zCjIiMnjloApRcgSKTsyif9PDMknxIn2m+YdwEK
 Wl7H/7wu2Fa73D2x9TPMmVN80rl/1Ja1NuKd9Lf3G3N7NyyYIPAlQbqAOVbbTQTRlbiZMn
 JNiKehZ5HBb/Gbz1qwyG0M660a0AtL0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-eCl0fOJ4MQCvU2ebNBM7_Q-1; Wed,
 19 Aug 2026 12:00:09 -0400
X-MC-Unique: eCl0fOJ4MQCvU2ebNBM7_Q-1
X-Mimecast-MFC-AGG-ID: eCl0fOJ4MQCvU2ebNBM7_Q_1787155199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C5271954AFB; Wed, 19 Aug 2026 15:59:57 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 63C4A18005BB; Wed, 19 Aug 2026 15:59:53 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: stable@vger.kernel.org, "Dave Airlie" <airlied@redhat.com>,
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
Subject: [PATCH v2 2/6] drm/nouveau/kms/nv50-: Add nv50_outp_get_old_crtc()
Date: Wed, 19 Aug 2026 11:43:49 -0400
Message-ID: <20260819155934.154125-3-lyude@redhat.com>
In-Reply-To: <20260819155934.154125-1-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: FpmVCcx9_3UZ9QvGa77hUk0gjn6rtmZDWPncbr-lmh0_1787155199
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

Does what it says on the label, unused for now.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Fixes: f575f2bdb6c3 ("drm/nouveau/kms/nv50-: Remove (nv_encoder->crtc) checks in ->disable callbacks")
Cc: <stable@vger.kernel.org> # v5.12+
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index a885394f7cb92..152361f7feb42 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -459,6 +459,22 @@ nv50_outp_get_old_connector(struct drm_atomic_commit *state, struct nouveau_enco
 	return NULL;
 }
 
+static struct nouveau_crtc * __maybe_unused
+nv50_outp_get_old_crtc(const struct drm_atomic_commit *state, const struct nouveau_encoder *outp)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *crtc_state;
+	const u32 mask = drm_encoder_mask(&outp->base.base);
+	int i;
+
+	for_each_old_crtc_in_state(state, crtc, crtc_state, i) {
+		if (crtc_state->encoder_mask & mask)
+			return nouveau_crtc(crtc);
+	}
+
+	return NULL;
+}
+
 static struct nouveau_crtc *
 nv50_outp_get_new_crtc(const struct drm_atomic_commit *state, const struct nouveau_encoder *outp)
 {
-- 
2.55.0

