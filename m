Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4C4CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F2E10E37F;
	Tue, 19 May 2026 11:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="TuR/+cE0";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B05210E37F
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779190186; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dyeKZ0M1kWsWaYXB/7WcHP+gyv7GguWHBp54aZ+mK4IpW6TjJHj4DZuG2nl2K7ROR2tgMm95hl04wVFOqaFtdi78Y+TJ3z7U5Udoh1k3tI9hKZABK3VeA3XX9WEGDEnt/W/ocOBze36ZnCk9L6zur9o6CKiyAKbHU56VDf3sans=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779190186;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=a21y7ylbJXMSnfljwvz1osdThtDDH25yBXqtvFOA67k=; 
 b=ZH47nl5zor2lKb6QwkJ1AVcjSAflDN947dg4QcS6NttsKv5/10qK+Pv2SQossIAQBrfoq8+cEOIfDX6Z3/GMfZk0wa5k2bJx1mJDPlxMElTc0XPzTnfKDA2imU+dnOw5McQAO0y4PmHBWwgklxj8LvFTo9ObTKU8Y03iXqnZUO0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779190186; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=a21y7ylbJXMSnfljwvz1osdThtDDH25yBXqtvFOA67k=;
 b=TuR/+cE02QEEbcM2MyCuO/oYImS84pmWGp1CI+a69QZtUkOqgwI8cdqUs2i6T83e
 bgvW0oXoxxMNLLxFg2sno4K19S8YrGn9i/RnwyueH453T0a2ks/VB55w9/ET3h6T0sV
 xacsp0Wdao7+0YWWl7zq2t+Gt02ttTNQnbspoh8ZtErNcwpNf9wwCGUWunAEVApiKwx
 o6iHedJeUfnuRbrpazlbQ0vWsvHsZiy7NLp9OKrQ5oYJAMOyt8DSHP9CDVlhwG2tGsG
 3rg1yVjEs/v5yMtOP5Q8SEt2oPGYbxjX5mebf30JPOeBmr2FsgxFVRWsAEGGlQ2DcdF
 iSnBp80deg==
Received: by mx.zohomail.com with SMTPS id 1779190183865602.4770060891767;
 Tue, 19 May 2026 04:29:43 -0700 (PDT)
Message-ID: <7b49ae842c07a0437e6851aae944003785ef31a3.camel@icenowy.me>
Subject: Re: [PATCH] drm/client: check whether CRTC is active before waiting
 for vblank
From: Icenowy Zheng <uwu@icenowy.me>
To: Jani Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Date: Tue, 19 May 2026 19:29:33 +0800
In-Reply-To: <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
References: <20260519092420.1124348-1-zhengxingda@iscas.ac.cn>
 <889a09d63c62d88a85d8a31a85feb8bbc178534c@intel.com>
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

=E5=9C=A8 2026-05-19=E4=BA=8C=E7=9A=84 12:41 +0300=EF=BC=8CJani Nikula=E5=
=86=99=E9=81=93=EF=BC=9A
> On Tue, 19 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> > Currently the implementaion of drm_client_modeset_wait_for_vblank()
> > assumes drm_vblank_get() will fail when the CRTC isn't active.
> > However
> > it seems that this is not true, and running fbcon on a device with
> > the
> > first CRTC inactive will lead to kernel warning in some cases
> > (which
> > could be reproduced with the loongson driver).
> >=20
> > Change the implementation to add a check for the active state
> > (atomic) /
> > enabled state (non-atomic) before calling drm_vblank_get(). As the
> > assumption of drm_vblank_get() failing for inactive CRTC isn't met,
> > the
> > error status of drm_vblank_get() can now be exported too.
> >=20
> > Cc: stable@vger.kernel.org
> > Fixes: d8c4bddcd8bc ("drm/fb-helper: Synchronize dirty worker with
> > vblank")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> > =C2=A0drivers/gpu/drm/drm_client_modeset.c | 13 +++++++++++--
> > =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_client_modeset.c
> > b/drivers/gpu/drm/drm_client_modeset.c
> > index bb49b8361271a..1b03bf351256e 100644
> > --- a/drivers/gpu/drm/drm_client_modeset.c
> > +++ b/drivers/gpu/drm/drm_client_modeset.c
> > @@ -1310,7 +1310,7 @@ int drm_client_modeset_wait_for_vblank(struct
> > drm_client_dev *client, unsigned i
> > =C2=A0{
> > =C2=A0	struct drm_device *dev =3D client->dev;
> > =C2=A0	struct drm_crtc *crtc;
> > -	int ret;
> > +	int ret =3D 0;
> > =C2=A0
> > =C2=A0	/*
> > =C2=A0	 * Rate-limit update frequency to vblank. If there's a DRM
> > master
> > @@ -1326,15 +1326,24 @@ int
> > drm_client_modeset_wait_for_vblank(struct drm_client_dev *client,
> > unsigned i
> > =C2=A0	 * Only wait for a vblank event if the CRTC is enabled,
> > otherwise
> > =C2=A0	 * just don't do anything, not even report an error.
> > =C2=A0	 */
>=20
> I'll dodge the question whether the change below is right or not, but
> for sure the comment above needs to be amended to match the change.

If the change is right, it perfectly matches what the comment above is
saying -- it's the current behavior that does not match the comment.

Thanks,
Icenowy

>=20
> (Please wait for other review comments before sending another version
> with the comment changed.)
>=20
> BR,
> Jani.
>=20
> > +	if (drm_drv_uses_atomic_modeset(dev)) {
> > +		if (!crtc->state || !crtc->state->active)
> > +			goto out;
> > +	} else {
> > +		if (!crtc->enabled)
> > +			goto out;
> > +	}
> > +
> > =C2=A0	ret =3D drm_crtc_vblank_get(crtc);
> > =C2=A0	if (!ret) {
> > =C2=A0		drm_crtc_wait_one_vblank(crtc);
> > =C2=A0		drm_crtc_vblank_put(crtc);
> > =C2=A0	}
> > =C2=A0
> > +out:
> > =C2=A0	drm_master_internal_release(dev);
> > =C2=A0
> > -	return 0;
> > +	return ret;
> > =C2=A0}
> > =C2=A0EXPORT_SYMBOL(drm_client_modeset_wait_for_vblank);
