Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4DD606A327
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ZnIRwvRl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E29A10F092;
	Sat, 14 Nov 2026 18:04:47 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC0710F092
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 18:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1794679464;
 bh=iNjuddUwp0F/NvBRewhXZhhddFnwPV+N1qaUj5S+D0k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ZnIRwvRlvDwDjkz6WzFF94EKBAqlfjeG9sGnbf30culhS7Y4DOUxad9401EG8tjgh
 hQPAfeFO27jAkaU6PpS7dMkW58EO7PVL3c9Kv9fpCGSGxSFThE+DTpexIT1Oas8yWr
 C/c7tPfPKbRXAz15iE2nJ44unfDWmCd0V1JkUyet8rItHvLiclBvAomzd4vMoSFXXa
 QCrAwdmellqQHsQ33KwDUnEaqd7sdg3mSlp3hxgKjJyNPVtqu546cvIHZhZmUN/TTn
 EWWtXl+fFNWvnDAf9SIqDUrUkf08tGFhNfY35BeuCFD4NqTIGry5hcjHITYnN1RcVg
 36c+k1CW8KgIA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B959017E35C9;
 Sat, 14 Nov 2026 19:04:24 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:34 +0200
Subject: [PATCH 10/25] drm/connector: Drop redundant max_bpc field
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-10-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 =?utf-8?q?Robin_R=C3=A4ber?= <robin.raebi@gmail.com>, 
 Igor Paunovic <royalnet026@gmail.com>
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that all users migrated to the new drmm_connector_hdmi_init()
signature, max_bpc is provided through struct drm_connector_hdmi_funcs,
a reference to which is already stored in drm_connector_hdmi.

Drop the redundant connector->max_bpc field and point its users to
hdmi.funcs->max_bpc instead.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Robin Räber <robin.raebi@gmail.com>
Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588 Orange Pi 5 Plus, dual HDMI
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 6 +++---
 drivers/gpu/drm/drm_connector.c                 | 2 --
 include/drm/drm_connector.h                     | 5 -----
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 97027dd17276..a85f85b844cb 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -320,7 +320,7 @@
 void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector_state *new_conn_state,
 						   struct drm_connector *connector)
 {
-	unsigned int max_bpc = connector->max_bpc;
+	unsigned int max_bpc = connector->hdmi.funcs ? connector->hdmi.funcs->max_bpc : 0;
 
 	new_conn_state->max_bpc = max_bpc;
 	new_conn_state->max_requested_bpc = max_bpc;
@@ -678,7 +678,7 @@ hdmi_compute_config(const struct drm_connector *connector,
 {
 	unsigned int max_bpc = clamp_t(unsigned int,
 				       conn_state->max_bpc,
-				       8, connector->max_bpc);
+				       8, connector->hdmi.funcs->max_bpc);
 	enum drm_output_color_format fmt;
 	int ret;
 
@@ -811,7 +811,7 @@ static int hdmi_generate_hdr_infoframe(const struct drm_connector *connector,
 	if (!connector->hdmi.funcs->hdr_drm.write_infoframe)
 		return 0;
 
-	if (connector->max_bpc < 10)
+	if (connector->hdmi.funcs->max_bpc < 10)
 		return 0;
 
 	if (!conn_state->hdr_output_metadata)
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 2fb6fc0243b5..95dd4012580c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -658,8 +658,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	}
 
 	drm_connector_attach_max_bpc_property(connector, 8, hdmi_funcs->max_bpc);
-	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
-	connector->max_bpc = hdmi_funcs->max_bpc;
 
 	if (hdmi_funcs->max_bpc > 8)
 		drm_connector_attach_hdr_output_metadata_property(connector);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 312638824918..262bc4d91a3c 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2446,11 +2446,6 @@ struct drm_connector {
 	 */
 	struct drm_property_blob *path_blob_ptr;
 
-	/**
-	 * @max_bpc: Maximum bits per color channel the connector supports.
-	 */
-	unsigned int max_bpc;
-
 	/**
 	 * @max_bpc_property: Default connector property for the max bpc to be
 	 * driven out of the connector.

-- 
2.56.0

