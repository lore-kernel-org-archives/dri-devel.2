Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C506606A68C
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=MJtRyZUT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D56910E409;
	Sat, 21 Nov 2026 16:08:24 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CED410E409
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:08:17 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277296; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:dYxwfyusk5LTtfGCD1AvO1OOt/b0
 sYGhDdo9uqse3giAoYw03SlRqYmHHTtb7h2gc39D/Dp6WAF1iJ7pUzQEqvcNnTvR9gr3WVCijaU
 B/4C0ONfueVN+veKN0XJj1WWGtCIls2KFw0jY4Y/6NfyN4ZfYI179ShXSjQ498ni2RW9c6B9sOp
 S/EqmkmN8MdIdz19BM/EeX5R1mJAB/dWG6nNbYaC2xMSwiUSms8N/ncyZKyOAhKRRPZ30srduaC
 iRcQXSlvzAfJAHbuRXDOXuDHPn9m02h7WGwgAOCRRcLceFYaCXbn7mVefFxF+ZZObNGVgGjlVdC
 zp/nBfmhaoX1Dw==;
Message-Instance: m=1; h=sha256: WYYhVUQPAvYaaFqxp23DuqhiqnmY8Bx7aZx7h8TKeZ4=:
 YMQaZYoWCEjZOJsUNyybSKHgjzBxXSFJYQFROm/a2XU=, sha512:
 5/mRYal4THBCN05PW1ECNzkjSy+967wg1366NkC2tr5lEcbdwr4ww9v7Raokk06Y8wYTHU4E5dxOOzSlVS//nA==:
 FT/AaSNAYckRnn/8OXRLi6UXf1gW2Q/piN1adjDGh9fYcHZlLQURaILpNLfHl4HxNIoevOewoNtngv8SWnF8+g==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277278; x=1795882078; i=jan.claussen10@web.de;
 bh=CCCBgC3t202EBUvzUuRYpuK9FpeOT8mgidQb08HiPmk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MJtRyZUTJHKcxjzT6OojsUUyDRvhA7BEQTqJXGIDBn1PvsAKsrxe7460a4TyXYds
 ZLbCQl7DqA+B3xaVLc179QTndvLmOi0w3GaFM/hHVldqvsnxQV1TaasHbr+/EVyoD
 5vQSe1wbDh8dAsLawHj7cQ69PchpW1Oz6CsahH+81bL2GsrHgAhClEE/PN/tbVXY2
 IQnC6dgjMJs3vouAufzysmxy/4jJJrwOhktzGwKYXVf0uEFmuinSB5QNC5jFuY4Dn
 TVC6azPN+uhNOvSsaO5GmlHXJyGuKpBXxdEqCghB4avuKIu3D82Af/bhLreLQgXAS
 MY4e6qTKkOF/FWQQuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8kAN-1xYwMJ1WyH-005PQm; Sat, 21
 Nov 2026 17:07:58 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniels@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 John Harrison <John.Harrison@Igalia.com>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/8] drm/display: hdmi-state-helper: Force modeset on
 colorspace change
Date: Sat, 21 Nov 2026 17:06:54 +0100
Message-ID: <20261121160725.6344-3-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:155fnUVSc4YP8Pd9YrXl60V/GMI8CDWwc2CX0gT+/o7cLGCf8oF
 EteeQK0tp2+JyTvTek4mHnBkwmeGspcYc40+Qxwqa4ex5rSMM6oSlInp6Z1f4Ma0G3uRYzt
 Pp0hZaBUOuHFpfhgel33RZkmYY2y6ZWY1M2sYojm0Rax22TT8BJSn4sVR9ypHqxUZO8XDty
 cd402N4d7bsf3h9k/68FA==
UI-OutboundReport: notjunk:1;M01:P0:J7DoBMCU804=;TzEqN/pLsSZfCR6yHB3v3PQaXaO
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

