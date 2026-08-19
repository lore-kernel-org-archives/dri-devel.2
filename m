Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FC8C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38C2710EE3F;
	Wed, 19 Aug 2026 15:54:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="eiu8d7jd";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A9D10EE2E
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787154859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YMx6B6wQ0d9YA2ziv/pklHaoes3pKBFz90L+1nYEWOo=;
 b=eiu8d7jdGV8uzUfQTUd4pXIBc0wcVYKXRK5l9O8avVO2RZLvhLZZqRiDCVl4986vhCL1sW
 PiWd/fdhnGVW5E86MRIrYTgZtkYaRL88kgX9ab2+glQcNmaM39cAp9dQmGKBub0qAT+Qf8
 7VXzqr0MQs5sShBxC0QrlEIqH4VkBIQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-2_h09MP0OX2I7x8MPEwYug-1; Wed, 19 Aug 2026 11:54:17 -0400
X-MC-Unique: 2_h09MP0OX2I7x8MPEwYug-1
X-Mimecast-MFC-AGG-ID: 2_h09MP0OX2I7x8MPEwYug_1787154857
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8fdace20927so8529146d6.2
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154857; x=1787759657;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J+IOUaFC3Xsu+BadyrY5BgXGxb/Top6L0MSw96c1AhE=;
 b=n4pMnm3pOFppMpcbEV+UkXN4eJCii1NgkR0X0X7/miAzg0cAAuVS6dsCFFhwJVqleD
 ZExSV0jQzI2q4Xmx/GYxK0omyBBXGbFIRcaSyNLVxvVchcyGXTBO1gIzJ+e42QrvkSfJ
 EArOV+h47DzO2qzXfdXMPMHMsQ7MsA9zhIbytbHUXP9r8Ru9kwCw7grPxphGb7GtFv9M
 NsaTJ5xicOUFAcNasJYonq39vF9K4FuyJNDDt45D7FNrhn0k9tqb/pEa6BhEt/lkMJ/i
 2ord7WFm1ITY4LJ//RwQmwxLBwMZhbPjqqPmo1ahir1x67Kbg/Svu5SMrg7574QXz/mW
 OubA==
X-Gm-Message-State: AFuF++mHKjDAQmv46Tf2GlYTqGtO1vBWGlUGw0SoHeNSXfYKJPcHLqFx
 v9R/5pTdrdayxzLIkUUvO+fvgic5CE2dBu5/IWfKwKOT6WapSWtYaeMSGXIUBsmkQEhg49vLoG7
 zKSmRFYF3QBs9JENGpCYyUAqWwrpkCPEI5+i/pRCdgGiw861gMQ5EZ97v3TfXHRsKjQlhPg0x4y
 ZDVQ==
X-Gm-Gg: AR+sD13tC/xtMLqZNkh+ylHKawo4ej6jMNPzQYaMXIqEqTrzzOXMThW9VcpC33rEwIX
 qPj7EllCVoLbI2mtVlzdbRE+IDu21c93s3EyYi3JW+9k9dQkNxJDTfCwXPoKIKPu0s9UAQky75h
 CgxRuwKn65oudBWjg+CPwaOM6OPhZ+rLpD/d8L2eJd9t0Xc+S0JoumhLnXmbJTpzJFuFwdNZorr
 5XDtxkedfd9l0C4xXHRHTNEkLjdb1Kj9Y3/oLIRXo63HEkv+CLBg4KQBI2xBbFVrsHoHV/SRgrl
 oZbmHpCQCJK9mZWsghOwZON+JoUjw8yqNhLDzlkHgvfVdUwYAgfzMynPH7SI9KW5BFgy9Y1U
X-Received: by 2002:a05:6214:f6e:b0:907:44ac:7d12 with SMTP id
 6a1803df08f44-90c5e659cd0mr55100316d6.0.1787154856883; 
 Wed, 19 Aug 2026 08:54:16 -0700 (PDT)
X-Received: by 2002:a05:6214:f6e:b0:907:44ac:7d12 with SMTP id
 6a1803df08f44-90c5e659cd0mr55099656d6.0.1787154856327; 
 Wed, 19 Aug 2026 08:54:16 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5eec934bsm17474696d6.15.2026.08.19.08.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:54:15 -0700 (PDT)
Message-ID: <bbda3e7e66afbeba1bf0d4bb1d7104e69a166e1e.camel@redhat.com>
Subject: Re: [PATCH 1/6] drm/nouveau/kms/nv50-: Move DPCD backlight disable
 into its own function
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Date: Wed, 19 Aug 2026 11:54:15 -0400
In-Reply-To: <20260819000720.D19471F000E9@smtp.kernel.org>
References: <20260818235637.1738055-1-lyude@redhat.com>
 <20260818235637.1738055-2-lyude@redhat.com>
 <20260819000720.D19471F000E9@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qHGz8AMlsd_YtrP468xnu_jYTL6BOrejtj5K3jIuo1c_1787154857
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

omg

On Wed, 2026-08-19 at 00:07 +0000, sashiko-bot@kernel.org wrote:
>=20
> > diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> > +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> [ ... ]
> > +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
> > +static inline void
> > +nv50_sor_atomic_disable_backlight(struct nouveau_drm *drm,
> > +=09=09=09=09=C2=A0 struct nouveau_encoder
> > *nv_encoder,
> > +=09=09=09=09=C2=A0 struct drm_atomic_commit *state)
> > +{
> [ ... ]
> > +=09if (!backlight || !backlight->uses_dpcd)
> > +=09=09return;
> > +
> > +=09ret =3D drm_edp_backlight_disable(&nv_connector->aux,
> > &backlight->edp_info);
>=20
> [Severity: High]
> This is a pre-existing issue, but moving the logic into
> nv50_sor_atomic_disable_backlight() preserves a potentially
> problematic
> sleeping call in an atomic context.
>=20
> Is it safe to call drm_edp_backlight_disable() from this path?
>=20
> Because nv50_sor_atomic_disable_backlight() is invoked by the encoder
> atomic
> disable callback nv50_sor_atomic_disable(), it executes in an atomic
> context
> where sleeping is forbidden.
>=20
> The drm_edp_backlight_disable() helper performs DPCD transactions
> over the
> AUX channel. These transactions require taking a hardware mutex and
> can
> sleep or block while waiting for hardware responses.
>=20
> Could this lead to scheduling while atomic kernel warnings or
> potential
> deadlocks during display disables or modesets?

This one gave me a good chuckle. This is a definite hallucination, it
is getting confused by the fact that nv50_sor_atomic_disable() has the
word atomic in it.

>=20
> > +=09if (ret < 0)
> > +=09=09NV_ERROR(drm, "Failed to disable backlight on
> > [CONNECTOR:%d:%s]: %d\n",
> > +=09=09=09 nv_connector->base.base.id, nv_connector-
> > >base.name, ret);
> > +}
> > +#endif

