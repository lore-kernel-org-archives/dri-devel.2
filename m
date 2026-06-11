Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743F3CD8CB2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4C3410ECBD;
	Thu, 11 Jun 2026 05:43:36 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79C110ECBD
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 05:43:35 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.167])
 by APP-01 (Coremail) with SMTP id qwCowACXOtMBSypqL+NEAQ--.1358S2;
 Thu, 11 Jun 2026 13:43:30 +0800 (CST)
Message-ID: <69a18fd1a1b9f375bbccfbe0d9e88ab31a01a188.camel@iscas.ac.cn>
Subject: Re: [PATCH 3/3] drm/panel: himax-hx83121a: add backlight regulator
 support
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Thu, 11 Jun 2026 13:43:29 +0800
In-Reply-To: <178115560757.199930.5802398831559617564.b4-review@b4>
References: <20260608162622.403713-1-zhengxingda@iscas.ac.cn>
 <20260608162622.403713-3-zhengxingda@iscas.ac.cn>
 <178115560757.199930.5802398831559617564.b4-review@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: qwCowACXOtMBSypqL+NEAQ--.1358S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtF1fGryxZF1rJFyUKrWUCFg_yoWkZwc_Wr
 4jqrZFqrWqqr4kCFn7AFyftF93KFs5uFn7Z3ZYy34aka47CrsrZrWUXrWrAas8Jw1FkFyq
 kanrZFyFvr4DWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUbskYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
 6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
 8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
 cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU7veHUUUUU
X-Originating-IP: [112.94.100.167]
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

=E5=9C=A8 2026-06-11=E5=9B=9B=E7=9A=84 13:26 +0800=EF=BC=8CPengyu Luo=E5=86=
=99=E9=81=93=EF=BC=9A
> On Tue, 09 Jun 2026 00:26:22 +0800, Icenowy Zheng
> <zhengxingda@iscas.ac.cn> wrote:
> > diff --git a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > index 1a7e0125bced..e31e2fba0a78 100644
> > --- a/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > +++ b/drivers/gpu/drm/panel/panel-himax-hx83121a.c
> > @@ -195,7 +197,27 @@ static int himax_bl_update_status(struct
> > backlight_device *bl)
> > [ ... skip 18 lines ... ]
> > +		ret =3D regulator_enable(ctx->bl_supply);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ctx->backlight_enabled =3D true;
> > +
>=20
> If you use a pin, (it is indeed a hwen pin as we know) you can
> simplify it like this,
>=20
> bool bl_enable_now =3D !!brightness;
>=20
> if (ctx->bl_enable !=3D bl_enable_now) {
> 	gpiod_set_value(ctx->hwen_gpio, bl_enable_now);
> 	ctx->bl_enable =3D bl_enable_now;
> }
>=20
> BTW, iirc, panel bias can be turned off too, although I don't think
> this will save too much power.

BTW during my test, it seems that DCS backlight 0 isn't turning off
backlight.

Thanks,
Icenowy

>=20
> Best wishes,
> Pengyu

