Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B02B606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nMTYyTOm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A64112878;
	Fri,  6 Nov 2026 13:16:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAD6010FCFD
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2FCCE601E3;
 Fri,  6 Nov 2026 13:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7831F0089F;
 Fri,  6 Nov 2026 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971012;
 bh=qG0gUMXNTLAjVBMHMniiZ1MGikNikgMpUD8ziq0I+Fs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nMTYyTOmp551NtEpawZJ2DlMmnc570RqU2cks3DLlrcuhpiAcT6AGnDJahzSyQR4o
 SkHZgfS/P4UYHExAAS2tN3hK2xW+zYz34dvlaKsW5cr2P4CqPFQxXl7SrtVMWkykKC
 VriXHXr/VzjU4eI1H9kqgv3ebybhWrIVn6tDwYdyJVYbY5m7QZy22jU2KOc+QsClXw
 R5+FRPeVIpQk+mtdfw4bSCUA7I5xXGQmS6FrmFH9Uw2OJQSPs+78hldZyW4161M8E7
 7CQua9GggLzhQr5vvTzzAQqMHgk5RrnzhgjTNy7llCnwpfUZU78QDq01tIHIqSTdUH
 JfhF+oRvo3EjQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:49 +0100
Subject: [PATCH v8 36/39] drm/tidss: encoder: Implement
 atomic_sro_get_current_crtc
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-36-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=mripard@kernel.org;
 h=from:subject:message-id; bh=ai7JoIhfpveHCS6N0NMydFxCg8pvmQFkCNk35yx8neg=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+0JCrjN+POw2yM3w+bjXA+SXGOeuVafvK6y1NFvU
 q3ygSsxHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiPVGM9Z4u3YGWJ92Zvz7S
 i/vQz3Tx0NrN/137v7P8KV9VMHXZ1dUlE/OEE9Sap+Y5JO2OzhJrZ2xY/i+5N7/2xnLeh0/N7j9
 6VN6Z+NF83s7/f0UL2faX2bkmn3opEukjc8eFKU+dbcEH6yUA
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

The tidss driver doesn't really implement anything with encoders, it
just relies on simple encoders, bridges and drm_bridge_connector.

In order to figure out the CRTC -> connector association from the
hardware state, we do need encoder support though, through the
get_current_crtc callback.

Since the tidss encoders are always connected to a single CRTC, we don't
really need to read the hardware state though, we can simply return the
one we know we are always connected to.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_encoder.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 5034e601ac86..1ca054a3cd87 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -124,5 +124,20 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
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

-- 
2.55.0

