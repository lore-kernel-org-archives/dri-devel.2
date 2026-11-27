Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC28606A338
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VEDjhM+6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEA1112938;
	Fri, 27 Nov 2026 09:55:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F0C11292A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:54:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C56B1407A4;
 Fri, 27 Nov 2026 09:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125451F00898;
 Fri, 27 Nov 2026 09:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773271;
 bh=l54Ae+K462y5IIm72TRoUVO+9Vk3uQKE+0AWLy0ZIvU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=VEDjhM+6Nj5UQbg6uB/OJqgPOABdNSSx9Twea+KXKkstukRAzhQoXgHyazbEYWqyY
 YYJaskq+KUmbjw6xCeuy2fTNujm3qtvPNMBkjRaBTvv+ytWgZ4LC/LY5BkhMWhfKhQ
 2fIbbjJtC8RapBp6inaSezFOeByQ22fRIA1aSfkWWZCsw+IvL2epR5k+aQhPgf+vAV
 hpArLoHTNfgOEqNsdQ0FfM9AFQ7TtrUalzzK7k5YRsms4TTuJfBpN6Rv2Yo2Fz5gQI
 /B4B7E01yUwFg0sMVa8vqyjp1K2xq9G7yLmroNPFemN+pwYDnhI0uqCoQE0BwNn8/g
 m5vjZaP0ZKW+g==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:53:03 +0100
Subject: [PATCH v10 21/36] drm/encoder: Create atomic_sro_get_current_crtc hook
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-21-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=mripard@kernel.org;
 h=from:subject:message-id; bh=OZJEDMCz9eHw8SfkZcqJQoOJC5Z+ZaexUfbO/Ew/qHQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcwawtd7Nvu93Mn8S/53GA/7xtj2/N3Dtdbs50p9Rj1
 nf4UjZWd0xlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJvBJlbNgRWso/wyh1joXd
 Ue25W3e3BK0POPnrsbxvn1mU9ufKWt7bfI+2aT8zKuCcx3QyMudVGmPDOxGua0sclRm93hVM0Fl
 Z/zPkzY3My6vLPr2/qsMWJubepPJz3sfJakw3XltVzu+V+6QNAA==
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

In order for drivers to implement drm_connectors
atomic_sro_readout_state hooks, they need to query the hardware and
lookup the CRTC to set drm_connector_state.crtc.

It should be easy enough for drivers that are tightly integrated from
the CRTC to the connectors, but if the driver uses bridges, there's no
coupling between the CRTC and encoder, and the bridge driver.

The only thing the bridge has access to is the encoder, but the
relationship between a CRTC and an encoder isn't a fixed mapping at the
framework level, and thus the bridge can't deduce which CRTC is feeding
its encoder.

Create a new hook for encoders to implement to return the
CRTC they are currently connected to.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 include/drm/drm_encoder.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/drm/drm_encoder.h b/include/drm/drm_encoder.h
index eded7c34481a..7f41ec0a68dc 100644
--- a/include/drm/drm_encoder.h
+++ b/include/drm/drm_encoder.h
@@ -87,10 +87,28 @@ struct drm_encoder_funcs {
 	 * @debugfs_init:
 	 *
 	 * Allows encoders to create encoder-specific debugfs files.
 	 */
 	void (*debugfs_init)(struct drm_encoder *encoder, struct dentry *root);
+
+	/**
+	 * @atomic_sro_get_current_crtc:
+	 *
+	 * This optional hook is called during hardware state readout
+	 * to determine which CRTC is currently driving this encoder.
+	 *
+	 * It is needed by the bridge connector readout code to
+	 * establish the CRTC-encoder-connector association from the
+	 * hardware state, since the relationship between a CRTC and
+	 * an encoder is not a fixed mapping at the framework level.
+	 *
+	 * RETURNS:
+	 *
+	 * The CRTC currently associated with the encoder if enabled,
+	 * NULL otherwise.
+	 */
+	struct drm_crtc *(*atomic_sro_get_current_crtc)(struct drm_encoder *encoder);
 };
 
 /**
  * struct drm_encoder - central DRM encoder structure
  * @dev: parent DRM device

-- 
2.56.1

