Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99711CCA462
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12C610FACC;
	Thu, 15 Oct 2026 15:11:05 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1130210F66E
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:10:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8807D60200;
 Thu, 15 Oct 2026 15:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABBB1F000C4;
 Thu, 15 Oct 2026 15:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792077053;
 bh=SPEO8/kOBmQuC0kErJSms70HjQspFJbY8FZH7tt11p4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=eYcLsVIW60y5wG970n6LshywpyV0gYKvquJV7YAro0/1GkBseH7fIXfG3k7NYQMKu
 Fm/l8xOzUrFZqWWVave4nJkstXqduxWXRNdQu02+SgnR/xSxPONWf0brEfqO/H0GLk
 ptawrnrVQaywSvKVMNwH5N2xA10TQXKwGUmF9QUeQZT5r4N8uqAnhn7psY+RlAtaRY
 CwnOq/UbT096HYgH8EoxSyM9YHOl7Ai9Fx+VrUiMLSJyydsYrUWfUEp3pPqkoFSwKI
 +P9XMPgT4TNuW53pevkyBlF6W+QVHRRAMOEn6DgEdoZvXaRpDoWOrDOOA5VvPe9XFt
 wKKH24eNCcDPg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:09:19 +0200
Subject: [PATCH v6 27/28] drm/tidss: encoder: Implement
 atomic_sro_get_current_crtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-27-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760; i=mripard@kernel.org;
 h=from:subject:message-id; bh=+pVbVwdlCvDiSzBb0dvHg2XJCgEw9Rk2ihi2oD0Vv68=;
 b=kA0DAAkTJ1/OGaI9vnYByyZiAGrQ7Jai7cCJHg0IkArUqKsNDFlxSiBRI89/2eYmk+RRTVwe4
 4iVBAATCQAdFiEE5BxWy6eHo3pAP6n4J1/OGaI9vnYFAmrQ7JYACgkQJ1/OGaI9vnaDUwGA3cUE
 WuTOy1GthpF4QeQ9TnlXUaVQDdarN7WVYbd/ps3xEWqoF/cWHsEuMom6Vk2GAYDGoWGAG12AzdQ
 g1SbzfSC5BZGg7HN7XBX44g7WdF4GvYAA3hiDXpisIhbfd4WDqRg=
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

The tidss driver doesn't really implement anything with encoders, it
just relies on simple encoders, bridges and drm_bridge_connector.

In order to figure out the CRTC -> connector association from the
hardware state, we do need encoder support though, through the
get_current_crtc callback.

Since the tidss encoders are always connected to a single CRTC, we don't
really need to read the hardware state though, we can simply return the
one we know we are always connected to.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index cb4b8feb90d2..ec995335953b 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -121,11 +121,26 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 	.atomic_sro_readout_state	= tidss_readout_state,
 	.atomic_sro_compare_state	= drm_atomic_helper_bridge_compare_state,
 };
 
+static struct drm_crtc *tidss_encoder_get_current_crtc(struct drm_encoder *encoder)
+{
+	struct drm_crtc *crtc;
+
+	WARN_ON(hweight32(encoder->possible_crtcs) > 1);
+
+	drm_for_each_crtc(crtc, encoder->dev) {
+		if (encoder->possible_crtcs == (1 << drm_crtc_index(crtc)))
+			return crtc;
+	}
+
+	return NULL;
+}
+
 static const struct drm_encoder_funcs tidss_encoder_funcs = {
+	.atomic_sro_get_current_crtc = tidss_encoder_get_current_crtc,
 	.destroy = drm_encoder_cleanup,
 };
 
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,

-- 
2.55.0

