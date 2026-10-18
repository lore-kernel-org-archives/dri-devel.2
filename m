Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1C2CCA490
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 12:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D86610E101;
	Sun, 18 Oct 2026 12:32:06 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6E5C10E101
 for <dri-devel@lists.freedesktop.org>; Sun, 18 Oct 2026 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1792326718; x=1792931518; i=jan.claussen10@web.de;
 bh=B0KODFTWofPqvJSU5Pr20zOq5NF4b6w2jfljQhRPsfU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lvwGcVzFpMRDpDCZTm7gexq69tKfCc0zyBsg/Ed7rCpQej7iMCMgSKEWXH6Tcr5h
 yM/vqJXlEEliZFqb2NsC2ugmTQ+dBp05Upzdv8/tS4Xg2Bwe3QtFM9woOWRrnT19d
 Wv7y9sr4CaKOnvM8p6YDTOaW+uOKxf7SGV7kXah0v2RRXdW1t2hH6ZLspK1NboahI
 DmsZxVlH8rIax7qjKaTgVYzYXgliHPOD5TKiIZEA9ExHwNt7XDDpMFciz1Nr36aqH
 OiXfe7Cd5WDv5iD+S/+WvVUpoiwUyt9j2hP2TpxMPvN5csRvfq1oawjM9CXHBxgvC
 XBYP/OtZIcMic11nVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1xBZMv0EkJ-00UeUo; Sun, 18
 Oct 2026 14:31:58 +0200
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
Subject: [PATCH v3 5/6] drm/bridge: dw-hdmi-qp: Forward supported colorspaces
 from platform data
Date: Sun, 18 Oct 2026 14:30:15 +0200
Message-ID: <20261018123037.19560-6-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018123037.19560-1-jan.claussen10@web.de>
References: <20261018123037.19560-1-jan.claussen10@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XMuGmZJw/ZCKHScCqnjIeAJdj+aN5jcW5jj+zZ5rUytuxdySFzX
 tqdQ0ybN99YdD3t+CL7Wt44JRQdX2mTgpEtTA2IiLe8TH4XAPb+AJ6Hm9dXN6zULlpjRzuc
 RLtab3UC3X/4rcvk4p90mGzzpyNIjTjilPjjH9cCt7euI/cGXzM5FAB1Zt58SeB0kJF6Zy7
 bEiEOoEjAFDtgE8AnUc/w==
UI-OutboundReport: notjunk:1;M01:P0:9GLtfJNko0c=;QdIy/iMb6oz+BUsy1cmxKxQ5TOL
 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
 3Iwo8DpCbcxJ4gOrvZkE=
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

