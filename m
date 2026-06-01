Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E835ACD6E56
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E40511313C;
	Mon,  1 Jun 2026 10:11:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="qLkav5iT";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9310C11313C
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3NNJq5se+S0sYBMco9FFh7hZ/lpbqS+JiOZ8c2N40CU=; b=qLkav5iT4am9euQJ5OrRYPF10E
 p83ZqwMTBuLuWj8OfKw+Ia8fjGNVBbsXBsbYXwbeKURMp9mW44e0zM1Ri7tTMK9VWqoXPBdg0vNdJ
 eknjvKlOBp4v5r3oC+DB8ejeXaMctfHudR59YjzQpV6Z9H3w4/4LpvbL/suMsbNt64+xMVNVcpavM
 MhArAswBqkxTg6/P6OrasuwjrKVJ8J6eT29smlGmAuD+0RGtIty93D8EZeuKPYWtbi6SreuPmtuLm
 bs2Xp48TubwePRXjHwYR7jAJSNJrLCJB6oqApTDCzpStfC8ggGD9WhxPvMdXQhAH3oFffqhYXWyME
 CIXZcjJA==;
Received: from static-234-112-85-188.ipcom.comunitel.net ([188.85.112.234]
 helo=[192.168.0.17]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wTzcJ-00AxPj-Qi; Mon, 01 Jun 2026 12:11:31 +0200
Message-ID: <47df01b2fab27fc3df9074d18d417f5a7d1b4db1.camel@igalia.com>
Subject: Re: [PATCH 2/2] drm/v3d: Skip CSD when it has zeroed workgroups
From: Iago Toral <itoral@igalia.com>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>, Melissa Wen
 <mwen@igalia.com>, Jose Maria Casanova Crespo <jmcasanova@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 stable@vger.kernel.org
Date: Mon, 01 Jun 2026 12:11:21 +0200
In-Reply-To: <20260530-v3d-fix-indirect-csd-v1-2-15533948663f@igalia.com>
References: <20260530-v3d-fix-indirect-csd-v1-0-15533948663f@igalia.com>
 <20260530-v3d-fix-indirect-csd-v1-2-15533948663f@igalia.com>
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

El s=C3=A1b, 30-05-2026 a las 16:51 -0300, Ma=C3=ADra Canal escribi=C3=B3:
> A compute shader dispatch encodes its workgroup counts in the
> CFG0..CFG2
> registers. Kicking off a dispatch with a zero count in any of the
> three
> dimensions is invalid. First, the hardware will process 0 as 65536,
> causing an illegitimate submission. But over that, a submission with
> a
> zeroed workgroup dimension should be a no-op.
>=20
> These zeroed counts can reach the dispatch path through an indirect
> CSD
> job, whose workgroup counts are only known once the indirect buffer
> is
> read and may legitimately be zero, but such scenario should only
> result in
> a no-op.
>=20
> Don't submit the job to the hardware when any of the workgroup counts
> is
> zero, so the job completes immediately instead of running the shader.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader
> dispatch.")
> Suggested-by: Jose Maria Casanova Crespo <jmcasanova@igalia.com>
> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> ---
> =C2=A0drivers/gpu/drm/v3d/v3d_sched.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/v3d/v3d_sched.c
> b/drivers/gpu/drm/v3d/v3d_sched.c
> index 47f83936cd73..5476fcf43793 100644
> --- a/drivers/gpu/drm/v3d/v3d_sched.c
> +++ b/drivers/gpu/drm/v3d/v3d_sched.c
> @@ -352,6 +352,9 @@ v3d_csd_job_run(struct drm_sched_job *sched_job)
> =C2=A0		return NULL;
> =C2=A0	}
> =C2=A0
> +	if (!job->args.cfg[0] || !job->args.cfg[1] || !job-
> >args.cfg[2])
> +		return NULL;

I think this is not correct: cfg[0-2] have the actual dispatch sizes
encoded in the 16 MSB bits of these registers, allowing the lower 16-
bit to specify a base offset for the generated workgroup ids that may
not be zero. Therefore, I think we would want to rewrite this check as:

if ((job->args.cfg[0] & 0xffff0000u) =3D=3D 0 ||
    (job->args.cfg[1] & 0xffff0000u) =3D=3D 0 ||
    (job->args.cfg[2] & 0xffff0000u) =3D=3D 0) {
        return NULL;
}

Also, we probably want to add a comment here explaining that at the hw
level, 0 is interpreted as 65536 but the user-space driver only exposes
65535 as the maximum workgroup size allowed.

Iago

> +
> =C2=A0	v3d->queue[V3D_CSD].active_job =3D &job->base;
> =C2=A0
> =C2=A0	v3d_invalidate_caches(v3d);
>=20

