Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA69EC5DF86
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:57:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33B8810E8FA;
	Tue, 18 Aug 2026 23:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NUnWehfw";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA1A10E8FA
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787097448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6joxchIjpSKAZuVd8UNWe0u9ndTjKFHdE9rh6/DiW54=;
 b=NUnWehfwH5O4Hz+foDPnUSWxEQ3igMXjvq2vtKflKp/TdCL1ATLVW38HlaRxdxWx6rUNei
 qWqa8pO6XH8CewI4vomcZWLvbiesVkK4JnuMJzCTNZ5eV8SjFE128z0vvuDVrNMveeIysJ
 LINRq+a+ubbYpO+ZWejouKz3txmUNJI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-rwbj6aTuNea1z1EyPRRfDQ-1; Tue,
 18 Aug 2026 19:57:18 -0400
X-MC-Unique: rwbj6aTuNea1z1EyPRRfDQ-1
X-Mimecast-MFC-AGG-ID: rwbj6aTuNea1z1EyPRRfDQ_1787097436
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4890B1956041; Tue, 18 Aug 2026 23:57:16 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0329180049F; Tue, 18 Aug 2026 23:57:13 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: "Faith Ekstrand" <faith.ekstrand@collabora.com>,
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
Subject: [PATCH 5/6] drm/nouveau/kms/nv50-: Add nouveau_encoder->audio.crtc
Date: Tue, 18 Aug 2026 19:48:47 -0400
Message-ID: <20260818235637.1738055-6-lyude@redhat.com>
In-Reply-To: <20260818235637.1738055-1-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: qdcqzE9YBnvrT97GYCQj1LU7SkLIqagfdHq-jLmPR3A_1787097436
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

This is the only spot in nouveau where we do actually need to keep track of
the currently assigned CRTC for an encoder, and it ideally should be
happening outside of the modesetting locks.

So in preparation for obliterating nouveau_encoder->crtc, let's just add a
variable into nouveau_encoder->audio for tracking this and use it instead
of nouveau_encoder->crtc. This makes it a lot more obvious that this is
only intended for state-tracking for audio.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c   | 4 +++-
 drivers/gpu/drm/nouveau/nouveau_encoder.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 63d554e97fb62..3bfc04f7ef602 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -636,7 +636,7 @@ nv50_audio_component_get_eld(struct device *kdev, int port, int dev_id,
 
 		nv_encoder = nouveau_encoder(encoder);
 		nv_connector = nv_encoder->conn;
-		nv_crtc = nouveau_crtc(nv_encoder->crtc);
+		nv_crtc = nv_encoder->audio.crtc;
 
 		if (!nv_crtc || nv_encoder->outp.or.id != port || nv_crtc->index != dev_id)
 			continue;
@@ -757,6 +757,7 @@ nv50_audio_disable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc)
 	mutex_lock(&drm->audio.lock);
 	if (nv_encoder->audio.enabled) {
 		nv_encoder->audio.enabled = false;
+		nv_encoder->audio.crtc = NULL;
 		nvif_outp_hda_eld(&nv_encoder->outp, nv_crtc->index, NULL, 0);
 	}
 	mutex_unlock(&drm->audio.lock);
@@ -781,6 +782,7 @@ nv50_audio_enable(struct drm_encoder *encoder, struct nouveau_crtc *nv_crtc,
 	nvif_outp_hda_eld(&nv_encoder->outp, nv_crtc->index, nv_connector->base.eld,
 			  drm_eld_size(nv_connector->base.eld));
 	nv_encoder->audio.enabled = true;
+	nv_encoder->audio.crtc = nv_crtc;
 
 	mutex_unlock(&drm->audio.lock);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_encoder.h b/drivers/gpu/drm/nouveau/nouveau_encoder.h
index 4422c6185d498..647322ac1c8df 100644
--- a/drivers/gpu/drm/nouveau/nouveau_encoder.h
+++ b/drivers/gpu/drm/nouveau/nouveau_encoder.h
@@ -62,6 +62,7 @@ struct nouveau_encoder {
 	/* Protected by nouveau_drm.audio.lock */
 	struct {
 		bool enabled;
+		struct nouveau_crtc *crtc;
 	} audio;
 
 	struct drm_display_mode mode;
-- 
2.55.0

