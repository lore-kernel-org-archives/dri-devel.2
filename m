Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF3606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BwOH9CZW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D6610E81A;
	Thu, 19 Nov 2026 09:33:25 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F58E10E81A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795080795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3iNwzOS37/jrc7WtY7Br5byxUiklpla3M+UNj4OGHc=;
 b=BwOH9CZW4QD2xT5H0rbZyR0QEhIPidmCwnqOSCvxfiPpGfDRA55qoE1aHGhTizZsTGirTz
 m94mNYV9bRWE4e5Gw8fkZ4ynHz2QOdarzWp2g0Qg+Rbz4NKcw8SxG/z5EESaFczsx7VdUY
 Yz5L2dj15+EI9WiyZpDLpOmhHiWDV74=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-7_5sKw6JOGeBaneLRPeWWw-1; Thu, 19 Nov 2026 04:33:12 -0500
X-MC-Unique: 7_5sKw6JOGeBaneLRPeWWw-1
X-Mimecast-MFC-AGG-ID: 7_5sKw6JOGeBaneLRPeWWw_1795080791
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-869553205a7so29799727b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 01:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795080791; x=1795685591;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q3iNwzOS37/jrc7WtY7Br5byxUiklpla3M+UNj4OGHc=;
 b=lzhN3oV4qMVOrYt/MtT1J1j8Gwsm8gaUUbRT15TwYydRseZtouihWtOpvGRQGvqOk8
 TM4tToMSdMA/gRg4v2eWs5mtwHTejGcx6Rd7F2xB9r5cou+xAe233+Q6jxT8QcP1WtSv
 tXZLgfeOhejD5w/X/X6zBaZd/i3X5WIaFIX1lxUSKROLsaCj4vpQ4h646R9UdQbpGs/e
 vQt7K1yxFFKYyfG1mMkQ7i1kYwDmFZ+8VtimlPK1pkUm1RMy1Gpq7yoc079+ghRUEZue
 R/mJ/2q/jrKeOzl7mSlYrbC5cp4roVPEo6FlsRbhTE4n8OGXW1mSkKg6kcN9FYXCFAF5
 fPkQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEd+GtT5f1WTs60Jp7Hd9PYB7xyLebKDvO4GYaNLbkKJWGbwqONmRTz4KeL5w2RY6rEcUcImDTgL4Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/TSC88aKwyC0QkgJHhFKm6IU8yF8HoI5Ljx2Al3OayNsDWNKAf
 GUQPVd6bnRlDW2WWrs47FX9MELznEFbC8aeLJNBZcXhAnxCsyjG/tlmax+5MtGCJPZQ+kBTYtgN
 NOc4uV0VqLM0cIfLQ5aF0RSdZa2PGrS4S2oqJGO5Jge/EXn7VuqSUH8i+0EpAYpXWXBVc9Vk8Xo
 qTjUIyQoVHK1sjbxLhpj8/m+jF7fud8pBsoJHcqtkobb0m
X-Gm-Gg: AZFdTZe2EXiLnntQLDNJ9AVxBrATOqUN53sZX9NXQJdnt3Q91oywbOsHB+aq+BiKRid
 /xbBiXdImi4c194Ob06eFtXOJEIzXgM0bqxINU+NdvT0/Gln7RWvkQBeknYrMqCQBfnL5/uszj0
 4ayIWHynHU3tj47VHigYasHNTMPa/ogEi5q/xe9SvoAWaEk+Q6b74uGUaK
X-Received: by 2002:a05:690c:3682:b0:8b3:5a91:61e8 with SMTP id
 00721157ae682-8b4fedf227amr22008977b3.69.1795080791325; 
 Thu, 19 Nov 2026 01:33:11 -0800 (PST)
