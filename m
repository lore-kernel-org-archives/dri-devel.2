Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77D0606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=ZTuMAimv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F17610E9A5;
	Sat, 21 Nov 2026 13:12:51 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A4A10E9A5
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:12:44 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266763; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:q09oKANGiOwOiTY/GXxeeGunxq5g
 2xSOj3+RTU3RlIXHqK5DX8wxIZvqeUmylR1o5rLNjWpfex/PF9AtYpVVbzSL9xlDOjTR5kfK0EW
 CcL+jj6zBC5uaBVYvhNi4QlI2612FYz/k2qFcm9vfD6Ot6Wypkc+0kR9s6U//UCdNKn8VjCLEID
 y+Wd5cTT7hjDmYzOHBNhYxa/zfh4CkqSb7betrSRXy9PIXTQCHuvLXl/TcDOve7TaebrbW72Eut
 7+si7HjV06xDlUTfy3QQI5y/rlMWTTQwcVf4t5UY/QJUpiZ9N/XzzTpxu6EodxBbrrGzpDGaGFt
 ekCwuxvFU/1P1g==;
Message-Instance: m=1; h=sha256: dKiQU5m7rsUd9cGOrp9WljOL8sfjdFNq6Mop8yt+24s=:
 sTvwfobd69grKzlHxq4/6OKAk3Hsa2Jl+SuKHFRpz2o=, sha512:
 eKpuKKupGeSugJ7gJSIARfw9RiE7kltEbhUUVmdqdyOp4NedJhAHtJs2DKbszamDC/av0HYlEDIb6evivI0BZQ==:
 J39Fhn0mDd8freq58eAVG6Pe+fi/IjYmLl3hTSQilDS0mNyu/+otTtNjaOLekszhQOLrw9nePd1A0IZxxRm43g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266749; x=1795871549; i=jan.claussen10@web.de;
 bh=G4nmuM+bqcOQtIPOY3msxgjT9MI21X16wTT14DXaYjs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZTuMAimviWbPXnguLAfFwP6itpxFTzJkkSZPhogmDftWn6p6WAOimLRaEn8+Ait6
 IhjXrrXTmvX4i1pIs1inGNWXW+d9gYLyU6IvUXkx9qKgk6Kvo6zMGz65PuZY5GFSu
 QO5sDZtlvY/Xde6xEoueil8+RDaknK72NpMJdC6Z/36c+EWyVeMpqugXek88DYSFP
 b4p4w2PBTQ6e9ejNZoiZuxTt25HkOzY2FQtEJX6x6g/KTo6RFaJ/+TSmXjO+9bsnv
 /lPfOOuWBpkcQTNEuBcNNxiMx+kNCqgOkUjo5AjpEhtydNEGhgKI0DEGygwfkO3mu
 2YCNxAK3eAaDRD9izw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLijs-1xmQIe2WJs-00JLeZ; Sat, 21
 Nov 2026 14:12:28 +0100
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
Subject: [PATCH v5 4/8] drm/bridge-connector: Pass supported colorspaces to
 the HDMI helpers
Date: Sat, 21 Nov 2026 14:10:58 +0100
Message-ID: <20261121131126.3358-5-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZP3tpQxnMROr6GEDFOEf9bDLbEMJjQA+R9vU6JUnDokb669WStA
 j3SoxdgtcJDYQ7KxZ87oxAJtzye5Hr9xdoSWrnzJDmxXdEIYqASZDRXgZShe2mnSHfDOUOU
 2pvf/jFJ7NLjgp4QFwFQ7BWEdcPbAnn11DXSjrD+WsBU6Kysa58+f2yc0hRyvFeNCKyJlLv
 4snimk21ZwoVbc7GUYPgQ==
UI-OutboundReport: notjunk:1;M01:P0:Uv6kKvtqJVE=;qeytXYzKgvB3bnmwyuuJEKKIB1T
 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
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

