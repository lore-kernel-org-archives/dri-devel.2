Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D6DFCD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:20:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7FD110E9B2;
	Tue, 12 May 2026 08:20:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DDiwNGwe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943AA10E9A8
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+0PEtEuzG6oV5e85QFWV72fcI9rgE3EI/752M9oIxUA=; b=DDiwNGwe9QWg4sWXNr6yFA5jZg
 iaiKuHDPcuvMlJpxogezIEqXMcMAg7leCYFGcLPlvaZjYtPsfGHHwlTX8HwZSKkpCP9RRr3r9Vdzp
 bRuE3HRhPmWoJm0bDD/4W32bNL9TVea+wDZU6R2MKnXhib4Jp20rICSCFS80f7coDh0DyUJUBVQbS
 NBa6AB3Zjf3DRFu0w/atNWiF+bCTRe5RZSkNFZUybVdWbT8s1ThCC7r+IfS4R83EhgvcEqcru6UUM
 kh8neZ4Hov0rgFCU0zLYfajrURCsTUZSkD18LODFqWxcZNmdNsrewayFOj8Ma8ofH17NF7xWO9Nwr
 shvQSvng==;
Received: from static-197-2-86-188.ipcom.comunitel.net ([188.86.2.197]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMiM7-009MuM-1N; Tue, 12 May 2026 10:20:42 +0200
Message-ID: <7afa2b5b743d76f6f9ddf4bf58997e2ac178a0ba.camel@igalia.com>
Subject: Re: [PATCH 1/2] drm/v3d: Refactor perfmon locking
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org
Date: Tue, 12 May 2026 10:20:31 +0200
In-Reply-To: <20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com>
References: <20260508-v3d-perfmon-lifetime-v1-0-f5b5642c085f@igalia.com>
 <20260508-v3d-perfmon-lifetime-v1-1-f5b5642c085f@igalia.com>
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

El vie, 08-05-2026 a las 10:41 -0300, Ma=C3=ADra Canal escribi=C3=B3:
>=20
(...)
> +void v3d_perfmon_start(struct v3d_dev *v3d, struct v3d_perfmon
> *perfmon)
> +{
> +	guard(spinlock_irqsave)(&v3d->perfmon_state.lock);
> +
> +	perfmon =3D v3d->global_perfmon ?: perfmon;
> +


What's the rationale for having this function do this? The caller
explicitly passes a perfmon to be started, but this here can ignore
that and instead act on the global perform under the hood.

I think it would be better if this decision is made expicitly before
calling the function and have the function always act on the perfmon
requested instead.


> +	if (!perfmon)
> +		return;
> +
> +	if (perfmon =3D=3D v3d->perfmon_state.active)
> +		return;
> +
> +	if (!pm_runtime_get_if_active(v3d->drm.dev))
> +		return;
> +
> +	v3d_perfmon_hw_start(v3d, perfmon);
> +	v3d->perfmon_state.active =3D perfmon;
> +
> +	v3d_pm_runtime_put(v3d);
> +}
> +
>=20
(...)
> =C2=A0
> =C2=A0struct v3d_perfmon *v3d_perfmon_find(struct v3d_file_priv *v3d_priv=
,
> int id)
> @@ -316,11 +354,15 @@ static void v3d_perfmon_delete(struct
> v3d_file_priv *v3d_priv,
> =C2=A0	struct v3d_dev *v3d =3D v3d_priv->v3d;
> =C2=A0
> =C2=A0	/* If the active perfmon is being destroyed, stop it first
> */
> -	if (perfmon =3D=3D v3d->active_perfmon)
> -		v3d_perfmon_stop(v3d, perfmon, false);
> +	scoped_guard(spinlock_irqsave, &v3d->perfmon_state.lock) {
> +		/* If the global perfmon is being destroyed, set it
> to NULL */
> +		if (v3d->global_perfmon =3D=3D perfmon) {
> +			v3d->global_perfmon =3D NULL;
> +			v3d_perfmon_put(perfmon);
> +		}
> =C2=A0
> -	/* If the global perfmon is being destroyed, set it to NULL
> */
> -	cmpxchg(&v3d->global_perfmon, perfmon, NULL);
> +		v3d_perfmon_stop_locked(v3d, perfmon, false);

I think it would be better to stop the perfmon first and check if it is
global second, even if we are certain the put above is never going to
delete the last reference in that scenario.

Also, maybe we would want to document here with a comment that we
increase the refcnt when we set a global perfmon, which is why in that
case we put it twice when it is destroyed.

Iago