X-Received: by 2002:a05:690c:3682:b0:8b3:5a91:61e8 with SMTP id
 00721157ae682-8b4fedf227amr22008857b3.69.1795080790664; Thu, 19 Nov 2026
 01:33:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117184019.430513-1-andreas@kemnade.info>
 <CADSE00+-9Br_eVWRc=+i+OnthqZYfaMZ57Gxp5fXmqFXrMqf3A@mail.gmail.com>
 <20261119101734.2bb8bae9@kemnade.info>
In-Reply-To: <20261119101734.2bb8bae9@kemnade.info>
From: Albert Esteve <aesteve@redhat.com>
Date: Thu, 19 Nov 2026 10:32:59 +0100
X-Gm-Features: Aa3M54pDLkMvy9x4DRuXey_uiaCFyWTCdPTvY_vPUgwdK_XS83M8GupYchvlxWQ
Message-ID: <CADSE00LzPSHX5DhB6-DNwmfd6=rQc86fBa9MmcW-NhApjDH6iQ@mail.gmail.com>
Subject: Re: [PATCH] drm/omap: dss: simplify omapdss_device_init_output
To: Andreas Kemnade <andreas@kemnade.info>
Cc: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 luca.ceresoli@bootlin.com, louis.chauvet@bootlin.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k-p8FSHfdk23-s2-q-8E3jd2tO97_1AquQ6g-1jPlko_1795080791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 10:18=E2=80=AFAM Andreas Kemnade <andreas@kemnade.i=
nfo> wrote:
>
> On Thu, 19 Nov 2026 09:32:11 +0100
> Albert Esteve <aesteve@redhat.com> wrote:
>
> > On Tue, Nov 17, 2026 at 7:40=E2=80=AFPM Andreas Kemnade <andreas@kemnad=
e.info> wrote:
> > >
> > > During reviewing of a regression fix is that function, questionable
> > > possibly unbalanced drm_bridge_put/get came to light. Sashiko
> > > review pointed out that of_drm_get_bridge_by_endpoint() does not retu=
rn
> > > NULL, so the questionable code is simply unreachable and therefore do=
es
> > > at least not harm. Remove the dead code.
> > >
> > > Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  drivers/gpu/drm/omapdrm/dss/output.c | 10 ----------
> > >  1 file changed, 10 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/o=
mapdrm/dss/output.c
> > > index b5cef5093a883..cbb9b2f1a2133 100644
> > > --- a/drivers/gpu/drm/omapdrm/dss/output.c
> > > +++ b/drivers/gpu/drm/omapdrm/dss/output.c
> > > @@ -20,7 +20,6 @@ int omapdss_device_init_output(struct omap_dss_devi=
ce *out,
> > >                                struct drm_bridge *local_bridge)
> > >  {
> > >         struct drm_bridge *bridge;
> > > -       int ret;
> > >
> > >         bridge =3D of_drm_get_bridge_by_endpoint(out->dev->of_node, o=
ut->of_port, 0);
> > >         if (IS_ERR(bridge)) {
> > > @@ -34,20 +33,11 @@ int omapdss_device_init_output(struct omap_dss_de=
vice *out,
> > >         out->bridge =3D bridge;
> > >
> > >         if (local_bridge) {
> > > -               if (!out->bridge) {
> > > -                       ret =3D -EPROBE_DEFER;
> > > -                       goto error;
> > > -               }
> > > -
> > >                 out->next_bridge =3D out->bridge;
> > >                 out->bridge =3D drm_bridge_get(local_bridge);
> > >         }
> > >
> > >         return 0;
> > > -
> > > -error:
> > > -       omapdss_device_cleanup_output(out);
> > > -       return ret;
> > >  }
> >
> > This looks correct, it is dead code. But removing it makes the return
> > value meaningless (every path returns 0), so it may make sense to make
> > omapdss_device_init_output() void?
> >
> No, not every patch returns 0.

Ah, I was looking at my local tree and I had missed your base differs
in the IS_ERR branch (which the patch context doesn't show). Scratch
the suggestion then.

Reviewed-by: Albert Esteve <aesteve@redhat.com>

Thanks,
Albert.

>
> Regards,
> Andreas
>

