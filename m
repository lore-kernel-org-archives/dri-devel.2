Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60849606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 13:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=RgyvUy8P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0AC810E9AD;
	Sat, 21 Nov 2026 13:13:36 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6777C10E9AE
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 13:13:30 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795266809; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:ZMs97cd7QUVHPDvLtFx/LfGFzm/H
 ypcgl9gHaM5nmpFtvecbdjHV7x1huEVHnVBGb7mHq4jNs8mbKuTMGiveilkAqVi65KzxWVg9aAO
 wkGcv/wOh7NtzuqtszQ8oU2nu9Mvz1TeH6E6O7wghZ+eKKHaDdHwlW+tgVNXLw7742/NmBve7FG
 7ZNDD/qH9yVPBliiQRo1mrSayryjVrWpCtHlDi4rY6PJnD5EVocdXXhg2dbzcDabUTDwOybF/Cq
 fylaXgTZO+xmdnwjYMgMEXyf8zfuYR54Jwmxp6O4ojc7Ba6mfnu/AuEyGXWybRfO2XbkFQ2fhca
 nDOz77xhRya3XA==;
Message-Instance: m=1; h=sha256: bcOe9DcryW1J9i0IBf440w7dmAV5ABqSz4fSDGSblpA=:
 MNbnlroO+oZ5zmIfAVPHadYbENFiYq51a9WsJeA6l2U=, sha512:
 GiVZ/3yK3599FIEeGZfOGuLknM0pBN7B7/WziM6iMblLFvasZbOam7SKfSG/4Lr10AkiYO3N8eC8y1qNpID90A==:
 RmlLb4dBOeAe9hINFH0pkE/TQkv0qU5v65L6DPFgdNVQYwxuf277J8pZJHUbmwdf5yaZ6UVxPi0jvN72K7CxIw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795266799; x=1795871599; i=jan.claussen10@web.de;
 bh=/zhVvWZ62jF7UBsDV3xQAhNXtpMVfMUCFkx1iqxGM/k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RgyvUy8P1bqKeuy+Q8bLEh+HTD1qA9to/sHyYBlKAcwpgXzmNZAXPYaYIZXJMHdS
 L8Ibnm+f1fdYLoH2FTbyJVQNXDOsYhlt9PsolhosnWsapZz8Wb1E9JZUczdkbwHlC
 xz4ipQt8tGf88hzZ1xHykCxZS7DWFQphBwMm6N6Omps7sVMoPlqaSgcGeH1YxI4Q3
 JF+paatYSX+ROqBypvvzTeiD8MzWtu0zVwDmDTkgnvMJ3SHCv0g9ZUypCoPC5OZ8Z
 0Oh2o7trvj2HTiRIE0XiIwIvbwOzr9a4jWb6oeEMb9OUJCsAFvC3967R6oJzOnsFl
 7sKoo3ZJc9nz9mY2zA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MiuOk-1y9Imw3p3c-00l5L4; Sat, 21
 Nov 2026 14:13:19 +0100
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
Subject: [PATCH v5 8/8] drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020
 colorimetries
Date: Sat, 21 Nov 2026 14:11:02 +0100
Message-ID: <20261121131126.3358-9-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121131126.3358-1-jan.claussen10@web.de>
References: <20261121131126.3358-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9t17UPhC9K6QoVESTJHwYxsnK2Iv8NbFvgD7dQUOZO7ywyBNr8O
 5sTr+3pXnpQvridgI3H2Rnk8CozGyCBXCUjW8Lg4mBQ2diJ8/IUV1SdGPmtQ8c6zp/sY/UN
 FtUHmnJcm0dOnTcRlber1SNkcqZSjytZbXQi4kL4pVuBDeRjy2rrPg3n0UeFTGuMgV/+Crq
 SlHNwKZA7VyTxUop/jklQ==
UI-OutboundReport: notjunk:1;M01:P0:+5Vs5NatdWE=;M3zp/A5cRlPVX7ujTKKgzl18kp2
 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
 CPX6VAQY7rQ==
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

Expose BT.2020 RGB and YCC colorimetry so userspace can enable HDR
output. Also explicitly expose BT.709 YCC as it is listed in the
Rockchip RK3588 TRM V1.0-Part2 20220309 data sheet.

Tested on a Radxa Rock 5B (RK3588) with an LG OLED55B87LC in KDE
Plasma 6.7.5: enabling HDR switches the colorspace to BT.2020, and
disabling it restores the default.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/=
drm/rockchip/dw_hdmi_qp-rockchip.c
index 24a28b5f4576..890791c5277d 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -644,6 +644,10 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
v, struct device *master,
 				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
 				      BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422);
=20
+	plat_data.supported_colorspaces =3D BIT(DRM_MODE_COLORIMETRY_BT709_YCC) =
|
+				      BIT(DRM_MODE_COLORIMETRY_BT2020_RGB) |
+				      BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
+
 	encoder =3D &hdmi->encoder.encoder;
 	encoder->possible_crtcs =3D drm_of_find_possible_crtcs(drm, dev->of_node=
);
=20
=2D-=20
2.56.0

