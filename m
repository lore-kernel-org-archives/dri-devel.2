Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4532606A680
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=Jv62Ooxz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA5710E620;
	Sat, 21 Nov 2026 16:09:34 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F9810E620
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:09:27 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277365; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:rN935kJAvtWmX1Q+wpjPobXRBtzb
 G5LdtepMirr4lpBCF921goHbB8H1HXqe2gOYrscsiB/pcuzLGhNHb6LXgnEbkr3t4hU6RQdbMt1
 GP9YJMBFUJe8OQ4xrqfIsJpbVcTos/HLhHJMIPCErzOXFibMzzzQO3xf3UrocJKtd37LLM6of7Q
 O09YYOP/0mnz+XAQgXElOSEEvEQllusfPttVFg1IfPkeCX4Ijb+BxxKOHDQIGHBJaxM03QnlvD5
 w5jL2bwS1TnTaXCSFMd1gcutynAbVQPRCsckoCSd/c38Rf78kKLVmna0HxrQBRMX/eMLFafO65N
 j5l15yt/mqujww==;
Message-Instance: m=1; h=sha256: muNAWMUsDeUGTKO9n/9UH9IqzcKM6g5mP1dZ9zkJ1YM=:
 MNbnlroO+oZ5zmIfAVPHadYbENFiYq51a9WsJeA6l2U=, sha512:
 qgJrCLbIjWLScuZ3x4LX8I9JrlsY2hwtEOKUSSnRVXmD1pKD/E8IM5KxiB7BtZqd4Dg20BWExpUBH7K2mnNaBw==:
 RmlLb4dBOeAe9hINFH0pkE/TQkv0qU5v65L6DPFgdNVQYwxuf277J8pZJHUbmwdf5yaZ6UVxPi0jvN72K7CxIw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277356; x=1795882156; i=jan.claussen10@web.de;
 bh=/zhVvWZ62jF7UBsDV3xQAhNXtpMVfMUCFkx1iqxGM/k=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Jv62Ooxzz9LP0qCMcIfKIo5XZ9boMZzxMR/W8TqhXUvLl2MUT9l0ydzCQPZuBkfv
 U2daebtWL+JwrXxk/KvM6giiI9CbNWsHmD0cKvsU7sbH4Q1uyWNUaxnuEgA3de601
 BD+YbsUyMTXA1kfA2etccEtllFlkYfXlbPf0OsLMjLF00k1nbwkPDgtCQf2uRR25y
 zrZpBwjEuLIfbbyZeTso8YiV4KZV66DVvciX4LB8w6l84qtiH6LQRJZY1xb+JzvMh
 1cYuo7/CxL918Sl3tUGQBg2Sl0FgyGDyx/eYZst1Sf2E6zg7xcYlRFxOUWsCsK+eY
 jHmLV9Wvru03nugMWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1yAlB10Fgp-00hJeY; Sat, 21
 Nov 2026 17:09:16 +0100
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
Subject: [PATCH v6 8/8] drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020
 colorimetries
Date: Sat, 21 Nov 2026 17:07:00 +0100
Message-ID: <20261121160725.6344-9-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/W8mxtg8F5zQ/YOUeZQgosFBHt4uSe7O5+569t+84MvOEv/GGX0
 RYewKPNRFSLgc9dg5wemQXVdBQgST+pS4E05fd3uUigc2RQ8f8jIWWOlNEHO2996TOYyk82
 clYSLDWJFraw8TumEl9lqK8ShQ/ubudFJ7d6lWo+g/s1/BhlssFRISu9IvE8QK7LmkwRPPR
 ijW1Z57sjRAJkn1qLDGoA==
UI-OutboundReport: notjunk:1;M01:P0:MN5Zpvv7EPY=;cUF25LRQKNgxOrr73oDysz/s2L+
 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
 UYMZrXE42mA==
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

