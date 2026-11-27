Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DDC606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=TbudbJfN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9A8A112BFE;
	Fri, 27 Nov 2026 16:19:37 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 833E6112C09
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:19:09 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261127161908euoutp018222750d7dc5ae8816e1784d5112ff08~r80Ot4MFe2721927219euoutp01M
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 16:19:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261127161908euoutp018222750d7dc5ae8816e1784d5112ff08~r80Ot4MFe2721927219euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1795796348;
 bh=hW4PnFCT49QnJHLHRZYt9yWGbDa7JaYp1uG9G1RshfE=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=TbudbJfN2KEAcseLCdqwwdr/3N0wOH56zgL2BIimSzpkBxuP/owSfOiCEhof6SP2C
 MiUaDOnX9CG+igbpmtHKVvakO0UfRcR5O2R1KPGRA2LdUyj1tOB3B0CQ7X9vCoZtbo
 Am8wlPKUb0JuspNHw5s4QNGgclbyXZMM+UasxgR8=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261127161908eucas1p2fae4a07f1d72df6f675b1e4015727f13~r80OX2Anv1885618856eucas1p2L;
 Fri, 27 Nov 2026 16:19:08 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20261127161907eusmtip2fc9fbad8311ea1a87aa12e400dd147cb~r80Ngzdhl2969229692eusmtip26;
 Fri, 27 Nov 2026 16:19:07 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 27 Nov 2026 17:19:01 +0100
Subject: [PATCH 3/3] drm/bridge: inno-hdmi: Don't give the DDC adapter an OF
 node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-inno-hdmi-ddc-of-node-v1-3-465622e1b7ad@samsung.com>
In-Reply-To: <20261127-inno-hdmi-ddc-of-node-v1-0-465622e1b7ad@samsung.com>
To: Andy Yan <andyshrk@163.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jernej Skrabec
 <jernej.skrabec@gmail.com>,  Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,  Heiko Stuebner
 <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Byron Stanoszek <gandalf@winds.org>, Dominique
 Belhachemi <db@domibel.de>,  Owen O'Hehir <oo.hehir@gmail.com>,  Michal
 Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1611;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=PekPu8YIeS97KeLHxN3IfvfgL2ZCxwDu1aOL1IF9Aio=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWRzri1fLcSmmGKvGXY7KeviEk6XVxoSnKo+1w1/t+Xzc
 f0qeZXbUcrCIMbBICumyHJ2Y7SR5D+Gp+XHH/+CmcPKBDKEgYtTACbyV4Xhn0r+v+W/WJwebM9Z
 wfc/LG3P25ePnF56euxSVnvMUbu9O4/hf0j183bZlVf2cX1c8uZm9cPKp/Uv4vX3TWZMYDWLVIn
 JZgEA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261127161908eucas1p2fae4a07f1d72df6f675b1e4015727f13
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261127161908eucas1p2fae4a07f1d72df6f675b1e4015727f13
X-EPHeader: CA
X-CMS-RootMailID: 20261127161908eucas1p2fae4a07f1d72df6f675b1e4015727f13
References: <20261127-inno-hdmi-ddc-of-node-v1-0-465622e1b7ad@samsung.com>
 <CGME20261127161908eucas1p2fae4a07f1d72df6f675b1e4015727f13@eucas1p2.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

inno_hdmi_i2c_adapter() sets the DDC adapter's of_node to the HDMI
controller's node. When the adapter is registered, the I2C core then
tries to create an I2C client for every child of that node. On RK3036,
RK3128 and the JH7110 the only child is the OF graph 'ports' node, which
is not an I2C device, so each boot logs, here on the JH7110:

  i2c i2c-7: of_i2c: modalias failure on .../controller/ports
  i2c i2c-7: Failed to create I2C device for .../controller/ports

Nothing on the DDC bus is described in DT, and nothing looks the
adapter up by its node, so don't assign one, as dw-hdmi doesn't either.

Fixes: 412d4ae6b7a5 ("drm/rockchip: hdmi: add Innosilicon HDMI support")
Reported-by: Owen O'Hehir <oo.hehir@gmail.com>
Closes: https://lore.kernel.org/all/20261012175941.258219-1-electronicconsult1@gmail.com/
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/bridge/inno-hdmi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/inno-hdmi.c b/drivers/gpu/drm/bridge/inno-hdmi.c
index bbc90ae9eaae04166d502c05fde52e126462b8be..bf39483d483e00ccef0daefb80f6579d5c86815a 100644
--- a/drivers/gpu/drm/bridge/inno-hdmi.c
+++ b/drivers/gpu/drm/bridge/inno-hdmi.c
@@ -1044,7 +1044,6 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
 	adap = &i2c->adap;
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = hdmi->dev;
-	adap->dev.of_node = hdmi->dev->of_node;
 	adap->algo = &inno_hdmi_algorithm;
 	strscpy(adap->name, "Inno HDMI", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);

-- 
2.34.1

