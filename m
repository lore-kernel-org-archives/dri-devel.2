Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0356CCD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DBC610E2B5;
	Mon, 18 May 2026 16:31:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m4vHn98Y";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BC2B10E2B5
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:31:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 70DFB6001A;
 Mon, 18 May 2026 16:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9105C2BCB7;
 Mon, 18 May 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779121882;
 bh=jMB5NoP0wP+6A9Zh0OD36Hq603Uurn3NLlC4stKV5Ag=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m4vHn98Y6yqiR5nHUZYeHgIe1GYZOYxdaAUikdAIiclUlR6G0/TQadLFDESIfFWtx
 NAVKpOQRnJ+nc/mPfCztm3u6bR2H6K0grub1oakThM22+VJHHuLc58PBo15oAzJ91G
 fmtIaJIMaDtW5XxTdwpJeXJCrwKTCuZL3nkc2mEgCCYTLUyI2tk8Wxe3PT2ZWlfYZO
 P8h0kIgpuEKUOSr2QnSm0jZ0i9cC8d54ihfJYsTM3HkAfyNyIcu184dDHGMTb++Zd4
 RYmeY0C4vfm0QUnrJkvOKototuGqQl/n6C9mSOFMgc7H0eAXMLhqYCcvfOCnz5kf5C
 RfUETTXb/PvtA==
Date: Mon, 18 May 2026 17:31:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: Conor Dooley <conor.dooley@microchip.com>, hjc@rock-chips.com,
 heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com,
 nicolas.frattaroli@collabora.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org,
 m.szyprowski@samsung.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: display: rockchip: analogix-dp:
 Expose inherited properties
Message-ID: <20260518-bootlace-afoot-8da24d7c9d13@spud>
References: <20260514070133.2275069-1-damon.ding@rock-chips.com>
 <20260514070133.2275069-2-damon.ding@rock-chips.com>
 <20260514-upstate-sneer-0b6e78682798@spud>
 <2f653664-27e9-4632-97e9-8b59cf7e585e@rock-chips.com>
 <20260515-confess-hungrily-4f64ce0d8de2@wendy>
 <a7ab01f6-78a4-405f-8160-8af31a8ef99c@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zu1z+34yeGAH2xIH"
Content-Disposition: inline
In-Reply-To: <a7ab01f6-78a4-405f-8160-8af31a8ef99c@rock-chips.com>
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


--zu1z+34yeGAH2xIH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 10:44:29AM +0800, Damon Ding wrote:
> Hi Conor,
>=20
> On 5/15/2026 5:04 PM, Conor Dooley wrote:
> > On Fri, May 15, 2026 at 11:57:58AM +0800, Damon Ding wrote:
> > > Hi Conor,
> > >=20
> > > On 5/15/2026 2:16 AM, Conor Dooley wrote:
> > > > On Thu, May 14, 2026 at 03:01:31PM +0800, Damon Ding wrote:
> > > > > Expose the inherited properties from the base analogix-dp schema
> > > > > to satisfy unevaluatedProperties constraints.
> > > > >=20
> > > > > Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> > > >=20
> > > > Given it's unevaluatedProperties, not addtionalProperties, this pat=
ch
> > > > shouldn't be needed?
> > > >=20
> > >=20
> > > When I remove both the top-level data-lanes property and those explic=
it
> > > "xxx: true" property entries and run the dtbs check with:
> > >=20
> > > make CHECK_DTBS=3Dy CROSS_COMPILE=3Daarch64-linux-gnu- LT0=3Dnone LLV=
M=3D1
> > > LLVM_IAS=3D1 ARCH=3Darm64 rockchip/rk3588-evb1-v10.dtb
> > > rockchip/rk3588s-evb1-v10.dtb rockchip/rk3399-sapphire-excavator.dtb
> > > rockchip/rk3576-evb1-v10.dtb -j4
> > >=20
> > > It results in validation errors like these:
> > >=20
> > > /home/ding/drm-misc/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb:
> > > edp@27dc0000: ports:port@1:endpoint: Unevaluated properties are not a=
llowed
> > > ('data-lanes' was unexpected)
> > >          from schema $id:
> > > http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.y=
aml#
> > > /home/ding/drm-misc/arch/arm64/boot/dts/rockchip/rk3576-evb1-v10.dtb:
> > > edp@27dc0000: Unevaluated properties are not allowed ('force-hpd',
> > > 'interrupts', 'phy-names', 'phys', 'ports', 'reg' were unexpected)
> > >          from schema $id:
> > > http://devicetree.org/schemas/display/rockchip/rockchip,analogix-dp.y=
aml#
> > >=20
> > > I suspect that the properties defined in the child binding are
> > > overriding/masking all the inherited properties from the parent Analo=
gix DP
> > > schema.
> > >=20
> > > Is there a better way to fix this issue without explicitly listing all
> > > inherited properties as true?
> >=20
> > The example in this file uses most of the properties that you mention
> > above:
> >      dp@ff970000 {
> >        compatible =3D "rockchip,rk3288-dp";
> >        reg =3D <0xff970000 0x4000>;
> >        interrupts =3D <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
> >        clocks =3D <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
> >        clock-names =3D "dp", "pclk";
> >        phys =3D <&dp_phy>;
> >        phy-names =3D "dp";
> >        resets =3D <&cru 111>;
> >        reset-names =3D "dp";
> >        rockchip,grf =3D <&grf>;
> >        pinctrl-0 =3D <&edp_hpd>;
> >        pinctrl-names =3D "default";
> >=20
> > dt_binding_check reports no problems with this node, so I think the
> > problem might lie elsewhere?
> > There's no edp node in the dts you mention above, so this looks like an
> > interaction with something that's not yet upstream.
>=20
> Ah, I see.
>=20
> I did add extra changes to the edp node on my local rk3576-evb1 board DTS,
> which indeed caused this 'asymmetric information' issue and made the
> validation fail incorrectly.
>=20
> I will try adding the data-lanes property to the example in the binding
> document to ensure dt_binding_check passes cleanly.
>=20
> >=20
> > If this is required for the rk3576 edp, then you should include this
> > patch in the rk3576 edp support series rather than this one anyway where
> > it can actually be evaluated alongside the node it apparently causes
> > problems with.
>=20
> The data-lanes property is actually applicable and useful for all Rockchip
> eDP platforms, not just rk3576.
>=20
> In the next version, I will modify the series to better separate this com=
mon
> data-lanes change from the rk3576 specific eDP support patches.

To be clear, I wasn't talking about data-lanes here, I was talking about
this patch that addressed the properties inherited from the common
analogix-dp.yaml.

--zu1z+34yeGAH2xIH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCags+0gAKCRB4tDGHoIJi
0r+xAQCCA3hrAk8UTFXKlAQIK/tQrNfrXeTUlCpoCL4QRVIvSQEAlMrMbINx6Xd0
QZxf04KGcPEvkVb/5IExzbmxUZ8p7Ak=
=TgMj
-----END PGP SIGNATURE-----

--zu1z+34yeGAH2xIH--
