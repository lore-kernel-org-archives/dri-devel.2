Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99B4606B784
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=PjBK1IWl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04AD1121B5;
	Thu, 29 Oct 2026 10:19:26 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC1A1121A4
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:13 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3C83929;
 Thu, 29 Oct 2026 11:16:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269018;
 bh=YhUarWvkFmo5BAU7y6W2c0/rlDRAPf7YwZkgeidtnY0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PjBK1IWlqxPl565SY8k/Fk6uWiGjuOHjYOxbz8dQNajdIJy1qOQMghOyvrSP1SjD8
 aH6MWMdQlwcL+HXuH7fv38pwh6uQkPDvwgQAgwh/JSOUcWzOGjJqYa5hhwO46qywVT
 XMZd9J5TYRAXaQWiA2Hmigxn3ZF5LYUzjVc0kxo0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 29 Oct 2026 12:18:49 +0200
Subject: [PATCH v4 03/14] drm/tidss: Stop using vp_bus_type for directly
 connected panels
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-beagley-ai-display-v4-3-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
In-Reply-To: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=YhUarWvkFmo5BAU7y6W2c0/rlDRAPf7YwZkgeidtnY0=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2WAngQ2+yyxc+nNGt0VaMvb+tX9kwxHQ4m7
 6QU5zeNBdmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdlgAKCRD6PaqMvJYe
 9ZUbEACczkH4P+K0PGpZmASXOjmy5o8O68zj7a6M5err0YVTSGPXA+tq8V2B25nnliuigC4Dn1E
 u8Zfez5MdSd9wJg8T46y0uTaMz6M8+M4RtCBIZDDAxOSEIaE96KUkUEH+UBjsGCv4+HEtEZSXUO
 qlppx04cTv0FOVNzf6+sFrJKbDCaGrNtKYUJDy5R8tlMBhUcQfiFyhEP78WZ1E/IOwwKApEGw9e
 oD++x9/CD46C4qS4sbwWZE9jxPTAkjXeUHIBRZkVeFkS70sfJWJmUroRHTYSTyZiiZPRmPpFheH
 nhQXt34mv8RuR3/8E2r70IoFhVgOxHgtM+4fenTa/+a0U1qgNyGaroH/dZkYVF6C9BfWPuHCN0C
 WACYj53lAyvUY3nYqRiO5xhy1FjiYNsUgE9wg1mJ6MpKEeudbpNiA42ezr7keh1cZvJfZ9/XsSa
 QwUtPGTTZsbZErs/4xQ30tDh5sWUfVv7kxAcg16AWncKu9ZuGnKBQK6TsUQ9u1Qxyh9qPn+amM3
 lGFlEPgQX9mGWAv3I00EtU3lqfQt7VQk8EvEu5BptpkUJsgRYXApLSGhZIw97P4DJisNYIy6RQF
 Z6GXvyqLbF/mDrl0judW/UF6x7ZrtzIVzrsySFJ0D/raPKpfvb6g5aFKe46Fpj2nNQF97u/QJ5y
 ASrP7p7hHOKEfRQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

When a panel is connected directly to a video port,
tidss_dispc_modeset_init() sets the encoder and connector types using
the 'vp_bus_type' feat. DISPC_VP_DPI selects DPI and DISPC_VP_OLDI_AM65X
selects LVDS. Any other type triggers a WARN and fails the probe.

vp_bus_type is problematic and is going to be removed. Change
tidss_dispc_modeset_init() to use dispc_vp_is_am65x_oldi() for detecting
the OLDI case, and default to DPI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_kms.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index e55e7532e2f7..8b9c5fa96e47 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -232,19 +232,12 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 
 			dev_dbg(dev, "Setting up panel for port %d\n", i);
 
-			switch (feat->vp_bus_type[i]) {
-			case DISPC_VP_OLDI_AM65X:
+			if (dispc_vp_is_am65x_oldi(feat, i)) {
 				enc_type = DRM_MODE_ENCODER_LVDS;
 				conn_type = DRM_MODE_CONNECTOR_LVDS;
-				break;
-			case DISPC_VP_DPI:
+			} else {
 				enc_type = DRM_MODE_ENCODER_DPI;
 				conn_type = DRM_MODE_CONNECTOR_DPI;
-				break;
-			default:
-				WARN_ON(1);
-				ret = -EINVAL;
-				goto put_panel;
 			}
 
 			if (panel->connector_type != conn_type) {

-- 
2.43.0

