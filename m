Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0BF606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2pmAGhZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC6CB1125AF;
	Thu, 22 Oct 2026 12:36:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C357D1125AF
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 12:36:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AA495416EF;
 Thu, 22 Oct 2026 12:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEBC1F000C1;
 Thu, 22 Oct 2026 12:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792672588;
 bh=S8UiPcqQkHi6xVS+in3jZE5Rm7CqkpJsXtihlQt8oF0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=n2pmAGhZ3kKcLVrxZvAY0RPTHX21oSRgzzjHjv1JDmzraMxm4bTb7B+ZJKJlUNzXx
 3SNTALJabK5ca4CO3Qb6M4WpLYfdWqjSZCDEjcA8sS2bVHXyxEOhLP+A1XdFE9OHna
 KdKnCq5CuPNoFIWIy6noPzTR6jnQ6nwgYFOfJlclVCLkRSyTlDSfjjn1kBfyG0vZRO
 j1NG74J4257/kJ6VlOu9d/5GrmuJXMxduYovxeep6SFAcdpVwmG/A88J036Uwh0V67
 kICd/uqKO3B6u5YmfHxyQVk0bbSanFzy8aWhhDDPZWUDlEWwB5xIFxsdVmjZUoSno+
 2nzRdOEJQWiZw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 22 Oct 2026 14:31:44 +0200
Subject: [PATCH v2 45/59] drm/meson: Convert to atomic_create_state
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-drm-no-more-connector-reset-v2-45-0b7e4e85b1e8@kernel.org>
References: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
In-Reply-To: <20261022-drm-no-more-connector-reset-v2-0-0b7e4e85b1e8@kernel.org>
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
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm3mBZerT5gzn5xPvvSHat28my4HRJ0ZMkCHqsvPKd6/
 9t976xv75jKwiDMySArpsjyRCbs9PL2xVUO9it/wMxhZQIZwsDFKQATebmJsWECs+jfuR/SZitF
 zPk9o3eXo5PrtH22Z05zMXEdX7XlqHIbQ3rI2sLrDxqLPu+qaZopeISxYeriuIzFIiaJgn0HClK
 tJumdestT4KRlveMMV+OsVwFrxHc9undYNWdjcnOMvDDD3a89AA==
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

