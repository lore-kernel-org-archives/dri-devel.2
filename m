Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DD2CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3E510E637;
	Sun, 18 Oct 2026 14:33:09 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B4D010E637
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 14:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792333973; x=1792938773; i=jan.claussen10@web.de;
 bh=B0KODFTWofPqvJSU5Pr20zOq5NF4b6w2jfljQhRPsfU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Hi3MWl+gEo9wlvcwM+l+BMl9o+7QfGgj4oIil7+VP2sWbcFqC78dMY2PDtIg7Bwq
 7PZ9D1Cpdz/ddJ2gWqMZB0pOmhlRiAew6Gp/n3xmT7A9UO1ZSrZ+2PmZ38HeV7JM8
 vLR3cfAFTa5rVQ6wo01ZU4nfGv4jDbL5KHytfveJrFnp/69DZ58LL2g+AxGampEop
 6Fr4VDJA0YTmgPXjep4LQoj0K+EBjcpsuQ1Vhaf350RY/3ze/ezP5oRmLDwuiSQaM
 cbLTK150TypCmhpQDjLTi6tiJ1aadjsiER7wFnZHo1tYzzr4SPZAQ81T2sIGUEk4+
 b/pyuj7a9wcos+MsIw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MKdLK-1x1sUr1bRs-00KzhW; Sun, 18
 Oct 2026 16:32:53 +0200
From: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Sandy Huang <hjc@rock-chips.com>,
 =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: =?UTF-8?q?Jan=20Clau=C3=9Fen?= <jan.claussen10@web.de>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] drm/bridge: dw-hdmi-qp: Forward supported colorspaces
 from platform data
Date: Sun, 18 Oct 2026 16:31:11 +0200
Message-ID: <20261018143135.5745-6-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018143135.5745-1-jan.claussen10@web.de>
References: <20261018143135.5745-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yp1/9prnpCp/Xz3jY01TnP05QQDkcUbKgh1GFz9D0qq+G2RcmX1
 C8Wl6ciKPbrlldQL0wDFufTtQ2I4HjCrcsgrtV6QUeV0gXxNNdJvtAZ6/Tzopx3Hk1m8aT8
 bxpTnx8cRcQic2gtNvXISLEsjMcndgBHbPF9js+tSawFG5SIOOLhc146cVxJFpvCyr3ti6v
 JhtwThU4ZVUR4DScwVfaw==
UI-OutboundReport: notjunk:1;M01:P0:ntuKgzPk4ew=;HbFtbjfJVfFGsIpnNJlUSGMz3qx
 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
 smO45lRz4rM=
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

Let platform glue drivers declare the supported colorspaces, the same
way they already declare supported output formats and max bpc.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 3 +++
 include/drm/bridge/dw_hdmi_qp.h              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-hdmi-qp.c
index c9568aea98dc..6017c44b03d4 100644
=2D-- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -1129,6 +1129,9 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_d=
evice *pdev,
 	if (plat_data->supported_formats)
 		hdmi->bridge.supported_formats =3D plat_data->supported_formats;
=20
+	if (plat_data->supported_colorspaces)
+		hdmi->bridge.supported_colorspaces =3D plat_data->supported_colorspaces=
;
+
 	if (plat_data->max_bpc)
 		hdmi->bridge.max_bpc =3D plat_data->max_bpc;
=20
diff --git a/include/drm/bridge/dw_hdmi_qp.h b/include/drm/bridge/dw_hdmi_=
qp.h
index 6ea9c561cfef..a15af81989cc 100644
=2D-- a/include/drm/bridge/dw_hdmi_qp.h
+++ b/include/drm/bridge/dw_hdmi_qp.h
@@ -27,6 +27,8 @@ struct dw_hdmi_qp_plat_data {
 	unsigned long ref_clk_rate;
 	/* Supported output formats: bitmask of @drm_output_color_format */
 	unsigned int supported_formats;
+	/* Supported colorspaces: bitmask of &enum drm_colorspace */
+	unsigned int supported_colorspaces;
 	/* Maximum bits per color channel: 8, 10 or 12 */
 	unsigned int max_bpc;
 };
=2D-=20
2.56.0

