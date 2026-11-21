Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F0606A330
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=TeoMtUBG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F96A10E414;
	Sat, 21 Nov 2026 16:09:01 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E72A10E414
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:08:54 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277333; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:VCga6AIqmvop0k0fEOJlCz1XMrWV
 DrzJkNnnosoYBGL5wnv/DpEo1/KtiqU5QX0i19/ix18Ch47ujzL4FHUIbYEJNbcnCXw6J1sa+hD
 myS/rxOuqEWlhF3GX7chxhwWWKjqe4BJNhc5Gsnt8M5r/F+yb9Diszkf1C15UCmtTRnevQZWLGv
 C1FzbMMjbNvkITo0Kf/Ww8i99uc1Rfv9EUTuGFtfQXEPeNIhNutW7ccpxtgywfVidh6wJ1Wpcxu
 OTWoRAljTf9SGDa5f0QZTOTlq32J4lopvQK3T2Rj1qhA3oq3AVVJ6SlXSPOTSbaPs0FI94gO1cV
 3O2TXaQWy7u7IA==;
Message-Instance: m=1; h=sha256: GLrL7RkpE86HoLmbrVfrjX67VFAAFTJs3+lUZJToiW8=:
 sTvwfobd69grKzlHxq4/6OKAk3Hsa2Jl+SuKHFRpz2o=, sha512:
 IcWQGLYvmLnveDQ6VLopWZLcPINYZD1WodmV/Oi0o1mxj+sqg3cwJYTI1R7EleI5U6fWZrD1Py5zCJwbYmj7tQ==:
 J39Fhn0mDd8freq58eAVG6Pe+fi/IjYmLl3hTSQilDS0mNyu/+otTtNjaOLekszhQOLrw9nePd1A0IZxxRm43g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277306; x=1795882106; i=jan.claussen10@web.de;
 bh=G4nmuM+bqcOQtIPOY3msxgjT9MI21X16wTT14DXaYjs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=TeoMtUBGYKtdcuQdNKMuFB/N7ZcQjmbeu9w8kBhC5awA/Cz0IXxhpWu3bI7pL69S
 gRKB3gPb1/vxR1WZPFSLY5XtjRw8UPBeErZsG9pgDT7mygOuFjpG9Vif1TsLMMDjO
 0aWnuAcdrkp+YoKL+C+V8VAEpAZ5znWxBiC5cE0Es/thSBmRFLZXGfueeAmwhXlwL
 rJ2/9EupUu21ajXv24IAtKxbP/hl42/78QgWlMuln1hhxDCx/22tgGtAItBEWRvqO
 KRgRP1Hh1Opxr6AfhldqoRfc3/EygElPEIbi8sj/O5lPgg9rrPHpcy6c1qldBXjX3
 N1aMmPbA4BE7lCCKDA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melf5-1y4ggh1oW5-00pChY; Sat, 21
 Nov 2026 17:08:26 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/8] drm/bridge-connector: Pass supported colorspaces to
 the HDMI helpers
Date: Sat, 21 Nov 2026 17:06:56 +0100
Message-ID: <20261121160725.6344-5-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:o28Z+2TIgQ2o30+mV6QxkT9UtzDiwA1nP+Yd18pFwF8J+w09d6m
 OP0Qgp+d/zNygekfvLGlM/VnGbPk44O1xkjCW3ozu5HutBqZYbu3JZJ/m8Fyhv/K3fTNvLb
 oEW22mXtYlMO+gtTR1xThASBVPay6zr3v3KGQV/Wms/Gay14TMW4R+nHnVPtAHXkPfxn4jO
 2ogrcWw+lAjp+aOBwiXaw==
UI-OutboundReport: notjunk:1;M01:P0:a5pX2xwqwgY=;fUUggZcSLUzSk9SSUDer5z+9V8O
 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
 vGbU5mMT4IVBGqjGccJ/7cIDt/
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a supported_colorspaces field to struct drm_bridge so HDMI bridges
can declare the colorimetries they support, and pass it on to
drmm_connector_hdmi_init() so the colorspace property gets created.

Suggested-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
 include/drm/drm_bridge.h                       | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/=
drm/display/drm_bridge_connector.c
index 81f3e26f6fdf..40f50304c46f 100644
=2D-- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -1042,6 +1042,10 @@ struct drm_connector *drm_bridge_connector_init(str=
uct drm_device *drm,
 			bridge_connector->hdmi_funcs.supported_formats =3D
 				bridge_connector->bridge_hdmi->supported_formats;
=20
+		if (bridge_connector->bridge_hdmi->supported_colorspaces)
+			bridge_connector->hdmi_funcs.supported_colorspaces =3D
+				bridge_connector->bridge_hdmi->supported_colorspaces;
+
 		if (!connector->ycbcr_420_allowed)
 			bridge_connector->hdmi_funcs.supported_formats &=3D
 				~BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR420);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d..b46d34040024 100644
=2D-- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1129,6 +1129,13 @@ struct drm_bridge {
 	 */
 	unsigned int supported_formats;
=20
+	/**
+	 * @supported_colorspaces: Bitmask of &enum drm_colorspace listing
+	 * supported color spaces. This is only relevant if @DRM_BRIDGE_OP_HDMI
+	 * is set.
+	 */
+	unsigned int supported_colorspaces;
+
 	/**
 	 * @max_tmds_char_rate: Maximum TMDS character rate, in Hz, the HDMI
 	 * bridge supports. A value of 0 means the core should use the default
=2D-=20
2.56.0

