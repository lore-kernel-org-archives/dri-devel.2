Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979B5CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:33:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D67B610E63A;
	Sun, 18 Oct 2026 14:33:32 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B05510E63A
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792334000; x=1792938800; i=jan.claussen10@web.de;
 bh=nWxzefpcJg0qDNsmpAebrGOTXx+vSlOchKFuJ9yDqa0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=M4gbJNhBvzvWoP1+qalzE9NjvT5PceXtbspH3oVulL1vGsPHnxowFZsvevFq53ho
 DOxaaKVY3/VQE1Xi6B7k+Vs0R28bVdgf/SF3cnFPchvDYd9T1cnCQJLx7YAOs17T6
 SSo0HQRVrSbc12rLocTspsrJIB43vyrx241a0ZgXinBGPTtzn1knX239Ksp2fdB18
 LRQvA1M2nubq+KsuDRMtFx9SzLWaJ2D33sMQpMNaut4v5vFttAkqBDcMHzbItgyZR
 bUdwAA5dbT3O4K7IeAtQ7bRco2ShGSRRBpLD45V0FKx3N7AvdKgvATnUBkyla29ZO
 rEQd6mZfWY5J8jiaeA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gbW-1wWPp40J2g-00uLpc; Sun, 18
 Oct 2026 16:33:20 +0200
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
Subject: [PATCH v4 7/7] drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020
 colorimetries
Date: Sun, 18 Oct 2026 16:31:13 +0200
Message-ID: <20261018143135.5745-8-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143135.5745-1-jan.claussen10@web.de>
References: <20261018143135.5745-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vgJJz9wHClKoXxywE9jHWXa8QvwqPcQT9qjduanBMqbfmrHh3F6
 UkyRVC6ZYcg4UlNd7+tZlunBjopp8M4zUvvsbgauAEJQNI5J/J3dI5j/qO6Odfcb6QvacD8
 sN581rXoVvObSsynh2CRJiTD4juo+SLoGB821NbdEwg0o6a1Vjeb73ly2+nwQ5Iz9HKW7Ve
 hgMJJ4GOuVnaypFH7pVfg==
UI-OutboundReport: notjunk:1;M01:P0:lCwU8gFuzSI=;94U+FAFQO3nOZWAqjbFVXYpL1p8
 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
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

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
index 10c5b6d6406e..e677aacf5a33 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -621,6 +621,10 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
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

