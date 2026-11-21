Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A86606A33F
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Rx5XFgrN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66E810E3D8;
	Sat, 21 Nov 2026 13:12:19 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAF7310E3D8
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:12:12 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266731; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:RA0nJl88Km6HVzvUbAM7DRw1FJxW
 H7VSo51sPv+bIOoEMmbtg9764rk+qHzyy6IfnFLeNqmOOrOgE00nFrOj6oVRlO13sB0FKBy/hlZ
 VNj14tLoH3FeG7MldGDUXSX3BG41ttsisRjSrgPWEJNj+vmqRg1w+myIgrnfLcBA2V5eqraxsQn
 AuIMCBXwyFBu5/YzWiA7fjd9bENXJ/AHENy43xnmC6A197VhuARXdb+D4tNYI5J6phf63JeX4SI
 6VeUxeXsG6i438yHf+wDC/nOcZImugBaIagYGzz+HApUiwK+SvCXyZrBUrva/WSQ0dvyGPXV/Jb
 7CschVHNJAuzIw==;
Message-Instance: m=1; h=sha256: wehvaGY5aozvu712ppdkNnuNInvv8CQPg4ewY+79isY=:
 YMQaZYoWCEjZOJsUNyybSKHgjzBxXSFJYQFROm/a2XU=, sha512:
 OptSNXW7dxPzXFTgIlRHk4IZmnqkhe0Zown4JpUreVfC5VNmiZDYpl3JUi8h2aXW4MEr2W2Sexgp+lvTPXLTqg==:
 FT/AaSNAYckRnn/8OXRLi6UXf1gW2Q/piN1adjDGh9fYcHZlLQURaILpNLfHl4HxNIoevOewoNtngv8SWnF8+g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266723; x=1795871523; i=jan.claussen10@web.de;
 bh=CCCBgC3t202EBUvzUuRYpuK9FpeOT8mgidQb08HiPmk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Rx5XFgrNinHOTwA12e2G4qbB+W4i8IxGp6yHYPClqDpqr9qDHLrUH4IM9eJPKvHI
 HzzB85skBB72sm3ngBNoiYePbDA/DrceppxdZlYMBBeCh8OtNzCRXLYCgaAu4645J
 MgghW7/gpfxmzOVrgr/HlrXxeaDz2jASkZZ9GREvxAXLe35sCNbwC0MnsWQLcM91r
 artp+z/BLX/PrOJwtmAb5abdu1fP/UKluff44yl5L43Zsux34dK44+Ee1Q6Ip/S9W
 UCPFQVJWXbWb0iDhnUW5KBb2q8Z+MZwFHuoQrH8mAslxgS25Ui60jYuWdKrSzRtoV
 2iMOTaPWYPxeyWkwsA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MMp8Y-1xnWkw2ldc-00Y5M7; Sat, 21
 Nov 2026 14:12:02 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniels@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] drm/display: hdmi-state-helper: Force modeset on
 colorspace change
Date: Sat, 21 Nov 2026 14:10:56 +0100
Message-ID: <20261121131126.3358-3-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EVhLRaXSN8LW3NyP76g/kv1zQLScHkFYw3Snl3LcCBe/ZYzAssQ
 pGaBO7Vq3pKube13+MZMJrcGLDRBD0VgVNaQp4AHVmRyxOh1TSGsqiMGc52+HBTpozcg0Rc
 wqqLt460uaLu7sWwZIhg83nmw6DhWdClHyEGdsPLB3dRsOJ67SISNlrSoVR0OkKqQNhdJEe
 HbX4kOki31jSuNWhhrAdA==
UI-OutboundReport: notjunk:1;M01:P0:J3V+biQ5YlY=;/AmlSlDUbnbCvaJRRE91UIZzhEp
 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
 pjqkn2/o7AA==
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The colorimetry signalled to the sink is part of the AVI infoframe,
which is only updated on a modeset. A change of the colorspace
property therefore never reaches the sink.

Treat a colorspace change like a change of the Broadcast RGB, output
bpc or output format, and force a modeset.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu=
/drm/display/drm_hdmi_state_helper.c
index 7cdb7ca3dc12..9368e53c5945 100644
=2D-- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -925,7 +925,8 @@ int drm_atomic_helper_connector_hdmi_check(struct drm_=
connector *connector,
=20
 	if (old_conn_state->hdmi.broadcast_rgb !=3D new_conn_state->hdmi.broadca=
st_rgb ||
 	    old_conn_state->hdmi.output_bpc !=3D new_conn_state->hdmi.output_bpc=
 ||
-	    old_conn_state->hdmi.output_format !=3D new_conn_state->hdmi.output_=
format) {
+	    old_conn_state->hdmi.output_format !=3D new_conn_state->hdmi.output_=
format ||
+	    old_conn_state->colorspace !=3D new_conn_state->colorspace) {
 		struct drm_crtc *crtc =3D new_conn_state->crtc;
 		struct drm_crtc_state *crtc_state;
=20
=2D-=20
2.56.0

