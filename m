Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33611CD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89A6910E523;
	Tue, 26 May 2026 07:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=icenowy.me header.i=uwu@icenowy.me header.b="QKKcw7DB";
	dkim-atps=neutral
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C716410E523
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1779781523; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PZJ6hNbU1mprl9zC0T/4iXywSR3KX1yUOysd9kOkFts6y4JQIZzo5IXGOQDJxphgitFaumc5fDlYWSe1+jXe/vqL5CNHPSkpIZucl3u+mkC4zjCQBiiEMG5Vd2jc+Q48xGq1fUvUJZfTNiK8m/+H6IjGFv7Kgs0B0XZOVjluRUE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1779781523;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B+tMWFJC0xOgHTTocoXmqk9KvsOwwhBZRrZu09cDr90=; 
 b=SkWncssxAv2m/qX2BfBlJzQHQxmJJSzpdVMqpLoS1rM9DYr5Eci/fnhIFw7P5SoyQbLTl8lEt2t/CD2sxlO0866IUC5b7J8aHKo0IXB4dlZlncPtaoQ2VfaGpnHPhTqHEia+Amm4X2l7//QkDqa9/NmU4i94UmVrScIjArizuhs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779781523; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=B+tMWFJC0xOgHTTocoXmqk9KvsOwwhBZRrZu09cDr90=;
 b=QKKcw7DBHlBi3zfoY+ckyBBcQdFuDs6u2YC5g6xzumyh3FOeu1YsEx9DknynKsLO
 Jt01TPZcXPhoKW/b/qBnUPP7BVi0GCGHTu8cMxNG0fHUaAoSLC48Q5SKtJ3jsIj9Huk
 XCKJvJvPldBwfgYdoghfats9UkfjKdDLBYrTKFM0PmvJfF1Ys7kArULxxJZrRVHVUmV
 MRhWw+ufQLM0QGX1pRfmrFLdSfOD9wwiqfvecXbZQyaXwO0rBvuxsBR1muZLjxp2RfN
 5zxNZP12KMyivEdij2m02QjHtHXAxubAhIYW9NvsekeJOZAF2LatS8CUqiYUQRWEwJd
 5VihMIOuQQ==
Received: by mx.zohomail.com with SMTPS id 1779781521925989.2256404870978;
 Tue, 26 May 2026 00:45:21 -0700 (PDT)
Message-ID: <560db2df89ce7a3431b4234634cdb40c6ee017f5.camel@icenowy.me>
Subject: Re: [PATCH drm-misc-next] drm: verisilicon: fix build failure of
 cursor plane code
From: Icenowy Zheng <uwu@icenowy.me>
To: Jani Nikula <jani.nikula@linux.intel.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>, Mark Brown <broonie@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date: Tue, 26 May 2026 15:45:15 +0800
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

Oops, I thought I built the changes before sending the patch, so I
didn't do a build before pushing.

Sorry for this.

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
