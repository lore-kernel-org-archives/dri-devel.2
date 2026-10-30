Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD26A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8mFDHE/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BF6D1128A7;
	Fri, 30 Oct 2026 15:15:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D39C11288C
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 15:15:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D531D602CC;
 Fri, 30 Oct 2026 15:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112531F0093A;
 Fri, 30 Oct 2026 15:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793373331;
 bh=S8UiPcqQkHi6xVS+in3jZE5Rm7CqkpJsXtihlQt8oF0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Z8mFDHE/9BRhItfU5gT1EqXIUER9/2PJzjgA/9N9RnMKAeCgoAMr1ndTndPAD7O9C
 1PT7D/Jq1yH9h/oU2W1WZds6zG0+kDmfPBRkcv03+iSvbMBDQ0yY2AP9yK/+mDFFAL
 D3d76s7QPLQX/Li8yrEYvpTUCxu3DCDR0kTrCPvsspU7475/NdsWxFhKnfJbVDWbsy
 1H3W9+vYPUOwhzOwTtfcPIERoEcIyvO0KmNZdMTekTimh55oBpnZqXv/cd+8x2OLN9
 O3sBsvBGnuVSqqMvnrEV8jvPeCEzkxcNxc7Ahz6RrTXeiOGLu9/sDtCDJKFXiBiSnq
 duQAZg3xE0hGw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 30 Oct 2026 16:13:57 +0100
Subject: [PATCH v3 27/37] drm/meson: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-drm-no-more-connector-reset-v3-27-30e71d92c327@kernel.org>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Maxime Ripard <mripard@kernel.org>, 
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-amlogic@lists.infradead.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1592; i=mripard@kernel.org;
 h=from:subject:message-id; bh=lLWvU5PeY16j7uLhvTnNxShHdF9JrvsjFJ+4rAws3vk=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlPtmiWbry+f+p9sQdbsxMaGJquBrvIHtFa/f3gol3xx
 krez7dwdUxlYRDmZJAVU2R5IhN2enn74ioH+5U/YOawMoEMYeDiFICJXLjCWO+z1UlOLayTIdz1
 7YtkdyHWq2fOFD9IrJvjuHiddQ370g+dp49pz73zSUXEcU+VyMX/fxir2RZNVL057UcOx8RGJeW
 Lr8QupLE2LApdMW9/+u9iXxnz6dYbd3CWyJ25N4VbaN71H7uYAQ==
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

The meson HDMI encoder calls drm_atomic_helper_connector_reset()
during connector creation to allocate an initial connector state
needed by drm_connector_attach_max_bpc_property(). However, the
driver only needs to allocate a pristine state, which is exactly
what atomic_create_state provides.

Convert to drm_atomic_helper_connector_create_state() with proper
error handling.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index c4355c5cc340..eab2e969d791 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -449,5 +449,15 @@ int meson_encoder_hdmi_probe(struct meson_drm *priv)
 	 * connector to have a state.
 	 */
-	drm_atomic_helper_connector_reset(meson_encoder_hdmi->connector);
+	if (!meson_encoder_hdmi->connector->state) {
+		struct drm_connector_state *conn_state;
+
+		conn_state = drm_atomic_helper_connector_create_state(meson_encoder_hdmi->connector);
+		if (IS_ERR(conn_state)) {
+			ret = PTR_ERR(conn_state);
+			goto err_put_node;
+		}
+
+		meson_encoder_hdmi->connector->state = conn_state;
+	}
 
 	if (meson_vpu_is_compatible(priv, VPU_COMPATIBLE_GXL) ||

-- 
2.55.0

