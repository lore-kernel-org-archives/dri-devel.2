Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0993BC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:30:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D5A10E352;
	Mon, 21 Sep 2026 07:30:40 +0000 (UTC)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 296BE10E352
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:30:37 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.103.44])
 by APP-03 (Coremail) with SMTP id rQCowAA3Pz0W3bBqLVZECA--.3651S2;
 Mon, 21 Sep 2026 15:30:31 +0800 (CST)
Message-ID: <cb30f57c0ac124aac85efad32626e6182b9f1369.camel@iscas.ac.cn>
Subject: Re: [PATCH v7 7/7] drm/verisilicon: fix DC8200 primary plane
 disable clearing FB_EN
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 15:30:30 +0800
In-Reply-To: <1d988dfb-c930-4c17-ae77-47b93ff9f159@gmail.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
 <20260918030125.315978-8-a0987203069@gmail.com>
 <4a7b271d2a90eff94c27dec3bf24114ce44df1fd.camel@iscas.ac.cn>
 <1d988dfb-c930-4c17-ae77-47b93ff9f159@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: rQCowAA3Pz0W3bBqLVZECA--.3651S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw43uFWrXry3Jw47Zr4xJFb_yoW5GrW7pF
 4DtFWUKFs5X3yIka4IyFyqga4Yv3W7t395Jry8G34jvrs8ta9rWFy8Jr95Za4DWrWxGF4S
 vF4v939xCryUAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
 IFyTuYvjxU2VbyDUUUU
X-Originating-IP: [112.94.103.44]
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

=E5=9C=A8 2026-09-21=E4=B8=80=E7=9A=84 10:43 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
>=20
> Icenowy Zheng =E6=96=BC 2026/9/18 =E4=B8=8B=E5=8D=88 01:52 =E5=AF=AB=E9=
=81=93:
> > =E5=9C=A8 2026-09-18=E4=BA=94=E7=9A=84 11:01 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
> > > vs_dc8200_primary_plane_disable_ex() calls regmap_set_bits() on
> > > VSDC_FB_CONFIG_EX_FB_EN instead of regmap_clear_bits(), so
> > > disabling
> > > the primary plane on DC8200-family hardware actually leaves the
> > > framebuffer enable bit instead of clearing it.
> > >=20
> > > This bug predates this series: it was carried over unchanged from
> > > vs_primary_plane_atomic_disable() when patch "drm/verisilicon:
> > > introduce per-variant hardware ops table" split the DC8200-
> > > specific
> > > implementation out into vs_dc8200.c.
> > >=20
> > > Fixes: dbf21777caa8 ("drm: verisilicon: add a driver for
> > > Verisilicon
> > > display controllers")
> > Maybe it'd be better to fix this before adding DC variant
> > abstraction,
> > for easier backporting.
> >=20
> > Thanks,
> > Icenowy
> Makes sense. Should I send it as a standalone patch targeting
> drm-misc-fixes (separate from this series), or do you have a
> different preference for how to split it?

Maybe it's better to just make it the 2nd patch in this patchset, just
after the binding change.

Waiting for something into drm-misc-fixes again will need another fixes
pull and another RC back merge, which can consume weeks and miss the
current merging window.

In addition, it's possible that `drm/verisilicon: introduce per-variant
hardware ops table` also gets backported for a more clean primary plane
atomic_update disabling fix.

Thanks,
Icenowy

> >=20
> > > Signed-off-by: Joey Lu <a0987203069@gmail.com>
> > > ---
> > > =C2=A0=C2=A0drivers/gpu/drm/verisilicon/vs_dc8200.c | 4 ++--
> > > =C2=A0=C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/verisilicon/vs_dc8200.c
> > > b/drivers/gpu/drm/verisilicon/vs_dc8200.c
> > > index f72da10295e1b..25b5906a1c5fc 100644
> > > --- a/drivers/gpu/drm/verisilicon/vs_dc8200.c
> > > +++ b/drivers/gpu/drm/verisilicon/vs_dc8200.c
> > > @@ -70,8 +70,8 @@ static void
> > > vs_dc8200_primary_plane_enable_ex(struct vs_dc *dc, unsigned int
> > > out
> > > =C2=A0=20
> > > =C2=A0=C2=A0static void vs_dc8200_primary_plane_disable_ex(struct vs_=
dc
> > > *dc,
> > > unsigned int output)
> > > =C2=A0=C2=A0{
> > > -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > -			VSDC_FB_CONFIG_EX_FB_EN);
> > > +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
> > > +			=C2=A0 VSDC_FB_CONFIG_EX_FB_EN);
> > > =C2=A0=20
> > > =C2=A0=C2=A0	vs_dc8200_plane_commit(dc, output);
> > > =C2=A0=C2=A0}

