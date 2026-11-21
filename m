Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E447B606A33B
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=vXcXDdOD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 352F110E639;
	Sat, 21 Nov 2026 16:09:34 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CFF10E5AB
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:09:25 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277364; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:hiAIZYfDfLRaUDGjrA8vHwpF1lMn
 M3GfirkPQA5vLt1EHPYIgWNTkTbVOBLQrsQFvvKmQTp7paSFaxoHtnsoo6Z3l98y4sNdMo36BMM
 XsyRGx5f1OQlZJ2YJHrjUjTOi5aCUpIqw1C7ydKYWqJoyFPD3waSliMp+PwEaeOFSfSfEwdX+Ii
 rPC+hjs7+y9WtTm6uh4hfT1yxn0Z1aaQPdyzf+9sjLWRxVmLB2kkhQ4cCp3692AjF+Jpex/7pui
 OSb74vKyGxfjYDp7y4gdzfq0vD3+lvGWjYTje7LeT0n2gOzwwYIsacHe25HzgVTsmDzaF9UMS+o
 acX4Ea+1mFx0XQ==;
Message-Instance: m=1; h=sha256: 5NIaQc7CGtIQ5BkyNRggEbll7my6hfOtFay0nVEb/nw=:
 eQTQOpDy20avckqeSwISdmX48gNkRyRt1JlXQY4G2XQ=, sha512:
 cd2ZhMFo+8xsg5rf9LfoF6XV2fbGb9kYfDJ+ISIyXDzK74NBCFAD30+5rB7YRBWQl/Ddn2HCayuU3ookdw1gKw==:
 FBAJ5o00moWgt9VuzBUZBTf1HhHMGElbphV1F/+kpl8ZVRU8FWfKI7muS0EZBcrqj8cLgWgo5YLIwNIDEbYUIw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277344; x=1795882144; i=jan.claussen10@web.de;
 bh=Zsmosk/7xptQZiuCZvG/XXkwmDg6kwdhqizkWSN9V10=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vXcXDdODtQYS4FUKejX0cgvrVt65hNMYh2oMQoCaB4EgYWCOhbHsY9uRKvZmhqsd
 jC2LuCXnxijjXyYvULSLAttJ93Cv2/RaVaUWyQ6GGLbOgpD/D5z4onDV5wAH/bVNk
 jO+Jg16Zn2ez24LCtCcjgxvfOJnMD2AP+umpEtmA5JAv2mrL9mWpHlJa/gHhs6+To
 Lba7KKC0bkO3e4UJde5wRyR9GQSwzomTQvQmZ515B3WBSMQTTQsiAMix4RIhkvael
 hJ0oM9DCbpk3J3PpCu2BAgJ5QqjJfqj4S/jSwefKaWfohu2/HR8zeqvnvMEkn4eBw
 DhMJuzxTekbFMLt6+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyeU-1xp5QI21YQ-00Kz5H; Sat, 21
 Nov 2026 17:09:04 +0100
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] drm/rockchip: dw_hdmi_qp: Set the VOP2 color space
 from the connector
Date: Sat, 21 Nov 2026 17:06:59 +0100
Message-ID: <20261121160725.6344-8-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zDoO2QbrvbdbuRccXH83K0a7z/+S4pNRUxgObQhpNdxdNgqcsj5
 tnq92gvQ2qnXEhoVZkpnvjjcEZM58ZxlXtUmLsx/ZxUr0lL5wDVO7QHXib6afF3OsMFWKFU
 /loe3uyzP/D5KrWYDKKvvj3rhQzjLRxnktE1N5by/bXTBlUILZvDgj3oySdHr7eJEEvqLO7
 SaZHrYhyLDVke2P0eE2pQ==
UI-OutboundReport: notjunk:1;M01:P0:prPxuFbIgJ4=;MfrziTT25gPiDLxiDgxR3bZgjyd
 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
 5m6xcJy1C/4ZeQ3r9kvg==
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

VOP2 converts RGB to YCbCr using the matrix selected by the CRTC
state's colorspace, but the HDMI encoder never sets it, so VOP2
always converts with BT.709. Once the colorspace property can
signal BT.2020 colorimetry to the sink, a YCbCr output would be
encoded with BT.709 and decoded with BT.2020.

Pass the connector colorspace on to VOP2, and do so before the
early return so that a colorspace change alone is applied.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/=
drm/rockchip/dw_hdmi_qp-rockchip.c
index f2a1ea8dfefa..24a28b5f4576 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -205,6 +205,8 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct drm_en=
coder *encoder,
 	if (ingest_fmt < 0)
 		return -EINVAL;
=20
+	s->colorspace =3D conn_state->colorspace;
+
 	if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate &&
 	    s->output_bpc =3D=3D conn_state->hdmi.output_bpc &&
 	    s->bus_format =3D=3D ingest_fmt)
=2D-=20
2.56.0

