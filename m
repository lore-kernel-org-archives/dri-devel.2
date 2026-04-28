Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D98F4FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C66410EB92;
	Tue, 28 Apr 2026 14:11:32 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E76D10E34B;
 Tue, 28 Apr 2026 14:11:28 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.122])
 by APP-03 (Coremail) with SMTP id rQCowADX79bQv_BpQaZ1Dw--.2120S2;
 Tue, 28 Apr 2026 22:10:28 +0800 (CST)
Message-ID: <7d9086ff60e5e98117aeeb40a085dcde2c29de65.camel@iscas.ac.cn>
Subject: Re: [PATCH v2 00/41] drm/display: bridge-connector: attach encoder
 to the connector
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
Date: Tue, 28 Apr 2026 22:10:18 +0800
In-Reply-To: <DI4TW9XECX53.17TEZPCSWTH1A@bootlin.com>
References: <20260423-drm-bridge-connector-attach_encoder-v2-0-2ae6ca69b390@bootlin.com>
 <cf2c91396eb3017aa51dd9c840badffddca2f7ec.camel@iscas.ac.cn>
 <DI4TW9XECX53.17TEZPCSWTH1A@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowADX79bQv_BpQaZ1Dw--.2120S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw4DGF1UKFWUtry7tFWxCrg_yoW7WFWDpF
 Wjga12kr4kXryrAws2vF15Za4FvrWDJr45Jr1qgw4SkaykuF18AFW7tFs8uasrAFWrW3Wj
 qr4YqrWxuF15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_ZF0_GFyUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVWrXVW8Jr1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
 IIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
 6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
 73UjIFyTuYvjxUyPr4UUUUU
X-Originating-IP: [112.94.102.122]
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

=E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 15:39 +0200=EF=BC=8CLuca Ceresoli=E5=
=86=99=E9=81=93=EF=BC=9A
> Hello Icenowy,
>=20
> On Sat Apr 25, 2026 at 5:22 PM CEST, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-04-23=E5=9B=9B=E7=9A=84 11:16 +0200=EF=BC=8CLuca Ceresol=
i=E5=86=99=E9=81=93=EF=BC=9A
> > > This series simplifies using the bridge-connector by removing the
> > > need to
> > > attach the newly created connector to the encoder.
> > >=20
> > > =3D=3D Series description
> > >=20
> > > Currently all users of the bridge-connector must call
> > > drm_connector_attach_encoder() immediately after a successful
> > > drm_bridge_connector_init().
> > >=20
> > > This is an unnecessary burden for users. Move the call to the end
> > > of
> > > drm_bridge_connector_init() so all callers can be simplified.
> > >=20
> > > =C2=A0* Patch 1 adds a drm_connector_attach_encoder() call at the end
> > > of
> > > =C2=A0=C2=A0 drm_bridge_connector_init()
> > > =C2=A0* The other patches remove drm_connector_attach_encoder() after
> > > all
> > > =C2=A0=C2=A0 drm_bridge_connector_init() calls, ordered from the simp=
lest
> > > ones
> > > =C2=A0=C2=A0 (only the last one is somewhat non-obvious)
> > >=20
> > > The Cc list is huge due to the many drivers touched. I sent v1 to
> > > a
> > > reduced
> > > Cc list to ensure there is an agreement about the overall idea.
> > > That
> > > seems
> > > to be the case, so now it's time to copy all drivers maintainers.
> > >=20
> > > It would be nice to apply all of this series at once to avoid
> > > duplicated
> > > calls to drm_connector_attach_encoder() in the interim. That
> > > would be
> > > harmless beacuse drm_connector_attach_encoder() is idempotent,
> > > but
> > > unpleasant.
> > >=20
> > > =3D=3D Additional rationale (for the curious)
> > >=20
> > > Besides making the usage of the bridge-connector a bit simpler,
> > > this
> > > series
> > > is in preparation for DRM bridge hotplug. Here's why, feel free
> > > to
> > > skip if
> > > you don't care.
> > >=20
> > > The old bridge hotplug proposals I have sent in the past [1] were
> > > based on
> > > a hotplug-bridge driver to sit between the last fixed bridge and
> > > the
> > > first
> > > hotplugged bridge. Discussion with the community led to the need
> > > of
> > > removing the hotplug-bridge and let common DRM code handle
> > > hotplug.
> > > The
> > > common place of code that appears the most suitable for hotplug
> > > handling is
> > > the bridge-connector, which is by now the recommended way to
> > > handle
> > > connector instantiation after a bridge chain.
> > >=20
> > > So I'm in the process of extending the bridge-connector to be the
> > > central
> > > point to handle bridge hotplug. Turns out the need to call
> > > drm_connector_attach_encoder() after drm_bridge_connector_init()
> > > has
> > > returned is adding big headaches to such work. So I'm send this
> > > long
> > > but
> > > simple series to both simplify bridge-connector usage and remove
> > > one
> > > obstacle from the bridge hotplug work. This series is relevant by
> > > itself
> > > anyway.
> > >=20
> > > [1]
> > > https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-26-9d6f2c=
9c3058@bootlin.com/
> > >=20
> > > =3D=3D Grand plan
> > >=20
> > > This is part of the work to support hotplug of DRM bridges. The
> > > grand
> > > plan
> > > was discussed in [0].
> >=20
> > Just see the bridge hotplugging thing, is it possible for DRM
> > drivers
> > to declare bridges attached to themselves after this?
> >=20
> > Loongson 7A1000 PCH can only output DPI signals, so nearly all
> > products
> > with it are shipping with some kind of external bridges, but
> > currently
> > drm/loongson does not support them (all display connectors are now
> > seen
> > as DPI ones, and connectors behind non-transparent bridges won't
> > work).
> >=20
> > The bridges are going to be accessed by the DDC I2C busses of
> > 7A1000,
> > and are not declared with device tree (systems with 7A1000 never
> > ship
> > with device trees, and Linux currently matches a built-in device
> > tree).
> > (Bridges being on the DDC I2C also introduces some dependency for
> > them
> > to depend on the drm/loongson driver.)
> >=20
> > Loongson have defined some kind of VBIOS declaring what bridge is
> > behind, and their non-mainline driver just contains driver codes
> > for
> > all possible bridges. (Sui Jingfeng previously tried to mainline
> > such
> > practice, and of course it's rejected because of code duplicity.)
>=20
> I'm afraid your question goes a bit beyond my knowledge, the hotplug
> work
> I'm carrying on is focuses on DT platforms.
>=20
> My limited understading of non-DT platforms is that a card driver
> must
> instantiate all components and tie them together, which assumes it
> has to
> know them somehow (ACPI, hardcoded, whatever). Others can probably
> comment
> better about this.

Yes, there's some proprietary way defined by Loongson to declare which
device is attached.

The problem here is just to instantiate the attached devices (although
parsing of the Loongson VBIOS data is also a TODO now) and prevent
dependency loop.

Thanks,
Icenowy

>=20
> As a general principle, when devices can be mixed and matched by the
> board
> designer, hardcoding them is a bad design choice. Think of bad old
> board
> files written in C, which were unmanageable and got replaced exactly
> by
> device tree. So my opinion is that DRM encoders and bridges should
> know as
> little as possible about the following bridge, connector or panel
> that
> follows them.
>=20
> Luca
>=20
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

