Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADF5CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB06910EC8D;
	Tue, 13 Oct 2026 15:38:50 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C578210EC8D
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1791905881; x=1792510681; i=jan.claussen10@web.de;
 bh=PgiVJN92/muwb7elNFvcIeBFfe4vHagX50Jl0Qlt/BM=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Message-ID:In-Reply-To:
 References:Subject:MIME-Version:Content-Type:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=RPgjQZKM61JucwcY+L9qpMt+YqlsZhv5SScPbEFL1Dm0h3wRn+jzmQnXDIHPuk+7
 pJrmySFBvJqvGcG2LSWiuqbV9DN6Kgp3uvRLsS6zZey0y9uCiuKz6MvHyY0TymlWY
 bycL7SnFx5xAUuiMqndrNZFTzN3Fhx8xtSEdr7tn2OqtaaLN3dJWi3sCpywcVqRTC
 RnPH9tolGZjLJ+jczKrOzs4KiSnL64dEUZadRC0Qkyg/Pkme7OvP459ELG1u56pb4
 c7QIlE7AttSvHpdiKSE7kaiyNajxQMWwER/IP31N2QXYY/pj0Hkb8rMUef9BNthHw
 ejPn+hZrmAClUXznkw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N8mzy-1wbUzP2NZm-014LY6; Tue, 13
 Oct 2026 17:38:01 +0200
Date: Tue, 13 Oct 2026 17:37:58 +0200
From: =?utf-8?Q?Jan_Clau=C3=9Fen?= <jan.claussen10@web.de>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Javier Martinez Canillas <javierm@redhat.com>, 
 "=?utf-8?Q?dri-devel=40lists.freedesktop.org?="
 <dri-devel@lists.freedesktop.org>, 
 "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" <linux-kernel@vger.kernel.org>
Message-ID: <7CEEA420-8680-4E4B-8A59-20EA06C9B29A@getmailspring.com>
In-Reply-To: <as3t4OTbGHIOuXlG@houat>
References: <as3t4OTbGHIOuXlG@houat>
Subject: Re: [PATCH RFC v2] drm/bridge: connector: Support the
 colorspace property for HDMI
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="6ace5056_6e7352e3_b5d"
X-Provags-ID: V03:K1:BmA+wML1/+FcCJXwtvQbmhqmNW/gnqyQERCIsYUIHt0rVMKth28
 27TD+OUI2yEbnFxFg8sQSwt0WyYxltQZ2FT9xf/+/fUx6ayyMz38w/cfoivCxnHEIVji0D2
 11hnbHWOh90oX2azpanqJKFMqWdKN3bo/YEWG1IAQ4DLdIFR/c9ToakbTexuxq83QjUCSDu
 sluPTwmpF5zc8KjUBf9JA==
UI-OutboundReport: notjunk:1;M01:P0:gJGo3mj+BUM=;uxXeUJ31GmjX0mjoOasly42mlUc
 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
 G7zNPALVYWSNO5
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

--6ace5056_6e7352e3_b5d
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Maxime,

this is where I put it before. The colorspace check could definitely land=
 in the HDMI helper. Attaching the colorspace property should only happen=
 once though. Should I move this back in the dw=5Fhdmi=5Fqp-rockchip.c=3F=

Jan
On Okt. 13 2026, at 10:40 am, Maxime Ripard <mripard=40kernel.org> wrote:=

