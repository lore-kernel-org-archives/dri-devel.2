Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04C0109C04D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 18:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A3310E466;
	Wed, 25 Mar 2026 18:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="EDFwCxBz";
	dkim-atps=neutral
Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch
 [185.70.43.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD5D110E466
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 18:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1774463513; x=1774722713;
 bh=j86thck0cTqsFgXxw60goLvNyAwdeaXAk0Tlweu0J7A=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=EDFwCxBz+oeTss4TdxJTaOi/GaI36MwEjl7TfA4WB3rpdj8VmPUDgXenXHZ+Xs5Vp
 FYua2lTAJmXiR/LEBCTiCS8ZVvICPaSG+f7cnjKmRjiiK+NHT8PQ6aU8nHPThumDyE
 tgYF+KDwh7TAubhbT6vUjNx8/gzHrUd4oedw4KBHV6bzp2CfDb8cDO5/QAoj9CaYox
 Ljn6XpU2v5U1N1qQIDqt6kZrpWH8nqOrrWMMk6q0KGzbIaaWnaJXTLShy4VHEzZ6hK
 hPKB2rlqj2UupFz5+9PHA80/MNApMOExCxjN7+A8o8skPdhPziayWCQjtyNlHiBrhG
 rvGQOQXBbGLZg==
Date: Wed, 25 Mar 2026 18:31:47 +0000
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
From: cristian_ci <cristian_ci@protonmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
Message-ID: <E_O40YTvp6FW2yHa_lQOmzZwB1BZ7r_uCfh82T3BeO-SLK255eefzThCZDYJ2PFi3Hlnp3JXL7JWrlIU2ymh7m68wkNMTsM7jcMa8XxuxCs=@protonmail.com>
In-Reply-To: <fh7rfswcwcrquijgjq547b6jjuq2v3wxiweh5xnnd4z5ql5n7r@gt425ujkpctu>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
 <20260321-rimob-new-features-v3-1-d4b8ee867de7@protonmail.com>
 <sdcfwycey5ykhn2fghun7imx3tjtnwat3ny3mut5dwstl7wvw6@maqrzlycwdn5>
 <GF8zsK-szOM98Ck2jznCOZ4xjuJTl9g1b0uPc1N79Dzf7PNzOiVgewdqPFGjqF3YD7tOUa2tzdc7rG_e7iNH8yjHOJ9DobsihTxRLUk8EL4=@protonmail.com>
 <fh7rfswcwcrquijgjq547b6jjuq2v3wxiweh5xnnd4z5ql5n7r@gt425ujkpctu>
Feedback-ID: 27475468:user:proton
X-Pm-Message-ID: c9e8d4bc47d850f720563065e567891a08ab9c34
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tuesday, March 24th, 2026 at 23:20, Dmitry Baryshkov <dmitry.baryshkov@o=
ss.qualcomm.com> wrote:

> On Tue, Mar 24, 2026 at 01:10:13PM +0000, cristian_ci wrote:
> > On Saturday, March 21st, 2026 at 17:46, Dmitry Baryshkov <dmitry.barysh=
kov@oss.qualcomm.com> wrote:
> >
> > > This is not enough to identify the panel. This name identifies the
> > > controller inside the panel, however the exact settings (and the
> > > behaviour) would depend on the exact TFT "glass" used with this
> > > controller. Downstream usually doesn't care that much and frequently
> > > just uses the controller name or the the controller with some kind of
> > > "description" like ("wqhd-dsc-cmd").
> >
> > Ok but I just don't understand the following: I'd like to know (also
> > considering that I find it difficult to find someone, outside of this
> > ML, available to discuss this stuff, specifically) exactly why the
> > current bindings are not enough.
> > I mean: looking at schematics and datasheets of other similar devices
> > and based on observations about my device, I believe the generic bindin=
gs
> > approach for nt35532 works quite well for panels.
> > Novatek made the IC first and then whoever buys it can be a display
> > vendor. If we talk about downstream, differences between panels are des=
cribed
> > there (i.e. my panel makes use of four supplies, while other ones could=
 use
> > a different configuration).
>=20
> Different "glass" means different programming sequences. Take a look
> at the existing drivers which handle multiple panels. Sequences, modes,
> etc. are different though the DDIC (controller) is the same. For Android
> kernels this is handled by putting all the information into the DT. This
> approach does not align well with the upstream DT expectations /
> guidelines / philosophy / etc.

True. I completely forgot about that, my bad. Yes, vendors handle init=20
sequences, modes and other information in the DT, while upstream puts=20
initialization into panel driver. Now, I've looked at panel-sitronix-st7703=
.c=20
driver to get an example of multiple panels supported by the same DDIC=20
driver.

> For example, let's take two NT35532 panels described by [1], [2]. The
> sequences are somewhat similar, but the contents is completely
> different. From the upstream point of view, each should be described by
> its own compatible string (so that the kernel can identify them).
>=20
> [1] https://github.com/eliot-shao/qcom/blob/master/display/LCM-NT35532-JM=
55FH-1080p/kernel/arch/arm/boot/dts/qcom/dsi-panel-nt35532-jm55fh-1080p-vid=
eo.dtsi
> [2] https://github.com/balika011/android_kernel_xiaomi_msm8953/blob/maste=
r/arch/arm/boot/dts/qcom/dsi-panel-nt35532-fhd-video.dtsi
>=20
> >
> > > What does it mean for the upstream:
> > > - Try identifying the actual panel used for the phones. Sometimes
> > >   googling for spare or replacement parts would reveal such a name.
> > >   Sometimes it can be seen as a marking on the cable or on the backsi=
de
> > >   of the panel (again, googling).
> >
> > It seems that 'google' approach fails, in my case :( (I only know that
> > the vendor assigned Smartron the work to design the HW - but SW too -
> > of the device. Nevertheless, Smartron is neither OEM nor ODM, so the
> > company was relying, at the time, on a series of chinese manufacturers =
to provide
> > parts required for this device, including panel suppliers: in general,
> > the list of panel suppliers for Smartron includes BOE, Tianma and other=
 known
> > companies. So, this panel may be any of those, paired with NT35532, and=
 work
> > anyway). Unfortunately, even if marking on the cable is known, that doe=
sn't
> > identify the panel but the cable itself (which is available on the mark=
et,
> > though), instead, in this case.
> >
> > > - If not found, come up with some artificial identifier that would
> > >   identify the controller+glass combo (e.g. "tianma,fhd-video" or
> > >   "lenovo,j606f-boe-nt36523w" (where lenovo,j6006f is a device name a=
nd
> > >   boe is a "supplier").
> >
> > Assuming that resources available which I've as source of information
> > for this panel are limited (the ones also described in v1's review thre=
ad),
> > my vendor devicetree describes the panel in  'qcom,mdss_dsi_nt35532_108=
0p_cs_video'
> > node and makes use of:
> >
> > qcom,mdss-dsi-panel-name =3D "nt35532 1080p cs video mode dsi panel";
> >
> > property. Until now, close-to-mainline devicetree I was using the follo=
wing
> > compatible for the panel:
> >
> > compatible =3D "flipkart,rimob-nt35532-cs";
>=20
> In the lack of any information, this is probably as good as anything
> else. Please describe in your commit message that you don't know the
> exact vendor of the panel (nor the id of the panel).=20

Ok, apart adding a new compatible ("flipkart,rimob-panel-nt35532-cs") to=20
dt-bindings (patch 1/6) - leaving  "novatek,nt35532" as fallback - and=20
setting that to panel node (patch 3/6), I'll have to change (patch 2/6)=20
too, by renaming nt35532_on to rimob_panel_on and so on for nt35532_off,=20
nt35532_mode; by adding a new struct named rimob_panel_desc defining=20
.mode, .on, .off members and moving .lanes, .format and .mode_flags from=20
nt35532_probe to this new desc specific struct and by adding .data argument=
=20
to nt35532_of_match. What about the other nt35532 functions (i.e. nt35532_r=
eset)?

> > and I'm not sure about the exact meaning of 'cs' suffix. I cannot state=
 'CS'
> > as panel supplier and use that upstream without proof/evidence. What do
> > you suggest, in this regard?
> >
> >
>=20
> --
> With best wishes
> Dmitry
> 
