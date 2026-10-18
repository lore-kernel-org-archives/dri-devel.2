Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5167FCCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:32:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5E610E3C3;
	Sun, 18 Oct 2026 12:32:32 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D2810E3C3
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792326731; x=1792931531; i=jan.claussen10@web.de;
 bh=yZmygKiSqz+ADSHnLa4DiUmUVrmHybhmcAjGVUFB2P4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=NXGf0WcJ6OXxalTv9mcMoKTCY1bjCjmvBDmXyW6be/5gYdtxPAbVr0JkQHyCYl5L
 FKVRn5lRFAD/YOGAQZFMh/QqDFEXRNhqXeFHu8Y3jxoN+Y2TFUPrV0Az+J9G2rZ6m
 DGb04BQ8oTfcvbBiQJsdKa5QMuLO4NocTMCIEuqqEaMZC6f/Ng+xcfLJHqlI2BjvR
 plNy2sEncz2qMDNJClimm9iz7n3utTDUdhpFUFmLa6szm0scrzp8BHX8nL3vshPS5
 jGlzx/SYpvpQYaCl4KNpbynHgY80fCQUdufyH1ASVaC8zKM08jsjqDj281PFfcCEY
 Fm8cJnA2QlUISCa4Sw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8Bvz-1xEpYm384J-00CQc3; Sun, 18
 Oct 2026 14:32:11 +0200
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
Subject: [PATCH v3 6/6] drm/rockchip: dw_hdmi_qp: Advertise BT.709 and BT.2020
 colorimetries
Date: Sun, 18 Oct 2026 14:30:16 +0200
Message-ID: <20261018123037.19560-7-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018123037.19560-1-jan.claussen10@web.de>
References: <20261018123037.19560-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yl0b3oIkfDSLuLblgvx+9K3NL8P1m4TMnp571Z3OwBEju4Ga0/t
 q4jIxpmAqIKuRgEIOhr9dpP0G1tWCX7kk3lFC2z+QoyAIV9a2iCCdI7KWaVNXuzh5XbU47X
 A0D0JiRLEPCqz9Cu8aNeC1z3uRa9mYnNYNE2IUWYxOuDRrqBFV81w4G343Qh5Mpe09xtl90
 oX5/A/rmNnnLCOgCOiXvg==
UI-OutboundReport: notjunk:1;M01:P0:za1qdXZAlhc=;MxbQf88BB92tVszuaGznMjXCHtv
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

Not sure if BT.709 needs to be explicitly exposed here, but it is mentione=
d in the data sheet.
Might be covered by DRM_MODE_COLORIMETRY_DEFAULT though.

BT.709/BT.2020 YCC are untested.

 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/=
drm/rockchip/dw_hdmi_qp-rockchip.c
index 9c4cf68d79d5..dbb87dfd000c 100644
=2D-- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -605,6 +605,10 @@ static int dw_hdmi_qp_rockchip_bind(struct device *de=
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

