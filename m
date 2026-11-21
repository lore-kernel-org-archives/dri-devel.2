Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ADB606A320
	for <dri-devel@archiver.kernel.org>; Sat, 21 Nov 2026 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=jan.claussen10@web.de header.a=rsa-sha256 header.s=s29768273 header.b=QAKVJUtb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B8BD10E517;
	Sat, 21 Nov 2026 16:09:16 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9CBE10E517
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 16:09:08 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1795277347; mf=PGphbi5jbGF1c3NlbjEwQHdlYi5kZT4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+; d=web.de;
 s=s29768273:rsa-sha256:nU77DGau5AZl3LIAceRTEp5JGqAX
 J6srSmJ3LQB9msNnyugeWrTZR6AnpRL8JXCLa/vBcNhQsRohDyUg042BxU6LdwYcgAN+Y+wwtlx
 p2E0kZd194a6gSboNTxeMBp/KnSLNOKzl8q84z3ZzDVhVAJAZnLrA/mhHZ6t6e5Pok/RvEqGvDg
 JWtL9XdLxLGjCJCzeyDM26COI+nM5b/lBcIpDlqzAiyqiEQwIA3EmJUL32JzoV+7UJx04QGSi/t
 THBAKzlan6qf0GEw3fqihBSUrqQLVDx6VsrK4xPwm0+eylQAHJdMkLLJkZHzco26aWKEujZs5/H
 e/2WKPV+64Xwrw==;
Message-Instance: m=1; h=sha256: ft8bBy181fvFBztRt1ThJyb5njRRwT7Y/vNlSMMFxWU=:
 4/WEPnu04Gn7ZgA5ACkk2uVcQ27DoTP6sW72qU8QHC0=, sha512:
 7xYd3PLiISTzkyBFtR417WLjZw7rxr9zux1zoyKKzJVPOLOd4cHqZpcDms/odFZ98ohE/WlbOykyU9oWxiYYgA==:
 o7JR4WvKvfrEZfXJxVeRJNRLSVwXBS3YLuC/6ugEdEMztxh7K9jFdCNBOyee1DRNvW/x1UMkC0DnaPjJv2KhVg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1795277320; x=1795882120; i=jan.claussen10@web.de;
 bh=V/kc6bhg9QhVTGrbewSWZl3OlcV209fx9+SPKbpQtKo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=QAKVJUtbZlwUpmbUi2aIWj2aMuwhagIEKQ3z8mhrqHn9L9+icCKzUQDdyEVBd8XO
 gL4ngl/uKq+z3NG8Q7xI+k1C3D++WgehXf1wEKe0X0/NiS8tmMcV365/QlwtF/WNl
 xylylIvI9V+YpihuVVR4BiZpXpsn5I9biBuRDvQOh2zFz/XGmwV1ZbrE2pA+Yl9Ha
 9cx7TNmDGYKdExURBp7GctiqY/MRvHddQMkwwizWtslsmH2JoFsNTUZ+oP71GTwc6
 Gv5TD6nQM6L3WYZUENZ0N4Pgy6aOMAd0tZjKC5NsNXh+TwM7UP77bFvwFqmxsP8Rn
 QdAwTDysOkoWRSCGUA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumJD-1yLfHA357L-00sPk1; Sat, 21
 Nov 2026 17:08:39 +0100
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
Subject: [PATCH v6 5/8] drm/bridge: dw-hdmi-qp: Forward supported colorspaces
 from platform data
Date: Sat, 21 Nov 2026 17:06:57 +0100
Message-ID: <20261121160725.6344-6-jan.claussen10@web.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261121160725.6344-1-jan.claussen10@web.de>
References: <20261121160725.6344-1-jan.claussen10@web.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iKlUAoNrDtNvOIWu31eFpww08LSw1Z0DnsiqCYpKzIciEzqB82V
 2s9V6zgg9OAnml+TYsQ2PV/hFrim87QpL/BKQirNL0TsTG7RUWvaK1USOj+sDB1sL8hhrq0
 gl0L5qXHZ0/Yt+jtrYIdyawRee/diAZSJHCPrnG5FyZLMAm2WqBlM0W/ICu1PB/OToQFPEC
 UCBMXuye9ovrYEFhDDHRg==
UI-OutboundReport: notjunk:1;M01:P0:2UzhoE2eHPA=;w7wk0VyUPmsRDiAuVaKd6Ly/nHy
 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
 T2rgQd3B
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

Let platform glue drivers declare the supported colorspaces, the same
way they already declare supported output formats and max bpc.

Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10@web.de>
=2D--
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 3 +++
 include/drm/bridge/dw_hdmi_qp.h              | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/dr=
m/bridge/synopsys/dw-hdmi-qp.c
index b268c9376087..81180e9e8d94 100644
=2D-- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -1170,6 +1170,9 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_d=
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
index ad33f9cafdeb..c336bd40c9cb 100644
=2D-- a/include/drm/bridge/dw_hdmi_qp.h
+++ b/include/drm/bridge/dw_hdmi_qp.h
@@ -28,6 +28,8 @@ struct dw_hdmi_qp_plat_data {
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

