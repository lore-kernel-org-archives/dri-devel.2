Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ACACD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9DDD10E460;
	Tue, 26 May 2026 07:55:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="EyHhyQCj";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81D810E460
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:55:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779782137; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fgixMFn6rMnjjKUM+sBWdmqRcTslAd7VLVM2kE4B4dYGSJleDYxgh/TMHvnPDQ2XCTR6kbgFeYsyu4oTITCbn/TNZR3lpkcZOpqt+cKD7CU+FBe3cXwaJ8fi1S0YdJJWbcbbr1Ylm3nL/EMoRlcBnFyzsNbwXH2YSjYlzt8HMAI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779782137;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ExXMdbcWcv8RSaLXH889J+z4GdxKMlmS3aDNlQoeh1E=; 
 b=ViL2SW+QdQ1d+Hx5Prp9VQLjXmfdkySSEuuuC8H9qfqky3k88GMp8O/AJ8oUmOLC8hWEB98x4OJcxAr9eQNEFp4i2axTUUBf1v/nxxRGzrdxnsMCwVjv9gKdN0LRmeS40xy3G7fF7eVhiRHVIFJDQJtJ4SJh4/3EEQVKB6fgrx0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779782137; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=ExXMdbcWcv8RSaLXH889J+z4GdxKMlmS3aDNlQoeh1E=;
 b=EyHhyQCjFuEraVpitcT1G0bpsIbhKMXaZR7/QGoLimLKeoInaBkhwuF45/53lSwI
 la5pku/sYyVS7E3r+SCZljufbIDzmh49vYWaWAhmmMkSBDi0pGF+lPKuHkJ+qn4Ot68
 +Z9fKtZZj/dxJa8B2lRvSvx5PQ19OR7PR56TG6c1/tQTmiNWrABgZpMQ2758H8byIT1
 UFX0Af0Gw6XjwnA0TrGSFk7pupsvXQhw5sid2CGwZzI0bptTFlb6HQ4huy1EXAYmlsy
 BHImMJBshxZoQHGrHRHp0hWUHOLY92x+7dEo86czXNpaSKkmC4yV0ugBIf0T1Zr7aih
 AEnCEp21ZA==
Received: by mx.zohomail.com with SMTPS id 1779782135433335.38704084224946;
 Tue, 26 May 2026 00:55:35 -0700 (PDT)
Message-ID: <13c5353319e4c9e11e8d3360e9413f227a221a7d.camel@icenowy.me>
Subject: Re: [PATCH drm-misc-next] drm: verisilicon: fix build failure of
 cursor plane code
From: Icenowy Zheng <uwu@icenowy.me>
To: Jani Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 26 May 2026 15:55:28 +0800
In-Reply-To: <5c768f5d867d7cba875e0d06678f57594a022ddf@intel.com>
References: <20260525153618.1336239-1-zhengxingda@iscas.ac.cn>
 <5c768f5d867d7cba875e0d06678f57594a022ddf@intel.com>
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

=E5=9C=A8 2026-05-26=E4=BA=8C=E7=9A=84 10:44 +0300=EF=BC=8CJani Nikula=E5=
=86=99=E9=81=93=EF=BC=9A
> On Mon, 25 May 2026, Icenowy Zheng <zhengxingda@iscas.ac.cn> wrote:
> > The cursor plane patch was stalled for a too long time that the
> > struct drm_atomic_state parameter of atomic modeset hooks has been
> > changed to struct drm_atomic_commit.
>=20
> Yeah, but that was merged in the same branch three weeks ago. Did you
> not build the changes before pushing?

Oops this driver is not yet compiled with rerere configs on x86/arm*
(maybe because currently only some RISC-V SoC is supported -- Nuvoton
people is adding support for their MA35D1 SoC to it).

Thanks,
Icenowy

>=20
> BR,
> Jani.
>=20
> > Fix this by replacing the parameter's type. All helpers that
> > retrieve
> > information from this struct are also changed so simply replacing
> > the
> > type works.
> >=20
> > Fixes: 8c4ae2189125 ("drm: verisilicon: add support for cursor
> > planes")
> > Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> > ---
> > =C2=A0drivers/gpu/drm/verisilicon/vs_cursor_plane.c | 8 ++++----
> > =C2=A01 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > index acb9854fa67ed..fa4f601dd0c87 100644
> > --- a/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > +++ b/drivers/gpu/drm/verisilicon/vs_cursor_plane.c
> > @@ -40,7 +40,7 @@ static bool vs_cursor_plane_check_coord(int32_t
> > coord)
> > =C2=A0}
> > =C2=A0
> > =C2=A0static int vs_cursor_plane_atomic_check(struct drm_plane *plane,
> > -					struct drm_atomic_state
> > *state)
> > +					struct drm_atomic_commit
> > *state)
> > =C2=A0{
> > =C2=A0	struct drm_plane_state *new_plane_state =3D
> > drm_atomic_get_new_plane_state(state,
> > =C2=A0							=09
> > 		 plane);
> > @@ -98,7 +98,7 @@ static void vs_cursor_plane_commit(struct vs_dc
> > *dc, unsigned int output)
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void vs_cursor_plane_atomic_enable(struct drm_plane *plane=
,
> > -					=C2=A0=C2=A0 struct drm_atomic_state
> > *atomic_state)
> > +					=C2=A0=C2=A0 struct
> > drm_atomic_commit *atomic_state)
> > =C2=A0{
> > =C2=A0	struct drm_plane_state *state =3D
> > drm_atomic_get_new_plane_state(atomic_state,
> > =C2=A0								=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > @@ -115,7 +115,7 @@ static void
> > vs_cursor_plane_atomic_enable(struct drm_plane *plane,
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void vs_cursor_plane_atomic_disable(struct drm_plane
> > *plane,
> > -					=C2=A0=C2=A0=C2=A0 struct
> > drm_atomic_state *atomic_state)
> > +					=C2=A0=C2=A0=C2=A0 struct
> > drm_atomic_commit *atomic_state)
> > =C2=A0{
> > =C2=A0	struct drm_plane_state *state =3D
> > drm_atomic_get_old_plane_state(atomic_state,
> > =C2=A0								=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 plane);
> > @@ -132,7 +132,7 @@ static void
> > vs_cursor_plane_atomic_disable(struct drm_plane *plane,
> > =C2=A0}
> > =C2=A0
> > =C2=A0static void vs_cursor_plane_atomic_update(struct drm_plane *plane=
,
> > -					=C2=A0=C2=A0 struct drm_atomic_state
> > *atomic_state)
> > +					=C2=A0=C2=A0 struct
> > drm_atomic_commit *atomic_state)
> > =C2=A0{
> > =C2=A0	struct drm_plane_state *state =3D
> > drm_atomic_get_new_plane_state(atomic_state,
> > =C2=A0								=C2=A0=C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0 plane);
