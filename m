Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEFACD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 05:44:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F095C10E0DF;
	Wed, 13 May 2026 05:44:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="Xq6EiZel";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 699C510E0DF
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 05:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=x2lKY4wJSpV+yjTVpftwnbYTUZiIdkRcxob60Au7oEk=; b=Xq6EiZel8nbeFoef1OgrBkSShK
 smpYpPdjR0GICkYTt7ejafjX2vURrIJzwpTJ8WU2HhUuW29NDCZzRyul3RpQiEKLzYm8UVtiaReV+
 CKAWWPggmoxmAKxmk677umKw42dwiMwY0BIoyurFjubJwge99iMCm4y2GMmErKFJlAFPMzeEQ7sX7
 lKK1mTYTIrtTdNl2sVX/shrLWN7pHz37w8JOtbkQ1Dpp49Yw3Gq863tX8J2jTlddCV738q9d1C7g3
 XYu3s3HtroMJctVY65bRn0WvPnc67BbXr0xYcNEBkQMw3scX/6ojRXneCaXhhOV4TIKyF4NmUw2Pz
 rAXoQagg==;
Received: from static-197-2-86-188.ipcom.comunitel.net ([188.86.2.197]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wN2O6-009oLs-8s; Wed, 13 May 2026 07:44:06 +0200
Message-ID: <f485f5b5fb06053fd383fd31b99f95d2e6fe25c5.camel@igalia.com>
Subject: Re: [PATCH 1/2] drm/v3d: Refactor perfmon locking
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Wed, 13 May 2026 07:43:55 +0200
In-Reply-To: <93a2cb1e-3907-4aae-833e-15d0cbbbf255@igalia.com>
References: <20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com>
 <20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com>
 <7afa2b5b743d76f6f9ddf4bf58997e2ac178a0ba.camel@igalia.com>
 <93a2cb1e-3907-4aae-833e-15d0cbbbf255@igalia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
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

El mar, 12-05-2026 a las 07:55 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> Hi Iago,
>=20
> On 12/05/26 05:20, Iago Toral wrote:
> > El vie, 08-05-2026 a las 10:41 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> > >=20
> > (...)
> > > +void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon
> > > *perfmon)
> > > +{
> > > +	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
> > > +
> > > +	perfmon =3D v3d->global_perfmon ?: perfmon;
> > > +
> >=20
> >=20
> > What's the rationale for having this function do this? The caller
> > explicitly passes a perfmon to be started, but this here can ignore
> > that and instead act on the global perform under the hood.
>=20
> v3d_perfmon_start() is called in 3 different places: the run_job()
> callback for BIN, RENDER, and CSD jobs. If the global perfmon is
> enabled
> at submission time, we can assure that the job perfmon is NULL.
> However,
> if a global perfmon is set in between the submit ioctl and the job
> actual execution, we give preference to the global perfmon and new
> submissions will be rejected with per-job perfmons while the global
> perfmon is set.

So if we choose the global perfmon here, does that mean the current job
will fail early and won't be submitted?

Also, what would happen if we choose the job's perfmon over the global
perfmon instead? I understand the implication would be that the global
perfmon would have to wait for the next job without a perfmon to be
started but things would otherwise work correctly?

> >=20
> > I think it would be better if this decision is made expicitly
> > before
> > calling the function and have the function always act on the
> > perfmon
> > requested instead.
> >=20
>=20
> I believe this would lead to code duplication as this function is
> called
> in multiple places. Also, this would mean that we would need to
> transfer
> the global perfmon logic to all run_job() callbacks. Also note that
> we
> can only access the v3d->global_perfmon with the spinlock locked, so
> we
> would need to open-code the locking in all run_job() callbacks.
>=20

Right, we definitely want to avoid that.

Iago

> >=20
> > > +	if (!perfmon)
> > > +		return;
> > > +
> > > +	if (perfmon =3D=3D v3d->perfmon_state.active)
> > > +		return;
> > > +
> > > +	if (!pm_runtime_get_if_active(v3d->drm.dev))
> > > +		return;
> > > +
> > > +	v3d_perfmon_hw_start(v3d, perfmon);
> > > +	v3d->perfmon_state.active =3D perfmon;
> > > +
> > > +	v3d_pm_runtime_put(v3d);
> > > +}
> > > +
> > >=20
> > (...)
> > > =C2=A0=20
> > > =C2=A0=C2=A0struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv
> > > *v3d_priv,
> > > int id)
> > > @@ -316,11 +354,15 @@ static void v3d_perfmon_delete(struct
> > > v3d_file_priv *v3d_priv,
> > > =C2=A0=C2=A0	struct v3d_dev *v3d =3D v3d_priv->v3d;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	/* If the active perfmon is being destroyed, stop it
> > > first
> > > */
> > > -	if (perfmon =3D=3D v3d->active_perfmon)
> > > -		v3d_perfmon_stop(v3d, perfmon, false);
> > > +	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock)
> > > {
> > > +		/* If the global perfmon is being destroyed, set
> > > it
> > > to NULL */
> > > +		if (v3d->global_perfmon =3D=3D perfmon) {
> > > +			v3d->global_perfmon =3D NULL;
> > > +			v3d_perfmon_put(perfmon);
> > > +		}
> > > =C2=A0=20
> > > -	/* If the global perfmon is being destroyed, set it to
> > > NULL
> > > */
> > > -	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
> > > +		v3d_perfmon_stop_locked(v3d, perfmon, false);
> >=20
> > I think it would be better to stop the perfmon first and check if
> > it is
> > global second, even if we are certain the put above is never going
> > to
> > delete the last reference in that scenario.
> >=20
> > Also, maybe we would want to document here with a comment that we
> > increase the refcnt when we set a global perfmon, which is why in
> > that
> > case we put it twice when it is destroyed.
>=20
> Ack. I'll address it in v2. Thanks for your review!
>=20
> Best regards,
> - Ma=C3=ADra
>=20
> >=20
> > Iago
> >=20
>=20
>=20

