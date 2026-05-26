Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B4BCD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 08:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD7CB10E5DF;
	Tue, 26 May 2026 08:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="Wuq0HNWI";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA6A710E603
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 08:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779783515; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FWZ2tYymJfyIfly1WlPJXKZgBvoXqNA/WEM7NYQE6cT6/PhQ0AQzAQDVCE9LG1XRoFuqbkNgL5kugLKYC0whqISUtDp+mIZqMKqvoHDpRXbglLd/NdJrRgYsPQUbwSoxAAZ60K6BS+OIess6NKtJMg/N6pJk7y4vKBv2Z0hZhPk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779783515;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=VxdYd1cKkV0EdIWlixskBAMHzoXvyNtx9ZGHc6qepk8=; 
 b=MOTzvRekXYnFgo18gwlhZ6E8iyxs9PBQEY3q33hHnkea/UEbmFK8pKxJDqN8CAHFtrRMVevVcUNato+rrPsgKswLArjqwYXrTTgEnnjcAKFCYIodvBjyIzxtXSph0OQYvJTAEpy7uHBibAxmLLv2jkHomMqe9psMxKnHectcKAo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779783515; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=VxdYd1cKkV0EdIWlixskBAMHzoXvyNtx9ZGHc6qepk8=;
 b=Wuq0HNWIK3LpgkbB/KUjGhGHyg8nK/KT2+H6BS3+34imCG/2C4OMkjyXdYUsCSTE
 gkaGLSQ9hi4CyDduXKqKaoyw/2d2ug45rkaFW48Hp9tmb0PmOG+/oYX2A0H1kJr73cD
 AP9VQUFXoSYj+2EzZx7zn2KCuH9olUYTXQ06xLMYK/L/AnZCscKi0yC0d/ByCyr0o5H
 ZAS4zZkZxlfx6xphon039Gy9q1q4qWc5R+cQJTKFmbL6A3LRgMOtfLOfFLlskVqn3K+
 pNn/WbdUST94/jOsTFV26SShtiDRKvShOuq1EhuxODv0TNbUKkaEjrx2M9EIdiSou67
 mzwcm8NEhA==
Received: by mx.zohomail.com with SMTPS id 177978351302433.27254888770108;
 Tue, 26 May 2026 01:18:33 -0700 (PDT)
Message-ID: <da7033ca1c9a5fbce6b48ad684644c56c366a74b.camel@icenowy.me>
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
From: Icenowy Zheng <uwu@icenowy.me>
To: Thomas Zimmermann <tzimmermann@suse.de>, Ville =?ISO-8859-1?Q?Syrj=E4l=E4?=
 <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Tue, 26 May 2026 16:18:12 +0800
In-Reply-To: <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <ee86cb43-e5df-4946-a957-931a73dde752@suse.de> <ahBWayIcQUHuAt4i@intel.com>
 <b4b2e8cb-dd7c-42c2-88b7-0a2ab95a90ee@suse.de>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
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