> On Sun, Oct 11, 2026 at 02:27:32PM +0000, Jan Clau=C3=9Fen wrote:
> > Bridge connectors for HDMI do not expose the colorspace property,
> > so userspace cannot signal the colorimetry (e.g. BT.2020 for HDR).
> > KWin requires the property before it offers the HDR toggle.
> >
> > Attach the property for HDMI bridge connectors, next to the other HDM=
I
> > properties set up by drmm=5Fconnector=5Fhdmi=5Finit().
> >
> > =46orce a modeset when the property changes so the new colorimetry
> > reaches the sink, as vc4 does in its connector atomic=5Fcheck.
> >
> > After toggling HDR on, modetest shows that the correct BT.2020 color
> > space is loaded. After toggling it off, it loads the default color sp=
ace
> > again.
> >
> > Tested in KDE Plasma 6.7.5 on a Radxa Rock 5B (RK3588) with an LG
> > OLED55B87LC.
> >
> > Suggested-by: Javier Martinez Canillas <javierm=40redhat.com>
> > Signed-off-by: Jan Clau=C3=9Fen <jan.claussen10=40web.de>
> > ---
> > .../gpu/drm/display/drm=5Fbridge=5Fconnector.c =7C 25 +++++++++++++++=
+---
> > 1 file changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/display/drm=5Fbridge=5Fconnector.c b/dri=
vers/gpu/drm/display/drm=5Fbridge=5Fconnector.c
> > index 81f3e26f6fdf..885094cc6ddf 100644
> > --- a/drivers/gpu/drm/display/drm=5Fbridge=5Fconnector.c
> > +++ b/drivers/gpu/drm/display/drm=5Fbridge=5Fconnector.c
> > =40=40 -414,11 +414,24 =40=40 static int drm=5Fbridge=5Fconnector=5Fa=
tomic=5Fcheck(struct drm=5Fconnector *connector,
> > =7B
> > struct drm=5Fbridge=5Fconnector *bridge=5Fconnector =3D
> > to=5Fdrm=5Fbridge=5Fconnector(connector);
> > + struct drm=5Fconnector=5Fstate *old=5Fstate =3D
> > + drm=5Fatomic=5Fget=5Fold=5Fconnector=5Fstate(state, connector);
> > + struct drm=5Fconnector=5Fstate *new=5Fstate =3D
> > + drm=5Fatomic=5Fget=5Fnew=5Fconnector=5Fstate(state, connector);
> > + struct drm=5Fcrtc=5Fstate *crtc=5Fstate;
> >
> > - if (bridge=5Fconnector->bridge=5Fhdmi)
> > - return drm=5Fatomic=5Fhelper=5Fconnector=5Fhdmi=5Fcheck(connector, =
state);
> > + if (=21bridge=5Fconnector->bridge=5Fhdmi)
> > + return 0;
> >
> > - return 0;
> > + if (new=5Fstate->crtc && old=5Fstate->colorspace =21=3D new=5Fstate=
->colorspace) =7B
> > + crtc=5Fstate =3D drm=5Fatomic=5Fget=5Fcrtc=5Fstate(state, new=5Fsta=
te->crtc);
> > + if (IS=5FERR(crtc=5Fstate))
> > + return PTR=5FERR(crtc=5Fstate);
> > +
> > + crtc=5Fstate->mode=5Fchanged =3D true;
> > + =7D
> > +
> > + return drm=5Fatomic=5Fhelper=5Fconnector=5Fhdmi=5Fcheck(connector, =
state);
> > =7D
> >
> > static const struct drm=5Fconnector=5Fhelper=5Ffuncs drm=5Fbridge=5Fc=
onnector=5Fhelper=5Ffuncs =3D =7B
> > =40=40 -1079,6 +1092,12 =40=40 struct drm=5Fconnector *drm=5Fbridge=5F=
connector=5Finit(struct drm=5Fdevice *drm,
> > connector=5Ftype, ddc);
> > if (ret)
> > return ERR=5FPTR(ret);
> > +
> > + ret =3D drm=5Fmode=5Fcreate=5Fhdmi=5Fcolorspace=5Fproperty(connecto=
r, 0);
>
> This should come from drivers, you can't expect every driver to support=

> every HDMI colorspace.
>
> > + if (ret)
> > + return ERR=5FPTR(ret);
> > +
> > + drm=5Fconnector=5Fattach=5Fcolorspace=5Fproperty(connector);
>
> Most importantly, all that work should be in the HDMI helpers, it's an
> HDMI feature just like, say, max bpc
>
> Maxime
--6ace5056_6e7352e3_b5d
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi Maxime, </div><br><div>this is where I put it before. The colorsp=
ace check could definitely land in the HDMI helper. Attaching the colorsp=
ace property should only happen once though. Should I move this back in t=
he dw=5Fhdmi=5Fqp-rockchip.c=3F</div><br><div>Jan</div><br><div class=3D=22=
gmail=5Fquote=5Fattribution=22>On Okt. 13 2026, at 10:40 am, Maxime Ripar=
d &lt;mripard=40kernel.org&gt; wrote:</div><blockquote spellcheck=3D=22fa=
lse=22><div><div>On Sun, Oct 11, 2026 at 02:27:32PM +0000, Jan Clau=C3=9F=
en wrote:</div><div>&gt; Bridge connectors for HDMI do not expose the col=
orspace property,</div><div>&gt; so userspace cannot signal the colorimet=
ry (e.g. BT.2020 for HDR).</div><div>&gt; KWin requires the property befo=
re it offers the HDR toggle.</div><div>&gt;</div><div>&gt; Attach the pro=
perty for HDMI bridge connectors, next to the other HDMI</div><div>&gt; p=
roperties set up by drmm=5Fconnector=5Fhdmi=5Finit().</div><div>&gt;</div=
><div>&gt; =46orce a modeset when the property changes so the new colorim=
etry</div><div>&gt; reaches the sink, as vc4 does in its connector atomic=
=5Fcheck.</div><div>&gt;</div><div>&gt; After toggling HDR on, modetest s=
hows that the correct BT.2020 color</div><div>&gt; space is loaded. After=
 toggling it off, it loads the default color space</div><div>&gt; again.<=
/div><div>&gt;</div><div>&gt; Tested in KDE Plasma 6.7.5 on a Radxa Rock =
5B (RK3588) with an LG</div><div>&gt; OLED55B87LC.</div><div>&gt;</div><d=
iv>&gt; Suggested-by: Javier Martinez Canillas &lt;javierm=40redhat.com&g=
t;</div><div>&gt; Signed-off-by: Jan Clau=C3=9Fen &lt;jan.claussen10=40we=
b.de&gt;</div><div>&gt; ---</div><div>&gt; .../gpu/drm/display/drm=5Fbrid=
ge=5Fconnector.c =7C 25 ++++++++++++++++---</div><div>&gt; 1 file changed=
, 22 insertions(+), 3 deletions(-)</div><div>&gt;</div><div>&gt; diff --g=
it a/drivers/gpu/drm/display/drm=5Fbridge=5Fconnector.c b/drivers/gpu/drm=
/display/drm=5Fbridge=5Fconnector.c</div><div>&gt; index 81f3e26f6fdf..88=
5094cc6ddf 100644</div><div>&gt; --- a/drivers/gpu/drm/display/drm=5Fbrid=
ge=5Fconnector.c</div><div>&gt; +++ b/drivers/gpu/drm/display/drm=5Fbridg=
e=5Fconnector.c</div><div>&gt; =40=40 -414,11 +414,24 =40=40 static int d=
rm=5Fbridge=5Fconnector=5Fatomic=5Fcheck(struct drm=5Fconnector *connecto=
r,</div><div>&gt; =7B</div><div>&gt; struct drm=5Fbridge=5Fconnector *bri=
dge=5Fconnector =3D</div><div>&gt; to=5Fdrm=5Fbridge=5Fconnector(connecto=
r);</div><div>&gt; + struct drm=5Fconnector=5Fstate *old=5Fstate =3D</div=
><div>&gt; + drm=5Fatomic=5Fget=5Fold=5Fconnector=5Fstate(state, connecto=
r);</div><div>&gt; + struct drm=5Fconnector=5Fstate *new=5Fstate =3D</div=
><div>&gt; + drm=5Fatomic=5Fget=5Fnew=5Fconnector=5Fstate(state, connecto=
r);</div><div>&gt; + struct drm=5Fcrtc=5Fstate *crtc=5Fstate;</div><div>&=
gt;</div><div>&gt; - if (bridge=5Fconnector-&gt;bridge=5Fhdmi)</div><div>=
&gt; - return drm=5Fatomic=5Fhelper=5Fconnector=5Fhdmi=5Fcheck(connector,=
 state);</div><div>&gt; + if (=21bridge=5Fconnector-&gt;bridge=5Fhdmi)</d=
iv><div>&gt; + return 0;</div><div>&gt;</div><div>&gt; - return 0;</div><=
div>&gt; + if (new=5Fstate-&gt;crtc &amp;&amp; old=5Fstate-&gt;colorspace=
 =21=3D new=5Fstate-&gt;colorspace) =7B</div><div>&gt; + crtc=5Fstate =3D=
 drm=5Fatomic=5Fget=5Fcrtc=5Fstate(state, new=5Fstate-&gt;crtc);</div><di=
v>&gt; + if (IS=5FERR(crtc=5Fstate))</div><div>&gt; + return PTR=5FERR(cr=
tc=5Fstate);</div><div>&gt; +</div><div>&gt; + crtc=5Fstate-&gt;mode=5Fch=
anged =3D true;</div><div>&gt; + =7D</div><div>&gt; +</div><div>&gt; + re=
turn drm=5Fatomic=5Fhelper=5Fconnector=5Fhdmi=5Fcheck(connector, state);<=
/div><div>&gt; =7D</div><div>&gt;</div><div>&gt; static const struct drm=5F=
connector=5Fhelper=5Ffuncs drm=5Fbridge=5Fconnector=5Fhelper=5Ffuncs =3D =
=7B</div><div>&gt; =40=40 -1079,6 +1092,12 =40=40 struct drm=5Fconnector =
*drm=5Fbridge=5Fconnector=5Finit(struct drm=5Fdevice *drm,</div><div>&gt;=
 connector=5Ftype, ddc);</div><div>&gt; if (ret)</div><div>&gt; return ER=
R=5FPTR(ret);</div><div>&gt; +</div><div>&gt; + ret =3D drm=5Fmode=5Fcrea=
te=5Fhdmi=5Fcolorspace=5Fproperty(connector, 0);</div><br><div>This shoul=
d come from drivers, you can't expect every driver to support</div><div>e=
very HDMI colorspace.</div><br><div>&gt; + if (ret)</div><div>&gt; + retu=
rn ERR=5FPTR(ret);</div><div>&gt; +</div><div>&gt; + drm=5Fconnector=5Fat=
tach=5Fcolorspace=5Fproperty(connector);</div><br><div>Most importantly, =
all that work should be in the HDMI helpers, it's an</div><div>HDMI featu=
re just like, say, max bpc</div><br><div>Maxime</div></div></blockquote>
--6ace5056_6e7352e3_b5d--

