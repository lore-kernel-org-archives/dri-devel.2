Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CCCD8C92
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 09:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C41ED10F024;
	Mon,  8 Jun 2026 09:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F8edl6OX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E163C10F024
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:17:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2DE4406E7;
 Mon,  8 Jun 2026 09:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8F01F00893;
 Mon,  8 Jun 2026 09:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780910276;
 bh=dgqu6KzfbRiaFztUl8n6hnkGE5DMDdl4m+11IAfZFe8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=F8edl6OX6sIH78JKJF4DOVpRYHKkvWc/xgxsjZm/7f2JatgwoDI/di3zuqQYVxtq6
 5HU5xHZcuvyIuTwjSGQq6HP/fwXQE+6VUrkzR8NHLbKxK2OVDsDKRvirwcpG+i1XlD
 iY/xhiPw07uCqUn3fhZ+sszN8Kff0tuSmQ6IApP7ivvX4Bs+hB37ziO/clEdKEsAYI
 CZsNzNUOLZ2U87xY75+VDRhG4/vwuwXzKlrbQX72LQeWjDruzJNVJ1KmsP5/laFSja
 8gEQFLkwC6SpOUtFjSUyR1lCmd7GmLYE1zGBxyFZ1DvfQJN3+h7HbWl8xydcm62dTH
 fmx+4T5eg8w8g==
Date: Mon, 8 Jun 2026 11:17:54 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Alexey Charkov <alchark@flipper.net>
Cc: Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/rockchip: dw_hdmi_qp: expose "overscan" property
Message-ID: <20260608-judicious-maroon-toucanet-a8f610@houat>
References: <20260602-hdmi-overscan-v1-0-31f71b817c80@flipper.net>
 <20260602-hdmi-overscan-v1-2-31f71b817c80@flipper.net>
 <20260603-glittering-vigilant-beluga-0c6bf6@houat>
 <CAKTNdwE5uAOc9V+L1J7_QJfW45D-K-vTnpHuktxD2=x9e_4jOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="3wuqchwy36r7xdmf"
Content-Disposition: inline
In-Reply-To: <CAKTNdwE5uAOc9V+L1J7_QJfW45D-K-vTnpHuktxD2=x9e_4jOQ@mail.gmail.com>
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


--3wuqchwy36r7xdmf
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/rockchip: dw_hdmi_qp: expose "overscan" property
MIME-Version: 1.0

Hi Alexey,

On Wed, Jun 03, 2026 at 12:15:04PM +0400, Alexey Charkov wrote:
> On Wed, Jun 3, 2026 at 11:55=E2=80=AFAM Maxime Ripard <mripard@kernel.org=
> wrote:
> >
> > On Tue, Jun 02, 2026 at 09:00:40PM +0400, Alexey Charkov wrote:
> > > Expose the "overscan" connector property as recognized by KWin and the
> > > likes to compensate for TV overscan cropping.
> > >
> > > The CRTC will use the margin values derived from this overscan percen=
tage
> > > in its post-composition scaler to add appropriate blank margins on all
> > > sides of the output image so that the TV doesn't eat up visible conte=
nt.
> > >
> > > Signed-off-by: Alexey Charkov <alchark@flipper.net>
> > > ---
> > >  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers=
/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > index f35484715c2d..fae44d11dbef 100644
> > > --- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > +++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
> > > @@ -137,10 +137,18 @@ dw_hdmi_qp_rockchip_encoder_atomic_check(struct=
 drm_encoder *encoder,
> > >                                        struct drm_connector_state *co=
nn_state)
> > >  {
> > >       struct rockchip_hdmi_qp *hdmi =3D to_rockchip_hdmi_qp(encoder);
> > > +     const struct drm_display_mode *adj_mode =3D &crtc_state->adjust=
ed_mode;
> > >       struct rockchip_crtc_state *s =3D to_rockchip_crtc_state(crtc_s=
tate);
> > >       union phy_configure_opts phy_cfg =3D {};
> > > +     unsigned int overscan;
> > >       int ret;
> > >
> > > +     overscan =3D min(conn_state->tv.overscan, 100u);
> > > +     s->tv_margins.left   =3D adj_mode->hdisplay * overscan / 200;
> > > +     s->tv_margins.right  =3D s->tv_margins.left;
> > > +     s->tv_margins.top    =3D adj_mode->vdisplay * overscan / 200;
> > > +     s->tv_margins.bottom =3D s->tv_margins.top;
> > > +
> > >       if (hdmi->tmds_char_rate =3D=3D conn_state->hdmi.tmds_char_rate=
 &&
> > >           s->output_bpc =3D=3D conn_state->hdmi.output_bpc)
> > >               return 0;
> > > @@ -603,6 +611,14 @@ static int dw_hdmi_qp_rockchip_bind(struct devic=
e *dev, struct device *master,
> > >               return dev_err_probe(hdmi->dev, PTR_ERR(connector),
> > >                                    "Failed to init bridge connector\n=
");
> > >
> > > +     ret =3D drm_mode_create_tv_properties_legacy(drm, 0, NULL);
> > > +     if (ret)
> > > +             return dev_err_probe(dev, ret,
> > > +                                  "Failed to create TV connector pro=
perties\n");
> > > +
> > > +     drm_object_attach_property(&connector->base,
> > > +                                drm->mode_config.tv_overscan_propert=
y, 0);
> > > +
> >
> > As the name suggests, it's a legacy property only ever used for TV. You
> > should be using drm_mode_create_tv_margin_properties()
>=20
> Hi Maxime, I tried that one before going for the current solution but
> realized that the userspace tooling I care about (KWin in particular)
> doesn't recognize those properties, but it does recognize "overscan".
> Maybe there's a compat helper somewhere that I missed, which would
> translate between the two?
>=20
> It is for TVs. Turns out that having a proper right-sized digital
> input interface doesn't prevent them from doing weird stuff with the
> image data, i.e. overscanning and cropping it right where one would
> expect to see the system tray and panel.

When I said "TV", I meant old-school analog TV, not modern HDMI ones :)

I guess it's a Kwin issue then. To my knowledge, there's 0 HDMI driver
implementing the legacy tv properties, when VC4 implements the margin
ones for HDMI.

Maxime

--3wuqchwy36r7xdmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiaIwQAKCRAnX84Zoj2+
dhCxAYD7DedUCXFMxG0zmpyP1mKhk0Nd/DHzQYvVYJqw8KALO6D0if0LDkgPoiEp
ANJVCzIBgKeFDn4t7faQQCMU/doiZGX1KvxOkHQPnm76uToF7SfXfdOPNQX0SADd
E85+6C88Gw==
=+4Lh
-----END PGP SIGNATURE-----

--3wuqchwy36r7xdmf--
