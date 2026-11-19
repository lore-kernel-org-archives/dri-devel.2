Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B464606A337
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=ZK6Wflyx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E57DB10E216;
	Thu, 19 Nov 2026 09:18:58 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5426510E216
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
 Reply-To:Content-ID:Content-Description;
 bh=9vXtiwxZ9b/ia2h9vVrH0bvt+6pBsP1BUbpXNBoP+Xw=; t=1795079932; x=1796289532; 
 b=ZK6WflyxI1fFmGtO6XflEetTrLw/Qoj0Fb97WrerhEZh/eZLmc9rBSqQXAW3267i4+qwo2GzAmG
 wY9EeQX1Hv4VSQooPuv1H/xZXi5n+gcnpM3YLRd4LXjqURYgEAEpVxL5M9Ojxm0YRgxc+r42M5mFx
 fWy6VXa7OvEMJsajo39vyjvdrS1WBcPneSzB5YgOVTXArzlnDoIV77v8MHBWeAekJKVVtQcyKUzHe
 zU5cY/r3EEKPB9Z0dCqnZvBa/7bsEWZWw/W0e36JPrcD5bUGrThzLUtfaAKGZ6wJ34FCi+c+7R3Nk
 rsLyUzG++uOmeon1kUrq8o5m7cb1W2w5Wf8Q==;
Date: Thu, 19 Nov 2026 10:17:34 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Albert Esteve <aesteve@redhat.com>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, luca.ceresoli@bootlin.com, louis.chauvet@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/omap: dss: simplify omapdss_device_init_output
Message-ID: <20261119101734.2bb8bae9@kemnade.info>
In-Reply-To: <CADSE00+-9Br_eVWRc=+i+OnthqZYfaMZ57Gxp5fXmqFXrMqf3A@mail.gmail.com>
References: <20261117184019.430513-1-andreas@kemnade.info>
 <CADSE00+-9Br_eVWRc=+i+OnthqZYfaMZ57Gxp5fXmqFXrMqf3A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 19 Nov 2026 09:32:11 +0100
Albert Esteve <aesteve@redhat.com> wrote:

> On Tue, Nov 17, 2026 at 7:40=E2=80=AFPM Andreas Kemnade <andreas@kemnade.=
info> wrote:
> >
> > During reviewing of a regression fix is that function, questionable
> > possibly unbalanced drm_bridge_put/get came to light. Sashiko
> > review pointed out that of_drm_get_bridge_by_endpoint() does not return
> > NULL, so the questionable code is simply unreachable and therefore does
> > at least not harm. Remove the dead code.
> >
> > Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/gpu/drm/omapdrm/dss/output.c | 10 ----------
> >  1 file changed, 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/oma=
pdrm/dss/output.c
> > index b5cef5093a883..cbb9b2f1a2133 100644
> > --- a/drivers/gpu/drm/omapdrm/dss/output.c
> > +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> > @@ -20,7 +20,6 @@ int omapdss_device_init_output(struct omap_dss_device=
 *out,
> >                                struct drm_bridge *local_bridge)
> >  {
> >         struct drm_bridge *bridge;
> > -       int ret;
> >
> >         bridge =3D of_drm_get_bridge_by_endpoint(out->dev->of_node, out=
->of_port, 0);
> >         if (IS_ERR(bridge)) {
> > @@ -34,20 +33,11 @@ int omapdss_device_init_output(struct omap_dss_devi=
ce *out,
> >         out->bridge =3D bridge;
> >
> >         if (local_bridge) {
> > -               if (!out->bridge) {
> > -                       ret =3D -EPROBE_DEFER;
> > -                       goto error;
> > -               }
> > -
> >                 out->next_bridge =3D out->bridge;
> >                 out->bridge =3D drm_bridge_get(local_bridge);
> >         }
> >
> >         return 0;
> > -
> > -error:
> > -       omapdss_device_cleanup_output(out);
> > -       return ret;
> >  } =20
>=20
> This looks correct, it is dead code. But removing it makes the return
> value meaningless (every path returns 0), so it may make sense to make
> omapdss_device_init_output() void?
>=20
No, not every patch returns 0.

Regards,
Andreas
