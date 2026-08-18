Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD22EC5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1180710E708;
	Tue, 18 Aug 2026 23:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="h0VBPweg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53DC410E708
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 23:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787097442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+AiUvg3f0tmCvkZK9tohm8bvMedZbKf/cdnpoumO1Tw=;
 b=h0VBPweg9WTqdcuNSJKsyETpGO85m6qwGjTCz/yY8JIVCNro3b4Vn+YHs1UH2I+2fpXUIC
 exfZS4VYIs4BrLrK2hiop0sIgsmYtEWQDI1TOYXVTIk02F2eGJzRKnHyrJaesnp9wjkLyx
 tnZbum/8l+8Etx5jnmJeGRAR1VRops0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-aqiblKe4MkGyJoEF2yAsqQ-1; Tue,
 18 Aug 2026 19:57:12 -0400
X-MC-Unique: aqiblKe4MkGyJoEF2yAsqQ-1
X-Mimecast-MFC-AGG-ID: aqiblKe4MkGyJoEF2yAsqQ_1787097430
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B8C41800637; Tue, 18 Aug 2026 23:57:10 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.80.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C9D41800347; Tue, 18 Aug 2026 23:57:07 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Marek Czernohous <mczernohous@gmail.com>
Cc: Marek Czernohous <marek@czernohous.de>,
 "Faith Ekstrand" <faith.ekstrand@collabora.com>,
 "Dave Airlie" <airlied@redhat.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Kees Cook" <kees@kernel.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Ben Skeggs" <bskeggs@redhat.com>,
 "David Airlie" <airlied@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Maxime Ripard" <mripard@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 "Jani Nikula" <jani.nikula@intel.com>, "James Jones" <jajones@nvidia.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH 4/6] drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc in
 nv50_disp_atomic_commit_core()
Date: Tue, 18 Aug 2026 19:48:46 -0400
Message-ID: <20260818235637.1738055-5-lyude@redhat.com>
In-Reply-To: <20260818235637.1738055-1-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 9lgK_1kKspArIs_Bld3qC6d3Occ_-HNigjinxww_kv4_1787097430
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

Another leftover spot where we still use nv_encoder->crtc. Get rid of it
and do the right thing: get the currently assigned CRTC from the new atomic
state.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reported-by: Marek Czernohous <marek@czernohous.de>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index f19820dc055ae..63d554e97fb62 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2171,10 +2171,14 @@ nv50_disp_atomic_commit_core(struct drm_atomic_commit *state, u32 *interlock)
 	list_for_each_entry(outp, &atom->outp, head) {
 		if (outp->encoder->encoder_type != DRM_MODE_ENCODER_DPMST) {
 			struct nouveau_encoder *nv_encoder = nouveau_encoder(outp->encoder);
+			struct nouveau_crtc *nv_crtc = nv50_outp_get_new_crtc(state, nv_encoder);
+
+			if (drm_WARN_ON(drm->dev, !nv_crtc))
+				continue;
 
 			if (outp->enabled) {
-				nv50_audio_enable(outp->encoder, nouveau_crtc(nv_encoder->crtc),
-						  nv_encoder->conn, NULL, NULL);
+				nv50_audio_enable(outp->encoder, nv_crtc, nv_encoder->conn, NULL,
+						  NULL);
 				outp->enabled = outp->disabled = false;
 			} else {
 				if (outp->disabled) {
-- 
2.55.0

