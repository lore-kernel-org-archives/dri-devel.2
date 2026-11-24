Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78A606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 770F710F327;
	Tue, 24 Nov 2026 08:42:35 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA74F10F351
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 08:39:52 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.97.139])
 by APP-01 (Coremail) with SMTP id qwCowADnDfhFTQVrj+mUAQ--.9372S2;
 Tue, 24 Nov 2026 16:39:34 +0800 (CST)
Message-ID: <6fd9adfbb46959316ea18581513e21a71732df80.camel@iscas.ac.cn>
Subject: Re: [PATCH v3 0/2] drm/bridge: add glue driver for T-Head TH1520 DW
 MIPI DSI
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong	
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Sandy
 Huang <hjc@rock-chips.com>, Heiko =?ISO-8859-1?Q?St=FCbner?=	
 <heiko@sntech.de>, Andy Yan <andyshrk@163.com>,
 dri-devel@lists.freedesktop.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, 	linux-riscv@lists.infradead.org, Han
 Gao <gaohan@iscas.ac.cn>
Date: Tue, 24 Nov 2026 16:39:33 +0800
In-Reply-To: <c89271be-85f9-41ba-9c19-c78743d212c8@rock-chips.com>
References: <20261124-th1520-dw-mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn>
 <c89271be-85f9-41ba-9c19-c78743d212c8@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID: qwCowADnDfhFTQVrj+mUAQ--.9372S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4fCr1rGry5Xw4DtF47Arb_yoW5Xr43pa
 17GFy3AFWDJrn2gF97tw1rXFW5Xws5JFyvgrW5tw1fZws8Wa4xXF9Fkrs8WFy8Xr1fuF12
 vF40g34fWrnFvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
 C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
 MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
 4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
 67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2I
 x0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
 x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa
 73UjIFyTuYvjxUVuWlDUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

=E5=9C=A8 2026-11-24=E4=BA=8C=E7=9A=84 16:24 +0800=EF=BC=8CChaoyi Chen=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi Icenowy,
>=20
> On 11/24/2026 3:56 PM, Icenowy Zheng wrote:
> > T-Head TH1520 contains a DesignWare MIPI DSI host controller paired wit=
h
> > an internal DesignWare PHY, as a similar design (but with a different
> > PHY) with the Rockchip DW MIPI DSI.
> >=20
> > The functionality to write to the PHY is shared between these two
> > implementations of DW MIPI DSI, so it's extracted from the Rockchip
> > driver to the common code. (The same sequence could be seen in the
> > HiSilicon Kirin DRM driver, but that one hasn't been converted to commo=
n
> > DW MIPI DSI.)
> >=20
> > Tested on a Lichee Console 4A (with a Mingjun MJ070BI30IA2 panel) with
> > further pending DT patches.
> >=20
> > One question remains: I have to copy the extra lane bandwidth headroom
> > from the Rockchip driver, otherwise the Mingjun panel cannot keep sync
> > to the display signal; from my testing, changing the hardcoded
> > PHY_STOP_WAIT_TIME from 0x20 to 0x2 (which is written by the vendor
> > driver) can also make this panel to work w/o the extra headroom. I want
> > some advice on whether to keep the extra headroom or changing the commo=
n
> > code to make the PHY_STOP_WAIT_TIME parameter adjustable.
> >=20
>=20
> Does the DesignWare PHY databook describe about PHY_STOP_WAIT_TIME?

Unfortunately I don't have the databook for this specific PHY, and I don't
know whether this field is a PHY-specific value.

Thanks,
Icenowy

>  =20
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> > Changes in v3:
> > - Fixed a remaining `syscon` in the DT binding.
> > - Link to v2: https://patch.msgid.link/20261119-th1520-dw-mipi-dsi-v2-0=
-9ab5f9808f87@iscas.ac.cn
> >=20
> > Changes in v2:
> > - Changed `syscon` to `thead,vo-syscon` in the DT binding.
> > - Dropped the patch moving common PHY write routine to dw-mipi-dsi
> >   common code.
> > - Fixed a few problems pointed out by Sashiko in v1.
> > - Link to v1: https://patch.msgid.link/20261030-th1520-dw-mipi-dsi-v1-0=
-753f34fd304f@iscas.ac.cn
> >=20
> > ---
> > Icenowy Zheng (2):
> >       dt-bindings: display: bridge: document TH1520 MIPI DSI controller
> >       drm/bridge: add TH1520 DesignWare MIPI DSI host controller
> >=20
> >  .../display/bridge/thead,th1520-dw-mipi-dsi.yaml   | 103 ++++
> >  drivers/gpu/drm/bridge/Kconfig                     |  12 +
> >  drivers/gpu/drm/bridge/Makefile                    |   1 +
> >  drivers/gpu/drm/bridge/th1520-dw-mipi-dsi.c        | 570 +++++++++++++=
++++++++
> >  4 files changed, 686 insertions(+)
> > ---
> > base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> > change-id: 20261030-th1520-dw-mipi-dsi-580d5b2792f9
> >=20
> > Best regards,
> > -- =20
> > Icenowy Zheng <zhengxingda@iscas.ac.cn>