=E5=9C=A8 2026-05-22=E4=BA=94=E7=9A=84 15:24 +0200=EF=BC=8CThomas Zimmerman=
n=E5=86=99=E9=81=93=EF=BC=9A
> Hi
>=20
> Am 22.05.26 um 15:13 schrieb Ville Syrj=C3=A4l=C3=A4:
> > On Fri, May 22, 2026 at 01:55:59PM +0200, Thomas Zimmermann wrote:
> > > Hi
> > >=20
> > > Am 19.05.26 um 11:24 schrieb Icenowy Zheng:
> > > > Currently the implementaion of
> > > > drm_client_modeset_wait_for_vblank()
> > > > assumes drm_vblank_get() will fail when the CRTC isn't active.
> > > > However
> > > > it seems that this is not true, and running fbcon on a device
> > > > with the
> > > > first CRTC inactive will lead to kernel warning in some cases
> > > > (which
> > > > could be reproduced with the loongson driver).
> > > >=20
> > > > Change the implementation to add a check for the active state
> > > > (atomic) /
> > > > enabled state (non-atomic) before calling drm_vblank_get(). As
> > > > the
> > > > assumption of drm_vblank_get() failing for inactive CRTC isn't
> > > > met, the
> > > > error status of drm_vblank_get() can now be exported too.
> > > >=20
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker
> > > > with vblank")
> > > > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > > > ---
> > > > =C2=A0=C2=A0 drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++-=
-
> > > > =C2=A0=C2=A0 1 file changed, 11 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/drm_client_modeset.c
> > > > b/drivers/gpu/drm/drm_client_modeset.c
> > > > index bb49b8361271a..1b03bf351256e 100644
> > > > --- a/drivers/gpu/drm/drm_client_modeset.c
> > > > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > > > @@ -1310,7 +1310,7 @@ int
> > > > drm_client_modeset_wait_for_vblank(struct drm_client_dev
> > > > *client, unsigned i
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0	struct drm_device *dev =3D client->dev;
> > > > =C2=A0=C2=A0=C2=A0	struct drm_crtc *crtc;
> > > > -	int ret;
> > > > +	int ret =3D 0;
> > > > =C2=A0=C2=A0=20
> > > > =C2=A0=C2=A0=C2=A0	/*
> > > > =C2=A0=C2=A0=C2=A0	 * Rate-limit update frequency to vblank. If the=
re's a
> > > > DRM master
> > > > @@ -1326,15 +1326,24 @@ int
> > > > drm_client_modeset_wait_for_vblank(struct drm_client_dev
> > > > *client, unsigned i
> > > > =C2=A0=C2=A0=C2=A0	 * Only wait for a vblank event if the CRTC is
> > > > enabled, otherwise
> > > > =C2=A0=C2=A0=C2=A0	 * just don't do anything, not even report an er=
ror.
> > > > =C2=A0=C2=A0=C2=A0	 */
> > > > +	if (drm_drv_uses_atomic_modeset(dev)) {
> > > > +		if (!crtc->state || !crtc->state->active)
> > > > +			goto out;
> > > > +	} else {
> > > > +		if (!crtc->enabled)
> > > > +			goto out;
> > > > +	}
> > > > +
> > > This part is good.
> > Locking is missing.
>=20
> Ok
>=20
> >=20
> > > > =C2=A0=C2=A0=C2=A0	ret =3D drm_crtc_vblank_get(crtc);
> > > > =C2=A0=C2=A0=C2=A0	if (!ret) {
> > > > =C2=A0=C2=A0=C2=A0		drm_crtc_wait_one_vblank(crtc);
> > > > =C2=A0=C2=A0=C2=A0		drm_crtc_vblank_put(crtc);
> > > > =C2=A0=C2=A0=C2=A0	}
> > > > =C2=A0=C2=A0=20
> > > > +out:
> > > > =C2=A0=C2=A0=C2=A0	drm_master_internal_release(dev);
> > > > =C2=A0=C2=A0=20
> > > > -	return 0;
> > > > +	return ret;
> > > But this isn't. There can be CRTCs without any vblank at all. We
> > > still
> > > want to fail silently for them. So we still have to return 0
> > > here.
> > >=20
> > > Having set this, fixing this helper is only partially what you
> > > want.
> > > Since your device has vblanking, the emulation should check on
> > > the
> > > correct CRTC. IOW you need to pass the right CRTC index at
> > >=20
> > > https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_=
fb_helper.c#L237
> > > https://elixir.bootlin.com/linux/v7.1-rc1/source/drivers/gpu/drm/drm_=
fb_helper.c#L920
> > >=20
> > > I'm not quite sure how to support this. The CRTC is under
> > > fb_helper->client.modesets.crtc. You'd have to figure out which
> > > is the
> > > relevant one and use that. But that's also not so great, as fbdev
> > > ioctls
> > > only support CRTC 0. Doing internal re-mappings only complicates
> > > matters.
> > >=20
> > > But why does your HW use CRTC 1 in the first place.
> > Could be eg. the enabled outputs can't be driven with CRTC 0.
> >=20
> > I guess what you want to do is pick the first crtc from modesets[]
> > which is enabled. Or perhaps even "pick the Nth enabled crtc from
> > modesets[] based on the ioctl argument".
>=20
> The enable-status of each CRTC could change later on, which might
> lead=20

Well, maybe it's too difficult for things like fbdev to support
hotplugging outputs.

Maybe just use crtcs from modeset[] and check its enable status before
doing vblank wait, and have the vsync waiting falling back to nothing
when the initial CRTC of it isn't now enabled?

This will at least make some usages of fbdev work and restrict the
failure for other usages (e.g. doesn't enable vblank on a not enabled
CRTC).

Thanks,
Icenowy

> to problems.=C2=A0 Picking the one CRTC/output with the lowest spec and=
=20
> mirroring it to the others might work. This CRTC would then be the
> one=20
> to wait for.
>=20
> Best regards
> Thomas
>=20
> >=20
