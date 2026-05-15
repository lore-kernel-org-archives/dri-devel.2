Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE559CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:39:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9BA910F46A;
	Fri, 15 May 2026 08:39:03 +0000 (UTC)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D1810F48F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:39:01 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.82])
 by APP-05 (Coremail) with SMTP id zQCowAAHlwqc2wZqB+ZSEA--.46578S2;
 Fri, 15 May 2026 16:38:53 +0800 (CST)
Message-ID: <1c4d8611411e2d14699ac0b9aeb5b2377feedc8a.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] drm/verisilicon: add support for Nuvoton MA35D1
 DCUltra Lite display controller
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Joey Lu <a0987203069@gmail.com>, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, 	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 15 May 2026 16:38:52 +0800
In-Reply-To: <1a42a168-1dbb-467e-9053-b5585a737f71@gmail.com>
References: <20260511075142.54752-1-a0987203069@gmail.com>
 <20260511075142.54752-3-a0987203069@gmail.com>
 <93e69179dbc495188cfffd8015350b3a55ce7876.camel@iscas.ac.cn>
 <de35406e-874d-4bdd-be7f-3d74dc37b13f@gmail.com>
 <3b94806073de8bd1d79aa7ec956493f67679e46b.camel@iscas.ac.cn>
 <dfbc4042-64cf-49f2-a5de-12260beffaa0@gmail.com>
 <4bf6efbb222ebc4d770ad613d17c6185e7cb2fda.camel@iscas.ac.cn>
 <1d04dd6d-f245-4b83-96b0-c5491fad8093@gmail.com>
 <76a9e9b676509e85484a1eb31c723b46c7e21a19.camel@iscas.ac.cn>
 <1a42a168-1dbb-467e-9053-b5585a737f71@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-CM-TRANSID: zQCowAAHlwqc2wZqB+ZSEA--.46578S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFyUXF4DAr15CF4UWr1ftFb_yoW3Gw1fpr
 ykGFW0kr4DJryayr47tw1DtFyjyw1UJw43Wr1kJr1rXr1qyr17WF4UJr1UCF1kWr1kGr18
 Jr48JrWxXry5ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
 vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
 1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
 C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
 wI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
 v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
 jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
 ZFpf9x07betCcUUUUU=
X-Originating-IP: [112.94.100.82]
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

