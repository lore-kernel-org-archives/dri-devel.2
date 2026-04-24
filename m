Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBD4FB44C6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228B310F391;
	Fri, 24 Apr 2026 08:04:25 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABE6D10F391
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:04:23 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.10])
 by APP-03 (Coremail) with SMTP id rQCowABnhNvRI+tpv7EHDw--.22752S2;
 Fri, 24 Apr 2026 16:03:33 +0800 (CST)
Message-ID: <1d54c67c3c1892805793e58e77ef5708cf5b7ca4.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 24/41] drm: verisilicon: remove now-redundant call to
 drm_connector_attach_encoder()
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, Dmitry Baryshkov	
 <dmitry.baryshkov@oss.qualcomm.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart	
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sasha Finkelstein <fnkl.kernel@gmail.com>,
 Janne Grunau <j@jannau.net>, Liu Ying <victor.liu@nxp.com>, Douglas
 Anderson <dianders@chromium.org>, Laurentiu Palcu	
 <laurentiu.palcu@oss.nxp.com>, Lucas Stach <l.stach@pengutronix.de>, Frank
 Li	 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Philipp Zabel	 <p.zabel@pengutronix.de>, Paul Cercueil
 <paul@crapouillou.net>, Anitha Chrisanthus <anitha.chrisanthus@intel.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, Matthias Brugger	
 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Kevin Hilman
 <khilman@baylibre.com>,  Jerome Brunet <jbrunet@baylibre.com>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Clark	
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang
 <jesszhan0024@gmail.com>, Sean Paul	 <sean@poorly.run>, Marijn Suijten
 <marijn.suijten@somainline.org>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Sandy Huang <hjc@rock-chips.com>, Heiko
 =?ISO-8859-1?Q?St=FCbner?=	 <heiko@sntech.de>, Andy Yan
 <andy.yan@rock-chips.com>, Thierry Reding	 <thierry.reding@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,  Jonathan Hunter
 <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>, Inki Dae
 <inki.dae@samsung.com>,  Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin
 Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski	 <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Laurent Pinchart	
 <laurent.pinchart+renesas@ideasonboard.com>, Tomi Valkeinen	
 <tomi.valkeinen+renesas@ideasonboard.com>, Kieran Bingham	
 <kieran.bingham+renesas@ideasonboard.com>, Geert Uytterhoeven	
 <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Biju Das	
 <biju.das.jz@bp.renesas.com>, Marek Vasut <marex@denx.de>, Stefan Agner	
 <stefan@agner.ch>, Jyri Sarha <jyri.sarha@iki.fi>, Michal Simek	
 <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, 	linux-mips@vger.kernel.org,
 linux-mediatek@lists.infradead.org, 	linux-amlogic@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, 	freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, 	linux-tegra@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, 	linux-renesas-soc@vger.kernel.org
Date: Fri, 24 Apr 2026 16:03:29 +0800
In-Reply-To: <20260423-drm-bridge-connector-attach_encoder-v2-24-2ae6ca69b390@bootlin.com>
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
 <20260423-drm-bridge-connector-attach_encoder-v2-24-2ae6ca69b390@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowABnhNvRI+tpv7EHDw--.22752S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFWxKr15Xw1xXw48Jr4rGrg_yoWfWFc_uw
 nY9F9rWrW5KFyDC3Z7Jrn5Zry2v3Z5uFW8uwnrt393KwsrAw18Z347Xry2v34UuFyUAFZF
 kw4DWFZ7Ar4akjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbVxYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_ZF0_GFyUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
 73UjIFyTuYvjxUxeOJUUUUU
X-Originating-IP: [112.94.102.10]
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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

=E5=9C=A8 2026-04-23=E5=9B=9B=E7=9A=84 11:17 +0200=EF=BC=8CLuca Ceresoli=E5=
=86=99=E9=81=93=EF=BC=9A
> drm_connector_attach_encoder() is now called by
> drm_bridge_connector_init().
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Acked-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>

> ---
> =C2=A0drivers/gpu/drm/verisilicon/vs_bridge.c | 1 -
> =C2=A01 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> b/drivers/gpu/drm/verisilicon/vs_bridge.c
> index 2a0ad00a94d6..83c91d5ce397 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> @@ -365,7 +365,6 @@ struct vs_bridge *vs_bridge_init(struct
> drm_device *drm_dev,
> =C2=A0		ret =3D PTR_ERR(bridge->conn);
> =C2=A0		return ERR_PTR(ret);
> =C2=A0	}
> -	drm_connector_attach_encoder(bridge->conn, bridge->enc);
> =C2=A0
> =C2=A0	return bridge;
> =C2=A0}