=E5=9C=A8 2026-05-15=E4=BA=94=E7=9A=84 14:25 +0800=EF=BC=8CJoey Lu=E5=86=99=
=E9=81=93=EF=BC=9A
>=20
> On 5/12/2026 9:12 PM, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 18:59 +0800=EF=BC=8CJoey Lu=E5=
=86=99=E9=81=93=EF=BC=9A
> > > On 5/12/2026 6:01 PM, Icenowy Zheng wrote:
> > > > =E5=9C=A8 2026-05-12=E4=BA=8C=E7=9A=84 17:06 +0800=EF=BC=8CJoey Lu=
=E5=86=99=E9=81=93=EF=BC=9A
> > > >=20
> > > > =3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > > > > > > > b/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > > > > > > > index 7a93049368db..225af322de32 100644
> > > > > > > > > --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > > > > > > > +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
> > > > > > > > > @@ -164,13 +164,16 @@ static void
> > > > > > > > > vs_bridge_enable_common(struct
> > > > > > > > > vs_crtc *crtc,
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_C=
LK_E
> > > > > > > > > N);
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0	regmap_set_bits(dc->regs,
> > > > > > > > > VSDC_DISP_PANEL_CONFIG(output),
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0			VSDC_DISP_PANEL_CONFIG_R=
UNNI
> > > > > > > > > NG);
> > > > > > > > > -	regmap_clear_bits(dc->regs,
> > > > > > > > > VSDC_DISP_PANEL_START,
> > > > > > > > > -		=09
> > > > > > > > > VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> > > > > > > > > -	regmap_set_bits(dc->regs,
> > > > > > > > > VSDC_DISP_PANEL_START,
> > > > > > > > > -
> > > > > > > > > 			VSDC_DISP_PANEL_START_RUNNIN
> > > > > > > > > G(ou
> > > > > > > > > tput));
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > -	regmap_set_bits(dc->regs,
> > > > > > > > > VSDC_DISP_PANEL_CONFIG_EX(crtc-
> > > > > > > > > > id),
> > > > > > > > > -
> > > > > > > > > 			VSDC_DISP_PANEL_CONFIG_EX_CO
> > > > > > > > > MMIT);
> > > > > > > > > +	if (dc->info->has_config_ex) {
> > > > > > > > > +		regmap_clear_bits(dc->regs,
> > > > > > > > > VSDC_DISP_PANEL_START,
> > > > > > > > > +			=09
> > > > > > > > > VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
> > > > > > > > > +		regmap_set_bits(dc->regs,
> > > > > > > > > VSDC_DISP_PANEL_START,
> > > > > > > > > +				VSDC_DISP_PANEL_STAR
> > > > > > > > > T_RU
> > > > > > > > > NNIN
> > > > > > > > > G(ou
> > > > > > > > > tput
> > > > > > > > > ));
> > > > > > > > > +
> > > > > > > > > +		regmap_set_bits(dc->regs,
> > > > > > > > > VSDC_DISP_PANEL_CONFIG_EX(crtc->id),
> > > > > > > > > +				VSDC_DISP_PANEL_CONF
> > > > > > > > > IG_E
> > > > > > > > > X_CO
> > > > > > > > > MMIT
> > > > > > > > > );
> > > > > > > > Should the commit operation happen on
> > > > > > > > DC8000/DCUltraLite
> > > > > > > > too?
> > > > > > > > (By
> > > > > > > > writing to DcregFrameBufferConfig0.VALID).
> > > > > > > >=20
> > > > > > > > Many registers written has "Note: This field is double
> > > > > > > > buffered" in
> > > > > > > > the
> > > > > > > > DCUltraLite documentation.
> > > > > > > >=20
> > > > > > > > I suggest create a static function for commit -- write
> > > > > > > > to
> > > > > > > > the
> > > > > > > > corresponding commit bit on DC8200, and write to
> > > > > > > > DcregFrameBufferConfig0.VALID on DC8000/DCUltraLite.
> > > > > > > [a] There is no commit operation for DCUltra Lite.
> > > > > > > I'll not add a `VSDC_FB_CONFIG_VALID` macro. VALID
> > > > > > > (BIT(3))
> > > > > > > is a
> > > > > > > hardware-managed double-buffer status bit: hardware
> > > > > > > writes
> > > > > > > 1=3DPENDING
> > > > > > > when a new register set is ready and clears to 0=3DWORKING
> > > > > > > after
> > > > > > > the
> > > > > > > VBLANK copy. Software must never write it, and there is
> > > > > > > no
> > > > > > > polling
> > > > > > > use
> > > > > > It seems to be writable and controls whether register
> > > > > > buffering
> > > > > > is
> > > > > > enabled, see [1].
> > > > > >=20
> > > > > > The description of this bit in MA35D1 TRM says "This
> > > > > > ensures a
> > > > > > frame
> > > > > > will always start with a valid working set if this register
> > > > > > is
> > > > > > programmed last, which reduces the need for SW to wait for
> > > > > > the
> > > > > > start of
> > > > > > a VBLANK signal in order to ensure all states are loaded
> > > > > > before
> > > > > > the
> > > > > > next VBLANK", which indicates some kind of "committing
> > > > > > write",
> > > > > > although
> > > > > > the code at [1] seems to indicate that double buffering is
> > > > > > only
> > > > > > enabled
> > > > > > when bit is cleared.
> > > > > >=20
> > > > > > Anyway this bit should be programmable, and "Software must
> > > > > > never
> > > > > > write
> > > > > > it" contradicts with the MA35D1 TRM.
> > > > > >=20
> > > > > > Thanks,
> > > > > > Icenowy
> > > > > >=20
> > > > > > [1]
> > > > > > https://github.com/rockos-riscv/rockos-kernel/blob/rockos-v6.6.=
y/drivers/gpu/drm/eswin/es_dc_hw.c#L993
> > > > > Thank you for the correction. I'll add
> > > > > `#define VSDC_FB_CONFIG_VALID BIT(3)` to
> > > > > vs_primary_plane_regs.h
> > > > > and
> > > > > write it in `vs_primary_plane_commit()` for non-config_ex
> > > > > variants.
> > > > > > > case in the driver that requires a named constant. For
> > > > > > > non-
> > > > > > > config_ex
> > > > > > > variants, `vs_primary_plane_commit()` performs no commit
> > > > > > > operation =E2=80=94
> > > > > > > `VSDC_FB_CONFIG_ENABLE` (OUTPUT, BIT(0)) is set in
> > > > > > > `vs_crtc_atomic_enable()` and `VSDC_FB_CONFIG_RESET`
> > > > > > > (BIT(4))
> > > > > > > is
> > > > > > > set/cleared in the bridge enable/disable paths.
> > > > Well according to the driver code for DC8000 from Eswin, and
> > > > the
> > > > bit
> > > > named "VALID", maybe it should be cleared before programming
> > > > the
> > > > registers, and set after programming registers, to make the
> > > > process
> > > > of
> > > > programming registers atomic from the perspective of the
> > > > display
> > > > controller.
> > > >=20
> > > > Anyway this should require testing on real hardware to verify.
> > > >=20
> > > > By the way, I see multiple peripheral drivers for MA35D1 get
> > > > applied in
> > > > the torvalds tree, but the device tree is still only a
> > > > skeleton;
> > > > when
> > > > will the device tree be updated?
> > > >=20
> > > > Thanks,
> > > > Icenowy
> > > Thanks for pointing this out.=C2=A0I=E2=80=99ll perform tests on real=
 hardware
> > > since
> > > I haven=E2=80=99t used this bit before.
> > >=20
> > > As for the device tree,=C2=A0we plan to update it comprehensively
> > > after
> > > completing several major IPs, with the goal of releasing the
> > > update
> > > later this year.
> > Well I bought a MA35D1 board (MYIR MYB-LMA35 + RGB LCD) earlier
> > this
> > year (and this is where I got the MA35D1 identification register
> > values). Hope I can have a chance to test this driver by myself.
> >=20
> > As MMC, Ethernet and USB support is all applied, maybe it's already
> > worthy to update the device tree ;-)
> >=20
> > Thanks,
> > Icenowy
>=20
> Yes you can!
>=20
> I have performed hardware validation on the MA35D1 and found that
> this=20
> bit acts as a manual latch for the shadow registers rather than an=20
> auto-clearing trigger, which clarifies the slightly ambiguous=20
> description in the TRM.
>=20
> Following your suggestion, I will align the implementation with
> ESWIN's=20
> DC8000 logic: setting the VALID bit at atomic_begin and clearing it

Ah do you mean clearing it at begin and setting it at flush?

In the Eswin driver (which seems to be based on reference code by
Verisilicon, I saw similar driver code for DC8200),
dc_hw_enable_shadow_register() clears VALID bit when enable is true,
and all register setting sequences calls that function with enable =3D
true before setting and enable =3D false after setting.

In addition, considering this bit is called "VALID" instead of
"INVALID", I think it represents that the DC will apply the new setting
when it's set and keep the current setting when it's cleared, so I
think it should be cleared before modeset sequence and be set after
modeset sequence.

Thanks,
Icenowy

> at=20
> atomic_flush. My tests confirm this allows the hardware to latch the=20
> plane configuration correctly while avoiding the blank screen issues=20
> observed with other configurations.
>=20
> I am preparing the v2 patchset with this change, along with the=20
> requested commit splits, and will submit it shortly.=F0=9F=99=82
>=20
> > > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >=20

